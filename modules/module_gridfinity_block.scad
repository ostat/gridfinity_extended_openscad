include <module_gridfinity.scad>
include <module_lip.scad>
include <module_magnet.scad>

show_gridfinity_demo = false;
if(show_gridfinity_demo){
  
  grid_block($fn=64);
 
  translate([50,0,0])
  union(){
    frame_cavity($fn=64);

    translate([0,50*3,0])
    frame_cavity(remove_bottom_taper=true,$fn=64);
    
    translate([0,50*4,0])
    frame_cavity(reducedWallHeight=1,$fn=64);
  }
  
  translate([150,0,0])
  union(){
    pad_oversize($fn=64);
    
    translate([0,50,0])
    pad_oversize(extend_down=5,$fn=64);
    
    translate([0,50*2,0])
    pad_oversize(margins=1,$fn=64);
    
    translate([0,50*3,0])
    pad_oversize(remove_bottom_taper=true,$fn=64);
    
    translate([0,50*4,0])
    pad_oversize(render_top=false,$fn=64);
    
    translate([0,50*5,0])
    pad_oversize(render_bottom=false,$fn=64);
  }  
}

// basic block with cutout in top to be stackable, optional holes in bottom
// start with this and begin 'carving'
//grid_block();
module grid_block(
  num_x=1, 
  num_y=2, 
  num_z=2, 
  position = "zero",
  filledin = "disabled", //[disabled, enabled, enabledfilllip]
  wall_thickness = 1.2,
  cupBase_settings = CupBaseSettings(),
  lip_settings = LipSettings(),
  help)
{
  lipHeight = 3.75;

  assert_openscad_version();
  cupBase_settings = ValidateCupBaseSettings(cupBase_settings);

  //Legacy variables.
  magnet_size=cupBase_settings[iCupBase_MagnetSize];
  screw_size=cupBase_settings[iCupBase_ScrewSize];
  hole_overhang_remedy=cupBase_settings[iCupBase_HoleOverhangRemedy];
  box_corner_attachments_only = cupBase_settings[iCupBase_CornerAttachmentsOnly];
  half_pitch=cupBase_settings[iCupBase_HalfPitch];
  flat_base=cupBase_settings[iCupBase_FlatBase];
  center_magnet_size = cupBase_settings[iCupBase_CenterMagnetSize];
  magnet_easy_release = cupBase_settings[iCupBase_MagnetEasyRelease];
  
  outer_size = [env_pitch().x - env_clearance().x, env_pitch().y - env_clearance().y];  // typically 41.5
  block_corner_position = [outer_size.x/2 - env_corner_radius(), outer_size.y/2 - env_corner_radius()];  // need not match center of pad corners

  magnet_position = calculateAttachmentPositions(magnet_size[iCylinderDimension_Diameter], screw_size[iCylinderDimension_Diameter]);
   
  overhang_fix = hole_overhang_remedy > 0 && magnet_size[iCylinderDimension_Diameter] > 0 && screw_size[iCylinderDimension_Diameter] > 0 ? hole_overhang_remedy : 0;
  overhang_fix_depth = 0.3;  // assume this is enough
  
  tz(env_pitch().z*num_z-fudgeFactor*2)
  if(filledin == "enabledfilllip"){
    color(env_colour(color_topcavity))
      tz(-fudgeFactor)
      hull() 
      cornercopy(block_corner_position, num_x, num_y) 
      cylinder(r=env_corner_radius(), h=lipHeight);
  } else {
    
    cupLip(
      num_x = num_x, 
      num_y = num_y, 
      lipStyle = lip_settings[iLipStyle],
      wall_thickness = wall_thickness,
      lip_notches = lip_settings[iLipNotch],
      lip_top_relief_height = lip_settings[iLipTopReliefHeight],
      lip_top_relief_width = lip_settings[iLipTopReliefWidth],
      lip_clip_position = lip_settings[iLipClipPosition],
      lip_non_blocking = lip_settings[iLipNonBlocking],
      align_grid = cupBase_settings[iCupBase_AlignGrid]);
  }
  
  translate(gridfinityRenderPosition(position,num_x,num_y))
  difference() {
    baseHeight = 5;
    intersection() {
      //Main cup outer shape
      color(env_colour(color_cup))
        tz(-fudgeFactor)
        hull() 
        cornercopy(block_corner_position, num_x, num_y) 
        cylinder(r=env_corner_radius(), h=env_pitch().z*num_z);

      union(){
        if(flat_base == FlatBase_rounded){
          basebottomRadius = let(fbr = cupBase_settings[iCupBase_FlatBaseRoundedRadius])
            fbr == -1 ? env_corner_radius()/2 : fbr;

          color(env_colour(color_cup))
          translate([env_clearance().x/2,env_clearance().y/2,0])
          roundedCube(
            x = num_x*env_pitch().x-env_clearance().x,
            y = num_y*env_pitch().y-env_clearance().y,
            z = env_pitch().z,
            size=[],
            topRadius = 0,
            bottomRadius = basebottomRadius,
            sideRadius = env_corner_radius(),
            centerxy = false,
            supportReduction_z = [cupBase_settings[iCupBase_FlatBaseRoundedEasyPrint],0]
            );
        } else {
          // logic for constructing odd-size grids of possibly half-pitch pads
          color(env_colour(color_base))
            pad_grid(
              num_x = num_x, 
              num_y = num_y, 
              half_pitch = half_pitch, 
              flat_base = flat_base, 
              cupBase_settings[iCupBase_MinimumPrintablePadSize],
              pitch=env_pitch(), 
              positionGridx = cupBase_settings[iCupBase_AlignGrid].x,
              positionGridy = cupBase_settings[iCupBase_AlignGrid].y);
        }

        color(env_colour(color_cup))
        tz(baseHeight) 
          cube([env_pitch().x*num_x, env_pitch().y*num_y, env_pitch().z*num_z]);
      }
    }
    
    color(env_colour(color_cup))
    bin_overhang_chamfer(
      num_x = num_x,
      num_y = num_y,
      baseHeight = baseHeight,
      wall_thickness = wall_thickness,
      corner_radius = env_corner_radius(),
      block_corner_position=block_corner_position,
      cupBase_settings = cupBase_settings);
   
    if(center_magnet_size[iCylinderDimension_Diameter]){
      //Center Magnet
      for(x =[0:1:num_x-1])
      {
        for(y =[0:1:num_y-1])
        {
          color(env_colour(color_basehole))
            translate([
               x * env_pitch().x + env_pitch().x / 2, // Add half pitch in X
               y * env_pitch().y + env_pitch().y / 2, // Add half pitch in Y
               -fudgeFactor
            ])
            cylinder(h=center_magnet_size[iCylinderDimension_Height]-fudgeFactor, d=center_magnet_size[iCylinderDimension_Diameter]);
        }
      }
    }
    
    color(env_colour(color_basehole))
    tz(-fudgeFactor)
    gridcopycorners(num_x, num_y, magnet_position, box_corner_attachments_only){
        rdeg =
          $gcci[2] == [ 1, 1] ? 90 :
          $gcci[2] == [-1, 1] ? 180 :
          $gcci[2] == [-1,-1] ? -90 :
          $gcci[2] == [ 1,-1] ? 0 : 0;
        rotate([0,0,rdeg-45+(magnet_easy_release==MagnetEasyRelease_outer ? 0 : 180)])
        MagnetAndScrewRecess(
          magnetDiameter = magnet_size[iCylinderDimension_Diameter],
          magnetThickness = magnet_size[iCylinderDimension_Height]+0.1,
          screwDiameter = screw_size[iCylinderDimension_Diameter],
          screwDepth = screw_size[iCylinderDimension_Height],
          overhangFixLayers = overhang_fix,
          overhangFixDepth = overhang_fix_depth,
          easyMagnetRelease = magnet_easy_release != MagnetEasyRelease_off,
          magnetCaptiveHeight = cupBase_settings[iCupBase_MagnetCaptiveHeight]);
    }
  }
 
  HelpTxt("grid_block",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"magnet_size",magnet_size
    ,"screw_size",screw_size
    ,"position",position
    ,"hole_overhang_remedy",hole_overhang_remedy
    ,"half_pitch",half_pitch
    ,"box_corner_attachments_only",box_corner_attachments_only
    ,"flat_base",flat_base
    ,"lipSettings",lip_settings
    ,"filledin",filledin]
    ,help);
}

//TODO: be better if we could round the corners of the chamfer around the bin.
module bin_overhang_chamfer(
  num_x,
  num_y,
  baseHeight,
  wall_thickness,
  corner_radius,
  block_corner_position,
  cupBase_settings = []){
  fudgeFactor = 0.01;

  alignGrid = cupBase_settings[iCupBase_AlignGrid];
  cavityFloorRadius = cupBase_settings[iCupBase_CavityFloorRadius];
  efficientFloor = cupBase_settings[iCupBase_EfficientFloor];
  half_pitch = cupBase_settings[iCupBase_HalfPitch];
  minimumPrintablePadSize = cupBase_settings[iCupBase_MinimumPrintablePadSize];

  calculate_bin_chamfer = function (
    width,
    pitch,
    clearance,
    wallThickness,
    cavityFloorRadius,
    efficientFloor,
    halfPitch,
    minimumPrintablePadSize) 
    let(
      over_hanging_lip = halfPitch ? (width*2-floor(width*2))/2 : (width-floor(width)),
      over_hanging_lip_mm = (over_hanging_lip)*pitch-clearance/4,
      calculatedCavityFloorRadius = calculateCavityFloorRadius(cavityFloorRadius, wallThickness, efficientFloor),
      outer_wall_radius = calculatedCavityFloorRadius + wallThickness*2,
      large_h = sqrt(2 * outer_wall_radius ^ 2),
      small_h = (large_h - outer_wall_radius) * 2,
      max_chamfer = sqrt((small_h^2) / 2),
      correctable_lip = max(0, min(over_hanging_lip_mm, max_chamfer)))
    over_hanging_lip > 0 && over_hanging_lip < minimumPrintablePadSize ? correctable_lip : 0;

    chamfer_lip_x = calculate_bin_chamfer(
      width = num_x,
      pitch = env_pitch().x,
      clearance = env_clearance().x,
      wallThickness = wall_thickness,
      cavityFloorRadius = cavityFloorRadius,
      efficientFloor = efficientFloor,
      halfPitch = half_pitch,
      minimumPrintablePadSize = minimumPrintablePadSize
    );

    chamfer_lip_y = calculate_bin_chamfer(
      width = num_y,
      pitch = env_pitch().y,
      clearance = env_clearance().x,
      wallThickness = wall_thickness,
      cavityFloorRadius = cavityFloorRadius,
      efficientFloor = efficientFloor,
      halfPitch = half_pitch,
      minimumPrintablePadSize = minimumPrintablePadSize
    );

  chamfer_max= max(chamfer_lip_x, chamfer_lip_y);
  lower_radius = env_corner_radius() - chamfer_max;
  echo("bin_overhang_chamfer", num_x=num_x, num_y=num_y, chamfer_lip_x=chamfer_lip_x, chamfer_lip_y=chamfer_lip_y, chamfer_max=chamfer_max, lower_radius=lower_radius);
  if(chamfer_lip_x > 0 || chamfer_lip_y > 0)
  translate([0,0,baseHeight-fudgeFactor])
  difference() {
    cube([env_pitch().x*num_x, env_pitch().y*num_y, chamfer_max]);

    hull() 
      cornercopy(block_corner_position, num_x, num_y)
        union(){
          _translate = [
                cupBase_settings[iCupBase_AlignGrid].x == "far"
                  ? ($idx[0] == 0 ? -((-chamfer_lip_x)+env_clearance().x/4) : -env_clearance().x/4)
                  : ($idx[0] == 0 ? -env_clearance().x/4 : (-chamfer_lip_x)+env_clearance().x/4),
                cupBase_settings[iCupBase_AlignGrid].y == "far"
                  ? ($idx[1] == 0 ? -((-chamfer_lip_y)+env_clearance().y/4) : -env_clearance().y/4)
                  : ($idx[1] == 0 ? -env_clearance().y/4 : (-chamfer_lip_y)+env_clearance().y/4),
                -fudgeFactor];
        hull(){
            translate([0,0,chamfer_max+fudgeFactor*2])
            cylinder(r=env_corner_radius()+fudgeFactor, h=fudgeFactor);
            translate(_translate)
            cylinder(r=env_corner_radius()+fudgeFactor, h=fudgeFactor);
          }
        }
    
  }
}
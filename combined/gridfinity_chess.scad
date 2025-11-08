///////////////////////////////////////
//Combined version of 'gridfinity_chess.scad'. Generated 2025-11-08 11:07
///////////////////////////////////////
/* [model] */
// Select model
part = "tile";  // [ board, tile, pawn, knight, bishop, rook, queen, king ]
/* [model detail] */
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments 
fa = 6; 
// minimum size of a fragment.  Low is more fragments
fs = 0.1; 
// number of fragments, overrides $fa and $fs
fn = 0;  
/* [Hidden] */
module end_of_customizer_opts() {}
//Combined from path module_gridfinity_block.scad





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
//CombinedEnd from path module_gridfinity_block.scad
//Combined from path module_gridfinity.scad













module pad_grid(
  num_x, 
  num_y, 
  half_pitch=false, 
  flat_base="off", 
  minimium_size = 0.2,
  pitch=env_pitch(), 
  positionGridx = "near", 
  positionGridy = "near") {
  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_bool(half_pitch));
  assert(is_string(flat_base));
  assert(is_num(minimium_size));
  //echo("pad_grid", flat_base=flat_base, half_pitch=half_pitch, positionGridx=positionGridx, positionGridy=positionGridy, minimium_size=minimium_size);
  pad_copy(
    num_x = num_x, 
    num_y = num_y, 
    half_pitch = half_pitch, 
    flat_base = flat_base, 
    minimium_size = minimium_size,
    pitch=pitch, 
    positionGridx = positionGridx, 
    positionGridy = positionGridy)
      pad_oversize($pad_copy_size.x, $pad_copy_size.y);
}
// like a cylinder but produces a square solid instead of a round one
// specified 'diameter' is the side length of the square, not the diagonal diameter
module cylsq(d, h) {
  translate([-d/2, -d/2, 0]) cube([d, d, h]);
}
// like a tapered cylinder with two diameters, but square instead of round
module cylsq2(d1, d2, h) {
  linear_extrude(height=h, scale=d2/d1)
  square([d1, d1], center=true);
}
module frame_cavity(
  num_x = 2, 
  num_y = 1, 
  position_fill_grid_x = "near",
  position_fill_grid_y = "near",
  render_top = true,
  render_bottom = true,
  remove_bottom_taper = false,
  extra_down=0, 
  frameLipHeight = 4,
  cornerRadius = gf_cup_corner_radius,
  reducedWallHeight = -1,
  reducedWallWidth = -1,
  reducedWallOuterEdgesOnly=false,
  enable_grippers = false) {
  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_string(position_fill_grid_x));
  assert(is_string(position_fill_grid_y));
  assert(is_bool(render_top));
  assert(is_bool(render_bottom));
  assert(is_bool(remove_bottom_taper));
  assert(is_num(extra_down));
  assert(is_num(frameLipHeight));
  assert(is_num(cornerRadius));
  assert(is_num(reducedWallHeight));
  assert(is_num(reducedWallWidth));
  assert(is_bool(reducedWallOuterEdgesOnly));
  assert(is_bool(enable_grippers));
  frameWallReduction = reducedWallHeight >= 0 ? max(0, frameLipHeight-reducedWallHeight) : -1;
    translate([0, 0, -fudgeFactor]) 
      gridcopy(
        num_x, 
        num_y,
        positionGridx = position_fill_grid_x,
        positionGridy = position_fill_grid_y) {
      if($gc_size.x > 0.2 && $gc_size.y >= 0.2){
        if(frameWallReduction>=0)
          for(side=[[0, [$gc_size.x, $gc_size.y]*env_pitch().x, "x"],[90, [$gc_size.y, $gc_size.x]*env_pitch().y, "y"]]){
            if(side[1].x >= env_pitch().x/2)
            if(!reducedWallOuterEdgesOnly || ($gc_is_corner[1] && side[2] =="x") || ($gc_is_corner[0] && side[2] =="y"))
            translate([$gc_size.x/2*env_pitch().x,$gc_size.y/2*env_pitch().y,frameLipHeight])
            rotate([0,0,side[0]])
              WallCutout(
                lowerWidth=side[1].x-(reducedWallWidth > 0 ? reducedWallWidth*2 : 20),
                wallAngle=80,
                height=frameWallReduction,
                thickness=side[1].y+fudgeFactor*2,
                cornerRadius=frameWallReduction,
                topHeight=1);
              }
          //wall reducers, cutouts and clips
          if($children >=2) children(1);
          pad_oversize(
            num_x=$gc_size.x,
            num_y=$gc_size.y,
            margins=1,
            extend_down=extra_down,
            render_top=render_top,
            render_bottom=render_bottom,
            remove_bottom_taper=remove_bottom_taper)
              //cell cavity
              if($children >=1) children(0);
    }
  }
}
// unit pad slightly oversize at the top to be trimmed or joined with other feet or the rest of the model
// also useful as cutouts for stacking
//pad_oversize(margins=1,extend_down=5, $fn=64);
module pad_oversize(
  num_x=1, 
  num_y=1, 
  margins=0,
  render_top = true,
  render_bottom = true,
  remove_bottom_taper = false,
  extend_down = 0) {
  assert(!is_undef(num_x), "num_x is undefined");
  assert(is_num(num_x), "num_x must be a number");
  assert(!is_undef(num_y), "num_y is undefined");
  assert(is_num(num_y), "num_y must be a number");
  assert(!is_undef(margins), "margins is undefined");
  assert(is_num(margins), "margins must be a number >= 0");
  assert(!is_undef(extend_down), "extend_down is undefined");
  assert(is_num(extend_down), "extend_down must be a number >= 0");
  if(env_help_enabled("trace")) echo("pad_oversize", num_x=num_x, num_y=num_y, margins= margins);
  // pad_corner_position = [env_pitch().x/2 - 4,env_pitch().y/2 - 4]; 
  // must be 17 to be compatible
  pad_corner_position = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  bevel1_top = 0.8;     // z of top of bottom-most bevel (bottom of bevel is at z=0)
  bevel2_bottom = 2.6;  // z of bottom of second bevel
  bevel2_top = 5;       // z of top of second bevel
  bonus_ht = 0.2;       // extra height (and radius) on second bevel
  // female parts are a bit oversize for a nicer fit
  radialgap = margins ? 0.25 : 0;  // oversize cylinders for a bit of clearance
  //axialdown = margins ? 0.1 : 0;   // a tiny bit of axial clearance present in Zack's design
  //remove axialdown as it messes up the placement of the attachements 
  axialdown =0;
  fudgeFactor = 0.01;
  translate([0, 0, -axialdown])
  difference() {
    union() {
      //top over size taper
      if(render_top){
        hull() cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            translate(bevel2_bottom) 
            cylsq2(d1=(env_corner_radius()-2.15+radialgap)*2, d2=(env_corner_radius()+0.25+radialgap+bonus_ht)*2, h=bevel2_top-bevel2_bottom+bonus_ht);
          }
          else {
            tz(bevel2_bottom) 
            cylinder(d1=(env_corner_radius()-2.15+radialgap)*2, d2=(env_corner_radius()+0.25+radialgap+bonus_ht)*2, h=bevel2_top-bevel2_bottom+bonus_ht);
          }
        }
      }
      if(render_bottom){ 
        hull()
        cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            cylsq(d=1.6+2*radialgap, h=0.1);
            translate([0, 0, bevel1_top]) 
            cylsq(d=(env_corner_radius()-2.15+radialgap)*2, h=1.9+bevel2_top-bevel2_bottom+bonus_ht);
          }
          else {
            cylinder(d=remove_bottom_taper ? (env_corner_radius()-2.15+radialgap)*2 : 1.6+2*radialgap, h=0.1);
            translate([0, 0, bevel1_top]) 
              cylinder(d=(env_corner_radius()-2.15+radialgap)*2, h=1.9+bevel2_top-bevel2_bottom+bonus_ht);
          }
        }
      }
      if(extend_down > 0)
      translate([0,0,-extend_down])
      difference(){
        hull() 
        cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            cylsq(d=1.6+2*radialgap, h=extend_down+fudgeFactor);
          }
          else {
            cylinder(d=1.6+2*radialgap, h=extend_down+fudgeFactor);
          }
        }
        //for baseplate patterns
        children();
      }
    }
    // cut off bottom if we're going to go negative
    if (margins && extend_down == 0) {
      cube([env_pitch().x*num_x, env_pitch().y*num_y, axialdown]);
    }
  }
}
module pad_copy(
  num_x, num_y, 
  half_pitch=false, 
  flat_base="off", 
  minimium_size = 0.2,
  pitch=env_pitch(), 
  positionGridx = "near", 
  positionGridy = "near") {
  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_bool(half_pitch));
  assert(is_string(flat_base));
  assert(is_num(minimium_size));
  if(env_help_enabled("debug")) echo("pad_copy", flat_base=flat_base, half_pitch=half_pitch, minimium_size=minimium_size);
  if (flat_base != FlatBase_off) {
    $pad_copy_size = [num_x, num_y];
    if(env_help_enabled("debug")) echo("pad_grid_flat_base", pad_copy_size=$pad_copy_size);
    if($pad_copy_size.x >= minimium_size && $pad_copy_size.y >= minimium_size) {
      children();
    }
  }
  else if (half_pitch) {
    gridcopy(
      num_x=num_x*2, 
      num_y=num_y*2, 
      pitch=[pitch.y/2,pitch.x/2,pitch.z],
      positionGridx = positionGridx, 
      positionGridy = positionGridy) {
      $pad_copy_size = $gc_size/2;
      if(env_help_enabled("debug")) echo("pad_grid_half_pitch", gci=$gci, gc_size=$gc_size, pad_copy_size=$pad_copy_size);
      if($pad_copy_size.x >= minimium_size && $pad_copy_size.y >= minimium_size) {
         children();      }
    }
  }
  else {
    gridcopy(
      num_x=num_x, 
      num_y=num_y, 
      pitch=pitch,
      positionGridx = positionGridx, 
      positionGridy = positionGridy) {
      $pad_copy_size = $gc_size;
      if(env_help_enabled("debug")) echo("pad_grid", gci=$gci, gc_size=$gc_size, pad_copy_size=$pad_copy_size);
      if($pad_copy_size.x >= minimium_size && $pad_copy_size.y >= minimium_size) {
        children();
      }
    }
  }
}
// make repeated copies of something(s) at the gridfinity spacing of 42mm
module gridcopy(
  num_x, 
  num_y, 
  pitch=env_pitch(), 
  positionGridx = "near", 
  positionGridy = "near") {
  assert(is_num(num_x) && num_x>=0, "num_x must be a number greater than 1");
  assert(is_num(num_y) && num_y>=0, "num_y must be a number greater than 1");
  assert(is_list(pitch));
  function num_to_list(num, positionGrid = "near") = 
    let(
      centerGrid = positionGrid == "center",
      padding = ceil(num) != num ? (num - floor(num))/(centerGrid?2:1) : 0,
      count = ceil(num) + ((padding > 0 && centerGrid) ? 1 :0),
      hasPrePad = padding != 0 && (positionGrid == "center" || positionGrid == "far"),
      hasPostPad = padding != 0 && (positionGrid == "center" || positionGrid == "near"))
      [for (i = [ 0 : count - 1 ]) 
        i == 0 && hasPrePad ? [padding,false]
          : i == count-1 && hasPostPad ? [padding,false]
          : [1, 
            (i == 0 && !hasPrePad) ||
            (i == 1 && hasPrePad) ||
            (i == (count-1) && !hasPostPad) ||
            (i == (count-2) && hasPostPad)]];    
  xCellsList = num_to_list(num_x, positionGridx);
  yCellsList = num_to_list(num_y, positionGridy);
  $gc_count=[len(xCellsList), len(yCellsList)];
  if(env_help_enabled("debug")) echo("gridcopy", xCellsList=xCellsList, yCellsList=yCellsList);
  for (xi=[0:len(xCellsList)-1]) 
    for (yi=[0:len(yCellsList)-1])
    {
      $gci=[xi,yi,0];
      $gc_count=[len(xCellsList), len(yCellsList), 0];
      $gc_size=[xCellsList[xi][0], yCellsList[yi][0], 0];
      //is this a corner really means is outer edge.
      $gc_is_corner=[xCellsList[xi][1], yCellsList[yi][1]];
      $gc_position=[
        vector_sum(xCellsList, 0, xi,0)-xCellsList[xi][0], 
        vector_sum(yCellsList, 0, yi,0)-yCellsList[yi][0], 0];
      translate([$gc_position.x*pitch.x,$gc_position.y*pitch.y,0])
        children();
    }
}         
// similar to cornercopy, can only copy to box corners
// r, position of the corner from the center for a full sized. Must be less than half of pitch (normally 17 for gridfinity) .
// num_x, num_y, size of the cube in units of pitch.
// pitch, size of one unit.
// center, center the grid
// reverseAlignment, reverse the alignment of the corners
module gridcopycorners(
  num_x, 
  num_y, 
  r, 
  onlyBoxCorners = false, 
  pitch=env_pitch(), 
  center = false, 
  reverseAlignment=[false,false]) {
  assert(is_list(pitch), "pitch must be a list");
  assert(is_list(r), "pitch must be a list");
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  r = is_num(r) ? [r,r] : r;
  translate(center ? [0,0] : [pitch.x/2,pitch.y/2])
  for (cellx=[1:ceil(num_x)], celly=[1:ceil(num_y)]) 
    for (quadrentx=[-1, 1], quadrenty=[-1, 1]) {
      cell = [cellx, celly];
      quadrent = [quadrentx, quadrenty];
      gridPosition = [cell.x+(quadrent.x == -1 ? -0.5 : 0), cell.y+(quadrent.y == -1 ? -0.5 : 0)];
      trans = [pitch.x*(cell.x-1)+quadrent.x*r.x, pitch.y*(cell.y-1)+ quadrent.y*r.y, 0];
      $gcci=[trans,cell,quadrent];
      cornerVisible = 
        (!reverseAlignment.x && gridPosition.x <= num_x || reverseAlignment.x && 1.5-gridPosition.x <= num_x) && 
        (!reverseAlignment.y && gridPosition.y <= num_y || reverseAlignment.y && 1.5-gridPosition.y <= num_y);
      if(env_help_enabled("debug")) echo("gridcopycorners", num_x=num_x,num_y=num_y, gcci=$gcci, gridPosition=gridPosition, reverseAlignment=reverseAlignment, cornerVisible=cornerVisible);
      //only copy if the cell is atleast half size
      if(cornerVisible)
        //only box corners or every cell corner
        if(!onlyBoxCorners || 
          ((cell.x == 1 && quadrent.x == -1) && (cell.y == 1  && quadrent.y == -1)) ||
          (gridPosition.x*2 == floor(num_x*2) && gridPosition.y*2 == floor(num_y*2)) ||
          ((cell.x == 1 && quadrent.x == -1) && gridPosition.y*2 == floor(num_y*2) ) ||
          (gridPosition.x*2 == floor(num_x*2) && (cell.y == 1 && quadrent.y == -1))) 
          translate(trans)
          children();
    }
}
// Coppies the children to the corners to create a square shape
// r, position of the corner from the center for a full sized. Must be less than half of pitch (normally 17 for gridfinity) .
// num_x, num_y, size of the cube in units of pitch.
// pitch, size of one unit.
// num_x = 1 give r*2, num_x = 2 give r*2+pitch, 
// similar to quadtranslate but expands to extremities of a block
module cornercopy(r, num_x=1, num_y=1,pitch=env_pitch(), center = false) {
  assert(!is_undef(r), "r is undefined");
  assert(is_list(pitch), "pitch must be a list");
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  r = is_num(r) ? [r,r] : r;
  translate(center ? [0,0] : [pitch.x/2,pitch.y/2])
  for (xx=[0, 1], yy=[0, 1]) {
    $idx=[xx,yy,0];
    xpos = xx == 0 ? -r.x : max(pitch.x*(num_x-1)+r.x,-r.x);
    ypos = yy == 0 ? -r.y : max(pitch.y*(num_y-1)+r.y,-r.y);
    if(env_help_enabled("debug")) echo("cornercopy", num_x=num_x,num_y=num_y,pitch=pitch, center=center, idx=$idx, gridPosition=[xpos,ypos,0]);
    translate([xpos, ypos, 0]) 
      children();
  }
}
module debug_cut(cutx, cuty, cutz) {
  cutx = is_undef(cutx) ? env_cutx() : cutx;
  cuty = is_undef(cuty) ? env_cuty() : cuty;
  cutz = is_undef(cutz) ? env_cutz() : cutz;
  num_x = env_numx();
  num_y = env_numy();
  num_z = env_numz();
  difference(){
    children();
    //Render the cut, used for debugging
    if(cutx != 0 && $preview){
      color(color_cut)
      translate(cutx > 0 
        ? [-fudgeFactor,-fudgeFactor,-fudgeFactor]
        : [(num_x-abs(cutx))*env_pitch().x-fudgeFactor,-fudgeFactor,-fudgeFactor])
      translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
        cube([
            abs(cutx)*env_pitch().x, 
            num_y*env_pitch().y+fudgeFactor*2,
            (num_z+1)*env_pitch().z+fudgeFactor*2]);
    }
    if(cuty != 0 && $preview){
      color(color_cut)
      translate(cuty > 0 
        ? [-fudgeFactor,-fudgeFactor,-fudgeFactor]
        : [-fudgeFactor,(num_y-abs(cuty))*env_pitch().y-fudgeFactor,-fudgeFactor])
        cube([
          num_x*env_pitch().x+fudgeFactor*2,
          abs(cuty)*env_pitch().y,
          (num_z+1)*env_pitch().z+fudgeFactor*2]);
    }
    if(cutz != 0 && $preview){
      color(color_cut)
      translate(cutz > 0 
        ? [-fudgeFactor,-fudgeFactor,-fudgeFactor]
        : [-fudgeFactor,-fudgeFactor,(num_z+1-abs(cutz))*env_pitch().z-fudgeFactor]
        )
        cube([
          num_x*env_pitch().x+fudgeFactor*2,
          num_y*env_pitch().y+fudgeFactor*2,
          abs(cutz)*env_pitch().z]);
    }
  }
}
//CombinedEnd from path module_gridfinity.scad
//Combined from path ub_helptxt.scad



// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad
/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/
// display the module variables in a copyable format
module HelpTxt(titel,string,help){ 
  help=is_undef(help)?is_undef($helpM)?false:
                                $helpM:
  help;
  idxON=is_undef($idxON)?false:$idxON?true:false;
  idx=is_undef($idx)||idxON?false:is_list($idx)?norm($idx):$idx;
   joinArray= function(in,out="",pos=0) pos>=len(in)?out:
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1); 
helpText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],",\n  ")];
 if(version()[0]<2021){ 
if(help)if(is_list(string))echo(
str("<H3> <font color=",helpMColor,"> Help ",titel, "(",
    helpText[0]
,helpText[1]?helpText[1]:""
,helpText[2]?helpText[2]:""
,helpText[3]?helpText[3]:""
,helpText[4]?helpText[4]:""
,helpText[5]?helpText[5]:""
,helpText[6]?helpText[6]:""
,helpText[7]?helpText[7]:""
,helpText[8]?helpText[8]:""
,helpText[9]?helpText[9]:""
,helpText[10]?helpText[10]:""
,helpText[11]?helpText[11]:""
,helpText[12]?helpText[12]:""
,helpText[13]?helpText[13]:""
,helpText[14]?helpText[14]:""
,helpText[15]?helpText[15]:""
,helpText[16]?helpText[16]:""
,helpText[17]?helpText[17]:""
,helpText[18]?helpText[18]:""
,helpText[19]?helpText[19]:""
,helpText[20]?helpText[20]:"" 
,helpText[21]?helpText[21]:""
,helpText[22]?helpText[22]:""
,helpText[23]?helpText[23]:""
,helpText[24]?helpText[24]:""
,helpText[25]?helpText[25]:""
,helpText[26]?helpText[26]:""
,helpText[27]?helpText[27]:""
,helpText[28]?helpText[28]:""
,helpText[29]?helpText[29]:""
// ," name=",name,
," help);"));  
else HelpTxt("Help",["titel",titel,"string",["string","data","help",help],"help",help],help=1);
}
else{ // current versions help 
if(help&&!idx)if(is_list(string))echo(
str("🟪\nHelp ",titel, "(\n  ",
joinArray(helpText)
,"help=",help,"\n);\n"));    
else HelpTxt("Help",["titel",titel,"string",string,"help",help],help=1);
}
}
//CombinedEnd from path ub_helptxt.scad
//Combined from path ub_common.scad


// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad
/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/
useVersion=undef;
co=[
["silver","lightgrey","darkgrey","grey","slategrey","red","orange","lime","cyan","lightblue","darkblue","purple",[.8,.8,.8,.3],[.8,.8,.8,.6],"cyan","magenta","yellow","black","white","red","green","blue",[0.77,0.75,0.72]],//std
["White","Yellow","Magenta","Red","Cyan","Lime","Blue","Gray","Silver","Olive","Purple","Maroon","Teal","Green","Navy","Black"],//VGA
["Gainsboro","LightGray","Silver","DarkGray","Gray","DimGray","LightSlateGray","SlateGray","DarkSlateGray","Black"],//grey
["Pink","LightPink","HotPink","DeepPink","PaleVioletRed","MediumVioletRed"],//pink
["LightSalmon","Salmon","DarkSalmon","LightCoral","IndianRed","Crimson","Firebrick","DarkRed","Red"],//red
["OrangeRed","Tomato","Coral","DarkOrange","Orange"],//orange
["Yellow","LightYellow","LemonChiffon","LightGoldenrodYellow","PapayaWhip","Moccasin","PeachPuff","PaleGoldenrod","Khaki","DarkKhaki","Gold"],//yellows
["Cornsilk","BlanchedAlmond","Bisque","NavajoWhite","Wheat","Burlywood","Tan","RosyBrown","SandyBrown","Goldenrod","DarkGoldenrod","Peru","Chocolate","SaddleBrown","Sienna","Brown","Maroon"],//browns
["DarkOliveGreen","Olive","OliveDrab","YellowGreen","LimeGreen","Lime","LawnGreen","Chartreuse","GreenYellow","SpringGreen","MediumSpringGreen","LightGreen","PaleGreen","DarkSeaGreen","MediumAquamarine","MediumSeaGreen","SeaGreen","ForestGreen","Green","DarkGreen"],//greens
["Cyan","LightCyan","PaleTurquoise","Aquamarine","Turquoise","MediumTurquoise","DarkTurquoise","LightSeaGreen","CadetBlue","DarkCyan","Teal"],//cyans
["LightSteelBlue","PowderBlue","LightBlue","SkyBlue","LightSkyBlue","DeepSkyBlue","DodgerBlue","CornflowerBlue","SteelBlue","RoyalBlue","Blue","MediumBlue","DarkBlue","Navy","MidnightBlue"],//blue
["Lavender","Thistle","Plum","Violet","Orchid","Magenta","MediumOrchid","MediumPurple","BlueViolet","DarkViolet","DarkOrchid","DarkMagenta","Purple","Indigo","DarkSlateBlue","SlateBlue","MediumSlateBlue"],//violetts
["White","Snow","Honeydew","MintCream","Azure","AliceBlue","GhostWhite","WhiteSmoke","Seashell","Beige","OldLace","FloralWhite","Ivory","AntiqueWhite","Linen","LavenderBlush","MistyRose"],//white
["Red","darkorange","Orange","Yellow","Greenyellow","lime","limegreen","turquoise","cyan","deepskyblue","dodgerblue","Blue","Purple","magenta"],//rainbow
["magenta","Purple","Blue","dodgerblue","deepskyblue","cyan","turquoise","limegreen","lime","Greenyellow","Yellow","Orange","darkorange","Red","darkorange","Orange","Yellow","Greenyellow","lime","limegreen","turquoise","cyan","deepskyblue","dodgerblue","Blue","Purple"]//rainbow2
];
styles=[
"Condensed",
"Condensed Oblique",
"Condensed Bold",
"Condensed Bold Oblique",
"Condensed Bold Italic",
"SemiCondensed",
"SemiLight Condensed",
"SemiLight SemiCondensed",
"SemiBold SemiCondensed",
"SemiBold Condensed",
"Light Condensed",
"Light SemiCondensed",
"SemiLight",
"Light",
"ExtraLight",
"Light Italic",
"Bold",
"Bold SemiCondensed",
"Semibold",
"Semibold Italic",
"Bold Italic",
"Bold Oblique",
"Black",
"Black Italic",
"Book",
"Regular",
"Italic",
"Medium",
"Oblique",
];
needs2D=["Rand","WKreis","Welle","Rund","Rundrum", "LinEx", "RotEx","SBogen","Bogen","HypKehle","Roof"]; /// modules needing 2D children 
function bool(n,bool)= b(n,bool);
function b(n,bool)=  is_list(n)?[for(i=[0:len(n)-1])b(n[i],bool)]:
                               is_num(n)?bool||is_undef(bool)?n?true:
                                                                false:
                                                              n?n:
                                                                0:
                                         bool?n?true:  // n = bool
                                                false:
                                              n?1:
                                                0;
function v3(v)= [
is_num(v.x)?v.x:is_num(v)?v:0,
is_num(v.y)?v.y:0,
is_num(v.z)?v.z:0,
 ];
function gradB(b,r)=360/(PI*r*2)*b; // winkel zur Bogen strecke b des Kreisradiuses r
// list of parent modules [["name",id]]
function parentList(n=-1,start=1)=  is_undef($parent_modules)||$parent_modules==start?undef:[for(i=[start:$parent_modules +n])[parent_module(i),i]];
function is_parent(parent= needs2D, i= 0)=
is_list(parent)?is_num(search(parent,parentList())[i])?true:
                                                      i<len(parent)-1?is_parent(parent=parent,i=i+1):
                                                                      false:
                is_num(search([parent],parentList())[0]);
/** \name stringChunk
\page Functions
stringChunk() separates charcter from a string
\param txt input string
\param start start of extraction
\param length number of characters to extract
*/
function stringChunk(txt,start=0,length,string="")=
  let(
    start=abs(start),
    length=is_undef(length)?len(str(txt))-start:length
  )
  len(string)<length&&start<len(txt)?stringChunk(txt=txt,length=length,start=start+1,string=str(string,str(txt)[start])):string;
/// display variable values
module InfoTxt(name,string,info,help=false){
  $tab=is_undef($tab)?0:$tab;
  info=is_undef(info)?is_undef($info)?false:
                                $info:
  info;
  //  https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/User-Defined_Functions_and_Modules#Function_Literals
 noInfo=is_undef($noInfo)?false:$noInfo; 
 idx=is_undef($idx)?false:is_list($idx)?norm($idx):$idx;
 idxON=is_undef($idxON)?false:$idxON?true:false;
 joinArray= function(in,out="",pos=0) pos>=len(in)?out: // scad version > 2021
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1);   
 if(version()[0]<2021){   
  infoText=[for(i=[0:2:len(string)-1])str(string[i],"=",is_num(string[i+1])?negRed(string[i+1]):string[i+1],i<len(string)-2?", ":"")];
if(info)if(is_list(string))echo( 
 str(is_bool(info)?"":"<b>",info," ",name," ", 
infoText[0]
,infoText[1]?infoText[1]:""
,infoText[2]?infoText[2]:""
,infoText[3]?infoText[3]:""
,infoText[4]?infoText[4]:""
,infoText[5]?infoText[5]:""
,infoText[6]?infoText[6]:""
,infoText[7]?infoText[7]:""
,infoText[8]?infoText[8]:""
,infoText[9]?infoText[9]:""
));
else HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=1);
}
else { // current version info
  infoText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],i<len(string)-2?", ":"")];
if(info&&(!idx||idxON)&&!noInfo)if(is_list(string))echo( 
 str(is_string(info)?$tab?"⏩\t":
                          "🟩\t••":
                     "",$tab?" ╞▷   ":
                             "",b($tab,false)>1?" ┗▶   ":
                                                " ",info," ",name," ",
joinArray(infoText)));
else HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=1);
}
HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=help);
}
/// missing object text
module MO(condition=true,warn=false){
$idx=is_undef($idx)?false:$idx;
Echo(str(parent_module(2)," has no children!"),color=warn?"warning":"red",condition=condition&&$parent_modules>1&&!$idx,help=false);    
}
/// short for translate[];
module T(x=0,y=0,z=0,help=false)
{
    //translate([x,y,z])children();
if(is_list(x))
    multmatrix(m=[
    [1,0,0,x[0]],
    [0,1,0,x[1]],    
    [0,0,1,is_undef(x.z)?z:x[2]+z],
    [0,0,0,1]    
    ])children(); 
else
    multmatrix(m=[
    [1,0,0,x],
    [0,1,0,y],    
    [0,0,1,z],
    [0,0,0,1]    
    ])children(); 
    MO(!$children);
    HelpTxt("T",["x",x,"y",y,"z",z],help);
}
module Text(text="»«",size=5,h,cx,cy,cz,center=0,spacing=1,fn,fs=$fs,radius=0,rot=[0,0,0],font="Bahnschrift:style=bold",style,help,name,textmetrics=true,viewPos=false,trueSize="body")
{
text=str(text);
lenT=len(text);
textmetrics=version()[0]<2022?false:textmetrics;
Echo(str("Sizing inactive trueSize=",trueSizeSW),color="warning",condition=trueSize!="size"&&( (!textmetrics&&trueSize!="body")||(is_num(useVersion)&&useVersion<22.208) ) );
trueSizeSW=is_num(useVersion)&&useVersion<22.208?"size":trueSize;
inputSize=size;
style=is_string(style)?style:styles[style];
font=is_num(font)?fonts[font]:font;
fontstr=is_undef(style)?font:str(font,":style=",style);
hp=textmetrics?textmetrics(text="hpbdlq",font=fontstr,size=1,spacing=spacing).size.y:1;
cap=textmetrics?textmetrics(text="HTAME",font=fontstr,size=1,spacing=spacing).size.y:1;
textSize=textmetrics?textmetrics(text=text,font=fontstr,size=1,spacing=spacing).size:[lenT*spacing,1];
fontS=textmetrics?fontmetrics(font=fontstr,size=1).nominal:1;
size=trueSizeSW=="body"?size*.72:
     trueSizeSW=="hp"?size/hp:
     trueSizeSW=="cap"?size/cap:
     trueSizeSW=="text"?size/textSize.y:
     trueSizeSW=="textl"?size/textSize.x:
     trueSizeSW=="font"?size/(fontS.ascent-fontS.descent):
     size;
    h=is_parent(needs2D)?0:is_undef(h)?size:h;
    cx=center?is_undef(cx)?1:cx:is_undef(cx)?0:cx;
    cy=center?is_undef(cy)?1:cy:is_undef(cy)?0:cy;
    cz=center?is_undef(cz)?1:cz:is_undef(cz)?0:cz;
    txtSizeX=textmetrics?textmetrics(text=text,font=fontstr,size=size,spacing=spacing).size.x:size*spacing*lenT;
    txtSizeY=textmetrics?textmetrics(text=text,font=fontstr,size=size,spacing=spacing).size.y:size;
    fontSize=[for(i=[0:max(lenT-1,0)])textmetrics?
      textmetrics(text=stringChunk(txt=text,length=i),font=fontstr,size=size,spacing=spacing).advance.x + textmetrics(text=text[i],font=fontstr,size=size,spacing=1).advance.x/2*(cx?1:1)
      :
      (size*spacing)*i];
 valign=cy?b(cy,false)<0?"bottom":
                         b(cy,false)>1?"top":
                                       "center":
           "baseline";
 halign=bool(cx,false)>0?"center"
                        :bool(cx,false)<0?"right"
                                         :"left";
 if(text)
  if(!radius){   
    if(h)    
    rotate(rot)translate([0,0,cz?-abs(h)/2:h<0?h:0]) linear_extrude(abs(h),convexity=10){
    text(str(text),size=size,halign=halign,valign=valign,font=fontstr,spacing=spacing,$fn=fn,$fs=fs);
    }
    else rotate(rot)translate([0,0,cz?-h/2:0])text(text,size=size,halign=halign,valign=valign,spacing=spacing,font=fontstr,$fn=fn,$fs=fs); 
  }
  else if (lenT){
   iRadius=radius+(cy?-txtSizeY/2:0);
    rotate(center?textmetrics?gradB(txtSizeX/2,iRadius):gradB(max(fontSize),iRadius)/2:0)
    for(i=[0:lenT-1])rotate(-gradB(fontSize[i],iRadius))
    if(h)    
    translate([0,radius,0])rotate(rot)Tz(cz?-abs(h)/2:h<0?h:0){
    %color("Chartreuse")if(viewPos&&$preview)translate([0,-1])rotate(-30)circle($fn=3);// pos Marker
    linear_extrude(abs(h),convexity=10)text(text[i],size=size,halign=true?"center":"left",valign=valign,font=fontstr,$fn=fn,$fs=fs);
    }
    else  translate([0,radius,cz?-h/2:0])rotate(rot)text(text[i],size=size,halign=true?"center":"left",valign=valign,font=fontstr,$fn=fn,$fs=fs); 
  }
 InfoTxt("Text",["font",font,"style",style,"trueSize",trueSizeSW,"size",str(inputSize," ⇒ ",size)],name);   
 HelpTxt("Text",[
"text",str("\"",text,"\""),
"size",inputSize,
"h",str(h," /*0 for 2D*/"),
"cx",cx,
"cy",cy,
"cz",cz,
"center",center,
"spacing",spacing,
"fn",fn,
"fs",fs,
"radius",radius, 
"rot",rot,
"font",str("\"",font,"\""),
"style",str("\"",style,"\""),
"name",name,
"textmetrics",textmetrics,
"viewPos",viewPos,
"trueSize",str("\"",trueSize,"\""," /* body,size,hp,cap,text,textl,font */")
],help);
}
 // color by color lists
module Col(no=0,alpha=1,pal=0,name=0,help){
   palette=["std","VGA","grey","pink","red","orange","yellow","brown","green","cyan","blue","violett","white","rainbow"]; 
HelpTxt("Col",["no",no,"alpha",alpha,"pal",pal,"name",name],help);
    for(i=[0:1:$children-1]){
    $idx=i;
    color(co[pal][(no+i)%len(co[pal])],alpha)children(i);
    union(){
      $idx=0; 
    InfoTxt("Col",["Color children ($idx)",str(i," Farb№: ",no+i,"- ",co[pal][(no+i)%len(co[pal])])," von ",len(co[pal])-1,"Palette",str(pal,"/",palette[pal],(no+i>len(co[pal])-1)?" — Out of Range":"")],name);
    }
    }
    MO(!$children);
}
/// echo color differtiations
module Echo(title,color="#FF0000",size=2,condition=true,help=false){
 idx=is_undef($idx)?false:is_list($idx)?norm($idx):$idx;
 idxON=is_undef($idxON)?false:$idxON?true:false;
 if(condition&&(!idx||idxON))
     if(version()[0]<2021)echo(str("<H",size,"><font color=",color,">",title)); 
     else if (color=="#FF0000"||color=="red")echo(str("\n🔴\t»»» ",title));
     else if (color=="redring")echo(str("\n⭕\t»»» ",title));
     else if (color=="#FFA500"||color=="orange")echo(str("\n🟠\t»»» ",title));    
     else if (color=="#00FF00"||color=="green"||color=="info")echo(str("🟢\t ",title));
     else if (color=="#0000FF"||color=="blue") echo(str("🔵\t ",title));
     else if (color=="#FF00FF"||color=="purple") echo(str("🟣\t ",title));    
     else if (color=="#000000"||color=="black") echo(str("⬤\t ",title));
     else if (color=="#FFFFFF"||color=="white") echo(str("◯\t ",title));
     else if (color=="#FFFF00"||color=="yellow"||color=="warning") echo(str("⚠\t ",title));    
         else echo(str("• ",title)); 
 HelpTxt("Echo",["title",title,"color",color,"size",size,"condition",condition],help);
}
//Clone and mirror object
module MKlon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,mx,my,mz,help=false)
{
    mx=is_undef(mx)?sign(abs(tx)):mx;
    my=is_undef(my)?sign(abs(ty)):my;
    mz=is_undef(mz)?!mx&&!my?1:sign(abs(tz)):mz;
  $idx=0;  
    translate([tx,ty,tz])rotate([rx,ry,rz])children();
    union(){
        $helpM=0;
        $info=0; 
        $idx=1;
        $idxON=false; 
        translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])mirror([mx,my,mz]) children();
    }
    MO(!$children);
    HelpTxt("MKlon",["tx",tx,"ty",ty,"tz",tz,"rx",rx,"ry",ry,"rz",rz,"mx",mx,"my",my,"mz",mz],help);
}
// Clone and mirror (replaced by MKlon)
module Mklon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,mx=0,my=0,mz=1)
{
    mx=tx?1:mx;
    my=ty?1:my;
    mz=tz?1:mz;
  $idx=0;
    translate([tx,ty,tz])rotate([rx,ry,rz])children(); 
    union(){
        $helpM=0;
        $info=0;
        $idx=1;
        $idxON=false;
    translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])mirror([mx,my,mz]) children(); }   
   MO(!$children);
}
//CombinedEnd from path ub_common.scad
//Combined from path module_utility.scad





utility_demo = false;
if(utility_demo && $preview){
  translate([400,0,0])
  union(){
    bentWall(separation=0);
    translate([0,100,0])
    bentWall(separation=0, thickness = [10,5]);
    translate([0,200,0])
    bentWall(separation=0, thickness = [10,5], top_radius = -2);
    translate([20,0,0])
    bentWall(separation=10);
    translate([20,100,0])
    bentWall(separation=10, thickness = [10,5]);
    translate([20,200,0])
    bentWall(separation=10, thickness = [10,5], top_radius = -2);
  }
}
//Wall is centred on the middle of the start. Bend is not taken in to account
module bentWall(
  length=80,
  bendPosition=0,
  bendAngle=45,
  separation=20,
  lowerBendRadius=0,
  upperBendRadius=0,
  height=30,
  thickness=[10,10],
  wall_cutout_depth = 0,
  wall_cutout_width = 0,
  wall_cutout_radius = 0,
  top_radius = 0,
  centred_x=true) {
  assert(is_num(thickness) || (is_list(thickness) && len(thickness) ==2), "thickness should be a list of len 2");
  thickness = is_num(thickness) ? [thickness,thickness] : thickness;
  thickness_bottom  = thickness.x;
  thickness_top = thickness.y;
  top_scale = thickness.y/thickness.x;
  top_radius = get_related_value(
    user_value = top_radius, 
    base_value = thickness_top, 
    max_value = thickness_top/2,
    default_value = 0);
  bendPosition = get_related_value(bendPosition, length, length/2);
  fudgeFactor = 0.01;
  //#render()
  difference()
  {
    if(separation != 0) { 
      translate(centred_x ? [0,0,0] : [(thickness.x+separation)/2,0,0])
      translate([0,bendPosition,0])
      linear_extrude(height, scale = [top_scale,1], )
      SBogen(
        TwoD=thickness.x,
        dist=separation,
        //x0=true,
        grad=bendAngle,
        r1=lowerBendRadius <= 0 ? separation : lowerBendRadius,
        r2=upperBendRadius <= 0 ? separation : upperBendRadius,
        l1=bendPosition,
        l2=length-bendPosition);   
    } else {
      translate(centred_x ? [-thickness.x/2,0,0] : [0,0,0])
      hull(){
        rotate([90,0,0])
        translate([(thickness_bottom-thickness_top)/2,0,-length])
        roundedCube(
          size =[thickness_top, height, length],
          sideRadius = top_radius);
        cube([thickness_bottom, length, thickness_bottom/2]);
      }
    }
    cutoutHeight = get_related_value(wall_cutout_depth, height, 0);
    cutoutRadius = get_related_value(wall_cutout_radius, cutoutHeight, cutoutHeight);
    cutoutLength = get_related_value(wall_cutout_width, length, length/2); 
    if(wall_cutout_depth != 0){
      translate(centred_x ? [0,0,0] : [(separation+thickness)/2+fudgeFactor,0,0])
      translate([0,length/2,height])
      rotate([0,0,90])
      WallCutout(
        height = cutoutHeight,
        lowerWidth = cutoutLength,
        cornerRadius = cutoutRadius,
        thickness = (separation+thickness[0]+fudgeFactor*2),
        topHeight = 1);
    }
   }
 }
 if(utility_demo){
  translate([200,0,0])
  roundedCube(
    size = [100,100,100],
    //cornerRadius=2,
    topRadius = 0, bottomRadius = 2, sideRadius = 4, 
    supportReduction_z=[-1,0],
    $fn=128);
  translate([200,150,0])
  roundedCube(
    size = [100,100,100],
    //cornerRadius=2,
    topRadius = 5, bottomRadius = 2, sideRadius = 5,
    supportReduction_x = [-1, -1],
    supportReduction_y = [-1, -1],
    supportReduction_z=[-1,0],
    $fn=128);
  translate([200,300,0])
  roundedCube(
    size = [54.5,39.5,41],
    cornerRadius=0,
    topRadius = 0, bottomRadius = 2, sideRadius = 3.75, 
    supportReduction_x = [0, 0], supportReduction_y = [0, 0], supportReduction_z = [1, 0],
    $fn=128);
}
//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
//topRadius = the radius of the top of the cube
//bottomRadius = the radius of the top of the cube
//sideRadius = the radius of the sides. This must be over 0.
module roundedCube(
  x,
  y,
  z,
  size=[],
  cornerRadius = 0,
  topRadius = 0,
  bottomRadius = 0,
  sideRadius = 0 ,
  centerxy = false,
  supportReduction_x = [0,0],
  supportReduction_y = [0,0],
  supportReduction_z = [0,0])
{
  minSideRadius = 0.01;
  assert(is_list(size), "size must be a list");
  size = len(size) == 3 ? size : [x,y,z];
  topRadius = topRadius > 0 ? topRadius : cornerRadius;
  bottomRadius = bottomRadius > 0 ? bottomRadius : cornerRadius;
  sideRadius = max(minSideRadius, sideRadius > 0 ? sideRadius : cornerRadius);
  supportReduction_z = is_num(supportReduction_z) ? [supportReduction_z, supportReduction_z] : supportReduction_z;
  supportReduction_x = is_num(supportReduction_x) ? [supportReduction_x, supportReduction_x] : supportReduction_x;
  supportReduction_y = is_num(supportReduction_y) ? [supportReduction_y, supportReduction_y] : supportReduction_y;
  assert(topRadius <= sideRadius, str("topRadius must be less than or equal to sideRadius. topRadius:", topRadius, " sideRadius:", sideRadius));
  assert(bottomRadius <= sideRadius, str("bottomRadius must be less than or equal to sideRadius. bottomRadius:", bottomRadius, " sideRadius:", sideRadius));
  //Support reduction should move in to roundedCylinder
  function auto_support_reduction(supportReduction, corner_radius, center_radius) = 
    let(center_radius = is_num(center_radius) ? center_radius : corner_radius,
      sr = (supportReduction == -1 ? corner_radius/2 : supportReduction)+max(0,center_radius-corner_radius))
    min(sr, center_radius);
  //z needs to account for the side radius as the side radius can be greater than the top and bottom radius.
  supReduction_z = [auto_support_reduction(supportReduction_z[0], bottomRadius, sideRadius), auto_support_reduction(supportReduction_z[1], topRadius, sideRadius)];
  supReduction_x = [auto_support_reduction(supportReduction_x[0], sideRadius), auto_support_reduction(supportReduction_x[1], sideRadius)];
  supReduction_y = [auto_support_reduction(supportReduction_y[0], sideRadius), auto_support_reduction(supportReduction_y[1], sideRadius)];
  //x and y need and offset to account for the top and bottom radius
  supReduction_x_offset = [auto_support_reduction(supportReduction_x[0], bottomRadius), auto_support_reduction(supportReduction_x[1], topRadius)];
  supReduction_y_offset = [auto_support_reduction(supportReduction_y[0], bottomRadius), auto_support_reduction(supportReduction_y[1], topRadius)];
  positions=[
     [[sideRadius                         ,sideRadius],                        [0,0]]
    ,[[max(size.x-sideRadius, sideRadius) ,sideRadius]                        ,[1,0]]
    ,[[max(size.x-sideRadius, sideRadius) ,max(size.y-sideRadius, sideRadius)],[1,1]]
    ,[[sideRadius                         ,max(size.y-sideRadius, sideRadius)],[0,1]]
    ];
  translate(centerxy ? [-size.x/2,-size.y/2,0] : [0,0,0])
  hull() 
  {
    for (i =[0:1:len(positions)-1])
    {
      translate(positions[i][0]) 
        union(){
        roundedCylinder(h=size.z,r=sideRadius,roundedr2=topRadius,roundedr1=bottomRadius);
        if(supReduction_z[1] > 0)
          translate([0,0,size.z-topRadius])
          cylinder(h=topRadius, r=supReduction_z[1]);
        if(supReduction_z[0] > 0)
          cylinder(h=bottomRadius, r=supReduction_z[0]);
        if(supReduction_x[0] > 0 && positions[i][1].x ==0){
          if(topRadius ==0 && bottomRadius == 0)
          {
            translate([0,0,size.z/2])
            cube(size=[sideRadius*2,supReduction_x[0]*2,size.z],center=true);
          } else {
            //bottom
            translate([0,0,supReduction_x[0]+supReduction_x_offset[0]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[0],center=true);
            //top
            translate([0,0,size.z-supReduction_x[0]-supReduction_x_offset[1]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[0],center=true);
          }
        }
        if(supReduction_x[1] > 0 && positions[i][1].x ==1){
         if(topRadius == 0 && bottomRadius == 0)
         {
            translate([0,0,size.z/2])
            cube(size=[sideRadius*2,supReduction_x[1]*2,size.z],center=true);
          } else {
            //bottom
            translate([0,0,supReduction_x[1]+supReduction_x_offset[0]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[1],center=true);
            //top
            translate([0,0,size.z-supReduction_x[1]-supReduction_x_offset[1]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[1],center=true);
          }
        }
        if(supReduction_y[0] > 0 && positions[i][1].y == 0){
            //bottom
            translate([0,0,supReduction_y[0]+supReduction_y_offset[0]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[0],center=true);
            //top
            translate([0,0,size.z-supReduction_y[0]-supReduction_y_offset[1]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[0],center=true);
        }
        if(supReduction_y[1] > 0 && positions[i][1].y == 1){
            //bottom
            translate([0,0,supReduction_y[1]+supReduction_y_offset[0]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[1], center=true);
            //top
            translate([0,0,size.z-supReduction_y[1]-supReduction_y_offset[1]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[1], center=true);
        }
      }
    }
  }
}
//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
module roundedCubeV1(
  x,
  y,
  z,
  cornerRadius)
{
  positions=[
     [cornerRadius                      ,cornerRadius                      ,cornerRadius]
    ,[max(x-cornerRadius, cornerRadius) ,cornerRadius                      ,cornerRadius]
    ,[max(x-cornerRadius, cornerRadius) ,max(y-cornerRadius, cornerRadius) ,cornerRadius]
    ,[cornerRadius                      ,max(y-cornerRadius, cornerRadius) ,cornerRadius]
    ];
  hull(){
    for (x =[0:1:len(positions)-1])
    {
      translate(positions[x]) 
        sphere(cornerRadius);
      translate(positions[x]) 
        cylinder(z-cornerRadius,r=cornerRadius);
    }
  }
}
if(utility_demo){
roundedCorner(
  radius = 10, 
  length = 100, 
  height = 25,
  $fn=128); 
}
//create a negative rouneded corner that subtracted from a shape
//radius = the radius of the corner 
//length = the extrusion/length
//height = the distance past the corner.
module roundedCorner(
  radius = 10, 
  length, 
  height)
{
  assert(is_num(length), "length must be a number");
  assert(is_num(height), "height must be a number");
  assert(is_num(radius), "radius must be a number");
  difference(){
    union(){
      //main corner to be removed
      translate([0,-radius, -radius])
        cube([length, radius*2,  radius*2]);
      //corner extension in y
      translate([0,0, -radius])
        cube([length, height, radius]);
      //corner extension in x
      translate([0,-radius, 0])
        cube([length, radius, height]);
    }
    translate([-1,radius, radius])
      rotate([90, 0, 90])
      cylinder(h = length+2, r=radius);
  }  
}
if(utility_demo){
translate([0,50,0])
chamferedCorner(
  chamferLength = 10, 
  cornerRadius = 4, 
  length=100, 
  height=25,
  width = 20,
  $fn=128);
}
//create a negative chamfer corner that subtracted from a shape
//chamferLength = the amount that will be subtracted from the 
//cornerRadius = the radius of the corners 
//length = the extrusion/length
//height = the distance past the corner
module chamferedCorner(
  chamferLength = 10, 
  cornerRadius = 4, 
  length, 
  height,
  width = 0,
  angled_extension = false)
{
  fudgeFactor = 0.01;
  width = width>0 ? width : chamferLength;
  difference(){
    union(){
      //main corner to be removed
      translate([0,-width, -width])
        cube([length, chamferLength+width,  chamferLength+width]);
      //corner extension in y
      translate([0,chamferLength-fudgeFactor, -width])
        rotate_around_point(point=[0,0,width], rotation=angled_extension ? [-45,0,0] : [0,0,0])
        cube([length, height-chamferLength, width]);
      //corner extension in x
      translate([0,-width, chamferLength-fudgeFactor])
        rotate_around_point(point=[0,width,0], rotation=angled_extension ? [45,0,0] : [0,0,0])
        cube([length, width, height-chamferLength]);
    }
    hull(){
      positions = [
        [-1,chamferLength, cornerRadius],
        [-1,cornerRadius, chamferLength],
        [-1,chamferLength, chamferLength]];
      for(i=[0:len(positions)-1])
      {
        translate(positions[i])
          rotate([90, 0, 90])
          cylinder(h = length+2, r=cornerRadius);
      }
    }
  }        
}
module rotate_around_point(point=[], rotation=[]){
  translate(point)
  rotate(rotation)
  translate(-point)
  children();
}
//sequential bridging for hanging hole. 
//ref: https://hydraraptor.blogspot.com/2014/03/buried-nuts-and-hanging-holes.html
//ref: https://www.youtube.com/watch?v=KBuWcT8XkhA
module SequentialBridgingDoubleHole(
  outerHoleRadius = 0,
  outerHoleDepth = 0,
  innerHoleRadius = 0,
  innerHoleDepth = 0,
  overhangBridgeCount = 2,
  overhangBridgeThickness = 0.3,
  overhangBridgeCutin = 0.05, //How far should the bridge cut in to the second smaller hole. This helps support the
  magnetCaptiveHeight = 0,
  ) 
{
  fudgeFactor = 0.01;
  hasOuter = outerHoleRadius > 0 && outerHoleDepth >0;
  hasInner = innerHoleRadius > 0 && innerHoleDepth > 0;
  bridgeRequired = hasOuter && hasInner && outerHoleRadius > innerHoleRadius && innerHoleDepth > outerHoleDepth;
  overhangBridgeCount = bridgeRequired ? overhangBridgeCount : 0;
  overhangBridgeHeight = overhangBridgeCount*overhangBridgeThickness;
  outerPlusBridgeHeight = hasOuter ? outerHoleDepth + overhangBridgeHeight : 0;
  if(hasOuter || hasInner)
  union(){
    difference(){
      if (hasOuter) {
        // move the cylinder up into the body to create internal void
        translate([0,0,magnetCaptiveHeight])
        if($children >=1){
          translate([0,0,outerHoleDepth]);
          cylinder(r=outerHoleRadius, h=overhangBridgeHeight+fudgeFactor);
          children(0); 
        } else { 
          cylinder(r=outerHoleRadius, h=outerPlusBridgeHeight+fudgeFactor);
        }
      }
      if (overhangBridgeCount > 0) {
        for(i = [0:overhangBridgeCount-1]) 
          rotate([0,0,180/overhangBridgeCount*i])
          for(x = [0:1]) 
          rotate([0,0,180]*x)
            translate([-outerHoleRadius,innerHoleRadius-overhangBridgeCutin,outerHoleDepth+overhangBridgeThickness*i])
            cube([outerHoleRadius*2, outerHoleRadius, overhangBridgeThickness*overhangBridgeCount+fudgeFactor*2]);
              }
      }
      if (hasInner) {
        translate([0,0,outerPlusBridgeHeight])
        cylinder(r=innerHoleRadius, h=innerHoleDepth-outerPlusBridgeHeight);
    }
  }
}
//Creates a cube with a single rounded corner.
//Centered around the rounded corner
module CubeWithRoundedCorner(
  size=[10,10,10], 
  cornerRadius = 2, 
  edgeRadius = 0,
  center=false){
  assert(is_list(size) && len(size)==3, "size should be a list of size 3");
  assert(is_num(cornerRadius) && cornerRadius >= 0, "cornerRadius should be a number greater than 0");
  assert(is_num(edgeRadius), "edgeRadius should be a number");
  fudgeFactor = 0.01;
  translate(center ? -size/2 : [0,0,0])
  if(edgeRadius <=0) {
    hull(){
      translate([cornerRadius,cornerRadius,0])
      cylinder(r=cornerRadius, h=size.z+fudgeFactor);
      translate([cornerRadius,0,0])
        cube([size.x-cornerRadius,size.y,size.z+fudgeFactor]);
      translate([0,cornerRadius,0])
        cube([size.x,size.y-cornerRadius,size.z+fudgeFactor]);
    }
  }
  else{
    hull(){
      translate([cornerRadius,cornerRadius,0])
      roundedCylinder(h=size.z+fudgeFactor,r=cornerRadius,roundedr2=edgeRadius);
      translate([(size.x+cornerRadius)/2,size.y/2,size.z/2])
      rotate([0,90,0])
      CubeWithRoundedCorner(
        size=[size.z,size.y,size.x-cornerRadius], 
        cornerRadius = edgeRadius,
        edgeRadius=0,
        center=true);
      translate([size.x/2,(size.y+cornerRadius)/2,size.z/2])
      rotate([0,90,270])
      CubeWithRoundedCorner(
        size=[size.z,size.y,size.x-cornerRadius], 
        cornerRadius = edgeRadius,
        edgeRadius=0,
        center=true);        
    }
  }
}
module roundedCylinder(h,r,roundedr=0,roundedr1=0,roundedr2=0)
{
  assert(is_num(h), "h must have a value");
  assert(is_num(r), "r must have a value");
  roundedr1 = roundedr1 > 0 ? roundedr1 : roundedr;
  roundedr2 = roundedr2 > 0 ? roundedr2 : roundedr;
  assert(is_num(roundedr1), "roundedr1 or roundedr must have a value");
  assert(is_num(roundedr2), "roundedr2 or roundedr must have a value");
  if(roundedr1 > 0 || roundedr2 > 0){
    hull(){
      if(roundedr1 > 0)
        roundedDisk(r,roundedr1,half=-1);
      else
        cylinder(r=r,h=h-roundedr2);
      if(roundedr2 > 0)
        translate([0,0,h-roundedr2*2]) 
          roundedDisk(r,roundedr2,half=1);
      else
        translate([0,0,roundedr1]) 
          cylinder(r=r,h=h-roundedr1);
    }
  }
  else {
    cylinder(r=r,h=h);
  }
}
module roundedDisk(r,roundedr, half=0){
 hull(){
    translate([0,0,roundedr]) 
    rotate_extrude() 
    translate([r-roundedr,0,0])
    difference(){
      circle(roundedr);
      //Remove inner half so we dont get error when r<roundedr*2
      translate([-roundedr*2,-roundedr,0])
      square(roundedr*2);
      if(half<0){
        //Remove top half
        translate([-roundedr,0,0])
        square(roundedr*2);   
      }
      if(half>0){
        //Remove bottom half
        translate([-roundedr,-roundedr*2,0])
        square(roundedr*2);   
      }
    }
  }
}
module tz(z) {
  translate([0, 0, z]) children();
}
//rounded_taper();
module rounded_taper(
  upperRadius=35,
  upperLength=20,
  lowerRadius=10,
  lowerLength=20,
  transitionLength=10,
  cornerRadius=0,
  roundedUpper=false,
  roundedLower=false,
  alignTop = false) {
  bottomWidth = lowerRadius*2;
  //topWidth = lowerWidth+(height/tan(wallAngle))*2;
  topWidth = upperRadius*2;
  height = upperLength+transitionLength+lowerLength;
  translate([0,0,alignTop?-height:0])
  rotate_extrude(angle=360, convexity=10)
  intersection(){
    square([topWidth,height]);
    //Use triple offset to fillet corners
    //https://www.reddit.com/r/openscad/comments/ut1n7t/quick_tip_simple_fillet_for_2d_shapes/
    offset(r=-cornerRadius)
    offset(r=2 * cornerRadius)
    offset(r=-cornerRadius)
    union(){
      hull(){
        //upper
        translate([-topWidth/2,lowerLength+transitionLength])
          square([topWidth,upperLength+(roundedUpper?0:cornerRadius)]);
        //transition
        translate([-bottomWidth/2,lowerLength])
          square([bottomWidth,transitionLength]);
      }
      //lower
      translate([-bottomWidth/2,roundedLower?0:-cornerRadius])
      square([bottomWidth,lowerLength+(roundedLower?0:cornerRadius)]);
    }
  }
}
module PartialCylinder(h, r, part) {
    rotate_extrude(angle = part)
        square([r, h]);
}
//CombinedEnd from path module_utility.scad
//Combined from path ub_sbogen.scad






// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad
/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/
minVal=0.0000001; // minimum für nicht 0
pivotSize=$vpd/15;
function Hypotenuse(a,b)=sqrt(pow(a,2)+pow(b,2));
function hypotenuse(a,b)=sqrt(pow(a,2)+pow(b,2));
function Kathete(hyp,kat)=sqrt(pow(hyp,2)-pow(kat,2));
function kathete(hyp,kat)=sqrt(pow(hyp,2)-pow(kat,2));
function Hexstring(c)=str("#",Hex(c[0]*255),Hex(c[1]*255),Hex(c[2]*255));
// two digit dec max 255
function Hex(dec)= 
    let(
    dec=min(abs(dec),255),
    sz=floor(dec/16),
    s1=floor(dec)-(sz*16)
    )
    str(sz>14?"F":
        sz>13?"E":
        sz>12?"D":
        sz>11?"C": 
        sz>10?"B":
        sz>9?"A":sz,      
        s1>14?"F":
        s1>13?"E":
        s1>12?"D":
        s1>11?"C": 
        s1>10?"B":
        s1>9?"A":s1   
    );
function RotLang(rot=0,l=10,l2,z,e,lz)=let(
rot=is_undef(rot)?0:rot%360,
l=is_undef(l)?0:l,
l2=is_undef(l2)?l:l2,
lz=is_undef(lz)?l:lz
)
is_undef(z)?is_undef(e)?[sin(rot)*l,cos(rot)*l2]:
                        [sin(rot)*cos(e%360)*l,cos(rot)*cos(e%360)*l2,sin(e%360)*lz]:
            [sin(rot)*l,cos(rot)*l,z];
/** \page Functions \name kreis
kreis() generates points on a circle or arc
\param r radius
\param rand dist second radius
\param grad angle
\param grad2 angle second arc
\param fn fragments
\param center center angle
\param sek  chord or center point
\param r2  y component
\param rand2  y component
\param rot rotate points
\param t translate points
\param z z value for polyhedron
\param d ovewrite radius with diameter
\param endPoint end angle with point
\param fs fragment size
\param fs2 fragment size second arc
\param fn2 fragments second arc
\param minF minimum fragments 
*/
function Kreis(r=10,rand=+5,grad=360,grad2,fn=$fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0])=kreis(r,rand,grad,grad2,fn,center,sek,r2,rand2,rcenter,rot,t);
function kreis(r=10,rand=+5,grad=360,grad2,fn=$fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0],z,d,endPoint=true,fs=$fs,fs2,fn2,minF=1,fa=$fa)=
let (
minF=bool(minF,bool=false),
grad2=is_undef(grad2)?grad:grad2,
r=is_num(d)?rcenter?(d+rand)/2:d/2:
            rcenter?r+rand/2:r,
rand2=is_undef(rand2)?rand:rand2,
r2=r2?
    rcenter?r2+rand2/2:r2
    :r,
ifn=is_num(fn)&&fn>0?max(1,ceil(abs(fn)))
                    :min(max(abs(grad)<180?1
                                       :abs(grad)==360?3
                                                      :2,ceil(abs(PI*r*2/360*grad/max(fs,0.001))),minF),round(abs(grad)/fa) ),
fs2=is_undef(fs2)?fs:fs2,
fn2=is_num(fn)&&fn>0?is_undef(fn2)?ifn:max(1,ceil(abs(fn2)))
                    :min(max(abs(grad2)<180?1:abs(grad2)==360?3:2,ceil(abs(PI*(r-rand)*2/360*grad2/max(fs2,0.001))),minF),round(grad/fa)),
step=grad/ifn,
step2=grad2/fn2,
t=is_list(t)?t:[t,0],
endPoint=rand?true:endPoint
)
is_num(z)?[
if(!sek&&!rand&&abs(grad)!=360&&grad)[0+t[0],0+t[1],z], // single points replacement
if(grad==0&&minF)for([0:minF])[sin(rot+(center?-grad/2-90:0))*r  +t[0],
     cos(rot+(center?-grad/2-90:0))*r2 +t[1],
     z],
if(grad)for(i=[0:endPoint?ifn:ifn-1])
        let(iw=abs(grad)==360?i%ifn:i)
    [sin(rot+(center?-grad/2-90:0)+iw*step)*r  +t[0],
     cos(rot+(center?-grad/2-90:0)+iw*step)*r2 +t[1],
     z],
if(rand)for(i=[0:endPoint?fn2:fn2 -1])
    let(iw=abs(grad2)==360?i%fn2:i)
    [sin(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r  -rand )+t[0],
     cos(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r2 -rand2)+t[1],
    z]
]:
[ // if TwoD
if(!sek&&!rand&&abs(grad)!=360&&grad||r==0)[0+t[0],0+t[1]], // single points replacement
if(r&&grad)for(i=[0:endPoint?ifn:ifn-1])
        let(iw=abs(grad)==360?i%ifn:i)
    [sin(rot+(center?-grad/2-90:0)+iw*step)*r+t[0],
    cos(rot+(center?-grad/2-90:0)+iw*step)*r2+t[1]],
if(grad==0&&minF)for([0:minF])[sin(rot+(center?-grad/2-90:0))*r  +t[0],
     cos(rot+(center?-grad/2-90:0))*r2 +t[1]],
if(rand)for(i=[0:endPoint?fn2:fn2-1])
    let(iw=abs(grad2)==360?i%fn2:i)
    [sin(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r-rand)+t[0],
    cos(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r2-rand2)+t[1]]
];
/**
\name SBogen
SBogen() creates an S-shape double counter arc between parallels
\param dist distance between verticals
\param r1 r2 radii
\param grad connecton angle
\param l1 l2 lower and upper length 
\param center center on x
\param fn,fs,fa  fraqments
\param messpunkt show arc center
\param TwoD make TwoD
\param extrude extrude in TwoD from x=0
\param grad2 angle endsection
\param x0 set x axis origin=0
\param lRef reference for l1 l2 0=center -1/1 lower/upper tangentP -2/2 tangent+grad2 -3/3 radius center
\param name help name help
\param lap overlap for 3D
*/
//SBogen(TwoD=true);
//SBogen(extrude=10, grad2=[26,-40]*1,r1=2,l1=20,lRef=+3,messpunkt=true);
module SBogen(dist=10,r1=10,r2,grad=45,l1=15,l2,center=1,fn,fs=$fs,fa=$fa,messpunkt=false,TwoD=0,extrude=false,grad2=0,x0=0,lRef=0,name,help,spiel,lap=0){
    lap=is_undef(spiel)?lap:spiel;
    center=is_bool(center)?center?1:0:sign(center);
    r2=is_undef(r2)?r1:r2;
    l2=is_undef(l2)?l1:l2;
    TwoD=is_parent(needs2D)&&!$children?TwoD?b(TwoD,false):
                                         1:
                                      b(TwoD,false);
// echo(parent_module(1),$parent_modules);
    grad2=is_list(grad2)?grad2:[grad2,grad2];
    extrudeTrue=extrude;
    extrude=is_bool(extrude)?0:extrude*sign(dist);
    gradN=grad; // detect negativ grad
    grad=abs(grad);// negativ grad done by mirror
    y=(grad>0?1:-1)*(abs(dist)/tan(grad)+r1*tan(grad/2)+r2*tan(grad/2));
    yRef=lRef?lRef>0?(lRef> 2?0: tan((grad- (lRef> 1?grad2[1]:0) )/2)*r2)-y/2 // move polygon circles to keep fixpoint according lRef
                    :(lRef<-2?0:-tan((grad- (lRef<-1?grad2[0]:0) )/2)*r1)+y/2
             :0;
    yrest=y-abs(sin(grad))*r1-abs(sin(grad))*r2;//y ohne Kreisstücke
    distrest=dist-r2-r1+cos(grad)*r1+cos(grad)*r2;//dist ohne Kreisstücke
    l2m=Hypotenuse(distrest,yrest)/2+minVal;// Mittelstück
    dist=grad>0?dist:-dist;
  $fn=fn;
  $fa=fa;
  $fs=fs;
  $idxON=false;
  $info=is_undef($info)?is_undef(name)?1:name:$info;
  grad2Y=[-l1+y/2-yRef+r1*sin(grad2[0]),l2-y/2-yRef-r2*sin(grad2[1])]; // Abstand Kreisende zu Punkt l1/l2
  grad2X=[r1-r1*cos(grad2[0])-tan(grad2[0])*grad2Y[0],-r2+r2*cos(grad2[1])-tan(grad2[1])*grad2Y[1]];// Versatz der Punkte durch grad2
  KreisCenterR1=[[-abs(dist)/2+extrude+r1,-y/2+yRef],[extrude+r1-abs(dist),-y/2-l2+yRef],[extrude+r1,-y/2+l1+yRef]];
  KreisCenterR2=[[abs(dist)/2+extrude-r2,y/2+yRef],[extrude-r2,y/2-l2+yRef],[abs(dist)+extrude-r2,y/2+l1+yRef]];
  selectKC=center?center>0?0:
                           1:
                  2;
  endPunkte=center?center==1?[extrude-abs(dist/2)+grad2X[0],extrude+abs(dist/2)+grad2X[1]]:[extrude-abs(dist)+grad2X[0],extrude+grad2X[1]]:[extrude+grad2X[0],extrude+abs(dist)+grad2X[1]];
    InfoTxt(parent_module(search(["Anschluss"],parentList(+0))[0]?
        search(["Anschluss"],parentList(+0,start=0))[0]:
        1)
        ,["ext",str(endPunkte[0],"/",endPunkte[1])," 2×=",str(2*endPunkte[0],"/",2*endPunkte[1]),"Kreiscenter",str(KreisCenterR1[selectKC],"/",KreisCenterR2[selectKC])
    ],name);
 if(grad&&!extrudeTrue)mirror(gradN<0?[1,0]:[0,0])translate(center?[0,0,0]:[dist/2,l1]){
    translate([dist/2,y/2,0])T(-r2)rotate(grad2[1])T(r2)Bogen(rad=r2,grad=grad+grad2[1],center=false,l1=l2-y/2,l2=l2m,help=0,name=0,messpunkt=messpunkt,TwoD=TwoD,fn=fn,fs=fs,d=TwoD,lap=lap)
    if($children){
      $idx=is_undef($idx)?0:$idx;
      $tab=is_undef($tab)?1:b($tab,false)+1;
      children();
    }
    else circle($fn=fn,$fs=fs);
  T(-dist/2,-y/2) mirror([1,0,0])rotate(180)T(r1)rotate(-grad2[0])T(-r1)Bogen(rad=r1,grad=-grad-grad2[0],center=false,l1=l1-y/2,l2=l2m,help=0,name=0,messpunkt=messpunkt,TwoD=TwoD,fn=fn,fs=fs,d=TwoD,lap=lap)
    if($children){
      $idx=1;
      children();
    }
    else circle($fn=fn,$fs=fs);
 }
 if(!grad&&!extrudeTrue) //0 grad Grade
     if(!TwoD)T(0,center?0:l1+l2)R(90)linear_extrude(l1+l2,convexity=5,center=center?true:false)
         if($children)children();
         else circle($fn=fn);
 else T(center?0:-TwoD/2) square([TwoD,l1+l2],center?true:false);
 if(extrudeTrue){
     points=center?center==1?concat(//center=1
     [[x0*sign(dist),l2]],[[extrude+abs(dist)/2+grad2X[1],l2+0]],
     kreis(r=-r2,rand=0,grad=abs(grad)+grad2[1],rot=-90-grad2[1],center=false,fn=fn,fs=fs,fa=fa,t=[abs(dist)/2+extrude-r2,y/2+yRef]), // ok
     kreis(r=-r1,rand=0,grad=-abs(grad)-grad2[0],fn=fn,fs=fs,fa=fa,rot=90+abs(grad),center=false,t=[-abs(dist)/2+extrude+r1,-y/2+yRef]),  // ok   
     [[extrude-abs(dist)/2+grad2X[0],-l1]],     
     [[x0*sign(dist),-l1]]
     ): concat(//center==-1||>1
     [[x0*sign(dist),0]],[[extrude+grad2X[1],0]],
     kreis(r=-r2,rand=0,grad=abs(grad)+grad2[1],rot=-90-grad2[1],center=false,fn=fn,fs=fs,fa=fa,t=[extrude-r2,y/2-l2+yRef]), // ok
     kreis(r=-r1,rand=0,grad=-abs(grad)-grad2[0],fn=fn,fs=fs,rot=90+abs(grad),center=false,t=[extrude+r1-abs(dist),-y/2-l2+yRef]),  // ok   
     [[extrude-abs(dist)+grad2X[0],-l2-l1]],     
     [[x0*sign(dist),-l2-l1]]     
     ):
     concat(//center==0
     [[x0*sign(dist),l2+l1]],[[extrude+abs(dist)+grad2X[1],l2+l1]],
     kreis(r=-r2,rand=0,grad=abs(grad)+grad2[1],rot=-90-grad2[1],center=false,fn=fn,fs=fs,fa=fa,t=[abs(dist)+extrude-r2,y/2+l1+yRef]), // ok
     kreis(r=-r1,rand=0,grad=-abs(grad)-grad2[0],fn=fn,fs=fs,fa=fa,rot=90+abs(grad),center=false,t=[extrude+r1,-y/2+l1+yRef]),  // ok   
     [[extrude+grad2X[0],0]],     
     [[x0*sign(dist),0]]     
     );
  if(dist>0&&gradN>0)  polygon(points,convexity=5);
  if(dist<0||gradN<0)mirror([1,0])  polygon(points,convexity=5);    
 }
 if(messpunkt&&is_num(extrude)){
     Pivot(KreisCenterR1[selectKC],messpunkt=messpunkt,active=[1,0,0,1]);
     Pivot(KreisCenterR2[selectKC],messpunkt=messpunkt,active=[1,0,0,1]);
 //echo(KreisCenterR1,KreisCenterR2);
 }
    //Warnings    
  Echo(str(name," SBogen has no TwoD-Object"),color=Hexstring([1,0.5,0]),size=4,condition=!$children&&!TwoD&&!extrudeTrue);
  Echo(str(name," SBogen width is determined by var TwoD=",TwoD,"mm"),color="info",size=4,condition=TwoD==1&&!extrudeTrue&&(is_undef($idx)||!$idx)&&$info);       
  Echo(str(name," SBogen r1/r2 to big  middle <0"),condition=l2m<0);
  Echo(str(name," SBogen radius 1 negative"),condition=r1<0);
  Echo(str(name," SBogen radius 2 negative"),condition=r2<0);    
  Echo(str(name," SBogen r1/r2 to big or angle or dist to short"),condition=grad!=0&&r1-cos(grad)*r1+r2-cos(grad)*r2>abs(dist));
  Echo(str(name," SBogen angle to small/ l1+l2 to short =",l1-y/2+yRef,"/",l2-y/2-yRef),condition=l1-y/2+yRef<0||l2-y/2-yRef<0);
   //Help    
  HelpTxt("SBogen",["dist",dist,"r1",r1,"r2",r2,"grad",grad,"l1",l1,"l2",l2,"center",center,"fn",fn,"messpunkt",messpunkt,"TwoD",TwoD,"extrude",extrude,"grad2",grad2,"x0",x0, "lRef", lRef, "lap",lap," ,name=",name],help); 
}
/** \name Bogen \page Objects
Bogen() creates a bended cylinder or children
\param grad angle
\param rad bend radius
\param l,l1,l2 straight length l⇒ [l1,l2]
\param fn fn2 fs fraqments
\param tcenter tangent
\param center centern
\param lap,spiel  overlap
\param d diameter (if no children)
\param messpunkt show bend center
\param TwoD  make TwoD
*/
//Bogen(TwoD=1,lap=+0,fn=0);
//Bogen();
module Bogen(grad=90,rad=5,l,l1=10,l2=12,fn=$fn,center=true,tcenter=false,name,d=3,fn2=0,fs=$fs,fa=$fa,lap=minVal,spiel,help,messpunkt=messpunkt,TwoD=false)
{
    $fn=fn;
    $fs=fs;
    $fa=fa;
    $helpM=0;
    $info=0;
    $idxON=false;
    ueberlapp=is_num(spiel)?-spiel:lap;
    l1=is_undef(l)?l1+ueberlapp:is_list(l)?l[0]+ueberlapp:l+ueberlapp;
    l2=is_undef(l)?l2+ueberlapp:is_list(l)?l[1]+ueberlapp:l+ueberlapp;
    TwoD=is_parent(needs2D)&&!$children?TwoD?b(TwoD,false):
                                       1:
                                    b(TwoD,false);
    c=sin(abs(grad)/2)*rad*2;//  Sekante 
    w1=abs(grad)/2;          //  Schenkelwinkel
    w3=180-abs(grad);        //  Scheitelwinkel
    a=(c/sin(w3/2))/2;    
    hc=grad!=180?Kathete(a,c/2):0;  // Sekante tangenten center
    hSek=Kathete(rad,c/2); //center Sekante
    bl=PI*rad/180*grad;//Bogenlänge
    mirror([grad<0?1:0,0,0])rotate(center?0:tcenter?-abs(grad)/2:+0)T(tcenter?grad>180?hSek+hc:-hSek-hc:0)rotate(tcenter?abs(grad)/2:0) T(center?0:tcenter?0:-rad){
    if(!TwoD) T(rad)R(+90,+0)Tz(-l1+ueberlapp){
      $idx=0;
      $tab=is_undef($tab)?1:b($tab,false)+1;
      color("green")   linear_extrude(l1,convexity=5)
            if ($children)mirror([grad<0?1:0,0,0])children();
            else circle(d=d,$fn=fn2);
     //color("lightgreen",.5)   T(0,0,l1)if(messpunkt&&$preview)R(0,-90,-90)Dreieck(h=l1,ha=pivotSize,grad=5,n=0);//Pivot(active=[1,1,1,0]);        
        }
    else T(rad)R(0,+0)T(0,-ueberlapp)color("green")T(-d/2)square([d,l1]);
    if(grad)if(!TwoD) rotate_extrude(angle=-abs(grad)-0,$fa = fn?abs(grad)/fn:fa, $fs = $fs,$fn=0,convexity=5)intersection(){
      $idx=1;
      $fn=fn;
      $fa=fa;
      T(rad)
            if ($children)mirror([grad<0?1:0,0,0])children();
                else circle(d=d,$fn=fn2); 
                translate([0,-500])square(1000);
            }
     else  Kreis(rand=d,grad=abs(grad),center=false,r=rad+d/2,fn=fn,fs=fs,name=0,help=0); 
     if (!TwoD)R(z=-abs(grad)-180) T(-rad,-ueberlapp)R(-90,180,0){
       $idx=2;
         color("darkorange")linear_extrude(l2,convexity=5)
            if ($children)mirror([grad<0?1:0,0,0])children();
            else circle(d=d,$fn=fn2);
         //color("orange",0.5)if(messpunkt&&$preview)T(0,0,l2)R(0,-90,-90)Dreieck(h=l2,ha=pivotSize,grad=5,n=0);//Pivot(active=[1,1,1,0]);   
        }
     else R(z=-abs(grad)-180) T(-rad,-ueberlapp) color("darkorange")T(-d/2)square([d,l2]);
    union(){//messpunkt
       color("yellow") Pivot(active=[1,0,0,1],messpunkt=messpunkt); 
       if(grad!=180)color("blue")mirror([0,grad<0?1:0,0]) translate(RotLang(90+grad/2,hc+hSek))Pivot(active=[1,0,0,1],messpunkt=messpunkt); 
       if(grad>180)color("lightblue")mirror([0,grad<0?1:0,0]) translate(RotLang(90+grad/2,-hc-hSek))Pivot(active=[1,0,0,1],messpunkt=messpunkt);     
    }  
    }
  if(name&&!$children)echo(str("»»» »»» ",name," Bogen ",grad,"° Durchmesser= ",d,"mm — Innenmaß= ",2*max(rad,d/2)-d,"mm Außenmaß= ",2*max(rad,d/2)+d));
  if(name)echo(str(name," Bogen ",grad,"° Radius=",rad,"mm Sekantenradius= ",hSek,"mm — Tangentenschnittpunkt=",hSek+hc,"mm TsSekhöhe=",hc,"mm Kreisstücklänge=",bl," inkl l=",bl+l1+l2,"mm"));
  if(!$children&&name&&!TwoD)Echo("Bogen missing Object! using circle",color="warning");
  HelpTxt("Bogen",["grad",grad,"rad",rad,"l",l,"l1",l1,"l2",l2,"fn",fn,"center",center,"tcenter",tcenter,"name",name,"d",d,"fn2",fn2,"fs",fs,"lap",lap,"messpunkt",messpunkt,"TwoD",TwoD],help);
}
/** \page Polygons
Kreis() creates a circle polygon
\name Kreis
\param r radius
\param dicke rim
\param grad angle
\param grad2 optional rim angle
\param fn fragments
\param center center (angle <360)
\param sek  secant or center point (angle <360)
\param r2  y radius for oval
\param rcenter rim center
\param rot rotate circle
\param t   translate circle
\param name name for circle
\param help help
\param d diameter optional to r = d↦r
\param id optional to dicke
\param b optional to grad, L of the circular arc
\param fs,fa fragment size optional to fn fs↦fn,min fraqment angle
*/
//Kreis(d=10,id=8,grad=270);
module Kreis(r=10,dicke=0,grad=360,grad2,fn,center=true,sek=false,r2=0,rand2,rcenter=0,rot=0,t=[0,0],name,help,d,b,fs=$fs,fa=$fa,rand,id){
    r=is_undef(d)?r:d/2;
    d=2*r;
    dicke=is_undef(rand)?is_undef(id)?dicke:(d-id)/2
                        :rand;
    grad=is_undef(b)?grad:r==0?0:b/(2*PI*r)*360;
    b=2*r*PI*grad/360;
   polygon( kreis(r=r,rand=dicke,grad=grad,grad2=grad2,fn=fn,center=center,sek=sek,r2=r2,rand2=rand2,rcenter=rcenter,rot=grad==360?center?rot:rot+90:center?rot+180:rot+90,t=t,fs=fn?undef:fs,endPoint=grad==360?false:true,fa=fa),convexity=5);
    HelpTxt("Kreis",["r",r,"dicke",dicke,"grad",grad,"grad2",grad2,"fn",fn,"center",center,"sek",sek,"r2",r2,"rand2",rand2,"rcenter",rcenter,"rot",rot,"t",t,"name",name,"d",d,", b",b,"id",id,"fs",fs],help);
    if(!rcenter){
      if(dicke>0)InfoTxt("Kreis",["id",2*(r-abs(dicke)),"od",2*r],name);
      if(dicke<0)InfoTxt("Kreis",["id",2*r,"od",2*(r+abs(dicke))],name); 
    }
    else if(dicke)InfoTxt("Kreis",["id",2*r-abs(dicke)," od=",2*r+abs(dicke)],name);   
}
/** \page Helper
Pivot() creates a pivot gizmo
* \name Pivot
* \brief creates a pivot gizmo
* \param p0  position of the Gizmo
* \param size size of the Gizmo
* \param active activate parts (center axis rotation text 
* \param messpunkt activates
* \param txt adds text
* \param rot rotates
* \param vpr orient text
* \param help activate help
*/
module Pivot(p0=[0,0,0],size,active=[1,1,1,1,1,1],messpunkt,txt,rot=0,vpr=$vpr,help=false){
  messpunkt=is_undef(messpunkt)?is_undef($messpunkt)?true:$messpunkt:messpunkt;
    p0=is_num(p0)?[p0,0]:p0;
    size=is_undef(size)?is_bool(messpunkt)?pivotSize:messpunkt:size;
    size2=size/+5;
  if(messpunkt&&$preview)translate(p0)%union(){
      if(active[3])rotate(rot)  color("blue")cylinder(size,d1=.5*size2,d2=0,center=false,$fn=4);
      if(active[2])rotate(rot)  color("green")rotate([-90,0,0])cylinder(size,d1=.5*size2,d2=0,center=false,$fn=4);
      if(active[1])rotate(rot)  color("red")rotate([0,90,0])cylinder(size,d1=.5*size2,d2=0,center=false,$fn=4);   
       if(active[0]) color("yellow")sphere(d=size2*.6,$fn=12);
       //Text
       if(active[4]) %color("grey")rotate(vpr)
          //linear_extrude(.1,$fn=1)
       text(text=str(norm(p0)?p0:""," ",rot?str(rot,"°"):"","   "),size=size2,halign="right",valign="top",font="Bahnschrift:style=light",$fn=1);    
       if(txt&&active[5])%color("lightgrey")rotate(vpr)translate([0,size/15])//linear_extrude(.1,$fn=1)
         Tz(0.1) text(text=str(txt,"   "),size=size2,font="Bahnschrift:style=light",halign="right",valign="bottom",$fn=1);
  }     
  HelpTxt("Pivot",[
     "p0",p0,
    "size",size,
    "active",active,
    "messpunkt",messpunkt,
    "txt",txt,
    "rot",rot,
    "vpr",vpr]
    ,help); 
}
// short for rotate(a,v=[0,0,0])
module R(x=0,y=0,z=0,help=false)
{
    rotate([x,y,z])children();
    MO(!$children);
    HelpTxt("R",["x",x,"y",y,"z",z],help);
}
//CombinedEnd from path ub_sbogen.scad
//Combined from path module_utility_wallcutout.scad


iwalcutoutconfig_type = 0;
iwalcutoutconfig_position = 1;
iwalcutoutconfig_width = 2;
iwalcutoutconfig_angle = 3;
iwalcutoutconfig_height = 4;
iwalcutoutconfig_cornerradius = 5;
function WallCutoutSettings(
    type = "disabled", 
    position = 0, 
    width = 0,
    angle = 0,
    height = 0, 
    corner_radius = 0) = 
  let(
    result = [
      type,
      position,
      width,
      angle,
      height,
      corner_radius],
    validatedResult = ValidateWallCutoutSettings(result)
  ) validatedResult;
function ValidateWallCutoutSettings(settings) =
  assert(is_list(settings), "Settings must be a list")
  assert(len(settings)==6, "Settings must length 6")
  assert(is_string(settings[iwalcutoutconfig_type]), "type must be a string")
  assert(is_num(settings[iwalcutoutconfig_position]) || is_list(settings[iwalcutoutconfig_position]), "position must be a list or number")
  assert(is_num(settings[iwalcutoutconfig_width]), "width must be a number")
  assert(is_num(settings[iwalcutoutconfig_angle]), "angle must be a number")
  assert(is_num(settings[iwalcutoutconfig_height]), "height must be a number")
  assert(is_num(settings[iwalcutoutconfig_cornerradius]), "corner radius must be a number")
  [
    settings[iwalcutoutconfig_type],
    is_num(settings[iwalcutoutconfig_position]) ? [settings[iwalcutoutconfig_position]] : settings[iwalcutoutconfig_position],
    settings[iwalcutoutconfig_width],
    settings[iwalcutoutconfig_angle],
    settings[iwalcutoutconfig_height],
    settings[iwalcutoutconfig_cornerradius]
  ];
iwalcutout_config = 0;
iwalcutout_enabled = 1;
iwalcutout_position = 2;
iwalcutout_size = 3;
iwalcutout_rotation = 4;
iwalcutout_reposition = 5;
function calculateWallCutouts(
  wall_length,
  opposite_wall_distance,
  wallcutout_settings,
  wallcutout_rotation = [0,0,0],
  wallcutout_reposition = [0,0,0],
  wall_thickness,
  cavityFloorRadius,
  wallTop,
  z_point,
  floorHeight,
  pitch,
  pitch_opposite) =
    let(wallcutout_positions = wallcutout_settings[iwalcutoutconfig_position])
    [for (i = [0:len(wallcutout_positions)-1])
      calculateWallCutout(
        wall_length = wall_length,
        opposite_wall_distance = opposite_wall_distance,
        wallcutout_settings = wallcutout_settings,
        wallcutout_position = wallcutout_positions[i],
        wallcutout_rotation = wallcutout_rotation,
        wallcutout_reposition = wallcutout_reposition,
        wall_thickness = wall_thickness,
        cavityFloorRadius = cavityFloorRadius,
        wallTop = wallTop,
        z_point = z_point,
        floorHeight = floorHeight,
        pitch = pitch,
        pitch_opposite = pitch_opposite)];
function calculateWallCutout(
  wall_length,
  opposite_wall_distance,
  wallcutout_settings,
  wallcutout_position,
  wallcutout_rotation = [0,0,0],
  wallcutout_reposition = [0,0,0],
  wall_thickness,
  cavityFloorRadius,
  wallTop,
  z_point,
  floorHeight,
  pitch,
  pitch_opposite) =
     let(
        wallcutout_type = wallcutout_settings[iwalcutoutconfig_type],
        wallcutout_width = wallcutout_settings[iwalcutoutconfig_width],
        wallcutout_angle = wallcutout_settings[iwalcutoutconfig_angle],
        wallcutout_height = wallcutout_settings[iwalcutoutconfig_height],
        wallcutout_corner_radius = wallcutout_settings[iwalcutoutconfig_cornerradius],
        is_enabled = wallcutout_position <= -1 || wallcutout_position >= 0,
        max_height = wallcutout_type == "inneronly" ? z_point : wallTop,
        fullEnabled = wallcutout_type == "enabled",
        innerEnabled = wallcutout_type == "inneronly",
        closeEnabled = wallcutout_type == "wallsonly" || wallcutout_type == "leftonly" || wallcutout_type == "frontonly",
        farEnabled = wallcutout_type == "wallsonly" || wallcutout_type == "rightonly" || wallcutout_type == "backonly",
        wallcutoutThickness = wall_thickness*2+max(wall_thickness*2,cavityFloorRadius), //wall_thickness*2 should be lip thickness
        wallcutoutHeight = wallcutout_height < 0 
            ? (max_height - floorHeight)/abs(wallcutout_height)
            : wallcutout_height == 0 ? max_height - floorHeight - cavityFloorRadius
            : wallcutout_height,
        wallcutoutLowerWidth=wallcutout_width <= 0 ? max(wallcutout_corner_radius*2, wall_length*pitch/3) : wallcutout_width,
        closeThickness = 
          fullEnabled ? opposite_wall_distance*pitch_opposite 
          : innerEnabled ? opposite_wall_distance*pitch_opposite - wallcutoutThickness*2 
          : wallcutoutThickness,
        clearance = env_clearance().x, //This should take in to account if its x or y, but for now we assume they are the same.
        closePosition = 
          innerEnabled ? closeThickness/2+clearance/2+wallcutoutThickness
          : closeThickness/2+clearance/2-fudgeFactor,
      //This could be more specific based on the base height, and the lip style.
      wallcutout_close = [
          //walcutout_config
          [wallcutout_type, wallcutout_position, wallcutout_width, wallcutout_angle, wallcutout_height, wallcutout_corner_radius],
          //walcutout_enabled
          is_enabled && (closeEnabled || fullEnabled || innerEnabled),
          //wallcutout_position
          [wallCutoutPosition_mm(wallcutout_position,wall_length,pitch), closePosition, max_height],
          //wallcutout_size
          [wallcutoutLowerWidth, closeThickness, wallcutoutHeight],
          //wallcutout_rotation
          wallcutout_rotation,
          //wallcutout_reposition
          wallcutout_reposition],
      wallcutout_far = [
          //walcutout_config
          [wallcutout_type, wallcutout_position, wallcutout_width, wallcutout_angle, wallcutout_height, wallcutout_corner_radius],
          //walcutout_enabled
          is_enabled && farEnabled,
          //wallcutout_position
          [wallCutoutPosition_mm(wallcutout_position,wall_length,pitch), opposite_wall_distance*pitch_opposite-wallcutoutThickness/2-clearance/2+fudgeFactor, max_height],
          //wallcutout_size
          [wallcutoutLowerWidth, wallcutoutThickness, wallcutoutHeight],
          //wallcutout_rotation
          wallcutout_rotation,
          //wallcutout_reposition
          wallcutout_reposition]) [wallcutout_close, wallcutout_far];
module WallCutout(
  lowerWidth=50,
  wallAngle=70,
  height=21,
  thickness=10,
  cornerRadius=5,
  topHeight) {
  topHeight = is_undef(topHeight) || topHeight < 0 ? cornerRadius*4 : topHeight;
  bottomWidth = lowerWidth;
  topWidth = lowerWidth+(height/tan(wallAngle))*2;
  rotate([90,0,0])
  translate([0,0,-thickness/2])
  linear_extrude(height=thickness)
  intersection(){
    translate([0,-height/2+topHeight/2,0])
    square([topWidth+cornerRadius*2,height+topHeight], true);
    //Use triple offset to fillet corners
    //https://www.reddit.com/r/openscad/comments/ut1n7t/quick_tip_simple_fillet_for_2d_shapes/
    offset(r=-cornerRadius)
    offset(r=2 * cornerRadius)
    offset(r=-cornerRadius)
    union(){
      translate([0,cornerRadius*4/2])
      square([topWidth*2,cornerRadius*4], true);
      hull(){
        translate([0,cornerRadius*4/2])
        square([topWidth,cornerRadius*4], true);
        translate([0,-height/2])
        square([bottomWidth,height], true);
      }
    }
  }
}
//CombinedEnd from path module_utility_wallcutout.scad
//Combined from path functions_general.scad



function sum(list, c = 0, end) = 
  let(end = is_undef(end) ? len(list) : end)
  c < 0 || end < 0 ? 0 : 
  c < len(list) - 1 && c < end
    ? list[c] + sum(list, c + 1, end=end) 
    : list[c];
function vector_sum(v, start=0, end, itemIndex) = 
  let(v=is_list(v)?v:[v], end = is_undef(end)?len(v)-1:min(len(v)-1,end))
  is_num(itemIndex) 
    ? start<end ? v[start][itemIndex] + vector_sum(v, start+1, end, itemIndex) : v[start][itemIndex]
    : start<end ? v[start] + vector_sum(v, start+1, end, itemIndex) : v[start];    
//round a number to a decimal with a defined number of significant figures
function roundtoDecimal(value, sigFigs = 0) = 
  assert(is_num(value), "value must be a number")
  assert(is_num(sigFigs) && sigFigs >= 0, "sigFigs must be a number")
  let(
    sigFigs = round(sigFigs),
    factor = 10^round(sigFigs))
    sigFigs == 0 
      ? round(value) 
      : round(value*factor)/factor;
function DictGet(list, key, alert=false) = 
  let(matchResults = search([key],list,1),
    matchIndex = is_list(matchResults) && len(matchResults)==1 && is_num(matchResults[0]) ? matchResults[0]: undef,
    alertMessage = str("count not find key in list key:'", key, "' matchResults:'", matchResults, "' matchIndex:'", matchIndex),
    matchValue = is_num(matchIndex) ? list[matchIndex] : undef,
    x = !alert && is_undef(matchValue) ? echo(alertMessage) : 1)
    assert(!alert || !is_undef(matchValue), alertMessage)
      matchValue[1];
function DictSetRange(list, keyValueArray) = !(len(keyValueArray)>0) ? list : 
  assert(is_list(list), str("DictSetRange(keyValueArray, arr) - arr is not a list. list:",list))
  assert(is_list(keyValueArray), str("DictSetRange(keyValueArray, arr) - keyValueArray is not a list. keyValueArray:", keyValueArray))
  let(currentKeyValue = keyValueArray[0])
  assert(is_list(currentKeyValue), str("DictSetRange(keyValueArray, arr) - currentKeyValue is not a list. currentKeyValue:",currentKeyValue))
  assert(len(currentKeyValue)==2, str("DictSetRange(keyValueArray, arr) - currentKeyValue is not length of 2. currentKeyValue:",currentKeyValue))
  assert(is_string(currentKeyValue[0]), str("DictSetRange(keyValueArray, arr) - currentKeyValue[0] is not a string, currentKeyValue:",currentKeyValue))
  let(keyValueArrayNext = remove_item(keyValueArray,0),
    updatedList = DictSet(list, currentKeyValue)
  ) concat(DictSetRange(updatedList, keyValueArrayNext));
function DictSet(list, keyValue) = 
  assert(is_list(list), str("DictSet(keyValueArray, arr) - arr is not a list list:", list))
  assert(is_list(keyValue), str("DictSet(keyValueArray, arr) - keyValueArray is not a list. keyValue:",keyValue))
  assert(len(keyValue)==2, str("DictSet(keyValueArray, arr) - keyValueArray is not a list. keyValue:",keyValue))
  let(matchResults = search([keyValue[0]],list,1),
    matchIndex = is_list(matchResults) && len(matchResults)==1 && is_num(matchResults[0]) ? matchResults[0] : undef)
  assert(!is_undef(matchIndex), str("count not find key in list, key:'", keyValue[0], "'", DictToString(list)))
    replace(list, matchIndex, keyValue);
module DictDisplay(list, name = ""){
  echo(DictToString(list=list,name=name));
}
function DictToString(list, name = "") =
  let(infoText=[for(i=[0:len(list)-1])str(list[i][0],"=",list[i][1])])
  str("🟧", name, concatstringarray(infoText));
function concatstringarray(in, out="",pos=0, sep="\r\n  ") = pos>=len(in)?out:
  concatstringarray(in=in,out=str(out,sep,in[pos]),pos=pos +1); 
//Replace multiple values in an array
function replace_Items(keyValueArray, arr) = !(len(keyValueArray)>0) ? arr : 
  assert(is_list(arr), "replace_Items(keyValueArray, arr) - arr is not a list")
  assert(is_list(keyValueArray), "replace_Items(keyValueArray, arr) - keyValueArray is not a list")
  let(currentKeyValue = keyValueArray[0])
  assert(is_list(currentKeyValue), "replace_Items(keyValueArray, arr) - currentKeyValue is not a list")
  assert(is_num(currentKeyValue[0]), "replace_Items(keyValueArray, arr) - currentKeyValue[0] is not a number")
  let(keyValueArrayNext = remove_item(keyValueArray,0),
    updatedList = replace(arr, currentKeyValue[0],currentKeyValue[1])
) concat(replace_Items(keyValueArrayNext, updatedList));
//Replace a value in an array
function replace(list,position,value) = 
  assert(is_list(list), "replace(list,position,value) - list is not a list")
  assert(is_num(position), "replace(list,position,value) - position is not a number")
  let (
    l1 = position > 0 ? partial(list,start=0,end=position-1) : [], 
    l2 = position < len(list)-1 ? partial(list,start=position+1,end=len(list)-1) :[]
  ) concat(l1,[value],l2);
// takes part of an array
function partial(list,start,end) = [for (i = [start:end]) list[i]];
//Removes item from an array
function remove_item(list,position) = [for (i = [0:len(list)-1]) if (i != position) list[i]];
//Takes a string and converts it in to an array of arrays.
//I.E.  "0, 0, 0.5, 3, 2, 6|0.5, 0, 0.5, 3,2, 6|1, 0, 3, 1.5|1, 1.5, 3, 1.5";
//becomes  [[0, 0, 0.5, 3, 2, 6], [0.5, 0, 0.5, 3, 2, 6], [1, 0, 3, 1.5], [1, 1.5, 3, 1.5]]
function splitCustomConfig(customConfig) = let(
  compartments = split(customConfig, "|")
) [for (x =[0:1:len(compartments)-1]) csv_parse(compartments[x])];
/*
U+1F7E5 🟥 LARGE RED SQUARE
U+1F7E6 🟦 LARGE BLUE SQUARE
U+1F7E7 🟧 LARGE ORANGE SQUARE
U+1F7E8 🟨 LARGE YELLOW SQUARE
U+1F7E9 🟩 LARGE GREEN SQUARE
U+1F7EA 🟪 LARGE PURPLE SQUARE
U+1F7EB 🟫 LARGE BROWN SQUARE
U+2B1B ⬛ BLACK LARGE SQUARE
U+2B1C ⬜ WHITE LARGE SQUARE
*/
function outputCustomConfig(typecode, arr) = let(
  config = createCustomConfig(arr),
  dynamicConfig = str("\"", typecode,"\"", ",", config)
) str("🟦 Generating 'tray' config, to be used in custom config.\r\nLocal Config\r\n\t", config, "\r\nDynamic Config\r\n\t", dynamicConfig,"\r\n");
function createCustomConfig(arr, pos=0, sep = ",") = pos >= len(arr) ? "" :
  let(
    current = is_list(arr[pos]) ? createCustomConfig(arr[pos], sep=";") 
      : is_string(arr[pos]) ? str("\"",arr[pos],"\"")
      : arr[pos],
    strNext = createCustomConfig(arr, pos+1, sep)
  ) str(current, strNext!=""?str(sep, strNext):"");
module assert_openscad_version(){
  assert(version()[0]>2022,"Gridfinity Extended requires an OpenSCAD version greater than 2022 https://openscad.org/downloads. Use Development Snapshots if the release version is still 2021.01 https://openscad.org/downloads.html#snapshots.");
}
// Gets one value base on another.
// if user_value = 0 use the base value
// user_value > 0 use that value
// user_value < 0 base_value/abs(user_value) (i.e. -3 is 1/3 the base_value)
function get_related_value(user_value, base_value, default_value, max_value) = 
  let(
      max_value = is_undef(max_value) ? base_value : max_value,
      default = is_undef(default_value) ? base_value : default_value,
      calculated = user_value == 0 ? default :
      user_value < 0 ? base_value/abs(user_value) : user_value)
      min(calculated, max_value);
module highlight_conditional(enable=false){
  if(enable)
    #children();
  else
    children();
}
function color_from_list(index) = 
let(
  colours = ["white","red","blue","Green","pink","orange","purple","black", "Coral", "Gray", "Teal"],
  mod_index = index%len(colours)
) colours[mod_index];
module color_conditional(enable=true, c, alpha = 1){
  if(enable)
  color(c, alpha)
    children();
  else
    children();
}
module exclusive_conditional(enable=true){
  if(enable)
    !children();
  else
    children();
}
module render_conditional(enable=true){
  if(enable)
    render()
      children();
  else
    union()
      children();
}
module hull_conditional(enabled = true)
{
  if(enabled){
    hull(){
      children();
    }
  }
  else{
    union(){
      children();
    }
  }
}
//CombinedEnd from path functions_general.scad
//Combined from path functions_string.scad


// String functions found here https://github.com/thehans/funcutils/blob/master/string.scad
join = function (l,delimiter="") 
  let(s = len(l), d = delimiter,
      jb = function (b,e) let(s = e-b, m = floor(b+s/2)) // join binary
        s > 2 ? str(jb(b,m), jb(m,e)) : s == 2 ? str(l[b],l[b+1]) : l[b],
      jd = function (b,e) let(s = e-b, m = floor(b+s/2))  // join delimiter
        s > 2 ? str(jd(b,m), d, jd(m,e)) : s == 2 ? str(l[b],d,l[b+1]) : l[b])
  s > 0 ? (d=="" ? jb(0,s) : jd(0,s)) : "";
substr = function(s,b,e) let(e=is_undef(e) || e > len(s) ? len(s) : e) (b==e) ? "" : join([for(i=[b:1:e-1]) s[i] ]);
split = function(s,separator=" ") separator=="" ? [for(i=[0:1:len(s)-1]) s[i]] :
  let(t=separator, e=len(s), f=len(t),
    _s=function(b,c,d,r) b<e ?
      (s[b]==t[c] ?
        (c+1 == f ?
          _s(b+1,0,b+1,concat(r,substr(s,d,b-c))) : // full separator match, concat substr to result
          _s(b+1,c+1,d,r) ) : // separator match char, more to test
        _s(b-c+1,0,d,r) ) : // separator mismatch
      concat(r,substr(s,d,e))) // end of input string, return result
  _s(0,0,0,[]);
fixed = function(x,w,p,sp="0")
  assert(len(sp)==1)
  let(mult = pow(10,p), x2 = round(x*mult)/mult,
    lz = function (x, l) l>1 && abs(x) < pow(10,l-1) ? str(sp, lz(x,l-1)) : "",
    tz = function (x, t) let(mult=pow(10,t-1)) t>0 && abs(floor(x*mult)-x*mult) < 1e-9 ? str(sp, tz(x,t-1)) : ""
  )
  str(x2<0?"-":" ", lz(x2,w-p-2), abs(x2), abs(floor(x)-x2)<1e-9 ? "." : "" ,tz(x2,p));
float = function(s) let(
    _f = function(s, i, x, vM, dM, ddM, m)
      i >= len(s) ? round(x*dM)/dM :
      let(
        d = ord(s[i])
      )
      (d == 32 && m == 0) || (d == 43 && (m == 0 || m == 2)) ?
        _f(s, i+1, x, vM, dM, ddM, m) :
      d == 45 && (m == 0 || m == 2) ?
        _f(s, i+1, x, vM, -dM, ddM, floor(m/2)+1) :
      d >= 48 && d <= 57 ?
        _f(s, i+1, x*vM + (d-48)/dM, vM, dM*ddM, ddM, floor(m/2)+1) :
      d == 46 && m<=1 ? _f(s, i+1, x, 1, 10*dM, 10, max(m, 1)) :
      (d == 69 || d == 101) && m==1 ? let(
          expon = _f(s, i+1, 0, 10, 1, 1, 2)
        )
        (is_undef(expon) ? undef : expon >= 0 ?
          (round(x*dM)*(10^expon/dM)) :
          (round(x*dM)/dM)/10^(-expon)) :
      undef
  )
  _f(s, 0, 0, 10, 1, 1, 0);
csv_parse = function(s) [for (e=split(s, ",")) float(e)];
//CombinedEnd from path functions_string.scad
//Combined from path functions_environment.scad





//Set up the Environment, if not run object should still render using defaults
module set_environment(
  width,
  depth,
  height = 0,
  height_includes_lip = false,
  lip_enabled = false,
  clearance = [0.5, 0.5, 0],
  setColour = "preview",
  help = false,
  render_position = "center", //[default,center,zero]
  cut = [0,0,0],
  pitch = [gf_pitch, gf_pitch, gf_zpitch],
  corner_radius = gf_cup_corner_radius,
  randomSeed = 0,
  force_render = true,
  generate_filter = ""){
  //Set special variables, that child modules can use
  $pitch = pitch;
  $setColour = setColour;
  $showHelp = help;
  $randomSeed = randomSeed;
  $forceRender = force_render;
  $clearance = clearance;
  $corner_radius = corner_radius;
  $user_width = width;
  $user_depth = depth;
  $user_height = height;
  $generate_filter = generate_filter;
  num_x = calcDimensionWidth(width, true); 
  num_y = calcDimensionDepth(depth, true); 
  num_z = 
    let(z_temp = calcDimensionHeight(height, true)) 
    height_includes_lip && lip_enabled ? z_temp - gf_Lip_Height/pitch.z : z_temp;
  $num_x = num_x; 
  $num_y = num_y; 
  $num_z = num_z; 
  $cutx = calcDimensionWidth(cut.x);
  $cuty = calcDimensionWidth(cut.y);
  $cutz = calcDimensionWidth(cut.z);
  echo("🟩set_environment", fs=$fs, fa=$fa, fn=$fn,  clearance=clearance, corner_radius=corner_radius, height_includes_lip=height_includes_lip, lip_enabled=lip_enabled);
  echo("🟩set_environment", width=width, depth=depth, height=height, pitch=pitch);
  echo("🟩set_environment", num_x=num_x, num_y=num_y, num_z=num_z);
  //Position the object
  translate(gridfinityRenderPosition(render_position,num_x,num_y))
  union(){
    difference(){
      //Render the object
      children(0);
      //Render the cut, used for debugging
      /*
      if(cutx > 0 && cutz > 0 && $preview){
        color(color_cut)
        translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
          cube([env_pitch().x*cutx,num_y*env_pitch().y+fudgeFactor*2,(cutz+1)*env_pitch().z]);
      }
      if(cuty > 0 && cutz > 0 && $preview){
        color(color_cut)
        translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
          cube([num_x*env_pitch().x+fudgeFactor*2,env_pitch().y*cuty,(cutz+1)*env_pitch().z]);
      }*/
    }
    //children(1);
  }
}
function env_numx() = is_undef($num_x) || !is_num($num_x) ? 0 : $num_x;
function env_numy() = is_undef($num_y) || !is_num($num_y) ? 0 : $num_y;
function env_numz() = is_undef($num_z) || !is_num($num_z) ? 0 : $num_z;
function env_clearance() = is_undef($clearance) || !is_list($clearance) ? [0,0,0] : $clearance;
function env_generate_filter() = (is_undef($generate_filter) || !is_string($generate_filter)) ? "" : $generate_filter;
function env_pitch() =  is_undef($pitch) || !is_list($pitch) ? [gf_pitch, gf_pitch, gf_zpitch] : $pitch; 
function env_corner_radius() =  is_undef($corner_radius) || !is_num($corner_radius) ? gf_cup_corner_radius : $corner_radius; 
function env_cutx() = is_undef($cutx) || !is_num($cutx) ? 0 : $cutx;
function env_cuty() = is_undef($cuty) || !is_num($cuty) ? 0 : $cuty;
function env_cutz() = is_undef($cutz) || !is_num($cutz) ? 0 : $cutz;
function env_random_seed() = is_undef($randomSeed) || !is_num($randomSeed) || $randomSeed == 0 ? undef : $randomSeed;
function env_force_render() = is_undef($forceRender) ? true : $forceRender;
//set_colour = "preview"; //[disabled, preview, lip]
function env_colour(colour, isLip = false, fallBack = color_cup) = 
    is_undef($setColour) 
      ? $preview ? colour : fallBack
      : is_string($setColour) 
        ? $setColour == "enable" ? colour
        : $setColour == "preview" && $preview ? colour
          : $setColour == "lip" && isLip ? colour
            : fallBack
          : fallBack;
function env_generate_filter_enabled(filter) = 
  echo("env_generate_filter_enabled", filter=filter, env_generate_filter=env_generate_filter())
  env_generate_filter() == filter || 
  env_generate_filter() == "" || 
  env_generate_filter() == "everything" || 
  is_undef(env_generate_filter());
function env_help_enabled(level) = 
  is_string(level) && level == "force" ? true
    : is_undef($showHelp) ? false
      : is_bool($showHelp) ? $showHelp
        : is_string($showHelp) 
          ? $showHelp == "info" && level == "info" ? true
            : $showHelp == "debug" && (level == "info" || level == "debug") ? true
            : $showHelp == "trace" && (level == "info" || level == "debug" || level == "trace") ? true
            : false
          : false;
//CombinedEnd from path functions_environment.scad
//Combined from path functions_gridfinity.scad





// set this to produce sharp corners on baseplates and bins
// not for general use (breaks compatibility) but may be useful for special cases
sharp_corners = 0;
function calcDimensionWidth(width, shouldLog = false) = calcDimension(width, "width", env_pitch().x, shouldLog);
function calcDimensionDepth(depth, shouldLog = false) = calcDimension(depth, "depth", env_pitch().y, shouldLog);
function calcDimensionHeight(height, shouldLog = false) = calcDimension(height, "height", env_pitch().z, shouldLog); 
function calcDimension(value, name, unitSize, shouldLog) = 
  is_num(value) ? 
    (shouldLog ? echo(str("🟩",name,": ", value, "gf (",value*unitSize,"mm)"), input=value) value : value)
  : assert(is_list(value) && len(value) == 2, str(unitSize ," should be array of length 2"))
    let(calcUnits = value[1] != 0 ? value[1]/unitSize : value[0],
    roundedCalcUnits = roundtoDecimal(calcUnits,4))
    (shouldLog ? echo(str("🟩",name,": ", calcUnits, "gf (",calcUnits*unitSize,"mm)"), input=value, roundedCalcUnits=roundedCalcUnits) roundedCalcUnits: roundedCalcUnits);
constTopHeight = let(fudgeFactor = 0.01) 5.7+fudgeFactor*5; //Need to confirm this
//returns unit position to mm.
//positive values are in units.
//negative values are ration total/abs(value)
function wallCutoutPosition_mm(userPosition, wallLength, pitch) = unitPositionTo_mm(userPosition, wallLength, pitch);
function unitPositionTo_mm(userPosition, wallLength, pitch) = 
  assert(is_num(userPosition), "userPosition must be a number")
  assert(is_num(wallLength), "wallLength must be a number")
  assert(is_num(pitch), "pitch must be a number")
  (userPosition < 0 ? wallLength*pitch/abs(userPosition) : pitch*userPosition);
//0.6 is needed to align the top of the cutout, need to fix this
function calculateWallTop(num_z, lip_style) =
  //env_pitch().z * num_z + (lip_style != "none" ? gf_Lip_Height-0.6 : 0);
  env_pitch().z * num_z + (lip_style != "none" ? gf_Lip_Height : 0);
  //calculates the magent position in from the center of the pitch in a single dimention
function calculateAttachmentPosition(magnet_diameter=0, screw_diameter=0, pitch = env_pitch().x) = 
  assert(is_num(magnet_diameter) && magnet_diameter >= 0, "magnet_diameter must be a non-negative number")
  assert(is_num(screw_diameter) && screw_diameter >= 0, "screw_diameter must be a non-negative number")
  assert(is_num(pitch) && pitch >= 0, "pitch must be a non-negative number")
  let(attachment_diameter = max(magnet_diameter, screw_diameter))
  attachment_diameter == 0 
    ? 0
    : min(pitch/2-8, pitch/2-4-attachment_diameter/2);
//calculates the magent position in from the center of the pitch in a both x and y dimention
function calculateAttachmentPositions(magnet_diameter=0, screw_diameter=0, pitch = env_pitch()) = 
  assert(is_num(magnet_diameter) && magnet_diameter >= 0, "magnet_diameter must be a non-negative number")
  assert(is_num(screw_diameter) && screw_diameter >= 0, "screw_diameter must be a non-negative number")
  assert(is_list(pitch) && len(pitch) == 3, "pitch must be a list of three numbers")
  [calculateAttachmentPosition(magnet_diameter, screw_diameter, pitch.x),
  calculateAttachmentPosition(magnet_diameter, screw_diameter, pitch.y)];
//zpos from 0 for wall pattern to clear. outer walls and dividers use this
function wallpatternClearanceHeight(magnet_depth, screw_depth, center_magnet, floor_thickness, num_z=1, filled_in="disabled", efficient_floor, flat_base, floor_inner_radius, outer_cup_radius) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_num(floor_thickness))
  assert(is_num(num_z))
  assert(is_string(filled_in)) 
  assert(is_string(efficient_floor)) 
  assert(is_string(flat_base))
  assert(is_num(floor_inner_radius))
  assert(is_num(outer_cup_radius))
  let(cfh = calculateFloorHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor=efficient_floor, flat_base=flat_base),
      cbch = cupBaseClearanceHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, center_magnet=center_magnet, flat_base=flat_base),
      _floor_inner_radius = efficient_floor == FlatBase_off ? floor_inner_radius : 0,
      result = max(
        (efficient_floor == EfficientFloor_off ? cfh+floor_inner_radius : 5.3), //5.3 clears the inner radius of smooth
        (flat_base == FlatBase_gridfinity ? cfh + _floor_inner_radius : 0),
        (flat_base == FlatBase_rounded ? max(outer_cup_radius, _floor_inner_radius+floor_thickness) : 0)))
      env_help_enabled("trace") ? echo("wallpatternClearanceHeight", result=result, cbch=cbch, magnet_depth=magnet_depth, screw_depth=screw_depth, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor=efficient_floor, flat_base=flat_base) result : result;
function calculateCavityFloorRadius(cavity_floor_radius, wall_thickness, efficientFloor) = let(
  q = 1.65 - wall_thickness + 0.95 // default 1.65 corresponds to wall thickness of 0.95
  //efficient floor has an effective radius of 0
) efficientFloor != "off" ? 0 
  : cavity_floor_radius >= 0 ? min((2.3+2*q)/2, cavity_floor_radius) : (2.3+2*q)/2;
//Height to clear the voids in the base (attachments and inner grid).
function cupBaseClearanceHeight(magnet_depth, screw_depth, center_magnet, flat_base=FlatBase_off) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_string(flat_base))
  flat_base == FlatBase_rounded ? max(magnet_depth, screw_depth) //todo should consider rounded radius.
    : flat_base == FlatBase_gridfinity ? max(gf_base_grid_clearance_height, magnet_depth, screw_depth) //3.5 clears the side stacking indents
    : max(magnet_depth, screw_depth, gfBaseHeight());
//Height of base including the floor.
function calculateFloorHeight(magnet_depth, screw_depth, center_magnet=0, floor_thickness, num_z=1, filled_in="disabled", efficient_floor, flat_base, captive_magnet_height=0) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_num(floor_thickness))
  assert(is_num(num_z))
  assert(is_string(filled_in))
  assert(is_string(efficient_floor))
  assert(is_string(flat_base))
  assert(is_num(captive_magnet_height))
  let(
    filled_in = validateFilledIn(filled_in),
    floorThickness = max(floor_thickness, gf_cup_floor_thickness),
    clearanceHeight = cupBaseClearanceHeight(magnet_depth=magnet_depth + captive_magnet_height, screw_depth=screw_depth, center_magnet=center_magnet, flat_base=flat_base), 
    result = 
      filled_in != FilledIn_disabled ? num_z * env_pitch().z 
        : efficient_floor != "off" 
          ? floorThickness
          : max(0, clearanceHeight + floorThickness))
  env_help_enabled("trace") ? echo("calculateFloorHeight", result=result, magnet_depth=magnet_depth, screw_depth=screw_depth, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor=efficient_floor, flat_base=flat_base) result : result;
//Usable floor depth (floor height - height of voids)
//used in the item holder
function calculateUsableFloorThickness(magnet_depth, screw_depth, center_magnet=0,floor_thickness, num_z, filled_in, flat_base=FlatBase_off) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_num(floor_thickness))
  assert(is_num(num_z))
  assert(is_string(filled_in))
  assert(is_string(flat_base))
  let(
    cfh = calculateFloorHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, center_magnet=center_magnet, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor="off", flat_base=flat_base),
    cbch = cupBaseClearanceHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, center_magnet=center_magnet, flat_base=flat_base),
    usableFloorThickness = cfh - cbch)
  env_help_enabled("trace") ? 
  echo("calculateFloorThickness", usableFloorThickness=usableFloorThickness, cfh=cfh, cbch=cbch, num_z=num_z, magnet_depth=magnet_depth,screw_depth=screw_depth, floor_thickness=floor_thickness, filledin=filledin) usableFloorThickness :
  usableFloorThickness;
function gridfinityRenderPosition(position, num_x, num_y) = 
    position == "center" ? [-(num_x)*env_pitch().x/2, -(num_y)*env_pitch().y/2, 0] 
    : position == "zero" ? [0, 0, 0] 
    : [-env_pitch().x/2, -env_pitch().y/2, 0]; 
//wall_thickness default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm) 
function wallThickness(wall_thickness, num_z) = wall_thickness != 0 ? wall_thickness
        : num_z < 6 ? 0.95
        : num_z < 12 ? 1.2
        : 1.6;
/* Data types */
function list_contains(list,value,index=0) = 
  assert(is_list(list), "list must be a list")
  assert(index >= 0 && index < len(list), str("List does not contain value '", value, "'index is invalid len '" , len(list) , "' index '", index, "' List:", list))
  list[index] == value 
    ? true 
    : index <= len(list)  ? list_contains(list,value,index+1)
    : false;
function typeerror(type, value) = str("invalid value for type '" , type , "'; value '" , value ,"'");
function typeerror_list(name, list, expectedLength) = str(name, " must be a list of length ", expectedLength, ", length:", is_list(list) ? len(list) : "not a list");
FilledIn_disabled = "disabled";
FilledIn_enabled = "enabled";
FilledIn_enabledfilllip = "enabledfilllip";
FilledIn_values = [FilledIn_disabled,FilledIn_enabled,FilledIn_enabledfilllip];
function validateFilledIn(value) = 
  //Convert boolean to list value
  let(value = is_bool(value) ? value ? FilledIn_enabled : FilledIn_disabled : value)
  assert(list_contains(FilledIn_values, value), typeerror("FilledIn", value))
  value;
Stackable_enabled = "enabled";
Stackable_disabled = "disabled";
Stackable_filllip = "filllip";
Stackable_values = [Stackable_enabled,Stackable_disabled,Stackable_filllip];
  function validateStackable(value) = 
  //Convert boolean to list value
  let(value = is_bool(value) ? value ? Stackable_enabled : Stackable_disabled : value) 
  assert(list_contains(Stackable_values, value), typeerror("Stackable", value))
  value;  
//CombinedEnd from path functions_gridfinity.scad
//Combined from path module_gridfinity_cup_base.scad



/* [Base]
// (Zack's design uses magnet diameter of 6.5) 
magnet_diameter = 0;  // .1
//create relief for magnet removal 
magnet_easy_release  = "auto";//["off","auto","inner","outer"] 
// (Zack's design uses depth of 6)
screw_depth = 0;
center_magnet_diameter =0;
center_magnet_thickness = 0;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = true;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth] 
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = false;
// Remove floor to create a vertical spacer
spacer = false;
*/
iCupBase_MagnetSize=0;
iCupBase_MagnetEasyRelease=1;
iCupBase_CenterMagnetSize=2;
iCupBase_ScrewSize=3;
iCupBase_HoleOverhangRemedy=4;
iCupBase_CornerAttachmentsOnly=5;
iCupBase_FloorThickness=6;
iCupBase_CavityFloorRadius=7;
iCupBase_EfficientFloor=8;
iCupBase_HalfPitch=9;
iCupBase_FlatBase=10;
iCupBase_Spacer=11;
iCupBase_MinimumPrintablePadSize=12;
iCupBase_FlatBaseRoundedRadius=13;
iCupBase_FlatBaseRoundedEasyPrint=14;
iCupBase_MagnetCaptiveHeight=15;
iCupBase_AlignGrid=16;
iCylinderDimension_Diameter=0;
iCylinderDimension_Height=1;
EfficientFloor_off = "off";
EfficientFloor_on = "on";
EfficientFloor_rounded = "rounded";
EfficientFloor_smooth = "smooth";
EfficientFloor_values = [EfficientFloor_off, EfficientFloor_on, EfficientFloor_rounded, EfficientFloor_smooth];
  function validateEfficientFloor(value) = 
    //Convert boolean to list value
    let(value = is_bool(value) ? value ? EfficientFloor_on : EfficientFloor_off : value)
    assert(list_contains(EfficientFloor_values, value), typeerror("EfficientFloor", value))
    value;  
FlatBase_off = "off";
FlatBase_gridfinity = "gridfinity";
FlatBase_rounded = "rounded";
FlatBase_values = [FlatBase_off, FlatBase_gridfinity, FlatBase_rounded];
  function validateFlatBase(value) = 
    //Convert boolean to list value
    let(value = is_bool(value) ? value ? FlatBase_gridfinity : FlatBase_off : value)
    assert(list_contains(FlatBase_values, value), typeerror("FlatBase", value))
    value;  
function CupBaseSettings(
    magnetSize = [0,0], 
    magnetEasyRelease = MagnetEasyRelease_auto, 
    centerMagnetSize = [0,0], 
    screwSize = [0,0], 
    holeOverhangRemedy = 2, 
    cornerAttachmentsOnly = true,
    floorThickness = gf_cup_floor_thickness,
    cavityFloorRadius = -1,
    efficientFloor = EfficientFloor_off,
    halfPitch = false,
    flatBase = FlatBase_off,
    spacer = false,
    minimumPrintablePadSize = 0,
    flatBaseRoundedRadius=-1,
    flatBaseRoundedEasyPrint=-1,
    magnetCaptiveHeight = 0,
    alignGrid = ["near", "near"]
    ) = 
  let(
    magnetSize = 
      is_num(magnetSize) 
        ? [magnetSize, gf_magnet_thickness]
        : magnetSize,
    screwSize = 
      is_num(screwSize) 
        ? [gf_cupbase_screw_diameter, screwSize]
        : screwSize,
    efficientFloor = validateEfficientFloor(efficientFloor),
    centerMagnetSize = efficientFloor != EfficientFloor_off ? [0, 0] : centerMagnetSize,
    cavityFloorRadius = efficientFloor != EfficientFloor_off ? 0 : cavityFloorRadius,
    magnetEasyRelease = validateMagnetEasyRelease(magnetEasyRelease, efficientFloor),
    result = [
      magnetSize[0] == 0 || magnetSize[1] == 0 ? [0,0] : magnetSize, 
      validateMagnetEasyRelease(magnetEasyRelease), 
      centerMagnetSize[0] == 0 || centerMagnetSize[1] == 0 ? [0,0] : centerMagnetSize,
      screwSize[0] == 0 || screwSize[1] == 0 ? [0,0] : screwSize, 
      holeOverhangRemedy, 
      cornerAttachmentsOnly,
      floorThickness,
      cavityFloorRadius,
      validateEfficientFloor(efficientFloor),
      halfPitch,
      validateFlatBase(flatBase),
      spacer,
      minimumPrintablePadSize,
      flatBaseRoundedRadius,
      flatBaseRoundedEasyPrint,
      magnetCaptiveHeight,
      alignGrid
      ],
    validatedResult = ValidateCupBaseSettings(result)
  ) validatedResult;
function ValidateCupBaseSettings(settings, num_x, num_y) =
  assert(is_list(settings) && len(settings) == 17, typeerror_list("CupBase Settings", settings, 17))
  assert(is_list(settings[iCupBase_MagnetSize]) && len(settings[iCupBase_MagnetSize])==2, "CupBase Magnet Setting must be a list of length 2")
  assert(is_list(settings[iCupBase_CenterMagnetSize]) && len(settings[iCupBase_CenterMagnetSize])==2, "CenterMagnet Magnet Setting must be a list of length 2")
  assert(is_list(settings[iCupBase_ScrewSize]) && len(settings[iCupBase_ScrewSize])==2, "ScrewSize Magnet Setting must be a list of length 2")
  assert(is_num(settings[iCupBase_HoleOverhangRemedy]), "CupBase HoleOverhangRemedy Settings must be a number")
  assert(is_bool(settings[iCupBase_CornerAttachmentsOnly]), "CupBase CornerAttachmentsOnly Settings must be a boolean")
  assert(is_num(settings[iCupBase_FloorThickness]), "CupBase FloorThickness Settings must be a number")
  assert(is_num(settings[iCupBase_CavityFloorRadius]), "CupBase CavityFloorRadius Settings must be a number")
  assert(is_bool(settings[iCupBase_HalfPitch]), "CupBase HalfPitch Settings must be a boolean")
  assert(is_string(settings[iCupBase_FlatBase]), "CupBase FlatBase Settings must be a string")
  assert(is_bool(settings[iCupBase_Spacer]), "CupBase Spacer Settings must be a boolean")
  assert(is_num(settings[iCupBase_MinimumPrintablePadSize]), "CupBase minimumPrintablePadSize Settings must be a number")
  assert(is_num(settings[iCupBase_MagnetCaptiveHeight]), "CupBase Magnet Captive height setting must a number")
  assert(is_list(settings[iCupBase_AlignGrid]) && len(settings[iCupBase_AlignGrid])==2, "CupBase AlignGrid Setting must be a list of length 2")
  let(
    efficientFloor = validateEfficientFloor(settings[iCupBase_EfficientFloor]),
    magnetEasyRelease = validateMagnetEasyRelease(settings[iCupBase_MagnetEasyRelease], efficientFloor),
    flatBase = validateFlatBase(settings[iCupBase_FlatBase])
  ) [
      settings[iCupBase_MagnetSize],
      magnetEasyRelease,
      settings[iCupBase_CenterMagnetSize],
      settings[iCupBase_ScrewSize],
      settings[iCupBase_HoleOverhangRemedy],
      settings[iCupBase_CornerAttachmentsOnly],
      settings[iCupBase_FloorThickness],
      settings[iCupBase_CavityFloorRadius],
      efficientFloor,
      settings[iCupBase_HalfPitch],
      flatBase,
      settings[iCupBase_Spacer],
      settings[iCupBase_MinimumPrintablePadSize],
      settings[iCupBase_FlatBaseRoundedRadius],
      settings[iCupBase_FlatBaseRoundedEasyPrint],
      settings[iCupBase_MagnetCaptiveHeight],
      settings[iCupBase_AlignGrid]
      ];
//CombinedEnd from path module_gridfinity_cup_base.scad
//Combined from path gridfinity_constants.scad


// dimensions as declared on https://gridfinity.xyz/specification/
//Gridfinity grid size
gf_pitch = 42;
//Gridfinity height size
gf_zpitch = 7;
gf_taper_angle = 45;
// cup
gf_cup_corner_radius = 3.75;
gf_cup_floor_thickness = 0.7;  
// CupBase
gf_cupbase_lower_taper_height = 0.8;
gf_cupbase_riser_height = 1.8;
gf_cupbase_upper_taper_height = 2.15;
gf_cupbase_magnet_position = 4.8; 
gf_cupbase_screw_diameter = 3; 
gf_cupbase_screw_depth = 6;
gf_magnet_diameter = 6.5;
gf_magnet_thickness = 2.4;
gf_base_grid_clearance_height = 3.5;
//stacking lips
// Standard lip
// \        gf_lip_upper_taper_height 
//  |       gf_lip_riser_height
//   \      gf_lip_lower_taper_height
//    |     gf_lip_height
//   /      gf_lip_support_taper_height
//  /
// /
///
// Reduced lip
// \        gf_lip_upper_taper_height 
//  |       gf_lip_riser_height
// /        gf_lip_reduced_support_taper_height
/// 
gf_lip_lower_taper_height = 0.7;
gf_lip_riser_height = 1.8;
gf_lip_upper_taper_height = 1.9;
gf_lip_height = 1.2;
//gf_lip_support_taper_height = 2.5;
//gf_lip_reduced_support_taper_height = 1.9;
// base plate
gf_baseplate_lower_taper_height = 0.7;
gf_baseplate_riser_height = 1.8;
gf_baseplate_upper_taper_height = 2.15;
gf_baseplate_magnet_od = 6.5;
gf_baseplate_magnet_thickness = 2.4;
// top lip height 4.4mm
gf_Lip_Height = 4.4-0.6;//gf_lip_lower_taper_height + gf_lip_riser_height + gf_lip_upper_taper_height;
// cupbase height 4.75mm + 0.25.
function gfBaseHeight() = gf_cupbase_lower_taper_height + gf_cupbase_riser_height + gf_cupbase_upper_taper_height+0.25; //results in 5
gf_min_base_height = gfBaseHeight(); 
// base heighttop lip height 4.4mm
function gfBasePlateHeight() = gf_baseplate_lower_taper_height + gf_baseplate_riser_height + gf_baseplate_upper_taper_height;
// old names, that will get replaced
/*
gridfinity_lip_height = gf_Lip_Height; 
gridfinity_corner_radius = gf_cup_corner_radius ; 
gridfinity_zpitch = env_pitch().z;
minFloorThickness = gf_cup_floor_thickness;  
const_magnet_height = gf_magnet_thickness;
*/
//Small amount to add to prevent clipping in openSCAD
fudgeFactor = 0.01;
color_cup = "LightSlateGray";
color_divider = "Gainsboro"; //LemonChiffon
color_topcavity = "Green";//"SteelBlue";
color_label = "DarkCyan";
color_cupcavity = "LightGreen"; //IndianRed
color_wallcutout = "SandyBrown";
color_basehole = "DarkSlateGray";
color_base = "DimGray";
color_extension = "lightpink";
color_text = "Yellow"; //Gold
color_cut = "Black";
color_lid = "MediumAquamarine";
//CombinedEnd from path gridfinity_constants.scad
//Combined from path module_lip.scad







//Lip object configuration
iLipStyle=0;
iLipSideReliefTrigger=1;
iLipTopReliefHeight=2;
iLipTopReliefWidth=3;
iLipNotch=4;
iLipClipPosition=5;
iLipNonBlocking=6;
LipStyle_normal = "normal";
LipStyle_reduced = "reduced";
LipStyle_reduced_double = "reduced_double";
LipStyle_minimum = "minimum";
LipStyle_none = "none";
LipStyle_values = [LipStyle_normal,LipStyle_reduced, LipStyle_reduced_double, LipStyle_minimum,LipStyle_none];
function validateLipStyle(value) = 
  assert(list_contains(LipStyle_values, value), typeerror("LipStyle", value))
  value;
LipClipPosition_disabled = "disabled";
LipClipPosition_center_wall = "center_wall";
LipClipPosition_intersection = "intersection";
LipClipPosition_both = "both";
LipClipPosition_values = [LipClipPosition_disabled,LipClipPosition_center_wall,LipClipPosition_intersection,LipClipPosition_both];
function validateLipClipPosition(value) = 
  assert(list_contains(LipClipPosition_values, value), typeerror("LipClipPosition", value))
  value;
function LipSettings(
  lipStyle = LipStyle_normal, 
  lipSideReliefTrigger = [1,1], 
  lipTopReliefHeight = -1, 
  lipTopReliefWidth = -1, 
  lipNotch = true,
  lipClipPosition = LipClipPosition_disabled,
  lipNonBlocking = false) =  
  let(
    result = [
      lipStyle,
      lipSideReliefTrigger,
      lipTopReliefHeight,
      lipTopReliefWidth,
      lipNotch,
      lipClipPosition,
      lipNonBlocking],
    validatedResult = ValidateLipSettings(result)
  ) validatedResult;
function ValidateLipSettings(settings) =
  assert(is_list(settings), "LipStyle Settings must be a list")
  assert(len(settings)==7, "LipStyle Settings must length 7")
  assert(is_bool(settings[iLipNotch]), "Lip Notch must be a bool")
    [validateLipStyle(settings[iLipStyle]),
      settings[iLipSideReliefTrigger],
      settings[iLipTopReliefHeight],
      settings[iLipTopReliefWidth],
      settings[iLipNotch],
      validateLipClipPosition(settings[iLipClipPosition]),
      settings[iLipNonBlocking]];
module cupLip(
  num_x = 2, 
  num_y = 3, 
  lipStyle = LipStyle_normal, 
  wall_thickness = 1.2,
  lip_notches = true,
  lip_top_relief_height = -1,
  lip_top_relief_width = -1,
  lip_clip_position = LipClipPosition_disabled,
  lip_non_blocking = false,
  align_grid = [ "near", "near"]){
  assert(is_num(num_x) && num_x > 0, "num_x must be a number greater than 0");
  assert(is_num(num_y) && num_y > 0, "num_y must be a number greater than 0");
  assert(is_string(lipStyle));
  assert(is_num(wall_thickness) && wall_thickness > 0, "wall_thickness must be a number greater than 0");
  assert(is_num(lip_top_relief_height));
  assert(is_num(lip_top_relief_width));
  assert(is_bool(lip_notches));
  assert(is_string(lip_clip_position));
  assert(is_bool(lip_non_blocking));
  connectorsEnabled = lip_clip_position != LipClipPosition_disabled;
  $allowConnectors = connectorsEnabled ? [1,1,1,1] : [0,0,0,0];
  $frameBaseHeight = 0; //$num_z * env_pitch().z;
  //Difference between the wall and support thickness
  lipSupportThickness = (lipStyle == "minimum" || lipStyle == "none") ? 0
    : lipStyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : lipStyle == "reduced_double" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;
  floorht=0;
  // should be 17 for default settings
  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  innerLipRadius = env_corner_radius()-gf_lip_lower_taper_height-gf_lip_upper_taper_height; //1.15
  innerWallRadius = env_corner_radius()-wall_thickness;
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // around the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  lipHeight = 3.75;
  outer_size = [env_pitch().x - env_clearance().x, env_pitch().y - env_clearance().y];  // typically 41.5
  block_corner_position = [outer_size.x/2 - env_corner_radius(), outer_size.y/2 - env_corner_radius()];  // need not match center of pad corners
  coloredLipHeight=min(2,lipHeight);
  if(lipStyle != "none")
    color(env_colour(color_topcavity, isLip = true))
    tz(-fudgeFactor*2)
    difference() {
      //Lip outer shape
      tz(fudgeFactor*2)
      hull() 
        cornercopy(block_corner_position, num_x, num_y) 
        cylinder(r=env_corner_radius(), h=lipHeight+fudgeFactor);
      cupLip_cavity(
        num_x = num_x, 
        num_y = num_y, 
        lipStyle = lipStyle, 
        wall_thickness = wall_thickness,
        lip_notches = lip_notches,
        lip_top_relief_height = lip_top_relief_height,
        lip_top_relief_width = lip_top_relief_width,
        lip_clip_position = lip_clip_position,
        lip_non_blocking = lip_non_blocking,
        align_grid = align_grid);
    }
}
module cupLip_cavity(
  num_x = 2, 
  num_y = 3, 
  lipStyle = LipStyle_normal, 
  wall_thickness = 1.2,
  lip_notches = true,
  lip_top_relief_height = -1,
  lip_top_relief_width = -1,
  lip_clip_position = LipClipPosition_disabled,
  lip_non_blocking = false,
  align_grid = [ "near", "near"]){
  assert(is_num(num_x) && num_x > 0, "num_x must be a number greater than 0");
  assert(is_num(num_y) && num_y > 0, "num_y must be a number greater than 0");
  assert(is_string(lipStyle));
  assert(is_num(wall_thickness) && wall_thickness > 0, "wall_thickness must be a number greater than 0");
  assert(is_num(lip_top_relief_height));
  assert(is_num(lip_top_relief_width));
  assert(is_bool(lip_notches));
  assert(is_string(lip_clip_position));
  assert(is_bool(lip_non_blocking));
  connectorsEnabled = lip_clip_position != LipClipPosition_disabled;
  $allowConnectors = connectorsEnabled ? [1,1,1,1] : [0,0,0,0];
  $frameBaseHeight = 0; //$num_z * env_pitch().z;
  //Difference between the wall and support thickness
  lipSupportThickness = (lipStyle == "minimum" || lipStyle == "none") ? 0
    : lipStyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : lipStyle == "reduced_double" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;
  floorht=0;
  // should be 17 for default settings
  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  innerLipRadius = env_corner_radius()-gf_lip_lower_taper_height-gf_lip_upper_taper_height; //1.15
  innerWallRadius = env_corner_radius()-wall_thickness;
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // around the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  lipHeight = 3.75;
  outer_size = [env_pitch().x - env_clearance().x, env_pitch().y - env_clearance().y];  // typically 41.5
  block_corner_position = [outer_size.x/2 - env_corner_radius(), outer_size.y/2 - env_corner_radius()];  // need not match center of pad corners
  coloredLipHeight=min(2,lipHeight);
  pitch=env_pitch();
  // remove top so XxY can fit on top
  //pad_oversize(num_x, num_y, 1);
  union(){
    //Top cavity, with lip relief
    frame_cavity(
      num_x = lip_non_blocking ? ceil(num_x) : num_x, 
      num_y = lip_non_blocking ? ceil(num_y) : num_y, 
      position_fill_grid_x = align_grid.x,
      position_fill_grid_y = align_grid.y,
      render_top = lip_notches,
      render_bottom = false,
      frameLipHeight = 4,
      cornerRadius = env_corner_radius(),
      reducedWallHeight = lip_top_relief_height,
      reducedWallWidth = lip_top_relief_width,
      reducedWallOuterEdgesOnly=true){
        echo("donothign");
        frame_connectors(
          width = num_x, 
          depth = num_y,
          connectorPosition = lip_clip_position,
          connectorClipEnabled = connectorsEnabled);
      };
    //lower cavity
    frame_cavity(
      num_x = 1, 
      num_y = 1, 
      position_fill_grid_x = "far",
      position_fill_grid_y = "far",
      render_top = !lip_notches,
      render_bottom = true,
      frameLipHeight = 4,
      cornerRadius = env_corner_radius(),
      reducedWallHeight = -1, 
      reducedWallWidth = -1,
      $pitch=[
        pitch.x*(lip_non_blocking ? ceil(num_x) : num_x),
        pitch.y*(lip_non_blocking ? ceil(num_y) : num_y),
        pitch.z]);
  }
  if (lipStyle == "minimum" || lipStyle == "none") {
    hull() cornercopy(inner_corner_center, num_x, num_y)
      tz(-fudgeFactor) 
      cylinder(r=innerWallRadius, h=gf_Lip_Height);   // remove entire lip
  } 
  else if (lipStyle == "reduced" || lipStyle == "reduced_double") {
    lowerTaperZ = gf_lip_lower_taper_height;
    hull() cornercopy(inner_corner_center, num_x, num_y)
    union(){
      tz(lowerTaperZ) 
      cylinder(
        r1=innerWallRadius, 
        r2=env_corner_radius()-gf_lip_upper_taper_height, 
        h=lipSupportThickness);
      tz(-fudgeFactor) 
      cylinder(
        r=innerWallRadius, 
        h=lowerTaperZ+fudgeFactor*2);
    }
  } 
  else { // normal
    lowerTaperZ = -gf_lip_height-lipSupportThickness;
    if(lowerTaperZ <= floorht){
      hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(floorht) 
        cylinder(r=innerLipRadius, h=-floorht+fudgeFactor*2); // lip
    } else {
      hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(-gf_lip_height-fudgeFactor) 
        cylinder(r=innerLipRadius, h=gf_lip_height+fudgeFactor*2); // lip
      hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(-gf_lip_height-lipSupportThickness-fudgeFactor) 
        cylinder(
          r1=innerWallRadius,
          r2=innerLipRadius, h=q+fudgeFactor);   // ... to top of thin wall ...
    }
  }
}
//CombinedEnd from path module_lip.scad
//Combined from path module_gridfinity_frame_connectors.scad






// include instead of use, so we get the pitch
iAllowConnectorsFront = 0;
iAllowConnectorsBack = 1;
iAllowConnectorsLeft = 2;
iAllowConnectorsRight = 3;
show_frame_connector_demo = false;
if(show_frame_connector_demo){
  $fn = 64;
  translate([0,0,0]) {
    ClippedWall(fullIntersection = true);
    translate([15,0,0])
    ClipConnector(fullIntersection=true);
    translate([30,0,0])
    ClipCutter(fullIntersection=true);
   }
  translate([0,15,0]) {
    ClippedWall(straightIntersection = true);
    translate([15,0,0])
    ClipConnector(straightIntersection = true);
    translate([30,0,0])
    ClipCutter(straightIntersection = true);
   }
  translate([0,30,0]) {
    ClippedWall(cornerIntersection = true);
    //translate([15,0,0])
    //ClipConnector(cornerIntersection = true);
    translate([30,0,0])
    ClipCutter(cornerIntersection = true);
  }
  translate([0,45,0]) {
    ClippedWall(straightWall = true);
    translate([15,0,0])
    ClipConnector(straightWall = true);
    translate([30,0,0])
    ClipCutter(straightWall = true);
   }
}
module frame_connectors(
  width = 1, 
  depth = 1,
  connectorPosition = "both",
  connectorClipEnabled = false,
  connectorClipSize = 10,
  connectorClipTolerance = 0.1,
  connectorButterflyEnabled = false,
  connectorButterflySize = [5,3,2],
  connectorButterflyRadius = 0.5,
  connectorButterflyTolerance = 0.1,
  connectorFilamentEnabled = false,
  connectorFilamentLength = 10,
  connectorFilamentDiameter = 2) {
  if(connectorButterflyEnabled || connectorFilamentEnabled || connectorClipEnabled){
    union(){
      if(env_help_enabled("debug")) echo("baseplate", gci=$gci, gc_size=$gc_size, gc_is_corner=$gc_is_corner, gc_position=$gc_position, width=width, depth=depth);
      if(connectorPosition == "center_wall" || connectorPosition == "both")
      PositionCellCenterConnector(
        left=$gci.x==0&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsLeft],
        right=$gci.x>=$gc_count.x-1&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsRight],
        front=$gci.y==0&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsFront],
        back=$gci.y>=$gc_count.y-1&&$gc_size.x==1&&$gc_size.y==1&& $allowConnectors[iAllowConnectorsBack]) {
          if($preview)
            *rotate([0,0,90])
            cylinder_printable(h=10,r=1);
          if(connectorClipEnabled)
            ClipCutter(size=connectorClipSize, 
              height= 0.8, //height of bevel1_top
              frameHeight = 4,
              clearance = connectorClipTolerance,
              cornerRadius = env_corner_radius(),
              straightWall=true);
          if(connectorButterflyEnabled)
            translate([0,0,-$frameBaseHeight])
            rotate([0,0,90])
            ButterFlyConnector(
              size=connectorButterflySize,
              r=connectorButterflyRadius,
              clearance = connectorButterflyTolerance,
              taper=false,half=false);
          if(connectorFilamentEnabled)
            translate([0,0,-$frameBaseHeight/2])
            FilamentCutter(
              l=connectorFilamentLength,
              d=connectorFilamentDiameter);
          }
        if(connectorPosition == "intersection" || connectorPosition == "both")
        PositionCellCornerConnector(
        left=$gci.x==0&&$gc_size.x==1&&$gc_size.y==1,
        right=$gci.x>=$gc_count.x-1 && $gc_size.x==1&&$gc_size.y==1,
        front=$gci.y==0&&$gc_size.x==1&&$gc_size.y==1,
        back=$gci.y>=$gc_count.y-1&&$gc_size.x==1&&$gc_size.y==1) {
          if($preview)
            *rotate([0,0,90])
            cylinder_printable(h=$corner ? 20 : 15,r=2);
          if(connectorClipEnabled)
            rotate([0,0,270])
            ClipCutter(size=connectorClipSize, 
              height= 0.8, //height of bevel1_top
              frameHeight = 4,
              clearance = connectorButterflyTolerance,
              cornerRadius = env_corner_radius(),
              straightIntersection = !$corner,
              cornerIntersection = $corner);
          if(connectorButterflyEnabled && !$corner)
            translate([0,0,-$frameBaseHeight])
            rotate([0,0,90])
            ButterFlyConnector(
              size=connectorButterflySize,
              r=connectorButterflyRadius,
              clearance = connectorButterflyTolerance,
              taper=false,half=false);
          if(connectorFilamentEnabled && !$corner)
            translate([0,0,-$frameBaseHeight/2])
            FilamentCutter(
              l=connectorFilamentLength,
              d=connectorFilamentDiameter);
        }
    }
  }
}
module PositionCellCenterConnector(left, right,front,back){
    if(left)
      translate([0,env_pitch().y/2,0])
      children();
    if(right)
      translate([env_pitch().x,env_pitch().y/2,0])
      rotate([0,0,180])
      children();
    if(front)
      translate([env_pitch().x/2,0,0])
      rotate([0,0,90])
      children();
    if(back)
      translate([env_pitch().x/2,env_pitch().y,0])
      rotate([0,0,270])
      children();
}
module PositionCellCornerConnector(left, right, front, back){
  if(left || right || front || back)
  {
    if(left && front) {
      if($allowConnectors[iAllowConnectorsLeft] && $allowConnectors[iAllowConnectorsFront])
        let($corner = true)
        rotate([0,0,90])
        children();
      let($corner = false){
        if($allowConnectors[iAllowConnectorsFront])
        translate([env_pitch().x,0,0])
        rotate([0,0,90])
        children();
        if($allowConnectors[iAllowConnectorsLeft])
        translate([0,env_pitch().y,0])
        children();
      }
    }
    if(left && back) {
      if($allowConnectors[iAllowConnectorsLeft] && $allowConnectors[iAllowConnectorsBack])
        let($corner = true)
        translate([0,env_pitch().y,0])
        children();
      let($corner = false) {
        if($allowConnectors[iAllowConnectorsLeft])
        children();
        if($allowConnectors[iAllowConnectorsBack])
        translate([env_pitch().x,env_pitch().y,0])
        rotate([0,0,270])
        children();
      }
    }
    if(right && front){
      if($allowConnectors[iAllowConnectorsRight] && $allowConnectors[iAllowConnectorsFront])
        let($corner = true)
        translate([env_pitch().x,0,0])
        rotate([0,0,180])
        children();
      let($corner = false) {
        if($allowConnectors[iAllowConnectorsFront])
        rotate([0,0,90])
        children();
        if($allowConnectors[iAllowConnectorsRight])
        translate([env_pitch().x,env_pitch().y,0])
        rotate([0,0,180])
        children();
      }
    }
    if(right && back){
      if($allowConnectors[iAllowConnectorsRight] && $allowConnectors[iAllowConnectorsBack])
        let($corner = true)
        translate([env_pitch().x,env_pitch().y,0])
        rotate([0,0,270])
        children();
      let($corner = false) {
        if($allowConnectors[iAllowConnectorsRight])
        translate([env_pitch().x,0,0])
        rotate([0,0,180])
        children();
        if($allowConnectors[iAllowConnectorsBack])
        translate([0,env_pitch().y,0])
        rotate([0,0,270])
        children();
      }
    }
    if(left && !back && !front && !front && $gci.y<=$gc_count.y-3 && $allowConnectors[iAllowConnectorsLeft]){
      $corner = false;
      translate([0,env_pitch().y,0])
      children();
    }
    if(front && !left && !right && $gci.x<=$gc_count.x-3 && $allowConnectors[iAllowConnectorsFront]){
      $corner = false;
      translate([env_pitch().x,0,0])
      rotate([0,0,90])
      children();
    }
    if(right && !back && !front && $gci.y<=$gc_count.y-3 && $allowConnectors[iAllowConnectorsRight]){
      $corner = false;
      translate([env_pitch().x,env_pitch().y,0])
      rotate([0,0,180])
      children();
    }
    if(back && !left && !right && $gci.x<=$gc_count.x-3 && $allowConnectors[iAllowConnectorsBack]){
      $corner = false;
      translate([env_pitch().x,env_pitch().y,0])
      rotate([0,0,270])
      children();
    }
  }
}
module FilamentCutter(
    l = 5, 
    d = 1.75){
  translate([-fudgeFactor, 0,0])
  rotate([90,0,90])
  cylinder_printable(h=l,d=d);
}
module cylinder_printable(h=10,r=1,d,center=false){
  r = is_num(d) ? d/2 : r;
  d=2*r;
  flat_top_width = d/2.5;
  flat_top_height = d/2+0.5;
  translate(center ? [0,0,0] : [0,0,h/2])
  hull(){
    //Printable Cylinder
    cylinder(h=h,d=d, center=true);
    translate([-flat_top_width/2,d/2-flat_top_height,-h/2])
      cube([flat_top_width,flat_top_height,h]); 
  }
}
//What is to be removed from the baseplate, to make room for the corner clip
module ClipCutter(
  size=10, 
  height= 0.8, //height of bevel1_top
  frameHeight = 4,
  clippedWallThickness = 2,
  clippedWallHeight = 1.6,
  clearance = 0.1,
  cornerRadius = gf_cup_corner_radius,
  straightWall = false,
  straightIntersection = false,
  cornerIntersection = false,
  fullIntersection = false){
  height = height-clearance/2;
  translate([0,0,height+fudgeFactor])
  difference(){
    if(straightIntersection) {
      translate([-size/2-clearance,-fudgeFactor,0])
        cube(size=[size+clearance*2,size/2+clearance+fudgeFactor,frameHeight-height+fudgeFactor]);
    } else if(cornerIntersection) {
      translate([-fudgeFactor,-fudgeFactor,0])
        cube(size=[size/2+fudgeFactor+clearance,size/2+clearance+fudgeFactor,frameHeight-height+fudgeFactor]);
    } else {
      translate([-size/2-clearance,-size/2-clearance,0])
        cube(size=[size+clearance*2,size+clearance*2,frameHeight-height+fudgeFactor]);
    }
    //clipped inner wall
    translate([0,0,-fudgeFactor])
    ClippedWall(
      clipSize=size+clearance*2, 
      cornerRadius = cornerRadius,
      clippedWallThickness = clippedWallThickness,
      clippedWallHeight = clippedWallHeight-clearance,
      straightWall = straightWall,
      straightIntersection = straightIntersection,
      cornerIntersection = cornerIntersection,
      fullIntersection = fullIntersection);
  }
}
module ClipConnector(
  size=10, 
  height= 0.8, //height of bevel1_top
  frameHeight = 4,
  clippedWallThickness = 2,
  clippedWallHeight = 1.6,
  clearance = 0.1,
  cornerRadius = gf_cup_corner_radius,
  straightWall = false,
  straightIntersection = false,
  fullIntersection = false){
  render()
  difference(){
    translate([
        -size/2,
        straightIntersection ? 0 : -size/2,
        0])
      cube(size=[size,
          straightIntersection ? size/2 : size,
          frameHeight-height]);
    if(!straightWall) {
      translate([-env_pitch().x,-env_pitch().y,-height])
        frame_cavity(
          num_x=2, 
          num_y=2);
    } else {
      translate([-env_pitch().x,-env_pitch().y/2,-height])
        frame_cavity(
          num_x=2, 
          num_y=1);
    }
    //clipped inner wall
    translate([0,0,-fudgeFactor])
    ClippedWall(
      clipSize=size, 
      cornerRadius = cornerRadius,
      clippedWallThickness = clippedWallThickness+clearance,
      clippedWallHeight = clippedWallHeight+clearance,
      straightWall = straightWall,
      straightIntersection = straightIntersection,
      fullIntersection = fullIntersection);
  }
}
//The wall that is ls left once the clip shape is removed
module ClippedWall(
  clipSize=10, 
  cornerRadius = gf_cup_corner_radius,
  clippedWallHeight = 2,
  clippedWallThickness = 1,
  frameWallHeight = 1.6,
  straightWall = false,
  straightIntersection = false,
  cornerIntersection = false,
  fullIntersection = false){
  corners = straightWall ? 0 
    : cornerIntersection ? 1 
    : straightIntersection ? 2 
    : 4;
    height = clippedWallHeight+fudgeFactor;
    clipRadius = cornerRadius - clippedWallThickness/2;
    xlength = straightWall ? 0
      : cornerIntersection ? clipSize/2+fudgeFactor
      : clipSize+fudgeFactor*2;
    ylength = cornerIntersection  || straightIntersection? clipSize/2+fudgeFactor
      : clipSize+fudgeFactor*2;
    union(){
      rotate([0,0,180])
      translate([-clippedWallThickness/2,-clipSize/2-fudgeFactor,0])
        cube(size=[clippedWallThickness,ylength,height]);
      rotate([0,0,180])
      translate([-clipSize/2-fudgeFactor,-clippedWallThickness/2,0])
        cube(size=[xlength,clippedWallThickness,height]);
    }
    if(corners > 0)
    difference(){
      if(cornerIntersection){
        translate([-(+clippedWallThickness)/2,-(clippedWallThickness)/2,0])
          cube(size=[clipRadius+clippedWallThickness,clipRadius+clippedWallThickness,height]);
      } else if (straightIntersection){
        translate([-(clipRadius*2+clippedWallThickness)/2,-(clippedWallThickness)/2,0])
          cube(size=[clipRadius*2+clippedWallThickness,clipRadius+clippedWallThickness,height]);
      } else {
        translate([-(clipRadius*2+clippedWallThickness)/2,-(clipRadius*2+clippedWallThickness)/2,0])
          cube(size=[clipRadius*2+clippedWallThickness,clipRadius*2+clippedWallThickness,height]);
      }
      for(i=[0:1:corners-1]){
        rotate([0,0,i*90])
        translate([clippedWallThickness/2+clipRadius,clippedWallThickness/2+clipRadius,-fudgeFactor])
          cylinder(r=clipRadius,h=height+fudgeFactor*2);
      }
  }
}
module ButterFlyConnector(
  size,
  r,
  clearance = 0,
  taper=false,
  half=false)
  {
  h = taper ? size.y/2+size.z : size.z;
  //render()
  intersection(){
    positions = [
      [-(size.x/2-r), size.y/2-r, h/2],
      [size.x/2-r, size.y/2-r, h/2],
      [0, -(size.y/2-r), h/2]];
    union()
    for(ri = [0:half?0:1]){
      mirror([0,1,0]*ri)
      hull(){
        for(pi = [0:len(positions)-1]){
          translate(positions[pi])
            cylinder(h=h,r=r,center=true);
        }
      }
    }
    if(taper)
    rotate([0,90,0])
    cylinder(h=size.x,r=size.y/2+size.z,$fn=4,center=true);
  }
}
//CombinedEnd from path module_gridfinity_frame_connectors.scad
//Combined from path module_magnet.scad




MagnetEasyRelease_off = "off";
MagnetEasyRelease_auto = "auto";
MagnetEasyRelease_inner = "inner"; 
MagnetEasyRelease_outer = "outer"; 
MagnetEasyRelease_values = [MagnetEasyRelease_off, MagnetEasyRelease_auto, MagnetEasyRelease_inner, MagnetEasyRelease_outer];
  function validateMagnetEasyRelease(value, efficientFloorValue) = 
  //Convert boolean to list value
  let(value = is_bool(value) ? value ? MagnetEasyRelease_auto : MagnetEasyRelease_off : value,
      autoValue = value == MagnetEasyRelease_auto 
        ? efficientFloorValue == EfficientFloor_off ? MagnetEasyRelease_inner : MagnetEasyRelease_outer 
        : value) 
  assert(list_contains(MagnetEasyRelease_values, autoValue), typeerror("MagnetEasyRelease", autoValue))
  autoValue;
module MagnetAndScrewRecess(
  magnetDiameter = 10,
  magnetThickness = 2,
  screwDiameter = 2,
  screwDepth = 6,
  overhangFixLayers = 3,
  overhangFixDepth = 0.2,
  easyMagnetRelease = true,
  magnetCaptiveHeight = 0){
     fudgeFactor = 0.01;
    union(){
      SequentialBridgingDoubleHole(
        outerHoleRadius = magnetDiameter/2,
        outerHoleDepth = magnetThickness,
        innerHoleRadius = screwDiameter/2,
        innerHoleDepth = screwDepth > 0 ? screwDepth+fudgeFactor : 0,
        overhangBridgeCount = overhangFixLayers,
        overhangBridgeThickness = overhangFixDepth,
        magnetCaptiveHeight = magnetCaptiveHeight);
      magnet_easy_release(
        magnetDiameter = magnetDiameter,
        magnetThickness = magnetThickness,
        easyMagnetRelease = easyMagnetRelease
      );
  }
}
module magnet_easy_release(
  magnetDiameter = 10,
  magnetThickness = 2,
  easyMagnetRelease = true,
  center = false
){
  fudgeFactor = 0.01;
  releaseWidth = 1.3;
  releaseLength = 1.5;
  outerPlusBridgeHeight = magnetThickness;
  translate(center ? [0,0,-outerPlusBridgeHeight/2] : [0,0,0] )
  union(){
    cylinder(r=magnetDiameter/2, h=outerPlusBridgeHeight);
    if(easyMagnetRelease && magnetDiameter > 0)
    difference(){
      hull(){
        translate([0,-releaseWidth/2,0])  
          cube([magnetDiameter/2+releaseLength,releaseWidth,magnetThickness]);
        translate([magnetDiameter/2+releaseLength,0,0])  
          cylinder(d=releaseWidth, h=magnetThickness);
      }
      champherRadius = min(magnetThickness, releaseLength+releaseWidth/2);
      totalReleaseLength = magnetDiameter/2+releaseLength+releaseWidth/2;
      translate([totalReleaseLength,-releaseWidth/2-fudgeFactor,magnetThickness])
      rotate([270,0,90])
      roundedCorner(
        radius = champherRadius, 
        length = releaseWidth+2*fudgeFactor, 
        height = totalReleaseLength);
    }
  }
}
//CombinedEnd from path module_magnet.scad
//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;   
if (part == "tile") {
  tile();
}
else if (part == "pawn") {
  pawn();
}
else if (part == "knight") {
  knight();
}
else if (part == "bishop") {
  bishop();
}
else if (part == "rook") {
  rook();
}
else if (part == "queen") {
  queen();
}
else if (part == "king") {
  king();
}
else if (part == "board") {
  board();
  color("#DDDDDD") piece_set();
  color("#505050") piece_set(false);
}
module piece_set(white=true) {
  pawnrow = white ? 1 : 6;
  restrow = white ? 0 : 7;
  for (i=[0:7]) {
    translate([i*42, 42*pawnrow, 0]) pawn();
  }
  for (i=[0,1]) {
    translate([0 + 7*i*42, restrow*42, 0]) rook();
    translate([(1 + 5*i)*42, restrow*42, 0]) 
      rotate([0, 0, white ? 0 : 180]) knight();
    translate([(2 + 3*i)*42, restrow*42, 0]) bishop();
  }
  translate([3*42, restrow*42, 0]) queen();
  translate([4*42, restrow*42, 0]) king();
}
module king() {
  base();
  rotate_extrude()
  polygon([[0, 47], [0, 0], [11, 0], [11, 10], [8, 13], [6, 38],
    [9, 42], [9, 45], [7, 46]]);
  translate([-1.5, -1, 47-1]) cube([3, 2, 10]);
  translate([-3, -1, 51]) cube([6, 2, 3]);
}
module queen() {
  base();
  difference() {  
    rotate_extrude()
    polygon([[0, 45], [0, 0], [11, 0], [11, 10], [8, 13], [6, 42], 
      [8, 44], [8, 46], [11, 48], [13, 53], [12, 53], [8, 48]]);
    *%for (a=[0, 60, 120]) rotate([0, 0, a])
    translate([-15, -1.5, 48.5]) cube([30, 3, 10]);
    for (a=[0, 30, 60, 90, 120, 150]) rotate([0, 0, a])
    translate([0, 0, 48.5+6])
    rotate([0, 90, 0]) cylinder(d=7.25, h=30, center=true);
  }
}
module knight() {
  base();
  rotate_extrude()
  polygon([[0, 13], [0, 0], [9, 0], [9, 10], [7, 13]]);
  hull() {
    translate([-4, -7.5, 0]) cube([8, 13, 14]);
    translate([-2.5, -7.5, 30]) cube([5, 8, 3]);
  }
  translate([-2.5-.125, -7.5, 30]) cube([5+.25, 17, 7]);
  // support for bridging knight nose (remove afterward)
  hull() {
    translate([-2.625, 9.5-0.8, 27]) cube([5.25, 0.8, 3]);  
    translate([-5, 10, 0]) cube([10, 1, 1]);
  }
  translate([-0.6, 10, 0]) cube([1.2, 6, 5]);
}
module bishop() {
  base();
  tz(42) sphere(d=3);
  difference() {
    rotate_extrude()
    polygon([[0, 42], [0, 0], [9, 0], [9, 10], [7, 13], [3.5, 26], [6, 32]]);
    translate([4.5, 0, 40])
    rotate([0, -56, 0])
    cylinder(d=20, h=1);
  }
}
module rook() {
  base();
  difference() {
    rotate_extrude()
    polygon([[0, 34], [0, 0], [10, 0], [10, 10], [7, 13], [7, 29], 
      [10, 32], [10, 39], [8, 39], [8, 34]]);
    for (a=[0, 90]) rotate([0, 0, a]) 
      translate([-15, -1.5, 34.5]) cube([30, 3, 10]);
  }
}
module pawn() {
  base();
  tz(25) sphere(d=11);
  rotate_extrude()
  polygon([[0, 25], [0, 0], [7, 0], [7, 8], [4.5, 11], [3, 24]]);
}
module base() {
  difference() {
    tile(0.75);
    difference() {
      cube([35, 35, 30], center=true);
      for (a=[45, 135]) rotate([0, 0, a]) cube([60, 2, 30], center=true);
    }
    translate([-21, -21, 5]) cube([42, 42, 42]);
  }
}
module board() {  // 64 tiles in alternating colors
  tz(-3.55) for (ti=[0:7]) for (tj=[0:7]) translate([42*ti, 42*tj, 0]) 
    color((ti+tj)%2 == 0 ? "darkblue" : "lightblue")
    render() tile();
}
module tile(height = 0.5) {
  grid_block(1, 1, 0.5, lipStyle = "none", position = "centered");
}
module tz(z) {
  translate([0, 0, z]) children();
}

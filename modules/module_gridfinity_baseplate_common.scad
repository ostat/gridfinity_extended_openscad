// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
include <module_utility.scad>
use <module_gridfinity_block.scad>
include <module_magnet.scad>

iBaseplateTypeSettings_SupportsMagnets = true;
  
function lookupKey(dictionary, key, default=undef) = let(results = [
  for (record = dictionary)
  if (record[0] == key)
  record
]) is_undef(results) || !is_list(results) 
  ? default 
  : results[0][1];

function retriveConnectorConfig(connector, default = undef) = lookupKey(connectorSettings,connector,default);
function retriveConnectorSetting(connector, iSetting, default = -1) = let(
  config = retriveConnectorConfig(connector),
  settingValue = config == undef ? default 
    : lookupKey(config, iSetting, default=default)
  ) 
   settingValue == undef 
    ? default 
    : settingValue;
    
function bitwise_and(v1, v2, bv = 1) = 
   assert(is_num(v1), "v1 must be a number")
   assert(is_num(v2), "v2 must be a number")
   assert(is_num(bv), "bv must be a number")
      ((v1 + v2) == 0) ? 0
     : (((v1 % 2) > 0) && ((v2 % 2) > 0)) ?
       bitwise_and(floor(v1/2), floor(v2/2), bv*2) + bv
     : bitwise_and(floor(v1/2), floor(v2/2), bv*2);
     
function decimaltobitwise(v1, v2) = 
   assert(is_num(v1), "v1")
   assert(is_num(v2), "v2")
   v1==0 && v2 == 0 ? 1 : 
      v1==0 && v2 == 1 ? 2 :
      v1==1 && v2 == 0 ? 4 :
      v1==1 && v2 == 1 ? 8 : 0;  

module frame_plain(
    grid_num_x, 
    grid_num_y, 
    outer_num_x = 0,
    outer_num_y = 0,
    outer_height = 0,
    position_fill_grid_x = "near",
    position_fill_grid_y = "near",
    position_grid_in_outer_x = "center",
    position_grid_in_outer_y = "center",
    extra_down=0, 
    trim=0, 
    baseTaper = 0, 
    height = 4,
    cornerRadius = gf_cup_corner_radius,
    reducedWallHeight = -1,
    roundedCorners = 15,
    reduceWallTaper = false) {
  frameLipHeight = extra_down > 0 ? height -0.6 : height;
  frameWallReduction = reducedWallHeight > 0 ? max(0, frameLipHeight-reducedWallHeight) : 0;

  centerGridPosition = [
    position_grid_in_outer_x == "near" || grid_num_x >= outer_num_x ? 0 
      : position_grid_in_outer_x == "far" 
        ? (outer_num_x-grid_num_x)*env_pitch().x 
        : (outer_num_x-grid_num_x)/2*env_pitch().x,
    position_grid_in_outer_y == "near" || grid_num_y >= outer_num_y ? 0 
      : position_grid_in_outer_y == "far" 
        ? (outer_num_y-grid_num_y)*env_pitch().y 
        : (outer_num_y-grid_num_y)/2*env_pitch().y,
    0];

  //front back left right
  $allowConnectors = [
      grid_num_y >= outer_num_y || position_grid_in_outer_y == "near", 
      grid_num_y >= outer_num_y || position_grid_in_outer_y == "far",
      grid_num_x >= outer_num_x || position_grid_in_outer_x == "near", 
      grid_num_x >= outer_num_x || position_grid_in_outer_x == "far"];

  if(env_help_enabled("debug")) echo("frame_plain", allowConnectors=$allowConnectors, grid_num_x=grid_num_x, position_grid_in_outer_x=position_grid_in_outer_x, centerGridPosition=centerGridPosition);
  difference() {
    color(color_cup)
    translate([0,0,-extra_down])
    union(){
      //padded outer material
      hull_conditional(reduceWallTaper){
        //padded outer lower
        outer_baseplate(
          num_x  =max(grid_num_x, outer_num_x), 
          num_y = max(grid_num_y, outer_num_y), 
          trim = trim, 
          height = outer_height > 0 
            ? outer_height 
            : reducedWallHeight >= 0 ? extra_down+reducedWallHeight : extra_down+frameLipHeight,
          cornerRadius = cornerRadius,
          roundedCorners = roundedCorners);
        
        //padded outer upper
        translate(centerGridPosition)
        outer_baseplate(
          num_x=grid_num_x, 
          num_y=grid_num_y, 
          trim=trim, 
          height=extra_down + (reducedWallHeight >= 0 ? reducedWallHeight : frameLipHeight),
          cornerRadius = cornerRadius,
          roundedCorners = roundedCorners);
      }
    
      //full outer material to build from
      translate(centerGridPosition)
      outer_baseplate(
        num_x=grid_num_x, 
        num_y=grid_num_y, 
        trim=trim, 
        height=extra_down+frameLipHeight,
        cornerRadius = cornerRadius,
        roundedCorners = roundedCorners);
    }
    
    //Wall reduction
    translate(centerGridPosition)
    frame_cavity(
      num_x=grid_num_x, 
      num_y=grid_num_y, 
      position_fill_grid_x = position_fill_grid_x,
      position_fill_grid_y = position_fill_grid_y,
      extra_down = extra_down, 
      frameLipHeight = frameLipHeight,
      cornerRadius = env_corner_radius(),
      reducedWallHeight = reducedWallHeight){
        if($children >=1) children(0); 
        if($children >=2) children(1);
      }
  }
}
debug_baseplate_cavities = false;
if(debug_baseplate_cavities){
  baseplate_cavities(1,1,10);
  
  translate([50,0,0])
  baseplate_cavities(1,1,10, magnetSize=[0,0]);
  translate([100,0,0])
  baseplate_cavities(1,1,10, centerScrewEnabled=true);
  translate([150,0,0])
  baseplate_cavities(1,1,10, magnetSize=[0,0], centerScrewEnabled=true);

  translate([0,50,0])
  baseplate_cavities(1,1,10, weightHolder=true);
  translate([50,50,0])
  baseplate_cavities(1,1,10, weightHolder=true, magnetSize=[0,0]);
  translate([100,50,0])
  baseplate_cavities(1,1,10, weightHolder=true, centerScrewEnabled=true);
  translate([150,50,0])
  baseplate_cavities(1,1,10, weightHolder=true, magnetSize=[0,0], centerScrewEnabled=true);

  translate([0,100,0])
  baseplate_cavities(1,1,10, cornerScrewEnabled=true);
  translate([50,100,0])
  baseplate_cavities(1,1,10, cornerScrewEnabled=true, magnetSize=[0,0]);
  translate([100,100,0])
  baseplate_cavities(1,1,10, cornerScrewEnabled=true, centerScrewEnabled=true);
  translate([150,100,0])
  baseplate_cavities(1,1,10, cornerScrewEnabled=true, magnetSize=[0,0], centerScrewEnabled=true);
}

module baseplate_cavities(
  num_x, 
  num_y,  
  baseCavityHeight,
  magnetSize = [gf_baseplate_magnet_od,gf_baseplate_magnet_thickness],
  magnetZOffset = 0,
  magnetTopCover = 0,
  magnetSouround = true,
  centerScrewEnabled = false,
  cornerScrewEnabled = false,
  weightHolder = false,
  cornerRadius = gf_cup_corner_radius,
  roundedCorners = 15,
  reverseAlignment = [false, false]) {

  assert(is_num(num_x) && num_x >= 0 && num_x <=1, "num_x must be a number between 0 and 1");
  assert(is_num(num_y) && num_y >= 0 && num_y <=1, "num_y must be a number between 0 and 1");
  assert(is_num(baseCavityHeight), "baseCavityHeight must be a number");
  
  fudgeFactor = 0.01;

  magnet_position = baseCavityHeight-magnetSize.y-magnetTopCover-fudgeFactor;
  magnet_easy_release = ((magnetZOffset > 0) != (magnetTopCover>0)) ? MagnetEasyRelease_outer : MagnetEasyRelease_off;
  echo(magnet_position=magnet_position, baseCavityHeight=baseCavityHeight, magnetSize=magnetSize );
      
  if(env_help_enabled("debug")) echo("baseplate_cavities", baseCavityHeight=baseCavityHeight, magnetSize=magnetSize, magnetZOffset=magnetZOffset, magnetTopCover=magnetTopCover);
   
  counterSinkDepth = 2.5;
  screwOuterChamfer = 8.5;
  weightDepth = 4;

  magnet_screw_size = max(
        cornerScrewEnabled ? 8.5 : 0,
        magnetSize[0]);
  magnet_screw_position = calculateAttachmentPositions(magnet_screw_size);
  magnetborder = 5;
  
  _centerScrewEnabled = centerScrewEnabled && num_x >= 1 && num_y >=1;
  _weightHolder = weightHolder && num_x >= 1 && num_y >=1;
  
  translate([
    (reverseAlignment.x ? (-1/2+num_x) : 1/2)*env_pitch().x,
    (reverseAlignment.y ? (-1/2+num_y) : 1/2)*env_pitch().y, 0])
  union(){
    gridcopycorners(r=magnet_screw_position, num_x=num_x, num_y=num_y, center= true, reverseAlignment = reverseAlignment) {
      //Magnets
        rdeg =
          $gcci[2] == [ 1, 1] ? 90 :
          $gcci[2] == [-1, 1] ? 180 :
          $gcci[2] == [-1,-1] ? -90 :
          $gcci[2] == [ 1,-1] ? 0 : 0;
        rotate([0,0,rdeg-45+(magnet_easy_release==MagnetEasyRelease_outer ? 0 : 180)])
      translate([0, 0, magnetSize.y/2+magnet_position])
      mirror(magnet_position <= 0 ? [0,0,0] : [0,0,1])
      magnet_easy_release(
        magnetDiameter=magnetSize[0], 
        magnetThickness=magnetSize.y+fudgeFactor, 
        easyMagnetRelease=magnet_easy_release != MagnetEasyRelease_off,
        center = true);
      //cylinder(d=magnetSize[0], h=magnetSize.y);

      // counter-sunk holes in the bottom
      if(cornerScrewEnabled){
        cylinder(d=3.5, h=baseCavityHeight);
        translate([0, 0, -fudgeFactor]) 
          cylinder(d1=8.5, d2=3.5, h=counterSinkDepth);
      }
    }
    
    if(_weightHolder){
      translate([-10.7, -10.7, -fudgeFactor]) 
        cube([21.4, 21.4, weightDepth + fudgeFactor]);
        
       for (a2=[0,90]) {
        rotate([0, 0, a2])
        hull() 
          for (a=[0, 180]) 
            rotate([0, 0, a]) 
            translate([-14.9519, 0, -fudgeFactor])
              cylinder(d=8.5, h=2.01);
      }
    }
    
    if(_centerScrewEnabled)
    {
      //counter-sunk holes for woodscrews
      union(){
        translate([0, 0, baseCavityHeight-counterSinkDepth]) 
          cylinder(d1=3.5, d2=8.5, h=counterSinkDepth);
        translate([0, 0, -fudgeFactor]) 
          cylinder(d=3.5, h=baseCavityHeight);
      }
    }
    
    //rounded souround for the magnet
    if(magnetSouround && !_centerScrewEnabled && !_weightHolder){
      supportDiameter = magnet_screw_size + magnetborder;

      difference(){
        translate([-env_pitch().x/2,-env_pitch().y/2,0])
          cube([env_pitch().x,env_pitch().y,baseCavityHeight]);
        if((cornerScrewEnabled || magnetSize[0]> 0))
        translate([0, 0, -fudgeFactor*2]) 
        gridcopycorners(r=magnet_screw_position, num_x=num_x, num_y=num_y, center= true, reverseAlignment = reverseAlignment) {
          rdeg =
            $gcci[2] == [ 1, 1] ? 90 :
            $gcci[2] == [-1, 1] ? 180 :
            $gcci[2] == [-1,-1] ? -90 :
            $gcci[2] == [ 1,-1] ? 0 : 0;
          rotate([0,0,rdeg])
            //magnet retaining ring
            union(){
              magnetSupportWidth = max(17/2,supportDiameter);
              cylinder(d=supportDiameter, h=baseCavityHeight+fudgeFactor*4);

              translate([magnetSupportWidth/2, -magnetSupportWidth/2+supportDiameter/2, baseCavityHeight/2]) 
                cube([magnetSupportWidth,magnetSupportWidth,baseCavityHeight+fudgeFactor*6],center = true);

              translate([magnetSupportWidth/2-supportDiameter/2, -magnetSupportWidth/2, baseCavityHeight/2]) 
                cube([magnetSupportWidth,magnetSupportWidth,baseCavityHeight+fudgeFactor*6],center = true);
            }
          }
      }
    }
  }
}

module outer_baseplate(
  num_x, 
  num_y, 
  height = 4,
  baseTaper = 0, 
  extendedDepth = 0,
  trim=0, 
  cornerRadius = gf_cup_corner_radius,
  roundedCorners = 15){
    
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(height), "height must be a number");
  assert(is_num(baseTaper), "baseTaper must be a number");
  assert(is_num(extendedDepth), "extendedDepth must be a number");
  assert(is_num(trim), "trim must be a number");
  assert(is_num(cornerRadius), "cornerRadius must be a number");
  assert(is_num(roundedCorners), "roundedCorners must be a number");
  
    fudgeFactor = 0.01;
  corner_position = [env_pitch().x/2-cornerRadius-trim, env_pitch().y/2-cornerRadius-trim];
 //full outer material to build from
  hull() 
    cornercopy(corner_position, num_x, num_y) {
      radius = max(bitwise_and(roundedCorners, decimaltobitwise($idx[0],$idx[1])) > 0 ? cornerRadius : 0.01, 0.01);// 0.01 is almost zero to get a square edge....
      ctrn = [
        ($idx[0] == 0 ? -1 : 1)*(cornerRadius-radius), 
        ($idx[1] == 0 ? -1 : 1)*(cornerRadius-radius), -extendedDepth];
      translate(ctrn)
      union(){
        translate([0, 0, baseTaper])
          cylinder(r=radius, h=height+extendedDepth-baseTaper);
        cylinder(r2=radius,r1=baseTaper, h=baseTaper+fudgeFactor);
      }
    }
}
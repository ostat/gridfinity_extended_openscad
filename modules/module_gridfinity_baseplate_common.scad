// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
use <module_gridfinity.scad>

iBaseplateTypeSettings_SupportsMagnets = true;

//This should be a function and should match the cup function
function magnet_position(magnetDiameter, pitch = gf_pitch) = min(pitch/2-8, pitch/2-4-magnetDiameter/2);
  
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
    reducedWallHeight = 0,
    roundedCorners = 15,
    reduceWallTaper = false) {
  frameLipHeight = extra_down > 0 ? height -0.6 : height;
  frameWallReduction = reducedWallHeight > 0 ? max(0, frameLipHeight-reducedWallHeight) : 0;

  centerGridPosition = [
    position_grid_in_outer_x == "near" || grid_num_x >= outer_num_x ? 0 
      : position_grid_in_outer_x == "far" 
        ? (outer_num_x-grid_num_x)*gf_pitch 
        : (outer_num_x-grid_num_x)/2*gf_pitch,
    position_grid_in_outer_y == "near" || grid_num_y >= outer_num_y ? 0 
      : position_grid_in_outer_y == "far" 
        ? (outer_num_y-grid_num_y)*gf_pitch 
        : (outer_num_y-grid_num_y)/2*gf_pitch,
    0];

  echo(grid_num_x=grid_num_x, position_grid_in_outer_x=position_grid_in_outer_x, centerGridPosition=centerGridPosition);
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
            : reducedWallHeight > 0 ? extra_down+reducedWallHeight : extra_down+frameLipHeight,
          cornerRadius = cornerRadius,
          roundedCorners = roundedCorners);
        
        //padded outer upper
        translate(centerGridPosition)
        outer_baseplate(
          num_x=grid_num_x, 
          num_y=grid_num_y, 
          trim=trim, 
          height=extra_down + (reducedWallHeight > 0 ? reducedWallHeight : frameLipHeight),
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
      cornerRadius = gf_cup_corner_radius,
      reducedWallHeight = reducedWallHeight)
        children();
  }
}

module hull_conditional(enabled = true)
{
  echo("hull_conditional", enabled=enabled)
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

module frame_cavity(
    num_x, 
    num_y, 
    position_fill_grid_x = "near",
    position_fill_grid_y = "near",
    extra_down=0, 
    frameLipHeight = 4,
    cornerRadius = gf_cup_corner_radius,
    reducedWallHeight = 0) {
  frameWallReduction = reducedWallHeight > 0 ? max(0, frameLipHeight-reducedWallHeight) : 0;
    translate([0, 0, -fudgeFactor]) 
      gridcopy(
        num_x, 
        num_y,
        positionGridx = position_fill_grid_x,
        positionGridy = position_fill_grid_y) {
      if($gc_size.x > 0.2 && $gc_size.y >= 0.2){
        if(frameWallReduction>0)
          for(side=[[0, [$gc_size.x, $gc_size.y]*gf_pitch],[90, [$gc_size.y, $gc_size.x]*gf_pitch]]){
          if(side[1].x >= gf_pitch/2)
           translate([$gc_size.x/2*gf_pitch,$gc_size.y/2*gf_pitch,frameLipHeight])
           rotate([0,0,side[0]])
            WallCutout(
              lowerWidth=side[1].x-15,
              wallAngle=80,
              height=frameWallReduction,
              thickness=side[1].y+fudgeFactor*2,
              cornerRadius=frameWallReduction,
              topHeight=1);
            }
            
          pad_oversize(
            margins=1,
            extend_down=extra_down,
            $gc_size.x,
            $gc_size.y)
                children();
    }
  }
}

module baseplate_cavities(
  num_x, 
  num_y,  
  baseCavityHeight,
  magnetSize = [gf_baseplate_magnet_od,gf_baseplate_magnet_thickness],
  magnetZOffset = 0,
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
  
  if(IsHelpEnabled("debug")) echo("baseplate_cavities", baseCavityHeight=baseCavityHeight, magnetSize=magnetSize, magnetZOffset=magnetZOffset);
    
  counterSinkDepth = 2.5;
  screwOuterChamfer = 8.5;
  weightDepth = 4;

  magnet_position = magnet_position(magnetSize[0]);
  magnetborder = 5;
  
  _centerScrewEnabled = centerScrewEnabled && num_x >= 1 && num_y >=1;
  _weightHolder = weightHolder && num_x >= 1 && num_y >=1;
  
  translate([
    (reverseAlignment.x ? (-1/2+num_x) : 1/2)*gf_pitch,
    (reverseAlignment.y ? (-1/2+num_y) : 1/2)*gf_pitch, 0])
  union(){
    gridcopycorners(r=magnet_position, num_x=num_x, num_y=num_y, center= true, reverseAlignment = reverseAlignment) {
      translate([0, 0, baseCavityHeight-magnetSize.y]) 
      cylinder(d=magnetSize[0], h=magnetSize.y);

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
      supportDiameter = max(
        cornerScrewEnabled ? 8.5 : 0,
        magnetSize[0]) + magnetborder;

      difference(){
        translate([-gf_pitch/2,-gf_pitch/2,0])
          cube([gf_pitch,gf_pitch,baseCavityHeight]);
        if((cornerScrewEnabled || magnetSize[0]> 0))
        translate([0, 0, -fudgeFactor*2]) 
        gridcopycorners(r=magnet_position, num_x=num_x, num_y=num_y, center= true, reverseAlignment = reverseAlignment) {
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
  corner_position = gf_pitch/2-cornerRadius-trim;
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
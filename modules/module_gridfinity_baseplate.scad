// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
use <module_gridfinity.scad>
use <module_gridfinity_baseplate_common.scad>
use <module_gridfinity_baseplate_regular.scad>
use <module_gridfinity_baseplate_cnclaser.scad>

/* [BasePlate] */
// Plate Style
Default_Base_Plate_Options = "default";//[default:Default, cnc:CNC or Laser]
Default_Oversize_method = "fill"; //[crop, fill]

// Magnet
// Enable magnets
Default_Enable_Magnets = true;
//size of magnet, diameter and height. Zacks original used 6.5 and 2.4 
Default_Magnet_Size = [6.5, 2.4];  // .1

/* [Base Plate Clips - POC dont use yet]*/
//This feature is not yet finalised, or working properly. 
Default_Butterfly_Clip_Enabled = false;
Default_Butterfly_Clip_Size = [6,6,1.5];
Default_Butterfly_Clip_Radius = 0.1;
Default_Butterfly_Clip_Tolerance = 0.1;
Default_Butterfly_Clip_Only = false;

//This feature is not yet finalised, or working properly. 
Default_Filament_Clip_Enabled = false;
Default_Filament_Clip_Diameter = 2;
Default_Filament_Clip_Length = 8;

gridfinity_baseplate(
  num_x = 2.5,
  num_y = 3.2);

module gridfinity_baseplate(
  num_x = 2,
  num_y = 3,
  outer_num_x = 0,
  outer_num_y = 0,
  position_fill_grid_x = "near",
  position_fill_grid_y = "near",
  position_grid_in_outer_x = "center",
  position_grid_in_outer_y = "center",
  plate_corner_radius=gf_cup_corner_radius,
  magnetSize = Default_Magnet_Size,
  reducedWallHeight = 0,
  cornerScrewEnabled  = false,
  centerScrewEnabled = false,
  weightedEnable = false,
  oversizeMethod = Default_Oversize_method,
  plateOptions = Default_Base_Plate_Options,
  customGridEnabled = false,
  gridPositions = [[1]],
  butterflyClipEnabled  = Default_Butterfly_Clip_Enabled,
  butterflyClipSize = Default_Butterfly_Clip_Size,
  butterflyClipRadius = Default_Butterfly_Clip_Radius,
  filamentClipEnabled = Default_Filament_Clip_Enabled,
  filamentClipDiameter = Default_Filament_Clip_Diameter,
  filamentClipLength = Default_Filament_Clip_Length)
{
  _gridPositions = customGridEnabled ? gridPositions : [[1]];
  width = oversizeMethod == "fill" ? num_x : ceil(num_x);
  depth = oversizeMethod == "fill" ? num_y : ceil(num_y);

  intersection(){
    union() {
      for(xi = [0:len(_gridPositions)-1])
        for(yi = [0:len(_gridPositions[xi])-1])
        {
          if(_gridPositions[xi][yi])
          {
            translate([gf_pitch*xi,gf_pitch*yi,0])
            baseplate(
              width = customGridEnabled ? 1 : width,
              depth = customGridEnabled ? 1 : depth,
              outer_width = outer_num_x,
              outer_depth = outer_num_y,
              position_fill_grid_x = position_fill_grid_x,
              position_fill_grid_y = position_fill_grid_y,
              position_grid_in_outer_x = position_grid_in_outer_x,
              position_grid_in_outer_y = position_grid_in_outer_y,
              magnetSize = magnetSize,
              reducedWallHeight=reducedWallHeight,
              cornerScrewEnabled = cornerScrewEnabled,
              centerScrewEnabled = centerScrewEnabled,
              weightedEnable = weightedEnable,
              plateOptions= plateOptions,
              butterflyClipEnabled  = butterflyClipEnabled,
              butterflyClipSize = butterflyClipSize,
              butterflyClipRadius = butterflyClipRadius,
              filamentClipEnabled = filamentClipEnabled,
              filamentClipDiameter = filamentClipDiameter,
              filamentClipLength = filamentClipLength,
              plate_corner_radius = plate_corner_radius,
              roundedCorners = _gridPositions[xi][yi] == 1 ? 15 : _gridPositions[xi][yi] - 2);
          }
        }
      }
      if(oversizeMethod == "crop")
        cube([num_x*gf_pitch, num_y*gf_pitch,20]);
  }
}
    
module baseplate(
  width = 2,
  depth = 1,
  outer_width = 0,
  outer_depth = 0,
  position_fill_grid_x = false,
  position_fill_grid_y = false,
  position_grid_in_outer_x = true,
  position_grid_in_outer_y = true,
  magnetSize = [gf_baseplate_magnet_od,gf_baseplate_magnet_thickness],
  reducedWallHeight=0,
  cornerScrewEnabled = false,
  centerScrewEnabled = false,
  weightedEnable = false,
  plateOptions = "default",
  plate_corner_radius = gf_cup_corner_radius,
  roundedCorners = 15,
  butterflyClipEnabled  = Default_Butterfly_Clip_Enabled,
  butterflyClipSize = Default_Butterfly_Clip_Size,
  butterflyClipRadius = Default_Butterfly_Clip_Radius,
  filamentClipEnabled = Default_Filament_Clip_Enabled,
  filamentClipDiameter = Default_Filament_Clip_Diameter,
  filamentClipLength = Default_Filament_Clip_Length)
{
  assert_openscad_version();
  
  difference(){
    union(){
      if (plateOptions == "cnclaser"){
        baseplate_cnclaser(
          num_x=width, 
          num_y=depth,
          magnetSize=magnetSize, 
          roundedCorners=roundedCorners);
      }      
      else {
        baseplate_regular(
          grid_num_x = width, 
          grid_num_y = depth,
          outer_num_x = outer_width,
          outer_num_y = outer_depth,
          position_fill_grid_x = position_fill_grid_x,
          position_fill_grid_y = position_fill_grid_y,
          position_grid_in_outer_x = position_grid_in_outer_x,
          position_grid_in_outer_y = position_grid_in_outer_y,
          magnetSize = magnetSize,
          reducedWallHeight=reducedWallHeight,
          centerScrewEnabled = centerScrewEnabled,
          cornerScrewEnabled = cornerScrewEnabled,
          weightHolder = weightedEnable,
          cornerRadius = plate_corner_radius,
          roundedCorners=roundedCorners);
      }
    }
    
    if(butterflyClipEnabled || filamentClipEnabled){
      gridcopy(width, depth) 
      union(){
        if(IsHelpEnabled("debug")) echo("baseplate", gci=$gci);
        if(butterflyClipEnabled)
          AttachButterFly(size=butterflyClipSize,r=butterflyClipRadius,left=$gci.x==0,right=$gci.x==width-1,front=$gci.y==0,back=$gci.y==depth-1);
          
        if(filamentClipEnabled)
          AttachFilament(l=filamentClipLength,d=filamentClipDiameter,left=$gci.x==0,right=$gci.x==width-1,front=$gci.y==0,back=$gci.y==depth-1);
      }
    }
  }
}

module AttachFilament(l=5, d=1.75,left= true, right=true, front=true, back=true){
 h=4;
  positions = [
    //left
    [left,[0,0, h],[0,90,0]],
    //right
    [right,[gf_pitch,0, h],[0,90,0]],
    //front
    [front,[0, 0,h],[90,0,0]],
    //back
    [back,[0, gf_pitch,h],[90,0,0]]];
  for(pi = [0:len(positions)-1]){
    if(positions[pi][0])
      translate(positions[pi][1])
      rotate(positions[pi][2])
      cylinder(h=l,d=d, center=true,$fn=32);
  }
}

module AttachButterFly(size=[5,3,2],r=0.5,left= true, right=true, front=true, back=true){
  inset = 12;
  if(left || right || front || back){
  
  positions = [
    //left
    [left,[0,inset, -fudgeFactor],[0,0,-90]],
    [left,[0,-inset, -fudgeFactor],[0,0,-90]],
    //right
    [right,[gf_pitch,inset, -fudgeFactor],[0,0,90]],
    [right,[gf_pitch,-inset, -fudgeFactor],[0,0,90]],
    //front
    [front,[inset, 0,-fudgeFactor],[0,0,0]],
    [front,[-inset, 0,-fudgeFactor],[0,0,0]],
    //back
    [back,[inset, gf_pitch,-fudgeFactor],[00,0,180]],
    [back,[-inset, gf_pitch,-fudgeFactor],[0,0,180]]];
  for(pi = [0:len(positions)-1]){
    if(positions[pi][0])
      translate(positions[pi][1])
      rotate(positions[pi][2])
      ButterFly(size,r,taper=false,half=true);
    }
  }
}

module ButterFly(size,r,taper=false,half=false)
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
            cylinder(h=h,r=r,center=true, $fn=32);
        }
      }
    }
    
    if(taper)
    rotate([0,90,0])
    cylinder(h=size.x,r=size.y/2+size.z,$fn=4,center=true);
  }
}



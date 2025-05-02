// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
use <module_gridfinity_block.scad>
use <module_gridfinity_baseplate_common.scad>
use <module_gridfinity_baseplate_lid.scad>

/* [Lid] */
// Plate Style
Default_Lid_Options = "default";//[default, flat:Flat Removes the internal grid from base, halfpitch: halfpitch base, efficient]
Default_Oversize_method = "fill"; //[crop, fill]

Default_Lid_Include_Magnets = true;
// Base height, when the bin on top will sit, in GF units
Default_Lid_Efficient_Base_Height = 0.4;// [0.4:0.1:1]
// Thickness of the efficient floor
Default_Lid_Efficient_Floor_Thickness = 0.7;// [0.7:0.1:7]

// Magnet
// Enable magnets
Default_Enable_Magnets = true;
//size of magnet, diameter and height. Zacks original used 6.5 and 2.4 
Default_Magnet_Size = [6.5, 2.4];  // .1

module gridfinity_lid(
  num_x = 2,
  num_y = 3,
  center_fill_grid_x = false,
  center_fill_grid_y = false,
  magnetSize = Default_Magnet_Size,
  plateStyle = "lid",
  reducedWallHeight = -1,
  lidOptions = Default_Lid_Options,
  lidIncludeMagnets = Default_Lid_Include_Magnets,
  lidEfficientFloorThickness =Default_Lid_Efficient_Floor_Thickness,
  lidEfficientBaseHeight = Default_Lid_Efficient_Base_Height)
{
  assert_openscad_version();

  union(){
    if (plateStyle == "lid_legacy") {
      base_lid(
        num_x=num_x, 
        num_y=num_y,
        lidOptions=lidOptions,
        lidIncludeMagnets = lidIncludeMagnets, 
        lidEfficientFloorThickness = lidEfficientFloorThickness, 
        lidEfficientBaseHeight = lidEfficientBaseHeight);
    } else{
      baseplate_lid(
        num_x=num_x, 
        num_y=num_y,
        lidOptions=lidOptions,
        magnetSize = magnetSize,
        reducedWallHeight=reducedWallHeight,
        lidIncludeMagnets = lidIncludeMagnets, 
        lidEfficientFloorThickness = lidEfficientFloorThickness, 
        lidEfficientBaseHeight = lidEfficientBaseHeight);
    }
  }  
}
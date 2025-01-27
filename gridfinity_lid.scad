// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity.scad>
use <modules/module_gridfinity_lid.scad>

/* [Size] */
// X dimension. grid units (multiples of 42mm) or mm.
Width = [2, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
Depth = [1, 0]; //0.1
center_fill_grid_x = true;
center_fill_grid_y = true;

/* [Lid] */
// Plate Style
Lid_Options = "default";//[default, flat:Flat Removes the internal grid from base, halfpitch: halfpitch base, efficient]

/* [Base Plate Options] */
// Enable magnets in the bin corner
Enable_Magnets = true;
//size of magnet, diameter and height. Zacks original used 6.5 and 2.4 
Magnet_Size = [6.5, 2.4];  // .1
//Reduce the frame wall size to this value
Reduced_Wall_Height = 0; //0.1

/* [Lid Options] */
Lid_Include_Magnets = true;
// Base height, when the bin on top will sit, in GF units
Lid_Efficient_Base_Height = 0.4;// [0.4:0.1:1]
// Thickness of the efficient floor
Lid_Efficient_Floor_Thickness = 0.7;// [0.7:0.1:7]

/* [debug] */
Render_Position = "center"; //[default,center,zero]
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// enable loging of help messages during render.
enable_help = false;

/* [Hidden] */
module end_of_customizer_opts() {}

SetGridfinityEnvironment(
  width = Width,
  depth = Depth,
  render_position = Render_Position,
  help = enable_help,
  cutx = cutx,
  cuty = cuty,
  cutz = 2)
gridfinity_lid(
  num_x = calcDimensionWidth(Width),
  num_y = calcDimensionWidth(Depth),
  center_fill_grid_x = center_fill_grid_x,
  center_fill_grid_y = center_fill_grid_y,
  magnetSize = Enable_Magnets ? Magnet_Size : [0,0],
  reducedWallHeight = Reduced_Wall_Height, 
  lidOptions = Lid_Options,
  lidIncludeMagnets = Lid_Include_Magnets,
  lidEfficientFloorThickness = Lid_Efficient_Floor_Thickness,
  lidEfficientBaseHeight = Lid_Efficient_Base_Height);
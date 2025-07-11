// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_block.scad>
use <modules/module_gridfinity_lid.scad>

/* [Size] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.1
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
Reduced_Wall_Height = -1; //0.1

/* [Lid Options] */
Lid_Include_Magnets = true;
// Base height, when the bin on top will sit, in GF units
Lid_Efficient_Base_Height = 0.4;// [0.4:0.1:1]
// Thickness of the efficient floor
Lid_Efficient_Floor_Thickness = 0.7;// [0.7:0.1:7]

/* [debug] */
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [Model detail] */
//assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
//where to render the model
render_position = "center"; //[default,center,zero]
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments 
fa = 6; 
// minimum size of a fragment.  Low is more fragments
fs = 0.1; 
// number of fragments, overrides $fa and $fs
fn = 0;  
// set random seed for 
random_seed = 0; //0.0001

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;  
  
set_environment(
  width = width,
  depth = depth,
  render_position = render_position,
  help = enable_help,
  cut = [cutx, cuty, 2],
  setColour = set_colour)
gridfinity_lid(
  num_x = calcDimensionWidth(width),
  num_y = calcDimensionWidth(depth),
  center_fill_grid_x = center_fill_grid_x,
  center_fill_grid_y = center_fill_grid_y,
  magnetSize = Enable_Magnets ? Magnet_Size : [0,0],
  reducedWallHeight = Reduced_Wall_Height, 
  lidOptions = Lid_Options,
  lidIncludeMagnets = Lid_Include_Magnets,
  lidEfficientFloorThickness = Lid_Efficient_Floor_Thickness,
  lidEfficientBaseHeight = Lid_Efficient_Base_Height);
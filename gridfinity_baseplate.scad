// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity.scad>
use <modules/module_gridfinity_baseplate.scad>

// Plate Style
Base_Plate_Options = "default";//[default:Efficient base, cnclaser:CNC or Laser cut]
// X dimension. grid units (multiples of 42mm) or mm.
Width = [2, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
Depth = [1, 0]; //0.1
oversize_method = "fill"; //[crop, fill]
position_fill_grid_x = "near";//[near, center, far]
position_fill_grid_y = "near";//[near, center, far]
// X outer dimension. grid units (multiples of 42mm) or mm.
outer_Width = [0, 0]; //0.1
// Y outer dimension. grid units (multiples of 42mm) or mm.
outer_Depth = [0, 0]; //0.1
position_grid_in_outer_x = "center";//[near, center, far]
position_grid_in_outer_y = "center";//[near, center, far]
//Reduce the frame wall size to this value
Reduced_Wall_Height = 0; //0.1
plate_corner_radius = 3.75; //[0:0.01:3.75]

/* [Base Plate Options] */
// Enable magnets in the bin corner
Enable_Magnets = true;
//size of magnet, diameter and height. Zacks original used 6.5 and 2.4 
Magnet_Size = [6.5, 2.4];  // .1

//Enable screws in the bin corner under the magnets
Corner_Screw_Enabled = true;
//Enable hold down screw in the center
Center_Screw_Enabled = true;
//Enable cavity to place frame weights
Enable_Weight = true;

/* [Base Plate Clips - POC don't use yet]*/
//This feature is not yet finalized, or working properly. 
Butterfly_Clip_Enabled = false;
Butterfly_Clip_Size = [6,6,1.5];
Butterfly_Clip_Radius = 0.1;
Butterfly_Clip_Tolerance = 0.1;
Butterfly_Clip_Only = false;

//This feature is not yet finalized, or working properly. 
Filament_Clip_Enabled = false;
Filament_Clip_Diameter = 2;
Filament_Clip_Length = 8;

/* [Custom Grid]*/
//Enable custom grid, you will configure this in the (Lid not supported)
Custom_Grid_Enabled = false;

//Custom gid sizes
//I am not sure it this is really useful, but its possible, so here we are.
//0:off the cell is off
//1:on the cell is on and all corners are rounded
//2-16, are bitwise values used to calculate what corners should be rounded, you need to subtract 2 from the value for the bitwise logic (so it does not clash with 0 and 1).
xpos1 = [3,4,0,0,3,4,0];
xpos2 = [2,2,0,0,2,2,0];
xpos3 = [2,2,0,0,2,2,0];
xpos4 = [2,2,2,2,2,2,0];
xpos5 = [6,2,2,2,2,10,0];
xpos6 = [0,0,0,0,0,0,0];
xpos7 = [0,0,0,0,0,0,0];

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

if(Butterfly_Clip_Only)
{
  ButterFly(
    size=[
      Butterfly_Clip_Size.x+Butterfly_Clip_Tolerance,
      Butterfly_Clip_Size.y+Butterfly_Clip_Tolerance,
      Butterfly_Clip_Size.z],
    r=Butterfly_Clip_Radius);
}
else{
  SetGridfinityEnvironment(
    width = Width,
    depth = Depth,
    render_position = Render_Position,
    help = enable_help,
    cutx = cutx,
    cuty = cuty,
    cutz = 2)
    gridfinity_baseplate(
      num_x = calcDimensionWidth(Width),
      num_y = calcDimensionWidth(Depth),
      outer_num_x = calcDimensionWidth(outer_Width),
      outer_num_y = calcDimensionWidth(outer_Depth),
      position_fill_grid_x = position_fill_grid_x,
      position_fill_grid_y = position_fill_grid_y,
      position_grid_in_outer_x = position_grid_in_outer_x,
      position_grid_in_outer_y = position_grid_in_outer_y,
      plate_corner_radius = plate_corner_radius,
      magnetSize = Enable_Magnets ? Magnet_Size : [0,0],
      reducedWallHeight = Reduced_Wall_Height, 
      cornerScrewEnabled  = Corner_Screw_Enabled,
      centerScrewEnabled = Center_Screw_Enabled,
      weightedEnable = Enable_Weight,
      oversizeMethod=oversize_method,
      plateOptions = Base_Plate_Options,
      customGridEnabled = Custom_Grid_Enabled,
      gridPositions=[xpos1,xpos2,xpos3,xpos4,xpos5,xpos6,xpos7],
      butterflyClipEnabled  = Butterfly_Clip_Enabled,
      butterflyClipSize = Butterfly_Clip_Size,
      butterflyClipRadius = Butterfly_Clip_Radius,
      filamentClipEnabled=Filament_Clip_Enabled,
      filamentClipDiameter=Filament_Clip_Diameter,
      filamentClipLength=Filament_Clip_Length);
}
// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity.scad>
use <modules/module_gridfinity_baseplate.scad>

/* [Size] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.1
oversize_method = "fill"; //[crop, fill]
//Enable custom grid, you will configure this in the (Lid not supported)
Custom_Grid_Enabled = false;
position = "center"; //[default,center,zero]

/* [Plate] */
// Plate Style
Plate_Style = "base"; //[base:Base plate, lid:Lid that is also a gridfinity base]
Base_Plate_Options = "default";//[default:Default, magnet:Efficient magnet base, weighted:Weighted base, woodscrew:Woodscrew, cnc:CNC or Laser cut, cncmagnet:CNC cut with Magnets]
Lid_Options = "default";//[default, flat:Flat Removes the internal grid from base, halfpitch: halfpitch base, efficient]

Lid_Include_Magnets = true;
// Base height, when the bin on top will sit, in GF units
Lid_Efficient_Base_Height = 0.4;// [0.4:0.1:1]
// Thickness of the efficient floor
Lid_Efficient_Floor_Thickness = 0.7;// [0.7:0.1:7]

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
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// enable loging of help messages during render.
help = false;

/* [Hidden] */
module end_of_customizer_opts() {}

num_x = calcDimensionWidth(width); 
num_y = calcDimensionWidth(depth); 

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
  translate(cupPosition(position,num_x,num_y))
  gridfinity_baseplate(
      num_x = num_x,
      num_y = num_y,
      oversizeMethod=oversize_method,
      plateStyle = Plate_Style,
      plateOptions = Base_Plate_Options,
      lidOptions = Lid_Options,
      customGridEnabled = Custom_Grid_Enabled,
      gridPositions=[xpos1,xpos2,xpos3,xpos4,xpos5,xpos6,xpos7],
      butterflyClipEnabled  = Butterfly_Clip_Enabled,
      butterflyClipSize = Butterfly_Clip_Size,
      butterflyClipRadius = Butterfly_Clip_Radius,
      filamentClipEnabled=Filament_Clip_Enabled,
      filamentClipDiameter=Filament_Clip_Diameter,
      filamentClipLength=Filament_Clip_Length,
      lidIncludeMagnets = Lid_Include_Magnets,
      lidEfficientFloorThickness = Lid_Efficient_Floor_Thickness,
      lidEfficientBaseHeight = Lid_Efficient_Base_Height,
      cutx = cutx,
      cuty = cuty,
      help = help);
}
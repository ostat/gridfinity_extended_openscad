// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/gridfinity_modules.scad>
use <modules/module_baseplate.scad>

/* [Plate] */
// Plate Style
Plate_Style = "base"; //[base:Base plate, lid:Lid that is also a gridfinity base]
Base_Plate_Options = "default";//[default:Default, magnet:Efficient magnet base, weighted:Weighted base, woodscrew:Woodscrew]
Lid_Options = "default";//[default, flat:Flat Removes the internal grid from base, halfpitch: halfpitch base, efficient]

Lid_Include_Magnets = true;
// Base height, when the bin on top will sit, in GF units
Lid_Efficient_Base_Height = 0.4;// [0.4:0.1:1]
// Thickness of the efficient floor
Lid_Efficient_Floor_Thickness = 0.7;// [0.7:0.1:7]

/* [Base Plate Clips - POC dont use yet]*/
//This feature is not yet finalised, or working properly. 
Butterfly_Clip_Enabled = false;
Butterfly_Clip_Size = [6,6,1.5];
Butterfly_Clip_Radius = 0.1;
Butterfly_Clip_Tollerance = 0.1;
Butterfly_Clip_Only = false;

//This feature is not yet finalised, or working properly. 
Filament_Clip_Enabled = false;
Filament_Clip_Diameter = 2;
Filament_Clip_Length = 8;

/* [Size] */
// X dimension in grid units  (multiples of 42mm)
Width = 2; // [ 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Y dimension in grid units (multiples of 42mm)
Depth = 1; // [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
//Enable custom grid, you will configure this in the (Lid not supported)
Custom_Grid_Enabled = false;
//I am not sure it this is really usefull, but its possible, so here we are.
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

module end_of_customizer_opts() {}

if(Butterfly_Clip_Only)
{
  ButterFly(
    size=[
      Butterfly_Clip_Size.x+Butterfly_Clip_Tollerance,
      Butterfly_Clip_Size.y+Butterfly_Clip_Tollerance,
      Butterfly_Clip_Size.z],
    r=Butterfly_Clip_Radius);
}
else{
  gridfinity_baseplate(
      width = Width,
      depth = Depth,
      plateStyle = Plate_Style,
      plateOptions = Base_Plate_Options,
      lidOptions = Lid_Options,
      customGridEnabled = Custom_Grid_Enabled,
      gridPossitions=[xpos1,xpos2,xpos3,xpos4,xpos5,xpos6,xpos7],
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
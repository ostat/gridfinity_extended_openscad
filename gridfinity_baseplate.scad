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
// z outer dimension. mm.
outer_Height = 0; //0.1
position_grid_in_outer_x = "center";//[near, center, far]
position_grid_in_outer_y = "center";//[near, center, far]
//Reduce the frame wall size to this value
Reduced_Wall_Height = 0; //0.1
Reduced_Wall_Taper = false; 
plate_corner_radius = 3.75; //[0:0.01:3.75]
/* [Printer bed options] */
build_plate_enabled = "disabled";//[disabled, enabled, unique]
//spread out the plates, use if last row is small.
average_plate_sizes = false;
//Will split the plate in to the 
build_plate_size = [200,250];

/* [Base Plate Options] */
// Enable magnets in the bin corner
Enable_Magnets = false;
//size of magnet, diameter and height. Zacks original used 6.5 and 2.4 
Magnet_Size = [6.5, 2.4];  // .1
//raises the magnet, and creates a floor (for gluding)
Magnet_Z_Offset = 0;  // .1

//Enable screws in the bin corner under the magnets
Corner_Screw_Enabled = false;
//Enable hold down screw in the center
Center_Screw_Enabled = false;
//Enable cavity to place frame weights
Enable_Weight = false;

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
   
function split_dimention(gf_size, gf_outer_size, plate_size, position_fill_grid, position_grid_in_outer, average_plate_sizes = false) =
  assert(is_num(gf_size), "gf_size must be a number")
  assert(is_num(gf_outer_size), "gf_outer_size must be a number")
  assert(is_num(plate_size), "plate_size must be a number")
  assert(is_string(position_fill_grid), "position_fill_grid must be a string")
  assert(is_string(position_grid_in_outer), "position_grid_in_outer must be a string")
  let(
    outerSize = gf_outer_size > gf_size ? gf_outer_size : gf_size,
    outerDelta = gf_outer_size <= 0 ? 0 : outerSize - gf_size,
    outerPrefix =
      position_grid_in_outer == "far" ? outerDelta : 
      position_grid_in_outer == "center" ? outerDelta/2 : 0,
    gridPrefix=
      position_fill_grid == "near" ? gf_size - floor(gf_size) : 
      position_fill_grid == "center" ? (gf_size - floor(gf_size))/2 : 0,
    platesRemaining = ceil(outerSize/plate_size),
    avgSize = platesRemaining > 1 && average_plate_sizes ? gf_size/platesRemaining : plate_size,
    avgOuter = platesRemaining > 1 && average_plate_sizes ? outerSize/platesRemaining : plate_size,
    size1 = outerSize <= plate_size ? gf_size : gridPrefix + floor(avgSize-max(outerPrefix,gridPrefix)),
    outer1 = outerSize <= plate_size ? outerSize : max(outerPrefix,gridPrefix) + floor(avgOuter-max(outerPrefix,gridPrefix)),
    remSize = max(0, gf_size - size1),
    remOuter = max(0, outerSize - max(outer1, size1)))
  //echo("split_dimention", gf_size=gf_size, plate_size=plate_size, platesRemaining=platesRemaining, avgSize=avgSize, gridPrefix=gridPrefix, size1=size1, remSize=remSize)
  //echo("split_dimention", gf_outer_size=gf_outer_size, plate_size=plate_size, platesRemaining=platesRemaining, avgOuter=avgOuter, outerPrefix=outerPrefix, outer1=outer1, remOuter=remOuter)
  let(
    next = remSize > 0 || remOuter > 0 ? split_dimention(remSize, remOuter, plate_size, "far", "near", average_plate_sizes): [],
    posOuter = position_grid_in_outer == "center" && gf_size > plate_size ? "far" : position_grid_in_outer,
    posGrid = position_fill_grid == "center" && gf_size > plate_size ? "near" : position_fill_grid
  )
  concat([[size1, posGrid, outer1 <= size1 ? 0 : outer1, posOuter]], next);

function split_plate(num_x, num_y,
    outer_num_x,
    outer_num_y,
    position_fill_grid_x,
    position_fill_grid_y,
    position_grid_in_outer_x,
    position_grid_in_outer_y,
    build_plate_size,
    average_plate_sizes) =
  let(
    max_x = build_plate_size.x/gf_pitch,
    max_y = build_plate_size.y/gf_pitch,
    list_x = split_dimention(num_x, outer_num_x, max_x, position_fill_grid_x, position_grid_in_outer_x, average_plate_sizes),
    list_y = split_dimention(num_y, outer_num_y, max_y, position_fill_grid_y, position_grid_in_outer_y, average_plate_sizes),
    list = [for(iy=[0:len(list_y)-1]) [for(ix=[0:len(list_x)-1]) [[ix,iy], [list_x[ix],list_y[iy]]]]])
    [for(iy=[0:len(list)-1]) [for(ix=[0:len(list[iy])-1]) let(plate = list[iy][ix]) [plate[0], plate[1], check_plate_duplicate_y(plate, list)]]];


function check_plate_duplicate_y(plate, plate_list, y = 0, end) = 
  assert(is_list(plate), "plate must be a list")
  assert(is_list(plate_list), "plate_list must be a list")
  assert(is_num(y), "y must be a number")
  let(end = is_undef(end) ? len(plate_list) : end)
    y > len(plate_list) - 1 || y > end ? false 
    : check_plate_duplicate_x(plate, plate_list[y]) 
    || check_plate_duplicate_y(plate, plate_list, y = y+1);
    
function check_plate_duplicate_x(plate, plate_list_y, x = 0, end) = 
  assert(is_list(plate), "plate must be a list")
  assert(is_list(plate_list_y), "plate_list_y must be a list")
  assert(is_num(x), "x must be a number")
  //echo("check_plate_duplicate_x", plate=plate)
  let(end = is_undef(end) ? len(plate_list_y) : end)
  x > len(plate_list_y) - 1 || x > end ? false 
  : let(comparePlate = plate_list_y[x],
    isDupe = (comparePlate[0][0] < plate[0][0] || 
      (comparePlate[0][0] == plate[0][0] && comparePlate[0][1] < plate[0][1])) && 
      plate[1][0][iPlate_size] == comparePlate[1][0][iPlate_size] && 
      (plate[1][0][iPlate_size] == floor(plate[1][0][iPlate_size]) || plate[1][0][iPlate_posGrid] == comparePlate[1][0][iPlate_posGrid]) && 
      plate[1][0][iPlate_outerSize] == comparePlate[1][0][iPlate_outerSize] && 
      (plate[1][0][iPlate_outerSize] == 0 || plate[1][0][iPlate_posOuter] == comparePlate[1][0][iPlate_posOuter]) &&
      plate[1][1][iPlate_size] == comparePlate[1][1][iPlate_size] && 
      (plate[1][1][iPlate_size] == floor(plate[1][1][iPlate_size]) || plate[1][1][iPlate_posGrid] == comparePlate[1][1][iPlate_posGrid]) && 
      plate[1][1][iPlate_outerSize] == comparePlate[1][1][iPlate_outerSize] && 
      (plate[1][1][iPlate_outerSize] == 0 || plate[1][1][iPlate_posOuter] == comparePlate[1][1][iPlate_posOuter]))
    isDupe || check_plate_duplicate_x(plate, plate_list_y, x = x+1, end);

iPlate_size = 0;
iPlate_posGrid = 1;
iPlate_outerSize = 2;
iPlate_posOuter = 3;
    
if(Butterfly_Clip_Only)
{
  ButterFly(
    size=[
      Butterfly_Clip_Size.x+Butterfly_Clip_Tolerance,
      Butterfly_Clip_Size.y+Butterfly_Clip_Tolerance,
      Butterfly_Clip_Size.z],
    r=Butterfly_Clip_Radius);
}
else 
{

  plate_list = let(
      num_x=calcDimensionWidth(Width), 
      num_y=calcDimensionDepth(Depth),
      outer_num_x = calcDimensionWidth(outer_Width),
      outer_num_y = calcDimensionWidth(outer_Depth))
    (build_plate_enabled == "disabled" || build_plate_size.x <= 0 || build_plate_size.y <= 0) 
    ? [[[[0,0], [[num_x, position_fill_grid_x, outer_num_x, position_grid_in_outer_x], 
       [num_y, position_fill_grid_y, outer_num_y, position_grid_in_outer_y]], false]]]
    :split_plate(
      num_x=num_x, 
      num_y=num_y,
      outer_num_x = outer_num_x,
      outer_num_y = outer_num_y,
      position_fill_grid_x = position_fill_grid_x,
      position_fill_grid_y = position_fill_grid_y,
      position_grid_in_outer_x = position_grid_in_outer_x,
      position_grid_in_outer_y = position_grid_in_outer_y,
      build_plate_size= build_plate_size,
      average_plate_sizes=average_plate_sizes);
    
  for(iy=[0:len(plate_list)-1])
  let(listy = plate_list[iy])
  for(ix=[0:len(listy)-1]) {
  plate = listy[ix];
  pos = [
    ix*build_plate_size.x+ix*5,
    iy*build_plate_size.y+iy*5,
    0];
  if(build_plate_enabled == "unique" && !plate[2] || build_plate_enabled != "unique")
  conditional_color(len(plate_list) > 1, plate[2] ? "#404040" : "#006400")
  translate(pos)
  conditional_render(true)//plate[2])
  SetGridfinityEnvironment(
    width = plate[1].x[iPlate_size],
    depth = plate[1].y[iPlate_size],
    render_position = Render_Position,
    help = enable_help,
    cutx = cutx,
    cuty = cuty,
    cutz = 2)
    gridfinity_baseplate(
      num_x = plate[1].x[iPlate_size],//calcDimensionWidth(Width),
      num_y = plate[1].y[iPlate_size],//calcDimensionWidth(Depth),
      outer_num_x = plate[1].x[iPlate_outerSize], //calcDimensionWidth(outer_Width),
      outer_num_y = plate[1].y[iPlate_outerSize], //calcDimensionWidth(outer_Depth),
      outer_height = outer_Height,
      position_fill_grid_x = plate[1].x[iPlate_posGrid], //position_fill_grid_x,
      position_fill_grid_y = plate[1].y[iPlate_posGrid], //position_fill_grid_y,
      position_grid_in_outer_x = plate[1].x[iPlate_posOuter], //position_grid_in_outer_x,
      position_grid_in_outer_y = plate[1].y[iPlate_posOuter], //position_grid_in_outer_y,
      plate_corner_radius = plate_corner_radius,
      magnetSize = Enable_Magnets ? Magnet_Size : [0,0],
      magnetZOffset = Magnet_Z_Offset,
      reducedWallHeight = Reduced_Wall_Height, 
      reduceWallTaper = Reduced_Wall_Taper, 
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
}

module conditional_color(enable=true, c){
  if(enable)
  color(c)
    children();
  else
    children();
}

module conditional_render(enable=true){
  if(enable)
  render()
    children();
  else
  union()
    children();
}
// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_block.scad>
use <modules/module_gridfinity_baseplate.scad>
use <modules/module_gridfinity_frame_connectors.scad>

// Plate Style
Base_Plate_Options = "default";//[default:Efficient base, cnclaser:CNC or Laser cut]
// X dimension. grid units (multiples of 42mm) or mm.
Width = [3, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
Depth = [2, 0]; //0.1
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
Reduced_Wall_Height = -1; //0.1
Reduced_Wall_Taper = false; 
plate_corner_radius = 3.75; //0.01
//Corner radius for the inner corners (Works well with build_plate_enabled)
secondary_corner_radius = 3.75; //0.01

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
//raises the magnet, and creates a floor (for gluing)
Magnet_Z_Offset = 0;  // .1
//raises the magnet, and creates a ceiling to capture the magnet
Magnet_Top_Cover = 0;  // .1
// [Magnet Release Options]
// Method to help remove magnets: "none", "slot" (side pry), "hole" (poke from behind)
Magnet_Release_Method = "none"; //[none, slot, hole]
//Enable screws in the bin corner under the magnets
Corner_Screw_Enabled = false;
//Enable hold down screw in the center
Center_Screw_Enabled = false;
//Enable cavity to place frame weights
Enable_Weight = false;
//Removes the bottom taper
Remove_Bottom_Taper = false;

/* [Base Plate Clips]*/
Connector_Only = false;
Connector_Position = "center_wall"; //["center_wall","intersection","both"]

Connector_Clip_Enabled = false;
Connector_Clip_Size = 10;
Connector_Clip_Tolerance = 0.1;

//This feature is not yet finalised, or working properly. 
Connector_Butterfly_Enabled = false;
Connector_Butterfly_Size = [5,4,1.5];
Connector_Butterfly_Radius = 0.1;
Connector_Butterfly_Tolerance = 0.1;

//This feature is not yet finalised, or working properly. 
Connector_Filament_Enabled = false;
Connector_Filament_Diameter = 2;
Connector_Filament_Length = 8;

//This feature is not yet finalised, or working properly. 
Connector_Snaps_Enabled = "disabled"; //["disabled","larger","smaller"]
Connector_Snaps_Clearance = 0.2;

/* [Custom Grid]*/
//Enable custom grid, you will configure this in the (Lid not supported)
Custom_Grid_Enabled = false;

//Custom gid sizes
//I am not sure it this is really useful, but its possible, so here we are.
//0:off the cell is off
//1:on the cell is on and all corners are rounded
//2-16, are bitwise values used to calculate what corners should be rounded, you need to subtract 2 from the value for the bitwise logic (so it does not clash with 0 and 1).
//[c,[x,y]], c corner value as shown above. [x,y] x and y size of the cell.
xpos1 = [3,[2,[3,3]],0,0,2,4,0];
xpos2 = [2,0,0,0,2,2,0];
xpos3 = [2,0,0,0,2,2,0];
xpos4 = [2,2,2,2,2,2,0];
xpos5 = [6,2,2,2,2,10,0];
xpos6 = [0,0,0,0,0,0,0];
xpos7 = [0,0,0,0,0,0,0];

/* [Model detail] */
//Work in progress,  Modify the default grid size. Will break compatibility
pitch = [42,42,7];  //[0:1:9999]
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments 
fa = 6; 
// minimum size of a fragment.  Low is more fragments
fs = 0.1; 
// number of fragments, overrides $fa and $fs
fn = 0;  

/* [debug] */
Render_Position = "center"; //[default,center,zero]
// Debug slice
cut = [0,0,0]; //0.1
// enable loging of help messages during render.
enable_help = false;

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;   

function round_half_down(number, max_allowed) = 
let (up = ceil(number), down = floor(number),
    result = (number - down <= 0.5 || up > max_allowed) ? down : up)
  echo("round_half_down", number=number, up=up, down=down, max_allowed=max_allowed, result=result, lessthan=number - down <= 0.5, upgreater=up > max_allowed)
  result;

function split_dimension(
    gf_size,                // The size of the grid (inner dimension of the grid area)
    gf_outer_size,          // The outer bounding size (outer dimension of the grid area)
    plate_size,           // The size of each plate or segment to split into
    position_fill_grid, //grid_alignment,         // Alignment of the grid within the bounding area ("near", "center", "far")
    position_grid_in_outer, //bounding_alignment,     // Alignment of the bounding area relative to the grid ("near", "center", "far")
    average_plate_sizes = false // Whether to average the sizes of the segments
) =
  assert(is_num(gf_size), "gf_size must be a number")
  assert(is_num(gf_outer_size), "gf_outer_size must be a number")
  assert(is_num(plate_size), "plate_size must be a number")
  assert(is_string(position_fill_grid), "position_fill_grid must be a string")
  assert(is_string(position_grid_in_outer), "position_grid_in_outer must be a string")
  let(
    // Determine the larger size between gf_size and gf_outer_size
    totalOuterSize = gf_outer_size > gf_size ? gf_outer_size : gf_size,
    outerPadding = max(0, totalOuterSize - gf_size),

    // Calculate offsets based on position, 
    //only used on first plate
    outerPrefix =
      position_grid_in_outer == "far" ? outerPadding : 
      position_grid_in_outer == "center" ? outerPadding/2 : 0,
    gridPrefix=
      position_fill_grid == "near" ? gf_size - floor(gf_size) : 
      position_fill_grid == "center" ? (gf_size - floor(gf_size))/2 : 0,

    // Calculate the number of plates and average sizes
    platesRemaining = ceil(totalOuterSize/plate_size),
    avgOuter = platesRemaining > 1 && average_plate_sizes ? totalOuterSize/platesRemaining : plate_size,
    //avgSize = platesRemaining > 1 && average_plate_sizes ? gf_size/platesRemaining : plate_size,
    max_allowed_grid_size = min(gf_size, plate_size-outerPrefix),

    // Calculate the size and outer size for the this plate
    current_grid_size = totalOuterSize <= plate_size
      ? gf_size 
      : gridPrefix + max(0, round_half_down(min(gf_size, avgOuter-outerPrefix-gridPrefix), max_allowed =plate_size-outerPrefix-gridPrefix)),
    current_outer_size = totalOuterSize <= plate_size
      ? totalOuterSize 
      : current_grid_size + outerPrefix, 

    // Calculate the remaining size and outer size
    remSize = max(0, gf_size - current_grid_size),
    remOuter = max(0, totalOuterSize - current_outer_size)
  )
  echo("🟪split_dimension", gf_size=gf_size, position_fill_grid=position_fill_grid, plate_size=plate_size, platesRemaining=platesRemaining, gridPrefix=gridPrefix, current_grid_size=current_grid_size, remSize=remSize, max_allowed_grid_size=max_allowed_grid_size)
  echo("split_dimension", gf_outer_size=gf_outer_size, position_grid_in_outer=position_grid_in_outer, plate_size=plate_size, platesRemaining=platesRemaining, avgOuter=avgOuter, outerPrefix=outerPrefix, current_outer_size=current_outer_size, remOuter=remOuter)
  assert(current_outer_size > 0)
  let(
    next = remSize > 0 || remOuter > 0 ? split_dimension(remSize, remOuter, plate_size, "far", "near", average_plate_sizes): [],
    posOuter = position_grid_in_outer == "center" && totalOuterSize > plate_size ? "far" : position_grid_in_outer,
    posGrid =  position_fill_grid == "center" && gf_size > plate_size ? "near" : position_fill_grid
  )
  echo("split_dimension", next=next, posOuter=posOuter, posGrid=posGrid, current_grid_size=current_grid_size, current_outer_size=current_outer_size)
  concat([[current_grid_size, posGrid, current_outer_size <= current_grid_size ? 0 : current_outer_size, posOuter]], next);

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
    max_x = build_plate_size.x/env_pitch().x,
    max_y = build_plate_size.y/env_pitch().y,
    list_x = split_dimension(num_x, outer_num_x, max_x, position_fill_grid_x, position_grid_in_outer_x, average_plate_sizes),
    list_y = split_dimension(num_y, outer_num_y, max_y, position_fill_grid_y, position_grid_in_outer_y, average_plate_sizes),
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
    
if(Connector_Only)
{
  if(Connector_Clip_Enabled) {
    ClipConnector(
      size=Connector_Clip_Size, 
      clearance = Connector_Clip_Tolerance,
      fullIntersection = true);

    translate([0,15,0])
    ClipConnector(
      size=Connector_Clip_Size, 
      straightIntersection = true,
      clearance = Connector_Clip_Tolerance);
    
    translate([0,30,0])
    ClipConnector(
      size=Connector_Clip_Size, 
      straightWall = true,
      clearance = Connector_Clip_Tolerance);
  }
  
  if(Connector_Butterfly_Enabled)
  translate([20,0,0])
  ButterFlyConnector(
    size=[
      Connector_Butterfly_Size.x-Connector_Butterfly_Tolerance,
      Connector_Butterfly_Size.y-Connector_Butterfly_Tolerance,
      Connector_Butterfly_Size.z-Connector_Butterfly_Tolerance],
    r=Connector_Butterfly_Radius);
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
    ix*build_plate_size.x*1.1+ix*5,
    iy*build_plate_size.y*1.1+iy*5,
    0];
  if(build_plate_enabled == "unique" && !plate[2] || build_plate_enabled != "unique")
  color_conditional(len(plate_list) > 1, plate[2] ? "#404040" : "#006400")
  translate(pos)
  render_conditional(len(plate_list) > 1)//plate[2])
  set_environment(
    width = plate[1].x[iPlate_size],
    depth = plate[1].y[iPlate_size],
    render_position = Render_Position,
    pitch = pitch,
    help = enable_help,
    cut = cut)
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
      secondary_corner_radius = secondary_corner_radius,
      corner_roles = let(
          nx=len(listy), 
          ny=len(plate_list)
        ) [
          (ix==0 && iy==0) ? 1 : 0,       // BL (0,0) -> 0
          (ix==0 && iy==ny-1) ? 1 : 0,    // TL (0,1) -> 1
          (ix==nx-1 && iy==0) ? 1 : 0,    // BR (1,0) -> 2
          (ix==nx-1 && iy==ny-1) ? 1 : 0   // TR (1,1) -> 3
        ],
      magnetSize = Enable_Magnets ? Magnet_Size : [0,0],
      magnetZOffset = Magnet_Z_Offset,
      magnetTopCover=Magnet_Top_Cover,
      magnetReleaseMethod = Magnet_Release_Method,
      reducedWallHeight = Reduced_Wall_Height, 
      reduceWallTaper = Reduced_Wall_Taper, 
      cornerScrewEnabled  = Corner_Screw_Enabled,
      centerScrewEnabled = Center_Screw_Enabled,
      weightedEnable = Enable_Weight,
      oversizeMethod=oversize_method,
      plateOptions = Base_Plate_Options,
      customGridEnabled = Custom_Grid_Enabled,
      gridPositions=[xpos1,xpos2,xpos3,xpos4,xpos5,xpos6,xpos7],
      remove_bottom_taper=Remove_Bottom_Taper,
      frameConnectorSettings = FrameConnectorSettings(
        connectorOnly = Connector_Only, 
        connectorPosition = Connector_Position, 
        connectorClipEnabled = Connector_Clip_Enabled,
        connectorClipSize = Connector_Clip_Size,
        connectorClipTolerance = Connector_Clip_Tolerance, 
        connectorButterflyEnabled = Connector_Butterfly_Enabled,
        connectorButterflySize = Connector_Butterfly_Size,
        connectorButterflyRadius = Connector_Butterfly_Radius,
        connectorButterflyTolerance = Connector_Butterfly_Tolerance,
        connectorFilamentEnabled = Connector_Filament_Enabled,
        connectorFilamentDiameter = Connector_Filament_Diameter,
        connectorFilamentLength = Connector_Filament_Length,
        connectorSnapsStyle = Connector_Snaps_Enabled,
        connectorSnapsClearance = Connector_Snaps_Clearance)
    );
  }
}

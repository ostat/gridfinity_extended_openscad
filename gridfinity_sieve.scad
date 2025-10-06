include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity_block.scad>

/*<!!start gridfinity_sieve!!>*/
/* [Sieve] */
// Should the grid be square or hex
sieve_grid_style = "hexgrid"; //[grid, hexgrid]
// Spacing around the holes
sieve_strength = 3; //0.1
// rotate the grid
sieve_rotate_grid = false;
// 45 deg chamfer added to the top of the hole (mm)
sieve_hole_chamfer = 0; //0.5
// The number of sides for the hole, when custom is selected
sieve_hole_sides = 6; 
// The size the hole, when custom is selected
sieve_cell_size = [10, 10]; //0.1
// Spacing around the compartments
sieve_compartment_clearance= 7; //0.1
sieve_compartment_fill = "none"; //["none", "space", "crop"]
/*<!!end gridfinity_sieve!!>*/

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.5
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.5
// Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [3, 0]; //0.1
// Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
//under size the bin top by this amount to allow for better stacking
headroom = 0.8; // 0.1

/* [Cup Lip] */
// Style of the cup lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [1,1]; //0.1
// Create a relie
lip_top_relief_height = -1; // 0.1
// add a notch to the lip to prevent sliding.
lip_top_notches  = true;

/* [Base] */
// (Zack's design uses magnet diameter of 6.5)
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 2;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "smooth";//[off,on,rounded,smooth] 
// Removes the internal grid from base the shape
flat_base = true;

/* [Label] */
label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]

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
/*<!!end gridfinity_basic_cup!!>*/

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;  

function addClearance(dim, clearance) =
    [dim.x > 0 ? dim.x+clearance : 0
    ,dim.y > 0 ? dim.y+clearance : 0
    ,dim.z];

// Generates the gridfinity bin with cutouts.
// Runs the function without needing to pass the variables.
module gridfinity_sieve(
  //sieve settings
  sieve_grid_style = sieve_grid_style,
  sieve_hole_sides = sieve_hole_sides,
  sieve_rotate_grid = sieve_rotate_grid,
  sieve_cell_size = sieve_cell_size,
  sieve_strength = sieve_strength,
  sieve_hole_chamfer = sieve_hole_chamfer,
  sieve_compartment_clearance = sieve_compartment_clearance,
  sieve_compartment_fill  = sieve_compartment_fill,
    
  //gridfinity settings
  width=width, depth=depth, height=height,
  position=render_position,
  label_settings=LabelSettings(
    labelStyle=label_style, 
    labelPosition=label_position, 
    labelSize=label_size,
    labelRelief=label_relief,
    labelWalls=label_walls),
  cupBase_settings = CupBaseSettings(
    magnetSize = [0,0], 
    centerMagnetSize = [0,0], 
    screwSize = [0,0], 
    floorThickness = floor_thickness,
    cavityFloorRadius = cavity_floor_radius,
    efficientFloor=efficient_floor,
    halfPitch=false,
    flatBase=flat_base,
    spacer=false),
  wall_thickness=wall_thickness,
  lip_settings = LipSettings(
    lipStyle=lip_style, 
    lipSideReliefTrigger=lip_side_relief_trigger, 
    lipTopReliefHeight=lip_top_relief_height, 
    lipNotch=lip_top_notches)) {
  
  difference() {
    num_x = calcDimensionWidth(width);
    num_y = calcDimensionDepth(depth);
    num_z = calcDimensionHeight(height);
    
    cellSize = is_list(sieve_cell_size) ? sieve_cell_size : [sieve_cell_size, sieve_cell_size];
    /*<!!start gridfinity_basic_cup!!>*/
    gridfinity_cup(
      width=width, depth=depth, height=height,
      label_settings=label_settings,
      filled_in=false,
      cupBase_settings=cupBase_settings,
      wall_thickness=wall_thickness,
      lip_settings=lip_settings,
      headroom=headroom,
        floor_pattern_settings = PatternSettings(
        patternEnabled = true, 
        patternStyle = sieve_grid_style, 
        patternFill = sieve_compartment_fill,
        patternBorder = sieve_compartment_clearance, 
        patternCellSize = cellSize, 
        patternStrength = sieve_strength,
        patternHoleSides = 6,
        patternRotateGrid = sieve_rotate_grid,
        patternGridChamfer=sieve_hole_chamfer));
    /*<!!end gridfinity_basic_cup!!>*/
  }
}

set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  cut = [cutx, cuty, height])
gridfinity_sieve();
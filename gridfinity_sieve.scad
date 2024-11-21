include <modules/module_item_holder.scad>
include <modules/gridfinity_constants.scad>
include <modules/functions_general.scad>
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity.scad>

/*<!!start gridfinity_sieve!!>*/

// Should the grid be square or hex
sieve_grid_style = "hex"; //["square","hex","auto"]
//Spacing around the holes
sieve_hole_spacing = 3; //0.1
// 45 deg chamfer added to the top of the hole (mm)
sieve_hole_chamfer = 0; //0.5
// The number of sides for the hole, when custom is selected
sieve_hole_sides = 6; 
// The size the hole, when custom is selected
sieve_hole_size = [10, 10]; //0.1
// Spacing around the compartments
sieve_compartment_clearance= 7; //0.1
// Center the holes within the compartments
sieve_compartment_centered = true; //0.1
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
// Remove some or all of lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
position = "center"; //[default,center,zero]
//under size the bin top by this amount to allow for better stacking
zClearance = 0; // 0.1
      
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
enable_help = false;
/*<!!end gridfinity_basic_cup!!>*/

module end_of_customizer_opts() {}

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
  sieve_hole_size = sieve_hole_size,
  sieve_hole_spacing = sieve_hole_spacing,
  sieve_hole_chamfer = sieve_hole_chamfer,
  sieve_compartment_centered = sieve_compartment_centered,
  sieve_compartment_clearance = sieve_compartment_clearance,
  sieve_compartment_fill  = sieve_compartment_fill,
    
  //gridfinity settings
  width=width, depth=depth, height=height,
  position=position,
  label_settings=LabelSettings(
    labelStyle=label_style, 
    labelPosition=label_position, 
    labelSize=label_size,
    labelRelief=label_relief,
    labelWalls=label_walls),
  cupbase_settings = CupBaseSettings(
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
  lip_style=lip_style,
  cutx=cutx,
  cuty=cuty,
  help=help) {
  
  difference() {
    num_x = calcDimensionWidth(width);
    num_y = calcDimensionDepth(depth);
    num_z = calcDimensionHeight(height);
    
    holeSize = is_list(sieve_hole_size) ? sieve_hole_size : [sieve_hole_size,sieve_hole_size];
    /*<!!start gridfinity_basic_cup!!>*/
    gridfinity_cup(
      width=width, depth=depth, height=height,
      position=position,
      label_settings=label_settings,
      filled_in=false,
      cupbase_settings=cupbase_settings,
      wall_thickness=wall_thickness,
      lip_style=lip_style,
      zClearance=zClearance,
      cutx=cutx,
      cuty=cuty,
      help = enable_help);
    /*<!!end gridfinity_basic_cup!!>*/

    color(color_extension)
    translate([0,0,-fudgeFactor])
      GridItemHolder(
        canvasSize = [num_x*gf_pitch,num_y*gf_pitch],
        hexGrid = sieve_grid_style == "hex",
        //customShape = item[4] == "square",
        circleFn = sieve_hole_sides,
        holeSize = holeSize,
        holeSpacing = [sieve_hole_spacing,sieve_hole_spacing],
        holeGrid = [0,0],
        holeHeight = floor_thickness+fudgeFactor*6,//_depth+fudgeFactor,
        holeChamfer = sieve_hole_chamfer,
        border = sieve_compartment_clearance,
        center=sieve_compartment_centered,
        fill=sieve_compartment_fill,
        help=help);
  }
}

gridfinity_sieve();
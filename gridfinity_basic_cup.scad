// include <gridfinity_modules.scad>
use <modules/gridfinity_cup_modules.scad>
include <modules/gridfinity_constants.scad>

/* [General Cup] */
// X dimension in grid units  (multiples of 42mm)
width = 2; // [ 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Y dimension in grid units (multiples of 42mm)
depth = 1; // [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Z dimension (multiples of 7mm)
height = 3; //0.1
// Fill in solid block (overrides all following options)
filled_in = false;
// Include overhang for labeling (and specify left/right/center justification)
withLabel = "disabled"; // ["disabled", "left", "right", "center", "leftchamber", "rightchamber", "centerchamber"]
// Width of the label in number of units, or zero means full width
labelWidth = 0;  // .01
// Wall thickness (Zack's design is 0.95)
wall_thickness = 0.95;  // .01
// Remove some or all of lip
lip_style = "normal";  // [ "normal", "reduced", "none" ]

/* [Subdivisions] */
// X dimension subdivisions
chambers = 1;
// Enable irregular subdivisions
irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
separator_positions = [ 0.25, 0.5, 1, 1.33, 1.66];

/* [Base] */
// (Zack's design uses magnet diameter of 6.5)
magnet_diameter = 0;  // .1
// (Zack's design uses depth of 6)
screw_depth = 0;
// Hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = true;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = false;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
// Efficient floor option saves material and time, but the internal floor is not flat (only applies if no magnets, screws, or finger-slide used)
efficient_floor = false;
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the base grid from inside the shape
flat_base = false;

/* [Finger Slide] */
// Include larger corner fillet
fingerslide = true;
// Radius of the corner fillet
fingerslide_radius = 8;

/* [Tapered Corner] */
tapered_corner = "none"; //[none, rounded, champhered]
tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [Wall Cutout] */
wallcutout_enabled=false;
// wall to enable on, front, back, left, right.
wallcutout_walls=[1,0,0,0]; 
//default will be binwidth/2
wallcutout_width=0;
wallcutout_angle=70;
//default will be binHeight
wallcutout_height=0;
wallcutout_corner_radius=5;

/* [Wall Pattern] */
// Grid wall pattern
wallpattern_enabled=false;
// set the grid as hex or square
wallpattern_hexgrid = true;
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1]; 
// pattern fill mode
wallpattern_fill = "none"; //["none":No fill, "space":Increase Space, "crop":Over fill and crop]
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = 5; //0.1
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1

/* [debug] */
//Slice along the x axis
cutx = false;
//Slice along the y axis
cuty = false;
// enable loging of help messages during render.
help = false;

module end_of_customizer_opts() {}
difference(){
  union()
  {
    if (filled_in) {
      grid_block(
        width, depth, height, 
        magnet_diameter=magnet_diameter, 
        screw_depth=screw_depth, 
        hole_overhang_remedy=hole_overhang_remedy,
        half_pitch=half_pitch, 
        box_corner_attachments_only=box_corner_attachments_only,
        flat_base = flat_base,
        help = help);
    }
    else {
      sepPositions = irregular_subdivisions 
        ? separator_positions
        : calcualteSeparators(chambers-1,width);
        
      irregular_cup(
        num_x=width, num_y=depth, num_z=height,
        withLabel=withLabel,
        labelWidth=labelWidth,
        fingerslide=fingerslide,
        fingerslide_radius=fingerslide_radius,
        magnet_diameter=magnet_diameter,
        screw_depth=screw_depth,
        floor_thickness=floor_thickness,
        wall_thickness=wall_thickness,
        hole_overhang_remedy=hole_overhang_remedy,
        efficient_floor=efficient_floor,
        separator_positions=sepPositions,
        half_pitch=half_pitch,
        lip_style=lip_style,
        box_corner_attachments_only=box_corner_attachments_only,
        flat_base = flat_base,
        tapered_corner=tapered_corner,
        tapered_corner_size = tapered_corner_size,
        tapered_setback = tapered_setback,
        wallpattern_enabled=wallpattern_enabled,
        wallpattern_hexgrid=wallpattern_hexgrid,
        wallpattern_walls=wallpattern_walls, 
        wallpattern_hole_sides=wallpattern_hole_sides,
        wallpattern_hole_size=wallpattern_hole_size,
        wallpattern_hole_spacing=wallpattern_hole_spacing,
        wallcutout_enabled=wallcutout_enabled,
        wallpattern_fill=wallpattern_fill,
        wallcutout_walls=wallcutout_walls,
        wallcutout_width=wallcutout_width,
        wallcutout_angle=wallcutout_angle,
        wallcutout_height=wallcutout_height,
        wallcutout_corner_radius=wallcutout_corner_radius,
        help = help);
    }
  }
  if(cutx){
    translate([-gridfinity_pitch,-gridfinity_pitch,-fudgeFactor])
      cube([(width+1)*gridfinity_pitch,gridfinity_pitch,(height+1)*gridfinity_zpitch]);
  }
  if(cuty){
    translate([-gridfinity_pitch,-gridfinity_pitch,-fudgeFactor])
      cube([gridfinity_pitch,(depth+1)*gridfinity_pitch,(height+1)*gridfinity_zpitch]);
  } 
}
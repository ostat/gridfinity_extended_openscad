// Gridfinity extended basic cup
// version 2024-02-17
//
// Source
// https://www.printables.com/model/630057-gridfinity-extended-openscad
//
// Documentation
// https://docs.ostat.com/docs/openscad/gridfinity-extended/basic-cup.html

include <modules/gridfinity_constants.scad>
use <modules/gridfinity_cup_modules.scad>
use <modules/gridfinity_modules.scad>

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X dimension in grid units  (multiples of 42mm)
width = 2; // [ 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Y dimension in grid units (multiples of 42mm)
depth = 1; // [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Z dimension (multiples of 7mm)
height = 3; //0.1
// Fill in solid block (overrides all following options)
filled_in = "off"; //["off","on","notstackable"]
// Include overhang for labeling (and specify left/right/center justification)
label = "disabled"; // ["disabled", "left", "right", "center", "leftchamber", "rightchamber", "centerchamber"]
// Width of the label in number of units, or zero means full width
// Width in Gridfinity units of 42mm, Depth and Height in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
label_size = [0,14,0]; // 0.01
// Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
// Remove some or all of lip
lip_style = "normal";  // [ "normal", "reduced", "none" ]
position="default"; //["default","center","zero"]

/* [Subdivisions] */
chamber_wall_thickness = 1.2;
// X dimension subdivisions
vertical_chambers = 1;
vertical_separator_bend_position = 0;
vertical_separator_bend_angle = 0;
vertical_separator_bend_separation = 0;
vertical_separator_cut_depth=0;
horizontal_chambers = 1;
horizontal_separator_bend_position = 0;
horizontal_separator_bend_angle = 0;
horizontal_separator_bend_separation = 0;
horizontal_separator_cut_depth=0;
// Enable irregular subdivisions
vertical_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
vertical_separator_config = "10.5|21|42|50|60";
// Enable irregular subdivisions
horizontal_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
horizontal_separator_config = "10.5|21|42|50|60";
      
/* [Base] */
// (Zack's design uses magnet diameter of 6.5)
magnet_diameter = 0;  // .1
// (Zack's design uses depth of 6)
screw_depth = 0;
center_magnet_diameter =0;
center_magnet_thickness = 0;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = true;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat (only applies if no magnets, screws, or finger-slide used)
efficient_floor = false;
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = false;
// Remove floor to create a veritcal spacer
spacer = false;
/* [Finger Slide] */
// Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// Radius of the corner fillet
fingerslide_radius = 8;

/* [Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [Wall Pattern] */
// Grid wall patter
wallpattern_enabled=false;
// Style of the pattern
wallpattern_style = "grid"; //["grid", "hexgrid", "voronoi","voronoigrid","voronoihexgrid"]
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1]; 
// Add the pattern to the dividers
wallpattern_dividers_enabled=false; 
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = 10; //0.1
// pattern fill mode
wallpattern_fill = "none"; //["none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"]
wallpattern_voronoi_noise = 0.75;
wallpattern_voronoi_radius = 0.5;

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

/* [Extendable] */
extention_x_enabled = false;
extention_y_enabled = false;
extention_tabs_enabled = true;

/* [debug] */
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// enable loging of help messages during render.
enable_help = false;

module end_of_customizer_opts() {}
/*<!!end gridfinity_basic_cup!!>*/
gridfinity_basic_cup();

module gridfinity_basic_cup(
  width = width,
  depth = depth,
  height = height,
  position=position,
  filled_in = filled_in,
  label=label,
  label_size=label_size,
  wall_thickness=wall_thickness,
  lip_style=lip_style,
  chamber_wall_thickness = chamber_wall_thickness,
  vertical_chambers = vertical_chambers,
  vertical_separator_bend_position=vertical_separator_bend_position,
  vertical_separator_bend_angle=vertical_separator_bend_angle,
  vertical_separator_bend_separation=vertical_separator_bend_separation,
  vertical_separator_cut_depth=vertical_separator_cut_depth,
  vertical_irregular_subdivisions=vertical_irregular_subdivisions,
  vertical_separator_config=vertical_separator_config,
  horizontal_chambers=horizontal_chambers,
  horizontal_separator_bend_position=horizontal_separator_bend_position,
  horizontal_separator_bend_angle=horizontal_separator_bend_angle,
  horizontal_separator_bend_separation=horizontal_separator_bend_separation,
  horizontal_separator_cut_depth=horizontal_separator_cut_depth,
  horizontal_irregular_subdivisions=horizontal_irregular_subdivisions,
  horizontal_separator_config=horizontal_separator_config, 
  magnet_diameter=magnet_diameter,
  screw_depth=screw_depth,
  center_magnet_diameter=center_magnet_diameter,
  center_magnet_thickness=center_magnet_thickness,
  hole_overhang_remedy=hole_overhang_remedy,
  box_corner_attachments_only=box_corner_attachments_only,
  floor_thickness=floor_thickness,
  cavity_floor_radius=cavity_floor_radius,
  efficient_floor=efficient_floor,
  half_pitch=half_pitch,
  flat_base=flat_base,
  spacer=spacer,
  fingerslide=fingerslide,
  fingerslide_radius=fingerslide_radius,
  tapered_corner=tapered_corner,
  tapered_corner_size=tapered_corner_size,
  tapered_setback=tapered_setback,
  wallcutout_enabled=wallcutout_enabled,
  wallcutout_walls=wallcutout_walls,
  wallcutout_width=wallcutout_width,
  wallcutout_angle=wallcutout_angle,
  wallcutout_height=wallcutout_height,
  wallcutout_corner_radius=wallcutout_corner_radius,
  wallpattern_enabled=wallpattern_enabled,
  wallpattern_style=wallpattern_style,
  wallpattern_walls=wallpattern_walls,
  wallpattern_dividers_enabled=wallpattern_dividers_enabled,
  wallpattern_fill=wallpattern_fill,
  wallpattern_hole_sides=wallpattern_hole_sides,
  wallpattern_hole_size=wallpattern_hole_size,
  wallpattern_hole_spacing=wallpattern_hole_spacing,
  wallpattern_voronoi_noise=wallpattern_voronoi_noise,
  wallpattern_voronoi_radius=wallpattern_voronoi_radius,
  extention_enabled=[extention_x_enabled, extention_y_enabled],
  extention_tabs_enabled=extention_tabs_enabled,
  cutx=cutx,
  cuty=cuty,
  help=enable_help) {

  difference(){
    irregular_cup(
      num_x=width, num_y=depth, num_z=height,
      position=position,
      filled_in=filled_in,
      label_style=label,
      labelSize=label_size,
      fingerslide=fingerslide,
      fingerslide_radius=fingerslide_radius,
      magnet_diameter=magnet_diameter,
      screw_depth=screw_depth,
      center_magnet_diameter=center_magnet_diameter,
      center_magnet_thickness=center_magnet_thickness,
      floor_thickness=floor_thickness,
      cavity_floor_radius=cavity_floor_radius,
      wall_thickness=wall_thickness,
      hole_overhang_remedy=hole_overhang_remedy,
      efficient_floor=efficient_floor,
      chamber_wall_thickness=chamber_wall_thickness,
      vertical_separator_bend_position=vertical_separator_bend_position,
      vertical_separator_bend_angle=vertical_separator_bend_angle,
      vertical_separator_bend_separation=vertical_separator_bend_separation,
      vertical_separator_cut_depth=vertical_separator_cut_depth,
      vertical_separator_positions=vertical_irregular_subdivisions 
        ? vertical_separator_config 
        : splitChamber(vertical_chambers-1, width),
      horizontal_separator_bend_position=horizontal_separator_bend_position,
      horizontal_separator_bend_angle=horizontal_separator_bend_angle,
      horizontal_separator_bend_separation=horizontal_separator_bend_separation,
      horizontal_separator_cut_depth=horizontal_separator_cut_depth,
      horizontal_separator_positions=horizontal_irregular_subdivisions 
        ? horizontal_separator_config 
        : splitChamber(horizontal_chambers-1, depth),
      half_pitch=half_pitch,
      lip_style=lip_style,
      box_corner_attachments_only=box_corner_attachments_only,
      flat_base = flat_base,
      spacer=spacer,
      tapered_corner=tapered_corner,
      tapered_corner_size = tapered_corner_size,
      tapered_setback = tapered_setback,
      wallpattern_enabled=wallpattern_enabled,
      wallpattern_style=wallpattern_style,
      wallpattern_walls=wallpattern_walls, 
      wallpattern_dividers_enabled=wallpattern_dividers_enabled,
      wallpattern_hole_sides=wallpattern_hole_sides,
      wallpattern_hole_size=wallpattern_hole_size, 
      wallpattern_hole_spacing=wallpattern_hole_spacing,
      wallpattern_fill=wallpattern_fill,
      wallpattern_voronoi_noise=wallpattern_voronoi_noise,
      wallpattern_voronoi_radius = wallpattern_voronoi_radius,
      wallcutout_enabled=wallcutout_enabled,
      wallcutout_walls=wallcutout_walls,
      wallcutout_width=wallcutout_width,
      wallcutout_angle=wallcutout_angle,
      wallcutout_height=wallcutout_height,
      wallcutout_corner_radius=wallcutout_corner_radius,
      extention_enabled = extention_enabled,
      extention_tabs_enabled = extention_tabs_enabled,
      cutx=cutx,
      cuty=cuty,
      help = help);
   }
}

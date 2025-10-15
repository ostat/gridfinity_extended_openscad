// Gridfinity extended basic cup
// version 2024-02-17
//
// Source
// https://www.printables.com/model/630057-gridfinity-extended-openscad
//
// Documentation
// https://docs.ostat.com/docs/openscad/gridfinity-extended/basic-cup

include <modules/gridfinity_constants.scad>
include <modules/module_gridfinity_sliding_lid.scad>
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity_block.scad>

/* [Sliding Lid] */
// select what to render
render_choice = "both";//[both, lid, cup]
sliding_lid_enabled = true;
// 0 = wall thickness *2
sliding_lid_thickness = 0; //0.1
// 0 = wall_thickness/2
sliding_min_wall_thickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
sliding_min_support = 0;//0.1
sliding_lid_lip_enabled = true;
sliding_clearance = 0.1;//0.1
sliding_lid_cutout_enabled = false; //
sliding_lid_cutout_size = [-2,-2]; //0.1
sliding_lid_cutout_radius = -4; //0.1
sliding_lid_cutout_position = [0,0]; //0.1

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.1
// Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [3, 0]; //0.1
// Fill in solid block (overrides all following options)
filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]
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

/* [Subdivisions] */
chamber_wall_thickness = 1.2;
//Reduce the wall height by this amount
chamber_wall_headroom = 0;//0.1
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
// Enable magnets
enable_magnets = true;
// Enable screws
enable_screws = true;
//size of magnet, diameter and height. Zack's original used 6.5 and 2.4
magnet_size = [6.5, 2.4];  // .1
//create relief for magnet removal
magnet_easy_release = "auto";//["off","auto","inner","outer"] 
//size of screw, diameter and height. Zack's original used 3 and 6
screw_size = [3, 6]; // .1
//size of center magnet, diameter and height. 
center_magnet_size = [0,0];
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = true;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth]
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = "off"; // [off, gridfinity:gridfinity stackable, rounded]
// Remove floor to create a vertical spacer
spacer = false;
//Pads smaller than this will not be rendered as it interferes with the baseplate. Ensure appropriate support is added in slicer.
minimum_printable_pad_size = 0.2;

// Adjust the radius of the rounded flat base. -1 uses the corner radius.
flat_base_rounded_radius = -1;
// Add chamfer to the rounded bottom corner to make easier to print. -1 add auto 45deg.
flat_base_rounded_easyPrint = -1;

/* [Label] */
label_style = "normal"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]

/* [Finger Slide] */
// Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// Radius of the corner fillet
fingerslide_radius = -3;
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
fingerslide_walls=[1,0,0,0];  //[0:1:1]
//Align the fingerslide with the lip
fingerslide_lip_aligned=true;

/* [Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [Wall Pattern] */
// Grid wall patter
wallpattern_enabled=false;
// Style of the pattern
wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// Spacing between pattern
wallpattern_strength = 2; //0.1
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// rotate the grid
wallpattern_rotate_grid=false;
//Size of the hole
wallpattern_cell_size = [10,10]; //0.1
// Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both] 
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//Radius of corners
wallpattern_hole_radius = 0.5;
// pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
wallpattern_border = 0;
// depth of imprint in mm, 0 = is wall width.
wallpattern_depth = 0; // 0.1
//grid pattern hole taper
wallpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise, 
wallpattern_pattern_voronoi_noise = 0.75; //0.01
//brick pattern center weight
wallpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [Floor Pattern] */
// enable Grid floor patter
floorpattern_enabled=false;
// Style of the pattern
floorpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// Spacing between pattern
floorpattern_strength = 2; //0.1
// rotate the grid
floorpattern_rotate_grid = false;
//Size of the hole
floorpattern_cell_size = [10,10]; //0.1
//Number of sides of the hole op
floorpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//Radius of corners
floorpattern_hole_radius = 0.5;
// pattern fill mode
floorpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
floorpattern_border = 0;
// depth of imprint in mm, 0 = is wall width.
floorpattern_depth = 0; // 0.1
//grid pattern hole taper
floorpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise, 
floorpattern_pattern_voronoi_noise = 0.75; //0.01
//brick pattern center weight
floorpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
floorpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [Wall Cutout] */
wallcutout_vertical ="disabled"; //[disabled, enabled, wallsonly, frontonly, backonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=-2;  //0.1
//default will be binwidth/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
//default will be binHeight
wallcutout_vertical_height=0;
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, wallsonly, leftonly, rightonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=-2;  //0.1
//default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
//default will be binHeight
wallcutout_horizontal_height=0;
wallcutout_horizontal_corner_radius=5;

/* [Extendable] */
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5; 
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5; 
extension_tabs_enabled = true;
//Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];

/* [Bottom Text] */
// Add bin size to bin bottom
text_1 = false;
// Font Size of text, in mm (0 will auto size)
text_size = 0; // 0.1
// Depth of text, in mm
text_depth = 0.3; // 0.01
// Offset of text , in mm
text_offset = [0, 0]; // 0.1
// Font to use
text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// Add free-form text line to bin bottom (printing date, serial, etc)
text_2 = false;
// Actual text to add
text_2_text = "Gridfinity Extended";

/* [debug] */
// Debug slice
cut = [0,0,0]; //0.1
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
fs = 0.4; 
// number of fragments, overrides $fa and $fs
fn = 0;  
// set random seed for 
random_seed = 0; //0.0001
// force render on costly components
force_render = true;

/* [Hidden] */
module end_of_customizer_opts() {}
/*<!!end gridfinity_basic_cup!!>*/

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;  

set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  cut = cut,
  setColour = set_colour,
  randomSeed = random_seed,
  force_render = force_render)
  union(){
  if(render_choice == "both" || render_choice == "cup")
  {
    gridfinity_cup(
      width=width, depth=depth, height=height,
      filled_in=filled_in,
      label_settings=LabelSettings(
        labelStyle=label_style, 
        labelPosition=label_position, 
        labelSize=label_size,
        labelRelief=label_relief,
        labelWalls=label_walls),
      finger_slide_settings = FingerSlideSettings(
        type = fingerslide,
        radius = fingerslide_radius,
        walls = fingerslide_walls,
        lip_aligned = fingerslide_lip_aligned),
      cupBase_settings = CupBaseSettings(
        magnetSize = enable_magnets ? magnet_size : [0,0], 
        magnetEasyRelease = magnet_easy_release, 
        centerMagnetSize = center_magnet_size, 
        screwSize = enable_screws ? screw_size : [0,0], 
        holeOverhangRemedy = hole_overhang_remedy, 
        cornerAttachmentsOnly = box_corner_attachments_only,
        floorThickness = floor_thickness,
        cavityFloorRadius = cavity_floor_radius,
        efficientFloor=efficient_floor,
        halfPitch=half_pitch,
        flatBase=flat_base,
        spacer=spacer,
        minimumPrintablePadSize=minimum_printable_pad_size,
        flatBaseRoundedRadius = flat_base_rounded_radius,
        flatBaseRoundedEasyPrint = flat_base_rounded_easyPrint),
      wall_thickness=wall_thickness,
      vertical_chambers = ChamberSettings(
        chambers_count = vertical_chambers,
        chamber_wall_thickness = chamber_wall_thickness,
        chamber_wall_headroom = chamber_wall_headroom,
        separator_bend_position = vertical_separator_bend_position,
        separator_bend_angle = vertical_separator_bend_angle,
        separator_bend_separation = vertical_separator_bend_separation,
        separator_cut_depth = vertical_separator_cut_depth,
        irregular_subdivisions = vertical_irregular_subdivisions,
        separator_config = vertical_separator_config),
      horizontal_chambers = ChamberSettings(
        chambers_count = horizontal_chambers,
        chamber_wall_thickness = chamber_wall_thickness,
        chamber_wall_headroom = chamber_wall_headroom,
        separator_bend_position = horizontal_separator_bend_position,
        separator_bend_angle = horizontal_separator_bend_angle,
        separator_bend_separation = horizontal_separator_bend_separation,
        separator_cut_depth = horizontal_separator_cut_depth,
        irregular_subdivisions = horizontal_irregular_subdivisions,
        separator_config = horizontal_separator_config),
      lip_settings = LipSettings(
        lipStyle=lip_style, 
        lipSideReliefTrigger=lip_side_relief_trigger, 
        lipTopReliefHeight=lip_top_relief_height, 
        lipNotch=lip_top_notches),
      headroom=headroom,
      tapered_corner=tapered_corner,
      tapered_corner_size = tapered_corner_size,
      tapered_setback = tapered_setback,
      wallpattern_walls=wallpattern_walls, 
      wallpattern_dividers_enabled=wallpattern_dividers_enabled,
      wall_pattern_settings = PatternSettings(
        patternEnabled = wallpattern_enabled, 
        patternStyle = wallpattern_style, 
        patternRotate = wallpattern_rotate_grid,
        patternFill = wallpattern_fill,
        patternBorder = wallpattern_border, 
        patternDepth = wallpattern_depth,
        patternCellSize = wallpattern_cell_size, 
        patternHoleSides = wallpattern_hole_sides,
        patternStrength = wallpattern_strength, 
        patternHoleRadius = wallpattern_hole_radius,
        patternGridChamfer = wallpattern_pattern_grid_chamfer,
        patternVoronoiNoise = wallpattern_pattern_voronoi_noise,
        patternBrickWeight = wallpattern_pattern_brick_weight,
        patternFs = wallpattern_pattern_quality), 
      floor_pattern_settings = PatternSettings(
        patternEnabled = floorpattern_enabled, 
        patternStyle = floorpattern_style, 
        patternRotate = floorpattern_rotate_grid,
        patternFill = floorpattern_fill,
        patternBorder = floorpattern_border, 
        patternDepth = floorpattern_depth,
        patternCellSize = floorpattern_cell_size, 
        patternHoleSides = floorpattern_hole_sides,
        patternStrength = floorpattern_strength, 
        patternHoleRadius = floorpattern_hole_radius,
        patternGridChamfer = floorpattern_pattern_grid_chamfer,
        patternVoronoiNoise = floorpattern_pattern_voronoi_noise,
        patternBrickWeight = floorpattern_pattern_brick_weight,
        patternFs = floorpattern_pattern_quality), 
      wallcutout_vertical_settings = WallCutoutSettings(
        type = wallcutout_vertical, 
        position = wallcutout_vertical_position, 
        width = wallcutout_vertical_width,
        angle = wallcutout_vertical_angle,
        height = wallcutout_vertical_height, 
        corner_radius = wallcutout_vertical_corner_radius),
      wallcutout_horizontal_settings = WallCutoutSettings(
        type = wallcutout_horizontal, 
        position = wallcutout_horizontal_position, 
        width = wallcutout_horizontal_width,
        angle = wallcutout_horizontal_angle,
        height = wallcutout_horizontal_height, 
        corner_radius = wallcutout_horizontal_corner_radius),
      extendable_Settings = ExtendableSettings(
        extendablexEnabled = extension_x_enabled, 
        extendablexPosition = extension_x_position, 
        extendableyEnabled = extension_y_enabled, 
        extendableyPosition = extension_y_position, 
        extendableTabsEnabled = extension_tabs_enabled, 
        extendableTabSize = extension_tab_size),
      sliding_lid_enabled = sliding_lid_enabled, 
      sliding_lid_thickness = sliding_lid_thickness, 
      sliding_min_wall_thickness = sliding_min_wall_thickness, 
      sliding_min_support = sliding_min_support, 
      sliding_clearance = sliding_clearance,
      sliding_lid_lip_enabled=sliding_lid_lip_enabled,
      cupBaseTextSettings = CupBaseTextSettings(
        baseTextLine1Enabled = text_1,
        baseTextLine2Enabled = text_2,
        baseTextLine2Value = text_2_text,
        baseTextFontSize = text_size,
        baseTextFont = text_font,
        baseTextDepth = text_depth,
        baseTextOffset = text_offset));
  }

  if(render_choice == "both" || render_choice == "lid")
  {
    num_x = calcDimensionWidth(width);
    num_y = calcDimensionDepth(depth);
    num_z = calcDimensionHeight(height);
    wall_thickness = wallThickness(wall_thickness, num_z);
    
    slidingLidSettings= SlidingLidSettings(
      sliding_lid_enabled, 
      sliding_lid_thickness, 
      sliding_min_wall_thickness, 
      sliding_min_support,
      sliding_clearance,
      wall_thickness,
      sliding_lid_lip_enabled);
        
    headroom = headroom + (sliding_lid_enabled ? slidingLidSettings[iSlidingLidThickness] : 0);
    
    filledInZ = env_pitch().z*num_z;
    zpoint = filledInZ-headroom;
    
    translate(
      render_choice == "both" && !$preview 
      ? [(num_x+0.5)*env_pitch().x, 0, 0] 
      : [0, 0, render_choice == "lid" ? 0 : zpoint])
    difference()
    {
      SlidingLid(
        num_x=num_x, 
        num_y=num_y,
        wall_thickness,
        clearance = slidingLidSettings[iSlidingClearance],
        lidThickness=slidingLidSettings[iSlidingLidThickness],
        lidMinSupport=slidingLidSettings[iSlidingLidMinSupport],
        lidMinWallThickness=slidingLidSettings[iSlidingLidMinWallThickness],
        lipStyle = lip_style,
        lip_notches = lip_top_notches,
        lip_top_relief_height = lip_top_relief_height, 
        addLiptoLid = sliding_lid_lip_enabled,
        limitHeight=true,
        cutoutEnabled = sliding_lid_cutout_enabled,
        cutoutSize = sliding_lid_cutout_size,
        cutoutRadius = sliding_lid_cutout_radius,
        cutoutPosition = sliding_lid_cutout_position);
    }
  }
}

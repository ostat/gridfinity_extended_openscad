include <modules/module_gridfinity.scad>
use <modules/module_gridfinity_cup.scad>

/* [Utensil count and measurements] */
// Utensil definitions above this number are ignored
number_of_utensils = 5;

//utensil, narrow, wide, length, position
utensil_1 = [30, 0, 202, 1];
utensil_2 = [35, 0, 181, 2];
utensil_3 = [14, 37, 181, 3];
utensil_4 = [12, 33, 155, 4];
utensil_5 = [15, 32, 191, 5];
utensil_6 = [15, 32, 150, 6];
utensil_7 = [16, 24, 180, 7];
utensil_8 = [15, 28, 202, 8];
utensil_9 = [14, 24, 181, 9];
utensil_10 = [14, 37, 181, 10];
utensil_11 = [12, 33, 155, 11];
utensil_12 = [15, 32, 191, 12];
utensil_13 = [15, 32, 150, 13];
utensil_14 = [16, 24, 180, 14];

// Clearance on sides and ends of utensils
utensil_margin = 5;  // .1

// Height upper surface excluding perimeter lip. . grid units (multiples of 7mm) or mm.
height = [0, 42];

/* [Other parameters] */
// Wall thickness [bottom, top], top -ve is ratio of bottom wall thickness
chamber_wall_thickness = [4, -2]; //0.1
//Reduce the wall height by this amount
chamber_wall_headroom = 0;//0.1
// Radius of the top of the chamber wall, -ve is ratio of top wall thickness. (disabled for bent walls)
chamber_wall_top_radius = -2; //0.1
vertical_separator_bend_angle = 45;
vertical_separator_bend_position = 0;
vertical_separator_cut_depth=0;

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
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
// Create a relief
lip_top_relief_height = -1; // 0.1
// add a notch to the lip to prevent sliding.
lip_top_notches  = true;

/* [Base] */
// Enable magnets
enable_magnets = false;
// Enable screws
enable_screws = false;
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
label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]

/* [Sliding Lid] */
sliding_lid_enabled = false;
// 0 = wall thickness *2
sliding_lid_thickness = 0; //0.1
// 0 = wall_thickness/2
sliding_min_wallThickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
sliding_min_support = 0;//0.1
sliding_clearance = 0.1;//0.1
sliding_lid_lip_enabled = false;

/* [Finger Slide] */
// Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// Radius of the corner fillet, 0:none, >1: radius in mm, <0 dimention/abs(n) (i.e. -3 is 1/3 the width)
fingerslide_radius = 8;
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled using radius; >1: override radius.
fingerslide_walls=[1,0,0,0];
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
wallpattern_colored = "disabled"; //[disabled, enabled]


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
wallcutout_horizontal ="inneronly"; //[disabled, enabled, inneronly, wallsonly, leftonly, rightonly]
// wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=[-2,-0.5,-0.5,-0.5];  //0.01
//default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
//default will be binHeight
wallcutout_horizontal_height=-1.5; //0.1
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
//Work in progress,  Modify the default grid size. Will break compatibility
pitch = [42,42,7];  //[0:1:9999]
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


module end_of_customizer() {}
silverware_wall_clearance = 5.7; 
// Maximum utensil definitions
silver_defs_all = [
  utensil_1,
  utensil_2,
  utensil_3,
  utensil_4,
  utensil_5,
  utensil_6,
  utensil_7,
  utensil_8,
  utensil_9,
  utensil_10,
  utensil_11,
  utensil_12,
  utensil_13,
  utensil_14
];
 
function get_utensil_def(index, defs_list) = 
  let(
    matchResults = search(index, defs_list, num_returns_per_match=1, index_col_num=3),
    matchIndex = is_list(matchResults) && len(matchResults)==1 && is_num(matchResults[0]) ? matchResults[0]: undef,
    matchValue = is_num(matchIndex) ? silver_defs_all[matchIndex] : undef,
    utensil = is_undef(matchValue) ? [0,0,0] : [matchValue.x, max(matchValue.x, matchValue.y), matchValue.z]
    ) utensil;
    
// ##### Utility functions
// tail of a list with at least 2 elements
function cdr(list) = [ for (i=[1:len(list)-1]) list[i] ];
// sum of a bunch of values (recursive functional style)
function vecsum(vals) = len(vals) > 1 ? vals[0] + vecsum(cdr(vals)) : vals[0];
// total width of a list of utensils
function totwidth(defs, margin = utensil_margin) = vecsum(pitches(defs)) + 2*margin + 
  max(defs[0][0], defs[0][1])/2 + max(defs[len(defs)-1][0], defs[len(defs)-1][1])/2;
// maximum length of list of utensils
function maxlen(defs) = len(defs) > 1 ? max(defs[0][2], maxlen(cdr(defs))) : defs[0][2];
// convert a list of utensils into a list of center-to-center distances
function pitches(defs, thickness = chamber_wall_thickness[0], margin = utensil_margin) = [ for (i=[0:len(defs)-2]) thickness + 2*margin + 
  max( defs[i][1]/2 + defs[i+1][0]/2, defs[i][0]/2 + defs[i+1][1]/2) ];

// ##### Derived variables and values
// subset of all utensil definitions up to the requested number of utensils
silver_defs = [ for (i=[1:number_of_utensils]) get_utensil_def(i, silver_defs_all) ];

// X, width of combination of all silverware, in gridfinity units
width = ceil((totwidth(silver_defs) + silverware_wall_clearance)/42);
// Y, max depth of all silverware, in gridfinity units
depth = ceil((maxlen(silver_defs)+2*utensil_margin + silverware_wall_clearance)/42);
// gridfinity modules expect height in units of 7 mm (but fractions are allowed)
num_z = calcDimensionHeight(height);


function sum_(list, c = 0, end) = 
  let(end = is_undef(end) ? len(list) : end)
  c < 0 || end < 0 ? 0 : 
  c < len(list) - 1 && c < end
    ? list[c] + sum(list, c + 1, end=end) 
    : list[c];

// convert a list of utensils into a list of center-to-center distances
function pitches_(defs, thickness = chamber_wall_thickness[0], margin=utensil_margin) = 
  [ for (i=[0:len(defs)-2]) 
    thickness + 2*margin + max( defs[i][1]/2 + defs[i+1][0]/2, defs[i][0]/2 + defs[i+1][1]/2) 
  ];

function calculate_dividers (cells, xtop=0, xbot=0, index=0, inverted=false, thickness=chamber_wall_thickness[0], margin=utensil_margin) = 
    let(cell = cells[index],
      
      cell_top_w = thickness + margin * 2 + (inverted ? cell[1] : cell[0]),
      cell_bot_w = thickness + margin * 2 + (inverted ? cell[0] : cell[1]),
      cell_middle_pos = max(xtop+cell_top_w/2, xbot+cell_bot_w/2),
      wall_deviation = abs(cell_top_w - cell_bot_w)/2,
      wall_position = cell_middle_pos + max(cell_top_w, cell_bot_w)/2-wall_deviation/2,
      
      next_xtop = cell_middle_pos + cell_top_w/2,
      next_xbot = cell_middle_pos + cell_bot_w/2,
      currentDivider = [wall_position, wall_deviation, vertical_separator_bend_angle * (inverted ? 1 : -1)])
      echo("calculate_dividers", index=str(index, " of ", lenCells=len(cells)), input=cell, cell_size_needed = [cell_top_w,cell_bot_w], cell_middle_pos=cell_middle_pos, wall_position=wall_position, currentDivider)
      len(cells)-2<=index 
        ? [currentDivider]
         : concat([currentDivider], calculate_dividers(cells, xtop=next_xtop, xbot=next_xbot, index=index+1, !inverted, thickness=thickness, margin=margin));

// ##### Modules
// top level generator
module silverware_pockets(defs, md=magnet_size[1], sd=screw_size[1]) {
  apply_spacing_silverware = true;
  mag_ht = md > 0 ? 2.4: 0;
  m3_ht = sd;
  part_ht = 5;  // height of bottom side groove between gridfinity units
  floorht = max(mag_ht, m3_ht, part_ht) + floor_thickness;

  utensil_margin = utensil_margin + (apply_spacing_silverware ? ((width*42-(totwidth(silver_defs) + silverware_wall_clearance))/len(defs))/2 : 0);
  echo("silverware_pockets", defs = defs);
  echo("silverware_pockets", thickness=chamber_wall_thickness[0], margin=utensil_margin);
  dividers = calculate_dividers(cells=defs, inverted=true, thickness=chamber_wall_thickness[0], margin=utensil_margin);
  echo("silverware_pockets", dividers = dividers);

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
      magnetSize = enable_magnets?magnet_size:[0,0],
      magnetEasyRelease = magnet_easy_release, 
      centerMagnetSize = center_magnet_size, 
      screwSize = enable_screws?screw_size:[0,0],
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
    divider_wall_removable_settings = DividerRemovableSettings(),
    vertical_chambers = ChamberSettings(
      chamber_wall_thickness = chamber_wall_thickness,
      chamber_wall_headroom = chamber_wall_headroom,
      chamber_wall_top_radius = chamber_wall_top_radius,
      separator_bend_position = vertical_separator_bend_position,
      separator_bend_angle = vertical_separator_bend_angle,
      separator_cut_depth = vertical_separator_cut_depth,
      irregular_subdivisions = true,
      separator_config = dividers),
    horizontal_chambers = ChamberSettings(),
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
      patternFs = wallpattern_pattern_quality,
      patternColored = wallpattern_colored), 
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
    wallcutout_vertical_settings = WallCutoutSettings(),
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
    sliding_min_wall_thickness = sliding_min_wallThickness, 
    sliding_min_support = sliding_min_support, 
    sliding_clearance = sliding_clearance,
    sliding_lid_lip_enabled=sliding_lid_lip_enabled,
    cupBaseTextSettings = CupBaseTextSettings(
      baseTextLine1Enabled = text_1,
      baseTextLine2Enabled = text_2,
      baseTextLine2Value = text_2_text,
      baseTextFontSize = text_size,
      baseTextFont = text_font,
      baseTextDepth = text_depth));
}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

// ##### Top level model
set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  pitch = pitch,
  cut = cut,
  setColour = set_colour,
  randomSeed = random_seed,
  force_render = force_render)
silverware_pockets(silver_defs);
include <gridfinity_constants.scad>
include <functions_general.scad>
include <module_patterns.scad>
include <module_gridfinity_label.scad>
include <module_gridfinity_sliding_lid.scad>
include <module_gridfinity_Extendable.scad>
include <module_gridfinity_cup_base_text.scad>
include <module_gridfinity_cup_base.scad>
include <module_divider_walls.scad>
include <module_bin_chambers.scad>
include <module_fingerslide.scad>

use <module_gridfinity_block.scad>
use <module_gridfinity_efficient_floor.scad>

use <module_calipers.scad>

// X dimension. grid units (multiples of 42mm) or mm.
default_width = [2, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
default_depth = [1, 0]; //0.1
// Z dimension excluding. grid units (multiples of 7mm) or mm.
default_height = [3, 0]; //0.1
default_position = "default"; //["default","center","zero"]
default_filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]
//assign colours to the bin, will may 
default_set_colour = "preview"; //[disabled, preview, lip]

// Thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
default_wall_thickness = 0;// 0.01

// Set magnet diameter and depth to 0 to print without magnet holes
// (Zack's design uses magnet diameter of 6.5)
//under size the bin top by this amount to allow for better stacking
default_headroom = 0.8; // 0.1

/* [Cup Lip] */
// Style of the cup lip
default_lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// Below this the inside of the lip will be reduced for easier access.
default_lip_side_relief_trigger = [1,1]; //0.1
// Create a relief in the lip
default_lip_top_relief_height = -1; // 0.1
// add a notch to the lip to prevent sliding.
default_lip_top_notches  = 0; // 0.1

/* [Label] */
// Include overhang for labeling
default_label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// Include overhang for labeling (and specify left/right/center justification)
default_label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
default_label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropriate. Width, depth, height, radius
default_label_relief = [0,0,0,0.6]; // 0.1
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
default_label_walls=[0,1,0,0];  //[0:1:1]
    
/* [Sliding Lid] */
default_sliding_lid_enabled = false;
// 0 = wall thickness *2
default_sliding_lid_thickness = 0; //0.1
// 0 = wall_thickness/2
default_sliding_min_wallThickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
default_sliding_min_support = 0;//0.1
default_sliding_clearance = 0.1;//0.1
default_sliding_lid_lip_enabled = false;

/* [Finger Slide] */
// Include larger corner fillet
default_fingerslide = "none"; //[none, rounded, chamfered]
// radius of the corner fillet
default_fingerslide_radius = -3;
// wall to enable on, front, back, left, right.  0: disabled; 1: enabled;
default_fingerslide_walls=[1,0,0,0]; //[0:1:1]
default_fingerslide_lip_aligned = true;

/* [Subdivisions] */
// X dimension subdivisions
default_chamber_wall_thickness = 1.2;//0.1
//Reduce the wall height by this amount
default_chamber_wall_headroom = 0;//0.1
default_vertical_chambers = 1;
default_vertical_separator_bend_position = 0;//0.1
default_vertical_separator_bend_angle = 45;//0.1
default_vertical_separator_bend_separation = 0;//0.1
default_vertical_separator_cut_depth = 0;//0.1
default_horizontal_chambers = 1;
default_horizontal_separator_bend_position = 0; //0.1
default_horizontal_separator_bend_angle = 45; //0.1
default_horizontal_separator_bend_separation = 0; //0.1
default_horizontal_separator_cut_depth = 0;//0.1
// Enable irregular subdivisions
default_vertical_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
default_vertical_separator_config = "10.5|21|42|50|60";
// Enable irregular subdivisions
default_horizontal_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
default_horizontal_separator_config = "10.5|21|42|50|60";

/* [Base] */
//size of magnet, diameter and height. Zack's original used 6.5 and 2.4 
default_magnet_size = [6.5, 2.4];  // .1
//create relief for magnet removal
default_magnet_easy_release = "auto";//["off","auto","inner","outer"] 
// move magnet inside part for print-in magnets 
default_magnet_captive_height = 0;
//size of screw, diameter and height. Zack's original used 3 and 6
default_screw_size = [3, 6]; // .1
//size of center magnet, diameter and height. 
default_center_magnet_size = [0,0];
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
default_floor_thickness = 1.2;
default_cavity_floor_radius = -1;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
default_hole_overhang_remedy = 2;
// Save material with thinner floor
default_efficient_floor = "off";//["off","on","rounded","smooth"] 
// Remove floor to create a spacer
default_spacer = false;
// Half-pitch base pads for offset stacking
default_half_pitch = false;

// Limit attachments (magnets and screws) to box corners for faster printing.
default_box_corner_attachments_only = true;
// Removes the base grid from inside the shape
default_flat_base = false;
/* [Tapered Corner] */
default_tapered_corner = "none"; //[none, rounded, chamfered]
default_tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
default_tapered_setback = -1;//gf_cup_corner_radius/2;

/* [Wall Cutout] */
default_wallcutout_vertical ="disabled"; //[disabled, enabled, wallsonly, frontonly, backonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
default_wallcutout_vertical_position=-2;  //0.1
//default will be binwidth/2
default_wallcutout_vertical_width=0;
default_wallcutout_vertical_angle=70;
//default will be binHeight
default_wallcutout_vertical_height=0;
default_wallcutout_vertical_corner_radius=5;
default_wallcutout_horizontal ="disabled"; //[disabled, enabled, wallsonly, leftonly, rightonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
default_wallcutout_horizontal_position=-2;  //0.1
//default will be binwidth/2
default_wallcutout_horizontal_width=0;
default_wallcutout_horizontal_angle=70;
//default will be binHeight
default_wallcutout_horizontal_height=0;
default_wallcutout_horizontal_corner_radius=5;

/* [Wall Pattern] */
default_wallpattern_enabled=false; 
default_wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
default_wallpattern_rotate_grid = false;
default_wallpattern_dividers_enabled ="disabled"; //["disabled", "horizontal", "vertical", "both"] 
default_wallpattern_fill = "none"; //["none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"]
default_wallpattern_walls=[1,0,0,0];  //[0:1:1]
default_wallpattern_hole_sides = 6;
default_wallpattern_cell_size = [10,10]; //0.1
default_wallpattern_strength = 2; //0.1
default_wallpattern_hole_radius = 0.5;
default_wallpattern_border = 0;
default_wallpattern_depth = 0;
default_wallpattern_pattern_grid_chamfer = 0; //0.1
default_wallpattern_pattern_voronoi_noise = 0.75; //0.01
default_wallpattern_pattern_brick_weight = 5;
default_wallpattern_pattern_quality = 0;

/* [Extendable] */
default_extension_x_enabled = "disabled"; //[disabled, front, back]
default_extension_x_position = 0.5; 
default_extension_y_enabled = "disabled"; //[disabled, front, back]
default_extension_y_position = 0.5; 
default_extension_tabs_enabled = true;
//Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
default_extension_tab_size= [10,0,0,0];

/* [Bottom Text] */
// Add bin size to bin bottom
default_text_1 = false;
// Size of text, in mm
default_text_size = 0; // 0.1
// Depth of text, in mm
default_text_depth = 0.3; // 0.01
// Offset of text , in mm
default_text_offset = [0, 0]; // 0.1
// Font to use
default_text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// Add free-form text line to bin bottom (printing date, serial, etc)
default_text_2 = false;
// Actual text to add
default_text_2_text = "Gridfinity";

module end_of_customizer_opts() {}

/*
//[debug] 
default_cutx = 0;//0.01
default_cuty = 0;//0.01
default_help = "info"; //["off","info","debug","trace"]

set_environment(//execution point
  width = default_width,
  depth = default_depth,
  height = default_height,
  setColour = default_set_colour,//execution point
  help = default_help,//execution point
  cut=[default_cutx,default_cuty, default_height]//execution point
  )//execution point
gridfinity_cup();//execution point
*/

// It's recommended that all parameters other than x, y, z size should be specified by keyword 
// and not by position.  The number of parameters makes positional parameters error prone, and
// additional parameters may be added over time and break things.
// separator positions are defined in units from the left side
module gridfinity_cup(
  width,
  depth,
  height,
  filled_in=default_filled_in,
  wall_thickness=default_wall_thickness,
  label_settings=LabelSettings(
    labelStyle=default_label_style, 
    labelPosition=default_label_position, 
    labelSize=default_label_size,
    labelRelief=default_label_relief,
    labelWalls=default_label_walls),
  finger_slide_settings = FingerSlideSettings(
    type=default_fingerslide,
    radius=default_fingerslide_radius,
    walls=default_fingerslide_walls,
    lip_aligned=default_fingerslide_lip_aligned),
  cupBase_settings = CupBaseSettings(
    magnetSize = default_magnet_size, 
    magnetEasyRelease = default_magnet_easy_release, 
    magnetCaptiveHeight = default_magnet_captive_height,
    centerMagnetSize = default_center_magnet_size, 
    screwSize = default_screw_size, 
    holeOverhangRemedy = default_hole_overhang_remedy, 
    cornerAttachmentsOnly = default_box_corner_attachments_only,
    floorThickness = default_floor_thickness,
    cavityFloorRadius = default_cavity_floor_radius,
    efficientFloor=default_efficient_floor,
    halfPitch=default_half_pitch,
    flatBase=default_flat_base,
    spacer=default_spacer),
  vertical_chambers = ChamberSettings(
    chambers_count = default_vertical_chambers,
    separator_bend_position = default_vertical_separator_bend_position,
    separator_bend_angle = default_vertical_separator_bend_angle,
    separator_bend_separation = default_vertical_separator_bend_separation,
    separator_cut_depth = default_vertical_separator_cut_depth,
    irregular_subdivisions = default_vertical_irregular_subdivisions,
    separator_config = default_vertical_separator_config),
  horizontal_chambers = ChamberSettings(
    chambers_count = default_horizontal_chambers,
    separator_bend_position = default_horizontal_separator_bend_position,
    separator_bend_angle = default_horizontal_separator_bend_angle,
    separator_bend_separation = default_horizontal_separator_bend_separation,
    separator_cut_depth = default_horizontal_separator_cut_depth,
    irregular_subdivisions = default_horizontal_irregular_subdivisions,
    separator_config = default_horizontal_separator_config),
  lip_settings = LipSettings(
    lipStyle=default_lip_style, 
    lipSideReliefTrigger=default_lip_side_relief_trigger, 
    lipTopReliefHeight=default_lip_top_relief_height, 
    lipNotch=default_lip_top_notches),
  headroom=default_headroom,
  tapered_corner = default_tapered_corner,
  tapered_corner_size = default_tapered_corner_size,
  tapered_setback = default_tapered_setback,
  wallpattern_walls=default_wallpattern_walls, 
  wallpattern_dividers_enabled = default_wallpattern_dividers_enabled,
  wall_pattern_settings  = PatternSettings(
    patternEnabled = default_wallpattern_enabled, 
    patternStyle = default_wallpattern_style, 
    patternRotate = default_wallpattern_rotate_grid,
    patternFill = default_wallpattern_fill,
    patternBorder = default_wallpattern_border, 
    patternDepth = default_wallpattern_depth,
    patternCellSize = default_wallpattern_cell_size, 
    patternHoleSides = default_wallpattern_hole_sides,
    patternStrength = default_wallpattern_strength, 
    patternHoleRadius = default_wallpattern_hole_radius,
    patternGridChamfer = default_wallpattern_pattern_grid_chamfer,
    patternVoronoiNoise = default_wallpattern_pattern_voronoi_noise,
    patternBrickWeight = default_wallpattern_pattern_brick_weight,
    patternFs = default_wallpattern_pattern_quality), 
  floor_pattern_settings = PatternSettings(
    patternEnabled = default_wallpattern_enabled, 
    patternStyle = default_wallpattern_style, 
    patternRotate = default_wallpattern_rotate_grid,
    patternFill = default_wallpattern_fill,
    patternBorder = default_wallpattern_border, 
    patternDepth = default_wallpattern_depth,
    patternCellSize = default_wallpattern_cell_size, 
    patternHoleSides = default_wallpattern_hole_sides,
    patternStrength = default_wallpattern_strength, 
    patternHoleRadius = default_wallpattern_hole_radius,
    patternGridChamfer = default_wallpattern_pattern_grid_chamfer,
    patternVoronoiNoise = default_wallpattern_pattern_voronoi_noise,
    patternBrickWeight = default_wallpattern_pattern_brick_weight,
    patternFs = default_wallpattern_pattern_quality), 
  wallcutout_vertical_settings=WallCutoutSettings(
    type = default_wallcutout_vertical, 
    position = default_wallcutout_vertical_position, 
    width = default_wallcutout_vertical_width,
    angle = default_wallcutout_vertical_angle,
    height = default_wallcutout_vertical_height, 
    corner_radius = default_wallcutout_vertical_corner_radius),
  wallcutout_horizontal_settings=WallCutoutSettings(
    type = default_wallcutout_horizontal, 
    position = default_wallcutout_horizontal_position, 
    width = default_wallcutout_horizontal_width,
    angle = default_wallcutout_horizontal_angle,
    height = default_wallcutout_horizontal_height, 
    corner_radius = default_wallcutout_horizontal_corner_radius),
  extendable_Settings = ExtendableSettings(
    extendablexEnabled = default_extension_x_enabled, 
    extendablexPosition = default_extension_x_position, 
    extendableyEnabled = default_extension_y_enabled, 
    extendableyPosition = default_extension_y_position, 
    extendableTabsEnabled = default_extension_tabs_enabled, 
    extendableTabSize = default_extension_tab_size),
  sliding_lid_enabled = default_sliding_lid_enabled,
  sliding_lid_thickness = default_sliding_lid_thickness,
  sliding_lid_lip_enabled=default_sliding_lid_lip_enabled,
  sliding_min_wall_thickness = default_sliding_min_wallThickness, 
  sliding_min_support = default_sliding_min_support, 
  sliding_clearance = default_sliding_clearance,
  cupBaseTextSettings = CupBaseTextSettings(
    baseTextLine1Enabled = default_text_1,
    baseTextLine2Enabled = default_text_2,
    baseTextLine2Value = default_text_2_text,
    baseTextFontSize = default_text_size,
    baseTextFont = default_text_font,
    baseTextDepth = default_text_depth,
    baseTextOffset = default_text_offset)) {
  
  //num_x = is_undef($num_x) ? calcDimensionWidth(width, true) : $num_x;
  //num_y = is_undef($num_y) ? calcDimensionDepth(depth, true) : $num_y;
  //num_z = is_undef($num_z) ? calcDimensionHeight(height, true) : $num_z;
  
  num_x = is_undef(width) ?  $num_x : calcDimensionWidth(width, true);
  num_y = is_undef(depth) ? $num_y : calcDimensionDepth(depth, true);
  num_z = is_undef(height) ? $num_z : calcDimensionHeight(height, true);


  //wall_thickness default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
  wall_thickness = wallThickness(wall_thickness, num_z);

  filled_in = validateFilledIn(filled_in);
  label_settings=ValidateLabelSettings(label_settings);
  extendable_Settings = ValidateExtendableSettings(extendable_Settings, num_x=num_x, num_y=num_y);
  cupBase_settings = ValidateCupBaseSettings(cupBase_settings);
  floor_pattern_settings = ValidatePatternSettings(floor_pattern_settings);
  wall_pattern_settings = ValidatePatternSettings(wall_pattern_settings);
  
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
  efficient_floor = cupBase_settings[iCupBase_EfficientFloor];
  floor_thickness = cupBase_settings[iCupBase_FloorThickness];
  floorHeight = calculateFloorHeight(
    magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
    screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
    floor_thickness=cupBase_settings[iCupBase_FloorThickness],
    num_z=num_z,
    filled_in=filled_in, 
    efficient_floor=efficient_floor, 
    flat_base=cupBase_settings[iCupBase_FlatBase],
    captive_magnet_height=cupBase_settings[iCupBase_MagnetCaptiveHeight]);
  sepFloorHeight = (efficient_floor != "off" ? floor_thickness : floorHeight);
       
  calculated_vertical_separator_positions = calculateSeparators(
    separator_config = vertical_chambers[iChamber_irregular_subdivisions] 
      ? vertical_chambers[iChamber_separator_config]  
      : splitChamber(vertical_chambers[iChamber_count]-1, divider_width=vertical_chambers[iChamber_wall_thickness].x, container_width=num_x*env_pitch().x - env_clearance().x - wall_thickness*2), 
    length = env_pitch().y*num_y,
    height = env_pitch().z*(num_z)-sepFloorHeight+fudgeFactor*2-max(headroom, vertical_chambers[iChamber_wall_headroom]),
    wall_thickness = vertical_chambers[iChamber_wall_thickness],
    wall_top_radius = vertical_chambers[iChamber_wall_top_radius],
    bend_position = vertical_chambers[iChamber_separator_bend_position],
    bend_angle = vertical_chambers[iChamber_separator_bend_angle],
    bend_separation = vertical_chambers[iChamber_separator_bend_separation],
    cut_depth = vertical_chambers[iChamber_separator_cut_depth]);
  calculated_horizontal_separator_positions = calculateSeparators(
    separator_config = horizontal_chambers[iChamber_irregular_subdivisions] 
      ? horizontal_chambers[iChamber_separator_config] 
      : splitChamber(horizontal_chambers[iChamber_count]-1, divider_width=horizontal_chambers[iChamber_wall_thickness].x, container_width=num_y*env_pitch().y - env_clearance().y - wall_thickness*2), 
    length = env_pitch().x*num_x,
    height = env_pitch().z*(num_z)-sepFloorHeight+fudgeFactor*2-max(headroom, horizontal_chambers[iChamber_wall_headroom]),
    wall_thickness = horizontal_chambers[iChamber_wall_thickness],
    wall_top_radius = horizontal_chambers[iChamber_wall_top_radius],
    bend_position = horizontal_chambers[iChamber_separator_bend_position],
    bend_angle = horizontal_chambers[iChamber_separator_bend_angle],
    bend_separation = horizontal_chambers[iChamber_separator_bend_separation],
    cut_depth = horizontal_chambers[iChamber_separator_cut_depth]);

  //wallpattern_hole_size = is_list(wallpattern_hole_size) ? wallpattern_hole_size : [wallpattern_hole_size,wallpattern_hole_size];
  $gfc=[["num_x",num_x],["num_y",num_y],["num_z",num_z],["calculated_vertical_separator_positions",calculated_vertical_separator_positions],["calculated_horizontal_separator_positions",calculated_horizontal_separator_positions]];
     
  //Correct legacy values, values that used to work one way but were then changed.
  wallpattern_dividers_enabled = is_bool(wallpattern_dividers_enabled)
    ? wallpattern_dividers_enabled ? "vertical" : "disabled"
    : wallpattern_dividers_enabled;
  
  cavityFloorRadius = calculateCavityFloorRadius(cupBase_settings[iCupBase_CavityFloorRadius], wall_thickness, cupBase_settings[iCupBase_EfficientFloor]);
  
  if(env_generate_filter_enabled("cup"))
  debug_cut()
  union(){
    difference() {

        border = 0; //Believe this to be no longer needed
       
        wallpatternzpos = wallpatternClearanceHeight(
          magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
          screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
          center_magnet=cupBase_settings[iCupBase_CenterMagnetSize][iCylinderDimension_Height], 
          floor_thickness = cupBase_settings[iCupBase_FloorThickness],
          num_z=num_z, 
          filled_in=FilledIn_disabled, 
          efficient_floor=efficient_floor, 
          flat_base=cupBase_settings[iCupBase_FlatBase], 
          floor_inner_radius = cavityFloorRadius, 
          outer_cup_radius = 1);

        //I feel this should use wallTop, but it seems to work...
        heightz = env_pitch().z*(num_z)-wallpatternzpos + (
          //Position specific to each LIP style
          lip_settings[iLipStyle] == "reduced" ? 0.6 :
          lip_settings[iLipStyle] == "reduced_double" ? 0.6 :
          lip_settings[iLipStyle] == "minimum" ? 3 -border*2
           : -gf_lip_height-1.8);
        z=wallpatternzpos+heightz/2;
           
        cutoutclearance_divider = env_corner_radius()/2;

        wallTop = calculateWallTop(num_z, lip_settings[iLipStyle]);

        tapered_setback = tapered_setback < 0 ? env_corner_radius() : tapered_setback;
        tapered_corner_size =
              tapered_corner_size == -2 ? (wallTop - floorHeight)/2
            : tapered_corner_size < 0 ? wallTop - floorHeight //meant for -1, but also catch others
            : tapered_corner_size == 0 ? wallTop - floorHeight - cavityFloorRadius
            : tapered_corner_size;

      coloured_wall_pattern(
        wall_pattern_settings=wall_pattern_settings, wall_thickness=wall_thickness, wallpattern_walls=wallpattern_walls,
        pattern_floor = z, pattern_height = heightz, colored_pattern = wall_pattern_settings[iPatternColored]){ 

        //coloured_wall_pattern child 0 (Outer block)
        grid_block(
          num_x, num_y, num_z,
          cupBase_settings = cupBase_settings,
          wall_thickness = wall_thickness,
          lip_settings = lip_settings,
          filledin = filled_in);

        //coloured_wall_pattern child 1 bin cavities and negative volumes
        union(){
          //primary cavity
          if(filled_in == FilledIn_disabled) 
          partitioned_cavity(
            num_x, num_y, num_z,
            label_settings=label_settings,
            cupBase_settings = cupBase_settings,
            finger_slide_settings = finger_slide_settings,
            wall_thickness=wall_thickness,
            calculated_vertical_separator_positions = calculated_vertical_separator_positions,
            calculated_horizontal_separator_positions = calculated_horizontal_separator_positions,
            lip_settings=lip_settings,
            headroom=headroom,
            sliding_lid_settings= slidingLidSettings);

          bin_cutouts(
            num_x = num_x, num_y = num_y, num_z = num_z,
            wall_thickness = wall_thickness,
            cavityFloorRadius = cavityFloorRadius,
            wallTop = wallTop,
            floorHeight = floorHeight,
            wallcutout_vertical_settings = wallcutout_vertical_settings, 
            wallcutout_horizontal_settings = wallcutout_horizontal_settings, 
            tapered_corner = tapered_corner,
            tapered_corner_size = tapered_corner_size,
            tapered_setback = tapered_setback);

          bin_floor_pattern(
            num_x = num_x,
            num_y = num_y,
            wall_thickness = wall_thickness,
            cupBase_settings = cupBase_settings,
            calculated_vertical_separator_positions = calculated_vertical_separator_positions,
            calculated_horizontal_separator_positions = calculated_horizontal_separator_positions,
            floor_pattern_settings = floor_pattern_settings,
            sepFloorHeight = sepFloorHeight,
            fudgeFactor = fudgeFactor,
            cutoutclearance_divider = cutoutclearance_divider);
    
        bin_wall_pattern(
            num_x = num_x,
            num_y = num_y,
            num_z = num_z,
            wall_thickness = wall_thickness,
            cavityFloorRadius = cavityFloorRadius,
            wallTop = wallTop,
            floorHeight = floorHeight,
            label_settings = label_settings,
            calculated_vertical_separator_positions = calculated_vertical_separator_positions,
            calculated_horizontal_separator_positions = calculated_horizontal_separator_positions,
            wall_pattern_settings = wall_pattern_settings,
            wallpattern_walls = wallpattern_walls,
            wallpattern_dividers_enabled = wallpattern_dividers_enabled,
            sepFloorHeight = sepFloorHeight,
            cutoutclearance_divider = cutoutclearance_divider,
            border = border,
            heightz = heightz,
            z = z,
            wallpatternzpos = wallpatternzpos,
            tapered_corner = tapered_corner,
            tapered_corner_size = tapered_corner_size,
            tapered_setback = tapered_setback,
            wallcutout_vertical_settings = wallcutout_vertical_settings,
            wallcutout_horizontal_settings = wallcutout_horizontal_settings,
            enable_outer_walls = false,
            enable_inner_walls = true);
        }

        //coloured_wall_pattern child 2 wall pattern cavities
        //color(env_colour(color_wallcutout))
        bin_wall_pattern(
            num_x = num_x,
            num_y = num_y,
            num_z = num_z,
            wall_thickness = wall_thickness,
            cavityFloorRadius = cavityFloorRadius,
            wallTop = wallTop,
            floorHeight = floorHeight,
            label_settings = label_settings,
            calculated_vertical_separator_positions = calculated_vertical_separator_positions,
            calculated_horizontal_separator_positions = calculated_horizontal_separator_positions,
            wall_pattern_settings = wall_pattern_settings,
            wallpattern_walls = wallpattern_walls,
            wallpattern_dividers_enabled = wallpattern_dividers_enabled,
            sepFloorHeight = sepFloorHeight,
            cutoutclearance_divider = cutoutclearance_divider,
            border = border,
            heightz = heightz,
            z = z,
            wallpatternzpos = wallpatternzpos,
            tapered_corner = tapered_corner,
            tapered_corner_size = tapered_corner_size,
            tapered_setback = tapered_setback,
            wallcutout_vertical_settings = wallcutout_vertical_settings,
            wallcutout_horizontal_settings = wallcutout_horizontal_settings,
            enable_outer_walls = true,
            enable_inner_walls = false);
      } //coloured_wall_pattern

      if(label_settings[iLabelSettings_style] != LabelStyle_disabled){
        //generate the label sockets
        gridfinity_label(
          num_x = num_x,
          num_y = num_y,
          zpoint = zpoint,
          vertical_separator_positions = calculated_vertical_separator_positions,
          horizontal_separator_positions = calculated_horizontal_separator_positions,
          label_settings=label_settings,
          render_option = "socket",
          socket_padding = [0,0,4]);
    }

    // add text to the bottom
    _magnet_position = calculateAttachmentPositions(cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Diameter], cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Diameter]);

    if(env_help_enabled("trace")) echo("cup_base_text", _magnet_position=_magnet_position, iCupBase_MagnetSize=cupBase_settings[iCupBase_MagnetSize]);
    cup_base_text(
      cupBaseTextSettings = cupBaseTextSettings, 
      wall_thickness = wall_thickness,
      magnet_position = _magnet_position.x);
  
    cut_bins_for_extension(
      num_x = num_x,
      num_y = num_y,
      num_z = num_z,
      extendable_Settings = extendable_Settings);
    }
    
    //add the extention tabs
    extension_tabs(
      num_x = num_x,
      num_y = num_y,
      num_z = num_z,
      extendable_Settings = extendable_Settings,
      cupBase_settings = cupBase_settings,
      lip_settings = lip_settings,
      floor_thickness = floor_thickness,
      wall_thickness = wall_thickness,
      headroom = headroom);
    
    
    if (lip_settings[iLipStyle] == "reduced_double") {
      label_size=calculateLabelSize(label_settings[iLabelSettings_size]);
      labelCornerRadius = label_size[3];
      lipHeight = 3.75;
      tz(- lipHeight -labelCornerRadius)
      tz(zpoint)
      cupLip(
      num_x = num_x,
      num_y = num_y,
      lipStyle = lip_settings[iLipStyle],
      wall_thickness = wall_thickness,
      lip_notches = false,
      lip_top_relief_height = lip_settings[iLipTopReliefHeight],
      lip_top_relief_width = lip_settings[iLipTopReliefWidth],
      lip_clip_position = lip_settings[iLipClipPosition],
      lip_non_blocking = lip_settings[iLipNonBlocking]);

    }
  }  
  
  if(env_help_enabled("info"))
    //translate(gridfinityRenderPosition(position,num_x,num_y))
    ShowCalipers(
      env_cutx(), 
      env_cuty(), 
      size=[num_x,num_y,num_z], 
      lip_settings[iLipStyle],
      cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
      cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
      cupBase_settings[iCupBase_CenterMagnetSize][iCylinderDimension_Height], 
      floor_thickness = cupBase_settings[iCupBase_FloorThickness], 
      filled_in,
      wall_thickness,
      efficient_floor = cupBase_settings[iCupBase_EfficientFloor], 
      flat_base = cupBase_settings[iCupBase_FlatBase]); 
    
  HelpTxt("gridfinity_cup",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"filled_in",filled_in
    ,"label_settings",label_settings
    ,"finger_slide_settings",finger_slide_settings
    ,"cupBase_settings",cupBase_settings
    ,"wall_thickness",wall_thickness
    ,"vertical_chambers",vertical_chambers
    ,"horizontal_chambers",horizontal_chambers
    ,"lip_settings",lip_settings
    ,"headroom",headroom
    ,"tapered_corner",tapered_corner
    ,"tapered_corner_size",tapered_corner_size
    ,"tapered_setback",tapered_setback
    ,"wallpattern_walls",wallpattern_walls
    ,"wall_pattern_settings",wall_pattern_settings
    ,"floor_pattern_settings",floor_pattern_settings
    ,"wallcutout_vertical_settings",wallcutout_vertical_settings
    ,"wallcutout_horizontal_settings",wallcutout_horizontal_settings
    ,"extendable_Settings",extendable_Settings
    ]
    ,env_help_enabled("info"));  
}

module bin_wall_pattern(
  num_x,
  num_y,
  num_z,
  wall_thickness,
  cavityFloorRadius,
  wallTop,
  floorHeight,
  label_settings,
  calculated_vertical_separator_positions,
  calculated_horizontal_separator_positions,
  wall_pattern_settings,
  wallpattern_walls,
  wallpattern_dividers_enabled,
  sepFloorHeight,
  cutoutclearance_divider,
  border,
  heightz,
  z,
  wallpatternzpos,
  tapered_corner,
  tapered_corner_size,
  tapered_setback,
  wallcutout_vertical_settings,
  wallcutout_horizontal_settings,
  enable_outer_walls = true,
  enable_inner_walls = true,
) {
  fudgeFactor = 0.01;

  wallpattern_thickness = get_related_value(wall_pattern_settings[iPatternDepth], wall_thickness) + fudgeFactor*4;

  cutout_clearance_border = max(wall_thickness, wall_pattern_settings[iPatternBorder]);

  //TODO: wall pattern needs to take in to account head room.
  //TODO: wall pattern should partial depth walls.
  
  //Wall patterns
  //Wall pattern in outerwalls
  if(wall_pattern_settings[iPatternEnabled]){
    difference(){
      union(){
        if(wall_pattern_settings[iPatternEnabled]){
          labelSize = calculateLabelSize(label_settings[iLabelSettings_size]);
          //Subtracting the wallpattern_thickness is a bit of a hack, its needed as the label extends in to the wall.
          labelSizez = (label_settings[iLabelSettings_style] != LabelStyle_disabled ? labelSize.z-wallpattern_thickness : 0);

          positions = get_wallpattern_positions(
            border = border,
            heightz = heightz,
            positionz = z,
            wall_thickness = wall_thickness,
            wallpattern_thickness = wallpattern_thickness,
            wallpattern_walls = wallpattern_walls,
            label_walls = label_settings[iLabelSettings_walls],
            label_sizez = labelSizez);

          ylocations = positions.y;
          xlocations = positions.x;
          front = xlocations[0];
          left = ylocations[0];

          //patterns in the outer walls x
          difference(){
            union(){
              for(i = [0:1:len(ylocations)-1])
                if(enable_outer_walls && ylocations[i][4] > 0)
                  translate(ylocations[i][1])
                  mirror(ylocations[i][3])
                  rotate(ylocations[i][2])
                  render_conditional(env_force_render())
                    cutout_pattern(
                      patternStyle = wall_pattern_settings[iPatternStyle],
                      canvasSize = [ylocations[i][0].x, ylocations[i][0].y],
                      border = wall_pattern_settings[iPatternBorder],
                      customShape = false,
                      circleFn = wall_pattern_settings[iPatternHoleSides],
                      cellSize = wall_pattern_settings[iPatternCellSize],
                      strength = wall_pattern_settings[iPatternStrength],
                      holeHeight = ylocations[i][0].z + fudgeFactor,
                      center=true,
                      centerz = true,
                      fill = wall_pattern_settings[iPatternFill], //"none", "space", "crop"
                      patternGridChamfer = wall_pattern_settings[iPatternGridChamfer],
                      patternVoronoiNoise = wall_pattern_settings[iPatternVoronoiNoise],
                      patternBrickWeight = wall_pattern_settings[iPatternBrickWeight],
                      partialDepth = wall_pattern_settings[iPatternDepth] != 0,
                      holeRadius = wall_pattern_settings[iPatternHoleRadius],
                      source = "wall_pattern",
                      rotateGrid = wall_pattern_settings[iPatternRotate],
                      patternFs = wall_pattern_settings[iPatternFs]);
                      
                if(enable_inner_walls && wallpattern_dividers_enabled == "vertical" || wallpattern_dividers_enabled == "both")
                  position_separators(
                    calculatedSeparators = calculated_vertical_separator_positions, 
                    separator_orientation = "vertical")
                      let(verSepThickness = $sepCfg[iSeparatorWallThickness][0]+$sepCfg[iSeparatorBendSeparation]+fudgeFactor*2)
                      //translate([verSepThickness/2+wall_thickness/2-fudgeFactor, 0, 0])
                      translate([wall_thickness/2-fudgeFactor*2, 0, 0])
                      translate(left[1])
                      mirror(left[3])
                      rotate(left[2])
                      render_conditional(env_force_render())
                        //separator wall pattern
                        cutout_pattern(
                          patternStyle = wall_pattern_settings[iPatternStyle],
                          canvasSize = [left[0].x, left[0].y], 
                          border = wall_pattern_settings[iPatternBorder],
                          customShape = false,
                          circleFn = wall_pattern_settings[iPatternHoleSides],
                          cellSize = wall_pattern_settings[iPatternCellSize],
                          strength = wall_pattern_settings[iPatternStrength],
                          holeHeight = verSepThickness+fudgeFactor,
                          center=true,
                          centerz = true,
                          fill=wall_pattern_settings[iPatternFill],
                          patternGridChamfer = wall_pattern_settings[iPatternGridChamfer],
                          patternVoronoiNoise = wall_pattern_settings[iPatternVoronoiNoise],
                          patternBrickWeight = wall_pattern_settings[iPatternBrickWeight],
                          partialDepth = wall_pattern_settings[iPatternDepth] != 0,
                          holeRadius = wall_pattern_settings[iPatternHoleRadius],
                          source="vertical separator wall pattern",
                          rotateGrid = wall_pattern_settings[iPatternRotate],
                          patternFs = wall_pattern_settings[iPatternFs]);
            }    
              
            //subtract dividers from wall patterns
            translate([env_pitch().x*num_x, wall_thickness+env_clearance().y/2, sepFloorHeight-fudgeFactor])
            separators(
              calculatedSeparators = calculated_horizontal_separator_positions,
              separator_orientation = "horizontal",
              pad_wall_thickness = cutoutclearance_divider*2,
              pad_wall_height = fudgeFactor,
              source = "bin_wall_pattern");
          }
            
          //patterns in the outer walls y
          difference(){
            union(){
              for(i = [0:1:len(xlocations)-1])
                if(enable_outer_walls && xlocations[i][4] > 0)
                  translate(xlocations[i][1])
                  mirror(xlocations[i][3])
                  rotate(xlocations[i][2])
                  render_conditional(env_force_render())
                    cutout_pattern(
                      patternStyle = wall_pattern_settings[iPatternStyle],
                      canvasSize = [xlocations[i][0].x, xlocations[i][0].y],
                      border = wall_pattern_settings[iPatternBorder],
                      customShape = false,
                      circleFn = wall_pattern_settings[iPatternHoleSides],
                      cellSize = wall_pattern_settings[iPatternCellSize],
                      strength = wall_pattern_settings[iPatternStrength],
                      holeHeight = xlocations[i][0].z+fudgeFactor,
                      center = true,
                      centerz = true,
                      fill = wall_pattern_settings[iPatternFill], //"none", "space", "crop"
                      patternGridChamfer = wall_pattern_settings[iPatternGridChamfer],
                      patternVoronoiNoise = wall_pattern_settings[iPatternVoronoiNoise],
                      patternBrickWeight = wall_pattern_settings[iPatternBrickWeight],
                      partialDepth = wall_pattern_settings[iPatternDepth] != 0,
                      holeRadius = wall_pattern_settings[iPatternHoleRadius],
                      source = "wall_pattern",
                      rotateGrid = wall_pattern_settings[iPatternRotate],
                      patternFs = wall_pattern_settings[iPatternFs]);
                      
                  if(enable_inner_walls && wallpattern_dividers_enabled == "horizontal" || wallpattern_dividers_enabled == "both")
                    position_separators(
                      calculatedSeparators = calculated_horizontal_separator_positions, 
                      separator_orientation = "horizontal")
                        let(hozSepThickness = $sepCfg[iSeparatorWallThickness][0]+$sepCfg[iSeparatorBendSeparation]+fudgeFactor*2)
                        rotate([0,0,-90])
                        //translate([0, hozSepThickness/2+wall_thickness/2-fudgeFactor, 0])
                        translate([0, wall_thickness/2-fudgeFactor*2, 0])
                        translate(front[1])
                        mirror(front[3])
                        rotate(front[2])
                        render_conditional(env_force_render())
                          //separator wall pattern
                          cutout_pattern(
                            patternStyle = wall_pattern_settings[iPatternStyle],
                            canvasSize = [front[0].x, front[0].y], 
                            border = wall_pattern_settings[iPatternBorder],
                            customShape = false,
                            circleFn = wall_pattern_settings[iPatternHoleSides],
                            cellSize = wall_pattern_settings[iPatternCellSize],
                            strength = wall_pattern_settings[iPatternStrength],
                            holeHeight = hozSepThickness+fudgeFactor,
                            center = true,
                            centerz = true,
                            fill = wall_pattern_settings[iPatternFill], 
                            patternGridChamfer = wall_pattern_settings[iPatternGridChamfer],
                            patternVoronoiNoise = wall_pattern_settings[iPatternVoronoiNoise],
                            patternBrickWeight = wall_pattern_settings[iPatternBrickWeight],
                            partialDepth = wall_pattern_settings[iPatternDepth] != 0,
                            holeRadius = wall_pattern_settings[iPatternHoleRadius],
                            source = "horizontal separator wall pattern",
                            rotateGrid = wall_pattern_settings[iPatternRotate],
                            patternFs = wall_pattern_settings[iPatternFs]);
            }
              
            //subtract dividers from outer wall pattern
            translate([wall_thickness+env_clearance().x/2, 0, sepFloorHeight-fudgeFactor])
            separators(
              calculatedSeparators = calculated_vertical_separator_positions,
              separator_orientation = "vertical",
              pad_wall_thickness = cutoutclearance_divider*2,
              pad_wall_height = fudgeFactor,
              source = "bin_wall_pattern");
          }
        }
      }

      bin_cutouts(
        num_x = num_x,
        num_y = num_y,
        num_z = num_z,
        wall_thickness = wall_thickness,
        cavityFloorRadius = cavityFloorRadius,
        wallTop = wallTop,
        floorHeight = floorHeight,
        wallcutout_vertical_settings = wallcutout_vertical_settings,
        wallcutout_horizontal_settings = wallcutout_horizontal_settings,
        tapered_corner = tapered_corner,
        tapered_corner_size = tapered_corner_size,
        tapered_setback = tapered_setback,
        cutout_clearance_border = cutout_clearance_border);
    }
  }
}

module bin_floor_pattern(
  num_x,
  num_y,
  wall_thickness,
  cupBase_settings,
  calculated_vertical_separator_positions,
  calculated_horizontal_separator_positions,
  floor_pattern_settings,
  sepFloorHeight,
  fudgeFactor,
  cutoutclearance_divider,
) {
  if(floor_pattern_settings[iPatternEnabled]){
    difference(){
      pad_copy(
        num_x = num_x, 
        num_y = num_y, 
        half_pitch = cupBase_settings[iCupBase_HalfPitch], 
        flat_base = cupBase_settings[iCupBase_FlatBase], 
        minimium_size = cupBase_settings[iCupBase_MinimumPrintablePadSize])
          translate([$pad_copy_size.x*env_pitch().x/2, $pad_copy_size.y*env_pitch().y/2,-fudgeFactor])
          cutout_pattern(
            patternStyle = floor_pattern_settings[iPatternStyle],
            canvasSize = [$pad_copy_size.x*env_pitch().x, $pad_copy_size.y*env_pitch().y],
            circleFn = floor_pattern_settings[iPatternHoleSides],
            cellSize = floor_pattern_settings[iPatternCellSize],
            strength = floor_pattern_settings[iPatternStrength],
            holeHeight = sepFloorHeight + fudgeFactor*6,
            center = true,
            fill = floor_pattern_settings[iPatternFill],
            patternGridChamfer = floor_pattern_settings[iPatternGridChamfer],
            patternVoronoiNoise = floor_pattern_settings[iPatternVoronoiNoise],
            patternBrickWeight = floor_pattern_settings[iPatternBrickWeight],
            partialDepth = floor_pattern_settings[iPatternDepth] != 0,
            border = max(5, floor_pattern_settings[iPatternBorder],
              cupBase_settings[iCupBase_EfficientFloor] == EfficientFloor_smooth? 6.5 : 0),
            holeRadius = floor_pattern_settings[iPatternHoleRadius],
            patternFs = floor_pattern_settings[iPatternFs],
            rotateGrid = floor_pattern_settings[iPatternRotate],
            source="floor_pattern");

      //subtract dividers from floor pattern
      //Potential bug if the wall height is less than the floor height
      translate([wall_thickness+env_clearance().x/2, 0, -fudgeFactor])
      separators(
        calculatedSeparators = calculated_vertical_separator_positions,
        separator_orientation = "vertical",
        pad_wall_thickness = cutoutclearance_divider*2,
        source = "bin_floor_pattern");
        
      //subtract dividers from floor pattern
      //Potential bug if the wall height is less than the floor height
      translate([env_pitch().x*num_x, wall_thickness+env_clearance().y/2, -fudgeFactor])
      separators(
        calculatedSeparators = calculated_horizontal_separator_positions,
        separator_orientation = "horizontal",
        pad_wall_thickness = cutoutclearance_divider*2,
        source = "bin_floor_pattern");

      // Subtract magnet/screw pads if enabled
      magnet_diameter = cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Diameter];
      screw_diameter = cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Diameter];
      if (magnet_diameter > 0 || screw_depth > 0) {
        magnet_positions = calculateAttachmentPositions(magnet_diameter, screw_diameter);
        pad_radius = max(magnet_diameter, screw_diameter) / 2 + cutoutclearance_divider*2;
        pad_height = sepFloorHeight + fudgeFactor * 6;
        gridcopycorners(num_x, num_y, magnet_positions, cupBase_settings[iCupBase_CornerAttachmentsOnly])
            cylinder(r = pad_radius, h = pad_height, $fn = 32);
      }
    }
  }
}

module bin_cutouts(
  num_x = 0,
  num_y = 0,
  num_z = 0,
  wall_thickness,
  cavityFloorRadius,
  wallTop,
  floorHeight,
  wallcutout_vertical_settings,
  wallcutout_horizontal_settings,
  tapered_corner = "none",
  tapered_corner_size = 0,
  tapered_setback = 0,
  cutout_clearance_border = 0
) {

  wallcutouts_vertical = calculateWallCutouts(
    wall_length = num_x,
    opposite_wall_distance = num_y,
    wallcutout_settings = wallcutout_vertical_settings,
    wallcutout_rotation = [0,0,0],
    wallcutout_reposition = [0,0,0],
    wall_thickness = wall_thickness,
    cavityFloorRadius = cavityFloorRadius,
    wallTop = wallTop,
    z_point = num_z*env_pitch().z,
    floorHeight = floorHeight,
    pitch = env_pitch().x,
    pitch_opposite = env_pitch().y);
  wallcutouts_horizontal = calculateWallCutouts(
    wall_length = num_y,
    opposite_wall_distance = num_x,
    wallcutout_settings = wallcutout_horizontal_settings,
    wallcutout_rotation = [0,0,90],
    wallcutout_reposition = [num_x*env_pitch().x,0,0],
    wall_thickness = wall_thickness,
    cavityFloorRadius = cavityFloorRadius,
    wallTop = wallTop,
    z_point = num_z*env_pitch().z,
    floorHeight = floorHeight,
    pitch = env_pitch().y,
    pitch_opposite = env_pitch().x);
    
  wallcutout_locations = concat(wallcutouts_vertical, wallcutouts_horizontal);

  if(wallcutout_vertical_settings[iwalcutoutconfig_type] != "disabled" || wallcutout_horizontal_settings[iwalcutoutconfig_type] !="disabled" )
    for(wallcutout_location_near_far = wallcutout_locations)
    for(wallcutout_location = wallcutout_location_near_far)
      if(wallcutout_location[iwalcutout_enabled] == true)
        translate(wallcutout_location[iwalcutout_reposition])
        rotate(wallcutout_location[iwalcutout_rotation])
        translate(wallcutout_location[iwalcutout_position])
        WallCutout(
          lowerWidth=wallcutout_location[iwalcutout_size].x+cutout_clearance_border*2,
          wallAngle=wallcutout_location[iwalcutout_config][iwalcutoutconfig_angle],
          height=wallcutout_location[iwalcutout_size].z+cutout_clearance_border,
          thickness=wallcutout_location[iwalcutout_size].y,
          cornerRadius=wallcutout_location[iwalcutout_config][iwalcutoutconfig_cornerradius]);

  //Tapered corner cutout  // Add tapered corner cutout if enabled
  if(tapered_corner == "rounded" || tapered_corner == "chamfered"){
    translate([0, 
      tapered_setback + env_clearance().y+cutout_clearance_border, 
      env_pitch().z * num_z + gf_Lip_Height - env_clearance().z-cutout_clearance_border])
    rotate([270,0,0])
    union(){
      if(tapered_corner == "rounded"){
        roundedCorner(
          radius = tapered_corner_size+cutout_clearance_border*2,
          length = (num_x + 1) * env_pitch().x,
          height = tapered_corner_size,
          width = tapered_corner_size + tapered_setback);
      }
      else if(tapered_corner == "chamfered"){
        chamferedCorner(
          chamferLength = tapered_corner_size,
          length = (num_x + 1) * env_pitch().x,
          height = tapered_corner_size,
          width = tapered_corner_size + tapered_setback);
      }
    }
  }
}

module partitioned_cavity(num_x, num_y, num_z, 
    label_settings=[],
    cupBase_settings=[],
    finger_slide_settings=[],
    wall_thickness=0,
    calculated_vertical_separator_positions=calculated_vertical_separator_positions,
    calculated_horizontal_separator_positions=calculated_horizontal_separator_positions,
    lip_settings=[], 
    headroom=default_headroom, 
    sliding_lid_settings=[]) {
  
  //Legacy variables
  flat_base=cupBase_settings[iCupBase_FlatBase];
  cavity_floor_radius=cupBase_settings[iCupBase_CavityFloorRadius];
  spacer=cupBase_settings[iCupBase_Spacer];
  box_corner_attachments_only=cupBase_settings[iCupBase_CornerAttachmentsOnly];
  efficient_floor=cupBase_settings[iCupBase_EfficientFloor]; 
  half_pitch=cupBase_settings[iCupBase_HalfPitch];        
  magnet_diameter=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Diameter];
  screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height];
  magnet_easy_release=cupBase_settings[iCupBase_MagnetEasyRelease];
  floor_thickness=cupBase_settings[iCupBase_FloorThickness];  
  zpoint = env_pitch().z*num_z-headroom;

  floorHeight = calculateFloorHeight(
    magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
    screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
    floor_thickness=cupBase_settings[iCupBase_FloorThickness],
    num_z=num_z,
    filled_in="disabled", 
    efficient_floor=efficient_floor, 
    flat_base=cupBase_settings[iCupBase_FlatBase],
    captive_magnet_height=cupBase_settings[iCupBase_MagnetCaptiveHeight]);
    
  difference() {
    color(env_colour(color_cupcavity))
    union(){
    basic_cavity(num_x, num_y, num_z,
      cupBase_settings=cupBase_settings,
      finger_slide_settings = finger_slide_settings,
      wall_thickness=wall_thickness,
      lip_settings=lip_settings, 
      sliding_lid_settings=sliding_lid_settings, 
      headroom=headroom);
    }
    
    if(env_help_enabled("trace")) echo("partitioned_cavity", vertical_separator_positions=calculated_vertical_separator_positions);

    sepFloorHeight = (efficient_floor != "off" ? floor_thickness : floorHeight);
    
    color(env_colour(color_divider))
    tz(sepFloorHeight-fudgeFactor)
    translate([wall_thickness+env_clearance().x/2, 0, 0])
    separators(
      calculatedSeparators = calculated_vertical_separator_positions,
      separator_orientation = "vertical",
      source = "partitioned_cavity");

    if(env_help_enabled("trace")) echo("partitioned_cavity", horizontal_separator_positions=calculated_horizontal_separator_positions);
    
    color(env_colour(color_divider))
    translate([env_pitch().x*num_x, wall_thickness+env_clearance().y/2, sepFloorHeight-fudgeFactor])
    separators(
      calculatedSeparators = calculated_horizontal_separator_positions, 
      separator_orientation = "horizontal",
      source = "partitioned_cavity");
      
    if(label_settings[iLabelSettings_style] != LabelStyle_disabled){
      gridfinity_label(
        num_x = num_x,
        num_y = num_y,
        zpoint = zpoint,
        vertical_separator_positions = calculated_vertical_separator_positions,
        horizontal_separator_positions = calculated_horizontal_separator_positions,
        label_settings=label_settings,
        render_option = "labelwithsocket");
    }
  }
}           



module basic_cavity(num_x, num_y, num_z, 
    finger_slide_settings = [],
    wall_thickness=default_wall_thickness,
    lip_settings = [],
    cupBase_settings = [],
    sliding_lid_settings = [],
    divider_wall_removable_settings = [],
    headroom = 0) {

  //Legacy variables
  floor_thickness=cupBase_settings[iCupBase_FloorThickness]; 
  magnet_diameter=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Diameter];
  screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height];
  magnet_easy_release=cupBase_settings[iCupBase_MagnetEasyRelease];
  flat_base=cupBase_settings[iCupBase_FlatBase];
  spacer=cupBase_settings[iCupBase_Spacer];
  box_corner_attachments_only=cupBase_settings[iCupBase_CornerAttachmentsOnly];
  half_pitch=cupBase_settings[iCupBase_HalfPitch];

  //zpoint = env_pitch().z*num_z-headroom;
  
  AssertSlidingLidSettings(sliding_lid_settings);
  
  innerWallRadius = max(0.1, env_corner_radius()-wall_thickness); //prevent radius going negative
  corner_post_adjust = min(0, env_corner_radius()-wall_thickness-innerWallRadius)*-1;

  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];

  wall_inner_corner_center = let(
    corner_post_adjust = min(0, env_corner_radius()-wall_thickness-innerWallRadius)*-1
    ) [
    inner_corner_center.x-corner_post_adjust, 
    inner_corner_center.y-corner_post_adjust];

  lip_inner_corner_center = corner_post_adjust > 0 ? wall_inner_corner_center : inner_corner_center;
  innerLipRadius = env_corner_radius()-gf_lip_lower_taper_height-gf_lip_upper_taper_height; 

  reducedlipstyle = 
    // replace "reduced" with "none" if z-height is less than 1.2
    (num_z < 1.2) ? "none" 
    // replace with "reduced" if z-height is less than 1.8
    : (num_z < 1.8) ? "reduced" 
    : lip_settings[iLipStyle];

  filledInZ = env_pitch().z*num_z;
  zpoint = filledInZ-headroom;
 
  floorht = min(filledInZ, calculateFloorHeight(
      magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
      screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
      center_magnet=cupBase_settings[iCupBase_CenterMagnetSize][iCylinderDimension_Height], 
      floor_thickness=cupBase_settings[iCupBase_FloorThickness], 
      num_z=num_z,
      filled_in=FilledIn_disabled,
      efficient_floor=cupBase_settings[iCupBase_EfficientFloor],
      flat_base=cupBase_settings[iCupBase_FlatBase],
      captive_magnet_height=cupBase_settings[iCupBase_MagnetCaptiveHeight]));
    
  //Remove floor to create a vertical spacer.
  nofloor = spacer && finger_slide_settings[iFingerSlideType] == "none";
  
  //Difference between the wall and support thickness
  lipSupportThickness = (reducedlipstyle == "minimum" || reducedlipstyle == "none") ? 0
    : reducedlipstyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : reducedlipstyle == "reduced_double" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;
  lipHeight = (reducedlipstyle == "none") ? 0 : gf_Lip_Height-0.65;
  //bottom of the lip where it touches the wall
  lipBottomZ = ((reducedlipstyle == "minimum" || reducedlipstyle == "none") ? env_pitch().z*num_z +fudgeFactor*3
    : reducedlipstyle == "reduced" ? env_pitch().z*num_z+fudgeFactor*3
    : reducedlipstyle == "reduced_double" ? env_pitch().z*num_z+fudgeFactor*3
    : env_pitch().z*num_z-gf_lip_height-lipSupportThickness);
  //lipBottomZ = env_pitch().z*num_z+fudgeFactor*3;


  
  if(env_help_enabled("trace")) echo("basic_cavity", gf_cup_corner_radius=env_corner_radius(),wall_thickness=wall_thickness, env_clearance=env_clearance(), inner_corner_center=inner_corner_center, innerWallRadius=innerWallRadius, innerLipRadius=innerLipRadius);
  aboveLidHeight =  sliding_lid_settings[iSlidingLidThickness] + lipHeight;
  
  //cavityHeight= max(lipBottomZ-floorht,0);
  cavityHeight= max(lipBottomZ-floorht,0);
  cavity_floor_radius = calculateCavityFloorRadius(cupBase_settings[iCupBase_CavityFloorRadius], wall_thickness,cupBase_settings[iCupBase_EfficientFloor]);
  
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // arount the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  
  if(env_help_enabled("trace")) echo("basic_cavity", floorht=floorht, efficient_floor=cupBase_settings[iCupBase_EfficientFloor], nofloor=nofloor, lipSupportThickness=lipSupportThickness, lipBottomZ=lipBottomZ, innerLipRadius=innerLipRadius, innerWallRadius=innerWallRadius, cavityHeight=cavityHeight, cavity_floor_radius=cavity_floor_radius, flat_base=cupBase_settings[iCupBase_FlatBase]);
  
  if(filledInZ>floorht) {
    union(){
    difference() {
    union() {
      if (reducedlipstyle == "minimum" || reducedlipstyle == "none") {
      } 
      else if (reducedlipstyle == "reduced") {
      } 
      else if (reducedlipstyle == "reduced_double") {
      }
      else { // normal
        lowerTaperZ = filledInZ-gf_lip_height-lipSupportThickness;
        if(lowerTaperZ <= floorht){
          hull() cornercopy(lip_inner_corner_center, num_x, num_y)
            tz(floorht) 
            cylinder(r=innerLipRadius, h=filledInZ-floorht+fudgeFactor*4); // lip
        } else {
          if(headroom > 0)
          hull() cornercopy(inner_corner_center, num_x, num_y)
            tz(filledInZ-headroom-fudgeFactor) 
            cylinder(r=innerLipRadius, h=headroom+fudgeFactor*4); // lip

          hull() cornercopy(lip_inner_corner_center, num_x, num_y)
            tz(filledInZ-gf_lip_height-fudgeFactor) 
            cylinder(r=(innerLipRadius > innerWallRadius ? innerWallRadius : innerLipRadius), h=gf_lip_height+fudgeFactor*4); // lip

          hull() cornercopy(lip_inner_corner_center, num_x, num_y)
            tz(filledInZ-gf_lip_height-lipSupportThickness-fudgeFactor) 
            cylinder(
              r1=innerWallRadius,
              r2=innerLipRadius, h=q+fudgeFactor);   // ... to top of thin wall ...
        }
      }
    
      //Cavity below lip
      if(cavityHeight > 0)
       hull() cornercopy(wall_inner_corner_center, num_x, num_y)
        tz(floorht)
          roundedCylinder(
            h=cavityHeight,
            r=innerWallRadius,
            roundedr1=min(cavityHeight, cavity_floor_radius),
            roundedr2=0);
    } //union of main cavity

    if(sliding_lid_settings[iSlidingLidEnabled])
      SlidingLidSupportMaterial(
        num_x = num_x, 
        num_y = num_y,
        wall_thickness = wall_thickness,
        sliding_lid_settings = sliding_lid_settings,
        zpoint=zpoint);
    
    // fingerslide inside bottom of cutout
    if(finger_slide_settings[iFingerSlideType] != "none"){
      FingerSlide(
        num_x = num_x, 
        num_y = num_y,
        num_z = num_z,
        fingerslide_walls=finger_slide_settings[iFingerSlideWalls],
        lipAligned=finger_slide_settings[iFingerSlideLipAligned],
        fingerslide=finger_slide_settings[iFingerSlideType],
        fingerslide_radius=finger_slide_settings[iFingerSlideRadius],
        reducedlipstyle=reducedlipstyle,
        wall_thickness=wall_thickness,
        floorht=floorht,
        inner_corner_center=wall_inner_corner_center);
    }

    if (cupBase_settings[iCupBase_EfficientFloor] != "off") {
      magnetPosition = calculateAttachmentPositions(magnet_diameter, cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Diameter]);
      magnetCoverHeight = max(
        cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
        cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height]);
      hasCornerAttachments = magnet_diameter > 0 || screw_depth > 0;
      efficientFloorGridHeight = max(magnetCoverHeight,gfBaseHeight())+floor_thickness;
      if(env_help_enabled("trace")) echo("basic_cavity", efficient_floor=cupBase_settings[iCupBase_EfficientFloor], efficientFloorGridHeight=efficientFloorGridHeight,  floor_thickness=floor_thickness);
      difference(){
        tz(-fudgeFactor)
          cube([num_x*env_pitch().x, num_y*env_pitch().y, efficientFloorGridHeight]);
        
        difference(){
          efficient_floor_grid(
            num_x, num_y,
            floorStyle = cupBase_settings[iCupBase_EfficientFloor],
            half_pitch=half_pitch,
            flat_base=flat_base,
            floor_thickness=floor_thickness,
            efficientFloorGridHeight=efficientFloorGridHeight,
            align_grid = cupBase_settings[iCupBase_AlignGrid],
            margins=q);
           
           //Screw and magnet covers required for efficient floor
           if(hasCornerAttachments)
             gridcopycorners(num_x, num_y, magnetPosition, box_corner_attachments_only)
                let(magnet_size=cupBase_settings[iCupBase_MagnetSize])
                EfficientFloorAttachmentCaps(
                  grid_copy_corner_index = $gcci,
                  floor_thickness = floor_thickness,
                  magnet_size = cupBase_settings[iCupBase_MagnetSize] + [0, cupBase_settings[iCupBase_MagnetCaptiveHeight]],
                  screw_size = cupBase_settings[iCupBase_ScrewSize],
                  wall_thickness = magnet_easy_release == MagnetEasyRelease_inner ? wall_thickness*2 : wall_thickness );
          }
        }
      }
    }  // difference removals from main body.
    
    //Sliding lid rebate.
    if(sliding_lid_settings[iSlidingLidEnabled])
      tz(zpoint)
      SlidingLidCavity(
        num_x = num_x,
        num_y = num_y,
        wall_thickness = wall_thickness,
        sliding_lid_settings = sliding_lid_settings,
        aboveLidHeight = aboveLidHeight);
  }}
  
  // cut away side lips if num_x is less than 1
  if(env_help_enabled("trace")) echo(str("cutaway input:", num_x, " rounded:", roundtoDecimal(num_x, sigFigs = 2), " numx<1:", num_x < 1," round<1:", roundtoDecimal(num_x, sigFigs = 2)<1, " numx=round:", num_x==roundtoDecimal(num_x, sigFigs = 2)));
  if (roundtoDecimal(num_x,2) < lip_settings[iLipSideReliefTrigger].x) {
    top = num_z*env_pitch().z+gf_Lip_Height;
    height = top-lipBottomZ+fudgeFactor*2;
    
    hull()
    for (x=[1.5+0.25+wall_thickness, num_x*env_pitch().x-1.5-0.25-wall_thickness]){
      for (y=[11, (num_y)*env_pitch().y-wall_inner_corner_center.y])
      translate([x, y, top-height])
      cylinder(d=3, h=height);
    }
  }

  if (roundtoDecimal(num_y,2) < lip_settings[iLipSideReliefTrigger].y) {
    top = num_z*env_pitch().z+gf_Lip_Height;
    height = top-lipBottomZ+fudgeFactor*2;
    
    hull()
    for (y=[1.5+0.25+wall_thickness, num_y*env_pitch().y-1.5-0.25-wall_thickness]){
      for (x=[11, (num_x)*env_pitch().x-wall_inner_corner_center.x])
      translate([x, y, top-height])
      cylinder(d=3, h=height);
    }
  }
  
  if (nofloor) {
    tz(-fudgeFactor)
      hull()
      cornercopy(num_x=num_x, num_y=num_y, r=wall_inner_corner_center)
      cylinder(r=2, h=gf_cupbase_lower_taper_height+fudgeFactor);
    gridcopy(1, 1)
      EfficientFloor(num_x, num_y,-fudgeFactor, q);
  }
}

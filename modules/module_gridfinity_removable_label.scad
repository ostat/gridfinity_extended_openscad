include <gridfinity_constants.scad>
include <functions_general.scad>
include <module_patterns.scad>
include <module_gridfinity_label.scad>
include <module_gridfinity_sliding_lid.scad>
include <module_gridfinity_Extendable.scad>
include <module_gridfinity_cup_base_text.scad>
include <module_gridfinity_cup_base.scad>
include <module_gridfinity_dividers_removable.scad>
include <module_divider_walls.scad>

use <module_gridfinity_block.scad>
use <module_gridfinity_efficient_floor.scad>
use <module_attachment_clip.scad>
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
default_fingerslide_radius = 8;
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

/* [Removable Divider Walls] */
default_divider_walls_enabled = false;
// Wall to enable on, x direction, y direction
default_divider_walls = [1,1];  //[0:1:1]
// Thickness of the divider walls.
default_divider_walls_thickness = 2.5;  //0.1
// Spacing between the divider walls (0=divider_walls_thickness*2).
default_divider_walls_spacing = 0; //0.1
// Thickness of the support walls.
default_divider_walls_support_thickness = 2;
// Size of the slot in the divider walls. width(0=divider_walls_thickness), depth(0=divider_walls_support_thickness)
default_divider_wall_slot_size = [0,0];
// Clearance between the divider walls top
default_divider_headroom = 0.1;
// Clearance subtracted from the removable divider wall. Width, Length
default_divider_clearance = [0.3, 0.2];
// Number of slot spanning divider to generate.
default_divider_slot_spanning = 0;

/* [Base] */
//size of magnet, diameter and height. Zack's original used 6.5 and 2.4 
default_magnet_size = [6.5, 2.4];  // .1
//create relief for magnet removal
default_magnet_easy_release = "auto";//["off","auto","inner","outer"] 
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
default_wallpattern_style = "hexgrid"; //[hexgrid, hexgridrotated, grid, gridrotated, voronoi, voronoigrid, voronoihexgrid, brick, brickrotated, brickoffset, brickoffsetrotated]
default_wallpattern_dividers_enabled ="disabled"; //["disabled", "horizontal", "vertical", "both"] 
default_wallpattern_fill = "none"; //["none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"]
default_wallpattern_walls=[1,0,0,0];  //[0:1:1]
default_wallpattern_hole_sides = 6;
default_wallpattern_hole_size = [10,10]; //0.1
default_wallpattern_hole_spacing = 2; //0.1
default_wallpattern_hole_radius = 0.5;
default_wallpattern_border = 0;
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
module gridfinity_removable_label(
  width=default_width,
  depth=default_depth,
  height=default_height,
  filled_in=default_filled_in,
  label_settings=LabelSettings(
    labelStyle=default_label_style, 
    labelPosition=default_label_position, 
    labelSize=default_label_size,
    labelRelief=default_label_relief,
    labelWalls=default_label_walls),
  sliding_lid_enabled = default_sliding_lid_enabled,
  sliding_lid_thickness = default_sliding_lid_thickness,
  sliding_lid_lip_enabled=default_sliding_lid_lip_enabled,
  fingerslide=default_fingerslide,
  fingerslide_radius=default_fingerslide_radius,
  fingerslide_walls=default_fingerslide_walls,
  fingerslide_lip_aligned=default_fingerslide_lip_aligned,
  cupBase_settings = CupBaseSettings(
    magnetSize = default_magnet_size, 
    magnetEasyRelease = default_magnet_easy_release, 
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
  wall_thickness=default_wall_thickness,
  chamber_wall_thickness=default_chamber_wall_thickness,
  chamber_wall_headroom=default_chamber_wall_headroom,
  divider_wall_removable_settings = DividerRemovableSettings(
    enabled=default_divider_walls_enabled,
    walls=default_divider_walls,
    headroom=default_divider_headroom,
    slot_size=default_divider_wall_slot_size,
    divider_spacing=default_divider_walls_spacing,
    divider_thickness=default_divider_walls_thickness,
    divider_clearance=default_divider_clearance,
    divider_slot_spanning=default_divider_slot_spanning),
  divider_wall_removable_settings = DividerRemovableSettings(
    enabled=divider_walls_enabled,
    walls=divider_walls,
    headroom=divider_headroom,
    support_thickness=divider_walls_support_thickness,
    slot_size=divider_wall_slot_size,
    divider_spacing=divider_walls_spacing,
    divider_thickness=divider_walls_thickness,
    divider_clearance=divider_clearance,
    divider_slot_spanning=divider_slot_spanning),
  vertical_chambers = default_vertical_chambers,
  vertical_separator_bend_position = default_vertical_separator_bend_position,
  vertical_separator_bend_angle = default_vertical_separator_bend_angle,
  vertical_separator_bend_separation = default_vertical_separator_bend_separation,
  vertical_separator_cut_depth = default_vertical_separator_cut_depth,
  vertical_irregular_subdivisions  = default_vertical_irregular_subdivisions,
  vertical_separator_config = default_vertical_separator_config,
  horizontal_chambers = default_horizontal_chambers,
  horizontal_separator_bend_position = default_horizontal_separator_bend_position,
  horizontal_separator_bend_angle = default_horizontal_separator_bend_angle,
  horizontal_separator_bend_separation = default_horizontal_separator_bend_separation,
  horizontal_separator_cut_depth = default_horizontal_separator_cut_depth,
  horizontal_irregular_subdivisions = default_horizontal_irregular_subdivisions,
  horizontal_separator_config = default_horizontal_separator_config,
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
    patternFill = default_wallpattern_fill,
    patternBorder = default_wallpattern_hole_spacing, 
    patternHoleSize = default_wallpattern_hole_size, 
    patternHoleSides = default_wallpattern_hole_sides,
    patternHoleSpacing = default_wallpattern_hole_spacing, 
    patternHoleRadius = default_wallpattern_hole_radius,
    patternGridChamfer = default_wallpattern_pattern_grid_chamfer,
    patternVoronoiNoise = default_wallpattern_pattern_voronoi_noise,
    patternBrickWeight = default_wallpattern_pattern_brick_weight,
    patternFs = default_wallpattern_pattern_quality), 
  floor_pattern_settings = PatternSettings(
    patternEnabled = default_wallpattern_enabled,
    patternStyle = default_wallpattern_style, 
    patternFill = default_wallpattern_fill,
    patternBorder = default_wallpattern_hole_spacing, 
    patternHoleSize = default_wallpattern_hole_size, 
    patternHoleSides = default_wallpattern_hole_sides,
    patternHoleSpacing = default_wallpattern_hole_spacing, 
    patternHoleRadius = default_wallpattern_hole_radius,
    patternGridChamfer = default_wallpattern_pattern_grid_chamfer,
    patternVoronoiNoise = default_wallpattern_pattern_voronoi_noise,
    patternBrickWeight = default_wallpattern_pattern_brick_weight,
    patternFs = default_wallpattern_pattern_quality), 
  wallcutout_vertical=default_wallcutout_vertical,
  wallcutout_vertical_position=default_wallcutout_vertical_position,
  wallcutout_vertical_width=default_wallcutout_vertical_width,
  wallcutout_vertical_angle=default_wallcutout_vertical_angle,
  wallcutout_vertical_height=default_wallcutout_vertical_height,
  wallcutout_vertical_corner_radius=default_wallcutout_vertical_corner_radius,
  wallcutout_horizontal=default_wallcutout_horizontal,
  wallcutout_horizontal_position=default_wallcutout_horizontal_position,
  wallcutout_horizontal_width=default_wallcutout_horizontal_width,
  wallcutout_horizontal_angle=default_wallcutout_horizontal_angle,
  wallcutout_horizontal_height=default_wallcutout_horizontal_height,
  wallcutout_horizontal_corner_radius=default_wallcutout_horizontal_corner_radius,
  extendable_Settings = ExtendableSettings(
    extendablexEnabled = default_extension_x_enabled, 
    extendablexPosition = default_extension_x_position, 
    extendableyEnabled = default_extension_y_enabled, 
    extendableyPosition = default_extension_y_position, 
    extendableTabsEnabled = default_extension_tabs_enabled, 
    extendableTabSize = default_extension_tab_size),
  sliding_lid_enabled = default_sliding_lid_enabled, 
  sliding_lid_thickness = default_sliding_lid_thickness, 
  sliding_min_wall_thickness = default_sliding_min_wallThickness, 
  sliding_min_support = default_sliding_min_support, 
  sliding_clearance = default_sliding_clearance,
  cupBaseTextSettings = CupBaseTextSettings(
    baseTextLine1Enabled = default_text_1,
    baseTextLine2Enabled = default_text_2,
    baseTextLine2Value = default_text_2_text,
    baseTextFontSize = default_text_size,
    baseTextFont = default_text_font,
    baseTextDepth = default_text_depth)) {
  
  num_x = calcDimensionWidth(width, true);
  num_y = calcDimensionDepth(depth, true);
  num_z = calcDimensionHeight(height, true);
  //wall_thickness default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
  wall_thickness = wallThickness(wall_thickness, num_z);

  filled_in = validateFilledIn(filled_in);
  label_settings=ValidateLabelSettings(label_settings);
  extendable_Settings = ValidateExtendableSettings(extendable_Settings, num_x=num_x, num_y=num_y);
  cupBase_settings = ValidateCupBaseSettings(cupBase_settings);
  floor_pattern_settings = ValidatePatternSettings(floor_pattern_settings);
  wall_pattern_settings = ValidatePatternSettings(wall_pattern_settings);
  
  divider_wall_removable_settings = ValidateDividerRemovableSettings(divider_wall_removable_settings, wall_thickness);
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
    flat_base=cupBase_settings[iCupBase_FlatBase]);
  sepFloorHeight = (efficient_floor != "off" ? floor_thickness : floorHeight);
       
  calculated_vertical_separator_positions = calculateSeparators(
    separator_config = vertical_irregular_subdivisions 
      ? vertical_separator_config 
      : splitChamber(vertical_chambers-1, num_x*env_pitch().x), 
    length = env_pitch().y*num_y,
    height = env_pitch().z*(num_z)-sepFloorHeight+fudgeFactor*2-max(headroom, chamber_wall_headroom),
    wall_thickness = chamber_wall_thickness,
    bend_position = vertical_separator_bend_position,
    bend_angle = vertical_separator_bend_angle,
    bend_separation = vertical_separator_bend_separation,
    cut_depth = vertical_separator_cut_depth);
  calculated_horizontal_separator_positions = calculateSeparators(
    separator_config = horizontal_irregular_subdivisions 
      ? horizontal_separator_config 
      : splitChamber(horizontal_chambers-1, num_y*env_pitch().y), 
    length = env_pitch().x*num_x,
    height = env_pitch().z*(num_z)-sepFloorHeight+fudgeFactor*2-max(headroom, chamber_wall_headroom),
    wall_thickness = chamber_wall_thickness,
    bend_position = horizontal_separator_bend_position,
    bend_angle = horizontal_separator_bend_angle,
    bend_separation = horizontal_separator_bend_separation,
    cut_depth = horizontal_separator_cut_depth);

  //wallpattern_hole_size = is_list(wallpattern_hole_size) ? wallpattern_hole_size : [wallpattern_hole_size,wallpattern_hole_size];
  $gfc=[["num_x",num_x],["num_y",num_y],["num_z",num_z],["calculated_vertical_separator_positions",calculated_vertical_separator_positions],["calculated_horizontal_separator_positions",calculated_horizontal_separator_positions]];
     
  //Correct legacy values, values that used to work one way but were then changed.
  wallpattern_dividers_enabled = is_bool(wallpattern_dividers_enabled)
    ? wallpattern_dividers_enabled ? "vertical" : "disabled"
    : wallpattern_dividers_enabled;
  
  debug_cut()
  union(){
    difference() {
      intersection() {
        gridfinity_label(
        num_x = num_x,
        num_y = num_y,
        zpoint = zpoint,
        vertical_separator_positions = calculated_vertical_separator_positions,
        horizontal_separator_positions = calculated_horizontal_separator_positions,
        label_settings = label_settings,
        render_option = "removablelabel");
        
        partitioned_cavity(
          num_x, num_y, num_z,
          label_settings=label_settings,
          cupBase_settings = cupBase_settings,
          fingerslide=fingerslide,
          fingerslide_radius=fingerslide_radius,
          fingerslide_walls=fingerslide_walls,
          fingerslide_lip_aligned=fingerslide_lip_aligned,
          wall_thickness=wall_thickness+sliding_clearance,
          chamber_wall_thickness=chamber_wall_thickness,
          chamber_wall_headroom=chamber_wall_headroom,
          calculated_vertical_separator_positions = calculated_vertical_separator_positions,
          calculated_horizontal_separator_positions = calculated_horizontal_separator_positions,
          lip_settings=lip_settings,
          headroom=headroom,
          sliding_lid_settings= slidingLidSettings,
          divider_wall_removable_settings = divider_wall_removable_settings);
      }

      label_size = calculateLabelSize(label_settings[iLabelSettings_size]);
      labelCornerRadius = label_size[3];
      lipHeight = 3.75;
      
      tz(-lipHeight - labelCornerRadius)
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
        lip_non_blocking = lip_settings[iLipNonBlocking],
        lip_as_void=true,
        sliding_clearance=sliding_clearance
      );
    }
  }
  
  
  HelpTxt("gridfinity_removable_label",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"filled_in",filled_in
    ,"label_settings",label_settings
    ,"fingerslide",fingerslide
    ,"fingerslide_radius",fingerslide_radius
    ,"fingerslide_walls",fingerslide_walls
    ,"fingerslide_lip_aligned",fingerslide_lip_aligned
    ,"cupBase_settings",cupBase_settings
    ,"wall_thickness",wall_thickness
    ,"chamber_wall_thickness",chamber_wall_thickness
    ,"vertical_separator_bend_position",vertical_separator_bend_position
    ,"vertical_separator_bend_angle",vertical_separator_bend_angle
    ,"vertical_separator_bend_separation",vertical_separator_bend_separation
    ,"vertical_separator_positions",calculated_vertical_separator_positions
    ,"vertical_separator_cut_depth",vertical_separator_cut_depth
    ,"horizontal_separator_bend_position",horizontal_separator_bend_position
    ,"horizontal_separator_bend_angle",horizontal_separator_bend_angle
    ,"horizontal_separator_bend_separation",horizontal_separator_bend_separation
    ,"horizontal_separator_positions",calculated_horizontal_separator_positions
    ,"horizontal_separator_cut_depth",horizontal_separator_cut_depth
    ,"lip_settings",lip_settings
    ,"headroom",headroom
    ,"tapered_corner",tapered_corner
    ,"tapered_corner_size",tapered_corner_size
    ,"tapered_setback",tapered_setback
    ,"wallpattern_walls",wallpattern_walls
    ,"wall_pattern_settings",wall_pattern_settings
    ,"floor_pattern_settings",floor_pattern_settings
    ,"wallcutout_vertical",[
        wallcutout_vertical, 
        wallcutout_vertical_position,
        wallcutout_vertical_width,
        wallcutout_vertical_angle,
        wallcutout_vertical_height,
        wallcutout_vertical_corner_radius]
    ,"wallcutout_horizontal",[
        wallcutout_horizontal, 
        wallcutout_horizontal_position,
        wallcutout_horizontal_width,
        wallcutout_horizontal_angle,
        wallcutout_horizontal_height,
        wallcutout_horizontal_corner_radius]
    ,"extendable_Settings",extendable_Settings
    ]
    ,env_help_enabled("info"));  
}



module partitioned_cavity(num_x, num_y, num_z,
    label_settings=[],
    cupBase_settings=[],
    fingerslide=default_fingerslide,  fingerslide_radius=default_fingerslide_radius,
    fingerslide_walls=default_fingerslide_walls,
    fingerslide_lip_aligned=fingerslide_lip_aligned,
    wall_thickness=default_wall_thickness,
    chamber_wall_thickness=default_chamber_wall_thickness, chamber_wall_headroom=default_chamber_wall_headroom,
    calculated_vertical_separator_positions=calculated_vertical_separator_positions,
    calculated_horizontal_separator_positions=calculated_horizontal_separator_positions,
    lip_settings=[],
    headroom=default_headroom,
    sliding_lid_settings=[],
    divider_wall_removable_settings=[]) {
  
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
    flat_base=cupBase_settings[iCupBase_FlatBase]);
    
  difference() {
    color(env_colour(color_cupcavity))
    union(){
    basic_cavity(num_x, num_y, num_z,
      fingerslide=fingerslide, fingerslide_walls=fingerslide_walls, fingerslide_lip_aligned=fingerslide_lip_aligned, fingerslide_radius=fingerslide_radius,
      cupBase_settings=cupBase_settings,
      wall_thickness=wall_thickness,
      lip_settings=lip_settings,
      sliding_lid_settings=sliding_lid_settings,
      divider_wall_removable_settings=divider_wall_removable_settings,
      headroom=headroom);
    }
    
    if(env_help_enabled("trace")) echo("partitioned_cavity", vertical_separator_positions=calculated_vertical_separator_positions);

    sepFloorHeight = (efficient_floor != "off" ? floor_thickness : floorHeight);
    
    color(env_colour(color_divider))
    tz(sepFloorHeight-fudgeFactor)
    separators(
      calculatedSeparators = calculated_vertical_separator_positions,
      separator_orientation = "vertical");

    if(env_help_enabled("trace")) echo("partitioned_cavity", horizontal_separator_positions=calculated_horizontal_separator_positions);
    
    color(env_colour(color_divider))
    translate([env_pitch().x*num_x, 0, sepFloorHeight-fudgeFactor])
    separators(
      calculatedSeparators = calculated_horizontal_separator_positions,
      separator_orientation = "horizontal");
    
  }
}

module basic_cavity(num_x, num_y, num_z,
    fingerslide=default_fingerslide, fingerslide_radius=default_fingerslide_radius,fingerslide_walls,fingerslide_lip_aligned=default_fingerslide_lip_aligned,
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
  
  seventeen = [env_pitch().x/2-4,env_pitch().y/2-4];
  
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
      flat_base=cupBase_settings[iCupBase_FlatBase]));
    
  //Remove floor to create a vertical spacer.
  nofloor = spacer && fingerslide == "none";
  
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
  innerLipRadius = gf_cup_corner_radius-gf_lip_lower_taper_height-gf_lip_upper_taper_height; //1.15
  innerWallRadius = gf_cup_corner_radius-wall_thickness;
  

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
          hull() cornercopy(seventeen, num_x, num_y)
            tz(floorht)
            cylinder(r=innerLipRadius, h=filledInZ-floorht+fudgeFactor*4); // lip
        } else {
          hull() cornercopy(seventeen, num_x, num_y)
            tz(filledInZ-gf_lip_height-fudgeFactor)
            cylinder(r=innerLipRadius, h=gf_lip_height+fudgeFactor*4); // lip
    
          hull() cornercopy(seventeen, num_x, num_y)
            tz(filledInZ-gf_lip_height-lipSupportThickness-fudgeFactor)
            cylinder(
              r1=innerWallRadius,
              r2=innerLipRadius, h=q+fudgeFactor);   // ... to top of thin wall ...
        }
      }
    
      //Cavity below lip
      if(cavityHeight > 0)
       hull() cornercopy(seventeen, num_x, num_y)
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
    if(fingerslide != "none"){
      FingerSlide(
        num_x = num_x,
        num_y = num_y,
        num_z = num_z,
        fingerslide_walls=fingerslide_walls,
        lipAligned=fingerslide_lip_aligned,
        fingerslide=fingerslide,
        fingerslide_radius=fingerslide_radius,
        reducedlipstyle=reducedlipstyle,
        wall_thickness=wall_thickness,
        floorht=floorht,
        seventeen=seventeen);
    }
  
    if(divider_wall_removable_settings[iDividerRemovable_Enabled])
      removable_dividers_support(
          num_x = num_x,
          num_y = num_y,
          zpoint = zpoint,
          divider_settings = divider_wall_removable_settings,
          wall_thickness=wall_thickness,
          floorHeight=floorht);

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
            margins=q);
           
           //Screw and magnet covers required for efficient floor
           if(hasCornerAttachments)
             gridcopycorners(num_x, num_y, magnetPosition, box_corner_attachments_only)
                EfficientFloorAttachmentCaps(
                  grid_copy_corner_index = $gcci,
                  floor_thickness = floor_thickness,
                  magnet_size = cupBase_settings[iCupBase_MagnetSize],
                  screw_size = cupBase_settings[iCupBase_ScrewSize],
                  wall_thickness = magnet_easy_release == MagnetEasyRelease_inner ? wall_thickness*2 : wall_thickness );
          }
        }
      }
    }  // difference removals from main body.

    if(divider_wall_removable_settings[iDividerRemovable_Enabled])
      removable_dividers_slots(
        num_x = num_x,
        num_y = num_y,
        zpoint = zpoint,
        divider_settings = divider_wall_removable_settings,
        wall_thickness=wall_thickness,
        floorHeight=floorht);
    
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
      for (y=[11, (num_y)*env_pitch().y-seventeen.y])
      translate([x, y, top-height])
      cylinder(d=3, h=height);
    }
  }

  if (roundtoDecimal(num_y,2) < lip_settings[iLipSideReliefTrigger].y) {
    top = num_z*env_pitch().z+gf_Lip_Height;
    height = top-lipBottomZ+fudgeFactor*2;
    
    hull()
    for (y=[1.5+0.25+wall_thickness, num_y*env_pitch().y-1.5-0.25-wall_thickness]){
      for (x=[11, (num_x)*env_pitch().x-seventeen.x])
      translate([x, y, top-height])
      cylinder(d=3, h=height);
    }
  }
  
  if (nofloor) {
    tz(-fudgeFactor)
      hull()
      cornercopy(num_x=num_x, num_y=num_y, r=seventeen)
      cylinder(r=2, h=gf_cupbase_lower_taper_height+fudgeFactor);
    gridcopy(1, 1)
      EfficientFloor(num_x, num_y,-fudgeFactor, q);
  }
}

///Creates the finger slide that will be subtracted from the cavity
module FingerSlide(
        num_x = num_x,
        num_y = num_y,
        num_z = num_z,
        fingerslide_walls=fingerslide_walls,
        fingerslide=fingerslide,
        fingerslide_radius=fingerslide_radius,
        reducedlipstyle=reducedlipstyle,
        wall_thickness=wall_thickness,
        floorht=floorht,
        lipAligned = true,
        seventeen=seventeen) {
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(num_z), "num_z must be a number");
  assert(is_list(fingerslide_walls), "fingerslide_walls must be a list");
  assert(is_string(fingerslide), "fingerslide must be a string");
  assert(is_num(fingerslide_radius), "fingerslide_radius must be a number");
  assert(is_string(reducedlipstyle), "reducedlipstyle must be a string");
  assert(is_num(wall_thickness), "wall_thickness must be a number");
  assert(is_num(floorht), "floorht must be a number");
  assert(is_bool(lipAligned), "lipAligned must be a bool");
  assert(is_list(seventeen), "seventeen must be a number");
  
  echo("fingerslide", fingerslide_walls=fingerslide_walls, fingerslide=fingerslide);
  front = [
    //width
    num_x*env_pitch().x,
    //Position
    [0, 0, 0],
    //rotation
    [0,0,0],
    //cup width for finger slide (opposide dimention)
    num_y*env_pitch().y,
    //cup height
    num_z*env_pitch().z];
  back = [
    //width
    num_x*env_pitch().x,
    //Position
    [num_x*env_pitch().x, num_y*env_pitch().y, 0],
    //rotation
    [0,0,180],
    //cup width for finger slide (opposide dimention)
    num_y*env_pitch().y,
    //cup height
    num_z*env_pitch().z];
  left = [
    //width
    num_y*env_pitch().y,
    //Position
    [0, num_y*env_pitch().y, 0],
    //rotation
    [0,0,270],
    //cup width for finger slide (opposide dimention)
    num_x*env_pitch().x,
    //cup height
    num_z*env_pitch().z];
  right = [
    //width
    num_y*env_pitch().y,
    //Position
    [num_x*env_pitch().x, 0, 0],
    //rotation
    [0,0,90],
    //cup width for finger slide (opposide dimention)
    num_x*env_pitch().x,
    //cup height
    num_z*env_pitch().z];
    
  locations = [front, back, left, right];
  function get_fingerslide_radius(wall, cup_size, cup_height, fingerslide_radius) =
  let(radius_start = wall == 1 ? fingerslide_radius : wall,
      calculated_radius = radius_start < 0 ? cup_size/abs(radius_start) : radius_start,
      limited_radius = min(calculated_radius,cup_height,cup_size/2))
    echo("get_fingerslide_radius", is_ratio=(wall < 0),result=limited_radius, wall=wall, cup_size=cup_size, cup_height=cup_height, fingerslide_radius=fingerslide_radius)
    limited_radius;
    
  for(i = [0:1:len(locations)-1])
    union()
      if(fingerslide_walls[i] != 0)
        //patterns in the outer walls
        translate(locations[i][1])
        rotate(locations[i][2])
      translate([0,
        lipAligned && reducedlipstyle =="normal" ? -seventeen.x-1.15+env_pitch().x/2
        : lipAligned && reducedlipstyle == "reduced" ? -seventeen.x-1.15+env_pitch().x/2-gf_lip_lower_taper_height
        : lipAligned && reducedlipstyle == "reduced_double" ? -seventeen.x-1.15+env_pitch().x/2-gf_lip_lower_taper_height
        : 0.25+wall_thickness, floorht]) //todo:pitch issue here?
    //translate([0,-seventeen-1.15+env_pitch().x/2, floorht])
      union(){
        if(fingerslide == "rounded"){
          roundedCorner(
            radius = get_fingerslide_radius(fingerslide_walls[i], locations[i][3], locations[i][4], fingerslide_radius),
            length=locations[i][0],
            height = env_pitch().z*num_z-floorht+fudgeFactor);
        }
        else if(fingerslide == "chamfered"){
          chamferedCorner(
            chamferLength = get_fingerslide_radius(fingerslide_walls[i], locations[i][3], locations[i][4], fingerslide_radius),
            length=locations[i][0],
            height = env_pitch().z*num_z-floorht+fudgeFactor);
      }
    }
}
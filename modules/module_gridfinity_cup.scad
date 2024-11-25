include <gridfinity_constants.scad>
include <module_gridfinity_label.scad>
include <functions_general.scad>
include <module_voronoi.scad>
include <module_gridfinity_sliding_lid.scad>
include <module_gridfinity_Extendable.scad>
include <module_divider_walls.scad>

use <module_gridfinity.scad>
use <module_item_holder.scad>
include <module_gridfinity_cup_base_text.scad>
include <module_gridfinity_cup_base.scad>
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
// Might want to remove inner lip of cup
default_lip_style = "normal"; //[normal, reduced, minimum, none]
//assign colours to the bin, will may 
default_set_colour = "preview"; //[disabled, preview, lip]

// Thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
default_wall_thickness = 0;// 0.01

// Set magnet diameter and depth to 0 to print without magnet holes
// (Zack's design uses magnet diameter of 6.5)
//under size the bin top by this amount to allow for better stacking
default_zClearance = 0; // 0.1

/* [Label] */
// Include overhang for labeling
default_label_style = "normal"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
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

/* [Subdivisions] */
// X dimension subdivisions
default_chamber_wall_thickness = 1.2;//0.1
//Reduce the wall height by this amount
default_chamber_wall_zClearance = 0;//0.1
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
default_wallpattern_style = "gridrotated"; //[grid, gridrotated, hexgrid, hexgridrotated, voronoi, voronoigrid, voronoihexgrid]
default_wallpattern_dividers_enabled ="disabled"; //["disabled", "horizontal", "vertical", "both"] 
default_wallpattern_fill = "none"; //["none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"]
default_wallpattern_walls=[1,0,0,0];  //[0:1:1]
default_wallpattern_hole_sides = 6;
default_wallpattern_hole_size = 10; //0.1
default_wallpattern_hole_spacing = 2; //0.1
default_wallpattern_voronoi_noise = 0.75;
default_wallpattern_voronoi_radius = 0.5;

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
[debug] 
default_cutx = 0;//0.01
default_cuty = 0;//0.01
default_help = "info"; //["off","info","debug","trace"]

SetGridfinityEnvironment(//execution point
  setColour = default_set_colour,//execution point
  help = default_help,//execution point
  cutx=default_cutx,//execution point
  cuty=default_cuty)//execution point
gridfinity_cup();//execution point
*/

// It's recommended that all parameters other than x, y, z size should be specified by keyword 
// and not by position.  The number of parameters makes positional parameters error prone, and
// additional parameters may be added over time and break things.
// separator positions are defined in units from the left side
module gridfinity_cup(
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
  chamber_wall_zClearance=default_chamber_wall_zClearance,
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
  lip_style=default_lip_style,
  zClearance=default_zClearance,
  tapered_corner = default_tapered_corner,
  tapered_corner_size = default_tapered_corner_size,
  tapered_setback = default_tapered_setback,
  wallpattern_enabled=default_wallpattern_enabled,
  wallpattern_style=default_wallpattern_style,
  wallpattern_fill=default_wallpattern_fill,
  wallpattern_walls=default_wallpattern_walls, 
  wallpattern_dividers_enabled = default_wallpattern_dividers_enabled,
  wallpattern_hole_sides=default_wallpattern_hole_sides,
  wallpattern_hole_size=default_wallpattern_hole_size,
  wallpattern_hole_spacing=default_wallpattern_hole_spacing,
  wallpattern_voronoi_noise=default_wallpattern_voronoi_noise,
  wallpattern_voronoi_radius = default_wallpattern_voronoi_radius,
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
    baseTextDepth = default_text_depth), 
) {
  
  num_x = calcDimensionWidth(width, true);
  num_y = calcDimensionDepth(depth, true);
  num_z = calcDimensionHeight(height, true);

  filled_in = validateFilledIn(filled_in);
  label_settings=ValidateLabelSettings(label_settings);
  extendable_Settings = ValidateExtendableSettings(extendable_Settings, num_x=num_x, num_y=num_y);
  cupBase_settings = ValidateCupBaseSettings(cupBase_settings);
  
  filledInZ = gf_zpitch*num_z;
  zpoint = filledInZ-zClearance;
  efficient_floor = cupBase_settings[iCupBase_EfficientFloor];
  floor_thickness = cupBase_settings[iCupBase_FloorThickness];
  floorHeight = calculateFloorHeight(
    cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
    cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
    cupBase_settings[iCupBase_FloorThickness]);
  sepFloorHeight = (efficient_floor != "off" ? floor_thickness : floorHeight);
       
  calculated_vertical_separator_positions = calculateSeparators(
    separator_config = vertical_irregular_subdivisions 
      ? vertical_separator_config 
      : splitChamber(vertical_chambers-1, num_x), 
    length = gf_pitch*num_y,
    height = gf_zpitch*(num_z)-sepFloorHeight+fudgeFactor*2-max(zClearance, chamber_wall_zClearance),
    wall_thickness = chamber_wall_thickness,
    bend_position = vertical_separator_bend_position,
    bend_angle = vertical_separator_bend_angle,
    bend_separation = vertical_separator_bend_separation,
    cut_depth = vertical_separator_cut_depth);
  calculated_horizontal_separator_positions = calculateSeparators(
    separator_config = horizontal_irregular_subdivisions 
      ? horizontal_separator_config 
      : splitChamber(horizontal_chambers-1, num_y), 
    length = gf_pitch*num_x,
    height = gf_zpitch*(num_z)-sepFloorHeight+fudgeFactor*2-max(zClearance, chamber_wall_zClearance),
    wall_thickness = chamber_wall_thickness,
    bend_position = horizontal_separator_bend_position,
    bend_angle = horizontal_separator_bend_angle,
    bend_separation = horizontal_separator_bend_separation,
    cut_depth = horizontal_separator_cut_depth);

  $gfc=[["num_x",num_x],["num_y",num_y],["num_z",num_z],["calculated_vertical_separator_positions",calculated_vertical_separator_positions],["calculated_horizontal_separator_positions",calculated_horizontal_separator_positions]];
     
  //Correct legacy values, values that used to work one way but were then changed.
  wallpattern_dividers_enabled = is_bool(wallpattern_dividers_enabled)
    ? wallpattern_dividers_enabled ? "vertical" : "disabled"
    : wallpattern_dividers_enabled;
  
  //wall_thickness default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
  wall_thickness = wallThickness(wall_thickness, num_z);
  
  slidingLidSettings= SlidingLidSettings(
          sliding_lid_enabled, 
          sliding_lid_thickness, 
          sliding_min_wall_thickness, 
          sliding_min_support,
          sliding_clearance,
          wall_thickness,
          sliding_lid_lip_enabled);
          
  zClearance = zClearance + (sliding_lid_enabled ? slidingLidSettings[iSlidingLidThickness] : 0);

  union(){
    difference() {
      grid_block(
        num_x, num_y, num_z,
        cupBase_settings = cupBase_settings,
        wall_thickness = wall_thickness,
        lipStyle = lip_style,
        filledin = filled_in);
  
      if(filled_in == FilledIn_disabled) 
      union(){
        partitioned_cavity(
          num_x, num_y, num_z,
          label_settings=label_settings,
          cupBase_settings = cupBase_settings,
          fingerslide=fingerslide,
          fingerslide_radius=fingerslide_radius,
          fingerslide_walls=fingerslide_walls,
          wall_thickness=wall_thickness,
          chamber_wall_thickness=chamber_wall_thickness,
          chamber_wall_zClearance=chamber_wall_zClearance,
          calculated_vertical_separator_positions = calculated_vertical_separator_positions,
          calculated_horizontal_separator_positions = calculated_horizontal_separator_positions,
          lip_style=lip_style, 
          zClearance=zClearance,
          sliding_lid_settings= slidingLidSettings);
      
      color(getColour(color_wallcutout))
        union(){

          cavityFloorRadius = calculateCavityFloorRadius(cupBase_settings[iCupBase_CavityFloorRadius], wall_thickness, cupBase_settings[iCupBase_EfficientFloor]);
          wallTop = calculateWallTop(num_z, lip_style);
          cutoutclearance = gf_cup_corner_radius/2;

          tapered_setback = tapered_setback < 0 ? gf_cup_corner_radius : tapered_setback;
          tapered_corner_size =
                tapered_corner_size == -2 ? (wallTop - floorHeight)/2
              : tapered_corner_size < 0 ? wallTop - floorHeight //meant for -1, but also catch others
              : tapered_corner_size == 0 ? wallTop - floorHeight - cavityFloorRadius
              : tapered_corner_size;
              
              
        wallcutouts_vertical = calculateWallCutout(
          wall_length = num_x,
          opposite_wall_distance = num_y,
          wallcutout_type = wallcutout_vertical,
          wallcutout_position = wallcutout_vertical_position,
          wallcutout_width = wallcutout_vertical_width,
          wallcutout_angle = wallcutout_vertical_angle,
          wallcutout_height = wallcutout_vertical_height,
          wallcutout_corner_radius = wallcutout_vertical_corner_radius,
          wallcutout_rotation = [0,0,0],
          walcutout_reposition = [0,0,0],
          wall_thickness = wall_thickness,
          cavityFloorRadius = cavityFloorRadius,
          wallTop = wallTop,
          floorHeight = floorHeight);
        wallcutouts_horizontal = calculateWallCutout(
          wall_length = num_y,
          opposite_wall_distance = num_x,
          wallcutout_type = wallcutout_horizontal,
          wallcutout_position = wallcutout_horizontal_position,
          wallcutout_width = wallcutout_horizontal_width,
          wallcutout_angle = wallcutout_horizontal_angle,
          wallcutout_height = wallcutout_horizontal_height,
          wallcutout_corner_radius = wallcutout_horizontal_corner_radius,
          wallcutout_rotation = [0,0,90],
          walcutout_reposition = [num_x*gf_pitch,0,0],
          wall_thickness = wall_thickness,
          cavityFloorRadius = cavityFloorRadius,
          wallTop = wallTop,
          floorHeight = floorHeight);
          
          wallcutout_locations = [wallcutouts_vertical[0], wallcutouts_vertical[1], wallcutouts_horizontal[0], wallcutouts_horizontal[1]];
          if(tapered_corner == "rounded" || tapered_corner == "chamfered"){
            //tapered_corner_size = tapered_corner_size == 0 ? gf_zpitch*num_z/2 : tapered_corner_size;
            translate([0,tapered_setback+gf_tolerance,gf_zpitch*num_z+gf_Lip_Height-gf_tolerance])
            rotate([270,0,0])
            union(){
              if(tapered_corner == "rounded"){
                roundedCorner(
                  radius = tapered_corner_size,
                  length=(num_x+1)*gf_pitch,
                  height = tapered_corner_size);
              }
              else if(tapered_corner == "chamfered"){
                chamferedCorner(
                  chamferLength = tapered_corner_size,
                  length=(num_x+1)*gf_pitch,
                  height = tapered_corner_size);
              }
            }
          }
         
          if(wallcutout_vertical != "disabled" || wallcutout_horizontal !="disabled" )
            for(wallcutout_location = wallcutout_locations)
              if(wallcutout_location[iwalcutout_enabled] == true)
                translate(wallcutout_location[iwalcutout_reposition])
                rotate(wallcutout_location[iwalcutout_rotation])
                translate(wallcutout_location[iwalcutout_position])
                WallCutout(
                  lowerWidth=wallcutout_location[iwalcutout_size].x,
                  wallAngle=wallcutout_location[iwalcutout_config][iwalcutoutconfig_angle],
                  height=wallcutout_location[iwalcutout_size].z,
                  thickness=wallcutout_location[iwalcutout_size].y,
                  cornerRadius=wallcutout_location[iwalcutout_config][iwalcutoutconfig_cornerradius]);
          
          if(wallpattern_enabled){
            wallpattern_thickness = wall_thickness*2;
            border = wall_thickness;
            wallpatternzpos = floorHeight+max(cavityFloorRadius,border);
            
            //I feel this should use wallTop, but it seems to work...
            heightz = gf_zpitch*(num_z)-wallpatternzpos + (
              //Position specific to each LIP style
              lip_style == "reduced" ? 0.6 :
              lip_style == "minimum" ? 3 -border*2 
               : -gf_lip_height-1.8);
            z=wallpatternzpos+heightz/2;
            
            labelSize = calculateLabelSize(label_settings[iLabelSettings_size]);
            //Subtracting the wallpattern_thickness is a bit of a hack, its needed as the label extends in to the wall.
            labelSizez = (label_settings[iLabelSettings_style] != LabelStyle_disabled ? labelSize.z-wallpattern_thickness : 0);
            
            front = [
              //width,height
              [num_x*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,
                heightz - (label_settings[iLabelSettings_walls][0] != 0 ? labelSizez : 0)],
              //Position
              [(num_x)*gf_pitch/2, 
                wallpattern_thickness, 
                z - (label_settings[iLabelSettings_walls][0] != 0 ? labelSizez : 0)/2],
              //rotation
              [90,0,0]];
            back = [
              //width,height
              [num_x*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,
                heightz - (label_settings[iLabelSettings_walls][1] != 0 ? labelSizez : 0)],
              //Position
              [(num_x)*gf_pitch/2, 
                (num_y)*gf_pitch, 
                 z - (label_settings[iLabelSettings_walls][1] != 0 ? labelSizez : 0)/2],
              [90,0,0]];
            left = [
              //width,height
              [num_y*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,
                heightz - (label_settings[iLabelSettings_walls][2] != 0 ? labelSizez : 0)],
              //Position
              [0, 
                (num_y)*gf_pitch/2, 
                z - (label_settings[iLabelSettings_walls][2] != 0 ? labelSizez : 0)/2],
              [90,0,90]];
            right = [
              //width,height
              [num_y*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,
                heightz - (label_settings[iLabelSettings_walls][3] != 0 ? labelSizez : 0)],
              //Position
              [(num_x)*gf_pitch-wallpattern_thickness,   
                (num_y)*gf_pitch/2, 
                z - (label_settings[iLabelSettings_walls][3] != 0 ? labelSizez : 0)/2],
              [90,0,90]];
          
          locations = [front, back, left, right];
            
          //["disabled", "horizontal", "vertical", "both"] 
          if(wallpattern_dividers_enabled != "disabled"){
            difference(){
              union(){
                if(wallpattern_dividers_enabled == "vertical" || wallpattern_dividers_enabled == "both")
                  position_separators(
                    calculatedSeparators = calculated_vertical_separator_positions, 
                    separator_orientation = "vertical") {
                        thickness = $sepCfg[iSeparatorWallThickness]+$sepCfg[iSeparatorBendSeparation]+fudgeFactor*2;
                        translate([-thickness/2, 0, fudgeFactor]) 
                        translate(left[1])
                        rotate(left[2])
                        render() //Render on vertical_separator pattern because detailed patters can be slow
                        difference(){
                          //separator wall pattern
                          cutout_pattern(
                            patternStyle = wallpattern_style,
                            canvasSize = left[0], 
                            customShape = false,
                            circleFn = wallpattern_hole_sides,
                            holeSize = [wallpattern_hole_size, wallpattern_hole_size],
                            holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
                            holeHeight = thickness,
                            center=true,
                            fill=wallpattern_fill, //"none", "space", "crop"
                            voronoiNoise=wallpattern_voronoi_noise,
                            voronoiRadius = wallpattern_voronoi_radius,
                            help=help);
                 
                          
                          //subtract outer wall to outer wall cutout from separator pattern
                          wallcutoutFront = wallcutouts_horizontal[0];
                          wallcutoutFrontThickness = $sepCfg[iSeparatorWallThickness]+$sepCfg[iSeparatorBendSeparation];
                          if(wallcutoutFront[iwalcutout_enabled] == true && wallcutoutFront[0][iwalcutoutconfig_type] == "enabled" )
                            translate([0,wallcutoutFront[iwalcutout_size].z/2,wallcutoutFrontThickness/2])
                            rotate([270,0,0])
                            WallCutout(
                              lowerWidth=wallcutoutFront[iwalcutout_size].x+cutoutclearance,
                              wallAngle=wallcutoutFront[iwalcutout_config][iwalcutoutconfig_angle],
                              height=wallcutoutFront[iwalcutout_size].z+cutoutclearance,
                              thickness=wallcutoutFrontThickness,
                              cornerRadius=wallcutoutFront[iwalcutout_config][iwalcutoutconfig_cornerradius]);
                        }
                      }
          
                if(wallpattern_dividers_enabled == "horizontal" || wallpattern_dividers_enabled == "both")
                  position_separators(
                    calculatedSeparators = calculated_horizontal_separator_positions, 
                    separator_orientation = "horizontal") {
                      thickness = $sepCfg[iSeparatorWallThickness]+$sepCfg[iSeparatorBendSeparation]+fudgeFactor*2;
                      rotate([0,0,-90])
                      //I dont know why -wallpattern_thickness is needed here and not in vertical
                      translate([0,-wallpattern_thickness+thickness/2, fudgeFactor]) 
                      translate(front[1])
                      rotate(front[2])
                      render() //Render on horizontal_separator pattern because detailed patters can be slow
                      difference(){
                      //separator wall pattern
                        cutout_pattern(
                          patternStyle = wallpattern_style,
                          canvasSize = front[0], 
                          customShape = false,
                          circleFn = wallpattern_hole_sides,
                          holeSize = [wallpattern_hole_size, wallpattern_hole_size],
                          holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
                          holeHeight = thickness,
                          center=true,
                          fill=wallpattern_fill, //"none", "space", "crop"
                          voronoiNoise=wallpattern_voronoi_noise,
                          voronoiRadius = wallpattern_voronoi_radius,
                          help=help);
              
                          //subtract outer wall to outer wall cutout from separator pattern
                          wallcutoutLeft = wallcutouts_vertical[0];
                          wallcutoutLeftThickness = $sepCfg[iSeparatorWallThickness]+$sepCfg[iSeparatorBendSeparation];
                          if(wallcutoutLeft[iwalcutout_enabled] == true && wallcutoutLeft[0][iwalcutoutconfig_type] == "enabled" )
                            translate([0,wallcutoutLeft[iwalcutout_size].z/2,wallcutoutLeftThickness/2])
                            rotate([270,0,0])
                            WallCutout(
                              lowerWidth=wallcutoutLeft[iwalcutout_size].x+cutoutclearance,
                              wallAngle=wallcutoutLeft[iwalcutout_config][iwalcutoutconfig_angle],
                              height=wallcutoutLeft[iwalcutout_size].z+cutoutclearance,
                              thickness=wallcutoutLeftThickness,
                              cornerRadius=wallcutoutLeft[iwalcutout_config][iwalcutoutconfig_cornerradius]);
                      }
                    }
                }
                
                //Subtract setback from wall pattern
                if(tapered_corner == "rounded" || tapered_corner == "chamfered")
                  //tapered_corner_size = tapered_corner_size == 0 ? gf_zpitch*num_z/2 : tapered_corner_size;
                  translate([
                    -cutoutclearance,
                    +tapered_setback+gf_tolerance+cutoutclearance,
                    gf_zpitch*num_z+gf_Lip_Height-gf_tolerance-cutoutclearance])
                  rotate([270,0,0])
                  union()
                    if(tapered_corner == "rounded"){
                      roundedCorner(
                        radius = tapered_corner_size-cutoutclearance,
                        length=(num_x+1)*gf_pitch,
                        height = tapered_corner_size);
                    }
                    else if(tapered_corner == "chamfered"){
                      chamferedCorner(
                        chamferLength = tapered_corner_size-cutoutclearance,
                        length=(num_x+1)*gf_pitch,
                        height = tapered_corner_size);
                    }
                    
              }
            }

            //Wall pattern in outerwalls
            difference(){
              union()
                for(i = [0:1:len(locations)-1])
                  if(wallpattern_walls[i] > 0)
                    //patterns in the outer walls
                    translate(locations[i][1])
                    rotate(locations[i][2])
                    render() //Render on outer wall pattern because detailed patters can be slow
                      cutout_pattern(
                        patternStyle = wallpattern_style,
                        canvasSize = locations[i][0],
                        customShape = false,
                        circleFn = wallpattern_hole_sides,
                        holeSize = [wallpattern_hole_size, wallpattern_hole_size],
                        holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
                        holeHeight = wallpattern_thickness,
                        center=true,
                        fill=wallpattern_fill, //"none", "space", "crop"
                        voronoiNoise=wallpattern_voronoi_noise,
                        voronoiRadius = wallpattern_voronoi_radius,
                        help=help);
              
              //subtract dividers from outer wall pattern
              translate([0, 0, sepFloorHeight-fudgeFactor])
              separators(
                calculatedSeparators = calculated_vertical_separator_positions,
                separator_orientation = "vertical",
                override_wall_thickness = chamber_wall_thickness+cutoutclearance*2);
              
              //subtract dividers from outer wall pattern
              translate([gf_pitch*num_x, 0, sepFloorHeight-fudgeFactor])
              separators(
                calculatedSeparators = calculated_horizontal_separator_positions,
                separator_orientation = "horizontal",
                override_wall_thickness = chamber_wall_thickness+cutoutclearance*2);
              
              //Subtract cutout from wall pattern
              if(wallcutout_vertical != "disabled" || wallcutout_horizontal !="disabled" )
                for(wallcutout_location = wallcutout_locations)
                  if(wallcutout_location[iwalcutout_enabled] == true)
                    translate(wallcutout_location[iwalcutout_reposition])
                    rotate(wallcutout_location[iwalcutout_rotation])
                    translate(wallcutout_location[iwalcutout_position])
                    WallCutout(
                      lowerWidth=wallcutout_location[iwalcutout_size].x+cutoutclearance*2,
                      wallAngle=wallcutout_location[iwalcutout_config][iwalcutoutconfig_angle],
                      height=wallcutout_location[iwalcutout_size].z+cutoutclearance,
                      thickness=wallcutout_location[iwalcutout_size].y,
                      cornerRadius=wallcutout_location[iwalcutout_config][iwalcutoutconfig_cornerradius]);
        
              //Subtract setback from wall pattern
              if(tapered_corner == "rounded" || tapered_corner == "chamfered")
                translate([
                  -cutoutclearance,
                  +tapered_setback+gf_tolerance+cutoutclearance,
                  gf_zpitch*num_z+gf_Lip_Height-gf_tolerance-cutoutclearance])
                rotate([270,0,0])
                union()
                  if(tapered_corner == "rounded"){
                    roundedCorner(
                      radius = tapered_corner_size-cutoutclearance, 
                      length=(num_x+1)*gf_pitch, 
                      height = tapered_corner_size);
                  }
                  else if(tapered_corner == "chamfered"){
                    chamferedCorner(
                      chamferLength = tapered_corner_size-cutoutclearance, 
                      length=(num_x+1)*gf_pitch, 
                      height = tapered_corner_size);
                  }
            }
          }
        }
      }
      
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
    _magnet_position = calculateMagnetPosition(cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Diameter]);
    cup_base_text(
      cupBaseTextSettings = cupBaseTextSettings, 
      wall_thickness = wall_thickness,
      magnet_position = _magnet_position);
  
      if(extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_disabled)
        color(getColour(color_wallcutout))
        if(extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_front)
        tz(-fudgeFactor)
          cube([unitPositionTo_mm(extendable_Settings.x[1],num_x),num_y*gf_pitch,(num_z+1)*gf_zpitch]);
        else
          translate([unitPositionTo_mm(extendable_Settings.x[1],num_x),0,-fudgeFactor])
            cube([num_x*gf_pitch-unitPositionTo_mm(extendable_Settings.x[1],num_x),num_y*gf_pitch,(num_z+1)*gf_zpitch]);
      
      if(extendable_Settings.y[0]!=BinExtensionEnabled_disabled)
        color(getColour(color_wallcutout))
        if(extendable_Settings.y[0]==BinExtensionEnabled_front)
          tz(-fudgeFactor)
          cube([gf_pitch*num_x,unitPositionTo_mm(extendable_Settings.y[1],num_y),(num_z+1)*gf_zpitch]);
        else
          translate([0,unitPositionTo_mm(extendable_Settings.y[1],num_y),-fudgeFactor])
          cube([gf_pitch*num_x,num_y*gf_pitch-unitPositionTo_mm(extendable_Settings.y[1],num_y),(num_z+1)*gf_zpitch]);
    }
    
    if((extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_disabled || extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_disabled) && extendable_Settings[iExtendableTabsEnabled]) {
      refTabHeight = extendable_Settings[iExtendableTabSize].x;
      tabThickness = extendable_Settings[iExtendableTabSize].z == 0 ? 1.4 : extendable_Settings[iExtendableTabSize].z;//1.4; //This should be calculated
      tabWidth = extendable_Settings[iExtendableTabSize].y;
      tabStyle = extendable_Settings[iExtendableTabSize][iExtendableTabSizeStyle];
      
      floorHeight = calculateFloorHeight(
        cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
        cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
        floor_thickness) + calculateCavityFloorRadius(cupBase_settings[iCupBase_CavityFloorRadius], wall_thickness,efficient_floor)-tabThickness;
      
      //todo need to correct this
      lipheight = lip_style == "none" ? tabThickness
        : lip_style == "reduced" ? gf_lip_upper_taper_height+tabThickness
        //Add tabThickness, as the taper can bleed in to the lip
        : gf_lip_upper_taper_height + gf_lip_lower_taper_height-tabThickness;
      ceilingHeight = gf_zpitch*num_z-zClearance-lipheight;
    
      //tabWorkingheight = (num_z-1)*gf_zpitch-gf_Lip_Height;
      tabWorkingheight = ceilingHeight-floorHeight;
    
      tabsCount = max(floor(tabWorkingheight/refTabHeight),1);
      tabHeight = tabWorkingheight/tabsCount;
      if(IsHelpEnabled("debug")) echo("tabs", binHeight =num_z, tabHeight=tabHeight, floorHeight=floorHeight, cavity_floor_radius=cupBase_settings[iCupBase_CavityFloorRadius], tabThickness=tabThickness);
      cutx = extendable_Settings.x[iExtendablePositionmm];
      cuty = extendable_Settings.y[iExtendablePositionmm];
      even = (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_back) ?
                [[0,180,90], [cutx,num_y*gf_pitch-wall_thickness-gf_tolerance/2,floorHeight], "darkgreen"]
              : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,180,180], [wall_thickness+gf_tolerance/2,cuty,floorHeight], "green"]
              : (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,180,270], [cutx,wall_thickness+gf_tolerance/2,floorHeight], "lime"]
              : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,180,0], [num_x*gf_pitch-wall_thickness-gf_tolerance/2,cuty,floorHeight], "aqua"] 
              : [[0,0,0],[0,0,0], extendable_Settings, "grey"];
      odd = (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,0,90], [cutx,wall_thickness+gf_tolerance/2,floorHeight], "pink"]
            : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_back) ?
                [[0,0,180], [num_x*gf_pitch-wall_thickness-gf_tolerance/2,cuty,floorHeight], "red"]
            : (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_back) ?
                [[0,0,270], [cutx,num_y*gf_pitch-wall_thickness-gf_tolerance/2,floorHeight], "orange"]
            : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,0,0], [wall_thickness+gf_tolerance/2,cuty,floorHeight], "yellow"]
            : [[0,0,0],[0,0,0], extendable_Settings, "grey"];
              
      for(i=[0:1:tabsCount-1])
      {
        isOdd = i % 2;
        tabPos = isOdd == 0 ? even : odd;
        if(IsHelpEnabled("trace")) echo("tabs", i=i, isOdd=isOdd, tabPos=tabPos);
        tz((i+0.5)*tabHeight)
        translate(tabPos[1])
          rotate(tabPos[0])
          attachment_clip(height=tabHeight, width=tabWidth, thickness=tabThickness, footingThickness=wall_thickness, tabStyle=tabStyle);
      }
    }
  }  
  
  if(IsHelpEnabled("info"))
    //translate(cupPosition(position,num_x,num_y))
    ShowCalipers(
      getCutx(), 
      getCuty(), 
      size=[num_x,num_y,num_z], 
      lip_style,
      cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
      cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
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
    ,"fingerslide",fingerslide
    ,"fingerslide_radius",fingerslide_radius
    ,"fingerslide_walls",fingerslide_walls
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
    ,"lip_style",lip_style
    ,"zClearance",zClearance
    ,"tapered_corner",tapered_corner
    ,"tapered_corner_size",tapered_corner_size
    ,"tapered_setback",tapered_setback
    ,"wallpattern_enabled",wallpattern_enabled
    ,"wallpattern_style",wallpattern_style
    ,"wallpattern_walls",wallpattern_walls
    ,"wallpattern_hole_sides",wallpattern_hole_sides
    ,"wallpattern_hole_size",wallpattern_hole_size
    ,"wallpattern_hole_spacing",wallpattern_hole_spacing
    ,"wallpattern_fill",wallpattern_fill
    ,"wallpattern_voronoi_noise",wallpattern_voronoi_noise
    ,"wallpattern_voronoi_radius",wallpattern_voronoi_radius
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
    ,IsHelpEnabled("info"));  
}

module cutout_pattern(
  patternStyle,
  canvasSize,
  customShape,
  circleFn,
  holeSize = [],
  holeSpacing,
  holeHeight,
  center,
  fill,
  voronoiNoise,
  voronoiRadius,
  help){
  if(patternStyle == "grid" || patternStyle == "hexgrid" || patternStyle == "gridrotated" || patternStyle == "hexgridrotated") {
    GridItemHolder(
      canvasSize = canvasSize,
      hexGrid = (patternStyle == "hexgrid" || patternStyle == "hexgridrotated"),
      customShape = customShape,
      circleFn = circleFn,
      holeSize = holeSize,
      holeSpacing = holeSpacing,
      holeHeight = holeHeight,
      center=center,
      fill=fill, //"none", "space", "crop"
      rotateGrid = (patternStyle == "gridrotated" || patternStyle == "hexgridrotated"),
      help=help);
  }
  else if(patternStyle == "voronoi" || patternStyle == "voronoigrid" || patternStyle == "voronoihexgrid"){
    if(IsHelpEnabled("trace")) echo("cutout_pattern", canvasSize = [canvasSize.x,canvasSize.y,holeHeight], thickness = holeSpacing.x, round=1);
    rectangle_voronoi(
      canvasSize = [canvasSize.x,canvasSize.y,holeHeight], 
      spacing = holeSpacing.x, 
      cellsize = holeSize.x,
      grid = (patternStyle == "voronoigrid" || patternStyle == "voronoihexgrid"),
      gridOffset = (patternStyle == "voronoihexgrid"),
      noise=voronoiNoise,
      radius = voronoiRadius,
      center=center);
  }
}

module partitioned_cavity(num_x, num_y, num_z, 
    label_settings=[],
    cupBase_settings=[],
    fingerslide=default_fingerslide,  fingerslide_radius=default_fingerslide_radius,
    fingerslide_walls=default_fingerslide_walls,
    wall_thickness=default_wall_thickness,
    chamber_wall_thickness=default_chamber_wall_thickness, chamber_wall_zClearance=default_chamber_wall_zClearance,
    calculated_vertical_separator_positions=calculated_vertical_separator_positions,
    calculated_horizontal_separator_positions=calculated_horizontal_separator_positions,
    lip_style=default_lip_style, zClearance=default_zClearance, 
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
  zpoint = gf_zpitch*num_z-zClearance;

  floorHeight = calculateFloorHeight(cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], screw_depth, floor_thickness);

  difference() {
    color(getColour(color_cupcavity))
    basic_cavity(num_x, num_y, num_z,
    fingerslide=fingerslide, fingerslide_walls=fingerslide_walls, fingerslide_radius=fingerslide_radius, cupBase_settings=cupBase_settings,
      wall_thickness=wall_thickness,
      lip_style=lip_style, sliding_lid_settings=sliding_lid_settings, zClearance=zClearance);
    sepFloorHeight = (efficient_floor != "off" ? floor_thickness : floorHeight);
    
    if(IsHelpEnabled("trace")) echo("partitioned_cavity", vertical_separator_positions=calculated_vertical_separator_positions);
    
    color(getColour(color_divider))
    tz(sepFloorHeight-fudgeFactor)
    separators(
      calculatedSeparators = calculated_vertical_separator_positions,  
      separator_orientation = "vertical");

    if(IsHelpEnabled("trace")) echo("partitioned_cavity", horizontal_separator_positions=calculated_horizontal_separator_positions);
    
    color(getColour(color_divider))
    translate([gf_pitch*num_x, 0, sepFloorHeight-fudgeFactor])
    separators( 
      calculatedSeparators = calculated_horizontal_separator_positions, 
      separator_orientation = "horizontal");
      
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
    fingerslide=default_fingerslide,  fingerslide_radius=default_fingerslide_radius,fingerslide_walls,
    wall_thickness=default_wall_thickness,
    lip_style=default_lip_style,
    cupBase_settings=[],
    sliding_lid_settings = [],
    zClearance = 0) {
  
  //Legacy variables
  floor_thickness=cupBase_settings[iCupBase_FloorThickness]; 
  magnet_diameter=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Diameter];
  screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height];
  magnet_easy_release=cupBase_settings[iCupBase_MagnetEasyRelease];
  flat_base=cupBase_settings[iCupBase_FlatBase];
  spacer=cupBase_settings[iCupBase_Spacer];
  box_corner_attachments_only=cupBase_settings[iCupBase_CornerAttachmentsOnly];
  half_pitch=cupBase_settings[iCupBase_HalfPitch];

  //zpoint = gf_zpitch*num_z-zClearance;
  
  AssertSlidingLidSettings(sliding_lid_settings);
  
  seventeen = gf_pitch/2-4;
    
  reducedlipstyle = 
    // replace "reduced" with "none" if z-height is less than 1.2
    (num_z < 1.2) ? "none" 
    // replace with "reduced" if z-height is less than 1.8
    : (num_z < 1.8) ? "reduced" 
    : lip_style;

  filledInZ = gf_zpitch*num_z;
  zpoint = filledInZ-zClearance;
 
  floorht = min(filledInZ, calculateFloorHeight(
      cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
      cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
      cupBase_settings[iCupBase_FloorThickness], 
      efficient_floor=cupBase_settings[iCupBase_EfficientFloor],
      flat_base=cupBase_settings[iCupBase_FlatBase]));

  //Remove floor to create a vertical spacer.
  nofloor = spacer && fingerslide == "none";
  
  //Difference between the wall and support thickness
  lipSupportThickness = (reducedlipstyle == "minimum" || reducedlipstyle == "none") ? 0
    : reducedlipstyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;
  lipHeight = (reducedlipstyle == "none") ? 0 : gf_Lip_Height-0.65;
  //bottom of the lip where it touches the wall
  lipBottomZ = ((reducedlipstyle == "minimum" || reducedlipstyle == "none") ? gf_zpitch*num_z +fudgeFactor*3
    : reducedlipstyle == "reduced" ? gf_zpitch*num_z+fudgeFactor*3
    : gf_zpitch*num_z-gf_lip_height-lipSupportThickness); 
  //lipBottomZ = gf_zpitch*num_z+fudgeFactor*3;
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
  
  if(IsHelpEnabled("trace")) echo("basic_cavity", efficient_floor=cupBase_settings[iCupBase_EfficientFloor], nofloor=nofloor, lipSupportThickness=lipSupportThickness, lipBottomZ=lipBottomZ, innerLipRadius=innerLipRadius, innerWallRadius=innerWallRadius, cavityHeight=cavityHeight, cavity_floor_radius=cavity_floor_radius);
  
  if(filledInZ>floorht) {
    union(){
    difference() {
    union() {
      if (reducedlipstyle == "minimum" || reducedlipstyle == "none") {
        /*hull() cornercopy(seventeen, num_x, num_y)
          tz(filledInZ-fudgeFactor) 
          cylinder(r=innerWallRadius, h=gf_Lip_Height, $fn=32);   // remove entire lip*/
      } 
      else if (reducedlipstyle == "reduced") {
        /*lowerTaperZ = filledInZ+gf_lip_lower_taper_height;
        hull() cornercopy(seventeen, num_x, num_y)
        union(){
          tz(lowerTaperZ) 
          cylinder(
            r1=innerWallRadius, 
            r2=gf_cup_corner_radius-gf_lip_upper_taper_height, 
            h=lipSupportThickness, $fn=32);
          tz(filledInZ-fudgeFactor) 
          cylinder(
            r=innerWallRadius, 
            h=lowerTaperZ-filledInZ+fudgeFactor*2, $fn=32);
        }*/
      } 
      else { // normal
        lowerTaperZ = filledInZ-gf_lip_height-lipSupportThickness;
        if(lowerTaperZ <= floorht){
          hull() cornercopy(seventeen, num_x, num_y)
            tz(floorht) 
            cylinder(r=innerLipRadius, h=filledInZ-floorht+fudgeFactor*4, $fn=32); // lip
        } else {
          hull() cornercopy(seventeen, num_x, num_y)
            tz(filledInZ-gf_lip_height-fudgeFactor) 
            cylinder(r=innerLipRadius, h=gf_lip_height+fudgeFactor*4, $fn=32); // lip
    
          hull() cornercopy(seventeen, num_x, num_y)
            tz(filledInZ-gf_lip_height-lipSupportThickness-fudgeFactor) 
            cylinder(
              r1=innerWallRadius,
              r2=innerLipRadius, h=q+fudgeFactor, $fn=32);   // ... to top of thin wall ...
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
            roundedr2=0, $fn=32);
    }

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
        fingerslide=fingerslide,
        fingerslide_radius=fingerslide_radius,
        reducedlipstyle=reducedlipstyle,
        wall_thickness=wall_thickness,
        floorht=floorht,
        seventeen=seventeen);
    }

    if (cupBase_settings[iCupBase_EfficientFloor] != "off") {
      magnetPosition = calculateMagnetPosition(magnet_diameter);
      magnetCoverHeight = max(
        cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
        cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height]);
      hasCornerAttachments = magnet_diameter > 0 || screw_depth > 0;
      efficientFloorGridHeight = max(magnetCoverHeight,gfBaseHeight())+floor_thickness;
      if(IsHelpEnabled("trace")) echo("basic_cavity", efficient_floor=cupBase_settings[iCupBase_EfficientFloor], efficientFloorGridHeight=efficientFloorGridHeight,  floor_thickness=floor_thickness);
      difference(){
        tz(-fudgeFactor)
          cube([num_x*gf_pitch, num_y*gf_pitch, efficientFloorGridHeight]);
        
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
    }
    
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
  if(IsHelpEnabled("trace")) echo(str("cutaway input:", num_x, " rounded:", roundtoDecimal(num_x, sigFigs = 2), " numx<1:", num_x < 1," round<1:", roundtoDecimal(num_x, sigFigs = 2)<1, " numx=round:", num_x==roundtoDecimal(num_x, sigFigs = 2)));
  if (roundtoDecimal(num_x,2) < 1) {
    top = num_z*gf_zpitch+gf_Lip_Height;
    height = top-lipBottomZ+fudgeFactor*2;
    
    hull()
    for (x=[1.5+0.25+wall_thickness, num_x*gf_pitch-1.5-0.25-wall_thickness]){
      for (y=[11, (num_y)*gf_pitch-seventeen])
      translate([x, y, top-height])
      cylinder(d=3, h=height, $fn=24);
    }
  }

  if (nofloor) {
    tz(-fudgeFactor)
      hull()
      cornercopy(num_x=num_x, num_y=num_y, r=seventeen)
      cylinder(r=2, h=gf_cupbase_lower_taper_height+fudgeFactor, $fn=32);
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
  assert(is_num(seventeen), "seventeen must be a number");
  
  echo("fingerslide", fingerslide_walls=fingerslide_walls, fingerslide=fingerslide);
  front = [
    //width
    num_x*gf_pitch,
    //Position
    [0, 0, 0],
    //rotation
    [0,0,0]];
  back = [
    //width
    num_x*gf_pitch,
    //Position
    [num_x*gf_pitch, num_y*gf_pitch, 0],
    //rotation
    [0,0,180]];
  left = [
    //width
    num_y*gf_pitch,
    //Position
    [0, num_y*gf_pitch, 0],
    //rotation
    [0,0,270]];
  right = [
    //width
    num_y*gf_pitch,
    //Position
    [num_x*gf_pitch, 0, 0],
    //rotation
    [0,0,90]];
    
  locations = [front, back, left, right];

  for(i = [0:1:len(locations)-1])
    union()
      if(fingerslide_walls[i] > 0)
        //patterns in the outer walls
        translate(locations[i][1])
        rotate(locations[i][2])                  
  translate([0, 
        reducedlipstyle == "reduced" ? - gf_lip_lower_taper_height
        : reducedlipstyle =="none" ? seventeen+1.15-gf_pitch/2+0.25+wall_thickness
        : 0, 0])
    translate([0,-seventeen-1.15+gf_pitch/2, floorht])
      union(){
        if(fingerslide == "rounded"){
          roundedCorner(
            radius = fingerslide_radius, 
            length=locations[i][0], 
            height = gf_zpitch*num_z);
        }
        else if(fingerslide == "chamfered"){
          chamferedCorner(
            chamferLength = fingerslide_radius, 
            length=locations[i][0],
            height = gf_zpitch*num_z);
      }
    }
}


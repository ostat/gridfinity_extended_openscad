include <gridfinity_constants.scad>
include <module_gridfinity_label.scad>
include <functions_general.scad>
include <module_voronoi.scad>
include <module_gridfinity_sliding_lid.scad>
include <module_divider_walls.scad>

use <module_gridfinity.scad>
use <module_item_holder.scad>
use <module_gridfinity_efficient_floor.scad>
use <module_attachement_clip.scad>
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

// Thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
default_wall_thickness = 0;// 0.01

// Set magnet diameter and depth to 0 to print without magnet holes
// (Zack's design uses magnet diameter of 6.5)
//under size the bin top by this amount to allow for better stacking
default_zClearance = 0; // 0.1

/* [Label] */
// Include overhang for labeling
default_label_style = "normal"; //[disabled: no label, normal:normal, click]

default_label_position = "left"; //[left: left aligned label, right: right aligned label, center: center aligned label, leftchamber: left aligned chamber label, rightchamber: right aligned chamber label, centerchamber: center aligned chamber label]
// Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
default_label_size = [0,14,0,0.6]; // 0.01
// Creates space so the attached label wont interfere with stacking
default_label_relief = 0; // 0.1
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
default_magnet_diameter = 6.5;  // .1
//create relief for magnet removal
default_magnet_easy_release = true;
// (Zack's design uses depth of 6)
default_screw_depth = 6;
default_center_magnet_diameter = 0;
default_center_magnet_thickness = 0;
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

// Limit attachments (magnets and scres) to box corners for faster printing.
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

/* [debug] */
default_cutx = 0;//0.01
default_cuty = 0;//0.01
default_help = "info"; //["off","info","debug","trace"]

module end_of_customizer_opts() {}

gridfinity_cup();//execution point

// It's recommended that all parameters other than x, y, z size should be specified by keyword 
// and not by position.  The number of parameters makes positional parameters error prone, and
// additional parameters may be added over time and break things.
// separator positions are defined in units from the left side
module gridfinity_cup(
  width=default_width,
  depth=default_depth,
  height=default_height,
  position=default_position,
  filled_in=default_filled_in,
  label_style=default_label_style,
  label_position=default_label_position,
  label_size=default_label_size,
  label_relief=default_label_relief,
  label_walls=default_label_walls,
  sliding_lid_enabled = default_sliding_lid_enabled,
  sliding_lid_thickness = default_sliding_lid_thickness,
  fingerslide=default_fingerslide,
  fingerslide_radius=default_fingerslide_radius,
  fingerslide_walls=default_fingerslide_walls,
  magnet_diameter=default_magnet_diameter,
  magnet_easy_release=default_magnet_easy_release,
  screw_depth=default_screw_depth,
  center_magnet_diameter = default_center_magnet_diameter,
  center_magnet_thickness = default_center_magnet_thickness,
  floor_thickness=default_floor_thickness,
  cavity_floor_radius=default_cavity_floor_radius,
  wall_thickness=default_wall_thickness,
  hole_overhang_remedy=default_hole_overhang_remedy,
  efficient_floor=default_efficient_floor,
  half_pitch=default_half_pitch,
  spacer=default_spacer,
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
  box_corner_attachments_only=default_box_corner_attachments_only,
  flat_base=default_flat_base,
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
  extension_enabled=[
    [default_extension_x_enabled,default_extension_x_position],
    [default_extension_y_enabled,default_extension_y_position]],
  extension_tabs_enabled=default_extension_tabs_enabled,
  extension_tab_size=default_extension_tab_size,
  sliding_lid_enabled = default_sliding_lid_enabled, 
  sliding_lid_thickness = default_sliding_lid_thickness, 
  sliding_min_wall_thickness = default_sliding_min_wallThickness, 
  sliding_min_support = default_sliding_min_support, 
  sliding_clearance = default_sliding_clearance,
  cutx=default_cutx,
  cuty=default_cuty,
  help=default_help) {
  $showHelp = help;
  num_x = calcDimensionWidth(width, true);
  num_y = calcDimensionDepth(depth, true);
  num_z = calcDimensionHeight(height, true);

  filled_in = validateFilledIn(filled_in);
  extension_enabled = validateBinExtensionEnabled(extension_enabled);
  
  vertical_separator_positions = vertical_irregular_subdivisions 
    ? vertical_separator_config 
    : splitChamber(vertical_chambers-1, num_x);
  horizontal_separator_positions=horizontal_irregular_subdivisions 
    ? horizontal_separator_config 
    : splitChamber(horizontal_chambers-1, num_y);

  $gfc=[["num_x",num_x],["num_y",num_y],["num_z",num_z],["vertical_separator_positions",vertical_separator_positions],["horizontal_separator_positions",horizontal_separator_positions]];
     
  //Correct legacy values, values that used to work one way but were then changed.
  wallpattern_dividers_enabled = is_bool(wallpattern_dividers_enabled)
    ? wallpattern_dividers_enabled ? "vertical" : "disabled"
    : wallpattern_dividers_enabled;
  
  //If efficient_floor disable the base magnets and screws
  center_magnet_thickness = efficient_floor != "off" ? 0 : center_magnet_thickness;
  center_magnet_diameter = efficient_floor != "off" ? 0 : center_magnet_diameter;
  //fingerslide = efficient_floor ? "none" : fingerslide;
  cavity_floor_radius = efficient_floor != "off" ? 0 : cavity_floor_radius;
  
  //wall_thickness default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
  wall_thickness = wallThickness(wall_thickness, num_z);
  
  slidingLidSettings= SlidingLidSettings(
          sliding_lid_enabled, 
          sliding_lid_thickness, 
          sliding_min_wall_thickness, 
          sliding_min_support,
          sliding_clearance,
          wall_thickness);
          
  zClearance = zClearance + (sliding_lid_enabled ? slidingLidSettings[iSlidingLidThickness] : 0);
  
  translate(cupPosition(position,num_x,num_y))
  union(){
    difference() {
      grid_block(
        num_x, num_y, num_z, 
        magnet_diameter, 
        screw_depth, 
        center_magnet_diameter = center_magnet_diameter,
        center_magnet_thickness = center_magnet_thickness,
        hole_overhang_remedy=hole_overhang_remedy, 
        half_pitch=half_pitch,
        box_corner_attachments_only=box_corner_attachments_only, 
        stackable = 
          lip_style == LipStyle_none ? Stackable_disabled 
          : filled_in == FilledIn_enabledfilllip ? Stackable_filllip : Stackable_enabled,
        flat_base=flat_base,
        magnet_easy_release = magnet_easy_release);

      if(filled_in == FilledIn_disabled) 
      union(){
        partitioned_cavity(
          num_x, num_y, num_z, 
          label_style=label_style,
          label_position=label_position,
          label_size=label_size,
          label_relief=label_relief,
          label_walls=label_walls,
          fingerslide=fingerslide, 
          fingerslide_radius=fingerslide_radius, 
          fingerslide_walls=fingerslide_walls,
          magnet_diameter=magnet_diameter,
          screw_depth=screw_depth, 
          floor_thickness=floor_thickness, 
          wall_thickness=wall_thickness,
          efficient_floor=efficient_floor, 
          half_pitch=half_pitch,
          chamber_wall_thickness=chamber_wall_thickness,
          chamber_wall_zClearance=chamber_wall_zClearance,
          vertical_separator_bend_position = vertical_separator_bend_position,
          vertical_separator_bend_angle = vertical_separator_bend_angle,
          vertical_separator_bend_separation = vertical_separator_bend_separation,
          vertical_separator_cut_depth = vertical_separator_cut_depth,
          horizontal_separator_bend_position = horizontal_separator_bend_position,
          horizontal_separator_bend_angle = horizontal_separator_bend_angle,
          horizontal_separator_bend_separation = horizontal_separator_bend_separation,
          horizontal_separator_cut_depth = horizontal_separator_cut_depth,
          vertical_separator_positions = vertical_separator_positions,
          horizontal_separator_positions = horizontal_separator_positions,
          lip_style=lip_style, 
          zClearance=zClearance,
          flat_base=flat_base,
          spacer=spacer,
          cavity_floor_radius=cavity_floor_radius,
          box_corner_attachments_only = box_corner_attachments_only,
          sliding_lid_settings= slidingLidSettings
          );
      
      color(color_wallcutout)
        union(){
          floorHeight = calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness);
          cavityFloorRadius = calcualteCavityFloorRadius(cavity_floor_radius, wall_thickness, efficient_floor);
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
            
            labelSize = calculateLabelSize(label_size);
            //Subtracting the wallpattern_thickness is a bit of a hack, its needed as the label extends in to the wall.
            labelSizez = (label_style != "disabled" ? labelSize.z-wallpattern_thickness : 0);
            
            front = [
              //width,height
              [num_x*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,
                heightz - (label_walls[0] != 0 ? labelSizez : 0)],
              //Position
              [(num_x)*gf_pitch/2, 
                wallpattern_thickness, 
                z - (label_walls[0] != 0 ? labelSizez : 0)/2],
              //rotation
              [90,0,0]];
            back = [
              [num_x*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,
                heightz - (label_walls[1] != 0 ? labelSizez : 0)],
              [(num_x)*gf_pitch/2, 
                (num_y)*gf_pitch, 
                 z - (label_walls[1] != 0 ? labelSizez : 0)/2],
              [90,0,0]];
            left = [
              [num_y*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,
                heightz - (label_walls[2] != 0 ? labelSizez : 0)],
              [0, 
                (num_y)*gf_pitch/2, 
                z - (label_walls[2] != 0 ? labelSizez : 0)/2],
              [90,0,90]];
            right = [
              [num_y*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,
                heightz - (label_walls[3] != 0 ? labelSizez : 0)],
              [(num_x)*gf_pitch-wallpattern_thickness,   
                (num_y)*gf_pitch/2, 
                z - (label_walls[3] != 0 ? labelSizez : 0)/2],
              [90,0,90]];
          
          locations = [front, back, left, right];
            
          //["disabled", "horizontal", "vertical", "both"] 
          if(wallpattern_dividers_enabled != "disabled"){
            difference(){
              union(){
                if(wallpattern_dividers_enabled == "vertical" || wallpattern_dividers_enabled == "both")
                  separators_generic(
                    seperator_config = vertical_separator_positions, 
                    length = left[0][1],
                    height = left[0][0],
                    wall_thickness = chamber_wall_thickness*2,
                    bend_position = vertical_separator_bend_position,
                    bend_angle = vertical_separator_bend_angle,
                    bend_separation = vertical_separator_bend_separation,
                    cut_depth = vertical_separator_cut_depth,
                    separator_orentation = "vertical") 
                      translate([-$sepCfg[iSeperatorBendSeparation]/2, 0, fudgeFactor]) 
                      translate(left[1])
                      rotate(left[2])
                      render() //Render on vertical_separator pattern because detailed patters can be slow
                      cutout_pattern(
                        patternStyle = wallpattern_style,
                        canvasSize = left[0], 
                        customShape = false,
                        circleFn = wallpattern_hole_sides,
                        holeSize = [wallpattern_hole_size, wallpattern_hole_size],
                        holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
                        holeHeight = $sepCfg[iSeperatorWallThickness]+$sepCfg[iSeperatorBendSeparation],
                        center=true,
                        fill=wallpattern_fill, //"none", "space", "crop"
                        voronoiNoise=wallpattern_voronoi_noise,
                        voronoiRadius = wallpattern_voronoi_radius,
                        help=help);
                  
                if(wallpattern_dividers_enabled == "horizontal" || wallpattern_dividers_enabled == "both")
                  separators_generic(
                    seperator_config = horizontal_separator_positions, 
                    length = front[0][1],
                    height = front[0][0],
                    wall_thickness = chamber_wall_thickness*2,
                    bend_position = horizontal_separator_bend_position,
                    bend_angle = horizontal_separator_bend_angle,
                    bend_separation = horizontal_separator_bend_separation,
                    cut_depth = horizontal_separator_cut_depth,
                    separator_orentation = "horizontal") 
                      rotate([0,0,-90])
                      translate([0,$sepCfg[iSeperatorBendSeparation]/2, fudgeFactor]) 
                      translate(front[1])
                      rotate(front[2])
                      render() //Render on horizontal_separator pattern because detailed patters can be slow
                      cutout_pattern(
                        patternStyle = wallpattern_style,
                        canvasSize = front[0], 
                        customShape = false,
                        circleFn = wallpattern_hole_sides,
                        holeSize = [wallpattern_hole_size, wallpattern_hole_size],
                        holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
                        holeHeight = $sepCfg[iSeperatorWallThickness]+$sepCfg[iSeperatorBendSeparation],
                        center=true,
                        fill=wallpattern_fill, //"none", "space", "crop"
                        voronoiNoise=wallpattern_voronoi_noise,
                        voronoiRadius = wallpattern_voronoi_radius,
                        help=help);
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
            difference(){
              for(i = [0:1:len(locations)-1])
                union()
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
              sepFloorHeight = (efficient_floor != "off" ? floor_thickness : floorHeight);
              translate([0, 0, sepFloorHeight-fudgeFactor])
              separators(  
                length=gf_pitch*num_y,
                height=gf_zpitch*(num_z)-sepFloorHeight+border*2+fudgeFactor*2,
                wall_thickness = chamber_wall_thickness+cutoutclearance*2,
                bend_position = vertical_separator_bend_position,
                bend_angle = vertical_separator_bend_angle,
                bend_separation = vertical_separator_bend_separation,
                cut_depth = vertical_separator_cut_depth,
                seperator_config = vertical_separator_positions);

              translate([gf_pitch*num_x, 0, sepFloorHeight-fudgeFactor])
              rotate([0,0,90])
              separators(  
                length=gf_pitch*num_x,
                height=gf_zpitch*(num_z)-sepFloorHeight+border*2+fudgeFactor*2,
                wall_thickness = chamber_wall_thickness+cutoutclearance*2,
                bend_position = horizontal_separator_bend_position,
                bend_angle = horizontal_separator_bend_angle,
                bend_separation = horizontal_separator_bend_separation,
                cut_depth = horizontal_separator_cut_depth,
                seperator_config = horizontal_separator_positions);

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
        }
      }
      
      if(extension_enabled.x[0]!=BinExtensionEnabled_disabled)
        color(color_wallcutout)
        if(extension_enabled.x[0]==BinExtensionEnabled_front)
        tz(-fudgeFactor)
          cube([unitPositionTo_mm(extension_enabled.x[1],num_x),num_y*gf_pitch,(num_z+1)*gf_zpitch]);
        else
          translate([unitPositionTo_mm(extension_enabled.x[1],num_x),0,-fudgeFactor])
            cube([num_x*gf_pitch-unitPositionTo_mm(extension_enabled.x[1],num_x),num_y*gf_pitch,(num_z+1)*gf_zpitch]);
      
      if(extension_enabled.y[0]!=BinExtensionEnabled_disabled)
        color(color_wallcutout)
        if(extension_enabled.y[0]==BinExtensionEnabled_front)
          tz(-fudgeFactor)
          cube([gf_pitch*num_x,unitPositionTo_mm(extension_enabled.y[1],num_y),(num_z+1)*gf_zpitch]);
        else
          translate([0,unitPositionTo_mm(extension_enabled.y[1],num_y),-fudgeFactor])
          cube([gf_pitch*num_x,num_y*gf_pitch-unitPositionTo_mm(extension_enabled.y[1],num_y),(num_z+1)*gf_zpitch]);

      if(cutx > 0 && $preview)
        color(color_cut)
        tz(-fudgeFactor)
          cube([gf_pitch*cutx,num_y*gf_pitch,(num_z+1)*gf_zpitch]);

      if(cuty > 0 && $preview)
        color(color_cut)
        tz(-fudgeFactor)
          cube([num_x*gf_pitch,gf_pitch*cuty,(num_z+1)*gf_zpitch]);
    }
    
    if((extension_enabled.x[0]!=BinExtensionEnabled_disabled || extension_enabled.y[0]!=BinExtensionEnabled_disabled) && extension_tabs_enabled) {
      refTabHeight = extension_tab_size.x;
      tabThickness = extension_tab_size.z == 0 ? 1.4 : extension_tab_size.z;//1.4; //This should be calculated
      tabWidth = extension_tab_size.y;
      tabStyle = extension_tab_size[3];
      
      floorHeight = calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness) + calcualteCavityFloorRadius(cavity_floor_radius, wall_thickness,efficient_floor)-tabThickness;
      
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
      if(IsHelpEnabled("debug")) echo("tabs", binHeight =num_z, tabHeight=tabHeight, floorHeight=floorHeight, cavity_floor_radius=cavity_floor_radius, tabThickness=tabThickness);
      cutx = unitPositionTo_mm(extension_enabled.x[1],num_x);
      cuty = unitPositionTo_mm(extension_enabled.y[1],num_y);
      even = (extension_enabled.x[0]==BinExtensionEnabled_front && extension_enabled.y[0]!=BinExtensionEnabled_back) ?
                [[0,180,90], [cutx,num_y*gf_pitch-wall_thickness-gf_tolerance/2,floorHeight], "darkgreen"]
              : (extension_enabled.y[0]==BinExtensionEnabled_front && extension_enabled.x[0]!=BinExtensionEnabled_front) ?
                [[0,180,180], [wall_thickness+gf_tolerance/2,cuty,floorHeight], "green"]
              : (extension_enabled.x[0]==BinExtensionEnabled_back && extension_enabled.y[0]!=BinExtensionEnabled_front) ?
                [[0,180,270], [cutx,wall_thickness+gf_tolerance/2,floorHeight], "lime"]
              : (extension_enabled.y[0]==BinExtensionEnabled_back && extension_enabled.y[0]!=BinExtensionEnabled_front) ?
                [[0,180,0], [num_x*gf_pitch-wall_thickness-gf_tolerance/2,cuty,floorHeight], "aqua"] 
              : [[0,0,0],[0,0,0], extension_enabled, "grey"];
      odd = (extension_enabled.x[0]==BinExtensionEnabled_front && extension_enabled.y[0]!=BinExtensionEnabled_front) ?
                [[0,0,90], [cutx,wall_thickness+gf_tolerance/2,floorHeight], "pink"]
            : (extension_enabled.y[0]==BinExtensionEnabled_front && extension_enabled.x[0]!=BinExtensionEnabled_back) ?
                [[0,0,180], [num_x*gf_pitch-wall_thickness-gf_tolerance/2,cuty,floorHeight], "red"]
            : (extension_enabled.x[0]==BinExtensionEnabled_back && extension_enabled.y[0]!=BinExtensionEnabled_back) ?
                [[0,0,270], [cutx,num_y*gf_pitch-wall_thickness-gf_tolerance/2,floorHeight], "orange"]
            : (extension_enabled.y[0]==BinExtensionEnabled_back && extension_enabled.y[0]!=BinExtensionEnabled_front) ?
                [[0,0,0], [wall_thickness+gf_tolerance/2,cuty,floorHeight], "yellow"]
            : [[0,0,0],[0,0,0], extension_enabled, "grey"];
              
      for(i=[0:1:tabsCount-1])
      {
        isOdd = i % 2;
        tabPos = isOdd == 0 ? even : odd;
        if(IsHelpEnabled("trace")) echo("tabs", i=i, isOdd=isOdd, tabPos=tabPos);
        //color(tabPos[2])
        tz((i+0.5)*tabHeight)
        translate(tabPos[1])
          rotate(tabPos[0])
          attachement_clip(height=tabHeight, width=tabWidth, thickness=tabThickness, footingThickness=wall_thickness, tabStyle=tabStyle);
      }
    }
  }  
  
  if(IsHelpEnabled("info"))
    translate(cupPosition(position,num_x,num_y))
    ShowCalipers(
      cutx, 
      cuty, 
      size=[num_x,num_y,num_z], 
      lip_style,
      magnet_diameter, 
      screw_depth, 
      floor_thickness, 
      filled_in,
      wall_thickness,
      efficient_floor,
      flat_base); 
      
  HelpTxt("gridfinity_cup",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"position",position
    ,"filled_in",filled_in
    ,"label_style",label_style
    ,"label_position",label_position
    ,"label_size",label_size
    ,"label_relief",label_relief
    ,"label_walls",label_walls
    ,"fingerslide",fingerslide
    ,"fingerslide_radius",fingerslide_radius
    ,"fingerslide_walls",fingerslide_walls
    ,"magnet_diameter",magnet_diameter
    ,"screw_depth",screw_depth
    ,"floor_thickness",floor_thickness
    ,"cavity_floor_radius",cavity_floor_radius
    ,"wall_thickness",wall_thickness
    ,"hole_overhang_remedy",hole_overhang_remedy
    ,"efficient_floor",efficient_floor
    ,"half_pitch",half_pitch
    ,"chamber_wall_thickness",chamber_wall_thickness
    ,"vertical_separator_bend_position",vertical_separator_bend_position
    ,"vertical_separator_bend_angle",vertical_separator_bend_angle
    ,"vertical_separator_bend_separation",vertical_separator_bend_separation
    ,"vertical_separator_positions",vertical_separator_positions
    ,"vertical_separator_cut_depth",vertical_separator_cut_depth
    ,"horizontal_separator_bend_position",horizontal_separator_bend_position
    ,"horizontal_separator_bend_angle",horizontal_separator_bend_angle
    ,"horizontal_separator_bend_separation",horizontal_separator_bend_separation
    ,"horizontal_separator_positions",horizontal_separator_positions
    ,"horizontal_separator_cut_depth",horizontal_separator_cut_depth
    ,"lip_style",lip_style
    ,"zClearance",zClearance
    ,"box_corner_attachments_only",box_corner_attachments_only
    ,"flat_base",flat_base
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
    ,"extension_enabled",extension_enabled
    ,"extension_tabs_enabled",extension_tabs_enabled
    ,"cutx",cutx
    ,"cuty",cuty]
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

module partitioned_cavity(num_x, num_y, num_z, label_style=default_label_style, label_position=default_label_position, 
    label_size=default_label_size, label_relief=default_label_relief, label_walls=default_label_walls,
    fingerslide=default_fingerslide,  fingerslide_radius=default_fingerslide_radius,
    fingerslide_walls=default_fingerslide_walls,
    magnet_diameter=default_magnet_diameter, screw_depth=default_screw_depth, 
    floor_thickness=default_floor_thickness, wall_thickness=default_wall_thickness,
    efficient_floor=default_efficient_floor, half_pitch=default_half_pitch,         chamber_wall_thickness=default_chamber_wall_thickness, chamber_wall_zClearance=default_chamber_wall_zClearance,
    vertical_separator_bend_position = default_vertical_separator_bend_position,
    vertical_separator_bend_angle = default_vertical_separator_bend_angle,
    vertical_separator_bend_separation = default_vertical_separator_bend_separation,
    vertical_separator_cut_depth = default_vertical_separator_cut_depth,
    vertical_separator_positions = [],
    horizontal_separator_bend_position = default_horizontal_separator_bend_position,
    horizontal_separator_bend_angle = default_horizontal_separator_bend_angle,
    horizontal_separator_bend_separation = default_horizontal_separator_bend_separation,
    horizontal_separator_cut_depth = default_horizontal_separator_cut_depth,
    horizontal_separator_positions = [],
    lip_style=default_lip_style, zClearance=default_zClearance, flat_base=default_flat_base, cavity_floor_radius=default_cavity_floor_radius,spacer=default_spacer, box_corner_attachments_only=default_box_corner_attachments_only,sliding_lid_settings=[]) {
  
  floorHeight = calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness);
  
  zpoint = gf_zpitch*num_z-zClearance;
  
  difference() {
    color(color_cupcavity)
    basic_cavity(num_x, num_y, num_z, 
    fingerslide=fingerslide, fingerslide_walls=fingerslide_walls, fingerslide_radius=fingerslide_radius, magnet_diameter=magnet_diameter,
      screw_depth=screw_depth, floor_thickness=floor_thickness, wall_thickness=wall_thickness,
      efficient_floor=efficient_floor, half_pitch=half_pitch, lip_style=lip_style, flat_base=flat_base, cavity_floor_radius=cavity_floor_radius, spacer=spacer, box_corner_attachments_only = box_corner_attachments_only, sliding_lid_settings=sliding_lid_settings, zClearance=zClearance);
    sepFloorHeight = (efficient_floor != "off" ? floor_thickness : floorHeight);
    
    if(IsHelpEnabled("trace")) echo("partitioned_cavity", vertical_separator_positions=vertical_separator_positions);
    
    color(color_divider)
    tz(sepFloorHeight-fudgeFactor)
    separators(  
      length=gf_pitch*num_y,
      height=gf_zpitch*(num_z)-sepFloorHeight+fudgeFactor*2-max(zClearance, chamber_wall_zClearance),
      wall_thickness = chamber_wall_thickness,
      bend_position = vertical_separator_bend_position,
      bend_angle = vertical_separator_bend_angle,
      bend_separation = vertical_separator_bend_separation,
      cut_depth = vertical_separator_cut_depth,
      seperator_config = vertical_separator_positions,
      separator_orentation = "vertical");

    if(IsHelpEnabled("trace")) echo("partitioned_cavity", horizontal_separator_positions=horizontal_separator_positions);
    
    color(color_divider)
    translate([gf_pitch*num_x, 0, sepFloorHeight-fudgeFactor])
    separators(  
      length=gf_pitch*num_x,
      height=gf_zpitch*(num_z)-sepFloorHeight+fudgeFactor*2-max(zClearance, chamber_wall_zClearance),
      wall_thickness = chamber_wall_thickness,
      bend_position = horizontal_separator_bend_position,
      bend_angle = horizontal_separator_bend_angle,
      bend_separation = horizontal_separator_bend_separation,
      cut_depth = horizontal_separator_cut_depth,
      seperator_config = horizontal_separator_positions,
      separator_orentation = "horizontal");
      
    if(label_style != "disabled"){
      vertical_separator_positions = calculateSeparators(
          seperator_config = vertical_separator_positions, 
          length = gf_pitch*num_y,
          height = gf_zpitch*(num_z)-sepFloorHeight+fudgeFactor*2-max(zClearance, chamber_wall_zClearance),
          wall_thickness = chamber_wall_thickness,
          bend_position = vertical_separator_bend_position,
          bend_angle = vertical_separator_bend_angle,
          bend_separation = vertical_separator_bend_separation,
          cut_depth = vertical_separator_cut_depth);
      horizontal_separator_positions = calculateSeparators(
          seperator_config = horizontal_separator_positions, 
          length = gf_pitch*num_x,
          height = gf_zpitch*(num_z)-sepFloorHeight+fudgeFactor*2-max(zClearance, chamber_wall_zClearance),
          wall_thickness = chamber_wall_thickness,
          bend_position = horizontal_separator_bend_position,
          bend_angle = horizontal_separator_bend_angle,
          bend_separation = horizontal_separator_bend_separation,
          cut_depth = horizontal_separator_cut_depth);
          
      gridfinity_label(
        num_x = num_x,
        num_y = num_y,
        zpoint = zpoint,
        vertical_separator_positions = vertical_separator_positions,
        horizontal_separator_positions = horizontal_separator_positions,
        label_size=label_size,
        label_position = label_position,
        label_style = label_style,
        label_relief = label_relief,
        label_walls=label_walls);
        
    }
  }
}
/*
calculateSeparators(
                  seperator_config, 
                  length,
                  height,
                  wall_thickness = 0,
                  bend_position = 0,
                  bend_angle = 0,
                  bend_separation = 0,
                  cut_depth = 0)
  */                

module basic_cavity(num_x, num_y, num_z, fingerslide=default_fingerslide,  fingerslide_radius=default_fingerslide_radius,fingerslide_walls,
    magnet_diameter=default_magnet_diameter, screw_depth=default_screw_depth, 
    floor_thickness=default_floor_thickness, wall_thickness=default_wall_thickness,
    efficient_floor=default_efficient_floor, half_pitch=default_half_pitch, 
    lip_style=default_lip_style, flat_base=default_flat_base, cavity_floor_radius=default_cavity_floor_radius, spacer=default_spacer, box_corner_attachments_only = default_box_corner_attachments_only,
    sliding_lid_settings = [],
    zClearance = 0) {
  
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
 
  floorht = min(filledInZ,calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness, efficient_floor=efficient_floor,flat_base=flat_base));

  //Remove floor to create a vertical spacer.
  nofloor = spacer && fingerslide == "none";
  
  //Difference between the wall and support thickness
  lipSupportThickness = (reducedlipstyle == "minimum" || reducedlipstyle == "none") ? 0
    : reducedlipstyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;
  lipHeight = (reducedlipstyle == "none") ? 0 : gf_Lip_Height-0.65;
  //bottom of the lip where it touches the wall
  lipBottomZ = ((reducedlipstyle == "minimum" || reducedlipstyle == "none") ? gf_zpitch*num_z
    : reducedlipstyle == "reduced" ? gf_zpitch*num_z
    : gf_zpitch*num_z-gf_lip_height-lipSupportThickness); 
  
  innerLipRadius = gf_cup_corner_radius-gf_lip_lower_taper_height-gf_lip_upper_taper_height; //1.15
  innerWallRadius = gf_cup_corner_radius-wall_thickness;
  

  aboveLidHeight =  sliding_lid_settings[iSlidingLidThickness] + lipHeight;
  
  cavityHeight= max(lipBottomZ-floorht,0);
  cavity_floor_radius = calcualteCavityFloorRadius(cavity_floor_radius, wall_thickness,efficient_floor);
  
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // arount the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  
  if(IsHelpEnabled("trace")) echo("basic_cavity", efficient_floor=efficient_floor, nofloor=nofloor, lipSupportThickness=lipSupportThickness, lipBottomZ=lipBottomZ, innerLipRadius=innerLipRadius, innerWallRadius=innerWallRadius, cavityHeight=cavityHeight, cavity_floor_radius=cavity_floor_radius);
  
  if(filledInZ>floorht) {
    union(){
    difference() {
    union() {
      if (reducedlipstyle == "minimum" || reducedlipstyle == "none") {
        hull() cornercopy(seventeen, num_x, num_y)
          tz(filledInZ-fudgeFactor) 
          cylinder(r=innerWallRadius, h=gf_Lip_Height, $fn=32);   // remove entire lip
      } 
      else if (reducedlipstyle == "reduced") {
        lowerTaperZ = filledInZ+gf_lip_lower_taper_height;
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
        }
      } 
      else { // normal
        lowerTaperZ = filledInZ-gf_lip_height-lipSupportThickness;
        if(lowerTaperZ <= floorht){
          hull() cornercopy(seventeen, num_x, num_y)
            tz(floorht) 
            cylinder(r=innerLipRadius, h=filledInZ-floorht+fudgeFactor*2, $fn=32); // lip
        } else {
          hull() cornercopy(seventeen, num_x, num_y)
            tz(filledInZ-gf_lip_height-fudgeFactor) 
            cylinder(r=innerLipRadius, h=gf_lip_height+fudgeFactor*2, $fn=32); // lip
    
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

    if (efficient_floor != "off") {
      magnetPosition = calculateMagnetPosition(magnet_diameter);
      magnetCoverHeight = max(magnet_diameter > 0 ? gf_magnet_thickness : 0, screw_depth);
      hasCornerAttachments = magnet_diameter > 0 || screw_depth > 0;
      efficientFloorGridHeight = max(magnetCoverHeight,gfBaseHeight())+floor_thickness;
      if(IsHelpEnabled("trace")) echo("basic_cavity", efficient_floor=efficient_floor, efficientFloorGridHeight=efficientFloorGridHeight,  floor_thickness=floor_thickness);
      difference(){
        tz(-fudgeFactor)
          cube([num_x*gf_pitch, num_y*gf_pitch, efficientFloorGridHeight]);
        
        difference(){
          efficient_floor_grid(
            num_x, num_y, 
            floorStyle = efficient_floor,
            half_pitch=half_pitch, 
            flat_base=flat_base, 
            floor_thickness=floor_thickness,
            efficientFloorGridHeight=efficientFloorGridHeight,
            margins=q);
           
           //Screw and magnet covers required for efficient floor
           if(hasCornerAttachments)
             gridcopycorners(num_x, num_y, magnetPosition, box_corner_attachments_only)
                EfficientFloorAttachementCaps(
                  grid_copy_corner_index = $gcci,
                  floor_thickness = floor_thickness,
                  magnet_diameter=magnet_diameter,
                  screw_depth = screw_depth,
                  wall_thickness = wall_thickness);
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
  if (num_x < 1) {
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

module SlidingLidSupportMaterial(
  num_x, 
  num_y,
  wall_thickness,
  sliding_lid_settings,
  innerWallRadius,
  zpoint){
  
  seventeen = gf_pitch/2-4;
    
  aboveLipHeight = sliding_lid_settings[iSlidingLidThickness];
  belowLedgeHeight = sliding_lid_settings[iSlidingLidThickness]/4;
  belowRampHeight = sliding_lid_settings[iSlidingLidMinSupport];

  belowLipHeight = belowLedgeHeight+belowRampHeight;
  slidingLidEdge = gf_cup_corner_radius-sliding_lid_settings[iSlidingLidMinWallThickness]; 
   
  //Sliding lid lower support lip
  tz(zpoint-belowLipHeight) 
  difference(){
    hull() 
      cornercopy(seventeen, num_x, num_y)
      cylinder(r=innerWallRadius, h=belowLipHeight, $fn=32); 
      
        union(){
        hull() cornercopy(seventeen, num_x, num_y)
          tz(belowRampHeight-fudgeFactor)
          cylinder(r=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=belowLedgeHeight+fudgeFactor*2, $fn=32);
          
        hull() cornercopy(seventeen, num_x, num_y)
        tz(-fudgeFactor)
        cylinder(r1=slidingLidEdge, r2=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=belowRampHeight+fudgeFactor, $fn=32);
     }
   }

  //Sliding lid upper lip
  tz(zpoint) 
  difference(){
    hull() 
      cornercopy(seventeen, num_x, num_y)
      tz(fudgeFactor) 
      cylinder(r=slidingLidEdge, h=aboveLipHeight, $fn=32); 
    union(){
    hull() 
      cornercopy(seventeen, num_x, num_y)
      tz(fudgeFactor) 
      cylinder(r=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=aboveLipHeight+fudgeFactor, $fn=32); 
      
    *SlidingLid(
      num_x=num_x, 
      num_y=num_y,
      wall_thickness,
      clearance = 0,
      slidingLidThickness=sliding_lid_settings[iSlidingLidThickness],
      slidingLidMinSupport=sliding_lid_settings[iSlidingLidMinSupport],
      slidingLidMinWallThickness=sliding_lid_settings[iSlidingLidMinWallThickness]);
    }
  }
}

module SlidingLidCavity(
  num_x, 
  num_y,
  wall_thickness,
  sliding_lid_settings,
  aboveLidHeight
){
  SlidingLid(
    num_x=num_x, 
    num_y=num_y,
    wall_thickness,
    clearance = 0,
    lidThickness=sliding_lid_settings[iSlidingLidThickness],
    lidMinSupport=sliding_lid_settings[iSlidingLidMinSupport],
    lidMinWallThickness=sliding_lid_settings[iSlidingLidMinWallThickness],
    limitHeight = false);
  
  //translate([-gf_pitch/2,-gf_pitch/2,zpoint]) 
  //cube([num_x*gf_pitch,gf_cup_corner_radius,zClearance+gf_Lip_Height]);
  //innerWallRadius = gf_cup_corner_radius-wall_thickness;
  translate([0,gf_cup_corner_radius,aboveLidHeight]) 
  rotate([270,0,0])
  chamferedCorner(
    cornerRadius = aboveLidHeight/4,
    chamferLength = aboveLidHeight,
    length=num_x*gf_pitch, 
    height = aboveLidHeight,
    width = gf_cup_corner_radius);
}
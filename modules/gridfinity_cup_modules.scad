use <gridfinity_modules.scad>
use <modules_item_holder.scad>
include <gridfinity_constants.scad>
include <functions_general.scad>

default_num_x=2; //0.1
default_num_y=1; //0.1
default_num_z=3; //0.1
default_position="default"; //["default","center","zero"]
default_filled_in = "off"; //["off","on","notstackable"] 
// Include overhang for labeling
default_label_style = "disabled"; //[disabled: no label, left: left aligned label, right: right aligned label, center: center aligned label, leftchamber: left aligned chamber label, rightchamber: right aligned chamber label, centerchamber: center aligned chamber label]
// Width of the label in number of units, or zero for full width
default_labelWidth = 0; // 0.01
// Include larger corner fillet
default_fingerslide = "none"; //[none, rounded, chamfered]
// radius of the corner fillet
default_fingerslide_radius = 8;
// Set magnet diameter and depth to 0 to print without magnet holes
// (Zack's design uses magnet diameter of 6.5)
/* [Subdivisions] */
// X dimension subdivisions
default_chamber_wall_thickness = 1.2;//0.1
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
// (Zack's design uses depth of 6)
default_screw_depth = 6;
default_center_magnet_diameter = 0;
default_center_magnet_thickness = 0;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
default_floor_thickness = 1.2;
// Thickness of outer walls (Zack's design is 0.95 mm)
default_wall_thickness = 0.95;
default_cavity_floor_radius = -1;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
default_hole_overhang_remedy = 2;
// Save material with thinner floor (only if no magnets, screws, or finger-slide used)
default_efficient_floor = false;
// Remove floor to create a spacer
default_spacer = false;
// Half-pitch base pads for offset stacking
default_half_pitch = false;
// Might want to remove inner lip of cup
default_lip_style = "normal"; //[normal, reduced, none]
// Limit attachments (magnets and scres) to box corners for faster printing.
default_box_corner_attachments_only = false;
// Removes the base grid from inside the shape
default_flat_base = false;
/* [Tapered Corner] */
default_tapered_corner = "none"; //[none, rounded, chamfered]
default_tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
default_tapered_setback = -1;//gf_cup_corner_radius/2;
/* [Wall Cutout] */
default_wallcutout_enabled=false;
// wall to enable on, front, back, left, right.
default_wallcutout_walls=[1,0,0,0]; 
//default will be binwidth/2
default_wallcutout_width=0;
default_wallcutout_angle=70;
//default will be binHeight
default_wallcutout_height=0;
default_wallcutout_corner_radius=5;
/* [Wall Pattern] */
default_wallpattern_enabled=false; 
default_wallpattern_dividers_enabled=false; 
default_wallpattern_hexgrid = false;
default_wallpattern_fill = "none"; //["none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"]
default_wallpattern_walls=[1,0,0,0]; 
default_wallpattern_hole_sides = 6;
default_wallpattern_hole_size = 5; //0.1
default_wallpattern_hole_spacing = 2; //0.1

/* [Extendable] */
default_extention_x_enabled = false;
default_extention_y_enabled = false;
default_extention_tabs_enabled = true;

/* [debug] */
default_cutx = 0;//0.1
default_cuty = 0;//0.1
default_help = false;

basic_cup(
  num_x=default_num_x,
  num_y=default_num_y,
  num_z=default_num_z,
  position=default_position,
  filled_in = default_filled_in,
  chamber_wall_thickness = default_chamber_wall_thickness,
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
  label_style=default_label_style,
  labelWidth=default_labelWidth,
  magnet_diameter=default_magnet_diameter,
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
  lip_style=default_lip_style,
  box_corner_attachments_only=default_box_corner_attachments_only,
  flat_base=default_flat_base,
  tapered_corner=default_tapered_corner,
  tapered_corner_size=default_tapered_corner_size,
  tapered_setback=default_tapered_setback,
  wallpattern_enabled=default_wallpattern_enabled,
  wallpattern_hexgrid=default_wallpattern_hexgrid,
  wallpattern_fill=default_wallpattern_fill,
  wallpattern_walls=default_wallpattern_walls, 
  wallpattern_hole_sides=default_wallpattern_hole_sides,
  wallpattern_hole_size=default_wallpattern_hole_size,
  wallpattern_hole_spacing=default_wallpattern_hole_spacing,
  wallcutout_enabled=default_wallcutout_enabled,
  wallcutout_walls=default_wallcutout_walls,
  wallcutout_width=default_wallcutout_width,
  wallcutout_angle=default_wallcutout_angle,
  wallcutout_height=default_wallcutout_height,
  wallcutout_corner_radius=default_wallcutout_corner_radius,
  extention_enabled=[default_extention_x_enabled,default_extention_y_enabled],
  extention_tabs_enabled=default_extention_tabs_enabled,
  cutx=default_cutx,
  cuty=default_cuty,
  help = default_help
);

// It's recommended that all parameters other than x, y, z size should be specified by keyword 
// and not by position.  The number of parameters makes positional parameters error prone, and
// additional parameters may be added over time and break things.
module basic_cup(
  num_x,
  num_y,
  num_z,
  position=default_position,
  filled_in = default_filled_in,
  chamber_wall_thickness = default_chamber_wall_thickness,
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
  label_style=default_label_style,
  labelWidth=default_labelWidth,
  fingerslide=default_fingerslide,
  fingerslide_radius=default_fingerslide_radius,
  magnet_diameter=default_magnet_diameter,
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
  lip_style=default_lip_style,
  box_corner_attachments_only=default_box_corner_attachments_only,
  flat_base = default_flat_base,
  tapered_corner = default_tapered_corner,
  tapered_corner_size = default_tapered_corner_size,
  tapered_setback = default_tapered_setback,
  wallpattern_enabled=default_wallpattern_enabled,
  wallpattern_hexgrid=default_wallpattern_hexgrid,
  wallpattern_fill=default_wallpattern_fill,
  wallpattern_walls=default_wallpattern_walls, 
  wallpattern_dividers_enabled = default_wallpattern_dividers_enabled,
  wallpattern_hole_sides=default_wallpattern_hole_sides,
  wallpattern_hole_size=default_wallpattern_hole_size,
  wallpattern_hole_spacing=default_wallpattern_hole_spacing,
  wallcutout_enabled=default_wallcutout_enabled,
  wallcutout_walls=default_wallcutout_walls,
  wallcutout_width=default_wallcutout_width,
  wallcutout_angle=default_wallcutout_angle,
  wallcutout_height=default_wallcutout_height,
  wallcutout_corner_radius=default_wallcutout_corner_radius,
  extention_enabled=[default_extention_x_enabled,default_extention_y_enabled],
  extention_tabs_enabled=default_extention_tabs_enabled,
  cutx=default_cutx,
  cuty=default_cuty,
  help) {
    
  irregular_cup(
    num_x = num_x,
    num_y = num_y,
    num_z = num_z,
    position=position,
    filled_in = filled_in,
    label_style=label_style,
    labelWidth=labelWidth,
    fingerslide=fingerslide,
    fingerslide_radius=fingerslide_radius,
    magnet_diameter=magnet_diameter,
    screw_depth=screw_depth,
    center_magnet_diameter = center_magnet_diameter,
    center_magnet_thickness = center_magnet_thickness,
    floor_thickness=floor_thickness,
    cavity_floor_radius=cavity_floor_radius,
    wall_thickness=wall_thickness,
    hole_overhang_remedy=hole_overhang_remedy,
    efficient_floor=efficient_floor,
    half_pitch=half_pitch,
    chamber_wall_thickness = chamber_wall_thickness,
    vertical_separator_bend_position = vertical_separator_bend_position,
    vertical_separator_bend_angle = vertical_separator_bend_angle,
    vertical_separator_bend_separation = vertical_separator_bend_separation,
    vertical_separator_cut_depth = vertical_separator_cut_depth,
    vertical_separator_positions = vertical_irregular_subdivisions 
      ? vertical_separator_config 
      : splitChamber(vertical_chambers-1, num_x),
    horizontal_separator_bend_position = horizontal_separator_bend_position,
    horizontal_separator_bend_angle = horizontal_separator_bend_angle,
    horizontal_separator_bend_separation = horizontal_separator_bend_separation,
    horizontal_separator_cut_depth = horizontal_separator_cut_depth,
    horizontal_separator_positions=horizontal_irregular_subdivisions 
      ? horizontal_separator_config 
      : splitChamber(horizontal_chambers-1, num_y),
    lip_style=lip_style, 
    box_corner_attachments_only=default_box_corner_attachments_only,
    flat_base=flat_base,
    tapered_corner=tapered_corner,
    tapered_corner_size=tapered_corner_size,
    tapered_setback=tapered_setback,
    wallpattern_enabled=wallpattern_enabled,
    wallpattern_hexgrid=wallpattern_hexgrid,
    wallpattern_fill=wallpattern_fill,
    wallpattern_walls=wallpattern_walls, 
    wallpattern_dividers_enabled = wallpattern_dividers_enabled,
    wallpattern_hole_sides=wallpattern_hole_sides,
    wallpattern_hole_size=wallpattern_hole_size,
    wallpattern_hole_spacing=wallpattern_hole_spacing,
    wallcutout_enabled=wallcutout_enabled,
    wallcutout_walls=wallcutout_walls,
    wallcutout_width=wallcutout_width,
    wallcutout_angle=wallcutout_angle,
    wallcutout_height=wallcutout_height,
    wallcutout_corner_radius=wallcutout_corner_radius,
    extention_enabled=extention_enabled,
    extention_tabs_enabled=extention_tabs_enabled,
    cutx=cutx,
    cuty=cuty,
    help = help);
}

// separator positions are defined in units from the left side
module irregular_cup(
  num_x,
  num_y,
  num_z,
  position=default_position,
  filled_in = default_filled_in,
  label_style=default_label_style,
  labelWidth=default_labelWidth,
  fingerslide=default_fingerslide,
  fingerslide_radius=default_fingerslide_radius,
  magnet_diameter=default_magnet_diameter,
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
  vertical_separator_bend_position = default_vertical_separator_bend_position,
  vertical_separator_bend_angle = default_vertical_separator_bend_angle,
  vertical_separator_bend_separation = default_vertical_separator_bend_separation,
  vertical_separator_cut_depth = default_vertical_separator_cut_depth,
  horizontal_separator_bend_position = default_horizontal_separator_bend_position,
  horizontal_separator_bend_angle = default_horizontal_separator_bend_angle,
  horizontal_separator_bend_separation = default_horizontal_separator_bend_separation,
  horizontal_separator_cut_depth = default_horizontal_separator_cut_depth,
  vertical_separator_positions = [],
  horizontal_separator_positions = [],
  lip_style=default_lip_style, 
  box_corner_attachments_only=default_box_corner_attachments_only,
  flat_base=default_flat_base,
  tapered_corner = default_tapered_corner,
  tapered_corner_size = default_tapered_corner_size,
  tapered_setback = default_tapered_setback,
  wallpattern_enabled=default_wallpattern_enabled,
  wallpattern_hexgrid=default_wallpattern_hexgrid,
  wallpattern_fill=default_wallpattern_fill,
  wallpattern_walls=default_wallpattern_walls, 
  wallpattern_dividers_enabled = default_wallpattern_dividers_enabled,
  wallpattern_hole_sides=default_wallpattern_hole_sides,
  wallpattern_hole_size=default_wallpattern_hole_size,
  wallpattern_hole_spacing=default_wallpattern_hole_spacing,
  wallcutout_enabled=default_wallcutout_enabled,
  wallcutout_walls=default_wallcutout_walls,
  wallcutout_width=default_wallcutout_width,
  wallcutout_angle=default_wallcutout_angle,
  wallcutout_height=default_wallcutout_height,
  wallcutout_corner_radius=default_wallcutout_corner_radius,
  extention_enabled=[default_extention_x_enabled,default_extention_y_enabled],
  extention_tabs_enabled=default_extention_tabs_enabled,
  cutx=default_cutx,
  cuty=default_cuty,
  help) {

  //If efficient_floor disable the base magnets and screws
  center_magnet_thickness = efficient_floor ? 0 : center_magnet_thickness;
  center_magnet_diameter = efficient_floor ? 0 : center_magnet_diameter;
  magnet_diameter = efficient_floor ? 0 : magnet_diameter;
  screw_depth = efficient_floor ? 0 : screw_depth;
  fingerslide = efficient_floor ? "none" : fingerslide;
  
  translate(cupPosition(position,num_x,num_y))
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
      stackable = filled_in!="notstackable",
      flat_base=flat_base);
      
    if(filled_in == "off") 
    union(){
      partitioned_cavity(
        num_x, num_y, num_z, 
        label_style=label_style,
        labelWidth=labelWidth, 
        fingerslide=fingerslide, 
        fingerslide_radius=fingerslide_radius, 
        magnet_diameter=magnet_diameter, 
        screw_depth=screw_depth, 
        floor_thickness=floor_thickness, 
        wall_thickness=wall_thickness,
        efficient_floor=efficient_floor, 
        half_pitch=half_pitch,
        chamber_wall_thickness=chamber_wall_thickness,
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
        flat_base=flat_base,
        spacer=spacer,
        cavity_floor_radius=cavity_floor_radius);
    
    color(color_wallcutout)
      union(){
        floorHeight = calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness);
        cfr = calcualteCavityFloorRadius(cavity_floor_radius, wall_thickness);
        z = gf_zpitch * num_z + gf_Lip_Height-0.6; //0.6 is needed to align the top of the cutout, need to fix this
        cutoutclearance = gf_cup_corner_radius/2;

        tapered_setback = tapered_setback < 0 ? gf_cup_corner_radius : tapered_setback;
        tapered_corner_size = 
              tapered_corner_size == -2 ? (z - floorHeight)/2
            : tapered_corner_size < 0 ? z - floorHeight //meant for -1, but also catch others
            : tapered_corner_size == 0 ? z - floorHeight - cfr
            : tapered_corner_size;
              
        wallcutout_thickness = wall_thickness*2+max(wall_thickness*2,cfr);//wall_thickness*2 should be lip thickness
        wallcutout_hgt = wallcutout_height < 0 
            ? z - floorHeight 
            : wallcutout_height == 0 ? z - floorHeight -cfr
            : wallcutout_height;
        wallcutout_front = [
          [(num_x-1)*gf_pitch/2, -gf_pitch/2+wallcutout_thickness/2, z],
          num_x*gf_pitch/3,
          [0,0,0]];
        wallcutout_back = [
          [(num_x-1)*gf_pitch/2, (num_y-0.5)*gf_pitch-wallcutout_thickness/2, z],
          num_x*gf_pitch/3,
          [0,0,0]];
        wallcutout_left = [[-gf_pitch/2+wallcutout_thickness/2, (num_y-1)*gf_pitch/2, z],
          num_y*gf_pitch/3,
          [0,0,90]];
        wallcutout_right = [
          [(num_x-0.5)*gf_pitch-wallcutout_thickness/2, (num_y-1)*gf_pitch/2, z],
          num_y*gf_pitch/3,
          [0,0,90]];
        
        wallcutout_locations = [wallcutout_front, wallcutout_back, wallcutout_left, wallcutout_right];
        
        if(tapered_corner == "rounded" || tapered_corner == "chamfered"){
          //tapered_corner_size = tapered_corner_size == 0 ? gf_zpitch*num_z/2 : tapered_corner_size;
          translate([
            -gf_pitch/2,
            -gf_pitch/2+tapered_setback+gf_tolerance,
            gf_zpitch*num_z+gf_Lip_Height-gf_tolerance])
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
        
        if(wallcutout_enabled){
          for(i = [0:1:len(wallcutout_locations)-1])
          {
            if(wallcutout_walls[i] > 0)
            {
              translate(wallcutout_locations[i][0])
              rotate(wallcutout_locations[i][2])
              WallCutout(
                lowerWidth=wallcutout_width <= 0 ? max(wallcutout_corner_radius*2, wallcutout_locations[i][1]) : wallcutout_width,
                wallAngle=wallcutout_angle,
                height=wallcutout_hgt,
                thickness=wallcutout_thickness,
                cornerRadius=wallcutout_corner_radius);
            }
          }
        }
        
        if(wallpattern_enabled){
          wallpattern_thickness = wall_thickness*2;
          border = gf_zpitch * (0.1);
          heightz = gf_zpitch * (num_z-1.2)-border*2 - floor_thickness - cfr + (
            lip_style == "reduced" ? 2.5 :
            lip_style == "none" ? 5 : 0);
          //z=floor_thickness+(gf_zpitch+0.5)+heightz/2;
          z=floorHeight+heightz/2+border+cfr;
          
          front = [
            //width,height
            [num_x*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,heightz],
            //Position
            [(num_x-1)*gf_pitch/2, -gf_pitch/2+wallpattern_thickness, z],
            //rotation
            [90,90,0]];
          back = [
            [num_x*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,heightz - (label_style != "disabled" ? 10 : 0)],
            //[(num_x-1)*gf_pitch/2, (num_y-0.5)*gf_pitch, (gf_zpitch+0.5)+(heightz - (label_style != "disabled" ? 10 : 0))/2],
            [(num_x-1)*gf_pitch/2, (num_y-0.5)*gf_pitch, z - (label_style != "disabled" ? 10 : 0)/2],
            [90,90,0]];
          left = [
            [num_y*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,heightz],
            [-gf_pitch/2, (num_y-1)*gf_pitch/2, z],
            [90,90,90]];
          right = [
            [num_y*gf_pitch-gf_cup_corner_radius*2-wallpattern_thickness,heightz],
            [(num_x-0.5)*gf_pitch-wallpattern_thickness, (num_y-1)*gf_pitch/2, z],
            [90,90,90]];

        if(wallpattern_dividers_enabled){
            dividerLocation = locations[2];
          difference(){
             separator_positions = calculateSeparators(vertical_separator_positions);
             //Add wall pattern to the separators 
             for (i=[0:len(separator_positions)-1]) {
                union(){
                translate([gf_pitch*(separator_positions[i])-wall_thickness, 0, fudgeFactor]) 
                translate(dividerLocation[1])
                rotate(dividerLocation[2])
                render(){
                GridItemHolder(
                  canvisSize = [dividerLocation[0][1],dividerLocation[0][0]], //Swap x and y and rotate so hex is easier to print
                  hexGrid = wallpattern_hexgrid,
                  customShape = false,
                  circleFn = wallpattern_hole_sides,
                  holeSize = [wallpattern_hole_size, wallpattern_hole_size],
                  holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
                  holeHeight = wallpattern_thickness,
                  center=true,
                  fill=wallpattern_fill, //"none", "space", "crop"
                  help=help);
                  }
                }
              }
              
              //Subtract setback from wall pattern
              if(tapered_corner == "rounded" || tapered_corner == "chamfered"){
                //tapered_corner_size = tapered_corner_size == 0 ? gf_zpitch*num_z/2 : tapered_corner_size;
                translate([
                  -gf_pitch/2-cutoutclearance,
                  -gf_pitch/2+tapered_setback+gf_tolerance+cutoutclearance,
                  gf_zpitch*num_z+gf_Lip_Height-gf_tolerance-cutoutclearance])
                rotate([270,0,0])
                union(){
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
          
          locations = [front, back, left, right];
          difference(){
            for(i = [0:1:len(locations)-1])
            {
              union(){
                if(wallpattern_walls[i] > 0)
                {
                  translate(locations[i][1])
                  rotate(locations[i][2])
                  render(){
                  GridItemHolder(
                    canvisSize = [locations[i][0][1],locations[i][0][0]], //Swap x and y and rotate so hex is easier to print
                    hexGrid = wallpattern_hexgrid,
                    customShape = false,
                    circleFn = wallpattern_hole_sides,
                    holeSize = [wallpattern_hole_size, wallpattern_hole_size],
                    holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
                    holeHeight = wallpattern_thickness,
                    center=true,
                    fill=wallpattern_fill, //"none", "space", "crop"
                    help=help);
                    }
                }
              }
            }
          
            //subtract dividers from wall pattern
            sepFloorHeight = (efficient_floor ? floor_thickness : floorHeight);
            translate([-gf_pitch/2, -gf_pitch/2, sepFloorHeight-fudgeFactor])
            separators(  
              length=gf_pitch*num_y,
              height=gf_zpitch*(num_z)-sepFloorHeight+fudgeFactor*2,
              wall_thickness = chamber_wall_thickness+cutoutclearance*2,
              bend_position = vertical_separator_bend_position,
              bend_angle = vertical_separator_bend_angle,
              bend_separation = vertical_separator_bend_separation,
              cut_depth = vertical_separator_cut_depth,
              seperator_config = vertical_separator_positions);

            translate([gf_pitch*num_x-gf_pitch/2, -gf_pitch/2, sepFloorHeight-fudgeFactor])
            rotate([0,0,90])
            separators(  
              length=gf_pitch*num_x,
              height=gf_zpitch*(num_z)-sepFloorHeight+fudgeFactor*2,
              wall_thickness = chamber_wall_thickness+cutoutclearance*2,
              bend_position = horizontal_separator_bend_position,
              bend_angle = horizontal_separator_bend_angle,
              bend_separation = horizontal_separator_bend_separation,
              cut_depth = horizontal_separator_cut_depth,
              seperator_config = horizontal_separator_positions);

              //Subtract cutout from wall pattern
            if(wallcutout_enabled){
              for(i = [0:1:len(wallcutout_locations)-1])
              {
                if(wallcutout_walls[i] > 0)
                {
                  translate(wallcutout_locations[i][0])
                  rotate(wallcutout_locations[i][2])
                  WallCutout(
                    lowerWidth=(wallcutout_width <= 0 ? max(wallcutout_corner_radius*2, wallcutout_locations[i][1]) : wallcutout_width)+cutoutclearance*2,
                    wallAngle=wallcutout_angle,
                    height=wallcutout_hgt+cutoutclearance,
                    thickness=wallcutout_thickness,
                    cornerRadius=wallcutout_corner_radius);
                }
              }
            }
          
            //Subtract setback from wall pattern
            if(tapered_corner == "rounded" || tapered_corner == "chamfered"){
              //tapered_corner_size = tapered_corner_size == 0 ? gf_zpitch*num_z/2 : tapered_corner_size;
              translate([
                -gf_pitch/2-cutoutclearance,
                -gf_pitch/2+tapered_setback+gf_tolerance+cutoutclearance,
                gf_zpitch*num_z+gf_Lip_Height-gf_tolerance-cutoutclearance])
              rotate([270,0,0])
              union(){
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
      }
    }
   
    if(extention_enabled.x){
     cutx = 0.5;
     color(color_wallcutout)
      translate([-gf_pitch*0.5,-gf_pitch*0.5,-fudgeFactor])
        cube([gf_pitch*cutx,num_y*gf_pitch,(num_z+1)*gf_zpitch]);
    }
    if(extention_enabled.y){
     cuty = 0.5;
     color(color_wallcutout)
      translate([-gf_pitch*0.5,-gf_pitch*0.5,-fudgeFactor])
        cube([gf_pitch*num_x,gf_pitch*cuty,(num_z+1)*gf_zpitch]);
    }
    
    if(cutx > 0 && $preview){
      color(color_cut)
      translate([-gf_pitch*0.5,-gf_pitch*0.5,-fudgeFactor])
        cube([gf_pitch*cutx,num_y*gf_pitch,(num_z+1)*gf_zpitch]);
    }
    if(cuty > 0 && $preview){
      color(color_cut)
      translate([-gf_pitch*0.5,-gf_pitch*0.5,-fudgeFactor])
        cube([num_x*gf_pitch,gf_pitch*cuty,(num_z+1)*gf_zpitch]);
    }
  }
  
  if((extention_enabled.x || extention_enabled.y) && extention_tabs_enabled){
    tabWorkingheight = (num_z-1)*gf_zpitch-gf_Lip_Height;
    tabHeight = tabWorkingheight/2;
    tabThickness = 2;
    cut = 0.5;
    if(extention_enabled.x){     
      translate([0,(num_y-0.5)*gf_pitch-wall_thickness-gf_tolerance/2,tabWorkingheight/4*3  + 1*gf_zpitch])
      rotate([0,180,90])
        attachement_clip(height=tabHeight,thickness=tabThickness);
    }
    if(extention_enabled.x && !extention_enabled.y){
      translate([0,-0.5*gf_pitch+wall_thickness+gf_tolerance/2,tabWorkingheight/4 + 1*gf_zpitch])
        rotate([0,0,90])
        attachement_clip(height=tabHeight,thickness=tabThickness);
    }
    if(extention_enabled.y){     
      translate([(num_x-0.5)*gf_pitch-wall_thickness-gf_tolerance/2,0,tabWorkingheight/4  + 1*gf_zpitch])
      rotate([0,0,180])
        attachement_clip(height=tabHeight,thickness=tabThickness);
    }
    if(extention_enabled.y && !extention_enabled.x){
      translate([-0.5*gf_pitch+wall_thickness+gf_tolerance/2,0,tabWorkingheight/4*3 + 1*gf_zpitch])
        rotate([0,180,180])
        attachement_clip(height=tabHeight,thickness=tabThickness);
    }
  }  
  
  if(help)
  ShowClippers(
    cutx, 
    cuty, 
    size=[num_x,num_y,num_z], 
    magnet_diameter, 
    screw_depth, 
    floor_thickness, 
    filled_in,
    wall_thickness); 
      
  HelpTxt("irregular_cup",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"position",position
    ,"filled_in",filled_in
    ,"label_style",label_style
    ,"labelWidth",labelWidth
    ,"fingerslide",fingerslide
    ,"fingerslide_radius",fingerslide_radius
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
    ,"box_corner_attachments_only",box_corner_attachments_only
    ,"flat_base",flat_base
    ,"tapered_corner",tapered_corner
    ,"tapered_corner_size",tapered_corner_size
    ,"tapered_setback",tapered_setback
    ,"wallpattern_enabled",wallpattern_enabled
    ,"wallpattern_hexgrid",wallpattern_hexgrid
    ,"wallpattern_walls",wallpattern_walls
    ,"wallpattern_hole_sides",wallpattern_hole_sides
    ,"wallpattern_hole_size",wallpattern_hole_size
    ,"wallpattern_hole_spacing",wallpattern_hole_spacing
    ,"wallcutout_enabled",wallcutout_enabled
    ,"wallpattern_fill",wallpattern_fill
    ,"wallcutout_walls",wallcutout_walls
    ,"wallcutout_width",wallcutout_width
    ,"wallcutout_angle",wallcutout_angle
    ,"wallcutout_height",wallcutout_height
    ,"wallcutout_corner_radius",wallcutout_corner_radius
    ,"extention_enabled",extention_enabled
    ,"extention_tabs_enabled",extention_tabs_enabled
    ,"cutx",cutx
    ,"cuty",cuty]
    ,help);  
}

module attachement_clip(
  height = 8,
  width = 0,
  thickness = 3)
{
  width = width > 0 ? width : height/2;
  tabHeight=height-thickness*2;
  tabDepth = min(tabHeight/2, width, 3.5);
  translate([0,0,-height/2])
  union()
  {
    //using hull prevents 
    hull()
    polyhedron
      (points = [
         [0, 0, 0],                                           //0
         [0, -width, 0],                                      //1
         [0, -width, height],                                 //2
         [0, 0, height],                                      //3
         [thickness, 0, thickness],                           //4
         [thickness, -width+thickness, thickness],            //5
         [thickness, -width+thickness, height-thickness],     //6
         [thickness, 0, height-thickness]                     //7
         ], 
       faces = [[0,1,2,3],[4,5,6,7]]
    );
    hull()
    polyhedron
      (points = [
         [0, 0, thickness],                                   //0
         [0, -width+thickness, thickness],                    //1
         [0, -width+thickness, height-thickness],             //2
         [0, 0, height-thickness],                            //3
         [0, tabDepth, height-thickness-tabDepth/2],          //4
         [0, tabDepth, thickness+tabDepth/2],                 //5
         [thickness, 0, thickness],                           //6
         [thickness, -width+thickness, thickness],            //7
         [thickness, -width+thickness, height-thickness],     //8
         [thickness, 0, height-thickness],                    //9
         [thickness, tabDepth, height-thickness-tabDepth/2],  //10
         [thickness, tabDepth, thickness+tabDepth/2]          //11
         ], 
         faces = [[0,1,2,3,4,5],[6,7,8,9,10,11]]
    );
  }
}


module partitioned_cavity(num_x, num_y, num_z, label_style=default_label_style, 
    labelWidth=default_labelWidth, fingerslide=default_fingerslide,  fingerslide_radius=default_fingerslide_radius,
    magnet_diameter=default_magnet_diameter, screw_depth=default_screw_depth, 
    floor_thickness=default_floor_thickness, wall_thickness=default_wall_thickness,
    efficient_floor=default_efficient_floor, half_pitch=default_half_pitch,         chamber_wall_thickness=default_chamber_wall_thickness,
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
    lip_style=default_lip_style, flat_base=default_flat_base, cavity_floor_radius=default_cavity_floor_radius,spacer=default_spacer) {
    
// height of partition between cells
  // cavity with removed segments so that we leave dividing walls behind
  outer_wall_th = 1.8;  // cavity is this far away from the 42mm 'ideal' block
  floorHeight = calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness);
  
  bar_d = 1.2;
  zpoint = gf_zpitch*num_z;
  
  yz = [[ (num_y-0.5)*gf_pitch-14, zpoint-bar_d/2 ],
    [ (num_y-0.5)*gf_pitch, zpoint-bar_d/2 ],
    [ (num_y-0.5)*gf_pitch, zpoint-bar_d/2-10.18 ]
  ];
  
  cavity_xsize = gf_pitch*num_x-2*outer_wall_th;

  difference() {
    color(color_cupcavity)
    basic_cavity(num_x, num_y, num_z, fingerslide=fingerslide, fingerslide_radius=fingerslide_radius, magnet_diameter=magnet_diameter,
      screw_depth=screw_depth, floor_thickness=floor_thickness, wall_thickness=wall_thickness,
      efficient_floor=efficient_floor, half_pitch=half_pitch, lip_style=lip_style, flat_base=flat_base, cavity_floor_radius=cavity_floor_radius, spacer=spacer);
  
    sepFloorHeight = (efficient_floor ? floor_thickness : floorHeight);
    color(color_divider)
    translate([-gf_pitch/2, -gf_pitch/2, sepFloorHeight-fudgeFactor])
    separators(  
      length=gf_pitch*num_y,
      height=gf_zpitch*(num_z)-sepFloorHeight+fudgeFactor*2,
      wall_thickness = chamber_wall_thickness,
      bend_position = vertical_separator_bend_position,
      bend_angle = vertical_separator_bend_angle,
      bend_separation = vertical_separator_bend_separation,
      cut_depth = vertical_separator_cut_depth,
      seperator_config = vertical_separator_positions);

    color(color_divider)
    translate([gf_pitch*num_x-gf_pitch/2, -gf_pitch/2, sepFloorHeight-fudgeFactor])
    rotate([0,0,90])
    separators(  
      length=gf_pitch*num_x,
      height=gf_zpitch*(num_z)-sepFloorHeight+fudgeFactor*2,
      wall_thickness = chamber_wall_thickness,
      bend_position = horizontal_separator_bend_position,
      bend_angle = horizontal_separator_bend_angle,
      bend_separation = horizontal_separator_bend_separation,
      cut_depth = horizontal_separator_cut_depth,
      seperator_config = horizontal_separator_positions);
    
    // this is the label
    if (label_style != "disabled") {
      separator_positions = calculateSeparators(vertical_separator_positions);
      // calcualte list of chambers. 
      labelWidthmm = labelWidth * gf_pitch;
      color(color_label){
        chamberWidths = len(separator_positions) < 1 || 
          labelWidthmm == 0 ||
          label_style == "left" ||
          label_style == "center" ||
          label_style == "right" ?
            [ num_x * gf_pitch ] // single chamber equal to the bin length
            : [ for (i=[0:len(separator_positions)]) 
              (i==len(separator_positions) 
                ? num_x * gf_pitch
                : separator_positions[i]) - (i==0 ? 0 : separator_positions[i-1]) ];

        for (i=[0:len(chamberWidths)-1]) {
          chamberStart = i == 0 ? 0 : separator_positions[i-1];
          chamberWidth = chamberWidths[i];
          label_num_x = (labelWidthmm == 0 || labelWidthmm > chamberWidth) ? chamberWidth : labelWidthmm;
          label_pos_x = (label_style == "center" || label_style == "centerchamber" )? (chamberWidth - label_num_x) / 2 
                          : (label_style == "right" || label_style == "rightchamber" )? chamberWidth - label_num_x 
                          : 0 ;
      
          hull() for (i=[0,1, 2])
          translate([(-gf_pitch/2) + ((chamberStart + label_pos_x)), yz[i][0], yz[i][1]])
          rotate([0, 90, 0])
          union(){
            tz(abs(label_num_x))
            sphere(d=bar_d, $fn=24);
            sphere(d=bar_d, $fn=24);
          }
        }
      }
    }
  }
}


module basic_cavity(num_x, num_y, num_z, fingerslide=default_fingerslide,  fingerslide_radius=default_fingerslide_radius,
    magnet_diameter=default_magnet_diameter, screw_depth=default_screw_depth, 
    floor_thickness=default_floor_thickness, wall_thickness=default_wall_thickness,
    efficient_floor=default_efficient_floor, half_pitch=default_half_pitch, 
    lip_style=default_lip_style, flat_base=default_flat_base, cavity_floor_radius=default_cavity_floor_radius, spacer=default_spacer) {
  
  seventeen = gf_pitch/2-4;
    
  reducedlipstyle = 
    // replace "reduced" with "none" if z-height is less than 1.2
    (num_z < 1.2) ? "none" 
    // replace with "reduced" if z-height is less than 1.8
    : (num_z < 1.8) ? "reduced" 
    : lip_style;

  filledInZ = gf_zpitch*num_z;
  floorht = min(filledInZ,calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness));

  //Efficient floor
  efloor = efficient_floor && magnet_diameter == 0 && screw_depth == 0 && fingerslide == "none";
  //Remove floor to create a vertical spacer.
  nofloor = spacer && fingerslide == "none";
  
  //Difference between the wall and support thickness
  lipSupportThickness = reducedlipstyle == "none" ? 0
    : reducedlipstyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;

  //bottom of the lip where it touches the wall
  lipBottomZ = (reducedlipstyle == "none" ? gf_zpitch*num_z
    : reducedlipstyle == "reduced" ? gf_zpitch*num_z
    : gf_zpitch*num_z-gf_lip_height-lipSupportThickness); 
  
  innerLipRadius = gf_cup_corner_radius-gf_lip_lower_taper_height-gf_lip_upper_taper_height; //1.15
  innerWallRadius = gf_cup_corner_radius-wall_thickness;
  
  cavityHeight= max(lipBottomZ-floorht,0);
  cavity_floor_radius = efloor ? 0 : calcualteCavityFloorRadius(cavity_floor_radius, wall_thickness);
  
    
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // arount the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  
  if(filledInZ>floorht) {
    difference() {
    union() {
      if (reducedlipstyle == "none") {
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
    
    // rounded inside bottom
    if(fingerslide != "none"){
      translate([0, 
            reducedlipstyle == "reduced" ? - gf_lip_lower_taper_height
            : reducedlipstyle =="none" ? seventeen+1.15-gf_pitch/2+0.25+wall_thickness
            : 0, 0])
        translate([-(gf_pitch/2),-seventeen-1.15, floorht])
          union(){
            if(fingerslide == "rounded"){
              roundedCorner(
                radius = fingerslide_radius, 
                length=gf_pitch*num_x, 
                height = gf_zpitch*num_z);
            }
            else if(fingerslide == "chamfered"){
              chamferedCorner(
                chamferLength = fingerslide_radius, 
                length=gf_pitch*num_x,
                height = gf_zpitch*num_z);
          }
        }
      }
    }
  }
  
  // cut away side lips if num_x is less than 1
  if (num_x < 1) {
    height =num_z*2.5;
    top = num_z*gf_zpitch+gf_Lip_Height;
    hull() 
    for (x=[-gf_pitch/2+1.5+0.25+wall_thickness, -gf_pitch/2+num_x*gf_pitch-1.5-0.25-wall_thickness]){
      for (y=[-10, (num_y-0.5)*gf_pitch-seventeen])
      translate([x, y, top-height])
      cylinder(d=3, h=height, $fn=24);
    }
  }
 
  if (efloor || nofloor) {
    if (num_x < 1) {
      gridcopy(1, num_y) {
        tz(floor_thickness) intersection() {
          hull() cornercopy(seventeen-0.5) cylinder(r=1, h=5, $fn=32);
          translate([gf_pitch*(-1+num_x), 0, 0]) hull() cornercopy(seventeen-0.5) cylinder(r=1, h=5, $fn=32);
        }
      
        // tapered top portion
        intersection() {
          hull() {
            tz(3) cornercopy(seventeen-0.5) cylinder(r=1, h=1, $fn=32);
            tz(5) cornercopy(seventeen+2.5-1.15-q) cylinder(r=1.15+q, h=4, $fn=32);
          }
          translate([gf_pitch*(-1+num_x), 0, 0]) hull() {
            tz(3) cornercopy(seventeen-0.5) cylinder(r=1, h=1, $fn=32);
            tz(5) cornercopy(seventeen+2.5-1.15-q) cylinder(r=1.15+q, h=4, $fn=32);
          }
        }
      }
    } else if (nofloor) {
      tz(-fudgeFactor)
        hull()
        cornercopy(num_x=num_x, num_y=num_y, r=seventeen) 
        cylinder(r=2, h=gf_cupbase_lower_taper_height+fudgeFactor, $fn=32);
      gridcopy(1, 1) 
        EfficientFloor(num_x, num_y,-fudgeFactor, q);
    } else if (flat_base) {
      gridcopy(1, 1) 
        EfficientFloor(num_x, num_y,floor_thickness, q);
    } else if (half_pitch) {
      gridcopy(num_x*2, num_y*2, gf_pitch/2) 
        EfficientFloor(0.5, 0.5,floor_thickness, q);
    } else {
      gridcopy(num_x, num_y) 
        EfficientFloor(1, 1, floor_thickness, q);
    }
  }
}

function calculateSeparators(seperator_config) = 
  is_string(seperator_config) ? [] : 
  is_list(seperator_config) ? seperator_config : [];

module separators(  
  length,
  height,
  wall_thickness = 0,
  bend_position = 0,
  bend_angle = 0,
  bend_separation = 0,
  cut_depth = 0,
  seperator_config = [])
{
  if(is_string(seperator_config))
  {
    //echo(separators="custom",seperator_config = splitCustomConfig(seperator_config),length=length,height=height,wall_thickness=wall_thickness);
    //Non custom components
    separators = split(seperator_config, "|");
    for (i =[0:1:len(separators)-1])
    {
      sep = csv_parse(separators[i]);
      if(is_list(sep) && len(sep)>0)
      {
        translate([sep[0]-wall_thickness/2,0,0])
        bentWall(
          length=length,
          bendPosition=bend_position,
          separation=len(sep) >= 2 ? sep[1] : bend_separation,
          bendAngle=len(sep) >= 3 ? sep[2] : bend_angle*(i%2==1?1:-1),
          height=height,
          wall_cutout_depth = len(sep) >= 4 ? sep[3] : cut_depth,
          wall_cutout_width = len(sep) >= 5 ? sep[4] : 0,
          thickness=len(sep) >= 6 ? sep[5] : wall_thickness);
        }
     }
  }
  else if(is_list(seperator_config) && len(seperator_config) > 0){
    for (i=[0:len(seperator_config)-1]) {
     translate([seperator_config[i]-wall_thickness/2,0,0])
     bentWall(
       length=length,
       bendPosition=bend_position,
       bendAngle=bend_angle*(i%2==1?1:-1),
       separation=bend_separation,
       lowerBendRadius=bend_separation/2,
       upperBendRadius=bend_separation/2,
       height=height,
       wall_cutout_depth = cut_depth,
       thickness=wall_thickness);
    }
  }
  else {
    echo(separators="unknown or null",seperator_config=seperator_config);
  }
}


module EfficientFloor(num_x=1, num_y=1, floor_thickness, margins=0){
  seventeen = gf_pitch/2-4;
  
  union(){
    // establishes floor
    hull() 
      tz(floor_thickness) 
      cornercopy(num_x=num_x, num_y=num_y, r=seventeen-0.5) 
      cylinder(r=1, h=5, $fn=32);

    // tapered top portion
    hull() {
      tz(3) 
      cornercopy(num_x=num_x, num_y=num_y, r=seventeen-0.5) 
      cylinder(r=1, h=1, $fn=32);
      
      tz(5-(+2.5-1.15-margins)) 
      cornercopy(num_x=num_x, num_y=num_y, r=seventeen) 
      cylinder(r=1.15+margins, h=4, $fn=32);
    }
  }
}
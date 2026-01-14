use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity_block.scad>
include <modules/gridfinity_constants.scad>
include <modules/functions_general.scad>
include <modules/module_gridfinity_cup_base.scad>

/*<!!start gridfinity_tray!!>*/
/* [Tray] */
tray_corner_radius = 2;

//Height above the base height
tray_zpos = 0;
tray_magnet_radius = 5;
tray_magnet_thickness = 5;
tray_spacing = 2; //0.1
tray_vertical_compartments = 1;
tray_horizontal_compartments = 1;
/*
xpos,ypos,xsize,ysize,radius,depth. 
dimensions of the tray cutout, a string with comma separated values, and pipe (|) separated trays.
 - xpos, ypos, the x/y position in gridfinity units.
 - xsize, ysize. the x/y size in gridfinity units. 
 - radius, [optional] corner radius in mm.
 - depth, [optional] depth in mm
 - example "0,0,2,1|2,0,2,1,2,5"
*/
//[[xpos,ypos,xsize,ysize,radius,depth]]. xpos, ypos, the x/y position in gridfinity units.xsize, ysize. the x/y size in gridfinity units. radius, [optional] corner radius in mm.depth, [optional] depth in mm\nexample "0,0,2,1|2,0,2,1,2,5"
tray_custom_compartments = "0, 0, 0.5, 3, 2, 6|0.5, 0, 0.5, 3,2, 6|1, 0, 3, 1.5|1, 1.5, 3, 1.5";

// Debug, Color Compartments
tray_color_compartments = false;
// Debug, Highlight Compartments
tray_highlight_compartments = false;

/*<!!end gridfinity_tray!!>*/

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [4, 0]; //0.5
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [3, 0]; //0.5
// Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [3, 0]; //0.1
// Fill in solid block (overrides all following options)
filled_in = true; 
// Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
// Remove some or all of lip
position = "center"; //[default,center,zero]
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
flat_base = "off";//[off,gridfinity,rounded]
// Remove floor to create a vertical spacer
spacer = false;

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

/* [Finger Slide] */
// Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// Radius of the corner fillet, 0:none, >1: radius in mm, <0 dimention/abs(n) (i.e. -3 is 1/3 the width)
fingerslide_radius = -3;
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

/* [Wall Cutout] */
wallcutout_vertical ="disabled"; //[disabled, enabled, inneronly, wallsonly, frontonly, backonly]
// wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=[-2,-0.5,-0.5,-0.5];  //0.01
//default will be binwidth/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
//default will be binHeight. 0: radius, -1 floor, Positive: depth from top; Negative: ratio height/abs(value)
wallcutout_vertical_height=0;
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, inneronly, wallsonly, leftonly, rightonly]
// wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=[-2,-0.5,-0.5,-0.5];  //0.01
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

/* [debug] */
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
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
fs = 0.1; 
// number of fragments, overrides $fa and $fs
fn = 0;  
// set random seed for 
random_seed = 0; //0.0001
/*<!!end gridfinity_basic_cup!!>*/

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;  

//Index for custom config arrays
ixPos = 0;
iyPos = 1;
ixSize = 2;
iySize = 3;
iCornerRadius = 4;
iDepth = 5;

// module to build the tray cutouts
// This is what will be executed by external scripts
module tray(
  num_x=1, 
  num_y=2, 
  num_z, 
  cornerRadius, 
  trayZpos, 
  spacing,
  cutoutSize, 
  baseHeight,
  floorThickness,
  wallThickness,
  verticalCompartments = 1,
  horizontalCompartments = 1,
  customCompartments = "",
  tray_color_compartments = false
  ) 
{

  cellSpacing = spacing/2;

  verticalCompartments = verticalCompartments > 0 ? verticalCompartments : num_x ;
  horizontalCompartments = horizontalCompartments > 0 ? horizontalCompartments : num_y;
  //todo, this could be simplified, by to produce a single array for ether scenario.
  if(len(customCompartments) == 0)
  {
    //Non custom components
    if(env_help_enabled("trace")) echo(n=num_x*env_pitch().x-(verticalCompartments+1)*spacing,d=verticalCompartments);
    xSize = (num_x*env_pitch().x-(verticalCompartments+1)*spacing)/verticalCompartments;
    xStep = xSize + spacing;
    ySize = (num_y*env_pitch().y-(horizontalCompartments+1)*spacing)/horizontalCompartments;
    yStep = ySize + spacing;
    
    for(x =[0:1:verticalCompartments-1])
    {
      for(y =[0:1:horizontalCompartments-1])
      {
        if(env_help_enabled("trace")) echo(x=x,y=y,xStep=xStep,yStep=yStep);
        translate([spacing+x*xStep,spacing+y*yStep,baseHeight+max(trayZpos,floorThickness)])
        roundedCube(
            xSize, ySize,
            num_z*env_pitch().z,
            bottomRadius = cornerRadius,
            sideRadius = cornerRadius);
      }
    }
  }
  else
  {
    if(env_help_enabled("debug")) echo(customCompartments = splitCustomConfig(customCompartments));
    //custom components
    compartments = split(customCompartments, "|");
    
    scl = [
      (num_x*env_pitch().x-cellSpacing*2)/(num_x*env_pitch().x),
      (num_y*env_pitch().y-cellSpacing*2)/(num_y*env_pitch().y),1];
    translate([cellSpacing,cellSpacing,0])
    scale(scl)
    union()
      for (x =[0:1:len(compartments)-1])
      {
          comp =csv_parse(compartments[x]);
          xpos = get_related_value(comp[ixPos],num_x,0);
          ypos = get_related_value(comp[iyPos],num_y,0);
          xsize = get_related_value(comp[ixSize],num_x,0);
          ysize = get_related_value(comp[iySize],num_y,0);
          radius = len(comp) >= 5 
            ? get_related_value(comp[iCornerRadius], cornerRadius, 0) 
            : cornerRadius;
          depth = let(
            bin_top = num_z*env_pitch().z,
            min_depth = max(trayZpos,floorThickness),
            user_selected = (len(comp) >= 6 ? comp[iDepth] : min_depth))
            baseHeight+get_related_value(user_selected, bin_top, bin_top);

          echo("tray", xpos=xpos, ypos=ypos, xsize=xsize, ysize=ysize, radius=radius, depth=depth);
          color_conditional(tray_color_compartments && $preview, color_from_list(x), 1)
          translate([cellSpacing+xpos*env_pitch().x,cellSpacing+ypos*env_pitch().y,depth])
          roundedCube(
              xsize*env_pitch().x-cellSpacing*2,
              ysize*env_pitch().y-cellSpacing*2,
              //Added 5, as I need to deal with the lip overhang
              num_z*env_pitch().z-depth+fudgeFactor+5,
              bottomRadius = radius,
              sideRadius = radius);
    }
  }
}

// Generates the gridfinity bin with cutouts.
// Runs the function without needing to pass the variables.
module gridfinity_tray(
  //tray settings
  tray_spacing = tray_spacing,
  tray_corner_radius = tray_corner_radius, 
  tray_zpos = tray_zpos, 
  tray_vertical_compartments = tray_vertical_compartments,
  tray_horizontal_compartments = tray_horizontal_compartments,
  tray_custom_compartments = tray_custom_compartments,
  tray_highlight_compartments=tray_highlight_compartments,
  tray_color_compartments=tray_color_compartments,
  //gridfinity settings
  width=width, depth=depth, height=height,
  position=position,
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
    magnetSize = magnet_size, 
    magnetEasyRelease = magnet_easy_release, 
    centerMagnetSize = center_magnet_size, 
    screwSize = screw_size, 
    holeOverhangRemedy = hole_overhang_remedy, 
    cornerAttachmentsOnly = box_corner_attachments_only,
    floorThickness = floor_thickness,
    cavityFloorRadius = cavity_floor_radius,
    efficientFloor=efficient_floor,
    halfPitch=half_pitch,
    flatBase=flat_base,
    spacer=spacer),
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
  half_pitch=half_pitch,
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
  cutx=cutx,
  cuty=cuty,
  help=enable_help) {
  
  num_x = calcDimensionWidth(width);
  num_y = calcDimensionDepth(depth);
  num_z = calcDimensionHeight(height);
  
  if(env_help_enabled("info")) echo("gridfinity_tray", num_x=num_x, num_y=num_y, num_z=num_z);
  
  difference() {
    /*<!!start gridfinity_basic_cup!!>*/
    gridfinity_cup(
      width=width, depth=depth, height=height,
      filled_in=filled_in,
      label_settings=label_settings,
      cupBase_settings = cupBase_settings,
      finger_slide_settings=finger_slide_settings,
      wall_thickness=wall_thickness,
      vertical_chambers = vertical_chambers,
      horizontal_chambers=horizontal_chambers,
      lip_settings=lip_settings,
      headroom=headroom,
      tapered_corner=tapered_corner,
      tapered_corner_size = tapered_corner_size,
      tapered_setback = tapered_setback,
      wallpattern_walls=wallpattern_walls, 
      wallpattern_dividers_enabled=wallpattern_dividers_enabled,
      wall_pattern_settings = wall_pattern_settings, 
      wallcutout_vertical_settings = wallcutout_vertical_settings,
      wallcutout_horizontal_settings = wallcutout_horizontal_settings,
      extendable_Settings = ExtendableSettings(
        extendablexEnabled = extension_x_enabled, 
        extendablexPosition = extension_x_position, 
        extendableyEnabled = extension_y_enabled, 
        extendableyPosition = extension_y_position, 
        extendableTabsEnabled = extension_tabs_enabled, 
        extendableTabSize = extension_tab_size));
    /*<!!end gridfinity_basic_cup!!>*/

    highlight_conditional(tray_highlight_compartments && $preview)
    tray(
      num_x = num_x,
      num_y = num_y,
      num_z = num_z, 
      floorThickness = floor_thickness,
      wallThickness = wall_thickness,
      spacing = tray_spacing,
      cornerRadius = tray_corner_radius, 
      trayZpos = tray_zpos, 
      baseHeight = cupBaseClearanceHeight(
                    magnet_size[iCylinderDimension_Height], 
                    screw_size[iCylinderDimension_Height],
                    center_magnet_size[iCylinderDimension_Height]),
      verticalCompartments = tray_vertical_compartments,
      horizontalCompartments = tray_horizontal_compartments,
      customCompartments = tray_custom_compartments,
      tray_color_compartments=tray_color_compartments);
      
      //This seems like a complicated way to do this, but it guarantees order will be correct.
      configArray = [
        [ixPos, 0], 
        [iyPos, 0], 
        [ixSize, num_z], 
        [iySize, num_x], 
        [iCornerRadius, tray_corner_radius], 
        [iDepth, num_z]];

      if(env_help_enabled("info")) echo(outputCustomConfig("tray", replace_Items(configArray, [])));
  }
}

set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  cut = [cutx, cuty, 0],
  randomSeed = random_seed)
gridfinity_tray();
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity.scad>
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
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
position = "center"; //[default,center,zero]
//under size the bin top by this amount to allow for better stacking
zClearance = 0; // 0.1

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
flat_base = false;
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
wallpattern_style = "gridrotated"; //[grid, gridrotated, hexgrid, hexgridrotated, voronoi, voronoigrid, voronoihexgrid, brick, brickrotated, brickoffset, brickoffsetrotated]
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both] 
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = [5,5]; //0.1
//Radius of corners
wallpattern_hole_radius = 0.5;
// pattern fill mode
wallpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
//voronoi: noise, brick: center weight, grid: taper
wallpattern_pattern_variable = 0.75;
//$fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [Wall Cutout] */
wallcutout_vertical ="disabled"; //[disabled, enabled, wallsonly, frontonly, backonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=-2;  //0.1
//default will be bin width/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
//default will be binHeight
wallcutout_vertical_height=0;
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, wallsonly, leftonly, rightonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=-2;  //0.1
//default will be bin width/2
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
  customCompartments = "") 
{

  cellSpacing = spacing/2;
  
  verticalCompartments = verticalCompartments > 0 ? verticalCompartments : num_x ;
  horizontalCompartments = horizontalCompartments > 0 ? horizontalCompartments : num_y;
  //todo, this could be simplified, by to produce a single array for ether scenario.
  if(len(customCompartments) == 0)
  {
    //Non custom components
    if(env_help_enabled("trace")) echo(n=num_x*gf_pitch-(verticalCompartments+1)*spacing,d=verticalCompartments);
    xSize = (num_x*gf_pitch-(verticalCompartments+1)*spacing)/verticalCompartments;
    xStep = xSize + spacing;
    ySize = (num_y*gf_pitch-(horizontalCompartments+1)*spacing)/horizontalCompartments;
    yStep = ySize + spacing;
    
    for(x =[0:1:verticalCompartments-1])
    {
      for(y =[0:1:horizontalCompartments-1])
      {
        if(env_help_enabled("trace")) echo(x=x,y=y,xStep=xStep,yStep=yStep);
        translate([spacing+x*xStep,spacing+y*yStep,baseHeight+max(trayZpos,floorThickness)])
        roundedCube(
            xSize, ySize,
            num_z*gf_zpitch,
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
      (num_x*gf_pitch-cellSpacing*2)/(num_x*gf_pitch),
      (num_y*gf_pitch-cellSpacing*2)/(num_y*gf_pitch),1];
    translate([cellSpacing,cellSpacing,0])
    scale(scl)
    union()
      for (x =[0:1:len(compartments)-1])
      {
          comp =csv_parse(compartments[x]);
          xpos = comp[ixPos];
          ypos = comp[iyPos];
          xsize = comp[ixSize];
          ysize = comp[iySize];
          radius = len(comp) >= 5 ? comp[iCornerRadius] : cornerRadius;
          depth = baseHeight+(len(comp) >= 6 ? comp[iDepth] : max(trayZpos,floorThickness));
        
          translate([cellSpacing+xpos*gf_pitch,cellSpacing+ypos*gf_pitch,depth])
          roundedCube(
              xsize*gf_pitch-cellSpacing*2,
              ysize*gf_pitch-cellSpacing*2,
              //Added 5, as I need to deal with the lip overhang
              num_z*gf_zpitch-depth+fudgeFactor+5,
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
  fingerslide=fingerslide,
  fingerslide_radius=fingerslide_radius,
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
  chamber_wall_thickness=chamber_wall_thickness,
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
  half_pitch=half_pitch,
  lip_style=lip_style,
  zClearance=zClearance,
  tapered_corner=tapered_corner,
  tapered_corner_size = tapered_corner_size,
  tapered_setback = tapered_setback,
  wallpattern_enabled=wallpattern_enabled,
  wallpattern_style=wallpattern_style,
  wallpattern_walls=wallpattern_walls, 
  wallpattern_dividers_enabled=wallpattern_dividers_enabled,
  wallpattern_hole_sides=wallpattern_hole_sides,
  wallpattern_hole_size=wallpattern_hole_size, 
  wallpattern_hole_radius = wallpattern_hole_radius,
  wallpattern_hole_spacing=wallpattern_hole_spacing,
  wallpattern_fill=wallpattern_fill,
  wallpattern_pattern_variable=wallpattern_pattern_variable,
  wallcutout_vertical=wallcutout_vertical,
  wallcutout_vertical_position=wallcutout_vertical_position,
  wallcutout_vertical_width=wallcutout_vertical_width,
  wallcutout_vertical_angle=wallcutout_vertical_angle,
  wallcutout_vertical_height=wallcutout_vertical_height,
  wallcutout_vertical_corner_radius=wallcutout_vertical_corner_radius,
  wallcutout_horizontal=wallcutout_horizontal,
  wallcutout_horizontal_position=wallcutout_horizontal_position,
  wallcutout_horizontal_width=wallcutout_horizontal_width,
  wallcutout_horizontal_angle=wallcutout_horizontal_angle,
  wallcutout_horizontal_height=wallcutout_horizontal_height,
  wallcutout_horizontal_corner_radius=wallcutout_horizontal_corner_radius,
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
      fingerslide_radius=fingerslide_radius,
      wall_thickness=wall_thickness,
      chamber_wall_thickness=chamber_wall_thickness,
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
      lip_style=lip_style,
      zClearance=zClearance,
      tapered_corner=tapered_corner,
      tapered_corner_size = tapered_corner_size,
      tapered_setback = tapered_setback,
      wallpattern_walls=wallpattern_walls, 
      wallpattern_dividers_enabled=wallpattern_dividers_enabled,
      wall_pattern_settings = PatternSettings(
        patternEnabled = wallpattern_enabled, 
        patternStyle = wallpattern_style, 
        patternFill = wallpattern_fill,
        patternBorder = wallpattern_hole_spacing, 
        patternHoleSize = wallpattern_hole_size, 
        patternHoleSides = wallpattern_hole_sides,
        patternHoleSpacing = wallpattern_hole_spacing, 
        patternHoleRadius = wallpattern_hole_radius,
        patternVariable = wallpattern_pattern_variable,
        patternFs = wallpattern_pattern_quality), 
      wallcutout_vertical=wallcutout_vertical,
      wallcutout_vertical_position=wallcutout_vertical_position,
      wallcutout_vertical_width=wallcutout_vertical_width,
      wallcutout_vertical_angle=wallcutout_vertical_angle,
      wallcutout_vertical_height=wallcutout_vertical_height,
      wallcutout_vertical_corner_radius=wallcutout_vertical_corner_radius,
      wallcutout_horizontal=wallcutout_horizontal,
      wallcutout_horizontal_position=wallcutout_horizontal_position,
      wallcutout_horizontal_width=wallcutout_horizontal_width,
      wallcutout_horizontal_angle=wallcutout_horizontal_angle,
      wallcutout_horizontal_height=wallcutout_horizontal_height,
      wallcutout_horizontal_corner_radius=wallcutout_horizontal_corner_radius,
      extendable_Settings = ExtendableSettings(
        extendablexEnabled = extension_x_enabled, 
        extendablexPosition = extension_x_position, 
        extendableyEnabled = extension_y_enabled, 
        extendableyPosition = extension_y_position, 
        extendableTabsEnabled = extension_tabs_enabled, 
        extendableTabSize = extension_tab_size));
    /*<!!end gridfinity_basic_cup!!>*/

    tray(
      num_x = num_x,
      num_y = num_y,
      num_z = num_z, 
      floorThickness = floor_thickness,
      wallThickness = wall_thickness,
      spacing = tray_spacing,
      cornerRadius = tray_corner_radius, 
      trayZpos = tray_zpos, 
      baseHeight = cupBaseClearanceHeight(magnet_size[iCylinderDimension_Height], screw_size[iCylinderDimension_Height]),
      verticalCompartments = tray_vertical_compartments,
      horizontalCompartments = tray_horizontal_compartments,
      customCompartments = tray_custom_compartments);
      
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
  cut = [cutx, cuty, calcDimensionHeight(height, true)],
  randomSeed = random_seed)
gridfinity_tray();
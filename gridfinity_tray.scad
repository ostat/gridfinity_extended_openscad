use <modules/gridfinity_cup_modules.scad>
include <modules/gridfinity_constants.scad>
include <modules/functions_general.scad>

/*<!!start gridfinity_tray!!>*/
/* [Tray] */
tray_corner_radius = 2;

//Height above the base height
tray_zpos = 0;
tray_magnet_radius = 5;
tray_magnet_thickness = 5;
tray_spacing = 3;
tray_vertical_compartments = 1;
tray_horizontal_compartments = 1;

/*
xpos,ypos,xsize,ysize,radius,depth. 
dimensions of the tray cutout, a string with comma separated values, and pipe (|) separated trays.
 - xpos, ypos, the x/y position in gridinity units.
 - xsize, ysize. the x/y size in gridinity units. 
 - radius, [optional] corner radius in mm.
 - depth, [optional] depth in mm
 - example "0,0,2,1|2,0,2,1,2,5"
*/
//[[xpos,ypos,xsize,ysize,radius,depth]]. xpos, ypos, the x/y position in gridinity units.xsize, ysize. the x/y size in gridinity units. radius, [optional] corner radius in mm.depth, [optional] depth in mm\nexample "0,0,2,1|2,0,2,1,2,5"
tray_custom_compartments = "0, 0, 0.5, 3, 2, 6|0.5, 0, 0.5, 3,2, 6|1, 0, 3, 1.5|1, 1.5, 3, 1.5";
/*<!!end gridfinity_tray!!>*/

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X dimension in grid units  (multiples of 42mm)
width = 4; // [ 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Y dimension in grid units (multiples of 42mm)
depth = 3; // [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Z dimension (multiples of 7mm)
height = 3; //0.1
// Fill in solid block (overrides all following options)
filled_in = "notstackable"; //["off","on","notstackable"]
// Include overhang for labeling (and specify left/right/center justification)
label = "disabled"; // ["disabled", "left", "right", "center", "leftchamber", "rightchamber", "centerchamber"]
// Width of the label in number of units, or zero means full width
label_width = 0;  // .01
// Wall thickness (Zack's design is 0.95)
wall_thickness = 0.95;  // .01
// Remove some or all of lip
lip_style = "normal";  // [ "normal", "reduced", "none" ]
position="default"; //["default","center","zero"]

/* [Subdivisions] */
// X dimension subdivisions
chambers = 1;
// Enable irregular subdivisions
irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
separator_positions = [ 0.25, 0.5, 1, 1.33, 1.66];

/* [Base] */
// (Zack's design uses magnet diameter of 6.5)
magnet_diameter = 0;  // .1
// (Zack's design uses depth of 6)
screw_depth = 0;
center_magnet_diameter = 0;
center_magnet_thickness = 0;
// Hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = true;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = false;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat (only applies if no magnets, screws, or finger-slide used)
efficient_floor = false;
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = false;

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

/* [Wall Pattern] */
// Grid wall pattern
wallpattern_enabled=false;
// set the grid as hex or square
wallpattern_hexgrid = true;
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1]; 
// pattern fill mode
wallpattern_fill = "none"; //["none":No fill, "space":Increase Space, "crop":Over fill and crop]
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = 5; //0.1
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1

/* [debug] */
//Slice along the x axis
cutx = false;
//Slice along the y axis
cuty = false;
// enable loging of help messages during render.
help = false;
/*<!!end gridfinity_basic_cup!!>*/

module end_of_customizer_opts() {}
/* [Hidden] */

//Index for custom config arrays
ixpos = 0;
iypos = 1;
ixsize = 2;
iysize = 3;
icornerradius = 4;
idepth = 5;

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
  cutoutSize = gridfinity_pitch - spacing*2;

  verticalCompartments = verticalCompartments > 0 ? verticalCompartments : num_x ;
  horizontalCompartments = horizontalCompartments > 0 ? horizontalCompartments : num_y;
  //todo, this could be simplified, by to produce a single array for ether scenario.
  if(len(customCompartments) == 0)
  {
    //Non custom components
    //echo(n=num_x*gridfinity_pitch-(verticalCompartments+1)*spacing,d=verticalCompartments);
    xSize = (num_x*gridfinity_pitch-(verticalCompartments+1)*spacing)/verticalCompartments;
    xStep = xSize + spacing;
    ySize = (num_y*gridfinity_pitch-(horizontalCompartments+1)*spacing)/horizontalCompartments;
    yStep = ySize + spacing;
    
    for(x =[0:1:verticalCompartments-1])
    {
      for(y =[0:1:horizontalCompartments-1])
      {
        //echo(x=x,y=y,xStep=xStep,yStep=yStep);
        translate([spacing+x*xStep,spacing+y*yStep,baseHeight+trayZpos])
        roundedCube(
            xSize, ySize,
            height*gridfinity_zpitch,cornerRadius);
      }
    }
  }
  else
  {
    echo(customCompartments = splitCustomConfig(customCompartments));
    //Non custom components
    compartments = split(customCompartments, "|");
    for (x =[0:1:len(compartments)-1])
    {
        comp =csv_parse(compartments[x]);
        //echo(comp=comp);
        xpos = comp[ixpos];
        ypos = comp[iypos];
        xsize = comp[ixsize];
        ysize = comp[iysize];
        radius = len(comp) >= 5 ? comp[icornerradius] : cornerRadius;
        depth = baseHeight+(len(comp) >= 6 ? comp[idepth] : trayZpos);
      
        translate([spacing+xpos*gridfinity_pitch,spacing+ypos*gridfinity_pitch,depth])
        roundedCube(
            min(1,xsize)*cutoutSize+max(0,xsize-1)*gridfinity_pitch,
            min(1,ysize)*cutoutSize+max(0,ysize-1)*gridfinity_pitch,
            height*gridfinity_zpitch,radius);
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
  width = width,
  depth = depth,
  height = height,
  position=position,
  filled_in = filled_in,
  label=label,
  label_width=label_width,
  wall_thickness=wall_thickness,
  lip_style=lip_style,
  chambers=chambers,
  irregular_subdivisions=irregular_subdivisions,
  separator_positions=separator_positions,
  magnet_diameter=magnet_diameter,
  screw_depth=screw_depth,
  center_magnet_diameter = center_magnet_diameter,
  center_magnet_thickness = center_magnet_thickness,
  hole_overhang_remedy=hole_overhang_remedy,
  box_corner_attachments_only=box_corner_attachments_only,
  floor_thickness=floor_thickness,
  cavity_floor_radius=cavity_floor_radius,
  efficient_floor=efficient_floor,
  half_pitch=half_pitch,
  flat_base=flat_base,
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
  wallpattern_hexgrid=wallpattern_hexgrid,
  wallpattern_walls=wallpattern_walls,
  wallpattern_fill=wallpattern_fill,
  wallpattern_hole_sides=wallpattern_hole_sides,
  wallpattern_hole_size=wallpattern_hole_size,
  wallpattern_hole_spacing=wallpattern_hole_spacing,
  cutx=cutx,
  cuty=cuty,
  help=help) {
  
  difference() {
    /*<!!start gridfinity_basic_cup!!>*/
    sepPositions = irregular_subdivisions 
      ? separator_positions
      : calcualteSeparators(chambers-1,width);
    
    irregular_cup(
      num_x=width, num_y=depth, num_z=height,
      position=position,
      filled_in=filled_in,
      withLabel=label,
      labelWidth=label_width,
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
      separator_positions=sepPositions,
      half_pitch=half_pitch,
      lip_style=lip_style,
      box_corner_attachments_only=box_corner_attachments_only,
      flat_base = flat_base,
      tapered_corner=tapered_corner,
      tapered_corner_size = tapered_corner_size,
      tapered_setback = tapered_setback,
      wallpattern_enabled=wallpattern_enabled,
      wallpattern_hexgrid=wallpattern_hexgrid,
      wallpattern_walls=wallpattern_walls, 
      wallpattern_hole_sides=wallpattern_hole_sides,
      wallpattern_hole_size=wallpattern_hole_size, 
      wallpattern_hole_spacing=wallpattern_hole_spacing,
      wallpattern_fill=wallpattern_fill,
      wallcutout_enabled=wallcutout_enabled,
      wallcutout_walls=wallcutout_walls,
      wallcutout_width=wallcutout_width,
      wallcutout_angle=wallcutout_angle,
      wallcutout_height=wallcutout_height,
      wallcutout_corner_radius=wallcutout_corner_radius,
      help = help);
    /*<!!end gridfinity_basic_cup!!>*/

    translate([-gridfinity_pitch/2,-gridfinity_pitch/2,0])
    tray(
      num_x = width,
      num_y = depth,
      num_z = height, 
      floorThickness = floor_thickness,
      wallThickness = wall_thickness,
      spacing = tray_spacing,
      cornerRadius = tray_corner_radius, 
      trayZpos = tray_zpos, 
      baseHeight = calculateCupBaseHeight(magnet_diameter, screw_depth),
      verticalCompartments = tray_vertical_compartments,
      horizontalCompartments = tray_horizontal_compartments,
      customCompartments = tray_custom_compartments);
      
      //This seems like a complciated way to do this, but it guarantees order will be correct.
      configArray = [
        [ixpos, 0], 
        [iypos, 0], 
        [ixsize, height], 
        [iysize, width], 
        [icornerradius, tray_corner_radius], 
        [idepth, height]];

      echo(outputCustomConfig("tray", replace_Items(configArray, [])));
  }
}

gridfinity_tray();
use <modules/gridfinity_cup_modules.scad>
use <modules/gridfinity_modules.scad>
include <modules/gridfinity_constants.scad>
include <modules/functions_general.scad>

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
position = "center"; //[default",center,zero]
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
// (Zack's design uses magnet diameter of 6.5)
magnet_diameter = 0;  // .1
// (Zack's design uses depth of 6)
screw_depth = 0;
center_magnet_diameter =0;
center_magnet_thickness = 0;
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
// Remove floor to create a veritcal spacer
spacer = false;

/* [Label] */
label_style = "disabled"; //[disabled: no label, normal:normal, click]
// Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
label_size = [0,14,0,0.6]; // 0.01
// Creates space so the attached label wont interferr with stacking
label_relief = 0; // 0.1

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
wallpattern_style = "grid"; //[grid, hexgrid, voronoi,voronoigrid,voronoihexgrid]
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1]; 
// Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both] 
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = 10; //0.1
// pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
wallpattern_voronoi_noise = 0.75;
wallpattern_voronoi_radius = 0.5;

/* [Wall Cutout] */
wallcutout_enabled=false;
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_walls=[1,0,0,0];  //0.1
//default will be binwidth/2
wallcutout_width=0;
wallcutout_angle=70;
//default will be binHeight
wallcutout_height=0;
wallcutout_corner_radius=5;

/* [Extendable] */
extention_x_enabled = false;
extention_y_enabled = false;
extention_tabs_enabled = true;

/* [debug] */
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// enable loging of help messages during render.
enable_help = false;
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

  cellSpacing = spacing/2;
  
  verticalCompartments = verticalCompartments > 0 ? verticalCompartments : num_x ;
  horizontalCompartments = horizontalCompartments > 0 ? horizontalCompartments : num_y;
  //todo, this could be simplified, by to produce a single array for ether scenario.
  if(len(customCompartments) == 0)
  {
    //Non custom components
    //echo(n=num_x*gf_pitch-(verticalCompartments+1)*spacing,d=verticalCompartments);
    xSize = (num_x*gf_pitch-(verticalCompartments+1)*spacing)/verticalCompartments;
    xStep = xSize + spacing;
    ySize = (num_y*gf_pitch-(horizontalCompartments+1)*spacing)/horizontalCompartments;
    yStep = ySize + spacing;
    
    for(x =[0:1:verticalCompartments-1])
    {
      for(y =[0:1:horizontalCompartments-1])
      {
        //echo(x=x,y=y,xStep=xStep,yStep=yStep);
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
    echo(customCompartments = splitCustomConfig(customCompartments));
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
          //echo(comp=comp);
          xpos = comp[ixpos];
          ypos = comp[iypos];
          xsize = comp[ixsize];
          ysize = comp[iysize];
          radius = len(comp) >= 5 ? comp[icornerradius] : cornerRadius;
          depth = baseHeight+(len(comp) >= 6 ? comp[idepth] : max(trayZpos,floorThickness));
        
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
  label_style=label_style,
  label_position=label_position,
  label_size=label_size,
  label_relief=label_relief,
  fingerslide=fingerslide,
  fingerslide_radius=fingerslide_radius,
  magnet_diameter=magnet_diameter,
  screw_depth=screw_depth,
  center_magnet_diameter=center_magnet_diameter,
  center_magnet_thickness=center_magnet_thickness,
  floor_thickness=floor_thickness,
  cavity_floor_radius=cavity_floor_radius,
  wall_thickness=wall_thickness,
  hole_overhang_remedy=hole_overhang_remedy,
  efficient_floor=efficient_floor,
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
  box_corner_attachments_only=box_corner_attachments_only,
  flat_base = flat_base,
  spacer=spacer,
  tapered_corner=tapered_corner,
  tapered_corner_size = tapered_corner_size,
  tapered_setback = tapered_setback,
  wallpattern_enabled=wallpattern_enabled,
  wallpattern_style=wallpattern_style,
  wallpattern_walls=wallpattern_walls, 
  wallpattern_dividers_enabled=wallpattern_dividers_enabled,
  wallpattern_hole_sides=wallpattern_hole_sides,
  wallpattern_hole_size=wallpattern_hole_size, 
  wallpattern_hole_spacing=wallpattern_hole_spacing,
  wallpattern_fill=wallpattern_fill,
  wallpattern_voronoi_noise=wallpattern_voronoi_noise,
  wallpattern_voronoi_radius = wallpattern_voronoi_radius,
  wallcutout_enabled=wallcutout_enabled,
  wallcutout_walls=wallcutout_walls,
  wallcutout_width=wallcutout_width,
  wallcutout_angle=wallcutout_angle,
  wallcutout_height=wallcutout_height,
  wallcutout_corner_radius=wallcutout_corner_radius,
  extention_enabled=[extention_x_enabled,extention_y_enabled],
  extention_tabs_enabled = extention_tabs_enabled,
  cutx=cutx,
  cuty=cuty,
  help=enable_help) {
  
  num_x = calcDimentionWidth(width);
  num_y = calcDimentionDepth(depth);
  num_z = calcDimentionHeight(height);
  
  echo("gridfinity_tray", num_x=num_x, num_y=num_y, num_z=num_z);
  
  difference() {
    /*<!!start gridfinity_basic_cup!!>*/
    gridfinity_cup(
      width=width, depth=depth, height=height,
      position=position,
      filled_in=filled_in,
      label_style=label_style,
      label_position=label_position,
      label_size=label_size,
      label_relief=label_relief,
      fingerslide=fingerslide,
      fingerslide_radius=fingerslide_radius,
      magnet_diameter=magnet_diameter,
      screw_depth=screw_depth,
      center_magnet_diameter=center_magnet_diameter,
      center_magnet_thickness=center_magnet_thickness,
      floor_thickness=floor_thickness,
      cavity_floor_radius=cavity_floor_radius,
      wall_thickness=wall_thickness,
      hole_overhang_remedy=hole_overhang_remedy,
      efficient_floor=efficient_floor,
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
      box_corner_attachments_only=box_corner_attachments_only,
      flat_base = flat_base,
      spacer=spacer,
      tapered_corner=tapered_corner,
      tapered_corner_size = tapered_corner_size,
      tapered_setback = tapered_setback,
      wallpattern_enabled=wallpattern_enabled,
      wallpattern_style=wallpattern_style,
      wallpattern_walls=wallpattern_walls, 
      wallpattern_dividers_enabled=wallpattern_dividers_enabled,
      wallpattern_hole_sides=wallpattern_hole_sides,
      wallpattern_hole_size=wallpattern_hole_size, 
      wallpattern_hole_spacing=wallpattern_hole_spacing,
      wallpattern_fill=wallpattern_fill,
      wallpattern_voronoi_noise=wallpattern_voronoi_noise,
      wallpattern_voronoi_radius = wallpattern_voronoi_radius,
      wallcutout_enabled=wallcutout_enabled,
      wallcutout_walls=wallcutout_walls,
      wallcutout_width=wallcutout_width,
      wallcutout_angle=wallcutout_angle,
      wallcutout_height=wallcutout_height,
      wallcutout_corner_radius=wallcutout_corner_radius,
      extention_enabled=[extention_x_enabled,extention_y_enabled],
      extention_tabs_enabled = extention_tabs_enabled,
      cutx=cutx,
      cuty=cuty,
      help = help);
    /*<!!end gridfinity_basic_cup!!>*/

    translate([-gf_pitch/2,-gf_pitch/2,0])
    translate(cupPosition(position,num_x,num_y))
    tray(
      num_x = num_x,
      num_y = num_y,
      num_z = num_z, 
      floorThickness = floor_thickness,
      wallThickness = wall_thickness,
      spacing = tray_spacing,
      cornerRadius = tray_corner_radius, 
      trayZpos = tray_zpos, 
      baseHeight = cupBaseClearanceHeight(magnet_diameter, screw_depth),
      verticalCompartments = tray_vertical_compartments,
      horizontalCompartments = tray_horizontal_compartments,
      customCompartments = tray_custom_compartments);
      
      //This seems like a complciated way to do this, but it guarantees order will be correct.
      configArray = [
        [ixpos, 0], 
        [iypos, 0], 
        [ixsize, num_z], 
        [iysize, num_x], 
        [icornerradius, tray_corner_radius], 
        [idepth, num_z]];

      echo(outputCustomConfig("tray", replace_Items(configArray, [])));
  }
}

gridfinity_tray();
include <modules/modules_item_holder.scad>
include <modules/gridfinity_constants.scad>
include <modules/functions_general.scad>
use <modules/gridfinity_cup_modules.scad>
use <modules/gridfinity_modules.scad>

/* [Divider] */
divider_count = 4;
divider_height = 50;
divider_width = 3;
divider_base_height = 10;
divider_radius = 5;
divider_front_top_inset=20;
divider_front_top_angle=45;
divider_back_top_inset=20;
divider_back_top_angle=45;

/* [Wall Pattern] */
// Grid wall patter
wallpattern_enabled=true;
// Style of the pattern
wallpattern_style = "hexgrid"; //[grid, hexgrid, voronoi,voronoigrid,voronoihexgrid]
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = 5; //0.1
// pattern fill mode
wallpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
wallpattern_voronoi_noise = 0.75;
wallpattern_voronoi_radius = 0.5;

/* [General Cup] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [3, 0]; //0.5
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [2, 0]; //0.5
// Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [1, 0]; //0.1
// Fill in solid block (overrides all following options)
filled_in = false; 
// Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
// Remove some or all of lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
position = "center"; //[default,center,zero]

/* [Base] */
// (Zack's design uses magnet diameter of 6.5)
magnet_diameter = 0;  // .1
// Create relief for magnet removal 
magnet_easy_release = true;
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

/* [Hidden] */
enable_help = false;
module end_of_customizer_opts() {}

Gridfinity_Divider();

module Divider(
  height = 50,
  length = 100,
  baseHeight = 10,
  radius = 5,
  frontTopInset=20,
  frontTopAngle=65,
  backTopInset=20,
  backTopAngle=65,
  $fn = 36
){
  _baseHeight = radius > baseHeight ? radius : baseHeight;
  
  _backBottomHeight = max(_baseHeight,height-radius-abs(backTopInset*tan(backTopAngle)));
  _frontBottomHeight = max(_baseHeight,height-radius-abs(frontTopInset*tan(frontTopAngle)));
  if(IsHelpEnabled("debug")) echo("Gridfinity_Divider", height,radius, abs(backTopInset*tan(backTopAngle)),_backBottomHeight);
  if(IsHelpEnabled("debug")) echo("Gridfinity_Divider", _baseHeight=_baseHeight, height=height, _backBottomHeight=_backBottomHeight, _frontBottomHeight=_frontBottomHeight);
  
  positions = [
    [radius,_frontBottomHeight],      //front bottom
    [radius+frontTopInset,height-radius],        //front top
    [length-radius-backTopInset,height-radius],  //back top
    [length-radius,_backBottomHeight] //back bottom
  ];
  
  //
  hull(){
    square([length,_baseHeight]);
    for(index =[0:1:len(positions)-1])
    {
      translate(positions[index])
        circle(r=radius, $fn=$fn);
    }
  }
}

module PatternedDivider(
  height = 50,
  length = 100,
  baseHeight = 10,
  width = 5,
  radius = 5,
  frontTopInset=20,
  frontTopAngle=65,
  backTopInset=20,
  backTopAngle=65,
  wallpatternEnabled = wallpattern_enabled,
  wallpatternStyle = wallpattern_style,
  wallpatternHoleSpacing = wallpattern_hole_spacing,
  wallpatternHoleSides = wallpattern_hole_sides,
  wallpatternHoleSize = wallpattern_hole_size,
  wallpatternFill = wallpattern_fill,
  wallpatternVoronoiNoise = wallpattern_voronoi_noise,
  wallpatternVoronoiRadius = wallpattern_voronoi_radius,
  help= false,
  $fn = 36){
  
  rotate([90,0,0])
  difference(){
  linear_extrude(height = width)
  Divider(
    height = height,
    length = length,
    baseHeight = baseHeight,
    radius = radius,
    frontTopInset=frontTopInset,
    frontTopAngle=frontTopAngle,
    backTopInset=backTopInset,
    backTopAngle=backTopAngle,
    $fn = $fn);
  
  if(wallpatternEnabled){
  translate([0,0,-fudgeFactor])
  intersection(){
    linear_extrude(height = width+fudgeFactor*2)
    offset(delta = -width)
    Divider(
      height = height,
      length = length,
      baseHeight = baseHeight,
      radius = radius,
      frontTopInset=frontTopInset,
      frontTopAngle=frontTopAngle,
      backTopInset=backTopInset,
      backTopAngle=backTopAngle,
      $fn = $fn);
    
      translate([0,height+baseHeight,0])
      rotate([0,0,-90])
      cutout_pattern(
        patternstyle = wallpatternStyle ,
        canvisSize = [height+baseHeight,length], //Swap x and y and rotate so hex is easier to print
        customShape = false,
        circleFn = wallpatternHoleSides,
        holeSize = [wallpatternHoleSize, wallpatternHoleSize],
        holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
        holeHeight = width*2,
        center=false,
        fill=wallpatternFill, //"none", "space", "crop"
        voronoiNoise=wallpatternVoronoiNoise,
        voronoiRadius = wallpatternVoronoiRadius,
        help=help);
      }
    }
  }
}

module Gridfinity_Divider(
  width=width, depth=depth, height=height,
  position=position,
  filled_in=filled_in,
  magnet_diameter=magnet_diameter,
  magnet_easy_release=magnet_easy_release,
  screw_depth=screw_depth,
  floor_thickness=floor_thickness,
  wall_thickness=wall_thickness,
  hole_overhang_remedy=hole_overhang_remedy,
  half_pitch=half_pitch,
  lip_style=lip_style,
  box_corner_attachments_only=box_corner_attachments_only,
  flat_base=flat_base,

  dividercount=divider_count,
  dividerheight=divider_height,
  baseHeight=divider_base_height,
  dividerwidth=divider_width,
  radius=divider_radius,
  frontTopInset=divider_front_top_inset,
  frontTopAngle=divider_front_top_angle,
  backTopInset=divider_back_top_inset,
  backTopAngle=divider_back_top_angle,
  wallpatternEnabled=wallpattern_enabled,
  wallpatternStyle=wallpattern_style,
  wallpatternHoleSpacing=wallpattern_hole_spacing,
  wallpatternHoleSides=wallpattern_hole_sides,
  wallpatternHoleSize=wallpattern_hole_size,
  wallpatternFill=wallpattern_fill,
  wallpatternVoronoiNoise=wallpattern_voronoi_noise,
  wallpatternVoronoiRadius=wallpattern_voronoi_radius
){

  num_x = calcDimensionWidth(width);
  num_y = calcDimensionDepth(depth);
  num_z = calcDimensionHeight(height);
  floorHeight = calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness);
  
  gridfinity_cup(
    width=width, depth=depth, height=height,
    position=position,
    filled_in=filled_in,
    magnet_diameter=magnet_diameter,
    magnet_easy_release=magnet_easy_release,
    screw_depth=screw_depth,
    floor_thickness=floor_thickness,
    cavity_floor_radius=cavity_floor_radius,
    wall_thickness=wall_thickness,
    hole_overhang_remedy=hole_overhang_remedy,
    efficient_floor=efficient_floor,
    half_pitch=half_pitch,
    lip_style=lip_style,
    box_corner_attachments_only=box_corner_attachments_only,
    flat_base = flat_base,
    label_style = "disabled",
    help = enable_help);
  
  for(i = [0 : divider_count-1]){
    ypos = (num_y*gf_pitch-gf_cup_corner_radius*2-dividerwidth)/(divider_count-1)*i;
    translate(cupPosition(position,num_x,num_y))
    translate([0.25,gf_cup_corner_radius+dividerwidth+ypos,floorHeight])
    PatternedDivider(
      height = dividerheight,
      length = num_x*gf_pitch-0.5,
      baseHeight = baseHeight,
      width = dividerwidth,
      radius = radius,
      frontTopInset=frontTopInset,
      frontTopAngle=frontTopAngle,
      backTopInset=backTopInset,
      backTopAngle=backTopAngle,
      wallpatternEnabled = wallpatternEnabled,
      wallpatternStyle = wallpatternStyle,
      wallpatternHoleSpacing = wallpatternHoleSpacing,
      wallpatternHoleSides = wallpatternHoleSides,
      wallpatternHoleSize = wallpatternHoleSize,
      wallpatternFill = wallpatternFill,
      wallpatternVoronoiNoise = wallpatternVoronoiNoise,
      wallpatternVoronoiRadius = wallpatternVoronoiRadius);
    }
}
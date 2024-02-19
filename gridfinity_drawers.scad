// Gridfinity drawer system.
// Intended for Gridfinity bins to sit in the drawers, meaning the outer box will not fit neatly on to a gridfinity grid.
//
// Original OpenSCAD design was provided by @monniasza
// Inspiration for their design was https://www.printables.com/pl/model/363389
// The design has diveated sigficantly, I would not consider this compatiable with the orginal.

use <modules/gridfinity_cup_modules.scad>
use <modules/gridfinity_modules.scad>
use <gridfinity_baseplate.scad>
include <modules/gridfinity_constants.scad>
use <modules/modules_item_holder.scad>

/* [Render] */
mode = "everything"; //["everything", "onedrawer":"Single Drawer", "drawers":"Drawers", "chest":"Chest"]

/* [Chest] */
//Inner width of drawer in Gridfinity units
drawer_inner_width = 4;
//Inner depth of drawer in Gridfinity units
drawer_inner_depth = 3;
//Inner height of drawer in Gridfinity units
drawer_inner_height = 4;
//Number of drawers
drawer_count = 3;
drawer_enable_custom_sizes = false;
//Inner height of drawer in Gridfinity units. Edit in script for more than 4 items.
drawer_custom_sizes = [1,2,3,4];

clearance = 0.25;
box_wall_thickness = 2;

//Thickness of drawer slies in mm. 0 is uses wall thickenss.
box_drawer_slide_thickness = 0;
//Width of drawer slies in mm. 0 is full box width.
box_drawer_slide_width = 10; 

/* [Drawer] */
// Handle size width, depth, height and radius
handle_size = [4, 10, -1, 5];

wallthicknessInner = 2;
drawerbase = "default"; //["grid":Grid only, "floor":floor only, "default":"Grid and floor"]
drawer_grid_style = "default";//[default:Default, magnet:Efficient magnet base]

/* [Chest Top Plate] */
box_enable_top_grid = true;
// Plate Style
box_top_grid_style = "default";//[default:Default, magnet:Efficient magnet base]

/* [Chest Base] */
bottomgrid = true;
// (Zack's design uses magnet diameter of 6.5)
magnet_diameter = 6.5;  // .1
// (Zack's design uses depth of 6)
screw_depth = 6;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = true;
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = false;

/* [Chest Wall Pattern] */
// wall pattern border width. -1 defaults to box_wall_thickness. less than 0 box_wall_thickness/abs(wallpattern_border_width)
wallpattern_border_width = -1;
efficientback = true;
// Grid wall patter
wallpattern_enabled=false;
// Style of the pattern
wallpattern_style = "grid"; //["grid", "hexgrid", "voronoi","voronoigrid","voronoihexgrid"]
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1
// Add the pattern to the dividers
wallpattern_dividers_enabled=false; 
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = 10; //0.1
// pattern fill mode
wallpattern_fill = "none"; //["none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"]
wallpattern_voronoi_noise = 0.75;
wallpattern_voronoi_radius = 0.5;

function sum(list, c = 0) = 
  c < len(list) - 1 
    ? list[c] + sum(list, c + 1) 
    : list[c];
 
// Apply defaults
drawerSlideThickness =box_drawer_slide_thickness == 0 ? box_wall_thickness : box_drawer_slide_thickness;
ridgedepth = wallpattern_border_width < 0 ? box_wall_thickness/abs(wallpattern_border_width) : wallpattern_border_width;

// Calculate global dimensions 
drawerInnerHeights = drawer_enable_custom_sizes ? drawer_custom_sizes : [for([0:drawer_count-1]) drawer_inner_height];
drawerCount = len(drawerInnerHeights);
echo(drawerInnerHeights=drawerInnerHeights, drawerCount=drawerCount);

drawerInnerSizes = [for(i = [0:drawerCount-1]) [
  (drawer_inner_width*gf_pitch) + clearance - 0.25,
  (drawer_inner_depth*gf_pitch) + clearance - 0.25,
  (drawerInnerHeights[i]*gf_zpitch) + clearance + 4.25 + (drawer_grid_style == "magnet" ? gf_baseplate_magnet_thickness : 0)
]];

echo(drawerInnerSizes=drawerInnerSizes);
drawerOuterSizes = [for(i = [0:drawerCount-1]) [
  drawerInnerSizes[i].x + (wallthicknessInner * 2),
  drawerInnerSizes[i].y + (wallthicknessInner * 2),
  drawerInnerSizes[i].z + ((drawerbase == "floor" || drawerbase == "default") ? wallthicknessInner : 0)
]];
echo(drawerOuterSizes=drawerOuterSizes);

function drawerPosition(index, outerSizes, clearance, sliderThickenss) = let(
  drawersTotal = (index<1 ? 0 : sum(partial(drawerOuterSizes,0,index-1)).z),
  clearanceTotal = clearance*2*(index+1),
  sliderThickenss = sliderThickenss*index) drawersTotal + clearanceTotal + sliderThickenss;
  
OuterBox = [
  drawerOuterSizes[0].x + (clearance * 2) + (box_wall_thickness * 2),
  drawerOuterSizes[0].y + (clearance * 2) + (box_wall_thickness)];

TotalH = sum(drawerOuterSizes).z + (clearance*2*drawerCount) + drawerSlideThickness * (drawerCount - 1) + box_wall_thickness*2;

StartH = box_wall_thickness;

$fn = 64;

//Drawer modules
module drawers(
  innerSizes = drawerInnerSizes,
  outerSizes = drawerOuterSizes
  ){
  offsetW = box_wall_thickness + clearance;
  
  for(i = [0 : drawerCount-1]){
    //IncrementH = 0;
    zpos = StartH + drawerPosition(i, drawerOuterSizes, clearance, ridgedepth);
    //(clearance * i) + (i<1 ? 0 : sum(partial(drawerOuterSizes,0,i-1)).z);
    echo("drawers", i= i, StartH=StartH, clearance=clearance, height=drawerInnerHeights[i], zpos=zpos, drawerOuterz=drawerOuterSizes.z, drawerInnerz=drawerInnerSizes.z, drawerOuterSizes.z);
      
    translate([box_wall_thickness+clearance/2, offsetW, zpos]) 
      drawer(i);
  }
}

module drawer(
  drawerIndex,
  drawerBase = drawerbase,
  wallThickness = wallthicknessInner,
  handleSize = handle_size){
  
  drawerFloor = (drawerBase == "default" || drawerBase == "floor");
  floorThickness = (drawerFloor ? wallThickness : 0);
  union(){
    difference(){
      roundedCube(
        x=drawerOuterSizes[drawerIndex].x,
        y=drawerOuterSizes[drawerIndex].y,
        z=drawerOuterSizes[drawerIndex].z,
        sideRadius = 6);
        
      echo("drawerCutout", drawerbase=drawerbase);

      translate([wallThickness, wallThickness, floorThickness-fudgeFactor]) 
      difference(){
        roundedCube(
          x=drawerInnerSizes[drawerIndex].x,
          y=drawerInnerSizes[drawerIndex].y,
          z=drawerInnerSizes[drawerIndex].z+fudgeFactor*2,
          sideRadius = 4);
        if(drawerbase == "default" || drawerbase == "grid"){
          translate([gf_pitch/2,gf_pitch/2, -fudgeFactor]) 
            baseplate(
              width = drawer_inner_width,
              depth = drawer_inner_depth,
              plateStyle = "base",
              plateOptions = drawer_grid_style);
        }
      }
    }
    
    handelHeight = handleSize.z == 0 ? drawerOuterSizes[drawerIndex].z/2
      : handleSize.z <0 ? drawerOuterSizes[drawerIndex].z/abs(handleSize.z) : handleSize.z;
      
    //Drawer handle
    translate([drawerOuterSizes[drawerIndex].x/2, 0, drawerOuterSizes[drawerIndex].z/2]) 
      drawerPull(handleSize.x, handleSize.y, handelHeight, handleSize[3]);
  }
}

module drawerPull(width, depth, height, radius){
  radius = min(radius, height/2,depth);
  depth = depth - radius;
  translate([-width/2,-depth,-height/2])
  hull(){
    cube([width, depth, height]);
    
    if(radius>0){
      for(i=[0:1]){
      translate(i == 0 ? [0,0,radius] : [0,0,height-radius])
      rotate([0,90,0])
        difference(){
          cylinder(h=width, r=radius);
          //Remove inner half so we dont get error when r<roundedr*2
          translate([-radius,0,-fudgeFactor])
          cube([radius*2,radius*2,width+fudgeFactor*2]);
        }
      }
    }
  }
}

//Chest modules
module chest(){
  bottomGridOffset = wallthicknessInner + box_wall_thickness + clearance*2;
  topGridOffset = bottomGridOffset - 0.25;

  color("green") 
  difference(){
    union(){
      cube([OuterBox.x, OuterBox.y, TotalH]);
      
      if(bottomgrid) {
        baseHeight=0.7;
        translate([bottomGridOffset, bottomGridOffset, 0]) 
        translate([gf_pitch/2, gf_pitch/2, -gf_zpitch*baseHeight+fudgeFactor])
        grid_block(
          num_x=drawer_inner_width, 
          num_y=drawer_inner_depth, 
          num_z=baseHeight, 
          stackable=false, 
          magnet_diameter=magnet_diameter, 
          screw_depth=screw_depth,
          hole_overhang_remedy=hole_overhang_remedy,
          box_corner_attachments_only=box_corner_attachments_only,
          half_pitch = half_pitch,
          flat_base = flat_base);
      }
      
      if(box_enable_top_grid) {
        translate([topGridOffset + gf_pitch/2, topGridOffset + gf_pitch/2, TotalH]) 
        baseplate(
          width = drawer_inner_width,
          depth = drawer_inner_depth,
          plateStyle = "base",
          plateOptions = box_top_grid_style);
      }
    }
    
    chestCutouts();
  }
}

module chestCutouts(){
  wallpattern_thickness = box_wall_thickness*2;

  for(iDrawer = [0 : drawerCount-1]){
    innerbox = [
      drawerOuterSizes[iDrawer].x + clearance*2,
      drawerOuterSizes[iDrawer].y + clearance*2,
      drawerOuterSizes[iDrawer].z + clearance*2];
    echo("holderCutouts", iDrawer=iDrawer, innerbox=innerbox);
    //positions for wall cutouts
    back = [
      [innerbox.x-ridgedepth*2,innerbox.z-ridgedepth*2], //size
      [innerbox.x/2+box_wall_thickness, innerbox.y+box_wall_thickness/2-wallpattern_thickness/2, innerbox.z/2], //location
      [90,90,180]]; //rotation 
    left = [
      [innerbox.y-ridgedepth*2,innerbox.z-ridgedepth*2],    //size
      [+box_wall_thickness/2-wallpattern_thickness/2, (innerbox.y+box_wall_thickness)/2, innerbox.z/2], //location
      [90,90,90]];//rotation
    right = [
      [innerbox.y-ridgedepth*2,innerbox.z-ridgedepth*2],//size
      [innerbox.x+box_wall_thickness*1.5-wallpattern_thickness/2, (innerbox.y+box_wall_thickness)/2, innerbox.z/2],//location
      [90,90,90]];//rotation
    locations = [back, left, right];
  
    vpos = StartH + drawerPosition(iDrawer, drawerOuterSizes, clearance, drawerSlideThickness);
    
    translate([box_wall_thickness, -fudgeFactor, vpos]) 
      cube([innerbox.x, innerbox.y+fudgeFactor, innerbox.z]);
        
    if(efficientback) {
      translate(locations[0][1])
      translate([-locations[0][0][0]/2, 0, vpos-locations[0][0][1]/2])
      cube([locations[0][0][0], wallpattern_thickness, locations[0][0][1]]);
    }
    
    if(wallpattern_enabled)
    {
      translate([0, 0, vpos]) 
      for(iSide = [0:1:len(locations)-1])
      {
        translate(locations[iSide][1])
        rotate(locations[iSide][2])
        render(){
        cutout_pattern(
          patternstyle = wallpattern_style,
          canvisSize = [locations[iSide][0][1],locations[iSide][0][0]], //Swap x and y and rotate so hex is easier to print
          customShape = false,
          circleFn = wallpattern_hole_sides,
          holeSize = [wallpattern_hole_size, wallpattern_hole_size],
          holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
          holeHeight = wallpattern_thickness,
          center=true,
          fill=wallpattern_fill, //"none", "space", "crop"
          voronoiNoise=wallpattern_voronoi_noise,
          voronoiRadius = wallpattern_voronoi_radius,
          help=false);
        }
      }
    }
  }
  
  if(box_drawer_slide_width > 0 && drawerCount > 1)
  {
    zposFirstDivider =drawerPosition(1, drawerOuterSizes, clearance, drawerSlideThickness)-drawerSlideThickness*2;
    zposLastDivider =drawerPosition(drawerCount-1, drawerOuterSizes, clearance, drawerSlideThickness)+drawerSlideThickness;
    translate([box_drawer_slide_width, -box_drawer_slide_width, StartH+zposFirstDivider]) 
      roundedCube(
        x=OuterBox.x-box_drawer_slide_width*2,
        y=OuterBox.y, //was innerbox
        z=zposLastDivider-zposFirstDivider,
        sideRadius = box_drawer_slide_width-fudgeFactor*2);
  }
}


module cutout_pattern(
  patternstyle,
  canvisSize,
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
  if(patternstyle == "grid" || patternstyle == "hexgrid") {
    GridItemHolder(
      canvisSize = canvisSize,
      hexGrid = patternstyle == "hexgrid",
      customShape = customShape,
      circleFn = circleFn,
      holeSize = holeSize,
      holeSpacing = holeSpacing,
      holeHeight = holeHeight,
      center=center,
      fill=fill, //"none", "space", "crop"
      help=help);
  }
  else if(patternstyle == "voronoi" || patternstyle == "voronoigrid" || patternstyle == "voronoihexgrid"){
    echo("cutout_pattern", canvisSize = [canvisSize.x,canvisSize.y,holeHeight], thickness = holeSpacing.x, round=1);
    rectangle_voronoi(
      canvisSize = [canvisSize.x,canvisSize.y,holeHeight], 
      spacing = holeSpacing.x, 
      cellsize = holeSize.x,
      grid = (patternstyle == "voronoigrid" || patternstyle == "voronoihexgrid"),
      gridOffset = (patternstyle == "voronoihexgrid"),
      noise=voronoiNoise,
      radius = voronoiRadius);
  }
}

//render function
module gridfinity_drawer(){
  if(mode == "chest" || mode == "everything")      
    chest();
  if(mode == "drawers" || mode == "everything")
    drawers();
  if(mode == "onedrawer")   
    drawer(0);
}

gridfinity_drawer();
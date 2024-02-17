use <modules/gridfinity_cup_modules.scad>
use <modules/gridfinity_modules.scad>
use <gridfinity_baseplate.scad>
include <modules/gridfinity_constants.scad>
use <modules/modules_item_holder.scad>
//From https://www.printables.com/pl/model/363389-gridfinity-drawer-chest-remix

/* [Render] */
mode = "everything"; //["everything", "drawers", "holder", "onedrawer"]

/* [Box] */
width = 4;
depth = 3;
height = 4;
count = 3;

//heightsRaw = "4 4 4";
clearance = 0.25;
box_wall_thickness = 2;
box_enable_top_grid = true;
//Thickness of drawer slies in mm. 0 is uses wall thickenss.
box_drawer_slide_thickness = 0;
//Width of drawer slies in mm. 0 is full box width.
box_drawer_slide_width = 10; 

/* [Drawer] */
handlewidth = 40;
handleheight = 4;
handlelength = 7;
wallthicknessInner = 2;
drawerbase = "default"; //["grid":Grid only, "floor":floor only, "default":"Grid and floor"]

/* [Box Base] */
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

/* [Box Wall Pattern] */
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

//heights = str_split(heightsRaw, " ");

drawerSlideThickness =box_drawer_slide_thickness == 0 ? box_wall_thickness : box_drawer_slide_thickness;
ridgedepth = wallpattern_border_width < 0 ? box_wall_thickness/abs(wallpattern_border_width) : wallpattern_border_width;

InnerDrawerW = (width*gf_pitch) + clearance - 0.25;
InnerDrawerD = (depth*gf_pitch) + clearance - 0.25;
InnerDrawerH = (height*gf_zpitch) + clearance + 4.25;
OuterDrawerW = InnerDrawerW + (wallthicknessInner * 2);
OuterDrawerD = InnerDrawerD + (wallthicknessInner * 2);
OuterDrawerH = InnerDrawerH + ((drawerbase == "floor" || drawerbase == "default") ? wallthicknessInner : 0);
InnerBoxW = OuterDrawerW + (clearance * 2);
InnerBoxD = OuterDrawerD + (clearance * 2);
InnerBoxH = OuterDrawerH + (clearance * 2);
OuterBoxW = InnerBoxW + (box_wall_thickness * 2);
OuterBoxD = InnerBoxD + (box_wall_thickness);
BottomGridOffset = wallthicknessInner + box_wall_thickness + clearance*2;
TopGridOffset = BottomGridOffset - 0.25;

HoleH = OuterDrawerH + (clearance * 2);
TotalH = (HoleH * count) + (drawerSlideThickness * (count - 1)) + (box_wall_thickness * 2);
IncrementH = HoleH + drawerSlideThickness;
StartH = box_wall_thickness;
OffsetW = box_wall_thickness + clearance;

$fn = 64;

//DRAWER STUFF
module rounddrawerbox(w, d, h, r=6){
  D = r * 2;
  linear_extrude(height = h)
  minkowski(){
    translate([r, r]) square([w-D, d-D]);
    circle(r);
  }
}
module drawer(h){
  drawerFloor = (drawerbase == "default" || drawerbase == "floor");
  drawerGrid = (drawerbase == "default" || drawerbase == "grid");
  floorThickness = (drawerFloor ? wallthicknessInner : 0);
  InnerH = (h*7) + clearance + 4.25;
  OuterH = InnerH + floorThickness;
  
  union(){
    difference(){
      rounddrawerbox(OuterDrawerW, OuterDrawerD, OuterH);
      drawerCutout(height,floorThickness,drawerGrid);
    };
    
    translate([OuterDrawerW/2, 0, OuterH/2]) 
      handle();
  }
}
module drawerCutout(height, floorThickness = 0, grid = true){
  translate([wallthicknessInner, wallthicknessInner, floorThickness-fudgeFactor]) 
  difference(){
    rounddrawerbox(InnerDrawerW, InnerDrawerD,(height+1)*gf_zpitch+fudgeFactor*2, 4);
    if(drawerbase == "default" || drawerbase == "grid"){
      translate([gf_pitch/2,gf_pitch/2, -fudgeFactor]) 
        frame_plain(width, depth);
    }
  }
}

module handle(){
  translate(-[handlewidth / 2, handlelength, handleheight/2]) cube([handlewidth, handlelength, handleheight]);
}

module drawers(){
  for(i = [0 : count-1]){
    vpos = clearance + StartH + IncrementH * i;
      translate([box_wall_thickness +clearance/2, OffsetW, vpos]) 
      drawer(height);
  }
}

//HOLDER STUFF
module baseRaw(){
  height=0.7;
  translate([gf_pitch/2, gf_pitch/2, -gf_zpitch*height+fudgeFactor])
  grid_block(
    num_x=width, 
    num_y=depth, 
    num_z=height, 
    stackable=false, 
    magnet_diameter=magnet_diameter, 
    screw_depth=screw_depth,
    hole_overhang_remedy=hole_overhang_remedy,
    box_corner_attachments_only=box_corner_attachments_only,
    half_pitch = half_pitch,
    flat_base = flat_base);
}

module base(){
  translate([BottomGridOffset, BottomGridOffset, 0]) 
    baseRaw();
}
module baseplate(){
  translate([TopGridOffset + 21, TopGridOffset + 21, TotalH]) 
    frame_plain(width, depth);
}

module holder(){
  color("green") 
  difference(){
    union(){
      cube([OuterBoxW, OuterBoxD, TotalH]);
      if(bottomgrid) base();
      if(box_enable_top_grid) baseplate();
    }
    holderCutouts();
  }
  
  echo("Bottom offset: ", BottomGridOffset);  
}

module holderCutouts(){
    wallpattern_thickness = box_wall_thickness + fudgeFactor*2;
  
    //InnerBoxW, InnerBoxD, InnerBoxH
    back = [
      [InnerBoxW-ridgedepth*2,InnerBoxH-ridgedepth*2], //size
      [InnerBoxW/2+box_wall_thickness, OuterBoxD+fudgeFactor, InnerBoxH/2], //location
      [90,90,0]]; //rotation 
    left = [
      [OuterBoxD-box_wall_thickness*2-ridgedepth*2,InnerBoxH-ridgedepth*2],    //size
      [-fudgeFactor, OuterBoxD/2, InnerBoxH/2], //location
      [90,90,90]];//rotation
    right = [
      [OuterBoxD-box_wall_thickness*2-ridgedepth*2,InnerBoxH-ridgedepth*2],//size
      [OuterBoxW-box_wall_thickness-fudgeFactor, OuterBoxD/2, InnerBoxH/2],//location
      [90,90,90]];//rotation
    
  locations = [back, left, right];
        
  for(i = [0 : count-1]){
    vpos = StartH + IncrementH * i;
    translate([box_wall_thickness, -fudgeFactor, vpos]) 
    holderCutout(InnerBoxW, InnerBoxD+fudgeFactor, InnerBoxH);
  
    if(wallpattern_enabled)
    translate([0, 0, vpos]) 
    for(i = [0:1:len(locations)-1])
    {
      translate(locations[i][1])
      rotate(locations[i][2])
      render(){
      cutout_pattern(
        patternstyle = wallpattern_style,
        canvisSize = [locations[i][0][1],locations[i][0][0]], //Swap x and y and rotate so hex is easier to print
        customShape = false,
        circleFn = wallpattern_hole_sides,
        holeSize = [wallpattern_hole_size, wallpattern_hole_size],
        holeSpacing = [wallpattern_hole_spacing,wallpattern_hole_spacing],
        holeHeight = wallpattern_thickness+fudgeFactor*2,
        center=true,
        fill=wallpattern_fill, //"none", "space", "crop"
        voronoiNoise=wallpattern_voronoi_noise,
        voronoiRadius = wallpattern_voronoi_radius,
        help=false);
      }
    }
  }
  
  if(box_drawer_slide_width > 0)
  {
    translate([box_drawer_slide_width, -box_drawer_slide_width, StartH-fudgeFactor]) 
     rounddrawerbox(OuterBoxW-box_drawer_slide_width*2, InnerBoxD, (TotalH-(box_wall_thickness*2)), box_drawer_slide_width-fudgeFactor*2);
  }
}

module holderCutout(InnerBoxW, InnerBoxD, InnerBoxH){
    cube([InnerBoxW, InnerBoxD, InnerBoxH]);
    
    if(efficientback)
      translate([ridgedepth, OuterBoxD-box_wall_thickness, ridgedepth])
      cube([InnerBoxW-ridgedepth*2, box_wall_thickness+fudgeFactor*2,InnerBoxH-ridgedepth*2]);
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

//THE END
module everything(){
    holder();
    drawers();
}

if(mode == "everything") everything();
if(mode == "holder") holder();
if(mode == "drawers") drawers();
if(mode == "onedrawer") drawer(height);
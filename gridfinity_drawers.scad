// Gridfinity drawer system.
// Intended for Gridfinity bins to sit in the drawers, meaning the outer chest will not fit neatly on to a gridfinity grid.
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
mode = "everything"; //["everything":Everything, "onedrawer":"Single Drawer", "drawers":"All drawers", "chest":"Chest"]

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

drawer_clearance = 0.25;

chest_wall_thickness = 2;
//Thickness of drawer slies in mm. 0 is uses wall thickenss.
chest_drawer_slide_thickness = 0;
//Width of drawer slies in mm. 0 is full chest width.
chest_drawer_slide_width = 10; 

/* [Drawer] */
// Handle size width, depth, height, and radius. Height, less than 0 drawerHeight/abs(height). radius, -1 = depth/2. 
handle_size = [4, 10, -1, -1];

drawer_wall_thickness = 2;
drawer_base = "default"; //["grid":Grid only, "floor":floor only, "default":"Grid and floor"]
drawer_grid_style = "default";//[default:Default, magnet:Efficient magnet base]

/* [Chest Top Plate] */
chest_enable_top_grid = true;
// Plate Style
chest_top_grid_style = "default";//[default:Default, magnet:Efficient magnet base]

/* [Chest Base] */
chest_bottom_grid = true;
// (Zack's design uses magnet diameter of 6.5)
magnet_diameter = 6.5;  // .1
// (Zack's design uses depth of 6)
screw_depth = 6;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to chest corners (prints faster).
chest_corner_attachments_only = true;
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = false;

/* [Chest Wall Pattern] */
// wall pattern border width. -1 defaults to chest_wall_thickness. less than 0 chest_wall_thickness/abs(wallpattern_border_width)
wallpattern_border_width = -1;
efficient_back = true;
// Grid wall patter
wallpattern_enabled=false;
// Style of the pattern
wallpattern_style = "hexgrid"; //["grid", "hexgrid", "voronoi","voronoigrid","voronoihexgrid"]
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1
// Add the pattern to the dividers
wallpattern_dividers_enabled=false; 
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = 8; //0.1
// pattern fill mode
wallpattern_fill = "crop"; //["none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"]
wallpattern_voronoi_noise = 0.75;
wallpattern_voronoi_radius = 0.5;

module end_of_customizer_opts() {}
colour_drawer = "Teal";
colour_drawer_pull = "CadetBlue";
colour_chest = "Maroon";

function drawerPosition(
  index, 
  outerSizes, 
  clearance, 
  sliderThickenss) = let(
  drawersTotal = (index<1 ? 0 : sum(partial(outerSizes,0,index-1)).z),
  clearanceTotal = clearance*2*(index+1),
  sliderThickenss = sliderThickenss*index) drawersTotal + clearanceTotal + sliderThickenss;
  
function sum(list, c = 0) = 
  c < len(list) - 1 
    ? list[c] + sum(list, c + 1) 
    : list[c];
 
$fn = 64;

//Drawer modules
module drawers(
  drawerCount,
  innerUnitSize,
  innerSizes,// = drawerInnerSizes,
  outerSizes,// = drawerOuterSizes,
  drawerBase, // = drawerbase,
  wallThickness,// = wallthicknessInner,
  handleSize,
  ridgeDepth,
  startH,
  clearance,
  chestWallThickness,
  gridStyle
  ){
  
  offsetW = chestWallThickness + clearance;
  
  for(i = [0 : drawerCount-1]){
    //IncrementH = 0;
    zpos = startH + drawerPosition(i, outerSizes, clearance, ridgeDepth);
    //(clearance * i) + (i<1 ? 0 : sum(partial(drawerOuterSizes,0,i-1)).z);
    //echo("drawers", i= i, StartH=StartH, clearance=clearance, height=drawerInnerHeights[i], zpos=zpos, drawerOuterz=drawerOuterSizes.z, drawerInnerz=drawerInnerSizes.z, drawerOuterSizes.z);
      
    translate([chestWallThickness+clearance/2, offsetW, zpos]) 
      drawer(drawerIndex=i,
        innerUnitSize=innerUnitSize,
        drawerBase=drawerBase,// = drawerbase,
        wallThickness=wallThickness,// = wallthicknessInner,
        handleSize=handleSize,
        innerSizes=innerSizes,
        outerSizes=outerSizes,
        gridStyle=gridStyle);
  }
}

module drawer(
  drawerIndex,
  innerUnitSize,
  drawerBase,// = drawerbase,
  wallThickness,// = wallthicknessInner,
  handleSize,
  innerSizes,// = drawerInnerSizes,
  outerSizes,// = drawerOuterSizes,
  gridStyle
  ){
  
  drawerFloor = (drawerBase == "default" || drawerBase == "floor");
  floorThickness = (drawerFloor ? wallThickness : 0);
  union(){
    difference(){
      color(colour_drawer)
      roundedCube(
        x=outerSizes[drawerIndex].x,
        y=outerSizes[drawerIndex].y,
        z=outerSizes[drawerIndex].z,
        sideRadius = 6);
        
      translate([wallThickness, wallThickness, floorThickness-fudgeFactor]) 
      difference(){
        color(colour_drawer)
        roundedCube(
          x=innerSizes[drawerIndex].x,
          y=innerSizes[drawerIndex].y,
          z=innerSizes[drawerIndex].z+fudgeFactor*2,
          sideRadius = 4);
        if(drawerBase == "default" || drawerBase == "grid"){
          translate([gf_pitch/2,gf_pitch/2, -fudgeFactor]) 
            baseplate(
              width = innerUnitSize.x,
              depth = innerUnitSize.y,
              plateStyle = "base",
              plateOptions = gridStyle);
        }
      }
    }

    handelHeight = handleSize.z == 0 ? outerSizes[drawerIndex].z/2
      : handleSize.z <0 ? outerSizes[drawerIndex].z/abs(handleSize.z) : handleSize.z;
      
    //Drawer handle
    color(colour_drawer_pull)
    translate([outerSizes[drawerIndex].x/2, 0, outerSizes[drawerIndex].z/2]) 
      drawerPull(handleSize.x, handleSize.y, handelHeight, handleSize[3]);
  }
}

module drawerPull(width, depth, height, radius){
  radius = min(radius == -1 ? depth/2 : radius, height/2,depth);
  depth = depth - radius;
  translate([-width/2,-depth,-height/2])
  hull(){
    cube([width, depth, height]);
    
    if(radius>0){
      for(i=[0:1]){
      translate(i == 0 ? [0,0,radius] : [0,0,height-radius])
      rotate([0,90,0])
        difference(){
          cylinder(h=width, r=radius, $fn=64);
          //Remove inner half so we dont get error when r<roundedr*2
          translate([-radius,0,-fudgeFactor])
          cube([radius*2,radius*2,width+fudgeFactor*2]);
        }
      }
    }
  }
}

//Chest modules
module chest(
  outerChest,
  totalH,
  chestWallThickness,
  enableTopGrid,
  topGridStyle,
  //ridgeDepth,
  bottomGrid,
  bottomMagnetDiameter,
  bottomScrewDepth,
  bottomHoleOverhangRemedy,
  bottomCornerAttachmentsOnly,
  bottomHalfPitch,
  bottomFlatBase,
  drawerCount,
  drawerInnerUnitSize,
  drawerOuterSizes,
  drawerSlideThickness,
  drawerWallThickness,
  startH,
  clearance
){
  bottomGridOffset = drawerWallThickness + chestWallThickness + clearance*2;
  topGridOffset = bottomGridOffset - 0.25;

  difference(){
    union(){
      color(colour_chest) 
      cube([outerChest.x, outerChest.y, totalH]);
      
      if(bottomGrid) {
        baseHeight=0.7;
        translate([bottomGridOffset, bottomGridOffset, 0]) 
        translate([gf_pitch/2, gf_pitch/2, -gf_zpitch*baseHeight+fudgeFactor])
        grid_block(
          num_x=drawerInnerUnitSize.x, 
          num_y=drawerInnerUnitSize.y, 
          num_z=baseHeight, 
          stackable=false, 
          magnet_diameter=bottomMagnetDiameter, 
          screw_depth=bottomScrewDepth,
          hole_overhang_remedy=bottomHoleOverhangRemedy,
          box_corner_attachments_only=bottomCornerAttachmentsOnly,
          half_pitch = bottomHalfPitch,
          flat_base = bottomFlatBase);
      }
      
      if(enableTopGrid) {
        translate([topGridOffset + gf_pitch/2, topGridOffset + gf_pitch/2, totalH-fudgeFactor]) 
        baseplate(
          width = drawerInnerUnitSize.x,
          depth = drawerInnerUnitSize.y,
          plateStyle = "base",
          plateOptions = topGridStyle);
      }
    }
    children();
  }
}

module chestCutouts(
  drawerCount, 
  drawerOuterSizes,
  ridgeDepth,
  drawerSlideThickness,
  drawerSlideWidth,
  startH,
  outerChest,
  clearance,
  chestWallThickness,
  efficientBack,
  wallPatternBorderWidth,
  wallPatternEnabled,
  wallPatternStyle,
  wallPatternWtyle,
  wallPatternHoleSpacing,
  wallPatternDividersEnabled,
  wallPatternHoleSides,
  wallPatternHoleSize,
  wallPatternFill,
  wallPatternVoronoiNoise,
  wallPatternVoronoiRadius
){
  wallPattern_thickness = chestWallThickness+fudgeFactor*2;

  for(iDrawer = [0 : drawerCount-1]){
    innerchest = [
      drawerOuterSizes[iDrawer].x + clearance*2,
      drawerOuterSizes[iDrawer].y + clearance*2,
      drawerOuterSizes[iDrawer].z + clearance*2];
 
    //positions for wall cutouts
    back = [
      [innerchest.x-ridgeDepth*2,innerchest.z-ridgeDepth*2], //size
      [innerchest.x/2+chestWallThickness, innerchest.y+chestWallThickness/2-wallPattern_thickness/2, innerchest.z/2], //location
      [90,90,180]]; //rotation 
    left = [
      [innerchest.y-ridgeDepth*2,innerchest.z-ridgeDepth*2],    //size
      [+chestWallThickness/2-wallPattern_thickness/2, (innerchest.y+chestWallThickness)/2, innerchest.z/2], //location
      [90,90,90]];//rotation
    right = [
      [innerchest.y-ridgeDepth*2,innerchest.z-ridgeDepth*2],//size
      [innerchest.x+chestWallThickness*1.5-wallPattern_thickness/2, (innerchest.y+chestWallThickness)/2, innerchest.z/2],//location
      [90,90,90]];//rotation
    locations = [back, left, right];
  
    vpos = startH + drawerPosition(iDrawer, drawerOuterSizes, clearance, drawerSlideThickness);
    
    color(colour_chest) 
    translate([chestWallThickness, -fudgeFactor, vpos]) 
      cube([innerchest.x, innerchest.y+fudgeFactor, innerchest.z]);
        
    if(efficientBack) {
      translate(locations[0][1])
      translate([-locations[0][0][0]/2, 0, vpos-locations[0][0][1]/2])
      cube([locations[0][0][0], wallPattern_thickness, locations[0][0][1]]);
    }
    
    if(wallPatternEnabled)
    {
      translate([0, 0, vpos]) 
      for(iSide = [efficientBack ? 1 : 0:1:len(locations)-1])
      {
        translate(locations[iSide][1])
        rotate(locations[iSide][2])
        render(){
        cutout_pattern(
          patternstyle = wallPatternStyle,
          canvisSize = [locations[iSide][0][1],locations[iSide][0][0]], //Swap x and y and rotate so hex is easier to print
          customShape = false,
          circleFn = wallPatternHoleSides,
          holeSize = [wallPatternHoleSize, wallPatternHoleSize],
          holeSpacing = [wallPatternHoleSpacing, wallPatternHoleSpacing],
          holeHeight = wallPattern_thickness,
          center=true,
          fill=wallPatternFill, //"none", "space", "crop"
          voronoiNoise=wallPatternVoronoiNoise,
          voronoiRadius = wallPatternVoronoiRadius,
          help=false);
        }
      }
    }
  }
  
  color(colour_chest) 
  if(drawerSlideWidth > 0 && drawerCount > 1)
  {
    zposFirstDivider =drawerPosition(1, drawerOuterSizes, clearance, drawerSlideThickness)-drawerSlideThickness*2;
    zposLastDivider =drawerPosition(drawerCount-1, drawerOuterSizes, clearance, drawerSlideThickness)+drawerSlideThickness;
    translate([drawerSlideWidth, -drawerSlideWidth, startH+zposFirstDivider]) 
      roundedCube(
        x=outerChest.x-drawerSlideWidth*2,
        y=outerChest.y, //was innerchest
        z=zposLastDivider-zposFirstDivider,
        sideRadius = drawerSlideWidth-fudgeFactor*2);
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
module gridfinity_drawer(
    mode = mode,
    drawerInnerWidth = drawer_inner_width,
    drawerInnerDepth = drawer_inner_depth,
    drawerInnerHeight = drawer_inner_height,
    drawerCount = drawer_count,
    drawerEnableCustomSizes = drawer_enable_custom_sizes,
    drawerCustomSizes = drawer_custom_sizes,
    clearance = drawer_clearance,
    chestWallThickness = chest_wall_thickness,
    chestDrawerSlideThickness = chest_drawer_slide_thickness,
    chestDrawerSlideWidth = chest_drawer_slide_width,
    handleSize = handle_size,
    drawerWallThickness = drawer_wall_thickness,
    drawerBase = drawer_base,
    drawerGridStyle = drawer_grid_style,
    chestEnableTopGrid = chest_enable_top_grid,
    chestTopGridStyle = chest_top_grid_style,
    bottomGrid = chest_bottom_grid,
    bottomMagnetDiameter = magnet_diameter,
    bottomScrewDepth = screw_depth,
    bottomHoleOverhangRemedy = hole_overhang_remedy,
    bottomCornerAttachmentsOnly = chest_corner_attachments_only,
    bottomHalfPitch = half_pitch,
    bottomFlatBase = flat_base,
    wallPatternBorderWidth = wallpattern_border_width,
    efficientBack = efficient_back,
    wallPatternEnabled = wallpattern_enabled,
    wallPatternStyle = wallpattern_style,
    wallPatternHoleSpacing = wallpattern_hole_spacing,
    wallPatternDividersEnabled = wallpattern_dividers_enabled,
    wallPatternHoleSides = wallpattern_hole_sides,
    wallPatternHoleSize = wallpattern_hole_size,
    wallPatternFill = wallpattern_fill,
    wallPatternVoronoiNoise = wallpattern_voronoi_noise,
    wallPatternVoronoiRadius = wallpattern_voronoi_radius){

  // Apply defaults
  drawerSlideThickness =chestDrawerSlideThickness == 0 ? chestWallThickness : chestDrawerSlideThickness;
  ridgeDepth = wallPatternBorderWidth < 0 ? chestWallThickness/abs(wallPatternBorderWidth) : wallPatternBorderWidth;

  // Calculate global dimensions 
  drawerInnerHeights = drawerEnableCustomSizes ? drawerCustomSizes : [for([0:drawerCount-1]) drawerInnerHeight];
  drawerCount = len(drawerInnerHeights);

  drawerInnerUnitSize = [drawerInnerWidth, drawerInnerDepth];
  drawerInnerSizes = [for(i = [0:drawerCount-1]) [
    (drawerInnerWidth*gf_pitch) + clearance - 0.25,
    (drawerInnerDepth*gf_pitch) + clearance - 0.25,
    (drawerInnerHeights[i]*gf_zpitch) + clearance + 4.25 + (drawerGridStyle == "magnet" ? gf_baseplate_magnet_thickness : 0)
  ]];

  drawerOuterSizes = [for(i = [0:drawerCount-1]) [
    drawerInnerSizes[i].x + (drawerWallThickness * 2),
    drawerInnerSizes[i].y + (drawerWallThickness * 2),
    drawerInnerSizes[i].z + ((drawerBase == "floor" || drawerBase == "default") ? drawerWallThickness : 0)
  ]];
    
  outerChest = [
    drawerOuterSizes[0].x + (clearance * 2) + (chestWallThickness * 2),
    drawerOuterSizes[0].y + (clearance * 2) + (chestWallThickness)];

  totalH = sum(drawerOuterSizes).z + (clearance*2*drawerCount) + drawerSlideThickness * (drawerCount - 1) + chestWallThickness*2;

  startH = chestWallThickness;


  if(mode == "chest" || mode == "everything")      
    chest(
      outerChest=outerChest, 
      totalH=totalH,
      chestWallThickness=chestWallThickness,
      enableTopGrid=chestEnableTopGrid,
      topGridStyle=chestTopGridStyle,
      //ridgeDepth=ridgeDepth,
      bottomGrid=bottomGrid,
      bottomMagnetDiameter=bottomMagnetDiameter,
      bottomScrewDepth=bottomScrewDepth,
      bottomHoleOverhangRemedy=bottomHoleOverhangRemedy,
      bottomCornerAttachmentsOnly=bottomCornerAttachmentsOnly,
      bottomHalfPitch=bottomHalfPitch,
      bottomFlatBase=bottomFlatBase,
      drawerCount=drawerCount,
      drawerInnerUnitSize=drawerInnerUnitSize,
      drawerOuterSizes=drawerOuterSizes,
      drawerSlideThickness=drawerSlideThickness,
      drawerWallThickness=drawerWallThickness,
      startH=startH,
      clearance=clearance)
      chestCutouts(
        drawerCount=drawerCount, 
        drawerOuterSizes=drawerOuterSizes,
        ridgeDepth=ridgeDepth,
        drawerSlideThickness=drawerSlideThickness,
        drawerSlideWidth=chestDrawerSlideWidth,
        startH=startH,
        outerChest=outerChest,
        clearance=clearance,
        chestWallThickness=chestWallThickness,
        efficientBack=efficientBack,
        wallPatternBorderWidth=wallPatternBorderWidth,
        wallPatternEnabled=wallPatternEnabled,
        wallPatternStyle=wallPatternStyle,
        wallPatternHoleSpacing=wallPatternHoleSpacing,
        wallPatternDividersEnabled=wallPatternDividersEnabled,
        wallPatternHoleSides=wallPatternHoleSides,
        wallPatternHoleSize=wallPatternHoleSize,
        wallPatternFill=wallPatternFill,
        wallPatternVoronoiNoise=wallPatternVoronoiNoise,
        wallPatternVoronoiRadius=wallPatternVoronoiNoise);
  if(mode == "drawers" || mode == "everything")
    drawers(
      drawerCount=drawerCount,
      innerUnitSize=drawerInnerUnitSize,
      innerSizes=drawerInnerSizes,
      outerSizes=drawerOuterSizes,
      drawerBase=drawerBase,
      wallThickness=drawerWallThickness,
      handleSize=handleSize,
      ridgeDepth=ridgeDepth,
      startH=startH,
      clearance=clearance,
      chestWallThickness=chestWallThickness,
      gridStyle=drawerGridStyle);
  if(mode == "onedrawer")   
    drawer(
      drawerIndex=0,
      innerUnitSize=drawerInnerUnitSize,
      drawerBase= drawerBase,
      wallThickness = drawerWallThickness,
      handleSize = handleSize,
      innerSizes = drawerInnerSizes,
      outerSizes = drawerOuterSizes,
      gridStyle=drawerGridStyle);
}

gridfinity_drawer(
/*  mode = mode,
  drawerInnerWidth = drawer_inner_width,
  drawerInnerDepth = drawer_inner_depth,
  drawerInnerHeight = drawer_inner_height,
  drawerCount = drawer_count,
  drawerEnableCustomSizes = drawer_enable_custom_sizes,
  drawerCustomSizes = drawer_custom_sizes,
  clearance = clearance,
  chestWallThickness = chest_wall_thickness,
  chestDrawerSlideThickness = chest_drawer_slide_thickness,
  chestDrawerSlideWidth = chest_drawer_slide_width,
  handleSize = handle_size,
  wallThicknessInner = wallthicknessInner,
  drawerBase = drawerbase,
  drawerGridStyle = drawer_grid_style,
  chestEnableTopGrid = chest_enable_top_grid,
  chestTopGridStyle = chest_top_grid_style,
  bottomGrid = bottomgrid,
  magnetDiameter = magnet_diameter,
  screwDepth = screw_depth,
  holeOverhangRemedy = hole_overhang_remedy,
  chestCornerAttachmentsOnly = chest_corner_attachments_only,
  halfPitch = half_pitch,
  flatBase = flat_base,
  wallPatternBorderWidth = wallpattern_border_width,
  efficientBack = efficientback,
  wallPatternEnabled = wallpattern_enabled,
  wallPatternStyle = wallpattern_style,
  wallPatternHoleSpacing = wallpattern_hole_spacing,
  wallPatternDividersEnabled = wallpattern_dividers_enabled,
  wallPatternHoleSides = wallpattern_hole_sides,
  wallPatternHoleSize = wallpattern_hole_size,
  wallPatternFill = wallpattern_fill,
  wallPatternVoronoiNoise = wallpattern_voronoi_noise,
  wallPatternVoronoiRadius = wallpattern_voronoi_radius*/
);
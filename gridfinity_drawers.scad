// Gridfinity drawer system.
// Intended for Gridfinity bins to sit in the drawers, meaning the outer chest will not fit neatly on to a gridfinity grid.
//
// Original OpenSCAD design was provided by @monniasza
// Inspiration for their design was https://www.printables.com/pl/model/363389
// The design has diveated sigficantly, I would not consider this compatiable with the orginal.

use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity.scad>
use <modules/module_gridfinity_baseplate.scad>
include <modules/gridfinity_constants.scad>
use <modules/module_item_holder.scad>

/* [Render] */
mode = "everything"; //[everything:Everything, onedrawer:Single Drawer, drawers:All drawers, chest:Chest]
position="center"; //["center","zero"]

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
//clearance inside the drawers
drawer_clearance = [0.25,0.25,0.25];

//clearance inside the chest
chest_clearance = [0.25,0.25,0.25];

chest_wall_thickness = 2;
//Thickness of drawer slies in mm. 0 is uses wall thickenss.
chest_drawer_slide_thickness = 0;
//Width of drawer slies in mm. 0 is full chest width.
chest_drawer_slide_width = 10; 

/* [Drawer] */
// Handle size width, depth, height, and radius. Height, less than 0 drawerHeight/abs(height). radius, -1 = depth/2. 
handle_size = [4, 10, -1, -1];
handle_verticle_center = false;
handle_rotate = false;
drawer_wall_thickness = 2;
drawer_base = "default"; //[grid:Grid only, floor:floor only, default:Grid and floor]
drawer_grid_style = "default";//[default:Default, magnet:Efficient magnet base]

/* [Chest Top Plate] */
chest_top_wallpattern_style = "none"; //[none, grid, gridrotated, hexgrid,hexgridrotated, voronoi,voronoigrid,voronoihexgrid]
chest_enable_top_grid = true;
// Plate Style
chest_top_grid_style = "default";//[default:Default, magnet:Efficient magnet base]

/* [Chest Base] */
chest_bottom_wallpattern_style = "none"; //[none, grid, gridrotated, hexgrid,hexgridrotated, voronoi,voronoigrid,voronoihexgrid]
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
// Grid wall patter
wallpattern_enabled=false;
// wall pattern border width. -1 defaults to chest_wall_thickness. less than 0 chest_wall_thickness/abs(wallpattern_border_width)
wallpattern_border_width = -1;
efficient_back = true;
// Style of the pattern
wallpattern_style = "hexgrid"; //[grid, gridrotated, hexgrid,hexgridrotated, voronoi,voronoigrid,voronoihexgrid]
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = 8; //0.1
// pattern fill mode
wallpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
wallpattern_voronoi_noise = 0.75;
wallpattern_voronoi_radius = 0.5;

/* [Hidden] */
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
  clearanceTotal = clearance.z*2*(index),
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
  handleVerticleCenter,
  handleRotate,
  ridgeDepth,
  startH,
  chestClearance,
  chestWallThickness,
  gridStyle,
  drawerClearance)
{
  assert(is_list(chestClearance) && len(chestClearance) == 3, "chestClearance must be a list of length 3");
  assert(is_list(drawerClearance) && len(drawerClearance) == 3, "drawerClearance must be a list of length 3");

  offsetW = chestWallThickness + chestClearance.x;
  
  for(i = [0 : drawerCount-1]){
    //IncrementH = 0;
    zpos = startH + drawerPosition(i, outerSizes, chestClearance, ridgeDepth);
    //(clearance * i) + (i<1 ? 0 : sum(partial(drawerOuterSizes,0,i-1)).z);
    if(IsHelpEnabled("debug")) echo("drawers", i= i, StartH=StartH, clearance=clearance, height=drawerInnerHeights[i], zpos=zpos, drawerOuterz=drawerOuterSizes.z, drawerInnerz=drawerInnerSizes.z, drawerOuterSizes.z);
      
    translate([chestWallThickness+chestClearance.x, offsetW, zpos]) 
      drawer(drawerIndex=i,
        innerUnitSize=innerUnitSize,
        drawerBase=drawerBase,// = drawerbase,
        wallThickness=wallThickness,// = wallthicknessInner,
        handleSize=handleSize,
        handleVerticleCenter=handleVerticleCenter,
        handleRotate=handleRotate,
        innerSizes=innerSizes,
        outerSizes=outerSizes,
        gridStyle=gridStyle,
        clearance=drawerClearance);
  }
}

module drawer(
  drawerIndex,
  innerUnitSize,
  drawerBase,// = drawerbase,
  wallThickness,// = wallthicknessInner,
  handleSize,
  handleVerticleCenter,
  handleRotate,
  innerSizes,// = drawerInnerSizes,
  outerSizes,// = drawerOuterSizes,
  gridStyle,
  clearance)
{
  assert(is_list(clearance) && len(clearance) == 3, "clearance must be a list of length 3");
  drawerFloor = (drawerBase == "default" || drawerBase == "floor");
  floorThickness = wallThickness;
  
  union(){
    difference(){
      color(colour_drawer)
      roundedCube(
        x=outerSizes[drawerIndex].x,
        y=outerSizes[drawerIndex].y,
        z=outerSizes[drawerIndex].z,
        sideRadius = 6);
        
      translate([wallThickness, wallThickness, floorThickness-fudgeFactor]) 
        color(colour_drawer)
        roundedCube(
          //remove the main grid space
          x=innerSizes[drawerIndex].x-fudgeFactor*2,
          y=innerSizes[drawerIndex].y-fudgeFactor*2,
          z=innerSizes[drawerIndex].z+fudgeFactor*2,
          sideRadius = 4);
          if(drawerBase == "grid"){
            translate([wallThickness+clearance.x/2+0.25,wallThickness+clearance.y/2+0.25, -fudgeFactor]) 
            roundedCube(
              x=gf_pitch*innerUnitSize.x-0.5,
              y=gf_pitch*innerUnitSize.y-0.5,
              z=floorThickness+fudgeFactor,
              sideRadius = 4);
        }
      }
      
      if(drawerBase == "default" || drawerBase == "grid"){
        translate([
          wallThickness+clearance.x/2,
          wallThickness+clearance.y/2, 
          (drawerFloor ? floorThickness-fudgeFactor : 0)-fudgeFactor*2]) 
          baseplate(
            width = innerUnitSize.x,
            depth = innerUnitSize.y,
            plateStyle = "base",
            plateOptions = gridStyle);
      }

    handelHeight = handleSize.z == 0 ? outerSizes[drawerIndex].z/2
      : handleSize.z <0 ? outerSizes[drawerIndex].z/abs(handleSize.z) : handleSize.z;
      
    //Drawer handle
    color(colour_drawer_pull)
    translate([
        outerSizes[drawerIndex].x/2, 
        0, 
        handleVerticleCenter 
          ? outerSizes[drawerIndex].z/2  
          : handleRotate ? handleSize.x/2 : handelHeight/2])
      rotate(handleRotate ? [0,90,0] : [0,0,0])
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
  assert(is_list(clearance), "clearance must be a list");
  bottomGridOffset = [
    chestWallThickness + clearance.x + (drawerOuterSizes[0].x-drawerInnerUnitSize.x*gf_pitch)/2,
    chestWallThickness + clearance.y + (drawerOuterSizes[0].y-drawerInnerUnitSize.y*gf_pitch)/2, 0];
    
  topGridOffset = [bottomGridOffset.x - 0.25, bottomGridOffset.y - 0.25,0];
    
  difference(){
    union(){
      color(colour_chest) 
      cube([outerChest.x, outerChest.y, totalH]);
      
      if(bottomGrid) {
        baseHeight=0.7;
        translate(bottomGridOffset) 
        tz(-gf_zpitch*baseHeight+fudgeFactor)
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
        translate(topGridOffset) 
        tz(totalH-fudgeFactor) 
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
  topWallPatternStyle,
  bottomWallpatternStyle,
  wallPatternBorderWidth,
  wallPatternEnabled,
  wallpatternStyle,
  wallPatternWtyle,
  wallPatternHoleSpacing,
  wallPatternHoleSides,
  wallPatternHoleSize,
  wallPatternFill,
  wallPatternVoronoiNoise,
  wallPatternVoronoiRadius
){
  wallPattern_thickness = chestWallThickness+fudgeFactor*2;

  for(iDrawer = [0 : drawerCount-1]){
    innerchest = [
      drawerOuterSizes[iDrawer].x + clearance.x*2,
      drawerOuterSizes[iDrawer].y + clearance.y*2,
      drawerOuterSizes[iDrawer].z + clearance.z*2];
 
    //positions for wall cutouts
    back = [
      [innerchest.z-ridgeDepth*2,innerchest.x-ridgeDepth*2], //size
      [innerchest.x/2+chestWallThickness, innerchest.y+chestWallThickness/2-wallPattern_thickness/2, innerchest.z/2], //location
      [0,90,90]]; //rotation 
    left = [
      [innerchest.z-ridgeDepth*2,innerchest.y-ridgeDepth*2],    //size
      [+chestWallThickness/2-wallPattern_thickness/2, (innerchest.y+chestWallThickness)/2, innerchest.z/2], //location
      [0,90,0]];//rotation
    right = [
      [innerchest.z-ridgeDepth*2,innerchest.y-ridgeDepth*2],//size
      [innerchest.x+chestWallThickness*1.5-wallPattern_thickness/2, (innerchest.y+chestWallThickness)/2, innerchest.z/2],//location
      [0,90,0]];//rotation

    locations = [back, left, right];
  
    vpos = startH + drawerPosition(iDrawer, drawerOuterSizes, clearance, drawerSlideThickness);
    echo(startH=startH, vpos=vpos );
    color(colour_chest) 
    translate([chestWallThickness, -fudgeFactor, vpos]) 
      cube([innerchest.x, innerchest.y+fudgeFactor, innerchest.z]);
        
    if(efficientBack) 
      translate(back[1])
      translate([-back[0][1]/2, 0, vpos-back[0][0]/2])
      cube([back[0][1], wallPattern_thickness, back[0][0]]);
    
    if(wallPatternEnabled)
      translate([0, 0, vpos]) 
      for(iSide = [efficientBack ? 1 : 0:1:len(locations)-1])
        translate(locations[iSide][1])
        rotate(locations[iSide][2])
        render() //Render on chest pattern because detailed patters can be slow
        cutout_pattern(
          patternStyle = wallpatternStyle,
          canvasSize = locations[iSide][0],
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
  
  top = [
    [outerChest.x-ridgeDepth*2,outerChest.y-ridgeDepth*2], //size
    [outerChest.x/2, outerChest.y/2, outerChest.z-chestWallThickness-fudgeFactor], //location
    [0,0,0],
    topWallPatternStyle]; //rotation  
  bottom = [
    [outerChest.x-ridgeDepth*2,outerChest.y-ridgeDepth*2], //size
    [outerChest.x/2, outerChest.y/2, -fudgeFactor], //location
    [0,0,0],
    bottomWallpatternStyle]; //rotation 
      
  for(side = [top, bottom])  
    if(side[3] != "none")
      translate(side[1])
      rotate(side[2])
      render() //Render on chest pattern because detailed patters can be slow
        cutout_pattern(
          patternStyle = side[3],
          canvasSize = side[0],
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
  rotateGrid = true,
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
      border=0,
      help=help);
  }
  else if(patternStyle == "voronoi" || patternStyle == "voronoigrid" || patternStyle == "voronoihexgrid"){
    rectangle_voronoi(
      canvasSize = [canvasSize.x,canvasSize.y,holeHeight], 
      spacing = holeSpacing.x, 
      cellsize = holeSize.x,
      grid = (patternStyle == "voronoigrid" || patternStyle == "voronoihexgrid"),
      gridOffset = (patternStyle == "voronoihexgrid"),
      noise=voronoiNoise,
      radius = voronoiRadius);
  }
}

//render function
module gridfinity_drawer(
    mode = mode,
    position = position,
    drawerInnerWidth = drawer_inner_width,
    drawerInnerDepth = drawer_inner_depth,
    drawerInnerHeight = drawer_inner_height,
    drawerCount = drawer_count,
    drawerEnableCustomSizes = drawer_enable_custom_sizes,
    drawerCustomSizes = drawer_custom_sizes,
    drawerClearance = drawer_clearance,
    chestClearance = chest_clearance,
    chestWallThickness = chest_wall_thickness,
    chestDrawerSlideThickness = chest_drawer_slide_thickness,
    chestDrawerSlideWidth = chest_drawer_slide_width,
    handleSize = handle_size,
    handleVerticleCenter = handle_verticle_center,
    handleRotate = handle_rotate,
    drawerWallThickness = drawer_wall_thickness,
    drawerBase = drawer_base,
    drawerGridStyle = drawer_grid_style,
    chestEnableTopGrid = chest_enable_top_grid,
    chestTopWallPatternStyle=chest_top_wallpattern_style,
    chestTopGridStyle = chest_top_grid_style,
    bottomGrid = chest_bottom_grid,
    bottomWallpatternStyle = chest_bottom_wallpattern_style,
    bottomMagnetDiameter = magnet_diameter,
    bottomScrewDepth = screw_depth,
    bottomHoleOverhangRemedy = hole_overhang_remedy,
    bottomCornerAttachmentsOnly = chest_corner_attachments_only,
    bottomHalfPitch = half_pitch,
    bottomFlatBase = flat_base,
    wallPatternBorderWidth = wallpattern_border_width,
    efficientBack = efficient_back,
    wallPatternEnabled = wallpattern_enabled,
    wallpatternStyle = wallpattern_style,
    wallPatternHoleSpacing = wallpattern_hole_spacing,
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
    (drawerInnerWidth*gf_pitch) + drawerClearance.x,
    (drawerInnerDepth*gf_pitch) + drawerClearance.y,
    (drawerInnerHeights[i]*gf_zpitch) + drawerClearance.z + 4.25 + (drawerGridStyle == "magnet" ? gf_baseplate_magnet_thickness : 0)
  ]];
    
  drawerOuterSizes = [for(i = [0:drawerCount-1]) [
    drawerInnerSizes[i].x + (drawerWallThickness * 2),
    drawerInnerSizes[i].y + (drawerWallThickness * 2),
    drawerInnerSizes[i].z + ((drawerBase == "floor" || drawerBase == "default") ? drawerWallThickness : 0)
  ]];
    
  outerChest = [
    drawerOuterSizes[0].x + (chestClearance.x * 2) + (chestWallThickness * 2),
    drawerOuterSizes[0].y + (chestClearance.y * 2) + (chestWallThickness),
    sum(drawerOuterSizes).z + (chestClearance.z*2*drawerCount) + drawerSlideThickness * (drawerCount - 1) + chestWallThickness*2];
    
  totalH = outerChest.z;

  startH = chestWallThickness;

  translate(position == "center" ? [-outerChest.x/2,-outerChest.y/2,0] : [0,0,0])
  union(){
  if(mode == "chest" || mode == "everything")      
    chest(
      outerChest=outerChest, 
      totalH=totalH,
      chestWallThickness=chestWallThickness,
      enableTopGrid=chestEnableTopGrid,
      topGridStyle=chestTopGridStyle,
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
      clearance=chestClearance)
      chestCutouts(
        drawerCount=drawerCount, 
        drawerOuterSizes=drawerOuterSizes,
        ridgeDepth=ridgeDepth,
        drawerSlideThickness=drawerSlideThickness,
        drawerSlideWidth=chestDrawerSlideWidth,
        startH=startH,
        outerChest=outerChest,
        clearance=chestClearance,
        chestWallThickness=chestWallThickness,
        efficientBack=efficientBack,
        topWallPatternStyle=chestTopWallPatternStyle,
        bottomWallpatternStyle = bottomWallpatternStyle,
        wallPatternBorderWidth=wallPatternBorderWidth,
        wallPatternEnabled=wallPatternEnabled,
        wallpatternStyle=wallpatternStyle,
        wallPatternHoleSpacing=wallPatternHoleSpacing,
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
      handleVerticleCenter=handleVerticleCenter,
      handleRotate=handleRotate,
      ridgeDepth=ridgeDepth,
      startH=startH,
      chestClearance=chestClearance,
      chestWallThickness=chestWallThickness,
      gridStyle=drawerGridStyle,
      drawerClearance=drawerClearance);
  if(mode == "onedrawer")   
    drawer(
      drawerIndex=0,
      innerUnitSize=drawerInnerUnitSize,
      drawerBase= drawerBase,
      wallThickness = drawerWallThickness,
      handleSize = handleSize,
      handleVerticleCenter=handleVerticleCenter,
      handleRotate=handleRotate,
      innerSizes = drawerInnerSizes,
      outerSizes = drawerOuterSizes,
      gridStyle=drawerGridStyle,
      clearance=drawerClearance);
  }
}

gridfinity_drawer();
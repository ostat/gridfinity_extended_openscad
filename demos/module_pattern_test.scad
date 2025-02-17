include <../modules/module_patterns.scad>

$fn = 64;
fudgeFactor = 0.01;
help = true;
module Highlight(size = [50,50,1], txt="",txt2=""){
  union(){
    if(txt != "")
    {
      translate([0,size[1]+3+8,0])
      text(txt, size=5);
    }
    if(txt2 != "")
    {
      translate([0,size[1]+3,0])
      text(txt2, size=4);
    }
    color("DarkGreen")
    translate([0,0,-size.z-fudgeFactor*3])
    cube(size);
    children(0);
    color("LightCoral")
    children(1);
  }
}
  
module show_pattern( 
  name,  
  desc,
  patternStyle,
  fill="fill",
  canvasSize = [canvis_length,canvis_length], 
  holeSize = [10,5],
  holeSpacing = [2,2],
  center = true,
  height=thickness,
  border = 5,
  patternGridChamfer=0,
  patternVoronoiNoise=0.5,
  patternBrickWeight=5,
  thickness = 5){
  
  Highlight(
    size = [canvasSize.x,canvasSize.y,1],
    txt = name,
    txt2 =desc
  ){
  translate(center ? [canvasSize.x/2,canvasSize.y/2,0] : [0,0,0])
  color("red")
  cylinder(r=2, h=height*2.2, center=true);
  if(fill == PatternFill_none 
      || patternStyle == PatternStyle_grid 
      || patternStyle == PatternStyle_gridrotated 
      || patternStyle == PatternStyle_hexgrid 
      || patternStyle == PatternStyle_hexgridrotated)
  translate(center ? [canvasSize.x/2,canvasSize.y/2,0] : [0,0,0])
  cutout_pattern(
    patternStyle,
    canvasSize = canvasSize,
    customShape = false,
    circleFn = 6,
    holeSize = holeSize,
    holeSpacing = holeSpacing,
    holeHeight = height,
    holeRadius = 2,
    center = center,
    centerz = false,
    fill = fill,
    patternGridChamfer=patternGridChamfer,
    patternVoronoiNoise=patternVoronoiNoise,
    patternBrickWeight=patternBrickWeight,
    border = border,
    patternFs = 0,
    source = name);
  }
}

PatternStyle_grid = "grid";
PatternStyle_gridrotated = "gridrotated";
PatternStyle_hexgrid = "hexgrid";
PatternStyle_hexgridrotated = "hexgridrotated";
PatternStyle_voronoi = "voronoi";
PatternStyle_voronoigrid = "voronoigrid";
PatternStyle_voronoihexgrid = "voronoihexgrid";
PatternStyle_brick = "brick";
PatternStyle_brickrotated = "brickrotated";
PatternStyle_brickoffset = "brickoffset";
PatternStyle_brickoffsetrotated = "brickoffsetrotated";

spacing = 4;
canvis_length = 75;
thickness = 5;

height = canvis_length+20;

  //translate([-spacing,-spacing,1])
  //cube([canvis_length+spacing*2,70+spacing*2,1]);
  for(iPattern=[0:len(PatternStyle_values)-1]){
    pattern = PatternStyle_values[iPattern];
    
    for(iFill=[0:len(PatternFill_values)-1]){
      fill = PatternFill_values[iFill];
      echo(iPattern=iPattern, pattern=pattern, iFill=iFill, fill=fill);
      translate([(canvis_length+spacing)*iFill,0,0])
      union(){
        translate([0,(height+spacing)*(0+4*iPattern),0])
        show_pattern(
          name = str(pattern, " centered"),
          desc = fill,
          patternStyle = pattern,
          fill = fill,
          border=0,
          center=true);
        translate([0,(height+spacing)*(1+4*iPattern),0])
        show_pattern(
          name = str(pattern),
          desc = fill,
          patternStyle = pattern,
          fill = fill,
          border=0,
          center=false);
        translate([0,(height+spacing)*(2+4*iPattern),0])
        show_pattern(
          name = str(pattern, " centered"),
          desc = fill,
          patternStyle = pattern,
          fill = fill,
          border=5,
          center=true);
        translate([0,(height+spacing)*(3+4*iPattern),0])
        show_pattern(
          name = str(pattern),
          desc = fill,
          patternStyle = pattern,
          fill = fill,
          border=5,
          center=false);
      }
    }
  }

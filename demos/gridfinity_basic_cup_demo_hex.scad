use <../gridfinity_basic_cup.scad>
include <../modules/gridfinity_constants.scad>

module gridfinity_basic_cup_demo(
  height = 3,
  width = 1,
  depth = 2){

  wallpattern_hole_size = height > 12 ? 10
                          : height > 5 ? 7 : 4;
                          
  wallpattern_hole_spacing = height > 12 ? 3
                          : height > 5 ? 3 : 2;
  gridfinity_basic_cup(      
  height = height,
  width = width,
  depth = depth,
  magnet_diameter = 6.5,
  screw_depth = 6,
  wallpattern_enabled=true,
  wallpattern_hexgrid=true,
  wallpattern_walls=[1,1,1,1],
  wallpattern_fill="crophorizontal",
  wallpattern_hole_sides=6,
  wallpattern_hole_size=wallpattern_hole_size,
  wallpattern_hole_spacing=wallpattern_hole_spacing);
}

space = [0.2,0.5];
heights = [3,5,7];

for(i = [0 : len(heights)-1])
{
  color("GhostWhite")
  translate([0, gridfinity_pitch*(3+space.y)*i, 0])
  gridfinity_basic_cup_demo(
    height = heights[i],
    width = 0.5,
    depth = 2);
    
  translate([gridfinity_pitch*(0.5+space.x), gridfinity_pitch*(3+space.y)*i, 0])
  color("GhostWhite")
  gridfinity_basic_cup_demo(
    height = heights[i],
    width = 1,
    depth = 2);
    
  color("GhostWhite")
  translate([gridfinity_pitch*(1.5+space.x*2), gridfinity_pitch*(3+space.y)*i, 0])
  gridfinity_basic_cup_demo(
    height = heights[i],
    width = 2,
    depth = 2);
}
include <../modules/module_voronoi.scad>

module Highlight(size = [100,100,1], txt=""){
  color("LightCoral")
  translate([-size[0]/2,size[1]/2+3,0])
  text(txt, size=5);
  color("DarkGreen")
  children();
}

space=15;
canvasSize = [100,50,10];
cellsize = 10;

// Row 1: Default behavior (no border fill)
Highlight(txt="Grid - Default", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, noise=0.75, cellsize=cellsize);

translate([(canvasSize.x+space),0,0])
Highlight(txt="Grid Offset - Default", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, gridOffset=true, noise=0.75, cellsize=cellsize);

translate([(canvasSize.x+space)*2,0,0])
Highlight(txt="Random - Default", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=false, cellsize=cellsize);

// Row 2: With border fill enabled (prevents overhangs)
translate([0,(canvasSize.y+space),0])
Highlight(txt="Grid - Fill Border", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, noise=0.75, cellsize=cellsize, fillBorderCells=true);

translate([(canvasSize.x+space),(canvasSize.y+space),0])
Highlight(txt="Grid Offset - Fill Border", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, gridOffset=true, noise=0.75, cellsize=cellsize, fillBorderCells=true);

translate([(canvasSize.x+space)*2,(canvasSize.y+space),0])
Highlight(txt="Random - Fill Border", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=false, cellsize=cellsize, fillBorderCells=true);

// Row 3: With custom border margin
translate([0,(canvasSize.y+space)*2,0])
Highlight(txt="Grid - Margin 8mm", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, noise=0.75, cellsize=cellsize, fillBorderCells=false, borderMargin=8);

translate([(canvasSize.x+space),(canvasSize.y+space)*2,0])
Highlight(txt="Grid Offset - Margin 8mm", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, gridOffset=true, noise=0.75, cellsize=cellsize, fillBorderCells=false, borderMargin=8);

translate([(canvasSize.x+space)*2,(canvasSize.y+space)*2,0])
Highlight(txt="Random - Margin 8mm", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=false, cellsize=cellsize, fillBorderCells=false, borderMargin=8);

include <../modules/module_voronoi.scad>

module Highlight(size = [100,100,1], txt=""){
  color("LightCoral")
  translate([-size[0]/2,size[1]/2+3,0])
  text(txt, size=5);
  color("DarkGreen")
  children();
}

space=15;
canvasSize = [100,50,1];

Highlight(txt="Random positions", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=false);

translate([(canvasSize.x+space),0,0])
Highlight(txt="Grid 100% noise", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, noise= 1);

translate([(canvasSize.x+space)*2,0,0])
Highlight(txt="Grid off center 100% noise", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, gridOffset=true, noise= 1);

translate([(canvasSize.x+space),(canvasSize.y+space)*2,0])
Highlight(txt="Grid 50% noise", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, noise= 0.5);

translate([(canvasSize.x+space)*2,(canvasSize.y+space)*2,0])
Highlight(txt="Grid off center 50% noise", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, gridOffset=true, noise= 0.5);

translate([(canvasSize.x+space),(canvasSize.y+space),0])
Highlight(txt="Grid 75% noise", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, noise= 0.75);

translate([(canvasSize.x+space)*2,(canvasSize.y+space),0])
Highlight(txt="Grid off center 75% noise", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, gridOffset=true, noise= 0.75);

translate([(canvasSize.x+space),(canvasSize.y+space)*3,0])
Highlight(txt="Grid 25% noise", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, noise= 0.25);

translate([(canvasSize.x+space)*2,(canvasSize.y+space)*3,0])
Highlight(txt="Grid off center 25% noise", size=canvasSize)
rectangle_voronoi(canvasSize=canvasSize, grid=true, gridOffset=true, noise= 0.25);

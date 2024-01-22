include <../modules/voronoi.scad>

module Highlight(size = [100,100,1], txt=""){
  color("LightCoral")
  translate([-size[0]/2,size[1]/2+3,0])
  text(txt, size=5);
  color("DarkGreen")
  children();
}

space=15;
canvisSize = [100,50,1];

Highlight(txt="Random positions", size=canvisSize)
rectangle_voronoi(canvisSize=canvisSize, grid=false);

translate([(canvisSize.x+space),0,0])
Highlight(txt="Grid 100% noise", size=canvisSize)
rectangle_voronoi(canvisSize=canvisSize, grid=true, noise= 1);

translate([(canvisSize.x+space)*2,0,0])
Highlight(txt="Grid off center 100% noise", size=canvisSize)
rectangle_voronoi(canvisSize=canvisSize, grid=true, gridOffset=true, noise= 1);

translate([(canvisSize.x+space),(canvisSize.y+space)*2,0])
Highlight(txt="Grid 50% noise", size=canvisSize)
rectangle_voronoi(canvisSize=canvisSize, grid=true, noise= 0.5);

translate([(canvisSize.x+space)*2,(canvisSize.y+space)*2,0])
Highlight(txt="Grid off center 50% noise", size=canvisSize)
rectangle_voronoi(canvisSize=canvisSize, grid=true, gridOffset=true, noise= 0.5);

translate([(canvisSize.x+space),(canvisSize.y+space),0])
Highlight(txt="Grid 75% noise", size=canvisSize)
rectangle_voronoi(canvisSize=canvisSize, grid=true, noise= 0.75);

translate([(canvisSize.x+space)*2,(canvisSize.y+space),0])
Highlight(txt="Grid off center 75% noise", size=canvisSize)
rectangle_voronoi(canvisSize=canvisSize, grid=true, gridOffset=true, noise= 0.75);

translate([(canvisSize.x+space),(canvisSize.y+space)*3,0])
Highlight(txt="Grid 25% noise", size=canvisSize)
rectangle_voronoi(canvisSize=canvisSize, grid=true, noise= 0.25);

translate([(canvisSize.x+space)*2,(canvisSize.y+space)*3,0])
Highlight(txt="Grid off center 25% noise", size=canvisSize)
rectangle_voronoi(canvisSize=canvisSize, grid=true, gridOffset=true, noise= 0.25);

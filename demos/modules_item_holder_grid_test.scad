use <../modules/module_item_holder.scad>

fudgeFactor = 0.01;
help = true;
module Highlight(size = [50,50,1], txt=""){
  union(){
    if(txt != "")
    {
      translate([0,size[1]+3,0])
      text(txt, size=5);
    }
    color("DarkGreen")
    translate([0,0,-size.z-fudgeFactor*3])
    cube(size);
    color("LightCoral")
    children();
  }
}

hexOptions = [false,true,"auto"];
centerOptions = [false,true];
fillOptions = ["none","space","crop"];

for(filli = [0:1:len(fillOptions)-1])
{
for(centeri = [0:1:len(centerOptions)-1])
{
for(hexi = [0:1:len(hexOptions)-1])
{
  canvasSize = 50;
  canvasSpace = 25;
  scenarios = 5;
  holeSize = 7;
  spacing = [2,2];

  samplei = 0;
  xpos = (canvasSize+canvasSpace)*(scenarios)*centeri;
  ypos = (canvasSize+canvasSpace)*hexi + (canvasSize+canvasSpace)*len(hexOptions)* filli;
  
  txt = str("fill style ", fillOptions[filli], " - center ", centerOptions[centeri], " - hex ", hexOptions[hexi]);
  translate([xpos+canvasSize+5,ypos+canvasSize+10,0])
  text(txt, size=5);
  
  translate([xpos+(canvasSize+canvasSpace)*0,ypos,0])
  Highlight([canvasSize,canvasSize,1], "square")
  translate(centerOptions[centeri] ? [canvasSize/2,canvasSize/2,0] : [0,0,0])
  GridItemHolder(
    canvasSize = [canvasSize,canvasSize],
    hexGrid = hexOptions[hexi],
    holeSize = [holeSize,2*holeSize],
    holeSpacing = spacing,
    holeGrid = [0,0],
    holeHeight = holeSize,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = true)
    cube([holeSize,2*holeSize,holeSize]);

  translate([xpos+(canvasSize+canvasSpace)*1,ypos,0])
  Highlight([canvasSize,canvasSize,1], "square")
  translate(centerOptions[centeri] ? [canvasSize/2,canvasSize/2,0] : [0,0,0])
  GridItemHolder(
    canvasSize = [canvasSize,canvasSize],
    hexGrid = hexOptions[hexi],
    holeSize = [2*holeSize,holeSize],
    holeSpacing = spacing,
    holeGrid = [0,0],
    holeHeight = holeSize,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = true)
    cube([2*holeSize,holeSize,holeSize]);
    
  translate([xpos+(canvasSize+canvasSpace)*2,ypos,0])
  Highlight([canvasSize,canvasSize,1], "hex")
  translate(centerOptions[centeri] ? [canvasSize/2,canvasSize/2,0] : [0,0,0])
  GridItemHolder(
    canvasSize = [canvasSize,canvasSize],
    hexGrid = hexOptions[hexi],
    circleFn = 6,
    holeSize = [holeSize,holeSize],
    holeSpacing = spacing,
    holeGrid = [0,0],
    holeHeight = holeSize,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = false);

  translate([xpos+(canvasSize+canvasSpace)*3,ypos,0])
  Highlight([canvasSize,canvasSize,1], "circle")
  translate(centerOptions[centeri] ? [canvasSize/2,canvasSize/2,0] : [0,0,0])
  GridItemHolder(
    canvasSize = [canvasSize,canvasSize],
    hexGrid = hexOptions[hexi],
    circleFn = 64,
    holeSize = [holeSize,holeSize],
    holeSpacing = spacing, //should this be 2 or 7
    holeGrid = [0,0],
    holeHeight = holeSize,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = false);
    
  translate([xpos+(canvasSize+canvasSpace)*4,ypos,0])
  Highlight([canvasSize,canvasSize,1], "sqaure")
  translate(centerOptions[centeri] ? [canvasSize/2,canvasSize/2,0] : [0,0,0])
  GridItemHolder(
    canvasSize = [canvasSize,canvasSize],
    hexGrid = hexOptions[hexi],
    circleFn = 4,
    holeSize = [holeSize,holeSize],
    holeSpacing = spacing, //should this be 2 or 7
    holeGrid = [0,0],
    holeHeight = holeSize,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = false);
}
}
}

for(filli = [0:1:len(fillOptions)-1])
{
for(centeri = [0:1:len(centerOptions)-1])
{
for(hexi = [0:1:len(hexOptions)-1])
{
  canvasSize = [162,120,0];
  canvasSpace = 25;
  scenarios = 1;
  holeSize = 7;
  spacing = [2,2];

  xpos = (canvasSize[0]+canvasSpace)*(scenarios)*centeri;
  ypos = (canvasSize[1]+canvasSpace)*hexi + (canvasSize[1]+canvasSpace)*len(hexOptions)* filli;
  
  txt = str("fill style ", fillOptions[filli], " - center ", centerOptions[centeri], " - hex ", hexOptions[hexi]);
  translate([xpos+(canvasSize.x+canvasSpace)*4,ypos+canvasSize[1]+10,0])
  text(txt, size=5);
  
  //translate([(canvasSize[0]+canvasSpace)*10,ypos,0])
  translate([xpos+(canvasSize.x+canvasSpace)*4,ypos,0])
  Highlight([162, 120,1], "sqaure")
  translate(centerOptions[centeri] ? canvasSize/2 : [0,0,0])
  GridItemHolder(
    canvasSize = [162, 120],
    hexGrid = hexOptions[hexi],
    circleFn = 64,
    holeSize = [18.65,18.65],
    holeSpacing = [2,2], //should this be 2 or 7
    holeGrid = [0,0],
    holeHeight = 5,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = false);
 }}}
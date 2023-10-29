use <../modules/modules_item_holder.scad>

fudgeFactor = 0.01;
help = false;
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

hexOptions = [true,false];
centerOptions = [false,true];
fillOptions = ["none","space","crop"];

canvisSize = 50;
canvisSpace = 25;
scenarios = 5;
holeSize = 7;
spacing = [2,2];

for(filli = [0:1:len(fillOptions)-1])
{
for(centeri = [0:1:len(centerOptions)-1])
{
for(hexi = [0:1:len(hexOptions)-1])
{
  samplei = 0;
  ypos = (canvisSize+canvisSpace) * (hexi) + (canvisSize+canvisSpace)*2* filli;
  xpos = (canvisSize+canvisSpace)*(scenarios)*centeri;
  
  txt = str("fill style ", fillOptions[filli], " - center ", centerOptions[centeri], " - hex ", hexOptions[hexi]);
  translate([xpos+canvisSize+5,ypos+canvisSize+10,0])
  text(txt, size=5);
  
  translate([xpos+(canvisSize+canvisSpace)*0,ypos,0])
  Highlight([canvisSize,canvisSize,1], "square")
  translate(centerOptions[centeri] ? [canvisSize/2,canvisSize/2,0] : [0,0,0])
  GridItemHolder(
    canvisSize = [canvisSize,canvisSize],
    hexGrid = hexOptions[hexi],
    holeSize = [holeSize,2*holeSize],
    holeSpacing = spacing,
    holeGrid = [0,0],
    holeHeight = holeSize,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = true,
    help = help)
    cube([holeSize,2*holeSize,holeSize]);

  translate([xpos+(canvisSize+canvisSpace)*1,ypos,0])
  Highlight([canvisSize,canvisSize,1], "square")
  translate(centerOptions[centeri] ? [canvisSize/2,canvisSize/2,0] : [0,0,0])
  GridItemHolder(
    canvisSize = [canvisSize,canvisSize],
    hexGrid = hexOptions[hexi],
    holeSize = [2*holeSize,holeSize],
    holeSpacing = spacing,
    holeGrid = [0,0],
    holeHeight = holeSize,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = true,
    help = help)
    cube([2*holeSize,holeSize,holeSize]);
    
  translate([xpos+(canvisSize+canvisSpace)*2,ypos,0])
  Highlight([canvisSize,canvisSize,1], "hex")
  translate(centerOptions[centeri] ? [canvisSize/2,canvisSize/2,0] : [0,0,0])
  GridItemHolder(
    canvisSize = [canvisSize,canvisSize],
    hexGrid = hexOptions[hexi],
    circleFn = 6,
    holeSize = [holeSize,holeSize],
    holeSpacing = spacing,
    holeGrid = [0,0],
    holeHeight = holeSize,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = false,
    help = help);

  translate([xpos+(canvisSize+canvisSpace)*3,ypos,0])
  Highlight([canvisSize,canvisSize,1], "circle")
  translate(centerOptions[centeri] ? [canvisSize/2,canvisSize/2,0] : [0,0,0])
  GridItemHolder(
    canvisSize = [canvisSize,canvisSize],
    hexGrid = hexOptions[hexi],
    circleFn = 64,
    holeSize = [holeSize,holeSize],
    holeSpacing = spacing, //should this be 2 or 7
    holeGrid = [0,0],
    holeHeight = holeSize,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = false,
    help = help);
    
  translate([xpos+(canvisSize+canvisSpace)*4,ypos,0])
  Highlight([canvisSize,canvisSize,1], "sqaure")
  translate(centerOptions[centeri] ? [canvisSize/2,canvisSize/2,0] : [0,0,0])
  GridItemHolder(
    canvisSize = [canvisSize,canvisSize],
    hexGrid = hexOptions[hexi],
    circleFn = 4,
    holeSize = [holeSize,holeSize],
    holeSpacing = spacing, //should this be 2 or 7
    holeGrid = [0,0],
    holeHeight = holeSize,
    center=centerOptions[centeri],
    fill=fillOptions[filli],
    customShape = false,
    help = help);
}
}
}
    
  translate([(canvisSize+canvisSpace)*10,0,0])
  Highlight([162, 120,1], "sqaure")
  translate(true ? [162/2,120/2,0] : [0,0,0])
  GridItemHolder(
    canvisSize = [162, 120],
    hexGrid = [0,0],
    circleFn = 64,
    holeSize = [18.65,18.65],
    holeSpacing = [2,2], //should this be 2 or 7
    holeGrid = [0,0],
    holeHeight = 5,
    center=true,
    fill="none",
    customShape = false,
    help = true);
    
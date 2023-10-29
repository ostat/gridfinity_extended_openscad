include <ub.scad>

fudgeFactor = 0.01;

module GridItemHolder(
  canvisSize = [0,0],
  hexGrid = true,
  customShape=false,
  circleFn = 6,
  holeSize = [0,0],
  holeSpacing = [0,0],
  holeGrid = [0,0],
  holeHeight = 0,
  center=false,
  fill="none", //"none", "space", "crop"
  help) 
{
  //Sides, 
  // 0 is circle
  // 4 is square
  // 6 is hex
  //Rc, outer radius is the shape
  //Ri. inner radius of the shape.
  //Ri=Rc * Cos(180/sides)
  Rc = circleFn<=2 || circleFn>16 ? holeSize[0]/2 : (holeSize[0]/2)/cos(180/circleFn);
  
  //For hex in a hex grid we can optomise the spacing, otherwise its too hard      
  Ri = holeSize[0]/2;//(circleFn==6 && hexGrid) || (circleFn==4) ? (holeSize[0]/2) : Rc;
  
  calcHoleDimentions = [
      customShape ? holeSize[0] :
      circleFn == 4 ? Rc*2 : 
      circleFn == 6 ? Rc*2 : Rc*2,
      customShape ? holeSize[1] :
      circleFn == 4 ? Rc*2 : 
      circleFn == 6 ? Ri*2 : Rc*2];

  //x spacing for hex, center to center 
  hexxSpacing = 
    circleFn == 4 ? holeSpacing[1]/2 + calcHoleDimentions[1]/2
    : customShape ? holeSize[0]+holeSpacing[0]
    : sqrt((Ri*2+holeSpacing[0])^2-((calcHoleDimentions[1]+holeSpacing[1])/2)^2);
  intersection(){
    translate([-fudgeFactor,-fudgeFactor,(center?holeHeight/2:0)-fudgeFactor])
    cube([canvisSize[0]+fudgeFactor*2,canvisSize[1]+fudgeFactor*2,holeHeight+fudgeFactor*2], center = center);
    
    if(hexGrid){
      //Calcualte the x and y items count
      e = [
        holeGrid[0] !=0 ? holeGrid[0]
          : floor((canvisSize[0]-calcHoleDimentions[0])/hexxSpacing+1), 
        holeGrid[1] !=0 ? holeGrid[1]
          : floor(((canvisSize[1]+holeSpacing[1])/(calcHoleDimentions[1]+holeSpacing[1])-0.5)*2)/2
        ];
      
      //x and y spacing including the item size.
      es = [
        fill == "space"
          ? calcHoleDimentions[0]+((canvisSize[0]-e[0]*calcHoleDimentions[0])/(e[0]-1)) 
          : hexxSpacing,
        fill == "space"
          ? calcHoleDimentions[1]+((canvisSize[1]-(e[1]+0.5)*calcHoleDimentions[1])/(e[1]-0.5)) 
          : holeSpacing[1] + calcHoleDimentions[1]];
          
      eFill=[
        fill == "crop" ? e[0]+2 : e[0],
        fill == "crop" ? e[1]+2 : e[1]];
        
      /*Grid(4)Text($pos.xy,size=3);
      // Grid but with alternating row offset - hex or circle packing
      HexGrid()circle(d=$es.y);
      HexGrid()circle(d=Umkreis(6,$d-.1),$fn=6);
      HexGrid() children(); creates an interlaced grid of children
      \param e elements [x,y]
      \param es element spacing [x,y]
      \param center true/false or -7 ⇔ 7 for x shift
      \param $d $r $es $idx $idx2 $pos output for children
      \param name help  name help
      module HexGrid(e=[11,4],es=5,center=true,name,help){
      */

      HexGrid(e=eFill, es=es, center=center, help=help)
        if(customShape){
          translate(center ? [-calcHoleDimentions[0]/2,-calcHoleDimentions[1]/2,0] : [0,0,0])
            children();
        } else {
          translate(!center ? [calcHoleDimentions[0]/2,calcHoleDimentions[1]/2,0] : [0,0,0])
            cylinder(h=holeHeight, r=Rc, $fn = circleFn);
        }
    }
    else {
      e = [
        holeGrid[0]!=0 ? holeGrid[0]
          : floor((canvisSize[0]+holeSpacing[0])/(calcHoleDimentions[0]+holeSpacing[0])),
        holeGrid[1]!=0 ? holeGrid[1]
          : floor((canvisSize[1]+holeSpacing[1])/(calcHoleDimentions[1]+holeSpacing[1]))];
          
      es = [
        fill == "space"
          ? calcHoleDimentions[0]+((canvisSize[0]-e[0]*calcHoleDimentions[0])/(e[0]-1)) 
          : calcHoleDimentions[0]+holeSpacing[0],
        fill == "space"
          ? calcHoleDimentions[1]+((canvisSize[1]-e[1]*calcHoleDimentions[1])/(e[1]-1)) 
          : calcHoleDimentions[1]+holeSpacing[1]];
      eFill=[
        fill == "crop" ? e[0]+2 : e[0],
        fill == "crop" ? e[1]+2 : e[1]];
      /*Grid() children(); creates a grid of children
      \param e elements [x,y]
      \param es element spacing [x,y]
      \param s total space ↦ es
      \param center true/false 
      // multiply children in a given matrix (e= number es =distance)
      module Grid(e=[2,2,1],es=10,s,center=true,name,help)
      */
      
      Grid(e=eFill, es=es, center=center, help=help)
        if(customShape){
          translate(center ? [-calcHoleDimentions[0]/2,-calcHoleDimentions[1]/2,0] : [0,0,0])
          children();
        } else {
          translate(center ? [0,0,0] : [calcHoleDimentions[0]/2,calcHoleDimentions[1]/2,0])
            cylinder(h=holeHeight, r=Rc, $fn = circleFn);
        }
    }
  }
  
  HelpTxt("GridItemHolder",[
    "canvisSize",canvisSize
    ,"circleFn",circleFn
    ,"hexGrid",hexGrid
    ,"holeSize",holeSize
    ,"holeSpacing",holeSpacing
    ,"holeGrid",holeGrid
    ,"center",center
    ,"fill",fill
    ,"customShape",customShape
    ,"hexxSpacing",hexxSpacing
    ,"Rc",Rc
    ,"Ri",Ri]
    ,help);
}
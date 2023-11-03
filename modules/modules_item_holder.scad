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
  holeChamfer = 0,
  center=false,
  fill="none", //"none", "space", "crop", "crophorizontal", "cropverticle", "crophorizontal_spaceverticle", "cropverticle_spacehorizontal", "spaceverticle", "spacehorizontal"
  crop = true,
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
  
  //Single lines should not be hex
  hexGrid = 
    canvisSize.x<=holeSize.x+holeSpacing.x || 
    canvisSize.y<=holeSize.y+holeSpacing.y ||
    holeGrid.x ==1 || holeGrid.y ==1 ? false : hexGrid;
  
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
    //Crop to ensure that we dont go outside the bounds 
    
    if(fill == "crop" || fill == "crophorizontal"  || fill == "cropverticle"  || fill ==  "crophorizontal_spaceverticle"  || fill == "cropverticle_spacehorizontal")
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
        fill == "space" || fill == "spaceverticle" ||fill == "crophorizontal_spaceverticle"
          ? calcHoleDimentions[0]+(e[0]<=1?0:((canvisSize[0]-e[0]*calcHoleDimentions[0])/(e[0]-1))) 
          : hexxSpacing,
        fill == "space" || fill == "spacehorizontal" ||fill == "cropverticle_spacehorizontal"
          ? calcHoleDimentions[1]+(e[1]<=0.5?0:((canvisSize[1]-(e[1]+0.5)*calcHoleDimentions[1])/(e[1]-0.5))) 
          : holeSpacing[1] + calcHoleDimentions[1]];
      
      eFill=[
        fill == "crop" || fill == "cropverticle" || fill == "cropverticle_spacehorizontal"
          ? e[0]+2 : e[0],
        fill == "crop" || fill == "crophorizontal" || fill == "crophorizontal_spaceverticle"
          ? e[1]+2 : e[1]];
        
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
            chamferedCylinder(h=holeHeight, r=Rc, chamfer=holeChamfer, circleFn = circleFn);
        }
    }
    else {
      e = [
        holeGrid[0]!=0 ? holeGrid[0]
          : floor((canvisSize[0]+holeSpacing[0])/(calcHoleDimentions[0]+holeSpacing[0])),
        holeGrid[1]!=0 ? holeGrid[1]
          : floor((canvisSize[1]+holeSpacing[1])/(calcHoleDimentions[1]+holeSpacing[1]))];
          
      es = [
        fill == "space" || fill == "spaceverticle" ||fill == "crophorizontal_spaceverticle"
          ? calcHoleDimentions[0]+(e[0]<=1?0:((canvisSize[0]-e[0]*calcHoleDimentions[0])/(e[0]-1))) 
          : calcHoleDimentions[0]+holeSpacing[0],
        fill == "space" || fill == "spacehorizontal" ||fill == "cropverticle_spacehorizontal"
          ? calcHoleDimentions[1]+(e[1]<=1?0:((canvisSize[1]-e[1]*calcHoleDimentions[1])/(e[1]-1)))
          : calcHoleDimentions[1]+holeSpacing[1]];
      
      eFill=[
        fill == "crop" || fill == "cropverticle" || fill == "cropverticle_spacehorizontal"
          ? e[0]+2 : e[0],
        fill == "crop" || fill == "crophorizontal" || fill == "crophorizontal_spaceverticle"
          ? e[1]+2 : e[1]];
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
            chamferedCylinder(h=holeHeight, r=Rc, chamfer=holeChamfer, circleFn = circleFn);
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
    ,"calcHoleDimentions",calcHoleDimentions
    ,"Rc",Rc
    ,"Ri",Ri]
    ,help);
}

module chamferedCylinder(h, r, circleFn, chamfer=0.5) {
  union(){
  cylinder(h=h, r=r, $fn = circleFn);
  translate([0, 0, h-chamfer]) 
    cylinder(h=chamfer, r1=r, r2=r+chamfer,$fn = circleFn);
    }
}

module multiCard(longCenter, smallCenter, side, chamfer = 1, alternate = false){
  union(){
    minspacing = 3;
    translate([(longCenter.x)/2,side.x/2,0])
    union(){
    translate([-(longCenter.x)/2,-longCenter.y/2,0])
    slotCutout([longCenter.x, longCenter.y, longCenter.z+fudgeFactor], chamfer);
    
    translate([-smallCenter.x/2,-smallCenter.y/2,(longCenter.z-smallCenter.z)])
    slotCutout([smallCenter.x, smallCenter.y, smallCenter.z+fudgeFactor], chamfer);
    
    
    if(alternate){
      pos = let(targetPos = (longCenter.x)/4-(side.y)/2) max(targetPos, smallCenter.y+minspacing);
      translate([-pos-side.y/2, 0, 0])
        rotate([0,0,90])
        translate([-(side.x)/2,-(side.y)/2,(longCenter.z-side.z)])
        slotCutout([side.x, side.y, side.z+fudgeFactor], chamfer);
      
      translate([+pos+side.y/2, 0, 0])
      rotate([0,0,90])
        translate([-(side.x)/2,-(side.y)/2,(longCenter.z-side.z)])
        slotCutout([side.x, side.y, side.z+fudgeFactor], chamfer);
    } else {
      rotate([0,0,90])
        translate([-(side.x)/2,-(side.y)/2,(longCenter.z-side.z)])
        slotCutout([side.x, side.y, side.z+fudgeFactor], chamfer);
      
      translate([-(longCenter.x)/2+(side.y)/2, 0, 0])
      rotate([0,0,90])
        translate([-(side.x)/2,-(side.y)/2,(longCenter.z-side.z)])
        slotCutout([side.x, side.y, side.z+fudgeFactor], chamfer);
        
      translate([(longCenter.x)/2-(side.y)/2, 0, 0])
      rotate([0,0,90])
        translate([-(side.x)/2,-(side.y)/2,(longCenter.z-side.z)])
        slotCutout([side.x, side.y, side.z+fudgeFactor], chamfer);
      }
    }
  }
}
            
            
// Creates a slot with a small champer for easy insertertion
//#slotCutout(100,20,40);
//width = width of slot
//depth = depth of slot
//height = height of slot
//chamfer = chamfer size
module slotCutout(size, chamfer = 1)
{
  translate([size.x/2,size.y/2,0])
  intersection(){
    union(){
      // Main slot
      translate([-size.x/2,-size.y/2,0])
        cube([size.x, size.y, size.z]);
      
     // chamfer
     translate([-size.x/2,-size.y/2,size.z+fudgeFactor])
     hull(){
        translate([0,0,0])
          rotate([180,0,45])
          cylinder(chamfer,chamfer,00,$fn=4);
        translate([size.x,0,0])
        rotate([180,0,45])
          cylinder(chamfer,chamfer,00,$fn=4);
        translate([0,size.y,0])
        rotate([180,0,45])
          cylinder(chamfer,chamfer,00,$fn=4);
        translate([size.x,size.y,0])
        rotate([180,0,45])
          cylinder(chamfer,chamfer,00,$fn=4);          
          
      }
    }
  }
}


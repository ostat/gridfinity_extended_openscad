include <ub.scad>
include <functions_general.scad>


//GridItemHolder(fill="space", center=true, rotateGrid = true);
//translate([0,50,0])
//GridItemHolder(fill="space", center=true, rotateGrid = false);

//translate([100,0,0])
//GridItemHolder(fill="space", hexGrid=false, rotateGrid = true);
//translate([100,50,0])
//GridItemHolder(fill="space", hexGrid=false, rotateGrid = false);
module GridItemHolder(
  canvasSize = [100,50],
  hexGrid = true, //false, true, "auto"
  customShape=false,
  circleFn = 6,
  holeSize = [10,10],
  holeSpacing = [2,2],
  holeGrid = [0,0],
  holeHeight = 3,
  holeChamfer = 0,
  border = 0,
  center=false,
  fill="none", //"none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"
  //crop = true,
  rotateGrid = false,
  help) 
{
  assert(is_list(canvasSize) && len(canvasSize)==2, "canvasSize must be list of len 2");
  assert(is_bool(hexGrid) || is_string(hexGrid), "hexGrid must be bool or string");
  assert(is_bool(customShape), "customShape must be bool");    
  assert(is_num(circleFn), "circleFn must be number");    
  assert(is_list(holeSize) && len(holeSize)>=2, "holeSize must be list of len 2");
  assert(is_list(holeSpacing) && len(holeSpacing)==2, "holeSpacing must be list of len 2");
  assert(is_list(holeGrid) && len(holeGrid)==2, "canvasSize must be list of len 2");  
  assert(is_num(holeHeight), "holeHeight must be number");    
  assert(is_num(holeChamfer), "holeChamfer must be number");    
  assert(is_num(holeChamfer), "holeChamfer must be number");  
  assert(is_string(fill), "fill must be a string");
  assert(is_bool(rotateGrid), "rotateGrid must be bool");  

  fudgeFactor = 0.01;
  
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
  
  _canvasSize = 
    let (cs = rotateGrid ? [canvasSize.y,canvasSize.x] : canvasSize)
      border > 0 ? 
        [cs.x-border*2,cs.y-border*2] : 
        cs;
    
  calcHoledimensions = [
      customShape ? holeSize[0] :
      circleFn == 4 ? Rc*2 : 
      circleFn == 6 ? Rc*2 : Rc*2,
      customShape ? holeSize[1] :
      circleFn == 4 ? Rc*2 : 
      circleFn == 6 ? Ri*2 : Rc*2];

        //x spacing for hex, center to center 
  hexxSpacing = 
    circleFn == 4 ? holeSpacing[1]/2 + calcHoledimensions[1]/2
    : customShape ? holeSize[0]+holeSpacing[0]
    : sqrt((Ri*2+holeSpacing[0])^2-((calcHoledimensions[1]+holeSpacing[1])/2)^2);
    
  //Calculate the x and y items count for hexgrid
  eHexGrid = [
      holeGrid[0] !=0 ? holeGrid[0]
        : floor((_canvasSize[0]-calcHoledimensions[0])/hexxSpacing+1), 
      holeGrid[1] !=0 ? holeGrid[1]
        : floor(((_canvasSize[1]+holeSpacing[1])/(calcHoledimensions[1]+holeSpacing[1])-0.5)*2)/2
      ];

  //Calculate the x and y hex items count for squaregrid
  eSquareGrid = [
      holeGrid[0]!=0 ? holeGrid[0]
        : floor((_canvasSize[0]+holeSpacing[0])/(calcHoledimensions[0]+holeSpacing[0])),
      holeGrid[1]!=0 ? holeGrid[1]
        : floor((_canvasSize[1]+holeSpacing[1])/(calcHoledimensions[1]+holeSpacing[1]))];

  //Single lines should not be hex
  hexGrid = 
    _canvasSize.x<=holeSize.x+holeSpacing.x || 
    _canvasSize.y<=holeSize.y+holeSpacing.y ||
    holeGrid.x ==1 || holeGrid.y ==1 ? false : hexGrid;
  if(IsHelpEnabled("trace")) echo("GridItemHolder", eHexGrid0 =eHexGrid[0], eHexGrid1 = eHexGrid[1], mod=eHexGrid[0]%2);
  hexGridCount = let(count = eHexGrid[0]*eHexGrid[1]) eHexGrid[0] % 2 == 0 ? floor(count) : ceil(count);
  squareCount = eSquareGrid[0]*eSquareGrid[1];
  _hexGrid = hexGrid != "auto" ? hexGrid //if not auto use what was chose
          : hexGridCount == squareCount ? false //if equal prefer square
          : hexGridCount > squareCount;
          
  if(IsHelpEnabled("info")) echo(str("🟩ItemGrid: count ", _hexGrid?hexGridCount:squareCount, " using grid ", _hexGrid?"hex":"square"), input=hexGrid==true?"hex":hexGrid==false?"square":hexGrid, hexGridCount=hexGridCount, squareCount=squareCount);
  

  translate(center ? [0, 0, 0] : [(rotateGrid?canvasSize.x:0)+ border, border, 0])
  //translate(rotateGrid && !center ?[canvasSize.x,0,0]:[0,0,0])
  rotate(rotateGrid?[0,0,90]:[0,0,0])
  intersection(){
    //Crop to ensure that we dont go outside the bounds 
    if(fill == "crop" || fill == "crophorizontal"  || fill == "cropvertical"  || fill ==  "crophorizontal_spacevertical"  || fill == "cropvertical_spacehorizontal")
      translate([-fudgeFactor,-fudgeFactor,(center?holeHeight/2:0)-fudgeFactor])
      cube([_canvasSize[0]+fudgeFactor*2,_canvasSize[1]+fudgeFactor*2,holeHeight+fudgeFactor*2], center = center);
    
    if(_hexGrid){
      //x and y spacing including the item size.
      es = [
        fill == "space" || fill == "spacevertical" ||fill == "crophorizontal_spacevertical"
          ? calcHoledimensions[0]+(eHexGrid[0]<=1?0:((_canvasSize[0]-eHexGrid[0]*calcHoledimensions[0])/(eHexGrid[0]-1))) 
          : hexxSpacing,
        fill == "space" || fill == "spacehorizontal" ||fill == "cropvertical_spacehorizontal"
          ? calcHoledimensions[1]+(eHexGrid[1]<=0.5?0:((_canvasSize[1]-(eHexGrid[1]+0.5)*calcHoledimensions[1])/(eHexGrid[1]-0.5))) 
          : holeSpacing[1] + calcHoledimensions[1]];
      
      eFill=[
        fill == "crop" || fill == "cropvertical" || fill == "cropvertical_spacehorizontal"
          ? eHexGrid[0]+2 : eHexGrid[0],
        fill == "crop" || fill == "crophorizontal" || fill == "crophorizontal_spacevertical"
          ? eHexGrid[1]+2 : eHexGrid[1]];
        
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
          translate(center ? [-calcHoledimensions[0]/2,-calcHoledimensions[1]/2,0] : [0,0,0])
            children();
        } else {
          translate(!center ? [calcHoledimensions[0]/2,calcHoledimensions[1]/2,0] : [0,0,0])
            chamferedCylinder(h=holeHeight, r=Rc, chamfer=holeChamfer, circleFn = circleFn);
        }
    }
    else {
      es = [
        fill == "space" || fill == "spacevertical" || fill == "crophorizontal_spacevertical"
          ? calcHoledimensions[0]+(eSquareGrid[0]<=1?0:((_canvasSize[0]-eSquareGrid[0]*calcHoledimensions[0])/(eSquareGrid[0] - (center ? 0.5 :1))))
          : calcHoledimensions[0]+holeSpacing[0],
        fill == "space" || fill == "spacehorizontal" ||fill == "cropvertical_spacehorizontal"
          ? calcHoledimensions[1]+(eSquareGrid[1]<=1?0:((_canvasSize[1]-eSquareGrid[1]*calcHoledimensions[1])/(eSquareGrid[1] - (center ? 0.5 :1))))
          : calcHoledimensions[1]+holeSpacing[1]];
      
      eFill=[
        fill == "crop" || fill == "cropvertical" || fill == "cropvertical_spacehorizontal"
          ? eSquareGrid[0]+2 : eSquareGrid[0],
        fill == "crop" || fill == "crophorizontal" || fill == "crophorizontal_spacevertical"
          ? eSquareGrid[1]+2 : eSquareGrid[1]];
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
          translate(center ? [-calcHoledimensions[0]/2,-calcHoledimensions[1]/2,0] : [0,0,0])
          children();
        } else {
          translate(center ? [0,0,0] : [calcHoledimensions[0]/2,calcHoledimensions[1]/2,0])
            chamferedCylinder(h=holeHeight, r=Rc, chamfer=holeChamfer, circleFn = circleFn);
        }
    }
  }
  
  HelpTxt("GridItemHolder",[
    "canvasSize",canvasSize
    ,"_canvasSize",_canvasSize
    ,"circleFn",circleFn
    ,"hexGrid",hexGrid
    ,"holeSize",holeSize
    ,"holeSpacing",holeSpacing
    ,"holeGrid",holeGrid
    ,"center",center
    ,"fill",fill
    ,"customShape",customShape
    ,"hexxSpacing",hexxSpacing
    ,"calcHoledimensions",calcHoledimensions
    ,"eHexGrid",eHexGrid
    ,"eSquareGrid",eSquareGrid  
    ,"hexGridCount",hexGridCount  
    ,"squareCount",squareCount  
     ,"Rc",Rc
    ,"Ri",Ri]
    ,help);
}

module multiCard(longCenter, smallCenter, side, chamfer = 1, alternate = false){
  fudgeFactor = 0.01;
  
  assert(is_list(longCenter) && len(longCenter) >= 3, "longCenter should be a list of length 5");
  assert(is_list(smallCenter) && len(smallCenter) >= 3, "longCenter should be a list of length 5");
  assert(is_list(side) && len(side) >= 3, "longCenter should be a list of length 5");

  iitemDiameter= 0;
  iitemx = 1;
  iitemy = 2;
  idepthneeded = 3;
  iitemHeight = 4;
  ishape = 5;

  if(IsHelpEnabled("trace")) echo(longCenter=longCenter,smallCenter=smallCenter,side=side,chamfer=chamfer,alternate=alternate);
  render() //Render on item holder multiCard as it can be complex
  union(){
    minspacing = 3;
    translate([(longCenter[iitemx])/2,side[iitemx]/2,0])
    union(){
    translate([-(longCenter[iitemx])/2,-longCenter[iitemy]/2,0])
    chamferedSquare([longCenter[iitemx], longCenter[iitemy], longCenter[idepthneeded]+fudgeFactor], chamfer);
    
    translate([-smallCenter[iitemx]/2,-smallCenter[iitemy]/2,(longCenter[idepthneeded]-smallCenter[idepthneeded])])
    chamferedSquare([smallCenter[iitemx], smallCenter[iitemy], smallCenter[idepthneeded]+fudgeFactor], chamfer);

    if(alternate){
      pos = let(targetPos = (longCenter[iitemx])/4-(side[iitemy])/2) max(targetPos, smallCenter[iitemy]+minspacing);
      translate([-pos-side[iitemy]/2, 0, 0])
        rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamferedSquare([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
      
      translate([+pos+side[iitemy]/2, 0, 0])
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamferedSquare([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
    } else {
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamferedSquare([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
      
      translate([-(longCenter[iitemx])/2+(side[iitemy])/2, 0, 0])
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamferedSquare([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
        
      translate([(longCenter[iitemx])/2-(side[iitemy])/2, 0, 0])
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamferedSquare([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
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
module chamferedSquare(size, chamfer = 1, cornerRadius = 0)
{
  assert(is_list(size) && len(size) == 3, "size should be a list of length 3");

  fudgeFactor = 0.01;
  chamfer = min(size.z, chamfer);
  union(){
    if(cornerRadius > 0){
        hull(){
          translate([cornerRadius,cornerRadius,0])
          cylinder(h = size.z, r=cornerRadius);
          translate([size.x-cornerRadius,cornerRadius,0])
          cylinder(h = size.z, r=cornerRadius);
          translate([cornerRadius,size.y-cornerRadius,0])
          cylinder(h = size.z, r=cornerRadius);
          translate([size.x-cornerRadius,size.y-cornerRadius,0])
          cylinder(h = size.z, r=cornerRadius);
        }
    } else {
      translate([0,0,0])
        cube([size.x, size.y, size.z]);
    }
    
    if(chamfer > 0)
       translate([0,0,size.z+fudgeFactor-chamfer-cornerRadius])
       chamferedRectangleTop(size=size, chamfer=chamfer, cornerRadius=cornerRadius);
  }
}

module chamferedRectangleTop(size, chamfer, cornerRadius){
  fudgeFactor = 0.01;
  
  chamferFn = cornerRadius > 0 ? $fn : 4;

  champherExtention = cornerRadius > 0 ? 0 
    : (min(size.x,size.y,size.z)-chamfer)/4;
    
  //when the chamferFn value is 4 we need to chan the formula as the radius is corner to corner not edge to edge.
  conesizeTop = chamfer+cornerRadius+champherExtention;
  conesizeBottom = conesizeTop>size.z ? conesizeTop-size.z: 0;
  
  if(IsHelpEnabled("trace")) echo("chamferedRectangleTop", size=size, chamfer=chamfer, cornerRadius=cornerRadius, conesizeTop=conesizeTop, conesizeBottom=conesizeBottom);
  //if cornerRadius = 0, we can further increase the height of the 'cone' so we can extend inside the shape
  hull(){
    translate([cornerRadius+champherExtention/2,cornerRadius+champherExtention/2,conesizeBottom-champherExtention])
      rotate([0,0,45])
      cylinder(h=conesizeTop-conesizeBottom,r2=conesizeTop,r1=conesizeBottom,$fn=chamferFn);
    translate([size.x-cornerRadius-champherExtention/2,cornerRadius+champherExtention/2,conesizeBottom-champherExtention])
    rotate([0,0,45])
      cylinder(h=conesizeTop-conesizeBottom,r2=conesizeTop,r1=conesizeBottom,$fn=chamferFn);
    translate([cornerRadius+champherExtention/2,size.y-cornerRadius-champherExtention/2,conesizeBottom-champherExtention])
    rotate([0,0,45])
      cylinder(h=conesizeTop-conesizeBottom,r2=conesizeTop,r1=conesizeBottom,$fn=chamferFn);
    translate([size.x-cornerRadius-champherExtention/2,size.y-cornerRadius-champherExtention/2,conesizeBottom-champherExtention])
    rotate([0,0,45])
      cylinder(h=conesizeTop-conesizeBottom,r2=conesizeTop,r1=conesizeBottom,$fn=chamferFn);          
  }
}

module chamferedHalfCylinder(h, r, circleFn, chamfer=0.5) {
  fudgeFactor = 0.01;
  
  chamfer = min(h, chamfer);
  translate([0,-h/2,r])
  union(){
    rotate([-90,0,0])
    difference(){
      cylinder(h=h, r=r, $fn = circleFn);
      translate([-r-fudgeFactor,-r,-fudgeFactor])
      cube([(r+fudgeFactor)*2,r,h+fudgeFactor*2]);
    }
    
    if(r>0)
      translate([-r, 0, -chamfer+fudgeFactor]) 
      chamferedRectangleTop(size=[r*2,h,r], chamfer=chamfer, cornerRadius=0);
  }
}

module chamferedCylinder(h, r, circleFn, chamfer=0.5) {
  chamfer = min(h, chamfer);
  union(){
    cylinder(h=h, r=r, $fn = circleFn);
    
    if(r>0)
      translate([0, 0, h-chamfer]) 
      cylinder(h=chamfer, r1=r, r2=r+chamfer,$fn = circleFn);
  }
}
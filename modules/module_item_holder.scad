include <thirdparty/ub_hexgrid.scad>
include <functions_general.scad>
include <functions_environment.scad>
include <module_chamfered_shapes.scad>

griditemholder_demo = false;

if(griditemholder_demo)
{
  GridItemHolder(fill="space", center=true, rotateGrid = true);
  
  translate([0,50,0])
  GridItemHolder(fill="space", center=true, rotateGrid = false);

  translate([100,0,0])
  GridItemHolder(fill="space", hexGrid=false, rotateGrid = true);
  
  translate([100,50,0])
  GridItemHolder(fill="space", hexGrid=false, rotateGrid = false);
  
  translate([0,0,20])
  chamfered_cube(size = [13,20,10], chamfer = 1, cornerRadius = 0);
}

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
  rotateGrid = false) 
{
  assert(is_list(canvasSize) && len(canvasSize)==2, "canvasSize must be list of len 2");
  assert(is_bool(hexGrid) || is_string(hexGrid), "hexGrid must be bool or string");
  assert(is_bool(customShape), "customShape must be bool");    
  assert(is_num(circleFn), "circleFn must be number");    
  assert(is_list(holeSize) && len(holeSize)>=2, "holeSize must be list of len 2");
  assert(is_num(holeSize[0]), "holeSize[0] must be list of number");
  assert(is_num(holeSize[1]), "holeSize[1] must be list of number");
  assert(is_list(holeSpacing) && len(holeSpacing)==2, "holeSpacing must be list of len 2");
  assert(is_list(holeGrid) && len(holeGrid)==2, "canvasSize must be list of len 2");  
  assert(is_num(holeHeight), "holeHeight must be number");    
  assert(is_num(border), "border must be number");    
  assert(is_string(fill), "fill must be a string");
  assert(is_bool(rotateGrid), "rotateGrid must be bool");  

  //holeChamfer = let(chamfer = is_num(holeChamfer) ? [0, holeChamfer] : holeChamfer) [min(chamfer.x,holeHeight/2),min(chamfer.y,holeHeight/2)];

  function calculate_chamfer(chamfer, thickness) = 
    let(
      _chamfer = is_num(chamfer) ? [0, chamfer] : chamfer,
      dual_chamfer = (_chamfer[0] != 0 && _chamfer[1] != 0) ? 2 : 1)
      [get_related_value(_chamfer.x, thickness/dual_chamfer, 0),get_related_value(_chamfer.y, thickness/dual_chamfer, 0)];

  holeChamfer= calculate_chamfer(chamfer=holeChamfer,thickness=holeHeight);

  assert(is_list(holeChamfer), "holeChamfer must be list");  
  
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
  if(env_help_enabled("trace")) echo("GridItemHolder", eHexGrid0 =eHexGrid[0], eHexGrid1 = eHexGrid[1], mod=eHexGrid[0]%2);
  hexGridCount = let(count = eHexGrid[0]*eHexGrid[1]) eHexGrid[0] % 2 == 0 ? floor(count) : ceil(count);
  squareCount = eSquareGrid[0]*eSquareGrid[1];
  _hexGrid = hexGrid != "auto" ? hexGrid //if not auto use what was chose
          : hexGridCount == squareCount ? false //if equal prefer square
          : hexGridCount > squareCount;
          
  if(env_help_enabled("info")) echo(str("🟩ItemGrid: count ", _hexGrid?hexGridCount:squareCount, " using grid ", _hexGrid?"hex":"square"), input=hexGrid==true?"hex":hexGrid==false?"square":hexGrid, hexGridCount=hexGridCount, squareCount=squareCount);
  

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

      HexGrid(e=eFill, es=es, center=center)
        if(customShape){
          translate(center ? [-calcHoledimensions[0]/2,-calcHoledimensions[1]/2,0] : [0,0,0])
            children();
        } else {
          translate(!center ? [calcHoledimensions[0]/2,calcHoledimensions[1]/2,0] : [0,0,0])
            chamferedCylinder(h=holeHeight, r=Rc, bottomChamfer=holeChamfer[0], topChamfer=holeChamfer[1], circleFn = circleFn);
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
      
      Grid(e=eFill, es=es, center=center)
        if(customShape){
          translate(center ? [-calcHoledimensions[0]/2,-calcHoledimensions[1]/2,0] : [0,0,0])
          children();
        } else {
          translate(center ? [0,0,0] : [calcHoledimensions[0]/2,calcHoledimensions[1]/2,0])
            chamferedCylinder(h=holeHeight, r=Rc, bottomChamfer=holeChamfer[0], topChamfer=holeChamfer[1], circleFn = circleFn);
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
    ,env_help_enabled("info"));
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

  if(env_help_enabled("trace")) echo(longCenter=longCenter,smallCenter=smallCenter,side=side,chamfer=chamfer,alternate=alternate);
  render() //Render on item holder multiCard as it can be complex
  union(){
    minspacing = 3;
    translate([(longCenter[iitemx])/2,side[iitemx]/2,0])
    union(){
    translate([-(longCenter[iitemx])/2,-longCenter[iitemy]/2,0])
    chamfered_cube([longCenter[iitemx], longCenter[iitemy], longCenter[idepthneeded]+fudgeFactor], chamfer);
    
    translate([-smallCenter[iitemx]/2,-smallCenter[iitemy]/2,(longCenter[idepthneeded]-smallCenter[idepthneeded])])
    chamfered_cube([smallCenter[iitemx], smallCenter[iitemy], smallCenter[idepthneeded]+fudgeFactor], chamfer);

    if(alternate){
      pos = let(targetPos = (longCenter[iitemx])/4-(side[iitemy])/2) max(targetPos, smallCenter[iitemy]+minspacing);
      translate([-pos-side[iitemy]/2, 0, 0])
        rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamfered_cube([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
      
      translate([+pos+side[iitemy]/2, 0, 0])
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamfered_cube([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
    } else {
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamfered_cube([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
      
      translate([-(longCenter[iitemx])/2+(side[iitemy])/2, 0, 0])
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamfered_cube([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
        
      translate([(longCenter[iitemx])/2-(side[iitemy])/2, 0, 0])
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamfered_cube([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
      }
    }
  }
}
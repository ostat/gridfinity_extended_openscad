include <module_utility.scad>
// Creates a slot with a small chamfer for easy insertertion
//#slotCutout(100,20,40);
//width = width of slot
//depth = depth of slot
//height = height of slot
//chamfer = chamfer size
module chamfered_cube(
  size = [10,10,10], 
  chamfer=0, topChamfer = 0, bottomChamfer = 0, 
  cornerRadius = 0, topRadius=0, bottomRadius=0,
  centerxy = false)
{
  assert(is_list(size) && len(size) == 3, "size should be a list of length 3");
  assert(is_num(chamfer), "chamfer should be a number");
  assert(is_num(topChamfer), "topChamfer should be a number");
  assert(is_num(bottomChamfer), "bottomChamfer should be a number");

  topChamfer = min(size.z, chamfer > 0 ? chamfer : topChamfer);
  bottomChamfer = min(size.z, chamfer > 0 ? chamfer : bottomChamfer);

  bottomRadius = min(bottomRadius, cornerRadius);
  topRadius = min(topRadius, cornerRadius);
  // echo("chamfered_cube", size=size, topChamfer=topChamfer, bottomChamfer=bottomChamfer);

  fudgeFactor = 0.01;
  chamfer = min(size.z, chamfer);
  translate(centerxy ? [-size.x/2, -size.y/2, 0] : [0,0,0])
  union(){
    roundedCube(
      size=size,
      topRadius = topRadius,
      bottomRadius = bottomRadius,
      sideRadius = cornerRadius);
    
    if(topChamfer > 0)
       translate([0,0,size.z+fudgeFactor-topChamfer-cornerRadius])
       chamferedRectangleTop(size=size, chamfer=topChamfer, cornerRadius=cornerRadius);

    if(bottomChamfer > 0)
       translate([0,0,bottomChamfer])
       mirror([0,0,1])
       chamferedRectangleTop(size=size, chamfer=bottomChamfer, cornerRadius=cornerRadius);
  }
}

module chamferedRectangleTop(size, chamfer, cornerRadius){
  fudgeFactor = 0.01;
  
  chamferFn = cornerRadius > 0 ? $fn : 4;

  //champherExtention caused errors in slat wall, Need to find the scenario it was needed to debug. For now disabled.
  //when the chamferFn value is 4 we need to change the formula as the radius is corner to corner not edge to edge.
  champherExtention = 0;// cornerRadius > 0 ? 0 : (min(size.x,size.y,size.z)-chamfer)/4;

  conesizeTop = chamfer+cornerRadius+champherExtention;
  conesizeBottom = conesizeTop>size.z ? conesizeTop-size.z: 0;

  //echo("chamferedRectangleTop", size=size, chamfer=chamfer, cornerRadius=cornerRadius, champherExtention=champherExtention, conesizeTop=conesizeTop, conesizeBottom=conesizeBottom);

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

module chamferedCylinder(h, r, circleFn, chamfer=0, topChamfer = 0.5, bottomChamfer = 0) {
  topChamfer = min(h, chamfer > 0 ? chamfer : topChamfer);
  bottomChamfer = min(h, chamfer > 0 ? chamfer : bottomChamfer);
  
  union(){
    cylinder(h=h, r=r, $fn = circleFn);
    
    if(topChamfer >0)
      translate([0, 0, h-topChamfer]) 
      cylinder(h=topChamfer, r1=r, r2=r+topChamfer,$fn = circleFn);

    if(bottomChamfer >0)
      cylinder(h=bottomChamfer, r1=r+bottomChamfer, r2=r,$fn = circleFn);
  }
}
include <modules_utility.scad>
       
translate([175,0,0])
WallCutout2(
  lowerWidth=50,
  wallAngle=70,
  height=21,
  thickness=10,
  cornerRadius=5);

#translate([175-40,50,-21])
cube([80,10,21]);
translate([175,50,0])
WallCutout(
  lowerWidth=50,
  wallAngle=70,
  height=21,
  thickness=10,
  cornerRadius=5);

#translate([0,0,0])
cube([25,25,10]);
translate([0,0,0])
roundedCube(
  x=25,
  y=25,
  z=10,
  cornerRadius=5)

translate([50,0,0])
roundedCorner(
  radius = 10, 
  length=10, 
  height=10);

translate([75,0,0])
SequentialBridgingDoubleHole(
  outerHoleRadius = 10,
  outerHoleDepth = 5,
  innerHoleRadius = 5,
  innerHoleDepth = 10,
  overhangBridgeCount = 3,
  overhangBridgeThickness = 0.3,
  overhangBridgeCutin =0.05);
  
translate([100,0,0])
champheredCorner(
  champherLength = 10, 
  cornerRadius = 4, 
  length=10, 
  height=10);

  
h=20;
r=5;
roundedr = 3;
$fn=64;

translate([40,0,0]){
  #cylinder(h,r=r);
  roundedCylinder(h,r,roundedr);
}

translate([40,r*2.5,0]){
  #cylinder(h,r=r);
  roundedCylinder(h,r,roundedr1=roundedr,roundedr2=roundedr/2);
}

translate([40,r*5,0]){
  #cylinder(h,r=r);
  roundedCylinder(h,r,roundedr1=roundedr, $fn=16);
}

translate([40,r*7.5,0]){
  #cylinder(h,r=r);
  roundedCylinder(h,r,roundedr2=roundedr);
}

translate([40,r*10,0]){
  #cylinder(h=6,r=5);
  roundedCylinder(h=6,r=5,roundedr1=4,roundedr2=2);
}
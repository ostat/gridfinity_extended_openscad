include <modules_utility.scad>
       
translate([150,0,0])
WallCutout2(
  lowerWidth=50,
  wallAngle=70,
  height=21,
  thickness=10,
  cornerRadius=5);

translate([150,50,0])
WallCutout(
  lowerWidth=50,
  wallAngle=70,
  height=21,
  thickness=10,
  cornerRadius=5);

translate([0,0,0])
roundedCube(
  x=25,
  y=25,
  z=10,
  cornerRadius=5)

translate([25,0,0])
roundedCorner(
  radius = 10, 
  length=10, 
  height=10);
  
translate([75,0,0])
champheredCorner(
  champherLength = 10, 
  cornerRadius = 4, 
  length=10, 
  height=10);

translate([50,0,0])
SequentialBridgingDoubleHole(
  outerHoleRadius = 10,
  outerHoleDepth = 5,
  innerHoleRadius = 5,
  innerHoleDepth = 10,
  overhangBridgeCount = 3,
  overhangBridgeThickness = 0.3,
  overhangBridgeCutin =0.05);
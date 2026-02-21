//sequential bridging for hanging hole. 
//ref: https://hydraraptor.blogspot.com/2014/03/buried-nuts-and-hanging-holes.html
//ref: https://www.youtube.com/watch?v=KBuWcT8XkhA

SequentialBridgingDoubleHole_demo = false;

if(SequentialBridgingDoubleHole_demo && $preview){
  $fn = 64;
  translate([0,0,0])
  SequentialBridgingDoubleHole(
    outerHoleRadius = 10,
    outerHoleDepth = 5,
    innerHoleRadius = 5,
    innerHoleDepth = 10,
    overhangBridgeCount = 2,
    overhangBridgeThickness = 0.3,
    overhangBridgeCutin = 0.05,
    magnetCaptiveHeight = 0);
    
    
  translate([25,0,0])
  SequentialBridgingDoubleHole(
    outerHoleRadius = 10,
    outerHoleDepth = 5,
    innerHoleRadius = 5,
    innerHoleDepth = 10,
    overhangBridgeCount = 2,
    overhangBridgeThickness = 0.3,
    overhangBridgeCutin = 0.05,
    magnetCaptiveHeight = 0)
    cylinder(r=10, h=$outer_height );

    translate([75,0,0])
    SequentialBridgingDoubleHole(
    outerHoleRadius = 10,
    outerHoleDepth = 5,
    innerHoleRadius = 5,
    innerHoleDepth = 10,
    overhangBridgeCount = 3,
    overhangBridgeThickness = 0.3,
    overhangBridgeCutin =0.05);

    translate([75,30,0])
    rotate([180,0,0])
    difference(){
    cylinder(h=10,r=15);
    translate([0,0,-0.01])  
    SequentialBridgingDoubleHole(
        outerHoleRadius = 10,
        outerHoleDepth = 5+0.01,
        innerHoleRadius = 5,
        innerHoleDepth = 10,
        overhangBridgeCount = 3,
        overhangBridgeThickness = 0.3,
        overhangBridgeCutin =0.05);
    }

    translate([75,60,0])
    SequentialBridgingDoubleHole(
    outerHoleRadius = 0,
    outerHoleDepth = 5,
    innerHoleRadius = 5,
    innerHoleDepth = 10,
    overhangBridgeCount = 0,
    overhangBridgeThickness = 0.3,
    overhangBridgeCutin =0.05);

    translate([75,90,0])
    rotate([180,0,0])
    difference(){
    cylinder(h=10,r=15);
    translate([0,0,-0.01])  
    SequentialBridgingDoubleHole(
        outerHoleRadius = 0,
        outerHoleDepth = 5+0.01,
        innerHoleRadius = 5,
        innerHoleDepth = 10,
        overhangBridgeCount = 0,
        overhangBridgeThickness = 0.3,
        overhangBridgeCutin =0.05);
}
}

module SequentialBridgingDoubleHole(
  outerHoleRadius = 0,
  outerHoleDepth = 0,
  innerHoleRadius = 0,
  innerHoleDepth = 0,
  overhangBridgeCount = 2,
  overhangBridgeThickness = 0.3,
  overhangBridgeCutin = 0.05, //How far should the bridge cut in to the second smaller hole. This helps support the
  magnetCaptiveHeight = 0) 
{
  fudgeFactor = 0.01;
  
  hasOuter = outerHoleRadius > 0 && outerHoleDepth >0;
  hasInner = innerHoleRadius > 0 && innerHoleDepth > 0;
  bridgeRequired = hasOuter && hasInner && outerHoleRadius > innerHoleRadius && innerHoleDepth > outerHoleDepth;
  overhangBridgeCount = bridgeRequired ? overhangBridgeCount : 0;
  overhangBridgeHeight = overhangBridgeCount*overhangBridgeThickness;
  outerPlusBridgeHeight = hasOuter ? outerHoleDepth + overhangBridgeHeight : 0;
  $outer_height = outerPlusBridgeHeight+fudgeFactor;
  
  if(hasOuter || hasInner)
  union(){
    difference(){
      if (hasOuter) {
        // move the cylinder up into the body to create internal void
        translate([0,0,magnetCaptiveHeight])
        if($children >=1){
          //translate([0,0,outerHoleDepth]);
          //cylinder(r=outerHoleRadius, h=overhangBridgeHeight+fudgeFactor);
          children(0); 
        } else { 
          cylinder(r=outerHoleRadius, h=outerPlusBridgeHeight+fudgeFactor);
        }
      }
      
      if (overhangBridgeCount > 0) {
        for(i = [0:overhangBridgeCount-1]) 
          rotate([0,0,180/overhangBridgeCount*i])
          for(x = [0:1]) 
          rotate([0,0,180]*x)
            translate([-outerHoleRadius,innerHoleRadius-overhangBridgeCutin,outerHoleDepth+overhangBridgeThickness*i])
            cube([outerHoleRadius*2, outerHoleRadius, overhangBridgeThickness*overhangBridgeCount+fudgeFactor*2]);
          }
      }
      
      if (hasInner) {
        translate([0,0,outerPlusBridgeHeight])
        cylinder(r=innerHoleRadius, h=innerHoleDepth-outerPlusBridgeHeight);
    }
  }
}


//
//sequential bridging for hanging hole. 
//ref: https://hydraraptor.blogspot.com/2014/03/buried-nuts-and-hanging-holes.html
//ref: https://www.youtube.com/watch?v=KBuWcT8XkhA
module SequentialBridgingDoubleHole(
  outerHoleRadius = 0,
  outerHoleDepth = 0,
  innerHoleRadius = 0,
  innerHoleDepth = 0,
  overhangBridgecount = 4,
  overhangBridgeThickness = 0.3,
  overhangBridgeCutin =0.05, //How far should the bridge cut in to the second smaller hole. This helps support the
  fn=$fn
)
{
  ff = 0.01;
  overhangBridgeHeight = overhangBridgecount*overhangBridgeThickness;
  render() //this wont improve render time, but will use less memory in the viewer. This matters here are there can be many holes (x*y*4) on the one render.
  union(){
    if (outerHoleRadius > 0) {
      cylinder(r=outerHoleRadius, h=outerHoleDepth, $fn=fn);
    }

    if (overhangBridgecount>0) {
      translate([0,0,outerHoleDepth])
      intersection(){
        cylinder(r=outerHoleRadius, h=(overhangBridgecount * overhangBridgeThickness), $fn=fn);
        
        for(i = [0:overhangBridgecount-1]) {
          intersection_for(y = [0:i]) {
              rotate([0,0,180/overhangBridgecount*y])
              translate([-outerHoleRadius, -(innerHoleRadius-overhangBridgeCutin/2), overhangBridgeThickness*i-ff]) 
                cube([outerHoleRadius*2, innerHoleRadius*2-overhangBridgeCutin, overhangBridgeThickness+ff]);
          }
        }
      }
    }

    if (innerHoleRadius > 0) {
      translate([0,0,outerHoleDepth+overhangBridgeHeight])
      cylinder(r=innerHoleRadius, h=innerHoleDepth-outerHoleDepth-overhangBridgeHeight, $fn=fn);
    }
  }
}

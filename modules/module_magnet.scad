use <module_utility.scad>

MagnetEasyRelease_off = "off";
MagnetEasyRelease_auto = "auto";
MagnetEasyRelease_inner = "inner"; 
MagnetEasyRelease_outer = "outer"; 
MagnetEasyRelease_values = [MagnetEasyRelease_off, MagnetEasyRelease_auto, MagnetEasyRelease_inner, MagnetEasyRelease_outer];
  function validateMagnetEasyRelease(value, efficientFloorValue) = 
  //Convert boolean to list value
  let(value = is_bool(value) ? value ? MagnetEasyRelease_auto : MagnetEasyRelease_off : value,
      autoValue = value == MagnetEasyRelease_auto 
        ? efficientFloorValue == EfficientFloor_off ? MagnetEasyRelease_inner : MagnetEasyRelease_outer 
        : value) 
  assert(list_contains(MagnetEasyRelease_values, autoValue), typeerror("MagnetEasyRelease", autoValue))
  autoValue;

module MagnetAndScrewRecess(
  magnetDiameter = 10,
  magnetThickness = 2,
  screwDiameter = 2,
  screwDepth = 6,
  overhangFixLayers = 3,
  overhangFixDepth = 0.2,
  easyMagnetRelease = true,
  magnetCaptiveHeight = 0){
     fudgeFactor = 0.01;
    union(){
      SequentialBridgingDoubleHole(
        outerHoleRadius = magnetDiameter/2,
        outerHoleDepth = magnetThickness,
        innerHoleRadius = screwDiameter/2,
        innerHoleDepth = screwDepth > 0 ? screwDepth+fudgeFactor : 0,
        overhangBridgeCount = overhangFixLayers,
        overhangBridgeThickness = overhangFixDepth,
        magnetCaptiveHeight = magnetCaptiveHeight);
      magnet_easy_release(
        magnetDiameter = magnetDiameter,
        magnetThickness = magnetThickness,
        easyMagnetRelease = easyMagnetRelease
      );
  }
}

module magnet_easy_release(
  magnetDiameter = 10,
  magnetThickness = 2,
  easyMagnetRelease = true,
  center = false
){
  fudgeFactor = 0.01;
  
  releaseWidth = 1.3;
  releaseLength = 1.5;
  outerPlusBridgeHeight = magnetThickness;
  translate(center ? [0,0,-outerPlusBridgeHeight/2] : [0,0,0] )
  union(){
    cylinder(r=magnetDiameter/2, h=outerPlusBridgeHeight);
    if(easyMagnetRelease && magnetDiameter > 0)
    difference(){
      hull(){
        translate([0,-releaseWidth/2,0])  
          cube([magnetDiameter/2+releaseLength,releaseWidth,magnetThickness]);
        translate([magnetDiameter/2+releaseLength,0,0])  
          cylinder(d=releaseWidth, h=magnetThickness);
      }
      champherRadius = min(magnetThickness, releaseLength+releaseWidth/2);
      
      totalReleaseLength = magnetDiameter/2+releaseLength+releaseWidth/2;
      
      translate([totalReleaseLength,-releaseWidth/2-fudgeFactor,magnetThickness])
      rotate([270,0,90])
      roundedCorner(
        radius = champherRadius, 
        length = releaseWidth+2*fudgeFactor, 
        height = totalReleaseLength);
    }
  }
}
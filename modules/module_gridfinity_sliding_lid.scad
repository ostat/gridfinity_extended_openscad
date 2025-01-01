include <gridfinity_constants.scad>
include <module_gridfinity.scad>
include <module_lip.scad>

iSlidingLidEnabled=0;
iSlidingLidThickness=1;
iSlidingLidMinWallThickness=2;
iSlidingLidMinSupport=3;
iSlidingClearance=4;
slidingLidLipEnabled=5;

function SlidingLidSettings(
  slidingLidEnabled,
  slidingLidThickness,
  slidingMinWallThickness,
  slidingMinSupport,
  slidingClearance,
  wallThickness,
  slidingLidLipEnabled = false) = 
  let(
    thickness = slidingLidThickness > 0 ? slidingLidThickness : wallThickness*2,
    minWallThickness = slidingMinWallThickness > 0 ? slidingMinWallThickness : wallThickness/2,
    minSupport = slidingMinSupport > 0 ? slidingMinSupport : thickness/2
  ) [
  slidingLidEnabled, 
  thickness,
  minWallThickness,
  minSupport,
  slidingClearance,
  slidingLidLipEnabled];

module AssertSlidingLidSettings(settings){
  assert(is_list(settings), "SlidingLid Settings must be a list")
  assert(len(settings)==6, "SlidingLid Settings must length 5");
} 

//SlidingLid(4,3,.8,0.1,1.6,0.8,0.4,true, true, [-2,-2],5,[0,0]);

module SlidingLid(
  num_x, 
  num_y,
  wall_thickness,
  clearance = 0,
  lidThickness,
  lidMinSupport,
  lidMinWallThickness,
  limitHeight = false,
  lipStyle = "normal",
  addLiptoLid = true,
  cutoutEnabled = false,
  cutoutSize = [0,0],
  cutoutRadius = 0,
  cutoutPosition = [0,0],
  $fn=64
){
  innerWallRadius = gf_cup_corner_radius-wall_thickness-clearance;
  seventeen = gf_pitch/2-4;
  
  lidSize = [num_x*gf_pitch-lidMinWallThickness, num_y*gf_pitch-lidMinWallThickness];
  
  lidLowerRadius = innerWallRadius+lidMinWallThickness;
  lidUpperRadius = limitHeight ? lidLowerRadius-lidThickness/2 : fudgeFactor;
  height = limitHeight ? lidThickness : innerWallRadius+lidMinWallThickness-fudgeFactor;
  difference()
  {
    union(){
      if(addLiptoLid)
      difference(){
        translate([0,0,lidThickness-fudgeFactor*3])
        cupLip(
          num_x = num_x, 
          num_y = num_y, 
          lipStyle = lipStyle, 
          wall_thickness = 1.2);
        translate([0,lidLowerRadius,lidThickness-fudgeFactor*4])
          cube([num_x*42,num_x*42,4+fudgeFactor*2]);
      }

      color(getColour(color_lid))
      union(){
        hull() 
          cornercopy(seventeen, num_x, num_y){
          tz(lidThickness-lidMinSupport) 
            cylinder(
              r1=innerWallRadius+lidMinWallThickness,
              r2=lidUpperRadius, 
              h=limitHeight ? lidThickness/2 : innerWallRadius+lidMinWallThickness-fudgeFactor);
            cylinder(r=lidLowerRadius, h=lidThickness/2);
        }
        if(addLiptoLid)
        difference(){
          hull()
            cornercopy(seventeen, num_x, num_y){
              cylinder(r=gf_cup_corner_radius, h=lidThickness);
          }         
          translate([-fudgeFactor,lidLowerRadius,-fudgeFactor])
            cube([num_x*gf_pitch+fudgeFactor*2,num_y*gf_pitch+fudgeFactor,lidThickness+fudgeFactor*2]);
        }
      }
  }
  
  if(IsHelpEnabled("debug")) echo("SlidingLid", cutoutSize=cutoutSize, cutoutRadius=cutoutRadius );
  if(cutoutSize.x != 0 && cutoutSize.y != 0 && cutoutRadius>0){
    
    cSize = [
      cutoutSize.x<0 
        ? lidSize.x/abs(cutoutSize.x) 
        : cutoutSize.x, 
      cutoutSize.y<0 
      ? lidSize.y/abs(cutoutSize.y) 
      : cutoutSize.y
    ];
    cRadius = min(cSize.x/2,cSize.y/2,cutoutRadius);
    positions = [
      [-cSize.x/2+cRadius, -cSize.y/2+cRadius],
      [-cSize.x/2+cRadius, cSize.y/2-cRadius],
      [cSize.x/2-cRadius, cSize.y/2-cRadius],
      [cSize.x/2-cRadius, -cSize.y/2+cRadius]
    ];

    translate([cutoutPosition.x,cutoutPosition.y,0])
    translate([lidSize.x/2-gf_pitch/2,lidSize.y/2-gf_pitch/2,-fudgeFactor])
      hull(){
        for(i=[0:len(positions)-1]){
          translate([positions[i].x,positions[i].y,0])
          cylinder(r=cRadius, h=lidThickness+fudgeFactor*2);
        }
      }
    }
  }
  
  if(IsHelpEnabled("debug")) echo("SlidingLid", num_x=num_x, num_y=num_y, wall_thickness=wall_thickness, clearance=clearance, lidThickness=lidThickness, lidMinSupport=lidMinSupport, lidMinWallThickness=lidMinWallThickness);
  if(IsHelpEnabled("debug")) echo("SlidingLid", cutoutSize=cutoutSize, cutoutRadius=cutoutRadius, cutoutPosition=cutoutPosition);
}

module SlidingLidSupportMaterial(
  num_x, 
  num_y,
  wall_thickness,
  sliding_lid_settings,
  innerWallRadius,
  zpoint){
  
  seventeen = gf_pitch/2-4;
    
  aboveLipHeight = sliding_lid_settings[iSlidingLidThickness];
  belowLedgeHeight = sliding_lid_settings[iSlidingLidThickness]/4;
  belowRampHeight = sliding_lid_settings[iSlidingLidMinSupport];

  belowLipHeight = belowLedgeHeight+belowRampHeight;
  slidingLidEdge = gf_cup_corner_radius-sliding_lid_settings[iSlidingLidMinWallThickness]; 
   
  //Sliding lid lower support lip
  tz(zpoint-belowLipHeight) 
  difference(){
    hull() 
      cornercopy(seventeen, num_x, num_y)
      cylinder(r=innerWallRadius, h=belowLipHeight, $fn=32); 
      
        union(){
        hull() cornercopy(seventeen, num_x, num_y)
          tz(belowRampHeight-fudgeFactor)
          cylinder(r=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=belowLedgeHeight+fudgeFactor*2, $fn=32);
          
        hull() cornercopy(seventeen, num_x, num_y)
        tz(-fudgeFactor)
        cylinder(r1=slidingLidEdge, r2=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=belowRampHeight+fudgeFactor, $fn=32);
     }
   }

  //Sliding lid upper lip
  tz(zpoint) 
  difference(){
    hull() 
      cornercopy(seventeen, num_x, num_y)
      tz(fudgeFactor) 
      cylinder(r=slidingLidEdge, h=aboveLipHeight, $fn=32); 
    union(){
    hull() 
      cornercopy(seventeen, num_x, num_y)
      tz(fudgeFactor) 
      cylinder(r=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=aboveLipHeight+fudgeFactor, $fn=32); 
      
    *SlidingLid(
      num_x=num_x, 
      num_y=num_y,
      wall_thickness,
      clearance = 0,
      slidingLidThickness=sliding_lid_settings[iSlidingLidThickness],
      slidingLidMinSupport=sliding_lid_settings[iSlidingLidMinSupport],
      slidingLidMinWallThickness=sliding_lid_settings[iSlidingLidMinWallThickness]);
    }
  }
}

module SlidingLidCavity(
  num_x, 
  num_y,
  wall_thickness,
  sliding_lid_settings,
  aboveLidHeight
){
  SlidingLid(
    num_x=num_x, 
    num_y=num_y,
    wall_thickness,
    clearance = 0,
    lidThickness=sliding_lid_settings[iSlidingLidThickness],
    lidMinSupport=sliding_lid_settings[iSlidingLidMinSupport],
    lidMinWallThickness=sliding_lid_settings[iSlidingLidMinWallThickness],
    limitHeight = false);
  
  if(sliding_lid_settings[slidingLidLipEnabled])
  {
    translate([0,0,0])
      cube([num_x*gf_pitch,gf_cup_corner_radius,aboveLidHeight+fudgeFactor*3]);
  } else {
    //translate([-gf_pitch/2,-gf_pitch/2,zpoint]) 
    //cube([num_x*gf_pitch,gf_cup_corner_radius,zClearance+gf_Lip_Height]);
    //innerWallRadius = gf_cup_corner_radius-wall_thickness;
    translate([0,gf_cup_corner_radius,aboveLidHeight]) 
    rotate([270,0,0])
    chamferedCorner(
      cornerRadius = aboveLidHeight/4,
      chamferLength = aboveLidHeight,
      length=num_x*gf_pitch, 
      height = aboveLidHeight,
      width = gf_cup_corner_radius);
  }
}

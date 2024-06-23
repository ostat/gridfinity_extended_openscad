include <gridfinity_constants.scad>
include <gridfinity_modules.scad>

iSlidingLidEnabled=0;
iSlidingLidThickness=1;
iSlidingLidMinWallThickness=2;
iSlidingLidMinSupport=3;
iSlidingClearance=4;

function SlidingLidSettings(slidingLidEnabled, slidingLidThickness, slidingMinWallThickness, slidingMinSupport, slidingClearance, wallThickness) = 
  let(
    thickness = slidingLidThickness > 0 ? slidingLidThickness : wallThickness*2,
    minWallThickness = slidingMinWallThickness > 0 ? slidingMinWallThickness : wallThickness/2,
    minSupport = slidingMinSupport > 0 ? slidingMinSupport : thickness/2
  ) [slidingLidEnabled, thickness, minWallThickness, minSupport, slidingClearance];

module AssertSlidingLidSettings(settings){
  assert(is_list(settings), "SlidingLid Settings must be a list")
  assert(len(settings)==5, "SlidingLid Settings must length 5");
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
  cutoutEnabled = false,
  cutoutSize = [0,0],
  cutoutRadius = 0,
  cutoutPosition = [0,0]
){
  innerWallRadius = gf_cup_corner_radius-wall_thickness-clearance;
  seventeen = gf_pitch/2-4;
  
  lidSize = [num_x*gf_pitch-lidMinWallThickness, num_y*gf_pitch-lidMinWallThickness];
  
  lidLowerRadius = innerWallRadius+lidMinWallThickness;
  lidUpperRadius = limitHeight ? lidLowerRadius-lidThickness/2 : fudgeFactor;
  height = limitHeight ? lidThickness : innerWallRadius+lidMinWallThickness-fudgeFactor;
  difference()
  {
  hull() 
    cornercopy(seventeen, num_x, num_y){
    tz(lidThickness-lidMinSupport) 
      cylinder(
        r1=innerWallRadius+lidMinWallThickness,
        r2=lidUpperRadius, 
        h=limitHeight ? lidThickness/2 : innerWallRadius+lidMinWallThickness-fudgeFactor, $fn=32);
      cylinder(r=lidLowerRadius, h=lidThickness/2, $fn=32);
  }
  
  echo(cutoutSize=cutoutSize, cutoutRadius=cutoutRadius );
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
  
  echo("SlidingLid", num_x=num_x, num_y=num_y, wall_thickness=wall_thickness, clearance=clearance, lidThickness=lidThickness, lidMinSupport=lidMinSupport, lidMinWallThickness=lidMinWallThickness);
  echo("SlidingLid", cutoutSize=cutoutSize, cutoutRadius=cutoutRadius, cutoutPosition=cutoutPosition);
}

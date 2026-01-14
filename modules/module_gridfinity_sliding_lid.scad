include <gridfinity_constants.scad>
include <module_gridfinity_block.scad>
include <module_lip.scad>

iSlidingLidEnabled=0;
iSlidingLidThickness=1;
iSlidingLidMinWallThickness=2;
iSlidingLidMinSupport=3;
iSlidingClearance=4;
slidingLidLipEnabled=5;

function DisabledSlidingLidSettings() = SlidingLidSettings(
  slidingLidEnabled = false,
  slidingLidThickness = 0,
  slidingMinWallThickness = 0,
  slidingMinSupport = 0,
  slidingClearance = 0,
  wallThickness = 0,
  slidingLidLipEnabled = false);
  
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
  lip_notches = true,
  lip_top_relief_height = -1, 
  addLiptoLid = true,
  cutoutEnabled = false,
  cutoutSize = [0,0],
  cutoutRadius = 0,
  cutoutPosition = [0,0]
){
  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_num(wall_thickness));
  assert(is_num(clearance));
  assert(is_num(lidThickness));
  assert(is_num(lidMinSupport));
  assert(is_num(lidMinWallThickness));
  assert(is_bool(limitHeight));
  assert(is_string(lipStyle));
  assert(is_bool(lip_notches));
  assert(is_num(lip_top_relief_height));
  assert(is_bool(addLiptoLid));
  assert(is_bool(cutoutEnabled));
  assert(is_list(cutoutSize));
  assert(is_num(cutoutRadius));
  assert(is_list(cutoutPosition));
  
  innerWallRadius = env_corner_radius()-wall_thickness-clearance;

  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  
  lidSize = [num_x*env_pitch().x-lidMinWallThickness, num_y*env_pitch().y-lidMinWallThickness];
  
  lidLowerRadius = innerWallRadius+lidMinWallThickness;
  lidUpperRadius = limitHeight ? lidLowerRadius-lidThickness/2 : fudgeFactor;
  height = limitHeight ? lidThickness : innerWallRadius+lidMinWallThickness-fudgeFactor;
  difference()
  {
    union(){
      if(addLiptoLid)
      color(env_colour(color_topcavity, isLip = true))
      difference(){
        translate([0,0,lidThickness-fudgeFactor*3])
        cupLip(
          num_x = num_x, 
          num_y = num_y, 
          lipStyle = lipStyle,
          lip_notches = lip_notches,
          lip_top_relief_height = lip_top_relief_height,
          wall_thickness = 1.2);
        translate([0,lidLowerRadius,lidThickness-fudgeFactor*4])
          cube([num_x*env_pitch().x,num_y*env_pitch().y,4+fudgeFactor*2]);
      }

      color(env_colour(color_lid))
      union(){
        hull() 
          cornercopy(inner_corner_center, num_x, num_y){
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
            cornercopy(inner_corner_center, num_x, num_y){
              cylinder(r=env_corner_radius(), h=lidThickness);
          }         
          translate([-fudgeFactor,lidLowerRadius,-fudgeFactor])
            cube([num_x*env_pitch().x+fudgeFactor*2,num_y*env_pitch().y+fudgeFactor,lidThickness+fudgeFactor*2]);
        }
      }
    }
  
    if(cutoutEnabled){
      if(env_help_enabled("debug")) echo("SlidingLid", cutoutEnabled=cutoutEnabled, cutoutSize=cutoutSize, cutoutRadius=cutoutRadius );
    
      sliding_lid_cutout(
        cutoutSize = cutoutSize,
        cutoutRadius = cutoutRadius,
        cutoutPosition = cutoutPosition,
        lidSize = lidSize,
        lidThickness = lidThickness);
    }
    
    if(env_help_enabled("debug")) echo("SlidingLid", num_x=num_x, num_y=num_y, wall_thickness=wall_thickness, clearance=clearance, lidThickness=lidThickness, lidMinSupport=lidMinSupport, lidMinWallThickness=lidMinWallThickness);
    if(env_help_enabled("debug")) echo("SlidingLid", cutoutSize=cutoutSize, cutoutRadius=cutoutRadius, cutoutPosition=cutoutPosition);
  }
}

module sliding_lid_cutout(
  cutoutSize = [0,0],
  cutoutRadius = 0,
  cutoutPosition = [0,0],
  lidSize = [0,0],
  lidThickness = 0
){
  fudgeFactor = 0.01;

  if(cutoutSize.x != 0 && cutoutSize.y != 0){
    cSize = [
      get_related_value(cutoutSize.x, lidSize.x, 0),
      get_related_value(cutoutSize.y, lidSize.y, 0)
    ];

    minSize = min(cSize.x, cSize.y);
    cRadius = min(minSize/2, get_related_value(cutoutRadius, minSize,  0.01));

    positions = [
      [-cSize.x/2+cRadius, -cSize.y/2+cRadius],
      [-cSize.x/2+cRadius, cSize.y/2-cRadius],
      [cSize.x/2-cRadius, cSize.y/2-cRadius],
      [cSize.x/2-cRadius, -cSize.y/2+cRadius]
    ];

    translate([cutoutPosition.x,cutoutPosition.y,0])
    translate([
      lidSize.x/2,
      lidSize.y/2,
      -fudgeFactor])
      hull(){
        for(i=[0:len(positions)-1]){
          translate([positions[i].x,positions[i].y,0])
          cylinder(r=cRadius, h=lidThickness+fudgeFactor*2);
        }
      }
  }
}

module SlidingLidSupportMaterial(
  num_x, 
  num_y,
  wall_thickness,
  sliding_lid_settings,
  innerWallRadius,
  zpoint){
  
  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
    
  aboveLipHeight = sliding_lid_settings[iSlidingLidThickness];
  belowLedgeHeight = sliding_lid_settings[iSlidingLidThickness]/4;
  belowRampHeight = sliding_lid_settings[iSlidingLidMinSupport];

  belowLipHeight = belowLedgeHeight+belowRampHeight;
  slidingLidEdge = env_corner_radius()-sliding_lid_settings[iSlidingLidMinWallThickness]; 
   
  //Sliding lid lower support lip
  tz(zpoint-belowLipHeight) 
  difference(){
    hull() 
      cornercopy(inner_corner_center, num_x, num_y)
      cylinder(r=innerWallRadius, h=belowLipHeight); 
      
        union(){
        hull() cornercopy(inner_corner_center, num_x, num_y)
          tz(belowRampHeight-fudgeFactor)
          cylinder(r=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=belowLedgeHeight+fudgeFactor*2);
          
        hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(-fudgeFactor)
        cylinder(r1=slidingLidEdge, r2=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=belowRampHeight+fudgeFactor);
     }
   }

  //Sliding lid upper lip
  tz(zpoint) 
  difference(){
    hull() 
      cornercopy(inner_corner_center, num_x, num_y)
      tz(fudgeFactor) 
      cylinder(r=slidingLidEdge, h=aboveLipHeight); 
    union(){
    hull() 
      cornercopy(inner_corner_center, num_x, num_y)
      tz(fudgeFactor) 
      cylinder(r=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=aboveLipHeight+fudgeFactor); 
      
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
      cube([num_x*env_pitch().x,env_corner_radius(),aboveLidHeight+fudgeFactor*3]);
  } else {
    //translate([-env_pitch().x/2,-env_pitch().y/2,zpoint]) 
    //cube([num_x*env_pitch().x,env_corner_radius(),headroom+gf_Lip_Height]);
    //innerWallRadius = env_corner_radius()-wall_thickness;
    translate([0,env_corner_radius(),aboveLidHeight]) 
    rotate([270,0,0])
    chamferedCorner(
      cornerRadius = aboveLidHeight/4,
      chamferLength = aboveLidHeight,
      length=num_x*env_pitch().x, 
      height = aboveLidHeight,
      width = env_corner_radius());
  }
}

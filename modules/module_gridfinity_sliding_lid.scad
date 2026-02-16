include <gridfinity_constants.scad>
include <module_gridfinity_block.scad>
include <module_lip.scad>

SlidingLid_debug = false;

if(SlidingLid_debug && $preview){
  $fn = 64;
  SlidingLid(  
    num_x = 2, 
    num_y = 1,
    wall_thickness = .8,
    headroom = 0.8,
    clearance = 0.1,
    lidThickness = 1.6,
    lidMinSupport = 0.8,
    lidMinWallThickness = 0.4,
    pull_style = SlidingLidPullStyle_finger,
    limitHeight = true, 
    lip_notches = true, 
    cutoutSize = [-2,-2],
    cutoutRadius = 5,
    cutoutPosition = [0,0],
    nub_size = 0.5);
}

SlidingLidPullStyle_disabled = "disabled";
SlidingLidPullStyle_lip = "lip";
SlidingLidPullStyle_finger = "finger";
SlidingLidPullStyle_values = [SlidingLidPullStyle_disabled, SlidingLidPullStyle_lip, SlidingLidPullStyle_finger];
function validateSlidingLidPullStyle(value, name = "SlidingLidPullStyle") = 
  assert(list_contains(SlidingLidPullStyle_values, value), typeerror(name, value))
  value;


iSlidingLid_Enabled=0;
iSlidingLid_Thickness=1;
iSlidingLid_MinWallThickness=2;
iSlidingLid_MinSupport=3;
iSlidingLid_Clearance=4;
iSlidingLid_PullStyle=5;
iSlidingLid_NubSize=6;

function SlidingLidSettings(
  enabled,
  thickness,
  min_wall_thickness,
  min_support,
  clearance,
  pull_style = SlidingLidPullStyle_disabled,
  nub_size = 0
  ) = 
  [enabled, 
  thickness,
  min_wall_thickness,
  min_support,
  clearance,
  pull_style,
  nub_size
  ];

function ValidateSlidingLidSettings(settings, wallThickness) = 
  assert(is_list(settings), "SlidingLid Settings must be a list")
  assert(len(settings)==7, "SlidingLid Settings must length 6")
  assert(is_num(wallThickness) && wallThickness > 0, "SlidingLidSettings: wallThickness must be a number greater than 0")
  assert(is_bool(settings[iSlidingLid_Enabled]), "SlidingLidSettings: slidingLidEnabled must be a boolean")
  assert(is_num(settings[iSlidingLid_Thickness]) && settings[iSlidingLid_Thickness] >= 0, "SlidingLidSettings: slidingLidThickness must be a number greater than or equal to 0")
  assert(is_num(settings[iSlidingLid_MinWallThickness]) && settings[iSlidingLid_MinWallThickness] >= 0, str("SlidingLidSettings: slidingMinWallThickness must be a number greater than or equal to 0 is:", settings[iSlidingLid_MinWallThickness]))
  assert(is_num(settings[iSlidingLid_MinSupport]) && settings[iSlidingLid_MinSupport] >= 0, "SlidingLidSettings: slidingMinSupport must be a number greater than or equal to 0")
  assert(is_num(settings[iSlidingLid_Clearance]) && settings[iSlidingLid_Clearance] >= 0, "SlidingLidSettings: slidingClearance must be a number greater than or equal to 0")
  assert(is_string(settings[iSlidingLid_PullStyle]), "SlidingLidSettings: slidingLidPullStyle must be a string")
  assert(is_num(settings[iSlidingLid_NubSize]) && settings[iSlidingLid_NubSize] >= 0, "SlidingLidSettings: slidingNubSize must be a number greater than or equal to 0")
  let(
    thickness = settings[iSlidingLid_Thickness] > 0 ? settings[iSlidingLid_Thickness] : wallThickness*2,
    minWallThickness = settings[iSlidingLid_MinWallThickness] > 0 ? settings[iSlidingLid_MinWallThickness] : wallThickness/2,
    minSupport = settings[iSlidingLid_MinSupport] > 0 ? settings[iSlidingLid_MinSupport] : thickness/2
  ) [
  settings[iSlidingLid_Enabled], 
  thickness,
  minWallThickness,
  minSupport,
  settings[iSlidingLid_Clearance],
  validateSlidingLidPullStyle(settings[iSlidingLid_PullStyle]),
  settings[iSlidingLid_NubSize]];

module AssertSlidingLidSettings(settings){
  assert(is_list(settings), "SlidingLid Settings must be a list")
  assert(len(settings)==7, "SlidingLid Settings must length 7");
} 

module SlidingLid(
  num_x, 
  num_y,
  wall_thickness,
  headroom = 0.8,
  clearance = 0,
  sliding_lid_gap_from_bin = 0,
  lidThickness,
  lidMinSupport,
  lidMinWallThickness,
  limitHeight = false,
  lipStyle = "normal",
  lip_notches = true,
  lip_top_relief_height = -1, 
  pull_style = SlidingLidPullStyle_disabled,
  cutoutEnabled = false,
  cutoutSize = [0,0],
  cutoutRadius = 0,
  cutoutPosition = [0,0],
  nub_size = 0,
  lip_height = 3.75, //this is a constant, but should be adjustable
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
  assert(is_string(pull_style));
  assert(is_bool(cutoutEnabled));
  assert(is_list(cutoutSize));
  assert(is_num(cutoutRadius));
  assert(is_list(cutoutPosition));
  assert(is_num(nub_size));
  
  innerWallRadius = env_corner_radius()-wall_thickness-clearance;

  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  
  lid_size = [
    num_x*env_pitch().x - env_clearance().x - clearance*2 - lidMinWallThickness*2, 
    num_y*env_pitch().y - env_clearance().y - clearance*2 - lidMinWallThickness*2, 
    lidThickness];
  lid_size1 = [inner_corner_center.x - (innerWallRadius + lidMinWallThickness),
  inner_corner_center.y - (innerWallRadius + lidMinWallThickness)];
  
  lidLowerRadius = innerWallRadius+lidMinWallThickness;
  lidUpperRadius = limitHeight ? lidLowerRadius-lidThickness/2 : fudgeFactor;
  height = limitHeight ? lidThickness : innerWallRadius+lidMinWallThickness-fudgeFactor;
  
  difference()
  {
    union(){
      //Main lid body
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
      }

      //Lid Lip
      if(pull_style == SlidingLidPullStyle_lip)
      color(env_colour(color_topcavity, isLip = true))
      difference(){
        translate([0,0,0])
        cupLip(
          num_x = num_x, 
          num_y = num_y, 
          lipHeight = lip_height,
          lipStyle = lipStyle,
          lip_notches = lip_notches,
          lip_top_relief_height = lip_top_relief_height,
          lip_remove_inner_grid = false,
          raise_lip = lidThickness,//headroom+lidThickness,
          wall_thickness = 1.2);
        translate([0,lidLowerRadius,-fudgeFactor])
        union(){
          taper_size =lip_height+headroom;
          translate([0,taper_size,0])
          cube([num_x*env_pitch().x,num_y*env_pitch().y-taper_size,taper_size+lidThickness+fudgeFactor*3]);
    
          translate([0,0,lidThickness-fudgeFactor])
          hull(){
            translate([0,taper_size,0])
            cube([num_x*env_pitch().x,num_y*env_pitch().y-taper_size,headroom + fudgeFactor]);
            translate([0,0,taper_size])
            cube([num_x*env_pitch().x,num_y*env_pitch().y,fudgeFactor*4]);
          }
        }
      }
    }

    //Lid nubs
    if(nub_size > 0){
      translate([env_clearance().x/2 + clearance + lidMinWallThickness, lid_size.y-lidLowerRadius*2,-fudgeFactor])
      for(nub_post = [
        [-nub_size,0,0],
        [lid_size.x+nub_size,0,0]]){
          translate(nub_post)
          cylinder(r=nub_size*2, h=lidThickness+fudgeFactor*2);
        }
    }
    
    if(pull_style == SlidingLidPullStyle_finger){
      translate([env_clearance().x/2 + clearance + lidMinWallThickness + lid_size.x/2, lidLowerRadius*2,lidThickness/2])
      hull(){
        finger_base_size = 3;
        for(posy = [[0,0,0],[0,+finger_base_size*2,lidThickness/2]])
        for(posx = [-finger_base_size,+finger_base_size])
          translate([posx,posy.y,posy.z])
          cylinder(r=finger_base_size,h=lidThickness);
      }
    }
      
    if(cutoutEnabled){
      if(env_help_enabled("debug")) echo("SlidingLid", cutoutEnabled=cutoutEnabled, cutoutSize=cutoutSize, cutoutRadius=cutoutRadius );
    
      sliding_lid_cutout(
        cutoutSize = cutoutSize,
        cutoutRadius = cutoutRadius,
        cutoutPosition = cutoutPosition,
        lid_size = lid_size,
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
  lid_size = [0,0],
  lidThickness = 0
){
  fudgeFactor = 0.01;

  if(cutoutSize.x != 0 && cutoutSize.y != 0){
    cSize = [
      get_related_value(cutoutSize.x, lid_size.x, 0),
      get_related_value(cutoutSize.y, lid_size.y, 0)
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
      lid_size.x/2,
      lid_size.y/2,
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
    
  aboveLipHeight = sliding_lid_settings[iSlidingLid_Thickness];
  belowLedgeHeight = sliding_lid_settings[iSlidingLid_Thickness]/4;
  belowRampHeight = sliding_lid_settings[iSlidingLid_MinSupport];

  belowLipHeight = belowLedgeHeight+belowRampHeight;
  slidingLidEdge = env_corner_radius()-sliding_lid_settings[iSlidingLid_MinWallThickness]; 
   
  //Sliding lid lower support lip
  tz(zpoint-belowLipHeight) 
  difference(){
    hull() 
      cornercopy(inner_corner_center, num_x, num_y)
      cylinder(r=innerWallRadius, h=belowLipHeight); 
      
        union(){
        hull() cornercopy(inner_corner_center, num_x, num_y)
          tz(belowRampHeight-fudgeFactor)
          cylinder(r=slidingLidEdge-sliding_lid_settings[iSlidingLid_MinSupport], h=belowLedgeHeight+fudgeFactor*2);
          
        hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(-fudgeFactor)
        cylinder(r1=slidingLidEdge, r2=slidingLidEdge-sliding_lid_settings[iSlidingLid_MinSupport], h=belowRampHeight+fudgeFactor);
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
      cylinder(r=slidingLidEdge-sliding_lid_settings[iSlidingLid_MinSupport], h=aboveLipHeight+fudgeFactor); 
    }
  }
}

module SlidingLidCavity(
  num_x, 
  num_y,
  wall_thickness,
  sliding_lid_settings,
  aboveLidHeight,
  headroom = 0.8,
  lip_height = 3.75, //this is a constant, but should be adjustable
){
  SlidingLid(
    num_x=num_x, 
    num_y=num_y,
    headroom=headroom,
    wall_thickness,
    clearance = 0,
    pull_style = SlidingLidPullStyle_disabled,  
    lidThickness=sliding_lid_settings[iSlidingLid_Thickness],
    lidMinSupport=sliding_lid_settings[iSlidingLid_MinSupport],
    lidMinWallThickness=sliding_lid_settings[iSlidingLid_MinWallThickness],
    limitHeight = false,
    lip_height = lip_height,
    nub_size = sliding_lid_settings[iSlidingLid_NubSize]);

   //the value of this is not right, I need to find where it should come from. perhaps headroom?
   extra_height = 1.4;

  if(sliding_lid_settings[iSlidingLid_PullStyle] == SlidingLidPullStyle_lip)
  {
    taper_setback = lip_height + headroom + 0.5 + sliding_lid_settings[iSlidingLid_Clearance];
    translate([0,0,0])
      cube([num_x*env_pitch().x,env_corner_radius()+taper_setback,aboveLidHeight + extra_height + fudgeFactor*3]);
  } else {
    //Where there is no lip on the sliding lid a chamfer is added to the box lip
    translate([0,env_corner_radius(),aboveLidHeight+extra_height]) 
    rotate([270,0,0])
    chamferedCorner(
      cornerRadius = aboveLidHeight/4,
      chamferLength = aboveLidHeight,
      length=num_x*env_pitch().x, 
      height = aboveLidHeight+extra_height,
      width = env_corner_radius());
  }
}

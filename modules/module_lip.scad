include <gridfinity_constants.scad>
include <module_gridfinity_frame_connectors.scad>
include <module_gridfinity.scad>

//Lip object configuration
iLipStyle=0;
iLipSideReliefTrigger=1;
iLipTopReliefHeight=2;
iLipTopReliefWidth=3;
iLipNotch=4;
iLipClipPosition=5;
iLipNonBlocking=6;

LipStyle_normal = "normal";
LipStyle_reduced = "reduced";
LipStyle_reduced_double = "reduced_double";
LipStyle_minimum = "minimum";
LipStyle_none = "none";
LipStyle_values = [LipStyle_normal,LipStyle_reduced, LipStyle_reduced_double, LipStyle_minimum,LipStyle_none];
function validateLipStyle(value) = 
  assert(list_contains(LipStyle_values, value), typeerror("LipStyle", value))
  value;

LipClipPosition_disabled = "disabled";
LipClipPosition_center_wall = "center_wall";
LipClipPosition_intersection = "intersection";
LipClipPosition_both = "both";
LipClipPosition_values = [LipClipPosition_disabled,LipClipPosition_center_wall,LipClipPosition_intersection,LipClipPosition_both];
function validateLipClipPosition(value) = 
  assert(list_contains(LipClipPosition_values, value), typeerror("LipClipPosition", value))
  value;

function LipSettings(
  lipStyle = LipStyle_normal, 
  lipSideReliefTrigger = [1,1], 
  lipTopReliefHeight = -1, 
  lipTopReliefWidth = -1, 
  lipNotch = true,
  lipClipPosition = LipClipPosition_disabled,
  lipNonBlocking = false) =  
  let(
    result = [
      lipStyle,
      lipSideReliefTrigger,
      lipTopReliefHeight,
      lipTopReliefWidth,
      lipNotch,
      lipClipPosition,
      lipNonBlocking],
    validatedResult = ValidateLipSettings(result)
  ) validatedResult;

function ValidateLipSettings(settings) =
  assert(is_list(settings), "LipStyle Settings must be a list")
  assert(len(settings)==7, "LipStyle Settings must length 7")
  assert(is_bool(settings[iLipNotch]), "Lip Notch must be a bool")
  
    [validateLipStyle(settings[iLipStyle]),
      settings[iLipSideReliefTrigger],
      settings[iLipTopReliefHeight],
      settings[iLipTopReliefWidth],
      settings[iLipNotch],
      validateLipClipPosition(settings[iLipClipPosition]),
      settings[iLipNonBlocking]];

module cupLip(
  num_x = 2, 
  num_y = 3, 
  lipStyle = LipStyle_normal, 
  wall_thickness = 1.2,
  lip_notches = true,
  lip_top_relief_height = -1,
  lip_top_relief_width = -1,
  lip_clip_position = LipClipPosition_disabled,
  lip_non_blocking = false,
  align_grid = [ "near", "near"]){
  
  assert(is_num(num_x) && num_x > 0, "num_x must be a number greater than 0");
  assert(is_num(num_y) && num_y > 0, "num_y must be a number greater than 0");
  assert(is_string(lipStyle));
  assert(is_num(wall_thickness) && wall_thickness > 0, "wall_thickness must be a number greater than 0");
  assert(is_num(lip_top_relief_height));
  assert(is_num(lip_top_relief_width));
  assert(is_bool(lip_notches));
  assert(is_string(lip_clip_position));
  assert(is_bool(lip_non_blocking));

  connectorsEnabled = lip_clip_position != LipClipPosition_disabled;
  $allowConnectors = connectorsEnabled ? [1,1,1,1] : [0,0,0,0];
  $frameBaseHeight = 0; //$num_z * env_pitch().z;

  //Difference between the wall and support thickness
  lipSupportThickness = (lipStyle == "minimum" || lipStyle == "none") ? 0
    : lipStyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : lipStyle == "reduced_double" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;
      
  floorht=0;
  
  // should be 17 for default settings
  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];

  innerLipRadius = env_corner_radius()-gf_lip_lower_taper_height-gf_lip_upper_taper_height; //1.15
  innerWallRadius = env_corner_radius()-wall_thickness;
  
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // around the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  lipHeight = 3.75;
  
  outer_size = [env_pitch().x - env_clearance().x, env_pitch().y - env_clearance().y];  // typically 41.5
  block_corner_position = [outer_size.x/2 - env_corner_radius(), outer_size.y/2 - env_corner_radius()];  // need not match center of pad corners
 
  coloredLipHeight=min(2,lipHeight);
  
  if(lipStyle != "none")
    color(env_colour(color_topcavity, isLip = true))

    tz(-fudgeFactor*2)
    difference() {
      //Lip outer shape
      tz(fudgeFactor*2)
      hull() 
        cornercopy(block_corner_position, num_x, num_y) 
        cylinder(r=env_corner_radius(), h=lipHeight+fudgeFactor);
    
      cupLip_cavity(
        num_x = num_x, 
        num_y = num_y, 
        lipStyle = lipStyle, 
        wall_thickness = wall_thickness,
        lip_notches = lip_notches,
        lip_top_relief_height = lip_top_relief_height,
        lip_top_relief_width = lip_top_relief_width,
        lip_clip_position = lip_clip_position,
        lip_non_blocking = lip_non_blocking,
        align_grid = align_grid);
    }
}

module cupLip_cavity(
  num_x = 2, 
  num_y = 3, 
  lipStyle = LipStyle_normal, 
  wall_thickness = 1.2,
  lip_notches = true,
  lip_top_relief_height = -1,
  lip_top_relief_width = -1,
  lip_clip_position = LipClipPosition_disabled,
  lip_non_blocking = false,
  align_grid = [ "near", "near"]){
  
  assert(is_num(num_x) && num_x > 0, "num_x must be a number greater than 0");
  assert(is_num(num_y) && num_y > 0, "num_y must be a number greater than 0");
  assert(is_string(lipStyle));
  assert(is_num(wall_thickness) && wall_thickness > 0, "wall_thickness must be a number greater than 0");
  assert(is_num(lip_top_relief_height));
  assert(is_num(lip_top_relief_width));
  assert(is_bool(lip_notches));
  assert(is_string(lip_clip_position));
  assert(is_bool(lip_non_blocking));

  connectorsEnabled = lip_clip_position != LipClipPosition_disabled;
  $allowConnectors = connectorsEnabled ? [1,1,1,1] : [0,0,0,0];
  $frameBaseHeight = 0; //$num_z * env_pitch().z;

  //Difference between the wall and support thickness
  lipSupportThickness = (lipStyle == "minimum" || lipStyle == "none") ? 0
    : lipStyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : lipStyle == "reduced_double" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;
      
  floorht=0;
  
  // should be 17 for default settings
  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
    
  innerLipRadius = env_corner_radius()-gf_lip_lower_taper_height-gf_lip_upper_taper_height; //1.15
  innerWallRadius = env_corner_radius()-wall_thickness;
  
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // around the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  lipHeight = 3.75;
  
  outer_size = [env_pitch().x - env_clearance().x, env_pitch().y - env_clearance().y];  // typically 41.5
  block_corner_position = [outer_size.x/2 - env_corner_radius(), outer_size.y/2 - env_corner_radius()];  // need not match center of pad corners
 
  coloredLipHeight=min(2,lipHeight);
      
  pitch=env_pitch();
  // remove top so XxY can fit on top
  //pad_oversize(num_x, num_y, 1);
  union(){
    //Top cavity, with lip relief
    frame_cavity(
      num_x = lip_non_blocking ? ceil(num_x) : num_x, 
      num_y = lip_non_blocking ? ceil(num_y) : num_y, 
      position_fill_grid_x = align_grid.x,
      position_fill_grid_y = align_grid.y,
      render_top = lip_notches,
      render_bottom = false,
      frameLipHeight = 4,
      cornerRadius = env_corner_radius(),
      reducedWallHeight = lip_top_relief_height,
      reducedWallWidth = lip_top_relief_width,
      reducedWallOuterEdgesOnly=true){
        echo("donothign");
        frame_connectors(
          width = num_x, 
          depth = num_y,
          connectorPosition = lip_clip_position,
          connectorClipEnabled = connectorsEnabled);
      };

    //lower cavity
    frame_cavity(
      num_x = 1, 
      num_y = 1, 
      position_fill_grid_x = "far",
      position_fill_grid_y = "far",
      render_top = !lip_notches,
      render_bottom = true,
      frameLipHeight = 4,
      cornerRadius = env_corner_radius(),
      reducedWallHeight = -1, 
      reducedWallWidth = -1,
      $pitch=[
        pitch.x*(lip_non_blocking ? ceil(num_x) : num_x),
        pitch.y*(lip_non_blocking ? ceil(num_y) : num_y),
        pitch.z]);
  }
 
  if (lipStyle == "minimum" || lipStyle == "none") {
    hull() cornercopy(inner_corner_center, num_x, num_y)
      tz(-fudgeFactor) 
      cylinder(r=innerWallRadius, h=gf_Lip_Height);   // remove entire lip
  } 
  else if (lipStyle == "reduced" || lipStyle == "reduced_double") {
    lowerTaperZ = gf_lip_lower_taper_height;
    hull() cornercopy(inner_corner_center, num_x, num_y)
    union(){
      tz(lowerTaperZ) 
      cylinder(
        r1=innerWallRadius, 
        r2=env_corner_radius()-gf_lip_upper_taper_height, 
        h=lipSupportThickness);
      tz(-fudgeFactor) 
      cylinder(
        r=innerWallRadius, 
        h=lowerTaperZ+fudgeFactor*2);
    }
  } 
  else { // normal
    lowerTaperZ = -gf_lip_height-lipSupportThickness;
    if(lowerTaperZ <= floorht){
      hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(floorht) 
        cylinder(r=innerLipRadius, h=-floorht+fudgeFactor*2); // lip
    } else {
      hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(-gf_lip_height-fudgeFactor) 
        cylinder(r=innerLipRadius, h=gf_lip_height+fudgeFactor*2); // lip

      hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(-gf_lip_height-lipSupportThickness-fudgeFactor) 
        cylinder(
          r1=innerWallRadius,
          r2=innerLipRadius, h=q+fudgeFactor);   // ... to top of thin wall ...
    }
  }
}

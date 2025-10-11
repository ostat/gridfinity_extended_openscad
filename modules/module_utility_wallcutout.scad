iwalcutoutconfig_type = 0;
iwalcutoutconfig_position = 1;
iwalcutoutconfig_width = 2;
iwalcutoutconfig_angle = 3;
iwalcutoutconfig_height = 4;
iwalcutoutconfig_cornerradius = 5;

function WallCutoutSettings(
    type = "disabled", 
    position = 0, 
    width = 0,
    angle = 0,
    height = 0, 
    corner_radius = 0) = 
  let(
    result = [
      type,
      position,
      width,
      angle,
      height,
      corner_radius],
    validatedResult = ValidateWallCutoutSettings(result)
  ) validatedResult;

function ValidateWallCutoutSettings(settings) =
  assert(is_list(settings), "Settings must be a list")
  assert(len(settings)==6, "Settings must length 6")
  assert(is_string(settings[iwalcutoutconfig_type]), "type must be a string")
  assert(is_num(settings[iwalcutoutconfig_position]) || is_list(settings[iwalcutoutconfig_position]), "position must be a list or number")
  assert(is_num(settings[iwalcutoutconfig_width]), "width must be a number")
  assert(is_num(settings[iwalcutoutconfig_angle]), "angle must be a number")
  assert(is_num(settings[iwalcutoutconfig_height]), "height must be a number")
  assert(is_num(settings[iwalcutoutconfig_cornerradius]), "corner radius must be a number")
  [
    settings[iwalcutoutconfig_type],
    is_num(settings[iwalcutoutconfig_position]) ? [settings[iwalcutoutconfig_position]] : settings[iwalcutoutconfig_position],
    settings[iwalcutoutconfig_width],
    settings[iwalcutoutconfig_angle],
    settings[iwalcutoutconfig_height],
    settings[iwalcutoutconfig_cornerradius]
  ];

iwalcutout_config = 0;
iwalcutout_enabled = 1;
iwalcutout_position = 2;
iwalcutout_size = 3;
iwalcutout_rotation = 4;
iwalcutout_reposition = 5;

function calculateWallCutouts(
  wall_length,
  opposite_wall_distance,
  wallcutout_settings,
  wallcutout_rotation = [0,0,0],
  wallcutout_reposition = [0,0,0],
  wall_thickness,
  cavityFloorRadius,
  wallTop,
  z_point,
  floorHeight,
  pitch,
  pitch_opposite) =
    let(wallcutout_positions = wallcutout_settings[iwalcutoutconfig_position])
    [for (i = [0:len(wallcutout_positions)-1])
      calculateWallCutout(
        wall_length = wall_length,
        opposite_wall_distance = opposite_wall_distance,
        wallcutout_settings = wallcutout_settings,
        wallcutout_position = wallcutout_positions[i],
        wallcutout_rotation = wallcutout_rotation,
        wallcutout_reposition = wallcutout_reposition,
        wall_thickness = wall_thickness,
        cavityFloorRadius = cavityFloorRadius,
        wallTop = wallTop,
        z_point = z_point,
        floorHeight = floorHeight,
        pitch = pitch,
        pitch_opposite = pitch_opposite)];

function calculateWallCutout(
  wall_length,
  opposite_wall_distance,
  wallcutout_settings,
  wallcutout_position,
  wallcutout_rotation = [0,0,0],
  wallcutout_reposition = [0,0,0],
  wall_thickness,
  cavityFloorRadius,
  wallTop,
  z_point,
  floorHeight,
  pitch,
  pitch_opposite) =
     let(
        wallcutout_type = wallcutout_settings[iwalcutoutconfig_type],
        wallcutout_width = wallcutout_settings[iwalcutoutconfig_width],
        wallcutout_angle = wallcutout_settings[iwalcutoutconfig_angle],
        wallcutout_height = wallcutout_settings[iwalcutoutconfig_height],
        wallcutout_corner_radius = wallcutout_settings[iwalcutoutconfig_cornerradius],
        is_enabled = wallcutout_position <= -1 || wallcutout_position >= 0,
        max_height = wallcutout_type == "inneronly" ? z_point : wallTop,
        fullEnabled = wallcutout_type == "enabled",
        innerEnabled = wallcutout_type == "inneronly",
        closeEnabled = wallcutout_type == "wallsonly" || wallcutout_type == "leftonly" || wallcutout_type == "frontonly",
        farEnabled = wallcutout_type == "wallsonly" || wallcutout_type == "rightonly" || wallcutout_type == "backonly",
        wallcutoutThickness = wall_thickness*2+max(wall_thickness*2,cavityFloorRadius), //wall_thickness*2 should be lip thickness
        wallcutoutHeight = wallcutout_height < 0 
            ? (max_height - floorHeight)/abs(wallcutout_height)
            : wallcutout_height == 0 ? max_height - floorHeight - cavityFloorRadius
            : wallcutout_height,
        wallcutoutLowerWidth=wallcutout_width <= 0 ? max(wallcutout_corner_radius*2, wall_length*pitch/3) : wallcutout_width,
        closeThickness = 
          fullEnabled ? opposite_wall_distance*pitch_opposite 
          : innerEnabled ? opposite_wall_distance*pitch_opposite - wallcutoutThickness*2 
          : wallcutoutThickness,
        clearance = env_clearance().x, //This should take in to account if its x or y, but for now we assume they are the same.
        closePosition = 
          innerEnabled ? closeThickness/2+clearance/2+wallcutoutThickness
          : closeThickness/2+clearance/2-fudgeFactor,
      //This could be more specific based on the base height, and the lip style.
      wallcutout_close = [
          //walcutout_config
          [wallcutout_type, wallcutout_position, wallcutout_width, wallcutout_angle, wallcutout_height, wallcutout_corner_radius],
          //walcutout_enabled
          is_enabled && (closeEnabled || fullEnabled || innerEnabled),
          //wallcutout_position
          [wallCutoutPosition_mm(wallcutout_position,wall_length,pitch), closePosition, max_height],
          //wallcutout_size
          [wallcutoutLowerWidth, closeThickness, wallcutoutHeight],
          //wallcutout_rotation
          wallcutout_rotation,
          //wallcutout_reposition
          wallcutout_reposition],
      wallcutout_far = [
          //walcutout_config
          [wallcutout_type, wallcutout_position, wallcutout_width, wallcutout_angle, wallcutout_height, wallcutout_corner_radius],
          //walcutout_enabled
          is_enabled && farEnabled,
          //wallcutout_position
          [wallCutoutPosition_mm(wallcutout_position,wall_length,pitch), opposite_wall_distance*pitch_opposite-wallcutoutThickness/2-clearance/2+fudgeFactor, max_height],
          //wallcutout_size
          [wallcutoutLowerWidth, wallcutoutThickness, wallcutoutHeight],
          //wallcutout_rotation
          wallcutout_rotation,
          //wallcutout_reposition
          wallcutout_reposition]) [wallcutout_close, wallcutout_far];

module WallCutout(
  lowerWidth=50,
  wallAngle=70,
  height=21,
  thickness=10,
  cornerRadius=5,
  topHeight) {
 
  topHeight = is_undef(topHeight) || topHeight < 0 ? cornerRadius*4 : topHeight;
  bottomWidth = lowerWidth;
  topWidth = lowerWidth+(height/tan(wallAngle))*2;

  rotate([90,0,0])
  translate([0,0,-thickness/2])
  linear_extrude(height=thickness)
  intersection(){
    translate([0,-height/2+topHeight/2,0])
    square([topWidth+cornerRadius*2,height+topHeight], true);
    
    //Use triple offset to fillet corners
    //https://www.reddit.com/r/openscad/comments/ut1n7t/quick_tip_simple_fillet_for_2d_shapes/
    offset(r=-cornerRadius)
    offset(r=2 * cornerRadius)
    offset(r=-cornerRadius)
    union(){
      translate([0,cornerRadius*4/2])
      square([topWidth*2,cornerRadius*4], true);
      hull(){
        translate([0,cornerRadius*4/2])
        square([topWidth,cornerRadius*4], true);
        translate([0,-height/2])
        square([bottomWidth,height], true);
      }
    }
  }
}


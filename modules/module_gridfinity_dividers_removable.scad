iDividerRemovable_Enabled = 0;
iDividerRemovable_Walls = 1;
iDividerRemovable_Headroom = 2;
iDividerRemovable_SupportThickness = 3;
iDividerRemovable_DividerSpacing  = 4;
iDividerRemovable_DividerThickness = 5;
iDividerRemovable_DividerSupportIndent = 6;
iDividerRemovable_DividerClearance = 7;

function DividerRemovableSettings(
    enabled = false,
    walls = [0,0],
    headroom = 0,
    support_thickness = 0,
    divider_spacing = 0,
    divider_thickness = 0,
    divider_support_indent = 0,
    divider_clearance = 0.1) = 
  let(
    result = [
      enabled,
      walls,
      headroom,
      support_thickness,
      divider_spacing,
      divider_thickness,
      divider_support_indent,
      divider_clearance],
    validatedResult = ValidateDividerRemovableSettings(result)
  ) validatedResult;

function ValidateDividerRemovableSettings(settings, wall_thickness = 0) =
  assert(is_list(settings), "Divider Removable Settings must be a list")
  assert(len(settings)==8, "Divider Removable Settings must length 8")
  assert(is_bool(settings[iDividerRemovable_Enabled]), "Divider Removable Enabled must be a boolean")
  assert(is_list(settings[iDividerRemovable_Walls]) && len(settings[iDividerRemovable_Walls])==2, "Divider Removable Walls Settings must length 2")
  assert(is_num(settings[iDividerRemovable_Headroom]), "Divider Removable Headroom must be a number")
  assert(is_num(settings[iDividerRemovable_SupportThickness]), "Divider Removable Support Thickness must be a number")
  assert(is_num(settings[iDividerRemovable_DividerSpacing]), "Divider Removable Divider Spacing must be a number")
  assert(is_num(settings[iDividerRemovable_DividerThickness]), "Divider Removable Divider Thickness must be a number")
  assert(is_num(settings[iDividerRemovable_DividerSupportIndent]), "Divider Removable Divider Support Indent must be a number")
  assert(is_num(settings[iDividerRemovable_DividerClearance]), "Divider Removable Divider Clearance must be a number")
  let(
    support_thickness = settings[iDividerRemovable_SupportThickness] <= 0 && wall_thickness > 0 ? wall_thickness*2 : settings[iDividerRemovable_SupportThickness],
    divider_thickness = settings[iDividerRemovable_DividerThickness] <= 0 && wall_thickness > 0 ? wall_thickness*2 : settings[iDividerRemovable_DividerThickness],
    divider_spacing = settings[iDividerRemovable_DividerSpacing] <= 0 && divider_thickness > 0 ? divider_thickness*2 : settings[iDividerRemovable_DividerSpacing]
  ) [
    settings[iDividerRemovable_Enabled],
    settings[iDividerRemovable_Walls],
    settings[iDividerRemovable_Headroom],
    support_thickness,
    divider_spacing,
    divider_thickness,
    settings[iDividerRemovable_DividerSupportIndent],
    settings[iDividerRemovable_DividerClearance]];
    
module removable_dividers(
  num_x, 
  num_y,
  zpoint,
  divider_settings = [],
  wall_thickness,
  floorHeight){
  
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(zpoint), "zpoint must be a number");
  assert(is_num(wall_thickness), "wall_thickness must be a number");
  assert(is_num(floorHeight), "floorHeight must be a number");
  divider_settings = ValidateDividerRemovableSettings(divider_settings, wall_thickness);
  
  support_walls=[divider_settings[iDividerRemovable_Walls].x,divider_settings[iDividerRemovable_Walls].y];
  headroom=divider_settings[iDividerRemovable_Headroom];
  divider_spacing=divider_settings[iDividerRemovable_DividerSpacing];
  divider_thickness=divider_settings[iDividerRemovable_DividerThickness];
  divider_support_indent=divider_settings[iDividerRemovable_DividerSupportIndent];
  divider_clearance=divider_settings[iDividerRemovable_DividerClearance];
  
  front = [
    //width
    num_x*env_pitch().x-0.5-wall_thickness*2-divider_support_indent*2,
    //Position
    [ wall_thickness+divider_support_indent+0.25, 0, floorHeight],
    //rotation
    [0,0,0],
    //cup width for calculating count
    num_y*env_pitch().y];
  left = [
    //width
    num_y*env_pitch().y-0.5-wall_thickness*2-divider_support_indent*2,
    //Position
    [num_x*env_pitch().x, wall_thickness+divider_support_indent+0.25, floorHeight],
    //rotation
    [0,0,90],
    //cup width for calculating count
    num_x*env_pitch().x];
    
  locations = [left, front];
      
  for(i = [0:1:len(locations)-1])
    union()
    if(support_walls[i] != 0){
      count = floor(((locations[i][3]+divider_thickness)/(divider_spacing+divider_thickness))-1);
      leadin = (locations[i][3]-(count-1)*divider_spacing-count*divider_thickness)/2;
      for(x = [0:1:count-2]) {
        pos = divider_spacing/2+x*(divider_spacing+divider_thickness);
        //patterns in the outer walls
        translate(locations[i][1])
        rotate(locations[i][2])                  
        translate([0,wall_thickness+leadin+pos,0])
        cube([locations[i][0], divider_thickness+divider_clearance, zpoint-headroom]);
      }
    }
}

module dividers_removable_for_cup(
  num_x, 
  num_y,
  zpoint,
  divider_settings = [],
  wall_thickness,
  floorHeight){
  
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(zpoint), "zpoint must be a number");
  assert(is_num(wall_thickness), "wall_thickness must be a number");
  assert(is_num(floorHeight), "floorHeight must be a number");
  divider_settings = ValidateDividerRemovableSettings(divider_settings, wall_thickness);
  
  support_walls=[divider_settings[iDividerRemovable_Walls].x,divider_settings[iDividerRemovable_Walls].y];
  headroom=divider_settings[iDividerRemovable_Headroom];
  divider_thickness=divider_settings[iDividerRemovable_DividerThickness];
  divider_support_indent=divider_settings[iDividerRemovable_DividerSupportIndent];
  divider_clearance=divider_settings[iDividerRemovable_DividerClearance];

  if(support_walls.x == 1){
    translate([-env_pitch().x/2,num_y*env_pitch().y,0])
    rotate([90,0,270])
    divider_removable(num_x=num_x, num_y=num_y, zpoint=zpoint, support_walls=[0,1], headroom=headroom, divider_thickness=divider_thickness, divider_support_indent=divider_support_indent, divider_clearance=divider_clearance, wall_thickness=wall_thickness, floorHeight=floorHeight);
  }
  if(support_walls.y == 1){
    translate([0,-env_pitch().y/2,0])
    rotate([90,0,0])
    divider_removable(num_x=num_x, num_y=num_y, zpoint=zpoint, support_walls=[1,0], headroom=headroom, divider_thickness=divider_thickness, divider_support_indent=divider_support_indent, divider_clearance=divider_clearance, wall_thickness=wall_thickness, floorHeight=floorHeight);
  }
}

module divider_removable(
  num_x, 
  num_y,
  zpoint,
  support_walls,
  headroom,
  divider_thickness, 
  divider_support_indent,
  divider_clearance,
  wall_thickness,
  floorHeight){
  
  size = 
    [support_walls.x == 1
      ? num_x*env_pitch().x-0.5-wall_thickness*2-divider_support_indent*2-divider_clearance
      : num_y*env_pitch().y-0.5-wall_thickness*2-divider_support_indent*2-divider_clearance,
      divider_thickness,
      zpoint-headroom-floorHeight];
  
  cube(size);
}

///Creates the divider wall slide subracted from the cavity
module removable_dividers_support(
  num_x, 
  num_y,
  zpoint,
  divider_settings = [],
  wall_thickness,
  floorHeight) {
  
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(zpoint), "zpoint must be a number");
  assert(is_num(wall_thickness), "wall_thickness must be a number");
  assert(is_num(floorHeight), "floorHeight must be a number");
  divider_settings = ValidateDividerRemovableSettings(divider_settings, wall_thickness);
  
  support_walls=[divider_settings[iDividerRemovable_Walls].x,divider_settings[iDividerRemovable_Walls].y];
  headroom=divider_settings[iDividerRemovable_Headroom];
  support_thickness=divider_settings[iDividerRemovable_SupportThickness];
  divider_clearance=divider_settings[iDividerRemovable_DividerClearance];

  front = [
    //width
    num_x*env_pitch().x,
    //Position
    [0, 0, 0],
    //rotation
    [0, 0, 0]];
  back = [
    //width
    num_x*env_pitch().x,
    //Position
    [num_x*env_pitch().x, num_y*env_pitch().y, 0],
    //rotation
    [0,0,180]];
  left = [
    //width
    num_y*env_pitch().y,
    //Position
    [0, num_y*env_pitch().y, 0],
    //rotation
    [0, 0, 270]];
  right = [
    //width
    num_y*env_pitch().y,
    //Position
    [num_x*env_pitch().x, 0, 0],
    //rotation
    [0, 0, 90]];
    
  locations = [front, back, left, right];
  walls = [support_walls.x, support_walls.x, support_walls.y, support_walls.y];
  for(i = [0:1:len(locations)-1])
    union()
    if(walls[i] != 0)
      //patterns in the outer walls
      translate(locations[i][1])
      rotate(locations[i][2])                  
      translate([0,wall_thickness,0])
      cube([locations[i][0], support_thickness, zpoint-headroom]);
}
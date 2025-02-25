include <module_utility.scad>

iDividerRemovable_Enabled = 0;
iDividerRemovable_Walls = 1;
iDividerRemovable_Headroom = 2;
iDividerRemovable_SupportThickness = 3;
iDividerRemovable_SlotSize = 4;
iDividerRemovable_DividerSpacing  = 5;
iDividerRemovable_DividerThickness = 6;
iDividerRemovable_DividerClearance = 7;
iDividerRemovable_DividerSlotSpanningCount = 8;

function DividerRemovableSettings(
    enabled = false,
    walls = [0,0],
    headroom = 0,
    support_thickness = 0,
    slot_size = [0,0],
    divider_spacing = 0,
    divider_thickness = 0,
    divider_clearance = [0.1, 0.1],
    divider_slot_spanning = 0) = 
  let(
    result = [
      enabled,
      walls,
      headroom,
      support_thickness,
      slot_size,
      divider_spacing,
      divider_thickness,
      divider_clearance,
      divider_slot_spanning],
    validatedResult = ValidateDividerRemovableSettings(result)
  ) validatedResult;

function ValidateDividerRemovableSettings(settings, wall_thickness = 0) =
  
  assert(is_list(settings), "Divider Removable Settings must be a list")
  assert(len(settings)==9, "Divider Removable Settings must length 9")
  assert(is_bool(settings[iDividerRemovable_Enabled]), "Divider Removable Enabled must be a boolean")
  assert(is_list(settings[iDividerRemovable_Walls]) && len(settings[iDividerRemovable_Walls])==2, "Divider Removable Walls Settings must length 2")
  assert(is_num(settings[iDividerRemovable_Headroom]), "Divider Removable Headroom must be a number")
  assert(is_num(settings[iDividerRemovable_SupportThickness]), "Divider Removable Support Thickness must be a number")
  assert(is_list(settings[iDividerRemovable_SlotSize]), "Divider Removable Slot Size must be a number")
  assert(is_num(settings[iDividerRemovable_DividerSpacing]), "Divider Removable Divider Spacing must be a number")
  assert(is_num(settings[iDividerRemovable_DividerThickness]), "Divider Removable Divider Thickness must be a number")
  assert(is_list(settings[iDividerRemovable_DividerClearance]), "Divider Removable Divider Clearance must be a list")
  assert(is_num(settings[iDividerRemovable_DividerSlotSpanningCount]), "Divider slot spanning must be a number")

  let(
    support_thickness = settings[iDividerRemovable_SupportThickness] <= 0 && wall_thickness > 0 ? wall_thickness*2 : settings[iDividerRemovable_SupportThickness],
    divider_thickness = settings[iDividerRemovable_DividerThickness] <= 0 && wall_thickness > 0 ? wall_thickness*2 : settings[iDividerRemovable_DividerThickness],
    slot_size_y = settings[iDividerRemovable_SlotSize].y <= 0 && support_thickness > 0 ? support_thickness : settings[iDividerRemovable_SlotSize].y,
    slot_size = [settings[iDividerRemovable_SlotSize].x <= 0 && divider_thickness > 0 ? divider_thickness : settings[iDividerRemovable_SlotSize].x,
                min(support_thickness <=0 ? slot_size_y : support_thickness, slot_size_y)],
    divider_spacing = settings[iDividerRemovable_DividerSpacing] <= 0 && divider_thickness > 0 ? divider_thickness*2 : settings[iDividerRemovable_DividerSpacing]
  ) [
    settings[iDividerRemovable_Enabled],
    settings[iDividerRemovable_Walls],
    settings[iDividerRemovable_Headroom],
    support_thickness,
    slot_size,
    divider_spacing,
    divider_thickness,
    settings[iDividerRemovable_DividerClearance],
    settings[iDividerRemovable_DividerSlotSpanningCount]];
    
module removable_dividers_slots(
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
  
  support_walls = [divider_settings[iDividerRemovable_Walls].x, divider_settings[iDividerRemovable_Walls].y];
  headroom = divider_settings[iDividerRemovable_Headroom];
  divider_spacing = divider_settings[iDividerRemovable_DividerSpacing];
  slot_size = divider_settings[iDividerRemovable_SlotSize];
  support_thickness = divider_settings[iDividerRemovable_SupportThickness];
  divider_thickness = divider_settings[iDividerRemovable_DividerThickness];
  
  front = [
    //width
    num_x*env_pitch().x-0.5-wall_thickness*2-support_thickness*2+slot_size.y*2,
    //Position
    [ wall_thickness+support_thickness-slot_size.y+0.25, 0, floorHeight],
    //rotation
    [0,0,0],
    //cup width for calculating count
    num_y*env_pitch().y];
  left = [
    //width
    num_y*env_pitch().y-0.5-wall_thickness*2-support_thickness*2+slot_size.y*2,
    //Position
    [num_x*env_pitch().x, wall_thickness+support_thickness-slot_size.y+0.25, floorHeight],
    //rotation
    [0,0,90],
    //cup width for calculating count
    num_x*env_pitch().x];
    
  locations = [left, front];
  for(i = [0:1:len(locations)-1])
    union()
    if(support_walls[i] != 0){
      count = floor(((locations[i][3]+slot_size.x)/(divider_spacing+slot_size.x))-1);
      leadin = (locations[i][3]-(count-1)*divider_spacing-count*slot_size.x)/2;
      for(x = [0:1:count-1]) {
        pos = leadin+x*(divider_spacing+slot_size.x);
        //patterns in the outer walls
        translate(locations[i][1])
        rotate(locations[i][2])                  
        translate([0,wall_thickness+pos-slot_size.x/2,0])
        cube([locations[i][0], slot_size.x, zpoint-headroom]);
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
  slot_size = divider_settings[iDividerRemovable_SlotSize];
  divider_thickness=divider_settings[iDividerRemovable_DividerThickness];
  divider_clearance=divider_settings[iDividerRemovable_DividerClearance];
  divider_spacing=divider_settings[iDividerRemovable_DividerSpacing];
  slot_spanning_count=divider_settings[iDividerRemovable_DividerSlotSpanningCount];

  function factorial(n) = n == 0 ? 1 : factorial(n - 1) * n;

  for(isep = [0:1:slot_spanning_count]){
    space_pos = isep <= 0 ? 0 :-zpoint-(isep)*(divider_spacing+divider_thickness)*2;
    echo(isep=isep, zpoint=zpoint, space_pos=-space_pos);
        
    if(support_walls.x == 1){
      translate([-env_pitch().x/2+space_pos,num_y*env_pitch().y,0])
      rotate([90,0,270])
      divider_removable(num_x=num_x, num_y=num_y, zpoint=zpoint, support_walls=[0,1], divider_settings=divider_settings, wall_thickness=wall_thickness, floorHeight=floorHeight, separation_count=isep);
    }
    if(support_walls.y == 1){
      translate([0,-env_pitch().y/2+space_pos,0])
      rotate([90,0,0])
      divider_removable(num_x=num_x, num_y=num_y, zpoint=zpoint, support_walls=[1,0], divider_settings=divider_settings, wall_thickness=wall_thickness, floorHeight=floorHeight, separation_count=isep);
    }
  }
}

module divider_removable(
  num_x, 
  num_y,
  zpoint,
  support_walls,
  divider_settings,
  slot_size,
  divider_thickness, 
  divider_clearance,
  wall_thickness,
  separation_count,
  floorHeight){

  headroom=divider_settings[iDividerRemovable_Headroom];
  slot_size = divider_settings[iDividerRemovable_SlotSize];
  divider_thickness=divider_settings[iDividerRemovable_DividerThickness];
  divider_clearance=divider_settings[iDividerRemovable_DividerClearance];
  divider_spacing=divider_settings[iDividerRemovable_DividerSpacing];
  
  separation = separation_count <= 0 ? 0 : separation_count*divider_spacing+separation_count*divider_thickness;
  slot = [
    slot_size.y-divider_clearance.y/2, //Divide by 2 as there are two end
    slot_size.x-divider_clearance.x, 
    zpoint-headroom-floorHeight];

  size = [ 
    support_walls.x == 1
      ? num_x*env_pitch().x-0.5-wall_thickness*2-slot_size.y*2
      : num_y*env_pitch().y-0.5-wall_thickness*2-slot_size.y*2,
      slot_size.x == divider_thickness ? divider_thickness-divider_clearance.x : divider_thickness,
      zpoint-headroom-floorHeight];

  rotate([separation == 0 ? 0 : 270,0,0])
  union(){
    translate([0,separation/2,0])
    cube(slot);

    translate([slot[0],0,0])
    if(separation > 0){
      translate([0,size.y,0])
      rotate([0,0,270])
      bentWall(
        length=size.x,
        separation=separation,
        lowerBendRadius=divider_spacing,
        upperBendRadius=divider_spacing,
        height = size.z,
        thickness = size.y);
    } else {
      cube(size);
    }
    
    translate([slot[0]+size[0],-separation/2,0])
    cube(slot);
  }
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
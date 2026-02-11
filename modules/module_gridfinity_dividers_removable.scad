include <module_utility.scad>
include <functions_environment.scad>

iDividerRemovable_Enabled = 0;
iDividerRemovable_Walls = 1;
iDividerRemovable_Headroom = 2;
iDividerRemovable_SupportThickness = 3;
iDividerRemovable_SlotSize = 4;
iDividerRemovable_DividerSpacing  = 5;
iDividerRemovable_DividerThickness = 6;
iDividerRemovable_DividerClearance = 7;
iDividerRemovable_DividerSlotSpanningCount = 8;
iDividerRemovable_DividerWallCutoutDepth = 9;
iDividerRemovable_DividerWallCutoutWidth = 10;
iDividerRemovable_DividerWallCutoutRadius = 11;
iDividerRemovable_DividerTopRadius = 12;
iDividerRemovable_DividerLabelSize = 13;


iDividerRemovable_SlotWidth = 0;
iDividerRemovable_SlotDepth = 1;

debug_removable_walls = false;

if(debug_removable_walls){
  $fn = 64;
  fudge_factor = 0.01;

  outer_container = [100, 75, 20];
  wall_thickness = 2;

  support_walls = [1, 1];
  divider_clearance = [0.2, 0.3];

  divider_thickness = 4;
  slot_size = [divider_thickness, divider_thickness];
  support_thickness = divider_thickness;
  divider_spacing = divider_thickness*2;

  slot_spanning_count = 3;

  translate([-20,-20,0])
  union(){
    translate([0,-15,0])
    removable_wall_slot(size = [2,2,20]);
    
    translate([0,-20,0])
    rotate([0,0,180])
    removable_wall_slot(size = [2,2,20]);
    
    translate([0,-30,0])
    removable_wall_slot(size = [5,2,20]);
  }
  
  union() {
    calculated_wall_thickness = 
      [calculate_wall_thickness(outer_container.x, divider_thickness, divider_spacing, wall_thickness),
      calculate_wall_thickness(outer_container.y, divider_thickness, divider_spacing, wall_thickness)];
    
    divider_walled_dimensions = [
      outer_container.x - wall_thickness*2,
      outer_container.y - wall_thickness*2,
      outer_container.z];

    divider_useable_dimensions = [
      outer_container.x - calculated_wall_thickness.x*2,
      outer_container.y - calculated_wall_thickness.y*2,
      outer_container.z];

    difference(){
      cube_clearance = 1;

      difference(){
        translate([outer_container.x/2,outer_container.y/2,outer_container.z/2])
        cube(outer_container, center=true);
        
        color("green")
        translate([outer_container.x/2,outer_container.y/2,outer_container.z/2])
        translate([0,0,outer_container.z - cube_clearance])
        cube(divider_useable_dimensions, center=true);
      
        color("darkgreen")
        translate([outer_container.x/2,outer_container.y/2,outer_container.z/2])
        translate([0,0,outer_container.z - cube_clearance/2])
        cube(divider_walled_dimensions, center=true);

        translate([wall_thickness,wall_thickness,0])
        difference(){
          translate([divider_walled_dimensions.x/2,divider_walled_dimensions.y/2,divider_useable_dimensions.z/2])
          cube([
            divider_walled_dimensions.x,
            divider_walled_dimensions.y,
            divider_walled_dimensions.z+fudge_factor*2], center=true);
            
        removable_divider_wall_reinforcement(
          divider_useable_dimensions = divider_walled_dimensions,
          support_walls = support_walls,
          support_thicknesses=calculated_wall_thickness,
          headroom=0);
        }
      }

      #translate([calculated_wall_thickness.y/2, calculated_wall_thickness.x/2, -fudge_factor])
      translate([support_thickness, support_thickness, -fudge_factor])
      removable_divider_wall_slots(
        divider_useable_dimensions = [
          divider_useable_dimensions.x, 
          divider_useable_dimensions.y, 
          divider_useable_dimensions.z+cube_clearance*2],
        support_thicknesses=calculated_wall_thickness,
        slot_size=slot_size,
        support_walls=support_walls,
        divider_spacing=divider_spacing);
    } 
    
    translate([wall_thickness, wall_thickness, 0])
    removable_divider_walls(
      divider_useable_dimensions=divider_useable_dimensions,
      slot_size=slot_size,
      support_walls=support_walls,
      divider_clearance=divider_clearance,
      divider_spacing=divider_spacing,
      divider_thickness=divider_thickness,
      slot_spanning_count=slot_spanning_count,
      $fn = 64);
  }
}

function calculate_wall_thickness(width, divider_thickness, divider_spacing, wall_support_thickness) = 
  let(
    //width between walls minus the supports
    useable_width = width-(wall_support_thickness*2),
    //each divider has half a spacing to the left, the divider, half a spacing to the right
    divider_width = divider_spacing/2+divider_thickness+divider_spacing/2,
    //divider_start = divider_thickness*2+divider_spacing,
    //divider_end = divider_thickness+divider_spacing,
    //min_divider = (divider_start+divider_end) <= useable_width ? divider_start+divider_end : divider_start,
    count = divider_wall_count(divider_thickness=divider_thickness, divider_spacing=divider_spacing, useable_width=useable_width),

    total_divider = divider_width*count,
    //the thickness of the walls needed to fit the dividers
    calculated_wall_thickness = (useable_width-total_divider)/2+wall_support_thickness)
  //echo("calculate_wall_thickness_inputs", width = width, divider_thickness=divider_thickness, divider_spacing=divider_spacing, wall_support_thickness=wall_support_thickness)
  //echo("calculate_wall_thickness", useable_width=useable_width, divider_width=divider_width, total_divider=total_divider, calculated_wall_thickness=calculated_wall_thickness, count=count, calucalted_useable_width=width-calculated_wall_thickness*2)
  calculated_wall_thickness;

//returns the number of dividers that can fit in the useable width
//useable width is the width between the support walls, not including the support walls
function divider_wall_count(divider_thickness, divider_spacing, useable_width) =
  let(
    //each divider has half a spacing to the left, the divider, half a spacing to the right
    divider_width = divider_spacing/2+divider_thickness+divider_spacing/2,
 
    //divider_start = divider_thickness*2+divider_spacing,
    //divider_end = divider_thickness+divider_spacing,
    //min_divider = (divider_start+divider_end) <= useable_width ? divider_start+divider_end : divider_start,
    count = floor((useable_width)/divider_width))
  //echo("divider_wall_count", useable_width=useable_width, divider_thickness=divider_thickness, divider_spacing=divider_spacing, divider_width=divider_width, count=count)
  count;
  
function DividerRemovableSettings(
    enabled = false,
    walls = [0,0],
    headroom = 0,
    support_thickness = 0,
    slot_size = [0,0],
    divider_spacing = 0,
    divider_thickness = 0,
    divider_clearance = [0.1, 0.1],
    divider_slot_spanning = 0,
    divider_wall_cutout_depth = 0,
    divider_wall_cutout_width = 0,
    divider_wall_cutout_radius = 0,
    divider_top_radius = 0,
    divider_label_size = 0
    ) = 
  let(
    result = [
      enabled,
      walls,
      headroom,
      walls == [1,1] ? divider_thickness : support_thickness,
      walls == [1,1] ? [divider_thickness,divider_thickness] : slot_size,
      walls == [1,1] ? divider_thickness*2 :divider_spacing,
      divider_thickness,
      divider_clearance,
      divider_slot_spanning,
      divider_wall_cutout_depth,
      divider_wall_cutout_width,
      divider_wall_cutout_radius,
      divider_top_radius,
      divider_label_size],
    validatedResult = ValidateDividerRemovableSettings(result)
  ) validatedResult;

// Calculate the usable internal dimensions for placing removable dividers.
function calculate_divider_useable_dimensions(num_x, num_y, pitch = [], wall_thickness, padding =[0.5,0.5], bin_corner_radius = gf_cup_corner_radius, bin_clearance_height, floor_height  ) = 
  assert(is_num(wall_thickness))
  let(
    exclusion_border_x = padding.x/2+wall_thickness,
    exclusion_border_y = padding.y/2+wall_thickness,
    useable_x = num_x*pitch.x-exclusion_border_x*2,
    useable_y = num_y*pitch.x-exclusion_border_y*2)
  [[useable_x, useable_y, bin_clearance_height-floor_height], [exclusion_border_x, exclusion_border_y], bin_corner_radius];

//wall_thickness should be called default_divider_thickness 
function ValidateDividerRemovableSettings(settings, wall_thickness = 0) =
  assert(is_list(settings), "Divider Removable Settings must be a list")
  assert(len(settings)==14, "Divider Removable Settings must length 13")
  assert(is_bool(settings[iDividerRemovable_Enabled]), "Divider Removable Enabled must be a boolean")
  assert(is_list(settings[iDividerRemovable_Walls]) && len(settings[iDividerRemovable_Walls])==2, "Divider Removable Walls Settings must length 2")
  assert(is_num(settings[iDividerRemovable_Headroom]), "Divider Removable Headroom must be a number")
  assert(is_num(settings[iDividerRemovable_SupportThickness]), "Divider Removable Support Thickness must be a number")
  assert(is_list(settings[iDividerRemovable_SlotSize]), "Divider Removable Slot Size must be a number")
  assert(is_num(settings[iDividerRemovable_DividerSpacing]), "Divider Removable Divider Spacing must be a number")
  assert(is_num(settings[iDividerRemovable_DividerThickness]), "Divider Removable Divider Thickness must be a number")
  assert(is_list(settings[iDividerRemovable_DividerClearance]), "Divider Removable Divider Clearance must be a list")
  assert(is_num(settings[iDividerRemovable_DividerSlotSpanningCount]), "Divider slot spanning must be a number")

  assert(is_num(settings[iDividerRemovable_DividerWallCutoutDepth]), "Divider wall cutout depth must be a number")
  assert(is_num(settings[iDividerRemovable_DividerWallCutoutWidth]), "Divider wall cutout width must be a number")
  assert(is_num(settings[iDividerRemovable_DividerWallCutoutRadius]), "Divider wall cutout radius must be a number")
  assert(is_num(settings[iDividerRemovable_DividerTopRadius]), "Divider top radius must be a number")
  assert(is_num(settings[iDividerRemovable_DividerLabelSize]), "Divider label size must be a number")
  
  let(
    divider_thickness = settings[iDividerRemovable_DividerThickness] <= 0 && wall_thickness > 0 ? wall_thickness*2 : settings[iDividerRemovable_DividerThickness],
    support_thickness = settings[iDividerRemovable_SupportThickness] <= 0 ? divider_thickness : settings[iDividerRemovable_SupportThickness],
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
    settings[iDividerRemovable_DividerSlotSpanningCount],
    settings[iDividerRemovable_DividerWallCutoutDepth],
    settings[iDividerRemovable_DividerWallCutoutWidth],
    settings[iDividerRemovable_DividerWallCutoutRadius],
    settings[iDividerRemovable_DividerTopRadius],
    settings[iDividerRemovable_DividerLabelSize]
  ];

// Creates thickened sections in the outer walls to support removable divider slots.
// For each enabled wall direction (front, back, left, right), this module:
//   - Calculates the position and orientation of the thickened wall feature.
//   - Adds extra material to the wall so slots can be cut for removable dividers.
// Parameters:
//   num_x, num_y: Gridfinity cup dimensions in grid units.
//   zpoint: Height of the thickened wall section.
//   divider_settings: Array of divider configuration values.
//   wall_thickness: Thickness of the outer wall.
//   floorHeight: Height of the cup floor.
// called by gridfinity_cup, to add support for removable dividers
module gridfinity_removable_divider_wall_reinforcement(
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

  divider_spacing = divider_settings[iDividerRemovable_DividerSpacing];
  divider_thickness = divider_settings[iDividerRemovable_DividerThickness];
  
  padding =[0.5,0.5];
  
  divider_useable_dimensions = calculate_divider_useable_dimensions(
      num_x, num_y, pitch=env_pitch(),
      wall_thickness=wall_thickness, padding = padding, 
      bin_corner_radius = env_corner_radius(),
      bin_clearance_height=zpoint, floor_height=floorHeight);
  
  calculated_wall_thickness = support_walls == [1,1] 
    ? [calculate_wall_thickness(divider_useable_dimensions[0].x, divider_thickness, divider_spacing, support_thickness),
    calculate_wall_thickness(divider_useable_dimensions[0].y, divider_thickness, divider_spacing, support_thickness)] 
    : [support_thickness, support_thickness];
  //echo("removable_divider_wall_reinforcement", divider_useable_dimensions=divider_useable_dimensions, calculated_wall_thickness=calculated_wall_thickness, support_thickness=support_thickness, support_walls=support_walls);
  translate([ wall_thickness+padding.x/2, wall_thickness+padding.y/2, floorHeight])
  removable_divider_wall_reinforcement(
    divider_useable_dimensions = [
        divider_useable_dimensions[0].x, 
        divider_useable_dimensions[0].y, 
        divider_useable_dimensions[0].z],
    support_walls=support_walls,
    support_thicknesses=calculated_wall_thickness,
    headroom=headroom);
}

module removable_divider_wall_reinforcement(
  divider_useable_dimensions = [],
  support_walls = [],
  support_thicknesses,
  headroom){
  assert(is_list(divider_useable_dimensions), "divider_useable_dimensions must be a list");
  assert(is_list(support_walls), "support_walls must be a list");
  assert(is_list(support_thicknesses), "support_thickness must be a list");
  assert(is_num(headroom), "headroom must be a number");
  
  echo("removable_divider_wall_reinforcement", support_thicknesses=support_thicknesses);
  
  front = [
    //width
    divider_useable_dimensions.x, support_thicknesses.y,
    //Position
    [0, 0, 0],
    //rotation
    [0, 0, 0]];
  back = [
    //width
    divider_useable_dimensions.x, support_thicknesses.y,
    //Position
    [divider_useable_dimensions.x, divider_useable_dimensions.y, 0],
    //rotation
    [0,0,180]];
  left = [
    //width
    divider_useable_dimensions.y, support_thicknesses.x,
    //Position
    [0, divider_useable_dimensions.y, 0],
    //rotation
    [0, 0, 270]];
  right = [
    //width
    divider_useable_dimensions.y, support_thicknesses.x,
    //Position
    [divider_useable_dimensions.x, 0, 0],
    //rotation
    [0, 0, 90]];
    
  locations = [front, back, left, right];
  walls = [support_walls.x, support_walls.x, support_walls.y, support_walls.y];
  for(i = [0:1:len(locations)-1])
    union()
    if(walls[i] != 0)
      translate(locations[i][2])
      rotate(locations[i][3])                  
      cube([locations[i][0], locations[i][1], divider_useable_dimensions.z-headroom]);
}

// Creates the slots in the outer walls to support removable divider walls.
// For each enabled wall direction (X or Y), this module:
//   - Calculates the usable space and number of slots needed.
//   - Positions and rotates each slot appropriately.
//   - Subtracts slot-shaped cutouts from the wall to allow divider insertion.
// Parameters:
//   num_x, num_y: Gridfinity cup dimensions in grid units.
//   zpoint: Height of the slot.
//   divider_settings: Array of divider configuration values.
//   wall_thickness: Thickness of the outer wall.
//   floorHeight: Height of the cup floor.
// called by removable_dividers_for_cup
// called by gridfinity_cup, to remove slots from the cup lip
module gridfinity_removable_divider_wall_slots(
  num_x, 
  num_y,
  zpoint,
  divider_settings = [],
  wall_thickness,
  floorHeight
  ){
  
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(wall_thickness), "wall_thickness must be a number");
  assert(is_num(zpoint), "zpoint must be a number");
  assert(is_num(floorHeight), "floorHeight must be a number");
  
  divider_settings = ValidateDividerRemovableSettings(divider_settings, 2);
  
  support_walls = [divider_settings[iDividerRemovable_Walls].x, divider_settings[iDividerRemovable_Walls].y];
  headroom = divider_settings[iDividerRemovable_Headroom];
  divider_spacing = divider_settings[iDividerRemovable_DividerSpacing];
  slot_size = divider_settings[iDividerRemovable_SlotSize];
  support_thickness = divider_settings[iDividerRemovable_SupportThickness];
  divider_thickness = divider_settings[iDividerRemovable_DividerThickness];
  
  padding = [0.5,0.5];
  //We need to know the height of the bin, not the zpoint
  divider_useable_dimensions = calculate_divider_useable_dimensions(
      num_x, num_y, pitch=env_pitch(),
      wall_thickness=wall_thickness, 
      padding = padding, 
      bin_corner_radius = env_corner_radius(),
      bin_clearance_height=zpoint*2, 
      floor_height=floorHeight);

  calculated_wall_thickness = support_walls == [1,1] 
    ? [calculate_wall_thickness(divider_useable_dimensions[0].x, divider_thickness, divider_spacing, support_thickness),
    calculate_wall_thickness(divider_useable_dimensions[0].y, divider_thickness, divider_spacing, support_thickness)] 
    : [support_thickness, support_thickness];
  
  echo("removable_divider_wall_slots", divider_useable_dimensions=divider_useable_dimensions, calculated_wall_thickness=calculated_wall_thickness, support_thickness=support_thickness, slot_size=slot_size, support_walls=support_walls, divider_spacing=divider_spacing);
  
  //Add the slots the to the reinforced wall
  exclusion_border = divider_useable_dimensions[1];
  translate([
      exclusion_border.x + (calculated_wall_thickness.x-support_thickness), 
      exclusion_border.y + (calculated_wall_thickness.y-support_thickness), 
      floorHeight])
  removable_divider_wall_slots(
    divider_useable_dimensions = [
        divider_useable_dimensions[0].x-(calculated_wall_thickness.x-support_thickness)*2, 
        divider_useable_dimensions[0].y-(calculated_wall_thickness.y-support_thickness)*2, 
        divider_useable_dimensions[0].z],
    support_thicknesses=[support_thickness,support_thickness],
    slot_size=slot_size,
    support_walls=support_walls,
    divider_spacing=divider_spacing);
}

module removable_divider_wall_slots(
  divider_useable_dimensions,
  support_thicknesses,
  slot_size,
  support_walls,
  divider_spacing){

  assert(is_list(divider_useable_dimensions), "divider_useable_dimensions must be a list");
  assert(is_list(support_thicknesses), "support_thicknesses must be a list");
  assert(is_list(slot_size), "slot_size must be a list");
  assert(is_list(support_walls), "support_walls must be a list");
  assert(is_num(divider_spacing), "divider_spacing must be a number");

  fudge = 0.01;

  front = [
    //width
    divider_useable_dimensions.y,
    //Position
    [divider_spacing/2+support_thicknesses.x/2, 0, 0], //support_thicknesses.x-slot_size.y
    //rotation, mirror
    [0,0,0], [0,0,0],
    //cup width for calculating count
    divider_useable_dimensions.x - support_thicknesses.x];
  left = [
    //width
    divider_useable_dimensions.x,
    //Position //+
    [0, divider_spacing/2+support_thicknesses.y/2, 0],
    //rotation, mirror
    [0,0,90], [1,0,0],
    //cup width for calculating count
    divider_useable_dimensions.y - support_thicknesses.y];

  locations = [front, left];
  //echo("removable_dividers_slots", divider_useable_dimensions=divider_useable_dimensions, support_thickness=support_thickness, slot_size=slot_size, support_walls=support_walls, divider_spacing=divider_spacing);
  //echo("removable_dividers_slots", left=left, front=front);

  for(i = [0:1:len(locations)-1])
    union()
    if(support_walls[i] != 0) {
      location = locations[i];
      width = location[0];
      start_position = location[1];
      rotation = location[2];
      mirror = location[3];
      cross_width = location[4];

      translate(start_position)
      mirror(mirror)
      rotate(rotation)
      //translate([0,pos,0])
      arange_slots_in_support(
        slot=[slot_size.x, width, divider_useable_dimensions.z+fudge*2],
        divider_thickness=slot_size.x,
        divider_spacing=divider_spacing,
        useable_width=cross_width)
          rotate([0,0,90])
          base_removable_divider_wall(
            divider_size = [width, slot_size.x, divider_useable_dimensions.z],
            slot_size = slot_size,
            divider_clearance = [0,0],
            divider_spacing = divider_spacing)
            translate([slot_size.x/2,0,0])
            rotate([0,0,90])
            cube(size=$size);
  }
}

// Creates an array of removable divider walls for the cup.
// For each enabled wall direction, this module:
//   - Generates multiple divider walls, spaced and positioned according to the bin size and settings.
//   - Handles both bent dividers (for long bins) and cross dividers (for wide bins).
//   - Supports step-over and slot spanning for complex bin layouts.
// Parameters:
//   num_x, num_y: Gridfinity cup dimensions in grid units.
//   zpoint: Height of the divider wall.
//   divider_settings: Array of divider configuration values.
//   wall_thickness: Thickness of the outer wall (array for X and Y).
//   floorHeight: Height of the cup floor.
// called by gridfinity_cup, to generate removable dividers to the cup
module gridfinity_removable_divider_walls(
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
  divider_settings = ValidateDividerRemovableSettings(divider_settings, 2);
  
  support_walls = [divider_settings[iDividerRemovable_Walls].x,divider_settings[iDividerRemovable_Walls].y];
  headroom = divider_settings[iDividerRemovable_Headroom];
  slot_size = divider_settings[iDividerRemovable_SlotSize];
  divider_thickness = divider_settings[iDividerRemovable_DividerThickness];
  divider_clearance = divider_settings[iDividerRemovable_DividerClearance];
  divider_spacing = divider_settings[iDividerRemovable_DividerSpacing];
  divider_wall_cutout_depth = divider_settings[iDividerRemovable_DividerWallCutoutDepth];
  divider_wall_cutout_width = divider_settings[iDividerRemovable_DividerWallCutoutWidth];
  divider_wall_cutout_radius = divider_settings[iDividerRemovable_DividerWallCutoutRadius];
  divider_top_radius = divider_settings[iDividerRemovable_DividerTopRadius];
  divider_label_size = divider_settings[iDividerRemovable_DividerLabelSize];
  support_thickness = divider_settings[iDividerRemovable_SupportThickness];
  slot_spanning_count = divider_settings[iDividerRemovable_DividerSlotSpanningCount];

  echo("gridfinity_removable_divider_walls", divider_settings=divider_settings, slot_size=slot_size, divider_label_size=divider_label_size);
  
  divider_useable_dimensions = calculate_divider_useable_dimensions(
    num_x, num_y, pitch=env_pitch(),
    wall_thickness=wall_thickness, padding = env_clearance(), 
    bin_corner_radius = env_corner_radius(),
    bin_clearance_height=zpoint-headroom, floor_height=floorHeight);

  calculated_wall_thickness = support_walls == [1,1] 
    ? [calculate_wall_thickness(divider_useable_dimensions[0].x, divider_thickness, divider_spacing, support_thickness),
    calculate_wall_thickness(divider_useable_dimensions[0].y, divider_thickness, divider_spacing, support_thickness)] 
    : [support_thickness, support_thickness];

  //echo("dividers_removable_for_cup", support_walls=support_walls, wall_thickness=wall_thickness, divider_clearance=divider_clearance);
  //echo("dividers_removable_for_cup", useable_x = num_x*env_pitch().x-0.5-wall_thickness*2, useable_y = num_y*env_pitch().y-0.5-wall_thickness*2);

  removable_divider_walls(
    divider_useable_dimensions=
      [divider_useable_dimensions[0].x-(calculated_wall_thickness.x-support_thickness)*2,
      divider_useable_dimensions[0].y-(calculated_wall_thickness.y-support_thickness)*2,
      divider_useable_dimensions[0].z-headroom],
    slot_size=slot_size,
    support_walls=support_walls,
    divider_clearance=divider_clearance,
    divider_spacing=divider_spacing,
    divider_thickness=divider_thickness,
    slot_spanning_count=slot_spanning_count,
    wall_cutout_depth = divider_wall_cutout_depth,
    wall_cutout_width = divider_wall_cutout_width,
    wall_cutout_radius = divider_wall_cutout_radius,
    top_radius = divider_top_radius,
    label_size = divider_label_size);
}

module removable_divider_walls(
  divider_useable_dimensions,
  slot_size,
  support_walls,
  divider_clearance,
  divider_spacing,
  divider_thickness,
  slot_spanning_count,
  wall_cutout_depth = 0,
  wall_cutout_width = 0,
  wall_cutout_radius = 0,
  top_radius = 0,
  label_size = 0) {

  assert(is_list(divider_useable_dimensions), "divider_useable_dimensions must be a list");
  assert(is_list(slot_size), "slot_size must be a list");
  assert(is_list(divider_clearance), "divider_clearance must be a list");
  assert(is_list(support_walls), "support_walls must be a list");
  assert(is_num(divider_spacing), "divider_spacing must be a number");
  assert(is_num(slot_spanning_count), "slot_spanning_count must be a number");
  assert(is_num(wall_cutout_depth), "wall_cutout_depth must be a number");
  assert(is_num(wall_cutout_width), "wall_cutout_width must be a number");
  assert(is_num(wall_cutout_radius), "wall_cutout_radius must be a number");
  assert(is_num(top_radius), "top_radius must be a number");

  function factorial(n) = n == 0 ? 1 : factorial(n - 1) * n;

  
  for(iSep = [0:1:slot_spanning_count]){
    space_pos = iSep <= 0 ? 0 :-(iSep)*(divider_spacing+divider_thickness)*2;

    if(env_generate_filter_enabled("divider_walls_bent_x"))
    if(support_walls.x == 1){
      divider_size = [divider_useable_dimensions.y, divider_thickness, divider_useable_dimensions.z];
      translate([-divider_useable_dimensions.z + space_pos, divider_useable_dimensions.y, 0])
      rotate([0,0,270])
      single_removable_divider_wall(
        divider_size=divider_size,
        slot_size=slot_size,
        divider_clearance=divider_clearance,
        divider_spacing=divider_spacing, 
        separation_count=iSep,
        wall_cutout_depth = wall_cutout_depth,
        wall_cutout_width = wall_cutout_width,
        wall_cutout_radius = wall_cutout_radius,
        top_radius = top_radius,
        label_size = label_size);
    }

    if(env_generate_filter_enabled("divider_walls_bent_y"))
    if(support_walls.y == 1){
      divider_size = [divider_useable_dimensions.x, divider_thickness, divider_useable_dimensions.z];

      translate([0, -divider_useable_dimensions.z + space_pos, 0])
      single_removable_divider_wall(
        divider_size=divider_size,
        slot_size=slot_size,
        divider_clearance=divider_clearance,
        divider_spacing=divider_spacing, 
        separation_count=iSep,
        wall_cutout_depth = wall_cutout_depth,
        wall_cutout_width = wall_cutout_width,
        wall_cutout_radius = wall_cutout_radius,
        top_radius = top_radius,
        label_size = label_size);
    }
  }

  if(support_walls == [1,1]) {
    max_width = max(divider_useable_dimensions.x, divider_useable_dimensions.y);
    count = divider_wall_count(divider_thickness=divider_thickness, divider_spacing=divider_spacing, useable_width=max_width);
    divider_size = [max_width, divider_thickness, divider_useable_dimensions.z];

    if(env_generate_filter_enabled("divider_walls_double_sided"))
    for(icount = [0:count-1])
    translate([max_width + divider_size.y*3, -icount*divider_size.y*5 -divider_useable_dimensions.z/2, 0])
    single_cross_removable_divider_wall(
      //divider_size.y*3 should be size, + slot, + side
      divider_size=[divider_size.x - ((divider_size.y*3)*icount), divider_size.y, divider_size.z],
      slot_size=slot_size,
      divider_clearance=divider_clearance,
      divider_spacing=divider_spacing, 
      left_slots=true, right_slots=true);
    
    if(env_generate_filter_enabled("divider_walls_single_sided"))
    for(icount = [0:count-1])
    translate([(max_width + divider_size.y*3)*2, -icount*divider_size.y*5 -divider_useable_dimensions.z/2, 0])
    single_cross_removable_divider_wall(
      //divider_size.y*3 should be size, + slot, + side
      divider_size=[divider_size.x - ((divider_size.y*3)*icount), divider_size.y, divider_size.z],
      slot_size=slot_size,
      divider_clearance=divider_clearance,
      divider_spacing=divider_spacing, 
      left_slots=true, right_slots=false);
    
    if(env_generate_filter_enabled("divider_walls_straight_sided"))
    for(icount = [0:count-1])
    translate([(max_width + divider_size.y*3)*3, -icount*divider_size.y*5 -divider_useable_dimensions.z/2, 0])
    single_removable_divider_wall(
      //divider_size.y*3 should be size, + slot, + side
      divider_size=[divider_size.x - ((divider_size.y*3)*icount), divider_size.y, divider_size.z],
      slot_size=slot_size,
      divider_clearance=divider_clearance,
      divider_spacing=divider_spacing,
      label_size = label_size);
  }
}

// Creates a single removable divider wall
//divider_size: full size of the divider, minus clearance
module single_removable_divider_wall(
  divider_size,
  slot_size,
  divider_clearance,
  divider_spacing,
  separation_count = 0,
  wall_cutout_depth = 0,
  wall_cutout_width = 0,
  wall_cutout_radius = 0,
  top_radius = 0,
  label_size = 0,
  label_angle = 45){

  assert(is_num(wall_cutout_depth), "wall_cutout_depth must be a number");
  assert(is_num(wall_cutout_width), "wall_cutout_width must be a number");
  assert(is_num(wall_cutout_radius), "wall_cutout_radius must be a number");
  assert(is_num(top_radius), "top_radius must be a number");
  base_removable_divider_wall(
    divider_size = divider_size,
    slot_size = slot_size,
    divider_clearance = divider_clearance,
    divider_spacing = divider_spacing,
    separation_count = separation_count)
      bentWall(
        length=$size.x,
        separation=$separation,
        lowerBendRadius=divider_spacing,
        upperBendRadius=divider_spacing,
        height = $size.z,
        thickness = $size.y,
        wall_cutout_depth = wall_cutout_depth,
        wall_cutout_width = wall_cutout_width,
        wall_cutout_radius = 2,
        top_radius = top_radius,
        label_size = $separation == 0 ? label_size : 0,
        label_angle = label_angle);
}

//contains the common sections of a removeable divider wall.
module base_removable_divider_wall(
  divider_size,
  slot_size,
  divider_clearance,
  divider_spacing,
  separation_count = 0, //rename to bend separation=
){
  assert(is_list(divider_size), "divider_size must be a list");
  assert(is_list(slot_size), "slot_size must be a list");
  assert(is_list(divider_clearance), "divider_clearance must be a list");
  assert(is_num(separation_count), "separation_count must be a number");
 
  fudgeFactor = 0.01;
  
  $separation = separation_count <= 0 ? 0 : separation_count*divider_spacing+separation_count*divider_size.y;
  $slot = [
    slot_size.y-divider_clearance.y/2, //Divide by 2 as there are two end
    slot_size.x-divider_clearance.x, 
    divider_size.z];
    
  //echo("base_removable_divider_wall", slot_size=slot_size, slot=$slot);
  
  $size = [ 
    divider_size.x - slot_size.y*2,
    slot_size.x == divider_size.y ? divider_size.y-divider_clearance.x : divider_size.y,
    divider_size.z];
 
  union(){
    translate([fudgeFactor,$separation/2,0])
    removable_wall_slot($slot);

    translate([$slot[0],0,0])
      //translate([0,$size.y/2,0])
      rotate([0,0,270])
      children();
    
    translate([$slot[0]*2+$size[0]-fudgeFactor,-$separation/2,0])
    rotate([0,0,180])
    removable_wall_slot($slot);
  } 
}


// Creates a single removable divider wall
module single_cross_removable_divider_wall(
  divider_size,
  slot_size,
  divider_clearance,
  divider_spacing,
  left_slots=true,
  right_slots=true){
    fudge = 0.01;

    base_removable_divider_wall(
      divider_size = divider_size,
      slot_size = slot_size,
      divider_clearance = divider_clearance,
      divider_spacing = divider_spacing,
      separation_count = 0)
    rotate([0,0,90])
    translate([0,-$slot[0]/2,0])
    difference(){
      translate([0,left_slots ? -divider_size.y:0,0])
      cube([$size.x, divider_size.y + (left_slots?divider_size.y:0)+ (right_slots?divider_size.y:0), $size.z]);

      if(left_slots)
        translate([0,-divider_size.y-fudge,-fudge])
        arange_slots_in_support(
          slot=[$slot.x, $slot.y, $slot.z+fudge*2],
          divider_thickness=divider_size.y,
          divider_spacing=divider_size.y*2,
          useable_width=$size.x)
          rotate([0,0,270])
          translate([-$slot.x,$slot.y/2,0])
          removable_wall_slot(
            size = [$slot.x, $slot.y, $slot.z+fudge*2],
            radius = 0);

      if(right_slots)
        translate([0, divider_size.y+divider_size.y-$slot.y+fudge,-fudge])
        arange_slots_in_support(
          slot=[$slot.x, $slot.y, $slot.z+fudge*2],
          divider_thickness=divider_size.y,
          divider_spacing=divider_size.y*2,
          useable_width=$size.x)
          rotate([0,0,90])
          translate([0,-$slot.y/2,0])
          removable_wall_slot(
            size = [$slot.x, $slot.y, $slot.z+fudge*2],
            radius = 0);
    }
  //}
}


//Creats the slots in the wall support
module arange_slots_in_support(
    slot, 
    divider_thickness, //width
    divider_spacing, //width*2
    useable_width //size.x
    ) {
  assert(is_list(slot), "slot must be a list");
  assert(is_num(divider_thickness), "divider_thickness must be a number");
  assert(is_num(divider_spacing), "divider_spacing must be a number");
  assert(is_num(useable_width), "useable_width must be a number");

  count = divider_wall_count(divider_thickness=divider_thickness, divider_spacing=divider_spacing, useable_width=useable_width);
  
  if(count > 0)
    union()
      for(i=[0:count-1])
        translate([divider_thickness+(divider_thickness+divider_spacing)*i,0,0])
        children();
}

module removable_wall_slot(
  size = [],
  radius = 0.5,
  nubs = 0.5
){
  assert(is_list(size), "size must be a list");
  assert(is_num(size.x), "size.x must be a number");
  assert(is_num(size.y), "size.y must be a number");
  assert(is_num(size.z), "size.z must be a number");

  fudge = 0.001;
  
  slot_width = size[iDividerRemovable_SlotWidth];
  slot_depth = size[iDividerRemovable_SlotDepth];
  slot_height = size.z;
  //echo("removable_wall_slot", size=size);
  difference(){
    translate([slot_width/2,0,slot_height/2])
    rotate([0,270,270])
    CubeWithRoundedCorner(
      size=[slot_height,slot_width,slot_depth], 
      cornerRadius = slot_width * radius,
      center=true);
    
    nub_radius = nubs+slot_depth;
    nub_pos = 5;
    
    translate([-fudge,nub_radius-nubs, nub_pos])
    rotate([0,90,0])
    cylinder(d=nub_radius, h=slot_width+fudge*2);

    translate([-fudge,-nub_radius+nubs, nub_pos])
    rotate([0,90,0])
    cylinder(d=nub_radius, h=slot_width+fudge*2);

  }
}
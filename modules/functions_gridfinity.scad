include <module_gridfinity_cup_base.scad>
include <gridfinity_constants.scad>

// set this to produce sharp corners on baseplates and bins
// not for general use (breaks compatibility) but may be useful for special cases
sharp_corners = 0;

function calcDimensionWidth(width, shouldLog = false) = calcDimension(width, "width", env_pitch().x, shouldLog);
function calcDimensionDepth(depth, shouldLog = false) = calcDimension(depth, "depth", env_pitch().y, shouldLog);
function calcDimensionHeight(height, shouldLog = false) = calcDimension(height, "height", env_pitch().z, shouldLog); 
function calcDimension(value, name, unitSize, shouldLog) = 
  is_num(value) ? 
    (shouldLog ? echo(str("🟩",name,": ", value, "gf (",value*unitSize,"mm)"), input=value) value : value)
  : assert(is_list(value) && len(value) == 2, str(unitSize ," should be array of length 2"))
    let(calcUnits = value[1] != 0 ? value[1]/unitSize : value[0],
    roundedCalcUnits = roundtoDecimal(calcUnits,4))
    (shouldLog ? echo(str("🟩",name,": ", calcUnits, "gf (",calcUnits*unitSize,"mm)"), input=value, roundedCalcUnits=roundedCalcUnits) roundedCalcUnits: roundedCalcUnits);

constTopHeight = let(fudgeFactor = 0.01) 5.7+fudgeFactor*5; //Need to confirm this
  
  
//returns unit position to mm.
//positive values are in units.
//negative values are ration total/abs(value)
function wallCutoutPosition_mm(userPosition, wallLength, pitch) = unitPositionTo_mm(userPosition, wallLength, pitch);
function unitPositionTo_mm(userPosition, wallLength, pitch) = 
  assert(is_num(userPosition), "userPosition must be a number")
  assert(is_num(wallLength), "wallLength must be a number")
  assert(is_num(pitch), "pitch must be a number")
  (userPosition < 0 ? wallLength*pitch/abs(userPosition) : pitch*userPosition);
  
//0.6 is needed to align the top of the cutout, need to fix this
function calculateWallTop(num_z, lip_style) =
  //env_pitch().z * num_z + (lip_style != "none" ? gf_Lip_Height-0.6 : 0);
  env_pitch().z * num_z + (lip_style != "none" ? gf_Lip_Height : 0);

  //calculates the magent position in from the center of the pitch in a single dimention
function calculateAttachmentPosition(magnet_diameter=0, screw_diameter=0, pitch = env_pitch().x) = 
  assert(is_num(magnet_diameter) && magnet_diameter >= 0, "magnet_diameter must be a non-negative number")
  assert(is_num(screw_diameter) && screw_diameter >= 0, "screw_diameter must be a non-negative number")
  assert(is_num(pitch) && pitch >= 0, "pitch must be a non-negative number")
  let(attachment_diameter = max(magnet_diameter, screw_diameter))
  attachment_diameter == 0 
    ? 0
    : min(pitch/2-8, pitch/2-4-attachment_diameter/2);

//calculates the magent position in from the center of the pitch in a both x and y dimention
function calculateAttachmentPositions(magnet_diameter=0, screw_diameter=0, pitch = env_pitch()) = 
  assert(is_num(magnet_diameter) && magnet_diameter >= 0, "magnet_diameter must be a non-negative number")
  assert(is_num(screw_diameter) && screw_diameter >= 0, "screw_diameter must be a non-negative number")
  assert(is_list(pitch) && len(pitch) == 3, "pitch must be a list of three numbers")
  [calculateAttachmentPosition(magnet_diameter, screw_diameter, pitch.x),
  calculateAttachmentPosition(magnet_diameter, screw_diameter, pitch.y)];

//zpos from 0 for wall pattern to clear. outer walls and dividers use this
function wallpatternClearanceHeight(magnet_depth, screw_depth, center_magnet, floor_thickness, num_z=1, filled_in="disabled", efficient_floor, flat_base, floor_inner_radius, outer_cup_radius) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_num(floor_thickness))
  assert(is_num(num_z))
  assert(is_string(filled_in)) 
  assert(is_string(efficient_floor)) 
  assert(is_string(flat_base))
  assert(is_num(floor_inner_radius))
  assert(is_num(outer_cup_radius))
  let(cfh = calculateFloorHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor=efficient_floor, flat_base=flat_base),
      cbch = cupBaseClearanceHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, center_magnet=center_magnet, flat_base=flat_base),
      _floor_inner_radius = efficient_floor == FlatBase_off ? floor_inner_radius : 0,
      result = max(
        (efficient_floor == EfficientFloor_off ? cfh+floor_inner_radius : 5.3), //5.3 clears the inner radius of smooth
        (flat_base == FlatBase_gridfinity ? cfh + _floor_inner_radius : 0),
        (flat_base == FlatBase_rounded ? max(outer_cup_radius, _floor_inner_radius+floor_thickness) : 0)))
      env_help_enabled("trace") ? echo("wallpatternClearanceHeight", result=result, cbch=cbch, magnet_depth=magnet_depth, screw_depth=screw_depth, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor=efficient_floor, flat_base=flat_base) result : result;

function calculateCavityFloorRadius(cavity_floor_radius, wall_thickness, efficientFloor) = let(
  q = 1.65 - wall_thickness + 0.95 // default 1.65 corresponds to wall thickness of 0.95
  //efficient floor has an effective radius of 0
) efficientFloor != "off" ? 0 
  : cavity_floor_radius >= 0 ? min((2.3+2*q)/2, cavity_floor_radius) : (2.3+2*q)/2;
  
//Height to clear the voids in the base (attachments and inner grid).
function cupBaseClearanceHeight(magnet_depth, screw_depth, center_magnet, flat_base=FlatBase_off) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_string(flat_base))
  flat_base == FlatBase_rounded ? max(magnet_depth, screw_depth) //todo should consider rounded radius.
    : flat_base == FlatBase_gridfinity ? max(gf_base_grid_clearance_height, magnet_depth, screw_depth) //3.5 clears the side stacking indents
    : max(magnet_depth, screw_depth, gfBaseHeight());

//Height of base including the floor.
function calculateFloorHeight(magnet_depth, screw_depth, center_magnet=0, floor_thickness, num_z=1, filled_in="disabled", efficient_floor, flat_base, captive_magnet_height=0) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_num(floor_thickness))
  assert(is_num(num_z))
  assert(is_string(filled_in))
  assert(is_string(efficient_floor))
  assert(is_string(flat_base))
  assert(is_num(captive_magnet_height))
  let(
    filled_in = validateFilledIn(filled_in),
    floorThickness = max(floor_thickness, gf_cup_floor_thickness),
    clearanceHeight = cupBaseClearanceHeight(magnet_depth=magnet_depth + captive_magnet_height, screw_depth=screw_depth, center_magnet=center_magnet, flat_base=flat_base), 
    result = 
      filled_in != FilledIn_disabled ? num_z * env_pitch().z 
        : efficient_floor != "off" 
          ? floorThickness
          : max(0, clearanceHeight + floorThickness))
  env_help_enabled("trace") ? echo("calculateFloorHeight", result=result, magnet_depth=magnet_depth, screw_depth=screw_depth, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor=efficient_floor, flat_base=flat_base) result : result;
      
//Usable floor depth (floor height - height of voids)
//used in the item holder
function calculateUsableFloorThickness(magnet_depth, screw_depth, center_magnet=0,floor_thickness, num_z, filled_in, flat_base=FlatBase_off) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_num(floor_thickness))
  assert(is_num(num_z))
  assert(is_string(filled_in))
  assert(is_string(flat_base))
  let(
    cfh = calculateFloorHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, center_magnet=center_magnet, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor="off", flat_base=flat_base),
    cbch = cupBaseClearanceHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, center_magnet=center_magnet, flat_base=flat_base),
    usableFloorThickness = cfh - cbch)
  env_help_enabled("trace") ? 
  echo("calculateFloorThickness", usableFloorThickness=usableFloorThickness, cfh=cfh, cbch=cbch, num_z=num_z, magnet_depth=magnet_depth,screw_depth=screw_depth, floor_thickness=floor_thickness, filledin=filledin) usableFloorThickness :
  usableFloorThickness;
  
function gridfinityRenderPosition(position, num_x, num_y) = 
    position == "center" ? [-(num_x)*env_pitch().x/2, -(num_y)*env_pitch().y/2, 0] 
    : position == "zero" ? [0, 0, 0] 
    : [-env_pitch().x/2, -env_pitch().y/2, 0]; 

//wall_thickness default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm) 
function wallThickness(wall_thickness, num_z) = wall_thickness != 0 ? wall_thickness
        : num_z < 6 ? 0.95
        : num_z < 12 ? 1.2
        : 1.6;
        
/* Data types */
function list_contains(list,value,index=0) = 
  assert(is_list(list), "list must be a list")
  assert(index >= 0 && index < len(list), str("List does not contain value '", value, "'index is invalid len '" , len(list) , "' index '", index, "' List:", list))
  list[index] == value 
    ? true 
    : index <= len(list)  ? list_contains(list,value,index+1)
    : false;
function typeerror(type, value) = str("invalid value for type '" , type , "'; value '" , value ,"'");
function typeerror_list(name, list, expectedLength) = str(name, " must be a list of length ", expectedLength, ", length:", is_list(list) ? len(list) : "not a list");

FilledIn_disabled = "disabled";
FilledIn_enabled = "enabled";
FilledIn_enabledfilllip = "enabledfilllip";
FilledIn_values = [FilledIn_disabled,FilledIn_enabled,FilledIn_enabledfilllip];
function validateFilledIn(value) = 
  //Convert boolean to list value
  let(value = is_bool(value) ? value ? FilledIn_enabled : FilledIn_disabled : value)
  assert(list_contains(FilledIn_values, value), typeerror("FilledIn", value))
  value;
 
Stackable_enabled = "enabled";
Stackable_disabled = "disabled";
Stackable_filllip = "filllip";
Stackable_values = [Stackable_enabled,Stackable_disabled,Stackable_filllip];
  function validateStackable(value) = 
  //Convert boolean to list value
  let(value = is_bool(value) ? value ? Stackable_enabled : Stackable_disabled : value) 
  assert(list_contains(Stackable_values, value), typeerror("Stackable", value))
  value;  
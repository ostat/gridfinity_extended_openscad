// set this to produce sharp corners on baseplates and bins
// not for general use (breaks compatibility) but may be useful for special cases
sharp_corners = 0;

function calcDimensionWidth(width, shouldLog = false) = calcDimension(width, "width", gf_pitch, shouldLog);
function calcDimensionDepth(depth, shouldLog = false) = calcDimension(depth, "depth", gf_pitch, shouldLog);
function calcDimensionHeight(height, shouldLog = false) = calcDimension(height, "height", gf_zpitch, shouldLog); 
function calcDimension(value, name, unitSize, shouldLog) = 
  is_num(value) ? 
    (shouldLog ? echo(str("🟩",name,": ", value, "gf (",value*unitSize,"mm)"), input=value) value : value)
  : assert(is_list(value) && len(value) == 2, str(unitSize ," should be array of length 2"))
    let(calcUnits = value[1] != 0 ? value[1]/unitSize : value[0],
    roundedCalcUnits = roundtoDecimal(calcUnits,4))
    (shouldLog ? echo(str("🟩",name,": ", calcUnits, "gf (",calcUnits*unitSize,"mm)"), input=value, roundedCalcUnits=roundedCalcUnits) roundedCalcUnits: roundedCalcUnits);
          
function calculateCavityFloorRadius(cavity_floor_radius, wall_thickness, efficientFloor) = let(
  q = 1.65 - wall_thickness + 0.95 // default 1.65 corresponds to wall thickness of 0.95
  //efficient floor has an effective radius of 0
) efficientFloor != "off" ? 0 
  : cavity_floor_radius >= 0 ? min((2.3+2*q)/2, cavity_floor_radius) : (2.3+2*q)/2;

constTopHeight = let(fudgeFactor = 0.01) 5.7+fudgeFactor*5; //Need to confirm this
  
  
//unit position to mm.
//positive values are in units.
//negative values are ration total/abs(value)
function wallCutoutPosition_mm(userPosition, wallLength) = unitPositionTo_mm(userPosition, wallLength);
function unitPositionTo_mm(userPosition, wallLength) = 
  (userPosition < 0 ? wallLength*gf_pitch/abs(userPosition) : gf_pitch*userPosition);
  
//0.6 is needed to align the top of the cutout, need to fix this
function calculateWallTop(num_z, lip_style) =
  gf_zpitch * num_z + (lip_style != "none" ? gf_Lip_Height-0.6 : 0);
  
//Height to clear the voids in the base
function cupBaseClearanceHeight(magnet_depth, screw_depth, flat_base=false) = 
    flat_base 
      ? max(magnet_depth, screw_depth) 
      : max(magnet_depth, screw_depth, gfBaseHeight());

function calculateMinFloorHeight(magnet_depth,screw_depth) = 
    cupBaseClearanceHeight(magnet_depth,screw_depth) + gf_cup_floor_thickness;
function calculateMagnetPosition(magnet_diameter) = min(gf_pitch/2-8, gf_pitch/2-4-magnet_diameter/2);

//Height of base including the floor.
function calculateFloorHeight(magnet_depth, screw_depth, floor_thickness, num_z=1, filledin = false, efficient_floor = "off", flat_base=false) = 
      assert(is_num(floor_thickness), "floor_thickness must be a number")
      assert(is_num(magnet_depth), "magnet_depth must be a number")
      assert(is_num(screw_depth), "screw_depth must be a number")
      assert(is_bool(flat_base), "flat_base must be a bool")
      let(
        filledin = validateFilledIn(filledin),
        floorThickness = max(floor_thickness, gf_cup_floor_thickness))
  filledin != FilledIn_disabled ? num_z * gf_zpitch 
    : efficient_floor != "off" 
      ? floorThickness
      : max(3.5, cupBaseClearanceHeight(magnet_depth,screw_depth, flat_base) + max(floor_thickness, gf_cup_floor_thickness));
    
//Usable floor depth (floor height - min floor)
function calculateFloorThickness(magnet_depth, screw_depth, floor_thickness, num_z, filledin) = 
  calculateFloorHeight(magnet_depth, screw_depth, floor_thickness, num_z, filledin) - cupBaseClearanceHeight(magnet_depth, screw_depth);
    
// calculate the position of separators from the size
function splitChamber(num_separators, num_x) = num_separators < 1 
      ? [] 
      : [ for (i=[1:num_separators]) i*(num_x/(num_separators+1))*gf_pitch];

function LookupKnownShapes(name="round") = 
  name == "square" ? 4 :
  name == "hex" ? 6 : 64;
  
function cupPosition(position, num_x, num_y) = gridfinityRenderPosition(position, num_x, num_y);
function gridfinityRenderPosition(position, num_x, num_y) = 
    position == "center" ? [-(num_x)*gf_pitch/2, -(num_y)*gf_pitch/2, 0] 
    : position == "zero" ? [0, 0, 0] 
    : [-gf_pitch/2, -gf_pitch/2, 0]; 

//wall_thickness default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm) 
function wallThickness(wall_thickness, num_z) = wall_thickness != 0 ? wall_thickness
        : num_z < 6 ? 0.95
        : num_z < 12 ? 1.2
        : 1.6;
        
/* Data types */
function list_contains(list,value,index=0) = 
  assert(is_list(list), "list must be a list")
  assert(index >= 0 && index < len(list), str("index is invalid len '" , len(list) , "' index '", index, "'"))
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

EfficientFloor_off = "off";
EfficientFloor_on = "on";
EfficientFloor_rounded = "rounded";
EfficientFloor_smooth = "smooth";
EfficientFloor_values = [EfficientFloor_off,EfficientFloor_on,EfficientFloor_rounded,EfficientFloor_smooth];
function validateEfficientFloor(value) = 
  assert(list_contains(EfficientFloor_values, value), typeerror("EfficientFloor", value))
  value;

LipStyle_normal = "normal";
LipStyle_reduced = "reduced";
LipStyle_minimum = "minimum";
LipStyle_none = "none";
LipStyle_values = [LipStyle_normal,LipStyle_reduced,LipStyle_minimum,LipStyle_none];
function validateLipStyle(value) = 
  assert(list_contains(LipStyle_values, value), typeerror("LipStyle", value))
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
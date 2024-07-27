// set this to produce sharp corners on baseplates and bins
// not for general use (breaks compatibility) but may be useful for special cases
sharp_corners = 0;

function calcDimensionWidth(width) = calcDimension(width, "width", gf_pitch);
function calcDimensionDepth(depth) = calcDimension(depth, "depth", gf_pitch);
function calcDimensionHeight(height) = calcDimension(height, "height", gf_zpitch); 
function calcDimension(value, name, unitSize) = 
  is_num(value) ? value : 
  assert(is_list(value) && len(value) == 2, str(unitSize ," should be array of length 2"))
  value[1] != 0 ? value[1]/unitSize : value[0];
          
function calcualteCavityFloorRadius(cavity_floor_radius, wall_thickness, efficientFloor) = let(
  q = 1.65 - wall_thickness + 0.95 // default 1.65 corresponds to wall thickness of 0.95
  //efficient floor has an effective radius of 0
) efficientFloor != "off" ? 0 
  : cavity_floor_radius >= 0 ? min((2.3+2*q)/2, cavity_floor_radius) : (2.3+2*q)/2;

constTopHeight = let(fudgeFactor = 0.01) 5.7+fudgeFactor*5; //Need to confirm this

function wallCutoutPosition_mm(userPosition, wallLength) = 
  (userPosition < 0 ? wallLength*gf_pitch/abs(userPosition) : gf_pitch*userPosition);

//0.6 is needed to align the top of the cutout, need to fix this
function calculateWallTop(num_z, lip_style) =
  gf_zpitch * num_z + (lip_style != "none" ? gf_Lip_Height-0.6 : 0);
  
//Height to clear the voids in the base
function cupBaseClearanceHeight(magnet_diameter, screw_depth, flat_base=false) = let (
    mag_ht = magnet_diameter > 0 ? gf_magnet_thickness : 0)
    flat_base 
      ? max(mag_ht, screw_depth) 
      : max(mag_ht, screw_depth, gfBaseHeight());

function calculateMinFloorHeight(magnet_diameter,screw_depth) = 
    cupBaseClearanceHeight(magnet_diameter,screw_depth) + gf_cup_floor_thickness;
function calculateMagnetPosition(magnet_diameter) = min(gf_pitch/2-8, gf_pitch/2-4-magnet_diameter/2);

//Height of base including the floor.
function calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness, num_z=1, filledin = false, efficient_floor = "off", flat_base=false) = 
      let(floorThickness = max(floor_thickness, gf_cup_floor_thickness))
  filledin ? num_z * gf_zpitch 
    : efficient_floor != "off" 
      ? floorThickness
      : max(3.5, cupBaseClearanceHeight(magnet_diameter,screw_depth, flat_base) + max(floor_thickness, gf_cup_floor_thickness));
    
//Usable floor depth (florr height - min floor)
function calculateFloorThickness(magnet_diameter, screw_depth, floor_thickness, num_z, filledin) = 
  calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness, num_z, filledin) - cupBaseClearanceHeight(magnet_diameter, screw_depth);
    
// calculate the position of separators from the size
function splitChamber(num_separators, num_x) = num_separators < 1 
      ? [] 
      : [ for (i=[1:num_separators]) i*(num_x/(num_separators+1))*gf_pitch];

function LookupKnownShapes(name="round") = 
  name == "square" ? 4 :
  name == "hex" ? 6 : 64;
  
function cupPosition(position, num_x, num_y) = 
    position == "center" ? [-(num_x)*gf_pitch/2, -(num_y)*gf_pitch/2, 0] 
    : position == "zero" ? [0, 0, 0] 
    : [-gf_pitch/2, -gf_pitch/2, 0]; 

//wall_thickness default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm) 
function wallThickness(wall_thickness, num_z) = wall_thickness != 0 ? wall_thickness
        : num_z < 6 ? 0.95
        : num_z < 12 ? 1.2
        : 1.6;
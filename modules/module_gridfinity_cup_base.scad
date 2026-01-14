include <gridfinity_constants.scad>

/* [Base]
// (Zack's design uses magnet diameter of 6.5) 
magnet_diameter = 0;  // .1
//create relief for magnet removal 
magnet_easy_release  = "auto";//["off","auto","inner","outer"] 
// (Zack's design uses depth of 6)
screw_depth = 0;
center_magnet_diameter =0;
center_magnet_thickness = 0;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = true;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth] 
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = false;
// Remove floor to create a vertical spacer
spacer = false;
*/

iCupBase_MagnetSize=0;
iCupBase_MagnetEasyRelease=1;
iCupBase_CenterMagnetSize=2;
iCupBase_ScrewSize=3;
iCupBase_HoleOverhangRemedy=4;
iCupBase_CornerAttachmentsOnly=5;
iCupBase_FloorThickness=6;
iCupBase_CavityFloorRadius=7;
iCupBase_EfficientFloor=8;
iCupBase_HalfPitch=9;
iCupBase_FlatBase=10;
iCupBase_Spacer=11;
iCupBase_MinimumPrintablePadSize=12;
iCupBase_FlatBaseRoundedRadius=13;
iCupBase_FlatBaseRoundedEasyPrint=14;
iCupBase_MagnetCaptiveHeight=15;
iCupBase_AlignGrid=16;

iCylinderDimension_Diameter=0;
iCylinderDimension_Height=1;

EfficientFloor_off = "off";
EfficientFloor_on = "on";
EfficientFloor_rounded = "rounded";
EfficientFloor_smooth = "smooth";

EfficientFloor_values = [EfficientFloor_off, EfficientFloor_on, EfficientFloor_rounded, EfficientFloor_smooth];
  function validateEfficientFloor(value) = 
    //Convert boolean to list value
    let(value = is_bool(value) ? value ? EfficientFloor_on : EfficientFloor_off : value)
    assert(list_contains(EfficientFloor_values, value), typeerror("EfficientFloor", value))
    value;  

FlatBase_off = "off";
FlatBase_gridfinity = "gridfinity";
FlatBase_rounded = "rounded";

FlatBase_values = [FlatBase_off, FlatBase_gridfinity, FlatBase_rounded];
  function validateFlatBase(value) = 
    //Convert boolean to list value
    let(value = is_bool(value) ? value ? FlatBase_gridfinity : FlatBase_off : value)
    assert(list_contains(FlatBase_values, value), typeerror("FlatBase", value))
    value;  
    
function CupBaseSettings(
    magnetSize = [0,0], 
    magnetEasyRelease = MagnetEasyRelease_auto, 
    centerMagnetSize = [0,0], 
    screwSize = [0,0], 
    holeOverhangRemedy = 2, 
    cornerAttachmentsOnly = true,
    floorThickness = gf_cup_floor_thickness,
    cavityFloorRadius = -1,
    efficientFloor = EfficientFloor_off,
    halfPitch = false,
    flatBase = FlatBase_off,
    spacer = false,
    minimumPrintablePadSize = 0,
    flatBaseRoundedRadius=-1,
    flatBaseRoundedEasyPrint=-1,
    magnetCaptiveHeight = 0,
    alignGrid = ["near", "near"]
    ) = 
  let(
    magnetSize = 
      is_num(magnetSize) 
        ? [magnetSize, gf_magnet_thickness]
        : magnetSize,
    screwSize = 
      is_num(screwSize) 
        ? [gf_cupbase_screw_diameter, screwSize]
        : screwSize,
      
    efficientFloor = validateEfficientFloor(efficientFloor),
    centerMagnetSize = efficientFloor != EfficientFloor_off ? [0, 0] : centerMagnetSize,
    cavityFloorRadius = efficientFloor != EfficientFloor_off ? 0 : cavityFloorRadius,
    magnetEasyRelease = validateMagnetEasyRelease(magnetEasyRelease, efficientFloor),
    result = [
      magnetSize[0] == 0 || magnetSize[1] == 0 ? [0,0] : magnetSize, 
      validateMagnetEasyRelease(magnetEasyRelease), 
      centerMagnetSize[0] == 0 || centerMagnetSize[1] == 0 ? [0,0] : centerMagnetSize,
      screwSize[0] == 0 || screwSize[1] == 0 ? [0,0] : screwSize, 
      holeOverhangRemedy, 
      cornerAttachmentsOnly,
      floorThickness,
      cavityFloorRadius,
      validateEfficientFloor(efficientFloor),
      halfPitch,
      validateFlatBase(flatBase),
      spacer,
      minimumPrintablePadSize,
      flatBaseRoundedRadius,
      flatBaseRoundedEasyPrint,
      magnetCaptiveHeight,
      alignGrid
      ],
    validatedResult = ValidateCupBaseSettings(result)
  ) validatedResult;
  
function ValidateCupBaseSettings(settings, num_x, num_y) =
  assert(is_list(settings) && len(settings) == 17, typeerror_list("CupBase Settings", settings, 17))
  assert(is_list(settings[iCupBase_MagnetSize]) && len(settings[iCupBase_MagnetSize])==2, "CupBase Magnet Setting must be a list of length 2")
  assert(is_list(settings[iCupBase_CenterMagnetSize]) && len(settings[iCupBase_CenterMagnetSize])==2, "CenterMagnet Magnet Setting must be a list of length 2")
  assert(is_list(settings[iCupBase_ScrewSize]) && len(settings[iCupBase_ScrewSize])==2, "ScrewSize Magnet Setting must be a list of length 2")
  assert(is_num(settings[iCupBase_HoleOverhangRemedy]), "CupBase HoleOverhangRemedy Settings must be a number")
  assert(is_bool(settings[iCupBase_CornerAttachmentsOnly]), "CupBase CornerAttachmentsOnly Settings must be a boolean")
  assert(is_num(settings[iCupBase_FloorThickness]), "CupBase FloorThickness Settings must be a number")
  assert(is_num(settings[iCupBase_CavityFloorRadius]), "CupBase CavityFloorRadius Settings must be a number")
  assert(is_bool(settings[iCupBase_HalfPitch]), "CupBase HalfPitch Settings must be a boolean")
  assert(is_string(settings[iCupBase_FlatBase]), "CupBase FlatBase Settings must be a string")
  assert(is_bool(settings[iCupBase_Spacer]), "CupBase Spacer Settings must be a boolean")
  assert(is_num(settings[iCupBase_MinimumPrintablePadSize]), "CupBase minimumPrintablePadSize Settings must be a number")
  assert(is_num(settings[iCupBase_MagnetCaptiveHeight]), "CupBase Magnet Captive height setting must a number")
  assert(is_list(settings[iCupBase_AlignGrid]) && len(settings[iCupBase_AlignGrid])==2, "CupBase AlignGrid Setting must be a list of length 2")
  
  let(
    efficientFloor = validateEfficientFloor(settings[iCupBase_EfficientFloor]),
    magnetEasyRelease = validateMagnetEasyRelease(settings[iCupBase_MagnetEasyRelease], efficientFloor),
    flatBase = validateFlatBase(settings[iCupBase_FlatBase])
  ) [
      settings[iCupBase_MagnetSize],
      magnetEasyRelease,
      settings[iCupBase_CenterMagnetSize],
      settings[iCupBase_ScrewSize],
      settings[iCupBase_HoleOverhangRemedy],
      settings[iCupBase_CornerAttachmentsOnly],
      settings[iCupBase_FloorThickness],
      settings[iCupBase_CavityFloorRadius],
      efficientFloor,
      settings[iCupBase_HalfPitch],
      flatBase,
      settings[iCupBase_Spacer],
      settings[iCupBase_MinimumPrintablePadSize],
      settings[iCupBase_FlatBaseRoundedRadius],
      settings[iCupBase_FlatBaseRoundedEasyPrint],
      settings[iCupBase_MagnetCaptiveHeight],
      settings[iCupBase_AlignGrid]
      ];
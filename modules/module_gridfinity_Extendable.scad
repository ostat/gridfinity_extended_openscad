include <gridfinity_constants.scad>
include <module_gridfinity_block.scad>
use <module_attachment_clip.scad>

/* [Extendable]
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5; 
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5; 
extension_tabs_enabled = true;
//Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];
*/
iExtendablex=0;
iExtendabley=1;
iExtendableTabsEnabled=2;
iExtendableTabSize=3;

iExtendableEnabled=0;
iExtendablePosition=1;
iExtendablePositionmm=2;

iExtendableTabSizeHeight=0;
iExtendableTabSizeWidth=1;
iExtendableTabSizeThickness=2;
iExtendableTabSizeStyle=3;

BinExtensionEnabled_disabled = "disabled";
BinExtensionEnabled_front = "front";
BinExtensionEnabled_back = "back";
BinExtensionEnabled_values = [BinExtensionEnabled_disabled, BinExtensionEnabled_front, BinExtensionEnabled_back];
function validateBinExtensionEnabled(value, name = "BinExtensionEnabled") = 
  assert(list_contains(BinExtensionEnabled_values, value), typeerror(name, value))
  value;
  
function ExtendableSettings(
    extendablexEnabled, 
    extendablexPosition, 
    extendableyEnabled, 
    extendableyPosition, 
    extendableTabsEnabled, 
    extendableTabSize) = 
  let(
    xEnabled = validateBinExtensionEnabled(
      is_bool(extendablexEnabled) 
        ? extendablexEnabled ? BinExtensionEnabled_front : BinExtensionEnabled_disabled 
        : extendablexEnabled),
    yEnabled = validateBinExtensionEnabled(
      is_bool(extendableyEnabled) 
        ? extendableyEnabled ? BinExtensionEnabled_front : BinExtensionEnabled_disabled 
        : extendableyEnabled),
    xPosition = is_bool(extendablexEnabled) ? 0.5 : extendablexPosition,
    yPosition = is_bool(extendableyEnabled) ? 0.5 : extendableyPosition,
    result = [
      [xEnabled, xPosition],
      [yEnabled, yPosition],
      extendableTabsEnabled,
      extendableTabSize],
    validatedResult = ValidateExtendableSettings(result)
  ) validatedResult;

function ValidateExtendableSettings(settings, num_x, num_y) =
  assert(is_list(settings), "Extendable Settings must be a list")
  assert(len(settings)==4, "Extendable Settings must length 4")
  assert(is_list(settings[iExtendablex]) && len(settings[iExtendablex])>=2 && len(settings[iExtendablex])<=3, "Extendable x Settings must length 2 or 3")
  assert(is_list(settings[iExtendabley]) && len(settings[iExtendabley])>=2 && len(settings[iExtendabley])<=3, "Extendable y Settings must length 2 or 3")
  let(
    xetendableEnabled = validateBinExtensionEnabled(settings[iExtendablex][iExtendableEnabled]),
    yetendableEnabled = validateBinExtensionEnabled(settings[iExtendabley][iExtendableEnabled]),
    cutx = !is_undef(num_x) ? unitPositionTo_mm(settings.x[iExtendablePosition],num_x,env_pitch().x) : num_x,
    cuty = !is_undef(num_y) ? unitPositionTo_mm(settings.y[iExtendablePosition],num_y,env_pitch().y) : num_y
  ) [
      [xetendableEnabled, settings[iExtendablex][iExtendablePosition], cutx],
      [yetendableEnabled, settings[iExtendabley][iExtendablePosition], cuty],
      settings[iExtendableTabsEnabled],
      settings[iExtendableTabSize]];
      
module cut_bins_for_extension(
  num_x,
  num_y,
  num_z,
  extendable_Settings
){
  fudgeFactor = 0.01;
      if(extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_disabled)
      color(env_colour(color_wallcutout))
      if(extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_front)
      tz(-fudgeFactor)
        cube([unitPositionTo_mm(extendable_Settings.x[1],num_x,env_pitch().x),num_y*env_pitch().y,(num_z+1)*env_pitch().z]);
      else
        translate([unitPositionTo_mm(extendable_Settings.x[1],num_x,env_pitch().x),0,-fudgeFactor])
          cube([num_x*env_pitch().x-unitPositionTo_mm(extendable_Settings.x[1],num_x,env_pitch().x),num_y*env_pitch().y,(num_z+1)*env_pitch().z]);
    
    if(extendable_Settings.y[0]!=BinExtensionEnabled_disabled)
      color(env_colour(color_wallcutout))
      if(extendable_Settings.y[0]==BinExtensionEnabled_front)
        tz(-fudgeFactor)
        cube([env_pitch().x*num_x,unitPositionTo_mm(extendable_Settings.y[1],num_y,env_pitch().y),(num_z+1)*env_pitch().z]);
      else
        translate([0,unitPositionTo_mm(extendable_Settings.y[1],num_y,env_pitch().y),-fudgeFactor])
        cube([env_pitch().x*num_x,num_y*env_pitch().x-unitPositionTo_mm(extendable_Settings.y[1],num_y,env_pitch().y),(num_z+1)*env_pitch().z]);
}

module extension_tabs(
  num_x,
  num_y,
  num_z,
  extendable_Settings,
  cupBase_settings,
  lip_settings,
  floor_thickness,
  wall_thickness,
  headroom
  ){
    if((extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_disabled || extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_disabled) && extendable_Settings[iExtendableTabsEnabled]) {
      refTabHeight = extendable_Settings[iExtendableTabSize].x;
      tabThickness = extendable_Settings[iExtendableTabSize].z == 0 ? 1.4 : extendable_Settings[iExtendableTabSize].z;//1.4; //This should be calculated
      tabWidth = extendable_Settings[iExtendableTabSize].y;
      tabStyle = extendable_Settings[iExtendableTabSize][iExtendableTabSizeStyle];
      
      calculatedFloorHeight = calculateFloorHeight(
        magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
        screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
        center_magnet=cupBase_settings[iCupBase_CenterMagnetSize][iCylinderDimension_Height], 
        floor_thickness=floor_thickness,
        filled_in="disabled",
        efficient_floor=cupBase_settings[iCupBase_EfficientFloor], 
        flat_base=cupBase_settings[iCupBase_FlatBase],
        captive_magnet_height=cupBase_settings[iCupBase_MagnetCaptiveHeight]);

      calculatedCavityFloorRadius = calculateCavityFloorRadius(
          cupBase_settings[iCupBase_CavityFloorRadius], 
          wall_thickness, 
          cupBase_settings[iCupBase_EfficientFloor]);

      calculatedcupBaseClearanceHeight = cupBaseClearanceHeight(
        magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
        screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
        center_magnet=cupBase_settings[iCupBase_CenterMagnetSize][iCylinderDimension_Height], 
        flat_base=cupBase_settings[iCupBase_FlatBase]);

      floorHeight = calculatedcupBaseClearanceHeight + floor_thickness + calculatedCavityFloorRadius;

      echo("extension tabs", calculatedFloorHeight=calculatedFloorHeight, calculatedCavityFloorRadius=calculatedCavityFloorRadius, floorHeight=floorHeight, tabThickness=tabThickness);

      //todo need to correct this
      lipheight = lip_settings[iLipStyle] == "none" ? tabThickness
        : lip_settings[iLipStyle] == "reduced" ? gf_lip_upper_taper_height+tabThickness
        : lip_settings[iLipStyle] == "reduced_double" ? gf_lip_upper_taper_height+tabThickness
        //Add tabThickness, as the taper can bleed in to the lip
        : gf_lip_upper_taper_height + gf_lip_lower_taper_height-tabThickness;
      ceilingHeight = env_pitch().z*num_z-headroom-lipheight;
    
      //tabWorkingheight = (num_z-1)*env_pitch().z-gf_Lip_Height;
      tabWorkingheight = ceilingHeight-floorHeight;
    
      tabsCount = max(floor(tabWorkingheight/refTabHeight),1);
      tabHeight = tabWorkingheight/tabsCount;
      if(env_help_enabled("debug")) echo("tabs", binHeight =num_z, tabHeight=tabHeight, floorHeight=floorHeight, cavity_floor_radius=cupBase_settings[iCupBase_CavityFloorRadius], tabThickness=tabThickness);
      cutx = extendable_Settings.x[iExtendablePositionmm];
      cuty = extendable_Settings.y[iExtendablePositionmm];
      even = (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_back) ?
                [[0,180,90], [cutx,num_y*env_pitch().y-wall_thickness-env_clearance().y/2,floorHeight], "darkgreen"]
              : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,180,180], [wall_thickness+env_clearance().x/2,cuty,floorHeight], "green"]
              : (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,180,270], [cutx,wall_thickness+env_clearance().y/2,floorHeight], "lime"]
              : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,180,0], [num_x*env_pitch().x-wall_thickness-env_clearance().x/2,cuty,floorHeight], "aqua"] 
              : [[0,0,0],[0,0,0], extendable_Settings, "grey"];
      odd = (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,0,90], [cutx,wall_thickness+env_clearance().y/2,floorHeight], "pink"]
            : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_back) ?
                [[0,0,180], [num_x*env_pitch().x-wall_thickness-env_clearance().y/2,cuty,floorHeight], "red"]
            : (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_back) ?
                [[0,0,270], [cutx,num_y*env_pitch().y-wall_thickness-env_clearance().y/2,floorHeight], "orange"]
            : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,0,0], [wall_thickness+env_clearance().x/2,cuty,floorHeight], "yellow"]
            : [[0,0,0],[0,0,0], extendable_Settings, "grey"];
              
      for(i=[0:1:tabsCount-1])
      {
        isOdd = i % 2;
        tabPos = isOdd == 0 ? even : odd;
        if(env_help_enabled("trace")) echo("tabs", i=i, isOdd=isOdd, tabPos=tabPos);
        tz((i+0.5)*tabHeight)
        translate(tabPos[1])
          rotate(tabPos[0])
          attachment_clip(height=tabHeight, width=tabWidth, thickness=tabThickness, footingThickness=wall_thickness, tabStyle=tabStyle);
      }
    }
}
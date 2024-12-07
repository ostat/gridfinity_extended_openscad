include <gridfinity_constants.scad>
include <module_gridfinity.scad>

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
    cutx = !is_undef(num_x) ? unitPositionTo_mm(settings.x[iExtendablePosition],num_x) : num_x,
    cuty = !is_undef(num_y) ? unitPositionTo_mm(settings.y[iExtendablePosition],num_y) : num_y,
  ) [
      [xetendableEnabled, settings[iExtendablex][iExtendablePosition], cutx],
      [yetendableEnabled, settings[iExtendabley][iExtendablePosition], cuty],
      settings[iExtendableTabsEnabled],
      settings[iExtendableTabSize]];

include <gridfinity_constants.scad>
include <functions_general.scad>

iCupBaseTextLine1Enabled = 0;
iCupBaseTextLine2Enabled = 1;
iCupBaseTextLine1Value = 2;
iCupBaseTextLine2Value = 3;
iCupBaseTextFontSize = 4;
iCupBaseTextFont = 5;
iCupBaseTextDepth = 6;
iCupBaseTextOffset = 7;

function CupBaseTextSettings(
  baseTextLine1Enabled,
  baseTextLine2Enabled,
  baseTextLine1Value,
  baseTextLine2Value,
  baseTextFontSize,
  baseTextFont,
  baseTextDepth,
  baseTextOffset) = 
  [baseTextLine1Enabled, 
  baseTextLine2Enabled,
  baseTextLine1Value,
  baseTextLine2Value,
  baseTextFontSize,
  baseTextFont,
  baseTextDepth,
  baseTextOffset];

module AssertCupBaseTextSettings(settings){
  assert(is_list(settings), "BaseText Settings must be a list")
  assert(len(settings)==8, "BaseText Settings must length 8");
} 

// add text to the bottom
module cup_base_text(
  cupBaseTextSettings,
  wall_thickness = 1.2,
  base_clearance = 4,
  magnet_position = 0){
  
  maxTextWidth = 30;
  maxTextSize= 10;
  if(env_help_enabled("trace")) echo("cup_base_text", magnet_position=magnet_position);
  AssertCupBaseTextSettings(cupBaseTextSettings);
  text_line1_enabled = cupBaseTextSettings[iCupBaseTextLine1Enabled];
  text_line2_enabled = cupBaseTextSettings[iCupBaseTextLine2Enabled];
  text_line1_value = cupBaseTextSettings[iCupBaseTextLine1Value];
  text_line2_value = cupBaseTextSettings[iCupBaseTextLine2Value];
  text_size = cupBaseTextSettings[iCupBaseTextFontSize]; 
  text_font = cupBaseTextSettings[iCupBaseTextFont];
  text_depth = cupBaseTextSettings[iCupBaseTextDepth];
  
  text_x_offset = cupBaseTextSettings[iCupBaseTextOffset][0];
  text_y_offset = cupBaseTextSettings[iCupBaseTextOffset][1];

  _text_x = wall_thickness + max(base_clearance, magnet_position * 1/3);
  _text_1_y = max(base_clearance, magnet_position * 1/3);
 
  _text_1_text = 
    is_string(text_line1_value) && text_line1_value!="" 
    ? text_line1_value 
    : str(
      str($num_x),
      " x ",
      str($num_y),
      " x ",
      str($num_z));
  
  _text_1_size = text_size > 0 ? text_size : 
    let(sample_text_1_width = textmetrics(text=_text_1_text, size=5, font=text_font).size.x) 
      5*maxTextWidth/sample_text_1_width;
      
  if (text_line1_enabled) {
    color(env_colour(color_wallcutout))
    translate([
      _text_x + text_x_offset,
      _text_1_y + text_y_offset,
      -1 * text_depth
    ])
    linear_extrude(height = text_depth * 2) {
      rotate(a = [0, 180, 180])
      text(
        text = _text_1_text,
        size = _text_1_size,
        font = text_font,
        halign = "left",
        valign = "top"
      );
    }
  }

  if (text_line2_enabled) {
    _text_2_size = text_size > 0 ? text_size : 
    let(sample_text_2_width = textmetrics(text=text_line2_value, size=5, font=text_font).size.x) 
      min(5*maxTextWidth/sample_text_2_width, maxTextSize);
        
    _text_2_y = _text_1_y + _text_1_size + min(_text_1_size * 0.25, 3);

    color(env_colour(color_wallcutout))
    translate([
      _text_x + text_x_offset,
      _text_2_y + text_y_offset,
      -1 * text_depth
    ])
    linear_extrude(height = text_depth * 2) {
      rotate(a = [0, 180, 180])
      text(
        text = text_line2_value,
        size = _text_2_size,
        font = text_font,
        halign = "left",
        valign = "top"
      );
    }
  }
}

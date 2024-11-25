include <gridfinity_constants.scad>
include <functions_general.scad>

iCupBaseTextLine1Enabled = 0;
iCupBaseTextLine2Enabled = 1;
iCupBaseTextLine2Value = 2;
iCupBaseTextFontSize = 3;
iCupBaseTextFont = 4;
iCupBaseTextDepth = 5;

function CupBaseTextSettings(
  baseTextLine1Enabled,
  baseTextLine2Enabled,
  baseTextLine2Value,
  baseTextFontSize,
  baseTextFont,
  baseTextDepth) = 
  [baseTextLine1Enabled, 
  baseTextLine2Enabled,
  baseTextLine2Value,
  baseTextFontSize,
  baseTextFont,
  baseTextDepth];

module AssertCupBaseTextSettings(settings){
  assert(is_list(settings), "BaseText Settings must be a list")
  assert(len(settings)==6, "BaseText Settings must length 6");
} 

// add text to the bottom
module cup_base_text(
  cupBaseTextSettings,
  wall_thickness = 1.2,
  magnet_position = 17){
  
  maxTextWidth = 30;
  maxTextSize= 10;
  
  AssertCupBaseTextSettings(cupBaseTextSettings);
  text_line1_enabled = cupBaseTextSettings[iCupBaseTextLine1Enabled];
  text_line2_enabled = cupBaseTextSettings[iCupBaseTextLine2Enabled];
  text_line2_value = cupBaseTextSettings[iCupBaseTextLine2Value];
  text_size = cupBaseTextSettings[iCupBaseTextFontSize]; 
  text_font = cupBaseTextSettings[iCupBaseTextFont];
  text_depth = cupBaseTextSettings[iCupBaseTextDepth];
  
  _text_x = wall_thickness + magnet_position * 1/3;
  _text_1_y = magnet_position;
 
  _text_1_text = str(
    str($num_x),
    " x ",
    str($num_y),
    " x ",
    str($num_z)
  );
  
  _text_1_size = text_size > 0 ? text_size : 
    let(sample_text_1_width = textmetrics(text=_text_1_text, size=5, font=text_font).size.x) 
      5*maxTextWidth/sample_text_1_width;
      
  if (text_line1_enabled) {
    color(getColour(color_wallcutout))
    translate([
      _text_x,
      _text_1_y,
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
        
    _text_2_y = _text_1_y + _text_1_size+3;// * 1.4;

    color(getColour(color_wallcutout))
    translate([
      _text_x,
      _text_2_y,
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
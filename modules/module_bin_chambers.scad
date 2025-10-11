
iChamber_count = 0;
iChamber_wall_thickness = 1;
iChamber_wall_headroom = 2;
iChamber_wall_top_radius = 3;
iChamber_separator_bend_position = 4;
iChamber_separator_bend_angle = 5;
iChamber_separator_bend_separation = 6;
iChamber_separator_cut_depth = 7;
iChamber_irregular_subdivisions = 8;
iChamber_separator_config = 9;

function ChamberSettings(
    chambers_count = 0,
    chamber_wall_thickness = 0,
    chamber_wall_headroom = 0,
    chamber_wall_top_radius = 0,
    separator_bend_position = 0,
    separator_bend_angle = 0,
    separator_bend_separation = 0,
    separator_cut_depth = 0,
    irregular_subdivisions = false,
    separator_config = "") = 
  let(
    result = [
      chambers_count,
      chamber_wall_thickness,
      chamber_wall_headroom,
      chamber_wall_top_radius,
      separator_bend_position,
      separator_bend_angle,
      separator_bend_separation,
      separator_cut_depth,
      irregular_subdivisions,
      separator_config],
    validatedResult = ValidateChamberSettings(result)
  ) validatedResult;

function ValidateChamberSettings(settings, wall_thickness = 0) =

  assert(is_list(settings), "Chamber Settings must be a list")
  assert(len(settings)==10, "Chamber Settings must length 10")
  assert(is_num(settings[iChamber_count]), "Chamber Count must be a number")
  assert(is_num(settings[iChamber_wall_thickness]) || (is_list(settings[iChamber_wall_thickness]) && len(settings[iChamber_wall_thickness]) ==2), "Wall Thickness must be a list")
  assert(is_num(settings[iChamber_wall_headroom]), "Wall Headroom must be a number")
  assert(is_num(settings[iChamber_wall_top_radius]), "Wall Top Radius must be a number")
  assert(is_num(settings[iChamber_separator_bend_position]), "Separator Bend Position must be a number")
  assert(is_num(settings[iChamber_separator_bend_angle]), "Separator Bend Angle must be a number")
  assert(is_num(settings[iChamber_separator_bend_separation]), "Separator Bend Separation must be a number")
  assert(is_num(settings[iChamber_separator_cut_depth]), "Separator Cut Depth must be a number")
  assert(is_bool(settings[iChamber_irregular_subdivisions]), "Separator Irregular Subdivisions must be a boolean")
  assert(is_string(settings[iChamber_separator_config]) || is_list(settings[iChamber_separator_config]), "Separator Config must be a string or a list")
  [
    settings[iChamber_count],
    is_num(settings[iChamber_wall_thickness])? [settings[iChamber_wall_thickness], settings[iChamber_wall_thickness]] : settings[iChamber_wall_thickness],
    settings[iChamber_wall_headroom],
    settings[iChamber_wall_top_radius],
    settings[iChamber_separator_bend_position],
    settings[iChamber_separator_bend_angle],
    settings[iChamber_separator_bend_separation],
    settings[iChamber_separator_cut_depth],
    settings[iChamber_irregular_subdivisions],
    settings[iChamber_separator_config]
  ];


iSeparatorPosition = 0;
iSeparatorLength = 1;
iSeparatorHeight = 2;
iSeparatorWallThickness = 3;
iSeparatorWallTopRadius = 4;
iSeparatorBendPosition = 5;
iSeparatorBendSeparation = 6;
iSeparatorBendAngle = 7;
iSeparatorWallCutDepth = 8;
iSeparatorWallCutoutWidth = 9;  

// calculate the position of separators from the size
function splitChamber(num_separators, container_width, divider_width) = num_separators < 1 
      ? [] 
      : let(
          chamber_count = num_separators + 1, // number of chambers
          chamber_width = (container_width - divider_width * num_separators)/chamber_count) // calculate the width of each chamber
      [ for (i=[1:num_separators]) i*chamber_width + (i-1)*divider_width+divider_width/2];

//Takes the user config and calculates the separators positions
function calculateSeparators(
                  separator_config, 
                  length,
                  height,
                  wall_thickness = 0,
                  wall_top_radius = 0,
                  bend_position = 0,
                  bend_angle = 0,
                  bend_separation = 0,
                  cut_depth = 0) = 
  is_string(separator_config) 
    //TODO: could reduce the duplication using a 
    //(is_string(separator_config) ||(is_list(separator_config) && len(separator_config) > 0))
    //  let(separator_config_list = is_string(separator_config) 
    //    ? [for (s = split(separator_config, "|")) csv_parse(s)]
    //    : separator_config)
    ? let(seps = [for (s = split(separator_config, "|")) csv_parse(s)]) // takes part of an array
      [for (i = [0:len(seps)-1]) 
        let(
          sepConfig = seps[i],
          _separator_position = is_list(sepConfig) && len(sepConfig) >= 1 ? sepConfig[0] : is_num(sepConfig) ? sepConfig : 0,
          _bend_separation = is_list(sepConfig) && len(sepConfig) >= 2 ? sepConfig[1] : bend_separation,
          _bend_angle = is_list(sepConfig) && len(sepConfig) >= 3 ? sepConfig[2] : bend_angle*(i%2==1?1:-1),
          _cut_depth = is_list(sepConfig) && len(sepConfig) >= 4 ? sepConfig[3] : cut_depth,
          _cut_width = is_list(sepConfig) && len(sepConfig) >= 5 ? sepConfig[4] : 0,
          _wall_thickness = is_list(sepConfig) && len(sepConfig) >= 6 ? sepConfig[5] : wall_thickness,
        )
        [
          _separator_position,        //0 iSeparatorPosition
          length,                     //1 iSeparatorLength
          height,                     //2 iSeparatorHeight
          _wall_thickness,            //3 iSeparatorWallThickness
          wall_top_radius,            //4 iSeparatorWallTopRadius
          bend_position,              //5 iSeparatorBendPosition
          _bend_separation,           //6 iSeparatorBendSeparation
          _bend_angle,                //7 iSeparatorBendAngle
          _cut_depth,                 //8 iSeparatorWallCutDepth
          _cut_width                  //9 iSeparatorWallCutoutWidth
        ]]
    : (is_list(separator_config) && len(separator_config) > 0) 
      ? [for (i = [0:len(separator_config)-1])
        let(
          sepConfig = separator_config[i],
          _separator_position = is_list(sepConfig) && len(sepConfig) >= 1 ? sepConfig[0] : is_num(sepConfig) ? sepConfig : 0,
          _bend_separation = is_list(sepConfig) && len(sepConfig) >= 2 ? sepConfig[1] : bend_separation,
          _bend_angle = is_list(sepConfig) && len(sepConfig) >= 3 ? sepConfig[2] : bend_angle*(i%2==1?1:-1),
          _cut_depth = is_list(sepConfig) && len(sepConfig) >= 4 ? sepConfig[3] : cut_depth,
          _cut_width = is_list(sepConfig) && len(sepConfig) >= 5 ? sepConfig[4] : 0,
          _wall_thickness_phase1 = is_list(sepConfig) && len(sepConfig) >= 6 ? sepConfig[5] : wall_thickness,
          _wall_thickness_phase2 = is_num(_wall_thickness_phase1) ? [_wall_thickness_phase1, _wall_thickness_phase1] : _wall_thickness_phase1,
          //allow wall thickness top to be relative to bottom
          _wall_thickness = [_wall_thickness_phase1.x, get_related_value(_wall_thickness_phase1.y, _wall_thickness_phase1.x, _wall_thickness_phase1.x)]
        ) [
          _separator_position,        //0 iSeparatorPosition
          length,                     //1 iSeparatorLength
          height,                     //2 iSeparatorHeight
          _wall_thickness,            //3 iSeparatorWallThickness
          wall_top_radius,            //4 iSeparatorWallTopRadius
          bend_position,              //5 iSeparatorBendPosition
          _bend_separation,           //6 iSeparatorBendSeparation
          _bend_angle,                //7 iSeparatorBendAngle
          _cut_depth,                 //8 iSeparatorWallCutDepth
          _cut_width                  //9 iSeparatorWallCutoutWidth
          ]]
      : [];

//Renders the physical separators
//calculatedSeparators - the calculated separator positions
//separator_orientation - the orientation of the separators (vertical or horizontal)
//override_wall_thickness - overrides the wallthickness 
module separators(
  calculatedSeparators,
  separator_orientation = "vertical",
  pad_wall_thickness = 0,
  pad_wall_height = 0,
  source = "")
{
 position_separators(
    calculatedSeparators = calculatedSeparators,
    separator_orientation = separator_orientation){
      bentWall(
        length=$sepCfg[iSeparatorLength],
        bendPosition=$sepCfg[iSeparatorBendPosition],
        bendAngle=$sepCfg[iSeparatorBendAngle],
        separation=$sepCfg[iSeparatorBendSeparation],
        lowerBendRadius=$sepCfg[iSeparatorBendSeparation]/2,
        upperBendRadius=$sepCfg[iSeparatorBendSeparation]/2,
        height = $sepCfg[iSeparatorHeight] + pad_wall_height,
        wall_cutout_depth = $sepCfg[iSeparatorWallCutDepth],
        wall_cutout_width = $sepCfg[iSeparatorWallCutoutWidth],
        thickness = let(wallThickness = $sepCfg[iSeparatorWallThickness])
          is_list(wallThickness) 
          ? [wallThickness[0] + pad_wall_thickness, wallThickness[1] + pad_wall_thickness]
          : wallThickness + pad_wall_thickness,
        top_radius = $sepCfg[iSeparatorWallTopRadius]);
      }
}

//positions the child in the correct location for the settings.
//This is a generic function that can be used for any separator, for example, the actual wall or the wall cutout
module position_separators(  
  calculatedSeparators,
  separator_orientation)
{
  assert(separator_orientation == "horizontal" || separator_orientation == "vertical", "separator_orientation must be 'horizontal' or 'vertical'");

  sepConfigs = calculatedSeparators;
  if(env_help_enabled("trace")) echo("separators",sepConfigs=sepConfigs);
 
  if(is_list(sepConfigs) && len(sepConfigs) > 0){
    for (i=[0:len(sepConfigs)-1]) {
      //set the current separator config for the child to access
      $sepCfg = sepConfigs[i];
      if(separator_orientation == "vertical"){
        translate([$sepCfg[iSeparatorPosition],0,0])
        children();
      }
      if(separator_orientation == "horizontal"){
        translate([0,$sepCfg[iSeparatorPosition],0])
        rotate([0,0,90])
        children();
      }
    }
  }
}
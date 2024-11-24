iSeparatorPosition = 0;
iSeparatorLength = 1;
iSeparatorHeight = 2;
iSeparatorWallThickness = 3;
iSeparatorBendPosition = 4;
iSeparatorBendSeparation = 5;
iSeparatorBendAngle = 6;
iSeparatorWallCutDepth = 7;
iSeparatorWallCutoutWidth = 8;  


//Takes the user config and calculates the separators positions
function calculateSeparators(
                  separator_config, 
                  length,
                  height,
                  wall_thickness = 0,
                  bend_position = 0,
                  bend_angle = 0,
                  bend_separation = 0,
                  cut_depth = 0) = 
  is_string(separator_config) 
    ? let(seps = [for (s = split(separator_config, "|")) csv_parse(s)]) // takes part of an array
      [for (i = [0:len(seps)-1]) [
          is_list(seps[i]) && len(seps[i]) >= 1 ? seps[i][0] : 0,               //0 iSeparatorPosition
          length,                                                   //1 iSeparatorLength
          height,                                                   //2 iSeparatorHeight
          is_list(seps[i]) && len(seps[i]) >= 6 ? seps[i][5] : wall_thickness,             //3 iSeparatorWallThickness
          bend_position,                                                      //4 iSeparatorBendPosition
          is_list(seps[i]) && len(seps[i]) >= 2 ? seps[i][1] : bend_separation,           //5 iSeparatorBendSeparation
          is_list(seps[i]) && len(seps[i]) >= 3 ? seps[i][2] : bend_angle*(i%2==1?1:-1),  //6 iSeparatorBendAngle
          is_list(seps[i]) && len(seps[i]) >= 4 ? seps[i][3] : cut_depth,                 //7 iSeparatorWallCutDepth
          is_list(seps[i]) && len(seps[i]) >= 5 ? seps[i][4] : 0                          //8 iSeparatorWallCutoutWidth
        ]]
    : (is_list(separator_config) && len(separator_config) > 0) 
      ? [for (i = [0:len(separator_config)-1])[
          separator_config[i],       //0 iSeparatorPosition
          length,                    //1 iSeparatorLength      
          height,                    //2 iSeparatorHeight
          wall_thickness,            //3 iSeparatorWallThickness
          bend_position,             //4 iSeparatorBendPosition
          bend_separation,           //5 iSeparatorBendSeparation
          bend_angle*(i%2==1?1:-1),  //6 iSeparatorBendAngle
          cut_depth,                 //7 iSeparatorWallCutDepth
          0                          //8 iSeparatorWallCutoutWidth
          ]]
      : [];

//Renders the physical separators
//calculatedSeparators - the calculated separator positions
//separator_orientation - the orientation of the separators (vertical or horizontal)
//override_wall_thickness - overrides the wallthickness 
module separators(
  calculatedSeparators,
  separator_orientation = "vertical",
  override_wall_thickness)
{

  position_separators(
    calculatedSeparators = calculatedSeparators,
    separator_orientation = separator_orientation){
      thickness = is_num(override_wall_thickness) ? override_wall_thickness : $sepCfg[iSeparatorWallThickness];
      translate([-thickness/2,0])
      bentWall(
        length=$sepCfg[iSeparatorLength],
        bendPosition=$sepCfg[iSeparatorBendPosition],
        bendAngle=$sepCfg[iSeparatorBendAngle],
        separation=$sepCfg[iSeparatorBendSeparation],
        lowerBendRadius=$sepCfg[iSeparatorBendSeparation]/2,
        upperBendRadius=$sepCfg[iSeparatorBendSeparation]/2,
        height = $sepCfg[iSeparatorHeight],
        wall_cutout_depth = $sepCfg[iSeparatorWallCutDepth],
        wall_cutout_width = $sepCfg[iSeparatorWallCutoutWidth],
        thickness = thickness);
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
  if(IsHelpEnabled("trace")) echo("separators",sepConfigs=sepConfigs);
 
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
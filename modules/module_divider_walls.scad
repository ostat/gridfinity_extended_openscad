iSeperatorPosition = 0;
iSeperatorLength = 1;
iSeperatorHeight = 2;
iSeperatorWallThickness = 3;
iSeperatorBendPosition = 4;
iSeperatorBendSeparation = 5;
iSeperatorBendAngle = 6;
iSeperatorWallCutDepth = 7;
iSeperatorWallCutoutWidth = 8;  

function calculateSeparators(seperator_config) = 
  is_string(seperator_config) ? [] : 
  is_list(seperator_config) ? seperator_config : [];

function calculateSeparatorsv2(
                  seperator_config, 
                  length,
                  height,
                  wall_thickness = 0,
                  bend_position = 0,
                  bend_angle = 0,
                  bend_separation = 0,
                  cut_depth = 0) = 
  is_string(seperator_config) 
    ? let(seps = [for (s = split(seperator_config, "|")) csv_parse(s)]) // takes part of an array
      [for (i = [0:len(seps)-1]) [
          is_list(seps[i]) && len(seps[i]) >= 1 ? seps[i][0] : 0,               //0 iSeperatorPosition
          length,                                                   //1 iSeperatorLength
          height,                                                   //2 iSeperatorHeight
          is_list(seps[i]) && len(seps[i]) >= 6 ? seps[i][5] : wall_thickness,             //3 iSeperatorWallThickness
          bend_position,                                                      //4 iSeperatorBendPosition
          is_list(seps[i]) && len(seps[i]) >= 2 ? seps[i][1] : bend_separation,           //5 iSeperatorBendSeparation
          is_list(seps[i]) && len(seps[i]) >= 3 ? seps[i][2] : bend_angle*(i%2==1?1:-1),  //6 iSeperatorBendAngle
          is_list(seps[i]) && len(seps[i]) >= 4 ? seps[i][3] : cut_depth,                 //7 iSeperatorWallCutDepth
          is_list(seps[i]) && len(seps[i]) >= 5 ? seps[i][4] : 0                          //8 iSeperatorWallCutoutWidth
        ]]
    : (is_list(seperator_config) && len(seperator_config) > 0) 
      ? [for (i = [0:len(seperator_config)-1])[
          seperator_config[i],       //0 iSeperatorPosition
          length,                    //1 iSeperatorLength      
          height,                    //2 iSeperatorHeight
          wall_thickness,            //3 iSeperatorWallThickness
          bend_position,             //4 iSeperatorBendPosition
          bend_separation,           //5 iSeperatorBendSeparation
          bend_angle*(i%2==1?1:-1),  //6 iSeperatorBendAngle
          cut_depth,                 //7 iSeperatorWallCutDepth
          0                          //8 iSeperatorWallCutoutWidth
          ]]
      : [];

module separators_generic(  
  length,
  height,
  wall_thickness = 0,
  bend_position = 0,
  bend_angle = 0,
  bend_separation = 0,
  cut_depth = 0,
  seperator_config = [],
  separator_orentation)
{
assert(separator_orentation == "horizontal" || separator_orentation == "vertical", "separator_orentation must be 'horizontal' or 'vertical'");

sepConfigs = calculateSeparatorsv2(
    seperator_config = seperator_config, 
    length = length,
    height = height,
    wall_thickness = wall_thickness,
    bend_position = bend_position,
    bend_angle = bend_angle,
    bend_separation = bend_separation,
    cut_depth = cut_depth);
  if(IsHelpEnabled("trace")) echo("separators",sepConfigs=sepConfigs);
 
  if(is_list(sepConfigs) && len(sepConfigs) > 0){
    for (i=[0:len(sepConfigs)-1]) {
      $sepCfg = sepConfigs[i];
      if(separator_orentation == "vertical"){
        translate([$sepCfg[iSeperatorPosition]-$sepCfg[iSeperatorWallThickness]/2,0,0])
        children();
      }
      if(separator_orentation == "horizontal"){
        translate([0,$sepCfg[iSeperatorPosition]-$sepCfg[iSeperatorWallThickness]/2,0])
        rotate([0,0,90])
        children();
      }
    }
  }
}

module separators(
  length,
  height,
  wall_thickness = 0,
  bend_position = 0,
  bend_angle = 0,
  bend_separation = 0,
  cut_depth = 0,
  seperator_config = [],
  separator_orentation = "vertical")
{
  separators_generic(
    seperator_config = seperator_config, 
    length = length,
    height = height,
    wall_thickness = wall_thickness,
    bend_position = bend_position,
    bend_angle = bend_angle,
    bend_separation = bend_separation,
    cut_depth = cut_depth,
    separator_orentation = separator_orentation)
    bentWall(
      length=$sepCfg[iSeperatorLength],
      bendPosition=$sepCfg[iSeperatorBendPosition],
      bendAngle=$sepCfg[iSeperatorBendAngle],
      separation=$sepCfg[iSeperatorBendSeparation],
      lowerBendRadius=$sepCfg[iSeperatorBendSeparation]/2,
      upperBendRadius=$sepCfg[iSeperatorBendSeparation]/2,
      height = $sepCfg[iSeperatorHeight],
      wall_cutout_depth = $sepCfg[iSeperatorWallCutDepth],
      wall_cutout_width = $sepCfg[iSeperatorWallCutoutWidth],
      thickness = $sepCfg[iSeperatorWallThickness]);
}

module separatorsv1(  
  length,
  height,
  wall_thickness = 0,
  bend_position = 0,
  bend_angle = 0,
  bend_separation = 0,
  cut_depth = 0,
  seperator_config = [])
{
  if(is_string(seperator_config))
  {
    //Non custom components
    separators = split(seperator_config, "|");
    for (i =[0:1:len(separators)-1])
    {
      sep = csv_parse(separators[i]);
      if(is_list(sep) && len(sep)>0)
      {
        translate([sep[0]-wall_thickness/2,0,0])
        bentWall(
          length=length,
          bendPosition=bend_position,
          separation=len(sep) >= 2 ? sep[1] : bend_separation,
          bendAngle=len(sep) >= 3 ? sep[2] : bend_angle*(i%2==1?1:-1),
          height=height,
          wall_cutout_depth = len(sep) >= 4 ? sep[3] : cut_depth,
          wall_cutout_width = len(sep) >= 5 ? sep[4] : 0,
          thickness=len(sep) >= 6 ? sep[5] : wall_thickness);
        }
     }
  }
  else if(is_list(seperator_config) && len(seperator_config) > 0){
    for (i=[0:len(seperator_config)-1]) {
     translate([seperator_config[i]-wall_thickness/2,0,0])
     bentWall(
       length=length,
       bendPosition=bend_position,
       bendAngle=bend_angle*(i%2==1?1:-1),
       separation=bend_separation,
       lowerBendRadius=bend_separation/2,
       upperBendRadius=bend_separation/2,
       height=height,
       wall_cutout_depth = cut_depth,
       thickness=wall_thickness);
    }
  }
}
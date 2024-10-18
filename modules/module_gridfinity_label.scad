ilabelWall_Width=0;
ilabelWall_Position=1;
ilabelWall_Rotation=2;
ilabelWall_SeparatorConfig=3;
ilabelWall_Reversed=4;

iLabelSettings_style = 0;
iLabelSettings_position = 1;
iLabelSettings_size = 2;
iLabelSettings_relief = 3;
iLabelSettings_walls = 4;

LabelStyle_disabled = "disabled";
LabelStyle_normal = "normal";
LabelStyle_cullenect = "cullenect";
LabelStyle_gflabel = "gflabel";
LabelStyle_pred = "pred";
LabelStyle_values = [LabelStyle_disabled,LabelStyle_normal,LabelStyle_cullenect,LabelStyle_gflabel];
function validateLabelStyle(value) = 
  assert(list_contains(LabelStyle_values, value), typeerror("LabelStyle", value))
  value;
  
LabelPosition_left = "left";
LabelPosition_center = "center";
LabelPosition_right = "right";
LabelPosition_leftchamber = "leftchamber";
LabelPosition_rightchamber = "rightchamber";
LabelPosition_centerchamber = "centerchamber";
LabelPosition_values = [LabelPosition_left,LabelPosition_center,LabelPosition_right,LabelPosition_leftchamber,LabelPosition_rightchamber,LabelPosition_centerchamber];
function validateLabelPosition(value) = 
  assert(list_contains(LabelPosition_values, value), typeerror("LabelPosition", value))
  value;
  
function calculateLabelSize(label_size) = 
    assert(is_list(label_size), "label_size must be a list")
    let(
      labelxtemp = is_num(label_size) ? label_size : is_list(label_size) && len(label_size) >= 1 ? label_size.x : 0,
      labelx = labelxtemp <=0 ? 0 : labelxtemp,
      labelytemp = is_list(label_size) && len(label_size) >= 2 ? label_size.y : 0,
      labely = labelytemp <= 0 ? 14 : labelytemp,
      labelztemp = is_list(label_size) && len(label_size) >= 3 ? label_size.z : 0,
      labelz = labelztemp == -1 ? labely*3/4 : labelztemp == 0 ? labely : labelztemp,
      labelrtemp = is_list(label_size) && len(label_size) >= 4 ? label_size[3] : 0,
      labelr = labelrtemp <= 0 ? 0.6 : labelrtemp)
        [labelx,labely,labelz,labelr];

function LabelSettings(
    labelStyle, 
    labelPosition, 
    labelSize,
    labelRelief,
    labelWalls) = 
  let(
    labelRelief = is_num(labelRelief) ? [0,0,labelRelief,0] : labelRelief,
    labelWalls = is_undef(labelWalls) ? [0,1,0,0] : labelWalls,
    result = [
      labelStyle,
      labelPosition,
      labelSize,
      labelRelief,
      labelWalls],
    validatedResult = ValidateLabelSettings(result)
  ) validatedResult;

function ValidateLabelSettings(settings) =
  assert(is_list(settings) && len(settings)== 5, "Label Settings must be a list of length 5")
  assert(is_list(settings[iLabelSettings_size]) && len(settings[iLabelSettings_size])==4, "Label Settings Size must length 4")
  assert(is_list(settings[iLabelSettings_relief]) && len(settings[iLabelSettings_relief])==4, "Label Settings relief must length 4")
  assert(is_list(settings[iLabelSettings_walls]) && len(settings[iLabelSettings_walls])==4, "Label Settings walls must length 4") [
      validateLabelStyle(settings[iLabelSettings_style]),
      validateLabelPosition(settings[iLabelSettings_position]),
      settings[iLabelSettings_size],
      settings[iLabelSettings_relief],
      settings[iLabelSettings_walls]];

module gridfinity_label(
  num_x,
  num_y,
  zpoint,
  vertical_separator_positions,
  horizontal_separator_positions,
  label_settings
)
{
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(zpoint), "zpoint must be a number");
  assert(is_string(label_position), "label_position must be a string");
  assert(is_string(vertical_separator_positions) || is_list(vertical_separator_positions), "vertical_separator_positions must be a list");
  assert(is_string(horizontal_separator_positions) || is_list(horizontal_separator_positions), "horizontal_separator_positions must be a list");
  
  label_settings=ValidateLabelSettings(label_settings);
  label_style=label_settings[iLabelSettings_style];
  label_position=label_settings[iLabelSettings_position];
  label_size=calculateLabelSize(label_settings[iLabelSettings_size]);
  label_relief=label_settings[iLabelSettings_relief];
  label_walls =label_settings[iLabelSettings_walls];
  labelSize=label_size;
  //label_style = label_style ? "pred" : "pred";
  labelCornerRadius = labelSize[3];
  
  frontWall = [
    //width
    num_x*gf_pitch,
    //Position
    [num_x*gf_pitch, 0, 0],
    //rotation
    [0,0,180],
    vertical_separator_positions,
    //is reversed
    true,
    "front"];
  backWall = [
    //width
    num_x*gf_pitch,
    //Position
    [0, num_y*gf_pitch, 0],
    //rotation
    [0,0,0],
    vertical_separator_positions,
    //is reversed
    false,
    "back"];
  leftWall = [
    //width
    num_y*gf_pitch,
    //Position
    [0, 0, 0],
    //rotation
    [0,0,90],
    horizontal_separator_positions,
    //is reversed
    false,
    "left"];
  rightWall = [
    //width
    num_y*gf_pitch,
    //Position
    [num_x*gf_pitch, num_y*gf_pitch, 0],
    //rotation
    [0,0,270],
    horizontal_separator_positions,
    //is reversed
    true,
    "right"];
    
  wallLocations = [frontWall, backWall, leftWall, rightWall];
 
  color(color_label)
  tz(zpoint+fudgeFactor)
  //Loop the sides 
  for(l = [0:1:len(wallLocations)-1]){
    location = wallLocations[l];
    separator_positions = location[ilabelWall_SeparatorConfig];//calculateSeparators(location[3]);
   
    labelPoints = [[ 0-labelSize.y, -labelCornerRadius],
      [ 0, -labelCornerRadius ],
      [ 0, -labelCornerRadius-labelSize.z ]
    ];
    labelWidthmm = labelSize.x <=0 ? location[ilabelWall_Width] : labelSize.x * gf_pitch;
    
    // calcualte list of chambers. 
    chamberWidths = len(separator_positions) < 1 || 
      labelWidthmm == 0 ||
      label_position == LabelPosition_left ||
      label_position == LabelPosition_center ||
      label_position == LabelPosition_right ?
        [ location[ilabelWall_Width] ] // single chamber equal to the bin length
        : [ for (i=[0:len(separator_positions)]) 
          (i==len(separator_positions) 
            ? location[ilabelWall_Width]
            : separator_positions[i][iSeperatorPosition]) - (i==0 ? 0 : separator_positions[i-1][iSeperatorPosition]) ];
    
    if(IsHelpEnabled("trace")) echo("gridfinity_label", l=l, location = location, chamberWidths=chamberWidths, separator_positions = separator_positions);
    union()
    if(label_walls[l] != 0)
      //patterns in the outer walls
      translate(location[ilabelWall_Position])
      rotate(location[ilabelWall_Rotation])     
      for (i=[0:len(chamberWidths)-1]) {
          chamberStart = i == 0 
            ? 0 
            : separator_positions[i-1][iSeperatorPosition] + 
              separator_positions[i-1][iSeperatorBendSeparation]/2
                *(separator_positions[i-1][iSeperatorBendAngle] < 0 ? -1 : 1)
                *(location[ilReversed] ? -1 : 1);
          chamberWidth = chamberWidths[i];
          label_num_x = (labelWidthmm == 0 || labelWidthmm > chamberWidth) ? chamberWidth : labelWidthmm;
          label_pos_x = ((label_position == "center" || label_position == "centerchamber" )? (chamberWidth - label_num_x) / 2 
                          : (label_position == "right" || label_position == "rightchamber" )? chamberWidth - label_num_x 
                          : 0);
        
        if(IsHelpEnabled("trace")) echo("gridfinity_label", i=i, chamberStart=chamberStart, label_num_x=label_num_x, label_pos_x=label_pos_x,  separator_position=separator_positions[i-1]);
                    
          translate([(chamberStart + label_pos_x)+labelCornerRadius,-labelCornerRadius,0])
          difference(){
            union(){
              hull() for (y=[0, 1, 2])
              translate([0, labelPoints[y][0], labelPoints[y][1]])
                rotate([0, 90, 0])
                union(){
                  //left
                  tz(abs(label_num_x-labelCornerRadius*2))//tz(abs(label_num_x))
                  sphere(r=labelCornerRadius, $fn=64);
                  //Right
                  sphere(r=labelCornerRadius, $fn=64);
                }
                
                if(label_style == LabelStyle_pred){
                  translate([0,labelPoints[0][0]+max(labelCornerRadius,label_relief+0.5),0-label_relief-fudgeFactor])
                  cube([abs(label_num_x)*2,abs(labelPoints[0][0]-labelPoints[1][0])/2,label_relief+fudgeFactor]);
                }
              }

            if(label_style == LabelStyle_cullenect){
              clickSize= [36.7,11.3, 1.2];
              clickLeftPosition = 
                label_position == LabelPosition_left ? 2.65 
                : label_position == LabelPosition_right ? 2.65
                : label_position == LabelPosition_center ? (label_num_x-clickSize.x)/2
                : 2.65;
               translate([clickLeftPosition-labelCornerRadius,labelPoints[0][0]+0.25,0])
               LabelClick(clickSize= clickSize);
             } else if(label_style == LabelStyle_pred){
                translate([0,labelPoints[0][0]+max(labelCornerRadius,label_relief+0.5),0-label_relief-fudgeFactor])
                cube([abs(label_num_x)-labelCornerRadius*2,abs(labelPoints[0][0]-labelPoints[1][0]),label_relief+fudgeFactor]);
            } else if(label_style == LabelStyle_gflabel){
                   gflabelSize=[label_relief.x,label_relief.y,label_relief.z];
                   gflabelLeftPosition = 
                label_position == LabelPosition_left ? 2.65 
                : label_position == LabelPosition_right ? 2.65
                : label_position == LabelPosition_center ? (label_num_x-gflabelSize.x)/2
                : 2.65;
               translate([gflabelLeftPosition-labelCornerRadius,labelPoints[0][0]+0.25,0])
              #Labelgflabel(
                size=gflabelSize,
                radius=label_relief[3]);
            } else if(label_style == LabelStyle_normal) {
                if (label_relief.z > 0){
                translate([0,labelPoints[0][0]+max(labelCornerRadius,label_relief.z+0.5),0-label_relief.z-fudgeFactor])
                  cube([abs(label_num_x)-labelCornerRadius*2,abs(labelPoints[0][0]-labelPoints[1][0]),label_relief.z+fudgeFactor]);
            }
        }
      }
    }
  }
}
module Labelgflabel(
    size= [36.7,11.3, 1.2],
    radius = 0.25
    ){
  echo("Labelgflabel", size=size, radius=radius);
  translate([0,0,-size.z])
  roundedCube(size=size,sideRadius=radius);
}

module LabelClick(
    clickSize= [36.7,11.3, 1.2],
    clickRadius = 0.25
    ){
  translate([0,0,-clickSize.z])
  difference(){
    roundedCube(size=clickSize,sideRadius=clickRadius);
    for(i = [0:2]){
      translate([(i+0.5)*clickSize.x/3,clickSize.y+fudgeFactor,0.23])
      rotate([90,210,0])
      cylinder(h=clickSize.y+fudgeFactor*2,r=.75, $fn=3);
    }}
}
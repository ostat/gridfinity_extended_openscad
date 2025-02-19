include <module_utility.scad>
include <functions_general.scad>

labeldemo = false;
if(labeldemo == true){
  //demo of the label voids

  // https://github.com/ndevenish/gflabel
  label_gflabel_socket();

  // https://github.com/CullenJWebb/Cullenect-Labels
  translate([0,15,0])
  label_cullenect_socket($fn = 64);
  
  // https://makerworld.com/en/models/446624#profileId-849444
  translate([0,30,0])
  label_cullenect_legacy_socket($fn = 64);

  //https://www.printables.com/model/592545-gridfinity-bin-with-printable-label-by-pred-parametric
  translate([0,45,0])
  label_pred_socket($fn = 64);
}

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
LabelStyle_cullenectlegacy = "cullenect_legacy";
LabelStyle_gflabel = "gflabel";
LabelStyle_pred = "pred";
LabelStyle_values = [LabelStyle_disabled,LabelStyle_normal,LabelStyle_cullenect,LabelStyle_cullenectlegacy,LabelStyle_gflabel,LabelStyle_pred];
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
      labelx = labelxtemp <= 0 ? 0 : labelxtemp,
      labelytemp = is_list(label_size) && len(label_size) >= 2 ? label_size.y : 0,
      labely = labelytemp <= 0 ? 14 : labelytemp,
      labelztemp = is_list(label_size) && len(label_size) >= 3 ? label_size.z : 0,
      labelz = labelztemp == -1 ? labely*3/4 : labelztemp == 0 ? labely : labelztemp,
      labelrtemp = is_list(label_size) && len(label_size) >= 4 ? label_size[3] : 0,
      labelr = labelrtemp <= 0 ? 0.6 : labelrtemp)
        [labelx,labely,labelz,labelr];

function LabelSettings(
    labelStyle= "normal", 
    labelPosition="left", 
    // Width, Depth, Height, Radius.   
    labelSize=[0,14,0,0.6],
    // Size in mm of relief where appropiate. Width, depth, height, radius
    labelRelief=[0,0,0,0.6],
    // wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
    labelWalls=[0,1,0,0]) = 
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

 function CalculateLabelSocketPosition(label_position, labelSocketSize, label_num_x, socketPadding =  2.65) =  
                label_position == LabelPosition_left || label_position == LabelPosition_leftchamber  ? socketPadding 
                : label_position == LabelPosition_right || label_position == LabelPosition_rightchamber ? label_num_x-labelSocketSize.x-socketPadding
                : label_position == LabelPosition_center || label_position == LabelPosition_centerchamber ? (label_num_x-labelSocketSize.x)/2
                : socketPadding;
                
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
  label_settings,
  render_option = "labelwithsocket", //"label", "socket", "labelwithsocket"
  socket_padding = [0,0,0]
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
    num_x*env_pitch().x,
    //Position
    [num_x*env_pitch().x, 0, 0],
    //rotation
    [0,0,180],
    vertical_separator_positions,
    //is reversed
    true,
    "front",
    env_pitch().x];
  backWall = [
    //width
    num_x*env_pitch().x,
    //Position
    [0, num_y*env_pitch().y, 0],
    //rotation
    [0,0,0],
    vertical_separator_positions,
    //is reversed
    false,
    "back",
    env_pitch().x];
  leftWall = [
    //width
    num_y*env_pitch().y,
    //Position
    [0, 0, 0],
    //rotation
    [0,0,90],
    horizontal_separator_positions,
    //is reversed
    false,
    "left",
    env_pitch().y];
  rightWall = [
    //width
    num_y*env_pitch().y,
    //Position
    [num_x*env_pitch().x, num_y*env_pitch().y, 0],
    //rotation
    [0,0,270],
    horizontal_separator_positions,
    //is reversed
    true,
    "right",
    env_pitch().y];
    
  wallLocations = [frontWall, backWall, leftWall, rightWall];
 
  color(env_colour(color_label))
  tz(zpoint+fudgeFactor)
  //Loop the sides 
  for(l = [0:1:len(wallLocations)-1]){
    wallLocation = wallLocations[l];
    separator_positions = wallLocation[ilabelWall_SeparatorConfig];//calculateSeparators(wallLocation[3]);
   
    labelPoints = [[ 0-labelSize.y, -labelCornerRadius],
      [ 0, -labelCornerRadius ],
      [ 0, -labelCornerRadius-labelSize.z ]
    ];
    labelWidthmm = labelSize.x <=0 ? wallLocation[ilabelWall_Width] : labelSize.x * wallLocation[6];
    
    // Calculate list of chambers. 
    chamberWidths = len(separator_positions) < 1 || 
      labelWidthmm == 0 ||
      label_position == LabelPosition_left ||
      label_position == LabelPosition_center ||
      label_position == LabelPosition_right ?
        [ wallLocation[ilabelWall_Width] ] // single chamber equal to the bin length
        : [ for (i=[0:len(separator_positions)]) 
          (i==len(separator_positions) 
            ? wallLocation[ilabelWall_Width]
            : separator_positions[i][iSeparatorPosition]) - (i==0 ? 0 : separator_positions[i-1][iSeparatorPosition]) ];
    
    if(env_help_enabled("trace")) echo("gridfinity_label", l=l, wallLocation = wallLocation, chamberWidths=chamberWidths, separator_positions = separator_positions);
    union()
    if(label_walls[l] != 0)
      translate(wallLocation[ilabelWall_Position])
      rotate(wallLocation[ilabelWall_Rotation])     
      for (i=[0:len(chamberWidths)-1]) {
          chamberStart = i == 0 
            ? 0 
            : separator_positions[i-1][iSeparatorPosition] + 
              separator_positions[i-1][iSeparatorBendSeparation]/2
                *(separator_positions[i-1][iSeparatorBendAngle] < 0 ? -1 : 1)
                *(wallLocation[ilabelWall_Reversed] ? -1 : 1);
          chamberWidth = chamberWidths[i];
          label_num_x = (labelWidthmm == 0 || labelWidthmm > chamberWidth) ? chamberWidth : labelWidthmm;
          label_pos_x = ((label_position == "center" || label_position == "centerchamber" )? (chamberWidth - label_num_x) / 2 
                          : (label_position == "right" || label_position == "rightchamber" )? chamberWidth - label_num_x 
                          : 0);
        
        if(env_help_enabled("trace")) echo("gridfinity_label", i=i, chamberStart=chamberStart, label_num_x=label_num_x, label_pos_x=label_pos_x,  separator_position=separator_positions[i-1]);
          translate([(chamberStart + label_pos_x)+labelCornerRadius,-labelCornerRadius,0])
          union(){
            difference(){
              if(render_option == "label" || render_option == "labelwithsocket")
              union(){
                hull() for (y=[0, 1, 2])
                translate([0, labelPoints[y][0], labelPoints[y][1]])
                  rotate([0, 90, 0])
                  union(){
                    //left
                    tz(abs(label_num_x-labelCornerRadius*2))//tz(abs(label_num_x))
                    sphere(r=labelCornerRadius);
                    //Right
                    sphere(r=labelCornerRadius);
                  }
                }
                
              //Create Label Sockets as negative volume
              if(render_option == "labelwithsocket")
                labelSockets(
                  label_style=label_style,
                  label_relief=label_relief,
                  labelPoints=labelPoints,
                  label_position=label_position,
                  labelCornerRadius=labelCornerRadius,
                  label_num_x=label_num_x,
                  socket_padding = socket_padding);
            }

            //Create Label Sockets as positive volume
            if(render_option == "socket")
              labelSockets(
                label_style=label_style,
                label_relief=label_relief,
                labelPoints=labelPoints,
                label_position=label_position,
                labelCornerRadius=labelCornerRadius,
                label_num_x=label_num_x,
                socket_padding = socket_padding);
          }
    }
  }
}

module labelSockets(
  label_style,
  label_relief,
  labelPoints,
  label_position,
  labelCornerRadius,
  label_num_x,
  socket_padding) {

  fudgeFactor = 0.01;
  binClearance = 0.5;
  fullLipWidth = 2.65;

  if(label_style == LabelStyle_cullenectlegacy){
      extraHeightToCleanLip = 3.75;
      labelSize=[
        label_relief.x == 0 ? 36.7 : label_relief.x,
        label_relief.y == 0 ? 11.3 : label_relief.y,
        (label_relief.z == 0 ? 1.5 : label_relief.z)+extraHeightToCleanLip];
      labelLeftPosition = CalculateLabelSocketPosition(
        label_position=label_position, 
        labelSocketSize=labelSize, 
        label_num_x=label_num_x);
        
      translate([labelLeftPosition-max(0,(labelSize.x-36))/2-binClearance,labelPoints[0][0]+.75,extraHeightToCleanLip])
      label_cullenect_legacy_socket(clickSize=labelSize);
    }
    else if(label_style == LabelStyle_cullenect){
      extraHeightToCleanLip = 0.5;
      cullenect_relief_x = label_num_x - 5.7;
      labelSize=[
        label_relief.x == 0 ? cullenect_relief_x : label_relief.x,
        label_relief.y == 0 ? 11.3 : label_relief.y,
        (label_relief.z == 0 ? 1.5 : label_relief.z)+extraHeightToCleanLip];
      labelLeftPosition = CalculateLabelSocketPosition(
        label_position=label_position, 
        labelSocketSize=labelSize, 
        label_num_x=label_num_x);

      translate([labelLeftPosition-0.4,labelPoints[0][0]+0.4,extraHeightToCleanLip])
      label_cullenect_socket(labelSize=labelSize);
    } 
    else if(label_style == LabelStyle_pred){
      predSize=[
        abs(label_num_x)-fullLipWidth*2-binClearance,
        abs(labelPoints[0][0]-labelPoints[1][0])-fullLipWidth,
        (label_relief.z == 0 ? 1 : label_relief.z) + fudgeFactor];
      translate([-labelCornerRadius+binClearance/2+fullLipWidth,-.3+labelPoints[0][0]+max(labelCornerRadius,label_relief.y+0.5),0-label_relief.z-fudgeFactor])
      label_pred_socket(size=predSize);
    } 
    else if(label_style == LabelStyle_gflabel){
            gflabelSize=[
                label_relief.x == 0 ? label_num_x-fullLipWidth*2-binClearance : label_relief.x,
                label_relief.y == 0 ? 11 : label_relief.y,
                label_relief.z == 0 ? 1.2 : label_relief.z];
            gflabelLeftPosition = 
              label_position == LabelPosition_left ? fullLipWidth 
              : label_position == LabelPosition_right ? fullLipWidth
              : label_position == LabelPosition_center ? (label_num_x-gflabelSize.x)/2
              : fullLipWidth;
        translate([gflabelLeftPosition-labelCornerRadius/2,labelPoints[0][0]+0.25,0])
      label_gflabel_socket(
        size=gflabelSize,
        radius=label_relief[3]);
    } else if(label_style == LabelStyle_normal) {
        fullLipWidth = 2.6;
        if (label_relief.z > 0){
        translate([0,labelPoints[0][0]+max(labelCornerRadius,label_relief.z+0.5),0-label_relief.z-fudgeFactor])
          cube([abs(label_num_x)-labelCornerRadius*2-fullLipWidth*2,abs(labelPoints[0][0]-labelPoints[1][0]),label_relief.z+fudgeFactor]);
    }
  }
}

//https://www.printables.com/model/592545-gridfinity-bin-with-printable-label-by-pred-parame
module label_pred_socket(
    size = [36, 12, 1], //should be full width of the label
    tab_size = [1, 6.7, 1],
    radius = 1
    ){
 
  translate([0,0,-size.z])
  union(){
    roundedCube(size=size,sideRadius=radius);
    translate([-tab_size.x,(size.y-tab_size.y)/2,0])
    cube(size=[size.x+tab_size.x*2, tab_size.y, size.z]);
  }
}

//https://github.com/ndevenish/gflabel
module label_gflabel_socket(
    size = [36.4, 11, 1.2],
    radius = 0.25
    ){

  translate([0,0,-size.z])
  roundedCube(size=size,sideRadius=radius);
}

//https://makerworld.com/en/models/446624#profileId-849444
module label_cullenect_legacy_socket(
    clickSize= [36.7,11.3, 1.2],
    socket_padding = [0.3,0.3,0.3],
    clickRadius = 0.25
    ){
  fudgeFactor = 0.01;

  paddedSocketSize = clickSize + socket_padding;   

  translate([0,0,-paddedSocketSize.z])
  difference(){
    roundedCube(size=paddedSocketSize, sideRadius=clickRadius);
    for(i = [0:2]){
      translate([(i+0.5)*clickSize.x/3,clickSize.y+fudgeFactor,0.23])
      rotate([90,210,0])
      cylinder(h=clickSize.y+fudgeFactor*2,r=.75, $fn=3);
    }}
}

// Generate negative volume of socket
// https://github.com/CullenJWebb/Cullenect-Labels
module label_cullenect_socket(
  labelSize=[36.3,11.3,1.5],
  labelRadius = 0.5,
  rib_height = 0.4, //height of the ribz
  rib_width = 0.2, //width of the ribxy
  rib_zoffset = 0.2 //z offset of the
){
  fudgeFactor = 0.01;
  
  echo("label_cullenect_socket", labelSize=labelSize);
  translate([0,0,-labelSize.z])
  difference(){
    roundedCube(size=[labelSize.x, labelSize.y, labelSize.z], sideRadius=labelRadius);
	  translate([0, -fudgeFactor, rib_zoffset])
      cube([labelSize.x, rib_width+fudgeFactor, rib_height]);
		translate([0, labelSize.y - rib_width, rib_zoffset])
      cube([labelSize.x, rib_width+fudgeFactor, rib_height]);
	}
}
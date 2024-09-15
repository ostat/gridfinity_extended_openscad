ilWidth=0;
ilPosition=1;
ilRotation=2;
ilSeparatorConfig=3;
ilReversed=4;

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

module gridfinity_label(
  num_x,
  num_y,
  zpoint,
  label_position,
  vertical_separator_positions,
  horizontal_separator_positions,
  label_size,
  label_style,
  label_relief,
  label_walls = [1,1,1,1]
)
{
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(zpoint), "zpoint must be a number");
  assert(is_string(label_position), "label_position must be a string");
  assert(is_string(vertical_separator_positions) || is_list(vertical_separator_positions), "vertical_separator_positions must be a list");
  assert(is_string(horizontal_separator_positions) || is_list(horizontal_separator_positions), "horizontal_separator_positions must be a list");
  assert(is_list(label_size), "label_size must be a list");
  assert(is_string(label_style), "label_style must be a string");
  assert(is_num(label_relief), "label_relief must be a number");
  assert(is_list(label_walls), "label_walls must be a list");
  
  labelSize = calculateLabelSize(label_size);
  
  labelCornerRadius = labelSize[3];
  
  front = [
    //width
    num_x*gf_pitch,
    //Position
    [num_x*gf_pitch, 0, 0],
    //rotation
    [0,0,180],
    vertical_separator_positions,
    //is reversed
    true];
  back = [
    //width
    num_x*gf_pitch,
    //Position
    [0, num_y*gf_pitch, 0],
    //rotation
    [0,0,0],
    vertical_separator_positions,
    //is reversed
    false];

  left = [
    //width
    num_y*gf_pitch,
    //Position
    [0, 0, 0],
    //rotation
    [0,0,90],
    horizontal_separator_positions,
    //is reversed
    false];
  right = [
    //width
    num_y*gf_pitch,
    //Position
    [num_x*gf_pitch, num_y*gf_pitch, 0],
    //rotation
    [0,0,270],
    horizontal_separator_positions,
    //is reversed
    true];
    
  locations = [front, back, left, right];
 
  color(color_label)
  for(l = [0:1:len(locations)-1]){
    location = locations[l];
    separator_positions = location[ilSeparatorConfig];//calculateSeparators(location[3]);
   
    labelPoints = [[ 0-labelSize.y, zpoint-labelCornerRadius],
      [ 0, zpoint-labelCornerRadius ],
      [ 0, zpoint-labelCornerRadius-labelSize.z ]
    ];
  
    // calcualte list of chambers. 
    labelWidthmm = labelSize.x <=0 ? location[ilWidth] : labelSize.x * gf_pitch;
    chamberWidths = len(separator_positions) < 1 || 
      labelWidthmm == 0 ||
      label_position == "left" ||
      label_position == "center" ||
      label_position == "right" ?
        [ location[ilWidth] ] // single chamber equal to the bin length
        : [ for (i=[0:len(separator_positions)]) 
          (i==len(separator_positions) 
            ? location[0]
            : separator_positions[i][iSeperatorPosition]) - (i==0 ? 0 : separator_positions[i-1][iSeperatorPosition]) ];
                
    union()
    if(label_walls[l] > 0)
      //patterns in the outer walls
      translate(location[1])
      rotate(location[2])     
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
                  
        translate([i == 0 ? 0 : ((chamberStart + label_pos_x)*(location[ilReversed] ? -1 : 1) + (location[ilReversed] ? location[ilWidth] : 0)),0,0])
        difference(){
          hull() for (y=[0, 1, 2])
          translate([0, labelPoints[y][0], labelPoints[y][1]])
            rotate([0, 90, 0])
            union(){
              //left
              tz(abs(label_num_x))
              sphere(r=labelCornerRadius, $fn=64);
              //Right
              sphere(r=labelCornerRadius, $fn=64);
            }
          
          if(label_style == "click"){
             translate([2,labelPoints[0][0]+1,zpoint])
             LabelClick();
          } else if(label_relief > 0){
            translate([0,labelPoints[0][0]+max(labelCornerRadius,label_relief+0.5),zpoint-label_relief-fudgeFactor])
              cube([abs(label_num_x),abs(labelPoints[0][0]-labelPoints[1][0]),label_relief+fudgeFactor]);
        }
      }
    }
  }
}

module LabelClick(
  
){
  clickSize= [36.7,11.3, 1.2];
  clickRadius = 0.25;
  translate([0,0,-clickSize.z])
  difference(){
    roundedCube(size=clickSize,sideRadius=clickRadius);
    for(i = [0:2]){
      translate([(i+0.5)*clickSize.x/3,clickSize.y+fudgeFactor,0.23])
      rotate([90,210,0])
      cylinder(h=clickSize.y+fudgeFactor*2,r=.75, $fn=3);
    }}
}
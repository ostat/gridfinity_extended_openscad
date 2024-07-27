

module gridfinity_label(
  num_x,
  num_y,
  zpoint,
  label_position,
  vertical_separator_positions,
  label_size,
  label_style,
  label_relief
)
{
  labelSize = let(
      labelxtemp = is_num(label_size) ? label_size : is_list(label_size) && len(label_size) >= 1 ? label_size.x : 0,
      labelx = labelxtemp <=0 ? num_x : labelxtemp,
      labelytemp = is_list(label_size) && len(label_size) >= 2 ? label_size.y : 0,
      labely = labelytemp <= 0 ? 14 : labelytemp,
      labelztemp = is_list(label_size) && len(label_size) >= 3 ? label_size.z : 0,
      labelz = labelztemp == -1 ? labely*3/4 : labelztemp == 0 ? labely : labelztemp,
      labelrtemp = is_list(label_size) && len(label_size) >= 4 ? label_size[3] : 0,
      labelr = labelrtemp <= 0 ? 0.6 : labelrtemp)
        [labelx,labely,labelz,labelr];

  labelCornerRadius = labelSize[3];

  labelPoints = [[ (num_y-0.5)*gf_pitch-labelSize.y, zpoint-labelCornerRadius],
    [ (num_y-0.5)*gf_pitch, zpoint-labelCornerRadius ],
    [ (num_y-0.5)*gf_pitch, zpoint-labelCornerRadius-labelSize.z ]
  ];
  
  separator_positions = calculateSeparators(vertical_separator_positions);
    
  // calcualte list of chambers. 
  labelWidthmm = labelSize.x * gf_pitch;
  chamberWidths = len(separator_positions) < 1 || 
    labelWidthmm == 0 ||
    label_position == "left" ||
    label_position == "center" ||
    label_position == "right" ?
      [ num_x * gf_pitch ] // single chamber equal to the bin length
      : [ for (i=[0:len(separator_positions)]) 
        (i==len(separator_positions) 
          ? num_x * gf_pitch
          : separator_positions[i]) - (i==0 ? 0 : separator_positions[i-1]) ];
                  
  color(color_label)
  for (i=[0:len(chamberWidths)-1]) {
      chamberStart = i == 0 ? 0 : separator_positions[i-1];
      chamberWidth = chamberWidths[i];
      label_num_x = (labelWidthmm == 0 || labelWidthmm > chamberWidth) ? chamberWidth : labelWidthmm;
      label_pos_x = (label_position == "center" || label_position == "centerchamber" )? (chamberWidth - label_num_x) / 2 
                      : (label_position == "right" || label_position == "rightchamber" )? chamberWidth - label_num_x 
                      : 0 ;
                      
      translate([(-gf_pitch/2) + ((chamberStart + label_pos_x)),0,0])
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
           translate([2,labelPoints[i][0]+1,zpoint])
           LabelClick();
        } else if(label_relief > 0){
          translate([0,labelPoints[0][0]+max(labelCornerRadius,label_relief+0.5),zpoint-label_relief-fudgeFactor])
            cube([abs(label_num_x),abs(labelPoints[0][0]-labelPoints[1][0]),label_relief+fudgeFactor]);
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
use <../modules/module_pattern_brick.scad>

  function course_v2_working(canvis_length, count, spacing, center_weight, half_offset=false) = 
    let(c = count - (half_offset ? 0 : 1),
    l = [for (i=[0:c]) 
    ((((canvis_length+spacing)/(c)- spacing) + cos((i)*360/(c))*-1*center_weight)/(half_offset && (i==0 || i==c) ? 2 : 1) - spacing)],
    suml = sum(l),
    comp = (canvis_length-(c)*spacing)/suml)
    [for (i=[0:c]) l[i]];

    
  function course_v2_working(canvis_length, count, spacing, center_weight, half_offset=false) = 
    let(c = count - (half_offset ? 0 : 1),
    l = [for (i=[0:c]) 
    (((canvis_length+spacing)/(c) + cos((i)*360/(c))*-1*center_weight)/(half_offset && (i==0 || i==c) ? 2 : 1) - spacing)],
    suml = sum(l),
    comp = (canvis_length-(c)*spacing)/suml)
    [for (i=[0:c]) l[i]*comp];

  //half_offset working
  function course_v1(canvis_length, count, spacing, center_weight, half_offset=false) = 
    let(count = count-(half_offset ? 0: 1))
    [for (i=[0:count]) 
    ((canvis_length+spacing)/count + cos((i)*360/count)*-1*center_weight)/(half_offset && (i==0 || i==count) ? 2 : 1) - spacing];
    

    
module show_brickcourse( 
  name,  
  canvis_length = canvis_length, 
  count = count, 
  spacing = spacing, 
  center_weight = 0,
  half_offset = false,
  h=height,
  thickness = 5){
  
  bricks=course(
  canvis_length = canvis_length, 
  count = count, 
  spacing = spacing, 
  center_weight = center_weight,
  half_offset = half_offset);
  
  echo(name=name, list=bricks);
  #for(ix=[0:len(bricks)-1]) {
    pos = sum(bricks, end = ix-1) + spacing*ix;
    size = [bricks[ix], h, thickness];
    translate([pos,0])
    cube(size=size);
  }
}

center_weight = 1;
count = 9;
half_offset = true;
spacing = 1;
canvis_length = 31;
height = 5;

difference(){
  translate([-spacing,-spacing,1])
  cube([canvis_length+spacing*2,70+spacing*2,1]);

  translate([0,0,0])
  show_brickcourse(
    name = "cw0_ho0",
    center_weight = 0,
    half_offset = false);

  translate([0,(height+spacing)*1,0])
  show_brickcourse(
    name = "cw1_ho0",
    center_weight = 1,
    half_offset = false);
    
  translate([0,(height+spacing)*2,0])
  show_brickcourse(
    name = "cw2_ho0",
    center_weight = 2,
    half_offset = false);
    
  translate([0,(height+spacing)*3,0])
  show_brickcourse(
    name = "cw-1_ho0",
    center_weight = -1,
    half_offset = false);
    
  translate([0,(height+spacing)*4,0])
  show_brickcourse(
    name = "cw0_ho1",
    center_weight = 0,
    half_offset = true);

  translate([0,(height+spacing)*5,0])
  show_brickcourse(
    name = "cw0_ho1",
    center_weight = 1,
    half_offset = true);

  translate([0,(height+spacing)*6,0])
  show_brickcourse(
    name = "cw2_ho1",
    center_weight = 2,
    half_offset = true);
    
  translate([0,(height+spacing)*7,0])
  show_brickcourse(
    name = "cw-1_ho1",
    center_weight = -1,
    half_offset = true);
}
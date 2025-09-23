include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity_block.scad>

use <modules/thirdparty/dotscad/ring_extrude.scad>;

/*<!!start gridfinity_marble!!>*/
/* [marbleRun] */
marble_style = "blank"; //[blank, dish, ramp, cup]
//Size of the marble track. Default 19.
marble_diameter = 19;

//1=42mm, 1.5=63mm, 2=84mm
Block_Dimention = 1; //[1, 1.5, 2]

//3=21mm, 4=28mm
Block_Layer_Height = 3; //[3, 4]

Ramp_Base_Offset = 0; //0.1

/* [Cup Top] */
marble_top_style = "straight"; //[none,straight,straight_double,straight_triple,straights,ramp,ramp+dip,ramp+corner,cross,cross+dip,cross+doubledip,dip,corner,corners,cornerramp, triple_corner, straight+corner, split, bend+corner]
marble_top_rotate = 0; //90
marble_top_mirror = [0,0,0]; //[0:1]
marble_top_position = [0,0]; //0.1
marble_top_profile = "auto"; //[auto, top, round, printable_round]
marble_top_highlight = false; 
 
/* [Cup Middle] */
marble_middle_style = "none"; //[none,straight,straight_double,straight_triple,straights,ramp,cross,cross+dip,dip,corner,corners,cornerramp,triple_corner, straight+corner, split, bend+corner]
marble_middle_rotate = 0; //90
marble_middle_mirror = [0,0,0]; //[0:1]
marble_middle_position = [0,0]; //0.1
marble_middle_profile = "auto"; //[auto, top, round, printable_round]
marble_middle_highlight = false; 

/* [Cup layer2 (42mm)] */
marble_level2_style = "none"; //[none,straight,straight_double,straight_triple,straights,ramp,cross,cross+dip,dip,corner,corners,cornerramp,triple_corner, straight+corner, split, bend+corner]
marble_level2_rotate = 0; //90
marble_level2_mirror = [0,0,0]; //[0:1]
marble_level2_position = [0,0]; //0.1
marble_level2_profile = "auto"; //[auto, top, round, printable_round]
marble_level2_highlight = false; 

/* [Cup layer1 (21mm)] */
marble_level1_style = "none"; //[none,straight,straight_double,straight_triple,straights,ramp,cross,cross+dip,dip,corner,corners,cornerramp,triple_corner, straight+corner, split, bend+corner]
marble_level1_rotate = 0; //90
marble_level1_mirror = [0,0,0]; //[0:1]
marble_level1_position = [0,0]; //0.1
marble_level1_profile = "auto"; //[auto, top, round, printable_round]
marble_level1_highlight = false; 

/* [Cup Bottom] */
marble_bottom_style = "none"; //[none,straight,straight_double,straight_triple,straights,ramp,cross,cross+dip,dip,corner,corners,cornerramp,triple_corner, straight+corner, split, bend+corner]
marble_bottom_rotate = 0; //90
marble_bottom_mirror = [0,0,0]; //[0:1]
marble_bottom_position = [0,0]; //0.1
marble_bottom_profile = "auto"; //[auto, top, round, printable_round]
marble_bottom_highlight = false; 

/*<!!end gridfinity_marble!!>*/

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.5
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.5
// Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [3, 0]; //3
// Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
//under size the bin top by this amount to allow for better stacking
headroom = 0; // 0.1

/* [Cup Lip] */
// Style of the cup lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [1,1]; //0.1
// Create a relief in the lip
lip_top_relief_height = 0; // 0.1
// how much of the lip to retain on each end
lip_top_relief_width = 8.5; // 0.1
// add a notch to the lip to prevent sliding.
lip_top_notches  = true;
// enable lip clip for connection cups
lip_clip_position = "disabled"; //[disabled, intersection]

/* [Base] */
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 1.5;
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = true;

/* [debug] */
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [Model detail] */
//assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
//where to render the model
render_position = "center"; //[default,center,zero]
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments 
fa = 6; 
// minimum size of a fragment.  Low is more fragments
fs = 0.1; 
// number of fragments, overrides $fa and $fs
fn = 0;  
// set random seed for 
random_seed = 0; //0.0001
/*<!!end gridfinity_basic_cup!!>*/

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;

//Version number printed on the bottom.
marble_version = 0.5;
show_demo_tracks = false;

function addClearance(dim, clearance) =
    [dim.x > 0 ? dim.x+clearance : 0
    ,dim.y > 0 ? dim.y+clearance : 0
    ,dim.z];

module get_pattern(pattern){
  if(pattern == "top"){
    profile_top(); 
  } else if(pattern == "round"){
    profile_round(); 
  } else if(pattern == "printable_round"){
    profile_printable_round(); 
  } else { //auto
    children();
  }
}


if(show_demo_tracks)
{
  !union(){
      num_x = calcDimensionWidth(width);
      num_y = calcDimensionDepth(depth);
      num_z = calcDimensionHeight(height);
    
    color("green")
    translate([0,0,0])
      track_straight(100)
      profile_top(marbleDiameter=20,lipRadius=4.0);

    color("green")
    translate([0,40,0])
      track_corner()
      profile_top(marbleDiameter=20,lipRadius=4.0);
    
    color("green")
    translate([0,100,0])
      track_ramp(100,40,10, rotation=-90)
      profile_top(marbleDiameter=20,lipRadius=4.0);
    
    color("green")
    translate([0,140,0])
      track_ramp(100,40,10)
      profile_top(marbleDiameter=20,lipRadius=4.0);
    
    color("green")
    translate([0,180,0])
      bent_extrusion()
      profile_top(marbleDiameter=20,lipRadius=4.0);

    color("green")
    translate([0,220,0])
      bent_extrusion(
        start_straight=10,
        end_straight=10,
        length=2*gf_pitch,
        bend_radius=15,
        bend_offset=1*gf_pitch/4)
        rotate(90)
        profile_ramp(marbleDiameter=20);
        
   color("green")
   translate([0,-60,0])
    track_corner_ramp()
             //rotate(270)
          profile_middle(marbleDiameter=19);
    //profile_ramp(marbleDiameter=20);
  }
}

// Generates the gridfinity bin with cutouts.
// Runs the function without needing to pass the variables.
module gridfinity_marble(
  //marble settings
  marble_style=marble_style,
  marbleDiameter=marble_diameter,
  //gridfinity settings
  width=width, depth=depth, height=height,
  position = render_position,
  floor_thickness = floor_thickness,
  half_pitch = half_pitch,
  wall_thickness=wall_thickness) {
  
  lip_style = marble_style == "ramp" ? "none" : lip_style;
  halfPitch=marble_style == "cup" ? false : half_pitch;
  
  difference() {
    num_x = calcDimensionWidth(width);
    num_y = calcDimensionDepth(depth);
    num_z = calcDimensionHeight(height);
    
  /*<!!start gridfinity_basic_cup!!>*/
    gridfinity_cup(
      width=width, depth=depth, height=height,
      filled_in=true,
      cupBase_settings= CupBaseSettings(
        magnetSize = [0,0], 
        centerMagnetSize = [0,0], 
        screwSize = [0,0], 
        cavityFloorRadius = -1,
        halfPitch=halfPitch,
        flatBase=false,
        spacer=false),
      wall_thickness=wall_thickness,
      lip_settings = LipSettings(
        lipStyle=lip_style, 
        lipSideReliefTrigger=lip_side_relief_trigger, 
        lipTopReliefHeight=lip_top_relief_height, 
        lipTopReliefWidth=lip_top_relief_width,
        lipNotch=lip_top_notches,
        lipClipPosition=lip_clip_position),
      headroom=headroom,
      cupBaseTextSettings = CupBaseTextSettings(
        baseTextLine1Enabled = true,
        baseTextLine2Enabled = true,
        baseTextLine1Value = str("m", marbleDiameter, "      ", "v", marble_version),
        baseTextFontSize = 4,
        baseTextFont = "aldo",
        baseTextDepth = 0.4));
    /*<!!end gridfinity_basic_cup!!>*/
      
    if(marble_top_style != "none"){
      conditional_highlight(marble_top_highlight)
      translate(marble_top_position*gf_pitch)
      translate([0,0,num_z*gf_zpitch])
        //mirror(marble_top_mirror)
        path(
          num_x=num_x, num_y=num_y,
          num_z=num_z,
          style = marble_top_style,
          top = true,
          r=marble_top_rotate,
          m=marble_top_mirror)
        get_pattern(marble_top_profile)
        profile_top(marbleDiameter);    
    }
    
    if(marble_middle_style != "none"){
      conditional_highlight(marble_middle_highlight)
      translate(marble_middle_position*gf_pitch)
      translate([0,0,num_z*gf_zpitch/2])
        //mirror(marble_middle_mirror)
        path(
          num_x=num_x, num_y=num_y,num_z=num_z/2,
          style = marble_middle_style, 
          r=marble_middle_rotate,
          m=marble_middle_mirror)
        get_pattern(marble_top_profile)
        profile_middle(marbleDiameter);    
    }

    if(marble_level2_style != "none"){
      conditional_highlight(marble_level2_highlight)
      translate(marble_level2_position*gf_pitch)
      translate([0,0,gf_zpitch*6])
        //mirror(marble_level2_mirror)
        path(
          num_x=num_x, num_y=num_y,num_z=6,
          style = marble_level2_style, 
          r=marble_level2_rotate,
          m=marble_level2_mirror)
        get_pattern(marble_level2_profile)
        profile_middle(marbleDiameter);    
    }
    
    if(marble_level1_style != "none"){
      conditional_highlight(marble_level1_highlight)
      translate(marble_level1_position*gf_pitch)
      translate([0,0,gf_zpitch*3])
        //mirror(marble_level1_mirror)
        path(
          num_x=num_x, num_y=num_y,num_z=3,
          style = marble_level1_style, 
          r=marble_level1_rotate,
          m=marble_level1_mirror)
        get_pattern(marble_level1_profile)
        profile_middle(marbleDiameter);    
    }
   
    if(marble_bottom_style != "none"){
      conditional_highlight(marble_bottom_highlight)
      translate(marble_bottom_position*gf_pitch)
        //mirror(marble_bottom_mirror)
        path(
          num_x=num_x, num_y=num_y,num_z=0,
          style = marble_bottom_style,
          r=marble_bottom_rotate,
          m=marble_bottom_mirror)
        get_pattern(marble_bottom_profile)
        profile_bottom(marbleDiameter);    
    }
    
    if(marble_style == "cup"){
      cup_zpos = num_x ==1 && num_x == 1 ? floor_thickness : gfBaseHeight()+floor_thickness;
      cup_border = 5;
      cup_radius = (min(num_x*gf_pitch,num_y*gf_pitch)-cup_border)/2;
      translate([num_x*gf_pitch/2,num_y*gf_pitch/2,cup_zpos])
        roundedCylinder(
            h=num_z*gf_zpitch-cup_zpos,
            r=cup_radius,
            roundedr=0,
            roundedr1=marbleDiameter/2,
            roundedr2=0);
      
      translate([0,0,num_z*gf_zpitch])
        style_cross(num_x,num_y)
        profile_top(marbleDiameter); 
    }
    
    if(marble_style == "ramp" || marble_style == "ramp2"){
      inramp = num_x*(num_x ==1 ? 2 : 5);
      rampheight = num_z - 3;
      translate([0,num_y*gf_pitch/2,num_z*gf_zpitch])
        track_ramp(
          length=num_x*gf_pitch, 
          divation=gf_zpitch*rampheight, 
          inramp=inramp,
          rotation=-90)
          rotate(90)
          profile_ramp(marbleDiameter,erraser = [num_y*gf_pitch,gf_zpitch*rampheight+4]);
    }
    
    
    if(marble_style == "dish"){
      cornerRadius=5;
      upperLength=min(num_z*gf_zpitch/4,cornerRadius/2);
      transitionLength=num_z*gf_zpitch/4;
      lowerLength=min(num_z*gf_zpitch/4,cornerRadius/2);
      dishHeight = upperLength+transitionLength+lowerLength;  
      
      translate([(num_x*gf_pitch)/2,(num_y*gf_pitch)/2,(num_z*gf_zpitch)])
      rounded_taper(
        upperRadius=((num_x*gf_pitch)-6)/2,
        upperLength=upperLength,
        lowerRadius=marbleDiameter/2,
        transitionLength=transitionLength,
        lowerLength=lowerLength+1,
        cornerRadius=cornerRadius,
        alignTop=true);
       
      translate([(num_x-1)*gf_pitch/2,num_y*gf_pitch/2,num_z*gf_zpitch-(dishHeight)])
        rotate([270,0,0])
        track_corner(){
          circle(r=marbleDiameter/2);
          rotate(270)
          profile_middle(marbleDiameter);
        }
        
       if(num_x>1){
          translate([0,num_y*gf_pitch/2,num_z*gf_zpitch-(dishHeight)-gf_pitch/2])
          track_straight(length =(num_x-1)/2*gf_pitch+fudgeFactor)
          profile_middle(marbleDiameter); 
       }
    }
  }
}

module conditional_highlight(highlight){ 
  if(highlight && $preview){
    #children();
  } else {
    children();
  }
}
module path(
  num_x,
  num_y,
  num_z,
  style,
  top = false,
  r=0,
  m=[0,0,0],
  marbleDiameter=marble_diameter){
  _num_x = abs(r)/90%2 == 1 ? num_y : num_x;
  _num_y = abs(r)/90%2 == 1 ? num_x : num_y;
  
  translate([num_x*gf_pitch/2,num_y*gf_pitch/2,0])
  rotate([0,0,r])
  mirror(m)
  translate([-_num_x*gf_pitch/2,-_num_y*gf_pitch/2,0])
  union(){
    if(style == "straight"){
      translate([0,_num_y*gf_pitch/2,0])
        track_straight(length = _num_x*gf_pitch)
        children();  
    }
    
    if(style == "straights"){
      for(yi=[0.5:0.5:_num_y-0.5])
      translate([0,yi*gf_pitch,0])
        track_straight(length = _num_x*gf_pitch)
        children(); 
    }
    
    if(style == "straight_double"){
      translate([0,_num_y*gf_pitch/4,0])
        track_straight(length = _num_x*gf_pitch)
        children();  
      translate([0,_num_y*gf_pitch*3/4,0])
        track_straight(length = _num_x*gf_pitch)
        children();    
    }
    
    if(style == "straight_triple"){
      translate([0,_num_y*gf_pitch/6,0])
        track_straight(length = _num_x*gf_pitch)
        children();    
      translate([0,_num_y*gf_pitch/2,0])
        track_straight(length = _num_x*gf_pitch)
        children();    
      translate([0,_num_y*gf_pitch*5/6,0])
        track_straight(length = _num_x*gf_pitch)
        children();    
    } 
    
    if(style == "cross" || style == "cross+dip" || style == "cross+doubledip"){
      style_cross(_num_x,_num_y, center_only=true)
        children(); 
      
      /*
      if(_num_x>=2 && _num_y >=2){
        style_corners(_num_x, _num_y)
          children(); 
      }*/ 
    
      if(style == "cross+dip" || style == "cross+doubledip"){
        translate([_num_x*gf_pitch/2,_num_y*gf_pitch/2-gf_pitch/2,style == "cross+doubledip"? -gf_zpitch : 0]) 
        rotate([0,90,0])
        track_corner(
          radius = gf_pitch/2,
          inramp = gf_pitch/8,
          inextention = _num_x*gf_pitch/2 - gf_pitch/2)
          rotate(270)
          profile_middle(marble_diameter);
      } 
    }
    
    if(style == "dip"){
      translate([0,_num_y*gf_pitch/2,-3*gf_zpitch]) 
      rotate([90,0,0])
      track_corner(
        radius = gf_pitch/2,
        inramp = gf_pitch/4)
        profile_basic(marble_diameter);
        
      translate([_num_y*gf_pitch/2,0,0]) 
      rotate([0,90,0])
      track_corner(
        radius = gf_pitch/2,
        inramp = gf_pitch/4)
        rotate(270)
        profile_middle(marble_diameter);
    } 

    if(style == "ramp" || style == "ramp+dip" || style == "ramp+corner"){
      echo("ramp", num_z=num_z, rampheight=rampheight);
      x = style == "ramp+dip" || style == "ramp+corner" ? _num_x-1 : _num_x;
      inramp = x*(x == 1 ? 4 : 5);
      outramp = style == "ramp" ? inramp : 0;
      
      rampheight = num_z >=6 ? 3 : 1.6;
      translate([0,_num_y*gf_pitch/2,0])
      union(){
        track_ramp(
          length=x*gf_pitch+fudgeFactor, 
          divation=gf_zpitch*rampheight, 
          inramp=inramp,
          outramp=outramp,
          rotation=-90){
            rotate(90)
            if(top) profile_top(marble_diameter); 
            else profile_middle(marble_diameter);
            rotate(90)    
            profile_middle(marble_diameter);
            rotate(90)    
            profile_middle(marble_diameter);         
        }
      
      if(style == "ramp+dip"){
        translate([(_num_x-1)*gf_pitch,0,-gf_zpitch*(rampheight+3)])
        rotate([90,0,0])
        track_corner(
          radius = gf_pitch/2,
          inramp = gf_pitch/16)
          rotate(90)
          profile_middle(marble_diameter);
      } 

      if(style == "ramp+corner"){
        translate([(_num_x-1)*gf_pitch,gf_pitch/2,-gf_zpitch*rampheight])
        rotate([0,0,270])
        track_corner()
        profile_middle(marble_diameter);
      }
     } 
    }
    
    if(style == "cornerramp"){
      
      rampheight = Ramp_Base_Offset > 0 ? Ramp_Base_Offset 
        : num_z >= 6 ? 3 
        : Block_Dimention == 1.5 ? 0.9 : 1.5; 
      track_corner_ramp(
      height = rampheight*gf_zpitch)
        //rotate(270)
        //rotate(20)
        children();
    } 
    
    if(style == "corner"){
      track_corner()
        children();
    } 
    
    if(style == "corners"){
      style_corners(_num_x, _num_y)
        children(); 
    } 

    if(style == "straight+corner"){
      translate([0,_num_y*gf_pitch/2,0])
        track_straight(length = _num_x*gf_pitch)
        children(); 
        
      style_corners(_num_x, _num_y)
        children(); 
    }
    
    if(style == "triple_corner"){
      track_corner(gf_pitch+gf_pitch/2)
        children();
  
      translate([2*gf_pitch,2*gf_pitch,0])
        rotate([0,0,180])
        track_corner()
        children();
        
      track_corner()
        children();
   }

   if(style == "bend+corner"){
      translate([0, _num_y*gf_pitch/2]) 
      track_ramp(
        length = _num_x*gf_pitch, 
        divation = _num_y*gf_pitch/4, 
        inramp = 10)
          children();
          
      translate([2*gf_pitch,0,0])
        rotate([0,0,90])
        track_corner()
        children();

  }
  
  if(style == "split"){
      translate([0, _num_y*gf_pitch/2]) 
      track_ramp(
        length = _num_x*gf_pitch, 
        divation = _num_y*gf_pitch/4, 
        inramp = 10)
          children();

      translate([0, _num_y*gf_pitch/2]) 
      track_ramp(
        length = _num_x*gf_pitch, 
        divation = -_num_y*gf_pitch/4, 
        inramp = 10)
          children();
     }
  }
}

module style_corners(num_x, num_y){
  track_corner()
    children();
      
 if(num_x>=Block_Dimention*1.5 && num_y >=Block_Dimention*1.5)
  translate([0,num_y*gf_pitch,0])
    rotate([0,0,270])
    track_corner()
      children();  
    
 if(num_y >=Block_Dimention*1.5)
    translate([num_x*gf_pitch,0,0])
    rotate([0,0,90])
    track_corner()
      children();
  
  if(num_x>=Block_Dimention)
    translate([num_x*gf_pitch,num_y*gf_pitch,0])
      rotate([0,0,180])
      track_corner()
        children();  
}

module style_cross(num_x, num_y, center_only=false){
  if(center_only){
    translate([0,num_y*gf_pitch/2,0])
      track_straight(length = num_x*gf_pitch)
      children();       
    translate([num_x*gf_pitch/2,0,0])
      rotate([0,0,90])
      track_straight(length = num_y*gf_pitch)
      children(); 
  } else {      
    for(yi=[0.5:0.5:num_y-0.5])
      translate([0,yi*gf_pitch,0])
      track_straight(length = num_x*gf_pitch)
      children();   
      
    for(xi=[0.5:0.5:num_x-0.5])
      translate([xi*gf_pitch,0,0])
      rotate([0,0,90])
      track_straight(length = num_y*gf_pitch)
      children(); 
  }
}          

module track_ramp(
  length, 
  divation, 
  inramp, 
  outramp, 
  radius=15,
  rotation = 0) {
  
  assert(length>0, "length > 0");
  //assert(divation>0, "divation > 0");

  outramp = is_undef(outramp) ? inramp:outramp;
  rotate([0,90,0])
  rotate([0,0, rotation])
  bent_extrusion(
    start_straight=inramp,
    end_straight=outramp,
    length=length,
    bend_radius=15,
    bend_offset=divation){
      children(0);
      if($children >=2) children(1); else children(0);
      if($children >=3) children(2); else children(0);
    }
}

module track_straight(length){
  rotate([0,90,0])
  linear_extrude(height = length)
  
  children(); 
}

module track_corner_ramp(
  radius = Block_Dimention/2*gf_pitch,
  height = Block_Layer_Height*gf_zpitch/2,
  shape_radius = marble_diameter/2,
  inramp = 0,
  $fn = 64)
{
  L=radius;
  D=height;
  B=sqrt(L^2+(D-shape_radius)^2);
  Z=sqrt(B^2-shape_radius^2);
  a1=atan((D-shape_radius)/L);
  a1_2=asin((D-shape_radius)/B);
  a2=atan(shape_radius/Z);
  a2_2=asin(shape_radius/B);
  a=a1+a2;
  echo(L=L, D=D, B=B, Z=Z,a1=a1,a1_2=a1_2,a2=a2,a2_2=a2_2,a=a);
  
  function rotate_point(x, y, theta) = [
      x * cos(theta) - y * sin(theta),
      x * sin(theta) + y * cos(theta)];

  function shape_printable_circle(r, rotate = 0) = let(
    flat_top_width = (r*2)/2.5,
    flat_top_height = r+0.5,
    circle = [for (i=[0:ceil($fn*3/4)-1]) let (a=i*360/$fn-225+rotate) r * [cos(a), sin(a)]],
    flat = [rotate_point(flat_top_width/2,flat_top_height,rotate),rotate_point(-flat_top_width/2,flat_top_height,rotate)])
    concat(circle, flat);
 
    zAngle = a;
   
   
    translate([0,0,-shape_radius])
    rotate([0,zAngle,0])
    translate([0,0,shape_radius])
    union(){
    
      translate([0,radius-Z,0])
      ring_extrude(shape_printable_circle(shape_radius, rotate=zAngle), radius = Z, twist = -zAngle, angle = 90);
      
      translate([0,radius,0])
      rotate([0,270,90])
      translate([-shape_radius,0,0])
      rotate([0,0,-0.01])
      ring_extrude(shape_printable_circle(shape_radius, rotate=270), radius = shape_radius , twist = 0, angle = zAngle+0.01);
    }
    
    //center 
    //translate([0, 0,start_straight]) 
    //translate([0,bend_radius,0])
    //rotate([-a,0,0])
    translate([radius,(radius-Z)+fudgeFactor,-height])
    rotate([90,90,0])
    linear_extrude(radius-Z+fudgeFactor)
      children();  
}

module track_corner(
  radius = Block_Dimention/2*gf_pitch,
  inramp = 0,
  inextention = 0,
  outextention = 0)
{
  radius = radius-inramp; 
  instraight = +inramp + inextention;
  outstraight = inramp + outextention;
  
  rotate([90,90,0])
  translate([0,inramp,-inramp]) 
  union(){
    if(instraight>0)
    translate([0,radius,instraight])
    rotate([0,90,-180])
      track_straight(length = instraight+fudgeFactor)
      children();
      
    if(outstraight>0)
    translate([0,fudgeFactor,-radius])
    rotate([90,0,270])
      track_straight(length = outstraight+fudgeFactor)
      children();
    
    translate([0,0])
    rotate([0,90,0])
      union(){
        rotate_extrude(angle=90, convexity=10)
        difference(){
         translate([radius, 0]) 
            rotate(90)
            children();
          
         translate([-100,-50])
          square(100,100);
        }    
      }
  }
}

  
module bent_extrusion(
  start_straight=5,
  end_straight=5,
  length=42,
  bend_radius=15,
  bend_offset=21){
  
  workingLength = length -start_straight-end_straight;
  L=workingLength /2;
  D=bend_offset/2;
  B=sqrt(L^2+(D-bend_radius)^2);
  Z=sqrt(B^2-bend_radius^2);
  a1=atan((D-bend_radius)/L);
  a1_2=asin((D-bend_radius)/B);
  a2=atan(bend_radius/Z);
  a2_2=asin(bend_radius/B);
  a=a1+a2;
  echo(workingLength=workingLength, children = $children, L=L, D=D, B=B, Z=Z,a1=a1,a1_2=a1_2,a2=a2,a2_2=a2_2,a=a);

   //render() // fix for PolySet -> Manifold conversion failed: NotManifold Trying to repair and reconstruct mesh..
   union(){
    centerChild = $children >= 2 ? 1 : 0;
    //Start angled piece
      translate([0, 0,start_straight]) 
      rotate([0,90,0])
      rotate([0,0,-90])
      translate([-bend_radius, 0]) 
      rotate_extrude(angle=-a, convexity=20)
      translate([bend_radius, 0]) 
      rotate([0,0,90])
      children(centerChild);  

      //center 
      translate([0, 0,start_straight]) 
      translate([0,bend_radius,0])
      rotate([-a,0,0])
      translate([0,-bend_radius,-fudgeFactor])
      linear_extrude(Z*2+fudgeFactor*2)
      children(centerChild);  
    
    //End angled piece
    translate([0,bend_offset,length-end_straight])
      rotate([0,90,0])
      rotate([0,0,-90])
      translate([bend_radius, 0]) 
      rotate_extrude(angle=-a, convexity=20)
      difference(){
        translate([-bend_radius, 0]) 
        rotate([0,0,90])
          children(centerChild);  
         translate([0,-50])
         square(100,100);
      }

    if(start_straight>0){
      //translate([0,num_y*gf_pitch*3/4,num_z*gf_zpitch])
      //rotate([0,90,0])
      linear_extrude(start_straight+fudgeFactor)
      children(0);  
    }
    
    if(end_straight>0){
      translate([0,bend_offset,length-end_straight-fudgeFactor])
      //rotate([0,90,0])
      linear_extrude(end_straight+fudgeFactor)
      children($children-1);  
    }
  }
}

//stencil for a top layer track, rounds over the wall
module profile_basic(marbleDiameter=marble_diameter){
  profile_round(marbleDiameter); 
}

//stencil for a top layer track, rounds over the wall
module profile_bottom(marbleDiameter=marble_diameter){
  profile_round_printable(marbleDiameter);
}

module profile_middle(marbleDiameter=marble_diameter){
  profile_round_printable(marbleDiameter);
}

module profile_round(marbleDiameter=marble_diameter){
  circle(r=marbleDiameter/2); 
}

module profile_round_printable(marbleDiameter=marble_diameter){
  flat_top_width = marbleDiameter/2.5;
  flat_top_height = marbleDiameter/2+0.5;
  rotate(90)
  hull(){
    circle(r=marbleDiameter/2); 
    translate([-flat_top_width/2,0])
    square([flat_top_width,flat_top_height]); 
  }
}

//stencil for a top layer track, rounds over the wall
module profile_top(
  marbleDiameter=marble_diameter,
  lipRadius=3.8){
  difference(){
    union(){
      circle(r=marbleDiameter/2); 
      translate([-marbleDiameter/2,-marbleDiameter/2-lipRadius])
      square(size=[marbleDiameter/2,marbleDiameter+lipRadius*2]);
    }
    
    if(lipRadius>0){
      translate([0,-marbleDiameter/2-lipRadius])
      circle(r=lipRadius); 
      translate([0,marbleDiameter/2+lipRadius])
      circle(r=lipRadius); 
    }
  }
}

//stencil for a top layer track, rounds over the wall
module profile_ramp(marbleDiameter,erraser=[0,0]){
  erraser = [max(marbleDiameter,erraser.x), max(marbleDiameter,erraser.y)];
  difference(){
    union(){
      circle(r=marbleDiameter/2); 
      translate([-erraser.y,-erraser.x/2])
      square(size=[erraser.y,erraser.x]);
    }
  }
}

render()
set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  //pitch = pitch,
  cut = [cutx, cuty, height],
  setColour = set_colour,
  randomSeed = random_seed) 
gridfinity_marble();
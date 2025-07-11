champher_demo = false;

if(champher_demo)
{
  rotate([90,0,0])
  chamferedSquare(size=50, radius = 0, $fn=64);

  translate([0,0,30])
  roundedNegativeChampher(
    champherRadius = 10, 
    size=[400,200], 
    cornerRadius = 20, $fn=64);
    
  translate([0,0,60])
  roundedNegativeChampher(
    champherRadius = 20, 
    size=[200,100], 
    cornerRadius = 10,
    champher = false, $fn=64);
    
  translate([0,0,90])
  roundedNegativeChampher(
    champherRadius = 10, 
    size=[100,50], 
    cornerRadius = 5,
    height = 20, $fn=64);
}

module roundedNegativeChampher(
  champherRadius = 10, 
  size=[80,100], 
  cornerRadius = 10, 
  height = 0,
  champher = false)
{
  eps = 0.01;

  height = height <= champherRadius ? champherRadius : height;
  postions = [
    [[0,0,0],
      size.y-cornerRadius*2,
      [size.x/2+champherRadius,size.y/2-cornerRadius,0],
      [size.x/2-cornerRadius,size.y/2-cornerRadius,0]],
    [[90,0,0],
      size.x-cornerRadius*2,
      [size.y/2+champherRadius,size.x/2-cornerRadius,0],
      [-size.x/2+cornerRadius,-size.y/2+cornerRadius,0]],
    [[180,0,0],
      size.y-cornerRadius*2,
      [size.x/2+champherRadius,size.y/2-cornerRadius,0],
      [size.x/2-cornerRadius,-size.y/2+cornerRadius,0]],
    [[270,0,0],
      size.x-cornerRadius*2,
      [size.y/2+champherRadius,size.x/2-cornerRadius,0],
      [-size.x/2+cornerRadius,size.y/2-cornerRadius,0]]
    ];

  difference(){
    hull(){
      for (pos = postions){  
        translate(pos[3])
          cylinder(r=(cornerRadius+champherRadius), h=height);
      }
    }

    union(){  
      for (pos = postions){  
        rotate(pos[0][0])
        translate(pos[2])
        union(){
          translate([-cornerRadius-champherRadius, 0]) 
          rotate_extrude(angle=90, convexity=cornerRadius)
            translate([cornerRadius+champherRadius, 0]) 
            if(champher){
                chamferedSquare(champherRadius*2);
            } else {
              circle(champherRadius);
            }
             
          translate([0, eps, 0]) 
           rotate([90, 0, 0]) 
            if(champher){
              linear_extrude(height=pos[1]+eps*2)
                chamferedSquare(champherRadius*2);
            } else {
              cylinder(r=champherRadius, h=pos[1]+eps*2);
            }
        }    
      }
    }
  }
}

module chamferedSquare(size=0, radius = 0){
  assert(is_num(size), "size must be a number");
  assert(is_num(radius), "radius must be a number");
  radius = radius <= 0 ? size/4 : radius;
  hull()
  {
    translate([0,radius])
      circle(radius);
    translate([-radius,0])
      circle(radius);
    translate([0,-size/2])
      square([size/2,size]);
    translate([-size/2,-size/2])
      square([size,size/2]);
  }
}
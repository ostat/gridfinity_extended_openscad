include <ub.scad>

//Creates a rounded wall cutout to allow access to the items inside the gridfinity box.           
module WallCutout2(
  lowerWidth=50,
  wallAngle=70,
  height=21,
  thickness=10,
  cornerRadius=5,
  fn = 64){
  topHeight = cornerRadius;
  bottomWidth = lowerWidth/2-cornerRadius;
  topWidth = lowerWidth/2;
  
  fudgeFactor = 0.01;
  
  rotate([90,0,0])
  translate([0,topHeight,-thickness/2])
  union(){
  mirrors = [[0,0,0],[1,0,0]];
  colours = ["red","blue"];
  for(i = [0:1:len(mirrors)-1])
  {
    mirror(mirrors[i])
      color(colours[i])
      rotate([0,00,90])
      translate([0,bottomWidth-fudgeFactor,0])
      linear_extrude(thickness)
      SBogen(
        grad=wallAngle,
        extrude=-(height/2+topHeight),
        dist=height,
        r1=cornerRadius,
        r2=cornerRadius,
        l1=bottomWidth,
        l2=topWidth, $fn = fn);    
    }
  }
}

module bentWall(
  length=100,
  bendPosition=0,
  bendAngle=45,
  separation=10,
  lowerBendRadius=0,
  upperBendRadius=0,
  height=30,
  thickness=10,
  wall_cutout_depth = 0,
  wall_cutout_width = 0,
  fn = 64) {
  bendPosition = bendPosition > 0 ?bendPosition: length/2;
  
  fudgeFactor = 0.01;
  
  render()
  difference()
  {
    union(){
      if(separation != 0) { 
        translate([thickness/2,bendPosition,0])
        linear_extrude(height)
        SBogen(
          2D=thickness,
          dist=separation,
          //x0=true,
          grad=bendAngle,
          r1=lowerBendRadius <= 0 ? separation : lowerBendRadius,
          r2=upperBendRadius <= 0 ? separation : upperBendRadius,
          l1=bendPosition,
          l2=length-bendPosition, $fn = fn);   
      } else {
        cube([thickness, length, height]);
      }
    }

    cutoutHeight = 
      wall_cutout_depth <= -1 ? height/abs(wall_cutout_depth)
        : wall_cutout_depth;
    cutoutLength = 
      wall_cutout_width <= -1 ? length/abs(wall_cutout_depth)
        : wall_cutout_width == 0 ? length/2
        : wall_cutout_width;
    if(wall_cutout_depth != 0){
      translate([0,length/2,height])
      rotate([0,0,90])
      WallCutout(
        height = cutoutHeight,
        lowerWidth = cutoutLength,
        cornerRadius = cutoutHeight,
        thickness = (separation+thickness*2+fudgeFactor*2));
    }
  }
}

module WallCutout(
  lowerWidth=50,
  wallAngle=70,
  height=21,
  thickness=10,
  cornerRadius=5,
  fn = 64){
  topHeight = cornerRadius;
  bottomWidth = lowerWidth/2-cornerRadius;
  topWidth = lowerWidth/2;
  
  translate([0,thickness/2,thickness])
  rotate([90,90,0])
  linear_extrude(thickness)
  Vollwelle(
    r=[cornerRadius,cornerRadius],
    mitte=lowerWidth-cornerRadius*2,
    g2End=[1,1],
    grad=wallAngle,
    h=height,
    extrude=thickness,
    x0=-1,
    xCenter=-1);
}

//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
//topRadius = the radius of the top of the cube
//bottomRadius = the radius of the top of the cube
//sideRadius = the radius of the sides. This must be over 0.
//fn = overrides the #fn function for the corners
module roundedCube(
  x,
  y,
  z,
  size=[],
  cornerRadius = 0,
  topRadius = 0,
  bottomRadius = 0,
  sideRadius = 0,
  fn = 64)
{
  assert(is_list(size), "size must be a list");
  size = len(size) == 3 ? size : [x,y,z];
  
  topRadius = topRadius > 0 ? topRadius : cornerRadius;
  bottomRadius = bottomRadius > 0 ? bottomRadius : cornerRadius;
  sideRadius = sideRadius > 0 ? sideRadius : cornerRadius;
  
  if(sideRadius < topRadius || sideRadius < bottomRadius)
  {
    echo("roundedCube", "Error, sideRadius must be >= than bottomRadius and topRadius", sideRadius=sideRadius, topRadius=topRadius, bottomRadius=bottomRadius);
  }
    
  positions=[
     [sideRadius                    ,sideRadius                   ]
    ,[max(size.x-sideRadius, sideRadius) ,sideRadius                   ]
    ,[max(size.x-sideRadius, sideRadius) ,max(size.y-sideRadius, sideRadius)]
    ,[sideRadius                         ,max(size.y-sideRadius, sideRadius)]
    ];

  hull(){
    for (i =[0:1:len(positions)-1])
    {
      translate(positions[i]) 
        roundedCylinder(h=size.z,r=sideRadius,roundedr2=topRadius,roundedr1=bottomRadius,$fn=fn);
    }
  }
}

//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
//fn = overrides the #fn function for the corners
module roundedCubeV1(
  x,
  y,
  z,
  cornerRadius,
  fn = 64)
{
  positions=[
     [cornerRadius                      ,cornerRadius                      ,cornerRadius]
    ,[max(x-cornerRadius, cornerRadius) ,cornerRadius                      ,cornerRadius]
    ,[max(x-cornerRadius, cornerRadius) ,max(y-cornerRadius, cornerRadius) ,cornerRadius]
    ,[cornerRadius                      ,max(y-cornerRadius, cornerRadius) ,cornerRadius]
    ];

  hull(){
    for (x =[0:1:len(positions)-1])
    {
      translate(positions[x]) 
        sphere(cornerRadius, $fn=fn);
      translate(positions[x]) 
        cylinder(z-cornerRadius,r=cornerRadius, $fn=fn);
    }
  }
}

//create a negative rouneded corner that subtracted from a shape
//radius = the radius of the corner 
//length = the extrusion/length
//height = the distance past the corner.
module roundedCorner(
  radius = 10, 
  length, 
  height,
  fn=64)
{
  difference(){
    union(){
      //main corner to be removed
      translate([0,-radius, -radius])
        cube([length, radius*2,  radius*2]);
      //corner extention in y
      translate([0,0, -radius])
        cube([length, height, radius]);
      //corner extention in x
      translate([0,-radius, 0])
        cube([length, radius, height]);

    }
    translate([-1,radius, radius])
      rotate([90, 0, 90])
      cylinder(h = length+2, r=radius, $fn=fn);
  }  
}

//create a negative chamfer corner that subtracted from a shape
//chamferLength = the amount that will be subtracted from the 
//cornerRadius = the radius of the corners 
//length = the extrusion/length
//height = the distance past the corner.
module chamferedCorner(
  chamferLength = 10, 
  cornerRadius = 4, 
  length, 
  height,
  fn=64)
{
  difference(){
    union(){
      //main corner to be removed
      translate([0,-1, -1])
        cube([length, chamferLength+1,  chamferLength+1]);
      //corner extention in y
      translate([0,0, -chamferLength])
        cube([length, height, chamferLength]);
      //corner extention in x
      translate([0,-chamferLength, 0])
        cube([length, chamferLength, height]);

    }
    hull(){
      positions = [
        [-1,chamferLength, cornerRadius],
        [-1,cornerRadius, chamferLength],
        [-1,chamferLength, chamferLength]];
      for(i=[0:len(positions)-1])
      {
        translate(positions[i])
          rotate([90, 0, 90])
          cylinder(h = length+2, r=cornerRadius, $fn=fn);
      }
    }
  }        
}

//sequential bridging for hanging hole. 
//ref: https://hydraraptor.blogspot.com/2014/03/buried-nuts-and-hanging-holes.html
//ref: https://www.youtube.com/watch?v=KBuWcT8XkhA
module SequentialBridgingDoubleHole(
  outerHoleRadius = 0,
  outerHoleDepth = 0,
  innerHoleRadius = 0,
  innerHoleDepth = 0,
  overhangBridgeCount = 2,
  overhangBridgeThickness = 0.3,
  overhangBridgeCutin =0.05, //How far should the bridge cut in to the second smaller hole. This helps support the
  fn=64) 
{
  fudgeFactor = 0.01;
  
  hasOuter = outerHoleRadius > 0 && outerHoleDepth >0;
  hasInner = innerHoleRadius > 0 && innerHoleDepth > 0;
  overhangBridgeCount = hasOuter && hasInner ? overhangBridgeCount : 0;
  overhangBridgeHeight = overhangBridgeCount*overhangBridgeThickness;
  outerPlusBridgeHeight = hasOuter ? outerHoleDepth + overhangBridgeHeight : 0;
  if(hasOuter || hasInner)
  union(){
    difference(){
      if (hasOuter) {
        cylinder(r=outerHoleRadius, h=outerPlusBridgeHeight+fudgeFactor, $fn=fn);
      }
      
      if (overhangBridgeCount > 0) {
        for(i = [0:overhangBridgeCount-1]) 
          rotate([0,0,180/overhangBridgeCount*i])
          for(x = [0:1]) 
          rotate([0,0,180]*x)
            translate([-outerHoleRadius,innerHoleRadius-overhangBridgeCutin,outerHoleDepth+overhangBridgeThickness*i])
            cube([outerHoleRadius*2, outerHoleRadius, overhangBridgeThickness*overhangBridgeCount+fudgeFactor*2]);
              }
      }
      
      if (hasInner) {
        translate([0,0,outerPlusBridgeHeight])
        cylinder(r=innerHoleRadius, h=innerHoleDepth-outerPlusBridgeHeight, $fn=fn);
    }
  }
}

//sequential bridging for hanging hole. 
//ref: https://hydraraptor.blogspot.com/2014/03/buried-nuts-and-hanging-holes.html
//ref: https://www.youtube.com/watch?v=KBuWcT8XkhA
module SequentialBridgingDoubleHole_v1_old(
  outerHoleRadius = 0,
  outerHoleDepth = 0,
  innerHoleRadius = 0,
  innerHoleDepth = 0,
  overhangBridgeCount = 2,
  overhangBridgeThickness = 0.3,
  overhangBridgeCutin =0.05, //How far should the bridge cut in to the second smaller hole. This helps support the
  fn=64) 
{
  ff = 0.01;
  
  overhangBridgeHeight = overhangBridgeCount*overhangBridgeThickness;
  //render() //this wont improve render time, but will use less memory in the viewer. This matters here are there can be many holes (x*y*4) on the one render.
  union(){
  
    if (outerHoleRadius > 0) {
      cylinder(r=outerHoleRadius, h=outerHoleDepth+ff, $fn=fn);
    }
    
    if (innerHoleRadius > 0) {
      //if(outerHoleRadius <=0)
      translate([0,0,outerHoleDepth+overhangBridgeHeight-ff])
      cylinder(r=innerHoleRadius, h=innerHoleDepth-outerHoleDepth-overhangBridgeHeight, $fn=fn);
    }

    if (overhangBridgeCount>0) {
      translate([0,0,outerHoleDepth])
      intersection(){
        cylinder(r=outerHoleRadius, h=(overhangBridgeCount * overhangBridgeThickness), $fn=fn);
        
        for(i = [0:overhangBridgeCount-1]) {
          intersection_for(y = [0:i]) {
              echo("intersection_for", i=i, y=y);
              rotate([0,0,180/overhangBridgeCount*y])
              translate([-outerHoleRadius, -(innerHoleRadius-overhangBridgeCutin/2), overhangBridgeThickness*i-ff]) 
                cube([outerHoleRadius*2, innerHoleRadius*2-overhangBridgeCutin, overhangBridgeThickness+ff]);
          }
        }
      }
    }
  }
}

module roundedCylinder(h,r,roundedr=0,roundedr1=0,roundedr2=0)
{
  roundedr1 = roundedr1 > 0 ? roundedr1 : roundedr;
  roundedr2 = roundedr2 > 0 ? roundedr2 : roundedr;
  if(roundedr1 > 0 || roundedr2 > 0){
    hull(){
      if(roundedr1 > 0)
        roundedDisk(r,roundedr1,half=-1);
      else
        cylinder(r=r,h=h-roundedr2);
        
      if(roundedr2 > 0)
        translate([0,0,h-roundedr2*2]) 
          roundedDisk(r,roundedr2,half=1);
      else
        translate([0,0,roundedr1]) 
          cylinder(r=r,h=h-roundedr1);
    }
  }
  else {
    cylinder(r=r,h=h);
  }
}

module roundedDisk(r,roundedr, half=0){
 hull(){
    translate([0,0,roundedr]) 
    rotate_extrude() 
    translate([r-roundedr,0,0])
    difference(){
      circle(roundedr);
      //Remove inner half so we dont get error when r<roundedr*2
      translate([-roundedr*2,-roundedr,0])
      square(roundedr*2);
      
      if(half<0){
        //Remove top half
        translate([-roundedr,0,0])
        square(roundedr*2);   
      }
      if(half>0){
        //Remove bottom half
        translate([-roundedr,-roundedr*2,0])
        square(roundedr*2);   
      }
    }
  }
}

module tz(z) {
  translate([0, 0, z]) children();
}
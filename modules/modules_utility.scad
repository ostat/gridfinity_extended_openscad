include <ub.scad>

fudgeFactor = 0.01;
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
//fn = overrides the #fn function for the corners
module roundedCube(
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
        cylinder(z,r=cornerRadius, $fn=fn);
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
  render(){
    difference(){
      union(){
        //main corner to be removed
        translate([0,-1, -1])
          cube([length, radius+1,  radius+1]);
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
}

//create a negative champher corner that subtracted from a shape
//champherLength = the amount that will be subtracted from the 
//cornerRadius = the radius of the corners 
//length = the extrusion/length
//height = the distance past the corner.
module champheredCorner(
  champherLength = 10, 
  cornerRadius = 4, 
  length, 
  height,
  fn=64)
{
  difference(){
    union(){
      //main corner to be removed
      translate([0,-1, -1])
        cube([length, champherLength+1,  champherLength+1]);
      //corner extention in y
      translate([0,0, -champherLength])
        cube([length, height, champherLength]);
      //corner extention in x
      translate([0,-champherLength, 0])
        cube([length, champherLength, height]);

    }
    hull(){
      positions = [
        [-1,champherLength, cornerRadius],
        [-1,cornerRadius, champherLength],
        [-1,champherLength, champherLength]];
      for(i=[0:len(positions)-1])
      {
        echo(i=i, positions[i]);
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
  ff = 0.01;
  overhangBridgeHeight = overhangBridgeCount*overhangBridgeThickness;
  render() //this wont improve render time, but will use less memory in the viewer. This matters here are there can be many holes (x*y*4) on the one render.
  union(){
    if (outerHoleRadius > 0) {
      cylinder(r=outerHoleRadius, h=outerHoleDepth, $fn=fn);
    }

    if (overhangBridgeCount>0) {
      translate([0,0,outerHoleDepth])
      intersection(){
        cylinder(r=outerHoleRadius, h=(overhangBridgeCount * overhangBridgeThickness), $fn=fn);
        
        for(i = [0:overhangBridgeCount-1]) {
          intersection_for(y = [0:i]) {
              rotate([0,0,180/overhangBridgeCount*y])
              translate([-outerHoleRadius, -(innerHoleRadius-overhangBridgeCutin/2), overhangBridgeThickness*i-ff]) 
                cube([outerHoleRadius*2, innerHoleRadius*2-overhangBridgeCutin, overhangBridgeThickness+ff]);
          }
        }
      }
    }

    if (innerHoleRadius > 0) {
      translate([0,0,outerHoleDepth+overhangBridgeHeight])
      cylinder(r=innerHoleRadius, h=innerHoleDepth-outerHoleDepth-overhangBridgeHeight, $fn=fn);
    }
  }
}
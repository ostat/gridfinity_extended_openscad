include <thridparty/ub_sbogen.scad>
include <module_utility_wallcutout.scad>

utility_demo = false;

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
  wall_cutout_width = 0) {
  bendPosition = bendPosition > 0 ?bendPosition: length/2;
  
  fudgeFactor = 0.01;
  
  //#render()
  difference()
  {
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
        l2=length-bendPosition);   
    } else {
      cube([thickness, length, height]);
   }
   
    cutoutHeight = 
      wall_cutout_depth <= -1 ? height/abs(wall_cutout_depth)
        : wall_cutout_depth;
    cutoutLength = 
      wall_cutout_width <= -1 ? length/abs(wall_cutout_depth)
        : wall_cutout_width == 0 ? length/2
        : wall_cutout_width;
    if(wall_cutout_depth != 0){
      translate([thickness/2,length/2,height])
      rotate([0,0,90])
      WallCutout(
        height = cutoutHeight,
        lowerWidth = cutoutLength,
        cornerRadius = cutoutHeight,
        thickness = (separation+thickness+fudgeFactor*2),
        topHeight = 1);
    }
   }
 }

//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
//topRadius = the radius of the top of the cube
//bottomRadius = the radius of the top of the cube
//sideRadius = the radius of the sides. This must be over 0.
module roundedCube(
  x,
  y,
  z,
  size=[],
  cornerRadius = 0,
  topRadius = 0,
  bottomRadius = 0,
  sideRadius = 0 ,
  centerxy = false,
  supportReduction_x = [0,0],
  supportReduction_y = [0,0],
  supportReduction_z = [0,0])
{
  minSideRadius = 0.01;
  assert(is_list(size), "size must be a list");
  size = len(size) == 3 ? size : [x,y,z];
  
  topRadius = topRadius > 0 ? topRadius : cornerRadius;
  bottomRadius = bottomRadius > 0 ? bottomRadius : cornerRadius;
  sideRadius = max(minSideRadius, sideRadius > 0 ? sideRadius : cornerRadius);
  
  assert(topRadius <= sideRadius, str("topRadius must be less than or equal to sideRadius. topRadius:", topRadius, " sideRadius:", sideRadius));
  assert(bottomRadius <= sideRadius, str("bottomRadius must be less than or equal to sideRadius. bottomRadius:", bottomRadius, " sideRadius:", sideRadius));

  //Support reduction should move in to roundedCylinder
  function auto_support_reduction(supportReduction, radius) = 
    supportReduction == -1 ? radius/2 : supportReduction;

  supportReduction_z = 
    let(srz_temp = is_num(supportReduction_z) ? [supportReduction_z,supportReduction_z] : supportReduction_z,
        srz = [auto_support_reduction(srz_temp[0], bottomRadius), auto_support_reduction(srz_temp[1], topRadius)]) 
      [min(srz[0], sideRadius),min(srz[1], sideRadius)];
  supportReduction_x = 
    let(srx_temp = is_num(supportReduction_x) ? [supportReduction_x,supportReduction_x] : supportReduction_x,
        srx = [auto_support_reduction(srx_temp[0], sideRadius), auto_support_reduction(srx_temp[1], sideRadius)])  
      [min(srx[0], sideRadius),min(srx[1], sideRadius)];
  supportReduction_y = 
    let(sry_temp = is_num(supportReduction_y) ? [supportReduction_y,supportReduction_y] : supportReduction_y,
        sry = [auto_support_reduction(sry_temp[0], sideRadius), auto_support_reduction(sry_temp[1], sideRadius)])   
      [min(sry[0], sideRadius),min(sry[1], sideRadius)];
      
  //assert(sideRadius < topRadius || sideRadius < bottomRadius, "sideRadius must be >= than bottomRadius and topRadius");
  if(env_help_enabled("trace")) echo("roundedCube", supportReduction_x=supportReduction_x, supportReduction_y=supportReduction_y, supportReduction_z=supportReduction_z);
  positions=[
     [[sideRadius                         ,sideRadius],                        [0,0]]
    ,[[max(size.x-sideRadius, sideRadius) ,sideRadius]                        ,[1,0]]
    ,[[max(size.x-sideRadius, sideRadius) ,max(size.y-sideRadius, sideRadius)],[1,1]]
    ,[[sideRadius                         ,max(size.y-sideRadius, sideRadius)],[0,1]]
    ];
    
  translate(centerxy ? [-size.x/2,-size.y/2,0] : [0,0,0])
  hull(){
    for (i =[0:1:len(positions)-1])
    {
      translate(positions[i][0]) 
        union(){
        roundedCylinder(h=size.z,r=sideRadius,roundedr2=topRadius,roundedr1=bottomRadius);
        if(supportReduction_z[1] > 0)
          translate([0,0,size.z-topRadius])
          cylinder(h=topRadius, r=supportReduction_z[1]);

        if(supportReduction_z[0] > 0)
          cylinder(h=bottomRadius, r=supportReduction_z[0]);
        
        if(supportReduction_x[0] > 0 && positions[i][1].x ==0){
          if(topRadius ==0 && bottomRadius == 0)
          {
            translate([0,0,size.z/2])
            cube(size=[sideRadius*2,supportReduction_x[0]*2,size.z],center=true);
          } else {
            translate([0,0,sideRadius])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supportReduction_x[0],center=true);
            translate([0,0,size.z-sideRadius])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supportReduction_x[0],center=true);
          }
        }
        
        if(supportReduction_x[1] > 0 && positions[i][1].x ==1){
         if(topRadius ==0 && bottomRadius == 0)
         {
            translate([0,0,size.z/2])
            cube(size=[sideRadius*2,supportReduction_x[1]*2,size.z],center=true);
          } else {
            translate([0,0,sideRadius])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supportReduction_x[1],center=true);
            translate([0,0,size.z-sideRadius])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supportReduction_x[1],center=true);
          }
        }
        
        if(supportReduction_y[0] > 0 && positions[i][1].y == 0){
            translate([0,0,sideRadius])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supportReduction_y[0],center=true);
            translate([0,0,size.z-sideRadius])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supportReduction_y[0],center=true);
        }
        if(supportReduction_y[1] > 0 && positions[i][1].y == 1){
            translate([0,0,sideRadius])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supportReduction_y[1], center=true);
            translate([0,0,size.z-sideRadius])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supportReduction_y[1], center=true);
        }
      }
    }
  }
}

//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
module roundedCubeV1(
  x,
  y,
  z,
  cornerRadius)
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
        sphere(cornerRadius);
      translate(positions[x]) 
        cylinder(z-cornerRadius,r=cornerRadius);
    }
  }
}

if(utility_demo){

roundedCorner(
  radius = 10, 
  length = 100, 
  height = 25,
  $fn=128); 
}
//create a negative rouneded corner that subtracted from a shape
//radius = the radius of the corner 
//length = the extrusion/length
//height = the distance past the corner.
module roundedCorner(
  radius = 10, 
  length, 
  height)
{
  assert(is_num(length), "length must be a number");
  assert(is_num(height), "height must be a number");
  assert(is_num(radius), "radius must be a number");
  difference(){
    union(){
      //main corner to be removed
      translate([0,-radius, -radius])
        cube([length, radius*2,  radius*2]);
      //corner extension in y
      translate([0,0, -radius])
        cube([length, height, radius]);
      //corner extension in x
      translate([0,-radius, 0])
        cube([length, radius, height]);
    }
    translate([-1,radius, radius])
      rotate([90, 0, 90])
      cylinder(h = length+2, r=radius);
  }  
}

if(utility_demo){
  
translate([0,50,0])
chamferedCorner(
  chamferLength = 10, 
  cornerRadius = 4, 
  length=100, 
  height=25,
  width = 20,
  $fn=128);
}
  
//create a negative chamfer corner that subtracted from a shape
//chamferLength = the amount that will be subtracted from the 
//cornerRadius = the radius of the corners 
//length = the extrusion/length
//height = the distance past the corner
module chamferedCorner(
  chamferLength = 10, 
  cornerRadius = 4, 
  length, 
  height,
  width = 0,
  angled_extension = false)
{
  fudgeFactor = 0.01;
  width = width>0 ? width : chamferLength;
 
  difference(){
    union(){
      //main corner to be removed
      translate([0,-width, -width])
        cube([length, chamferLength+width,  chamferLength+width]);
      //corner extension in y
      translate([0,chamferLength-fudgeFactor, -width])
        rotate_around_point(point=[0,0,width], rotation=angled_extension ? [-45,0,0] : [0,0,0])
        cube([length, height-chamferLength, width]);
      //corner extension in x
      translate([0,-width, chamferLength-fudgeFactor])
        rotate_around_point(point=[0,width,0], rotation=angled_extension ? [45,0,0] : [0,0,0])
        cube([length, width, height-chamferLength]);

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
          cylinder(h = length+2, r=cornerRadius);
      }
    }
  }        
}

module rotate_around_point(point=[], rotation=[]){
  translate(point)
  rotate(rotation)
  translate(-point)
  children();
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
  overhangBridgeCutin =0.05 //How far should the bridge cut in to the second smaller hole. This helps support the
  ) 
{
  fudgeFactor = 0.01;
  
  hasOuter = outerHoleRadius > 0 && outerHoleDepth >0;
  hasInner = innerHoleRadius > 0 && innerHoleDepth > 0;
  bridgeRequired = hasOuter && hasInner && outerHoleRadius > innerHoleRadius && innerHoleDepth > outerHoleDepth;
  overhangBridgeCount = bridgeRequired ? overhangBridgeCount : 0;
  overhangBridgeHeight = overhangBridgeCount*overhangBridgeThickness;
  outerPlusBridgeHeight = hasOuter ? outerHoleDepth + overhangBridgeHeight : 0;
  if(hasOuter || hasInner)
  union(){
    difference(){
      if (hasOuter) {
        cylinder(r=outerHoleRadius, h=outerPlusBridgeHeight+fudgeFactor);
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
        cylinder(r=innerHoleRadius, h=innerHoleDepth-outerPlusBridgeHeight);
    }
  }
}

//Creates a cube with a single rounded corner.
//Centered around the rounded corner
module CubeWithRoundedCorner(
  size=[10,10,10], 
  cornerRadius = 2, 
  edgeRadius = 0,
  center=false){
  assert(is_list(size) && len(size)==3, "size should be a list of size 3");
  assert(is_num(cornerRadius) && cornerRadius >= 0, "cornerRadius should be a number greater than 0");
  assert(is_num(edgeRadius), "edgeRadius should be a number");
  
  fudgeFactor = 0.01;
  
  translate(center ? -size/2 : [0,0,0])
  if(edgeRadius <=0) {
    hull(){
      translate([cornerRadius,cornerRadius,0])
      cylinder(r=cornerRadius, h=size.z+fudgeFactor);
      translate([cornerRadius,0,0])
        cube([size.x-cornerRadius,size.y,size.z+fudgeFactor]);
      translate([0,cornerRadius,0])
        cube([size.x,size.y-cornerRadius,size.z+fudgeFactor]);
    }
  }
  else{
    hull(){
      translate([cornerRadius,cornerRadius,0])
      roundedCylinder(h=size.z+fudgeFactor,r=cornerRadius,roundedr2=edgeRadius);
      
      translate([(size.x+cornerRadius)/2,size.y/2,size.z/2])
      rotate([0,90,0])
      CubeWithRoundedCorner(
        size=[size.z,size.y,size.x-cornerRadius], 
        cornerRadius = edgeRadius,
        edgeRadius=0,
        center=true);
        
      translate([size.x/2,(size.y+cornerRadius)/2,size.z/2])
      rotate([0,90,270])
      CubeWithRoundedCorner(
        size=[size.z,size.y,size.x-cornerRadius], 
        cornerRadius = edgeRadius,
        edgeRadius=0,
        center=true);        
    }
  }
}

module MagnetAndScrewRecess(
  magnetDiameter = 10,
  magnetThickness = 2,
  screwDiameter = 2,
  screwDepth = 6,
  overhangFixLayers = 3,
  overhangFixDepth = 0.2,
  easyMagnetRelease = true){
    fudgeFactor = 0.01;
    
    releaseWidth = 1.3;
    releaseLength = 1.5;
    
    union(){
      SequentialBridgingDoubleHole(
        outerHoleRadius = magnetDiameter/2,
        outerHoleDepth = magnetThickness,
        innerHoleRadius = screwDiameter/2,
        innerHoleDepth = screwDepth > 0 ? screwDepth+fudgeFactor : 0,
        overhangBridgeCount = overhangFixLayers,
        overhangBridgeThickness = overhangFixDepth);
      
      if(easyMagnetRelease && magnetDiameter > 0)
      difference(){
        hull(){
          translate([0,-releaseWidth/2,0])  
            cube([magnetDiameter/2+releaseLength,releaseWidth,magnetThickness]);
          translate([magnetDiameter/2+releaseLength,0,0])  
            cylinder(d=releaseWidth, h=magnetThickness);
        }
        champherRadius = min(magnetThickness, releaseLength+releaseWidth/2);
        
        totalReleaseLength = magnetDiameter/2+releaseLength+releaseWidth/2;
        
        translate([totalReleaseLength,-releaseWidth/2-fudgeFactor,magnetThickness])
        rotate([270,0,90])
        roundedCorner(
          radius = champherRadius, 
          length = releaseWidth+2*fudgeFactor, 
          height = totalReleaseLength);
      }
    };
}


module roundedCylinder(h,r,roundedr=0,roundedr1=0,roundedr2=0)
{
  assert(is_num(h), "h must have a value");
  assert(is_num(r), "r must have a value");
  roundedr1 = roundedr1 > 0 ? roundedr1 : roundedr;
  roundedr2 = roundedr2 > 0 ? roundedr2 : roundedr;
  
  assert(is_num(roundedr1), "roundedr1 or roundedr must have a value");
  assert(is_num(roundedr2), "roundedr2 or roundedr must have a value");
  
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
//rounded_taper();
module rounded_taper(
  upperRadius=35,
  upperLength=20,
  lowerRadius=10,
  lowerLength=20,
  transitionLength=10,
  cornerRadius=0,
  roundedUpper=false,
  roundedLower=false,
  alignTop = false) {
 
  bottomWidth = lowerRadius*2;
  //topWidth = lowerWidth+(height/tan(wallAngle))*2;
  topWidth = upperRadius*2;
  height = upperLength+transitionLength+lowerLength;
  
  translate([0,0,alignTop?-height:0])
  rotate_extrude(angle=360, convexity=10)
  intersection(){
    square([topWidth,height]);
    
    //Use triple offset to fillet corners
    //https://www.reddit.com/r/openscad/comments/ut1n7t/quick_tip_simple_fillet_for_2d_shapes/
    offset(r=-cornerRadius)
    offset(r=2 * cornerRadius)
    offset(r=-cornerRadius)
    union(){
      hull(){
        //upper
        translate([-topWidth/2,lowerLength+transitionLength])
          square([topWidth,upperLength+(roundedUpper?0:cornerRadius)]);
        //transition
        translate([-bottomWidth/2,lowerLength])
          square([bottomWidth,transitionLength]);
      }
      //lower
      translate([-bottomWidth/2,roundedLower?0:-cornerRadius])
      square([bottomWidth,lowerLength+(roundedLower?0:cornerRadius)]);
    }
  }
}
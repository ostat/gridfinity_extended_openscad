// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/gridfinity_modules.scad>

/* [Plate] */
// Plate Style
Plate_Style = "base"; //[base:Base plate, lid:Lid that is also a gridfinity base]
Base_Plate_Options = "default";//[default:Default, magnet:Efficient magnet base, weighted:Weighted base, woodscrew:Woodscrew]
Lid_Options = "default";//[default, flat:Flat Removes the internal grid from base, halfpitch: halfpitch base, efficient]

Lid_Include_Magnets = true;
// Base height, when the bin on top will sit, in GF units
Lid_Efficient_Base_Height = 0.4;// [0.4:0.1:1]
// Thickness of the efficient floor
Lid_Efficient_Floor_Thickness = 0.7;// [0.7:0.1:7]

/* [Base Plate Clips - POC dont use yet]*/
//This feature is not yet finalised, or working properly. 
Butterfly_Clip_Enabled = false;
Butterfly_Clip_Size = [6,6,1.5];
Butterfly_Clip_Radius = 0.1;
Butterfly_Clip_Tollerance = 0.1;
Butterfly_Clip_Only = false;

//This feature is not yet finalised, or working properly. 
Filament_Clip_Enabled = false;
Filament_Clip_Diameter = 2;
Filament_Clip_Length = 8;

/* [Size] */
// X dimension in grid units  (multiples of 42mm)
Width = 2; // [ 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Y dimension in grid units (multiples of 42mm)
Depth = 1; // [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
//Enable custom grid, you will configure this in the (Lid not supported)
Custom_Grid_Enabled = false;
//I am not sure it this is really usefull, but its possible, so here we are.
//0:off the cell is off
//1:on the cell is on and all corners are rounded
//2-16, are bitwise values used to calculate what corners should be rounded, you need to subtract 2 from the value for the bitwise logic (so it does not clash with 0 and 1).
xpos1 = [3,4,0,0,3,4,0];
xpos2 = [2,2,0,0,2,2,0];
xpos3 = [2,2,0,0,2,2,0];
xpos4 = [2,2,2,2,2,2,0];
xpos5 = [6,2,2,2,2,10,0];
xpos6 = [0,0,0,0,0,0,0];
xpos7 = [0,0,0,0,0,0,0];


/* [debug] */
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// enable loging of help messages during render.
help = false;

module end_of_customizer_opts() {}

/*constants */
magnet_od = 6.5;
magnet_thickness = 2.4;

if(Butterfly_Clip_Only)
{
  ButterFly(
    size=[
      Butterfly_Clip_Size.x+Butterfly_Clip_Tollerance,
      Butterfly_Clip_Size.y+Butterfly_Clip_Tollerance,
      Butterfly_Clip_Size.z],
    r=Butterfly_Clip_Radius);
}
else{
  gridfinity_baseplate(
      width = Width,
      depth = Depth,
      plateStyle = Plate_Style,
      plateOptions = Base_Plate_Options,
      lidOptions = Lid_Options,
      customGridEnabled = Custom_Grid_Enabled,
      gridPossitions=[xpos1,xpos2,xpos3,xpos4,xpos5,xpos6,xpos7],
      butterflyClipEnabled  = Butterfly_Clip_Enabled,
      butterflyClipSize = Butterfly_Clip_Size,
      butterflyClipRadius = Butterfly_Clip_Radius,
      filamentClipEnabled=Filament_Clip_Enabled,
      filamentClipDiameter=Filament_Clip_Diameter,
      filamentClipLength=Filament_Clip_Length,
      lidIncludeMagnets = Lid_Include_Magnets,
      lidEfficientFloorThickness = Lid_Efficient_Floor_Thickness,
      lidEfficientBaseHeight = Lid_Efficient_Base_Height,
      cutx = cutx,
      cuty = cuty,
      help = help);
}

function bitwise_and
   (v1, v2, bv = 1 ) = 
      ((v1 + v2) == 0) ? 0
     : (((v1 % 2) > 0) && ((v2 % 2) > 0)) ?
       bitwise_and(floor(v1/2), floor(v2/2), bv*2) + bv
     : bitwise_and(floor(v1/2), floor(v2/2), bv*2);
     
function decimaltobitwise
   (v1, v2) = 
      v1==0 && v2 == 0 ? 1 : 
      v1==0 && v2 == 1 ? 2 :
      v1==1 && v2 == 0 ? 4 :
      v1==1 && v2 == 1 ? 8 : 0;  
      
module gridfinity_baseplate(
  width = 2,
  depth = 1,
  plateStyle = "base",
  plateOptions = "default",
  lidOptions = "default",
  customGridEnabled = false,
  gridPossitions = [[1]],
  butterflyClipEnabled  = Butterfly_Clip_Enabled,
  butterflyClipSize = Butterfly_Clip_Size,
  butterflyClipRadius = Butterfly_Clip_Radius,
  filamentClipEnabled = Filament_Clip_Enabled,
  filamentClipDiameter = Filament_Clip_Diameter,
  filamentClipLength = Filament_Clip_Length,
  lidIncludeMagnets = Lid_Include_Magnets,
  lidEfficientFloorThickness = Lid_Efficient_Floor_Thickness,
  lidEfficientBaseHeight = Lid_Efficient_Base_Height,
  cutx = false,
  cuty = false,
  help = false)
{
  _gridPossitions = customGridEnabled ? gridPossitions : [[1]];
  
  difference() {
    union() {
      for(xi = [0:len(_gridPossitions)-1])
        for(yi = [0:len(_gridPossitions[xi])-1])
        {
          if(_gridPossitions[xi][yi])
          {
            translate([gf_pitch*xi,gf_pitch*yi,0])
            baseplate(
              width = customGridEnabled ? 1 : width,
              depth = customGridEnabled ? 1 : depth,
              plateStyle = plateStyle,
              plateOptions= plateOptions,
              lidOptions = lidOptions,
              butterflyClipEnabled  = butterflyClipEnabled,
              butterflyClipSize = butterflyClipSize,
              butterflyClipRadius = butterflyClipRadius,
              filamentClipEnabled = filamentClipEnabled,
              filamentClipDiameter = filamentClipDiameter,
              filamentClipLength = filamentClipLength,
              roundedCorners = _gridPossitions[xi][yi] == 1 ? 15 : _gridPossitions[xi][yi] - 2,
              lidIncludeMagnets = lidIncludeMagnets,
              lidEfficientFloorThickness = lidEfficientFloorThickness,
              lidEfficientBaseHeight = lidEfficientBaseHeight,
              help = help);
          }
        }
      }
    /*
    if(cutx && $preview){
      translate([-gf_pitch,-gf_pitch,-fudgeFactor])
        cube([(width+1)*gf_pitch,gf_pitch,2*gf_zpitch]);
    }
    if(cuty && $preview){
      translate([-gf_pitch*0.75,-gf_pitch,-fudgeFactor])
        cube([gf_pitch,(depth+1)*gf_pitch,2*gf_zpitch]);
    } */
    
    if(cutx > 0 && $preview){
      color(color_cut)
      translate([-gf_pitch*0.5,-gf_pitch*0.5,-fudgeFactor])
        cube([gf_pitch*cutx,(depth+1)*gf_pitch,2*gf_zpitch]);
    }
    if(cuty > 0 && $preview){
      color(color_cut)
      translate([-gf_pitch*0.5,-gf_pitch*0.5,-fudgeFactor])
        cube([(width+1)*gf_pitch,gf_pitch*cuty,2*gf_zpitch]);
    }
  }
}
    
module baseplate(
  width = 2,
  depth = 1,
  plateStyle = "base",
  plateOptions = "default",
  lidOptions = "default",
  roundedCorners = 15,
  butterflyClipEnabled  = butterflyClipEnabled,
  butterflyClipSize = butterflyClipSize,
  butterflyClipRadius = butterflyClipRadius,
  filamentClipEnabled = filamentClipEnabled,
  filamentClipDiameter = filamentClipDiameter,
  filamentClipLength = filamentClipLength,
  lidIncludeMagnets = true,
  lidEfficientFloorThickness = 0.7,
  lidEfficientBaseHeight = 0.4,
  help = false)
{
  difference(){
    union(){
      if (plateStyle == "lid") {
        base_lid(width, depth, lidOptions, 
          lidIncludeMagnets = lidIncludeMagnets, 
          lidEfficientFloorThickness = lidEfficientFloorThickness, 
          lidEfficientBaseHeight = lidEfficientBaseHeight);
      }
      else if (plateOptions == "weighted") {
        weighted_baseplate(width, depth, roundedCorners=roundedCorners);
      }
      else if (plateOptions == "woodscrew") {
        woodscrew_baseplate(width, depth, roundedCorners=roundedCorners);
      }
      else if (plateOptions == "magnet"){
        magnet_baseplate(width, depth, roundedCorners=roundedCorners);
      }
      else {
        frame_plain(width, depth, trim=0, roundedCorners=roundedCorners);
      }
    }
    
    if(butterflyClipEnabled || filamentClipEnabled){
      gridcopy(width, depth) 
      union(){
        echo("frame_plain", gci=$gci);
        if(butterflyClipEnabled)
          AttachButterFly(size=butterflyClipSize,r=butterflyClipRadius,left=$gci.x==0,right=$gci.x==width-1,front=$gci.y==0,back=$gci.y==depth-1);
          
        if(filamentClipEnabled)
          AttachFilament(l=filamentClipLength,d=filamentClipDiameter,left=$gci.x==0,right=$gci.x==width-1,front=$gci.y==0,back=$gci.y==depth-1);
      }
    }
  }
}

module base_lid(
  num_x, num_y, 
  lidOptions = "default",
  lidIncludeMagnets = true,
  lidEfficientFloorThickness = 0.7,
  lidEfficientBaseHeight = 0.4) 
{
  magnet_position = min(gf_pitch/2-8, gf_pitch/2-4-magnet_od/2);
  eps = 0.1;
  
  flat_base = lidOptions == "flat";
  half_pitch = lidOptions == "halfpitch";
  efficient_base = lidOptions == "efficient";
  
  fn = 44;
  height = flat_base ? 0.6 : 
            efficient_base ? lidEfficientBaseHeight : 1;
  if(!efficient_base)
  {
    translate([0, 0, (gf_zpitch*height)]) 
      frame_plain(
        num_x, num_y, 
        trim=0.25,
        baseTaper = gf_cup_corner_radius/2,
        fn = fn);
  }
  difference() {
    grid_block(
      num_x, 
      num_y, 
      efficient_base ? lidEfficientBaseHeight+0.6 : height, 
      magnet_diameter=0, 
      screw_depth=0, 
      flat_base=flat_base,
      half_pitch=half_pitch, 
      fn = fn);
    
    if(lidOptions == "efficient")
    {
      translate([-gf_pitch/2,-gf_pitch/2,(lidEfficientBaseHeight+0.6)*gf_zpitch])
        cube([gf_pitch*num_x,gf_pitch*num_y,gf_zpitch]);
      
    }
    
    union(){
      translate([0, 0, (gf_zpitch*height)]) 
        color(color_topcavity)
        translate([0, 0, -fudgeFactor]) 
          gridcopy(num_x, num_y) 
          pad_oversize(margins=1);
 
      //efficient
      lowerDia = 1;
      upperDia = 2.3;
      lowerTaperHeight = (upperDia-lowerDia)/2;
      
      gridcopy(num_x, num_y) 
        hull(){
          cornercopy(17) {
            translate([0, 0, lidEfficientFloorThickness+lowerTaperHeight])
              cylinder(d=upperDia, h=gf_zpitch, $fn=32);
            translate([0, 0, lidEfficientFloorThickness])
              cylinder(d1=lowerDia,d2=upperDia, h=lowerTaperHeight, $fn=32);
         }
       }
   }

   
   
    if(lidIncludeMagnets)
      gridcopy(num_x, num_y) 
        cornercopy(magnet_position) 
          translate([0, 0, (gf_zpitch*height)-magnet_thickness])
          cylinder(d=magnet_od, h=magnet_thickness+eps, $fn=32);
  }
}

module woodscrew_baseplate(
  num_x, 
  num_y,  
  cornerRadius = gf_cup_corner_radius,
  roundedCorners = 15) {
  magnet_position = min(gf_pitch/2-8, gf_pitch/2-4-magnet_od/2);
  eps = 0.1;
  frameHeight = 6.4;
  
  translate([0,0,frameHeight])
  difference() {
    frame_plain(num_x, num_y, 
      extra_down=frameHeight,
      cornerRadius = cornerRadius,
      roundedCorners = roundedCorners);
    
    gridcopy(num_x, num_y) {
      cornercopy(magnet_position) {
        translate([0, 0, -magnet_thickness])
        cylinder(d=magnet_od, h=magnet_thickness+eps, $fn=48);
        
        translate([0, 0, -frameHeight]) cylinder(d=3.5, h=frameHeight, $fn=24);
        
        // counter-sunk holes in the bottom
        translate([0, 0, -frameHeight -fudgeFactor]) cylinder(d1=8.5, d2=3.5, h=2.5, $fn=24);
      }
      
      //counter-sunk holes for woodscrews
      translate([0, 0, -2.5]) cylinder(d1=3.5, d2=8.5, h=2.5, $fn=24);
      translate([0, 0, -frameHeight -fudgeFactor]) cylinder(d=3.5, h=frameHeight, $fn=24);
    }
  }
}
module weighted_baseplate(
  num_x, 
  num_y,
  cornerRadius = gf_cup_corner_radius,
  roundedCorners = 15) {
  
  magnet_position = min(gf_pitch/2-8, gf_pitch/2-4-magnet_od/2);
  eps = 0.1;
  frameHeight = 6.4;

  difference() {
    translate([0, 0, frameHeight])
      frame_plain(num_x, num_y, 
        extra_down=frameHeight,
        cornerRadius = cornerRadius,
        roundedCorners = roundedCorners);
    
    gridcopy(num_x, num_y) {
      cornercopy(magnet_position) {
        translate([0, 0, frameHeight-magnet_thickness])
        cylinder(d=magnet_od, h=magnet_thickness+eps, $fn=48);
        
        cylinder(d=3.5, h=frameHeight, $fn=24);
        
        // counter-sunk holes in the bottom
        translate([0, 0, -fudgeFactor]) 
          cylinder(d1=8.5, d2=3.5, h=2.5, $fn=24);
      }
      
      translate([-10.7, -10.7, -fudgeFactor]) 
        cube([21.4, 21.4, 4.01]);
      
      for (a2=[0,90]) {
        rotate([0, 0, a2])
        hull() 
          for (a=[0, 180]) rotate([0, 0, a]) {
            translate([-14.9519, 0, -fudgeFactor])
              cylinder(d=8.5, h=2.01, $fn=24);
          }
      }
    }
  }
}

module magnet_baseplate(
  num_x, 
  num_y,
  cornerRadius = gf_cup_corner_radius,
  roundedCorners = 15) {
  
  magnet_position = min(gf_pitch/2-8, gf_pitch/2-4-magnet_od/2);
  frameHeight = magnet_thickness;
  magnetborder = 5;
  
  difference() {
    translate([0, 0, frameHeight])
      frame_plain(num_x, num_y, 
        extra_down=frameHeight,
        cornerRadius = cornerRadius,
        roundedCorners = roundedCorners);
    
    gridcopy(num_x, num_y) {
      cornercopy(magnet_position) {
        translate([0, 0, -fudgeFactor])
         cylinder(d=magnet_od, h=magnet_thickness+fudgeFactor*2, $fn=48);
      }
      
      cubeSize = gf_pitch-magnet_position+magnet_od;
      
      difference(){
      translate([-cubeSize/2, -cubeSize/2, -fudgeFactor]) 
        cube([cubeSize, cubeSize, magnet_thickness+fudgeFactor*2]);
        union(){
          for(xi = [-1:2:1]){
            for(yi = [-1:2:1]){
              translate([xi*magnet_position, yi*magnet_position, -fudgeFactor*2]) 
                cylinder(d=magnet_od+magnetborder, h=magnet_thickness+fudgeFactor*4, $fn=48);

              translate([xi*(magnet_position+magnet_od/2), yi*(magnet_position-magnetborder/2+magnet_od/2), -fudgeFactor*2]) 
                cube([magnet_od,magnet_od*2,magnet_od],center = true);

              translate([xi*(magnet_position-magnetborder/2), yi*(magnet_position+magnet_od/2), -fudgeFactor*2]) 
                cube(magnet_od,center = true);
              }
            }
          }
        }
    }
  }
}

module frame_plain(
    num_x, 
    num_y, 
    extra_down=0, 
    trim=0, 
    baseTaper = 0, 
    height = 4,
    cornerRadius = gf_cup_corner_radius,
    roundedCorners = 15,
    fn = 44) {
  ht = extra_down > 0 ? height -0.6 : height;

  corner_position = gf_pitch/2-cornerRadius-trim;
  
  difference() {
    color(color_cup)
    hull() 
      //render()
      cornercopy(corner_position, num_x, num_y) {
        radius = bitwise_and(roundedCorners, decimaltobitwise($idx[0],$idx[1])) > 0 ? cornerRadius : 0.01;// 0.01 is almost zero....
        ctrn = [
          ($idx[0] == 0 ? -1 : 1)*(cornerRadius-radius), 
          ($idx[1] == 0 ? -1 : 1)*(cornerRadius-radius), -extra_down];
        translate(ctrn)
        union(){
          translate([0, 0, baseTaper])
            cylinder(r=radius, h=ht+extra_down-baseTaper, $fn=fn);
          cylinder(r2=radius,r1=baseTaper, h=baseTaper+fudgeFactor, $fn=fn);
        }
      }
    color(color_topcavity)
    translate([0, 0, -fudgeFactor]) 
      gridcopy(num_x, num_y) 
      pad_oversize(margins=1);
  }
}

module AttachFilament(l=5, d=1.75,left= true, right=true, front=true, back=true){
 h=4;
  positions = [
    //left
    [left,[-gf_pitch/2,0, h],[0,90,0]],
    //right
    [right,[gf_pitch/2,0, h],[0,90,0]],
    //front
    [front,[0, -gf_pitch/2,h],[90,0,0]],
    //back
    [back,[0, gf_pitch/2,h],[90,0,0]]];
  for(pi = [0:len(positions)-1]){
    if(positions[pi][0])
      translate(positions[pi][1])
      rotate(positions[pi][2])
      cylinder(h=l,d=d, center=true,$fn=32);
  }
}

module AttachButterFly(size=[5,3,2],r=0.5,left= true, right=true, front=true, back=true){
  inset = 12;
  if(left || right || front || back){
  
  positions = [
    //left
    [left,[-gf_pitch/2,inset, -fudgeFactor],[0,0,-90]],
    [left,[-gf_pitch/2,-inset, -fudgeFactor],[0,0,-90]],
    //right
    [right,[gf_pitch/2,inset, -fudgeFactor],[0,0,90]],
    [right,[gf_pitch/2,-inset, -fudgeFactor],[0,0,90]],
    //front
    [front,[inset, -gf_pitch/2,-fudgeFactor],[0,0,0]],
    [front,[-inset, -gf_pitch/2,-fudgeFactor],[0,0,0]],
    //back
    [back,[inset, gf_pitch/2,-fudgeFactor],[00,0,180]],
    [back,[-inset, gf_pitch/2,-fudgeFactor],[0,0,180]]];
  for(pi = [0:len(positions)-1]){
    if(positions[pi][0])
      translate(positions[pi][1])
      rotate(positions[pi][2])
      ButterFly(size,r,taper=false,half=true);
    }
  }
}

module ButterFly(size,r,taper=false,half=false)
{
  h = taper ? size.y/2+size.z : size.z;
  render(){
    intersection(){
      positions = [
        [-(size.x/2-r), size.y/2-r, h/2],
        [size.x/2-r, size.y/2-r, h/2],
        [0, -(size.y/2-r), h/2]];
      
      union()
      for(ri = [0:half?0:1]){
        mirror([0,1,0]*ri)
        hull(){
          for(pi = [0:len(positions)-1]){
            translate(positions[pi])
              cylinder(h=h,r=r,center=true, $fn=32);
          }
        }
      }
      
      if(taper)
      rotate([0,90,0])
      cylinder(h=size.x,r=size.y/2+size.z,$fn=4,center=true);
    }
  }
}


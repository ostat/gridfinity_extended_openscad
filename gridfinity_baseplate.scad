// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/gridfinity_modules.scad>

/* [Plate] */
// Plate Style
Plate_Style = "base"; //[base:Base plate, lid:Lid that is also a gridfinity base]
Base_Plate_Options = "default";//[default:Default, magnet:Efficient magnet base, weighted:Weighted base, woodscrew:Woodscrew]
Lid_Options = "default";//[default, flat:Flat Removes the internal grid from base, halfpitch, halfpitch base]

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
 
/* [Debug] */
//Slice along the x axis
cutx = false;
//Slice along the y axis
cuty = false;
// enable loging of help messages during render.
help = false;

module end_of_customizer_opts() {}

/*constants */
magnet_od = 6.5;
magnet_thickness = 2.4;
      
gridfinity_baseplate(
    width = Width,
    depth = Depth,
    plateStyle = Plate_Style,
    plateOptions = Base_Plate_Options,
    lidOptions = Lid_Options,
    customGridEnabled = Custom_Grid_Enabled,
    gridPossitions=[xpos1,xpos2,xpos3,xpos4,xpos5,xpos6,xpos7],
    cutx = cutx,
    cuty = cuty,
    help = help);

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
            translate([gridfinity_pitch*xi,gridfinity_pitch*yi,0])
            baseplate(
              width = customGridEnabled ? 1 : width,
              depth = customGridEnabled ? 1 : depth,
              plateStyle = plateStyle,
              plateOptions= plateOptions,
              lidOptions = lidOptions,
              roundedCorners = _gridPossitions[xi][yi] == 1 ? 15 : _gridPossitions[xi][yi] - 2,
               help = help);
          }
        }
      }
    
    if(cutx && $preview){
      translate([-gridfinity_pitch,-gridfinity_pitch,-fudgeFactor])
        cube([(width+1)*gridfinity_pitch,gridfinity_pitch,2*gridfinity_zpitch]);
    }
    if(cuty && $preview){
      translate([-gridfinity_pitch*0.75,-gridfinity_pitch,-fudgeFactor])
        cube([gridfinity_pitch,(depth+1)*gridfinity_pitch,2*gridfinity_zpitch]);
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
  help = false)
{
  if (plateStyle == "lid") {
    base_lid(width, depth, lidOptions);
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

module base_lid(
  num_x, num_y, 
  lidOptions = "default") 
{
  magnet_position = min(gridfinity_pitch/2-8, gridfinity_pitch/2-4-magnet_od/2);
  eps = 0.1;
  
  flat_base = lidOptions == "flat";
  half_pitch = lidOptions == "halfpitch";
  
  fn = 44;
  height = flat_base ? 0.6 : 1;
  translate([0, 0, (gridfinity_zpitch*height)]) 
    frame_plain(
      num_x, num_y, 
      trim=0.25,
      baseTaper = gridfinity_corner_radius/2,
      fn = fn);

  difference() {
    grid_block(
      num_x, 
      num_y, 
      height, 
      magnet_diameter=0, 
      screw_depth=0, 
      flat_base=flat_base,
      half_pitch=half_pitch, 
      fn = fn);
      
    gridcopy(num_x, num_y) {
      cornercopy(magnet_position) {
        translate([0, 0, (gridfinity_zpitch*height)-magnet_thickness])
        cylinder(d=magnet_od, h=magnet_thickness+eps, $fn=32);
      }
    }
  }
}

module woodscrew_baseplate(
  num_x, 
  num_y,  
  cornerRadius = gridfinity_corner_radius,
  roundedCorners = 15) {
  magnet_position = min(gridfinity_pitch/2-8, gridfinity_pitch/2-4-magnet_od/2);
  eps = 0.1;
  frameHeight = 6.4;
    
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
  cornerRadius = gridfinity_corner_radius,
  roundedCorners = 15) {
  
  magnet_position = min(gridfinity_pitch/2-8, gridfinity_pitch/2-4-magnet_od/2);
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
  cornerRadius = gridfinity_corner_radius,
  roundedCorners = 15) {
  
  magnet_position = min(gridfinity_pitch/2-8, gridfinity_pitch/2-4-magnet_od/2);
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
      
      cubeSize = gridfinity_pitch-magnet_position+magnet_od;
      
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
    cornerRadius = gridfinity_corner_radius,
    roundedCorners = 15,
    fn = 44) {
  ht = extra_down > 0 ? height -0.6 : height;

  corner_position = gridfinity_pitch/2-cornerRadius-trim;
  
  difference() {
    color(color_cup)
    hull() 
      render()
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
      render() 
      gridcopy(num_x, num_y) 
      pad_oversize(margins=1);
  }
}
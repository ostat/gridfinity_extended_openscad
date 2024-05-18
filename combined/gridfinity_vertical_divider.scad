///////////////////////////////////////
//Combined version of 'gridfinity_vertical_divider.scad'. Generated 2024-05-18 17:15
///////////////////////////////////////

/* [Tray] */
cornerRadius = 2;

//Height above the floor
trayZpos = 0;
magnetRadius = 5;
magnetThickness = 5;
stackable = false;
spacing = 3;
verticalCompartments = 1;
horizontalCompartments = 1;

/*
xpos,ypos,xsize,ysize,radius,depth. 
dimentions of the tray cutout, a string with comma separated values, and pipe (|) separated trays.
 - xpos, ypos, the x/y position in gridinity units.
 - xsize, ysize. the x/y size in gridinity units. 
 - radius, [optional] corner radius in mm.
 - depth, [optional] depth in mm
 - example "0,0,2,1|2,0,2,1,2,5"
*/
//[[xpos,ypos,xsize,ysize,radius,depth]]. xpos, ypos, the x/y position in gridinity units.xsize, ysize. the x/y size in gridinity units. radius, [optional] corner radius in mm.depth, [optional] depth in mm\nexample "0,0,2,1|2,0,2,1,2,5"
customCompartments = "0, 0, 0.5, 3, 2, 6|0.5, 0, 0.5, 3,2, 6|1, 0, 3, 1.5|1, 1.5, 3, 1.5";


/* [Gridfinity] */
// X dimension in grid units
width = 4; // [ 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Y dimension in grid units
depth = 3; // [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Z dimension (multiples of 7mm)
height = 1.5; //0.1
// (Zack's design uses magnet diameter of 6.5)
magnet_diameter = 0;  // .1
// (Zack's design uses depth of 6)
screw_depth = 0;
// Hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = false;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
// Wall thickness (Zack's design is 0.95)
wall_thickness = 0.95;  // .01
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Remove some or all of lip
lip_style = "normal";  // [ "normal", "reduced", "none" ]
flat_base = false;

// ignore variable values below
/* [Hidden] */
baseDimention = 42;
baseHeight = 6 ;
cutoutSize = baseDimention - spacing*2;
fudgeFactor = 0.01;

module divider(
  height = 50,
  length = 100,
  baseHeight = 10,
  width = 5,
  radius = 5,
  frontTopInset=20,
  frontTopAngle=65,
  backTopInset=20,
  backTopAngle=65,
  fn = 36
){
  _baseHeight = radius > baseHeight ? radius : baseHeight;

  _backBottomHeight = max(_baseHeight,height-radius-abs(backTopInset*tan(backTopAngle)));
  _frontBottomHeight = max(_baseHeight,height-radius-abs(frontTopInset*tan(frontTopAngle)));
  echo(height,radius, abs(backTopInset*tan(backTopAngle)),_backBottomHeight);
  echo(_baseHeight=_baseHeight, height=height, _backBottomHeight=_backBottomHeight, _frontBottomHeight=_frontBottomHeight);
  
  positions = [
    [radius,0,_frontBottomHeight],      //front bottom
    [radius+frontTopInset,0,height-radius],        //front top
    [length-radius-backTopInset,0,height-radius],  //back top
    [length-radius,0,_backBottomHeight] //back bottom
  ];
  
  //
  hull(){
    translate([0,-width,0])
      cube([length,width,_baseHeight]);
    for(index =[0:1:len(positions)-1])
    {
      translate(positions[index])
        rotate([90,0,0])
        cylinder(r=radius,h=width, $fn=fn);
    }
  }
}
 
divider();

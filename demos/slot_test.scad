// Creates a slot with a small champer for easy insertertion
//#slotCutout(100,20,40);
//width = width of slot
//depth = depth of slot
//height = height of slot
//champer = champer size
fudgeFactor = 0.01;
module slotCutout(size, champer = 1.2)
{
  //TODO, this needs fixing, the champher math is off,
  //Needs to be a fixed champher not based no width
  champer = 1;
   c = size.y  + 0.5;
  translate([size.x/2,size.y/2,0])
  intersection(){
    union(){
      // Main slot
      translate([-size.x/2,-size.y/2,0])
        cube([size.x, size.y, size.z]);
      
     translate([-size.x/2,-size.y/2,size.z+fudgeFactor])
     hull(){
        translate([0,0,0])
          rotate([180,0,45])
          cylinder(champer,champer,00,$fn=4);
        translate([size.x,0,0])
        rotate([180,0,45])
          cylinder(champer,champer,00,$fn=4);
        translate([0,size.y,0])
        rotate([180,0,45])
          cylinder(champer,champer,00,$fn=4);
        translate([size.x,size.y,0])
        rotate([180,0,45])
          cylinder(champer,champer,00,$fn=4);          
          
     }
    }
  }
}

  sizes = [[24, 2.1, 18],
  [20, 1.4, 10],
  [11, 1, 3.75],
  [21.5, 2.8, 12.5],
  [20, 1.6, 7.75],
  [12.5, 1.2, 3.75],
  [12.3, 0.7, 2.2],
  [15, 1.6, 3.125],
  [38.5, 3.8, 7.45],
  [25, 1.78, 5],
  [12, 4.5, 12.8],
  [181, 15, 55.75]];

   for(i = [0:1:len(sizes)-1]){
   
   translate([0,10*i,0])
    slotCutout(sizes[i]);
   }

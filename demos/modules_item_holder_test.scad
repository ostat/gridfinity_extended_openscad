use <../modules/module_item_holder.scad>

$fn = 64;
fudgeFactor = 0.01;
help = true;

translate([0,00,0]) chamfered_cube([50,15,2], chamfer=1,cornerRadius=0);
translate([0,20,0]) chamfered_cube([50,15,2], chamfer=1,cornerRadius=2);
translate([0,40,0]) chamfered_cube([50,15,2], chamfer=1,cornerRadius=4);
translate([0,60,0]) chamfered_cube([50,15,40], chamfer=1,cornerRadius=0);
translate([0,80,0]) chamfered_cube([50,15,40], chamfer=1,cornerRadius=2);
translate([0,100,0]) chamfered_cube([50,15,40], chamfer=1,cornerRadius=4);

translate([65,0,0]) chamferedRectangleTop([10,40,20], 1, 0);
translate([85,0,0]) chamferedRectangleTop([10,40,20], 1, 2);

translate([120,0,0]) chamferedHalfCylinder(h=4,r=20);

translate([160,0,0]) 
multiCard(
  [0, 24, 2.1, 18, 32, "square"],
  [0, 12, 4.5, 13, 13, "square"],
  [0, 20, 1.4, 10, 21.5, "square"]);
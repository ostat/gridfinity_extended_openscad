///////////////////////////////////////
//Combined version of 'gridfinity_baseplate_flsun_q5.scad'. Generated 2025-11-08 11:07
///////////////////////////////////////
// include instead of use, so we get the pitch
ear_hole_x = 182.5; // distance between existing screw holes on FLSUN q5.
ear_hole_y = 7; // distance of screw hole from the front panel.
from_ends = (ear_hole_x - gf_pitch*4) / 2;
cube_z = 4.4; // ht from above.
M4_d = 4.2; // diameter needed for an M4 bolt.
wallThickness = 0.2; //Extend and imbed in to wall to fit around corner
union(){
  translate([gf_pitch/2, gf_pitch/2, 0]) 
    frame_plain(4, 1, height = cube_z);
  for (i = [0,1]) {
    x = i * ear_hole_x - from_ends-wallThickness;
    difference() {
      hull() {
        translate([x, ear_hole_y, 0]) 
          cylinder(h=cube_z, d=M4_d*2, $fn=20);
        translate([x - from_ends * i, ear_hole_y - M4_d, 0]) 
          cube([from_ends+wallThickness, M4_d*2, cube_z]);
      }
        translate([x, ear_hole_y, -0.01]) 
          cylinder(h=cube_z + 0.02, d=M4_d, $fn=20);
    }
  }
}

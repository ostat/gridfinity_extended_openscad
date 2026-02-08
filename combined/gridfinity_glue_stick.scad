///////////////////////////////////////
//Combined version of 'gridfinity_glue_stick.scad'. Generated 2026-02-09 08:20
///////////////////////////////////////

cup_height = 5;
stick_diameter = 30;
easement_z = 0.7; // a slightly large opening at the top for compliance while inserting.
minimum_wall = 4;
blocks_needed = ceil((stick_diameter+2*minimum_wall)/env_pitch().x);

$fn = 64;

set_environment(
  width = 1,
  depth = 1,
  height = 2,
  render_position = "center")
glue_stick_cup(blocks_needed, blocks_needed, cup_height);


module glue_stick_cup(num_x=1, num_y=1, num_z=2) {
  difference() {
    grid_block(num_x, num_y, num_z, 
      cupBase_settings = CupBaseSettings());
      translate([num_x*env_pitch().x/2, num_y*env_pitch().y/2, 0])
      glue_stick(num_z, stick_diameter);
  }
}

module glue_stick(num_z=5, diam) {
  floor_thickness = blocks_needed > 1 ? 5.5 : 1.2;
  translate([0, 0, floor_thickness]) cylinder(h=num_z*env_pitch().z, d=diam);
  translate([0, 0, (num_z - easement_z)*env_pitch().z + 1.2]) 
    cylinder(h=easement_z*env_pitch().z, d1=diam, d2=diam*1.1);
}

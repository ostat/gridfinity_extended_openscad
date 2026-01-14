include <modules/module_gridfinity_block.scad>

/* [Utensil count and measurements] */
// Utensil definitions above this number are ignored
number_of_utensils = 7;

utensil_1_wide = 28;  utensil_1_narrow = 15;  utensil_1_length = 202;
utensil_2_wide = 24;  utensil_2_narrow = 14;  utensil_2_length = 181;
utensil_3_wide = 37;  utensil_3_narrow = 14;  utensil_3_length = 181;
utensil_4_wide = 33;  utensil_4_narrow = 12;  utensil_4_length = 155;
utensil_5_wide = 32;  utensil_5_narrow = 15;  utensil_5_length = 191;
utensil_6_wide = 32;  utensil_6_narrow = 15;  utensil_6_length = 150;
utensil_7_wide = 24;  utensil_7_narrow = 16;  utensil_7_length = 180;

/* [Even more utensils?] */
utensil_8_wide = 28;  utensil_8_narrow = 15;  utensil_8_length = 202;
utensil_9_wide = 24;  utensil_9_narrow = 14;  utensil_9_length = 181;
utensil_10_wide = 37; utensil_10_narrow = 14; utensil_10_length = 181;
utensil_11_wide = 33; utensil_11_narrow = 12; utensil_11_length = 155;
utensil_12_wide = 32; utensil_12_narrow = 15; utensil_12_length = 191;
utensil_13_wide = 32; utensil_13_narrow = 15; utensil_13_length = 150;
utensil_14_wide = 24; utensil_14_narrow = 16; utensil_14_length = 180;

/* [Other parameters] */
// Separation wall thickness
separator_wall = 2;  // .1
// Clearance on sides and ends of utensils
margin = 1;  // .1
// Height to upper surface excluding perimeter lip
height_in_mm = 35;

/* [Gridfinity features] */
// (Zack's design uses magnet diameter of 6.5)
magnet_diameter = 0;  // .1
// Create relief for magnet removal 
magnet_easy_release = true;
// (Zack's design uses depth of 6)
screw_depth = 0;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 1.0;

module end_of_customizer() {}

// Maximum utensil definitions
silver_defs_all = [
  [ utensil_1_wide, utensil_1_narrow, utensil_1_length ],
  [ utensil_2_wide, utensil_2_narrow, utensil_2_length ],
  [ utensil_3_wide, utensil_3_narrow, utensil_3_length ],
  [ utensil_4_wide, utensil_4_narrow, utensil_4_length ],
  [ utensil_5_wide, utensil_5_narrow, utensil_5_length ],
  [ utensil_6_wide, utensil_6_narrow, utensil_6_length ],
  [ utensil_7_wide, utensil_7_narrow, utensil_7_length ],
  [ utensil_8_wide, utensil_8_narrow, utensil_8_length ],
  [ utensil_9_wide, utensil_9_narrow, utensil_9_length ],
  [ utensil_10_wide,utensil_10_narrow,utensil_10_length ],
  [ utensil_11_wide,utensil_11_narrow,utensil_11_length ],
  [ utensil_12_wide,utensil_12_narrow,utensil_12_length ],
  [ utensil_13_wide,utensil_13_narrow,utensil_13_length ],
  [ utensil_14_wide,utensil_14_narrow,utensil_14_length ],
];

// ##### Utility functions

// tail of a list with at least 2 elements
function cdr(list) = [ for (i=[1:len(list)-1]) list[i] ];
// sum of a bunch of values (recursive functional style)
function vecsum(vals) = len(vals) > 1 ? vals[0] + vecsum(cdr(vals)) : vals[0];
// total width of a list of utensils
function totwidth(defs) = vecsum(pitches(defs)) + 2*margin + 
  max(defs[0][0], defs[0][1])/2 + max(defs[len(defs)-1][0], defs[len(defs)-1][1])/2;
// maximum length of list of utensils
function maxlen(defs) = len(defs) > 1 ? max(defs[0][2], maxlen(cdr(defs))) : defs[0][2];
// convert a list of utensils into a list of center-to-center distances
function pitches(defs) = [ for (i=[0:len(defs)-2]) separator_wall + 2*margin + 
  max( defs[i][1]/2 + defs[i+1][0]/2, defs[i][0]/2 + defs[i+1][1]/2) ];

// ##### Derived variables and values

// subset of all utensil definitions up to the requested number of utensils
silver_defs = [ for (i=[0:number_of_utensils-1]) silver_defs_all[i] ];
// width of combination of all silverware
silver_w = totwidth(silver_defs);
// gridfinity modules expect height in units of 7 mm (but fractions are allowed)
height = height_in_mm / 7;
// X dimension in gridfinity units
width = ceil((silver_w + 5.7)/42);
// Y dimension in gridfinity units
depth = ceil((maxlen(silver_defs)+2*margin+5.7)/42);

if(env_help_enabled("debug")) echo("maxlen: ", maxlen(silver_defs));

// ##### Top level model

silverware_pockets(silver_defs);

// ##### Modules

// Polygon shape for a single utensil
module poly_pocket(topw, botw, oal, wall=separator_wall) {
  b2 = botw/2; t2 = topw/2; o2 = oal/2; qd = abs(topw-botw)/4;  // quarter of delta
  f = (topw > botw) ? (1-sqrt(2)/2)*wall/2 : -(1-sqrt(2)/2)*wall/2;
  polygon([[-b2,-qd+f],[-b2,-o2],[b2,-o2],[b2,-qd+f],[t2,qd+f], 
    [t2,o2],[-t2,o2],[-t2,qd+f]]);
}

// top level module to generate packed polygons
module stack_silver(defs) {
  xtop = 0;
  xbot = 0;
  translate([-totwidth(defs)/2, 0])
  recur_stack_silver(xtop, xbot, defs, 0);
}

// recursive helper function essentially implements loop
module recur_stack_silver(xtop, xbot, silv, inverted) {
  s1 = silv[0];
  topw = 2*margin + (inverted ? s1[1] : s1[0]);
  botw = 2*margin + (inverted ? s1[0] : s1[1]);
  
  topmid = xtop+topw/2;
  botmid = xbot+botw/2;
  mid = max(topmid, botmid);
  
  translate([mid, 0]) poly_pocket(topw, botw, s1[2]+2*margin);
  
  xtop2 = mid + topw/2 + separator_wall;
  xbot2 = mid + botw/2 + separator_wall;
  if (len(silv) > 1) {  // more pieces to stack, call recursively
    recur_stack_silver(xtop2, xbot2, cdr(silv), 1-inverted);
  }
}

// top level generator
module silverware_pockets(defs, md=magnet_diameter, sd=screw_depth) {
  mag_ht = md > 0 ? 2.4: 0;
  m3_ht = sd;
  part_ht = 5;  // height of bottom side groove between gridfinity units
  floorht = max(mag_ht, m3_ht, part_ht) + floor_thickness;
  
  difference() {
    translate(gridfinityRenderPosition("center",width,depth))
    grid_block(width, depth, height, magnet_diameter=md, screw_depth=sd);
    translate([0, 0, floorht]) 
      linear_extrude(height=7*height) 
      stack_silver(defs);
  }
}

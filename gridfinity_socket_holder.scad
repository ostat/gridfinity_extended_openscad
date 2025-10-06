include <modules/module_gridfinity_block.scad>

part = 5; //[1: "METRIC", 2: "IMPERIAL", 3: "Imperial < 1/2\"", 4: "Imperial >= 1/2\"", 5: "Metric >=7mm", 6: "Metric <7mm"]

if (part == 1) {
  socket_holder(4, [12,12,12,13,14,16,16,17,21,22], "METRIC");
}
else if (part == 2) {
  socket_holder(4, [12,13,14,14,16,16,17,18,20,22], "IMPERIAL");
}
else if (part == 3) {
  socket_holder(4, [12,12,12,12,12,12,13,14,14,16,16], "Imperial < 1/2\"", num_z=5);
}
else if (part == 4) {
  socket_holder(3, [17,18,20,22,24], "Imperial >= 1/2\"");
}
else if (part == 5) {
  socket_holder(4, [12,12,12,13,14,16,16,17,21,22], "Metric >=7mm", num_z=6);
}
else if (part == 6) {
  socket_holder(2, [12,12,12,12,12,12], "metric<7mm");
}

function inc(v, a=.6) = [for (i = v) i+a ];

module socket_holder(num_x=1, widths=[], name="", num_z=3) {
  difference() {
    grid_block(num_x, 1, num_z);
    usable_w = 42*num_x - 6;
    rotate([-45,0,0])translate([-18,-5,1])
      #sockets(inc(widths,0.6), usable_w);
    rotate([-45,0,0])translate([-18,-23-6,5])
      cube([usable_w,18,26]);
    translate([-18,-20,10])rotate([90,0,0])
      linear_extrude(10)text(name);
    translate([-18,-18,22])cube([usable_w,42-6,50]);
  }
}

function move(v, i=0, r=0, lo=0) = i > 0 ? move(v, i-1, r+(v[i-1]+v[i])/2, lo) + lo : r;
function sum(v, i=0, r=0) = i < len(v) ? sum(v, i+1, v[i] + r) : r;

module sockets(widths=[], width = 100) {
  leftover = width - sum(widths);
  if(env_help_enabled("debug")) echo(leftover=leftover, "(should be greater than 0)");
  for (i = [0:len(widths)-1]) {
    s = move(widths, i, 0, leftover/(len(widths)-1));
    translate([widths[0]/2,0,0])
    translate([s,-widths[i]/2,0])cylinder(h=26, d=widths[i]);
  }
}

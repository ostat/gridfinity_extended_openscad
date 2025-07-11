include <modules/module_gridfinity_block.scad>

/* [model] */
// Select model
part = "tile";  // [ board, tile, pawn, knight, bishop, rook, queen, king ]

/* [model detail] */
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments 
fa = 6; 
// minimum size of a fragment.  Low is more fragments
fs = 0.1; 
// number of fragments, overrides $fa and $fs
fn = 0;  

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;   

if (part == "tile") {
  tile();
}
else if (part == "pawn") {
  pawn();
}
else if (part == "knight") {
  knight();
}
else if (part == "bishop") {
  bishop();
}
else if (part == "rook") {
  rook();
}
else if (part == "queen") {
  queen();
}
else if (part == "king") {
  king();
}
else if (part == "board") {
  board();
  color("#DDDDDD") piece_set();
  color("#505050") piece_set(false);
}


module piece_set(white=true) {
  pawnrow = white ? 1 : 6;
  restrow = white ? 0 : 7;
  
  for (i=[0:7]) {
    translate([i*42, 42*pawnrow, 0]) pawn();
  }
  for (i=[0,1]) {
    translate([0 + 7*i*42, restrow*42, 0]) rook();
    translate([(1 + 5*i)*42, restrow*42, 0]) 
      rotate([0, 0, white ? 0 : 180]) knight();
    translate([(2 + 3*i)*42, restrow*42, 0]) bishop();
  }
  translate([3*42, restrow*42, 0]) queen();
  translate([4*42, restrow*42, 0]) king();
}


module king() {
  base();
  
  rotate_extrude()
  polygon([[0, 47], [0, 0], [11, 0], [11, 10], [8, 13], [6, 38],
    [9, 42], [9, 45], [7, 46]]);
  
  translate([-1.5, -1, 47-1]) cube([3, 2, 10]);
  translate([-3, -1, 51]) cube([6, 2, 3]);
}


module queen() {
  base();
  
  difference() {  
    rotate_extrude()
    polygon([[0, 45], [0, 0], [11, 0], [11, 10], [8, 13], [6, 42], 
      [8, 44], [8, 46], [11, 48], [13, 53], [12, 53], [8, 48]]);
    
    *%for (a=[0, 60, 120]) rotate([0, 0, a])
    translate([-15, -1.5, 48.5]) cube([30, 3, 10]);
    
    for (a=[0, 30, 60, 90, 120, 150]) rotate([0, 0, a])
    translate([0, 0, 48.5+6])
    rotate([0, 90, 0]) cylinder(d=7.25, h=30, center=true);
  }
}


module knight() {
  base();

  rotate_extrude()
  polygon([[0, 13], [0, 0], [9, 0], [9, 10], [7, 13]]);
  
  hull() {
    translate([-4, -7.5, 0]) cube([8, 13, 14]);
    translate([-2.5, -7.5, 30]) cube([5, 8, 3]);
  }
  translate([-2.5-.125, -7.5, 30]) cube([5+.25, 17, 7]);
  
  // support for bridging knight nose (remove afterward)
  hull() {
    translate([-2.625, 9.5-0.8, 27]) cube([5.25, 0.8, 3]);  
    translate([-5, 10, 0]) cube([10, 1, 1]);
  }
  translate([-0.6, 10, 0]) cube([1.2, 6, 5]);
}


module bishop() {
  base();
  
  tz(42) sphere(d=3);
  
  difference() {
    rotate_extrude()
    polygon([[0, 42], [0, 0], [9, 0], [9, 10], [7, 13], [3.5, 26], [6, 32]]);
    
    translate([4.5, 0, 40])
    rotate([0, -56, 0])
    cylinder(d=20, h=1);
  }
}


module rook() {
  base();
  
  difference() {
    rotate_extrude()
    polygon([[0, 34], [0, 0], [10, 0], [10, 10], [7, 13], [7, 29], 
      [10, 32], [10, 39], [8, 39], [8, 34]]);
    
    for (a=[0, 90]) rotate([0, 0, a]) 
      translate([-15, -1.5, 34.5]) cube([30, 3, 10]);
  }
}


module pawn() {
  base();
  
  tz(25) sphere(d=11);
  
  rotate_extrude()
  polygon([[0, 25], [0, 0], [7, 0], [7, 8], [4.5, 11], [3, 24]]);
}


module base() {
  difference() {
    tile(0.75);
    difference() {
      cube([35, 35, 30], center=true);
      for (a=[45, 135]) rotate([0, 0, a]) cube([60, 2, 30], center=true);
    }
    
    translate([-21, -21, 5]) cube([42, 42, 42]);
  }
}


module board() {  // 64 tiles in alternating colors
  tz(-3.55) for (ti=[0:7]) for (tj=[0:7]) translate([42*ti, 42*tj, 0]) 
    color((ti+tj)%2 == 0 ? "darkblue" : "lightblue")
    render() tile();
}


module tile(height = 0.5) {
  grid_block(1, 1, 0.5, lipStyle = "none", position = "centered");
}


module tz(z) {
  translate([0, 0, z]) children();
}

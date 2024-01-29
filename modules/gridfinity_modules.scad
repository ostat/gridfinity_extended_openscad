include <modules_utility.scad>
include <gridfinity_constants.scad>

// set this to produce sharp corners on baseplates and bins
// not for general use (breaks compatibility) but may be useful for special cases
sharp_corners = 0;

function calcualteCavityFloorRadius(cavity_floor_radius, wall_thickness) = let(
  q = 1.65 - wall_thickness + 0.95 // default 1.65 corresponds to wall thickness of 0.95
) cavity_floor_radius >= 0 ? min((2.3+2*q)/2, cavity_floor_radius) : (2.3+2*q)/2;

constTopHeight = 5.7+fudgeFactor*5; //Need to confirm this

//Height to clear the voids in the base
function cupBaseClearanceHeight(magnet_diameter, screw_depth) = let (
    mag_ht = magnet_diameter > 0 ? gf_magnet_thickness : 0)
    max(mag_ht, screw_depth, gf_min_base_height);

function calculateMinFloorHeight(magnet_diameter,screw_depth) = 
    cupBaseClearanceHeight(magnet_diameter,screw_depth) + gf_cup_floor_thickness;
function calculateMagnetPosition(magnet_diameter) = min(gf_pitch/2-8, gf_pitch/2-4-magnet_diameter/2);

//Height of base including the floor.
function calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness, num_z=1, filledin = "off") = 
  filledin == "on" || filledin == "notstackable" 
    ? num_z * gf_zpitch 
    : cupBaseClearanceHeight(magnet_diameter,screw_depth) + max(floor_thickness, gf_cup_floor_thickness);
    
//Usable floor depth (florr height - min floor)
function calculateFloorThickness(magnet_diameter, screw_depth, floor_thickness, num_z, filledin) = 
  calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness, num_z, filledin) - cupBaseClearanceHeight(magnet_diameter, screw_depth);
    
// calculate the position of separators from the size
function splitChamber(num_separators, num_x) = num_separators < 1 
      ? [] 
      : [ for (i=[1:num_separators]) i*(num_x/(num_separators+1))*gf_pitch];

function LookupKnownShapes(name="round") = 
  name == "square" ? 4 :
  name == "hex" ? 6 : 64;
  
function cupPosition(position, num_x, num_y) = position == "center" 
    ? [-(num_x-1)*gf_pitch/2, -(num_y-1)*gf_pitch/2, 0] 
    : position == "zero" ? [gf_pitch/2, gf_pitch/2, 0] 
    : [0, 0, 0]; 

module ShowClippers(cutx, cuty, size, magnet_diameter, screw_depth, floor_thickness, filled_in,wall_thickness){
  num_x=size.x;
  num_y=size.y;
  num_z=size.z;

  bh = gfBaseHeight();
  cbh = cupBaseClearanceHeight(magnet_diameter, screw_depth);
  mfh = calculateMinFloorHeight(magnet_diameter, screw_depth);
  fh = calculateFloorHeight(magnet_diameter, screw_depth, floor_thickness, num_z, filled_in);
  fd = fh - mfh;//calculateFloorDepth(filled_in, floor_thickness, num_z);

  fontSize = 3;  
  color(color_text)
  if(cuty > 0 && $preview)
  {
    translate([0,-gf_pitch*0.5+gf_pitch*cuty,0]) 
    {
      translate([-0.5*gf_pitch+gf_tolerance/2,0,num_z*gf_zpitch+gf_Lip_Height])
      rotate([90,0,0])
        Caliper(messpunkt = false, center=false,
          h = 0.1, s = fontSize
          , end=0, in=1,
          translate=[0,5,0],
          l=num_x*gf_pitch-gf_tolerance, 
          txt2 = str("total width ", num_x));
     
      translate([-0.5*gf_pitch+gf_tolerance/2+wall_thickness,0,(1+(num_z-1)/2)*gf_zpitch])
      rotate([90,0,0])
        Caliper(messpunkt = false, center=false,
          h = 0.1, s = fontSize
          , end=0, in=1,
          l=num_x*gf_pitch-gf_tolerance-wall_thickness*2, 
          txt2 = "inner width"); 
          
      translate([(num_x-0.5)*gf_pitch,0,0])
      rotate([90,0,0])
        Caliper(messpunkt = false, center=false,
          h = 0.1, size = fontSize,
          cx=0, end=0, in=2,
          l=num_z*gf_zpitch, 
          translate=[1,0,0],
          txt2 = str("height ", num_z));
          
      translate([(num_x-0.5)*gf_pitch,0,num_z*gf_zpitch])
      rotate([90,0,0])
        Caliper(messpunkt = false, center=false,
          h = 0.1, size = fontSize,
          cx=0, end=0, in=2,
          l=gf_Lip_Height, 
          translate=[1,0,0],
          txt2 = str("lip height"));
          
     translate([(num_x-0.5)*gf_pitch,0,0])
      rotate([90,0,0])
        Caliper(messpunkt = false, center=false,
          h = 0.1, size = fontSize,
          cx=0, end=0, in=2,
          translate=[fontSize*3,0,0],
          l=gf_Lip_Height+num_z*gf_zpitch, 
          txt2 = str("total height"));

      translate([-gf_pitch/2,0,mfh])
      rotate([90,0,0])
        Caliper(messpunkt = false, center=false,
          h = 0.1, s = fontSize,
          cx=-1, end=0, in=2,
          translate=[00,0,0],
          l=fd, 
          txt2 = "floor thickness");
      translate([-gf_pitch/2,0,0])
      rotate([90,0,0])
        Caliper(messpunkt = false, center=false,
          h = 0.1, s = fontSize*.75,
          cx=0, end=0, in=2,
          translate=[00,0,0],
          l=bh, 
          txt2 = "min base height");
      translate([-gf_pitch/2,0,0])
      rotate([90,0,0])
        Caliper(messpunkt = false, center=false,
          h = 0.1, s = fontSize*.75,
          cx=-1, end=0, in=2,
          translate=[-2,0,0],
          l=mfh, 
          txt2 = "min floor height");
  
    rotate([90,0,0])
        Caliper(messpunkt = false, center=false,
          h = 0.1, s = fontSize,
          cx=-1, end=0, in=2,
          translate=[0,-fh/2+2,0],
          l=fh, 
          txt2 = "floor height");
    }
  }  
  
  color(color_text)
  if(cutx > 0 && $preview)
  {
  translate([-gf_pitch*0.5+gf_pitch*cutx,0,0]) 
  {
    translate([0,(num_y-0.5)*gf_pitch-gf_tolerance/2,num_z*gf_zpitch+gf_Lip_Height])
    rotate([90,0,270])
      Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize
        , end=0, in=1,
        translate=[0,5,0],
        l=num_y*gf_pitch-gf_tolerance, 
        txt2 = str("total depth ", num_y));
   
    translate([0,(num_y-0.5)*gf_pitch-gf_tolerance/2-wall_thickness,(1+(num_z-1)/2)*gf_zpitch])
    rotate([90,0,270])
      Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize
        , end=0, in=1,
        l=num_y*gf_pitch-gf_tolerance-wall_thickness*2, 
        txt2 = "inner depth"); 
        
    translate([0,-gf_pitch/2,0])
    rotate([90,0,270])
      Caliper(messpunkt = false, center=false,
        h = 0.1, size = fontSize,
        cx=0, end=0, in=2,
        l=num_z*gf_zpitch, 
        translate=[1,0,0],
        txt2 = str("height ", num_z));
        
    translate([0,-gf_pitch/2,num_z*gf_zpitch])
    rotate([90,0,270])
      Caliper(messpunkt = false, center=false,
        h = 0.1, size = fontSize,
        cx=0, end=0, in=2,
        l=gf_Lip_Height, 
        translate=[1,0,0],
        txt2 = str("lip height"));
        
   translate([0,-gf_pitch/2,0])
    rotate([90,0,270])
      Caliper(messpunkt = false, center=false,
        h = 0.1, size = fontSize,
        cx=0, end=0, in=2,
        translate=[fontSize*3,0,0],
        l=gf_Lip_Height+num_z*gf_zpitch, 
        txt2 = str("total height"));

    translate([0,+gf_pitch/2,mfh])
    rotate([90,0,270])
      Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize,
        cx=-1, end=0, in=2,
        translate=[00,0,0],
        l=fd, 
        txt2 = "floor thickness");
    translate([0,+gf_pitch/2,0])
    rotate([90,0,270])
      Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.75,
        cx=0, end=0, in=2,
        translate=[00,0,0],
        l=bh, 
        txt2 = "min base height");
    translate([0,+gf_pitch/2,0])
    rotate([90,0,270])
      Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.75,
        cx=-1, end=0, in=2,
        translate=[-2,0,0],
        l=mfh, 
        txt2 = "min floor height");
    translate([0,0,0])
    rotate([90,0,270])
      Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize,
        cx=-1, end=0, in=2,
        translate=[0,-fh/2+2,0],
        l=fh, 
        txt2 = "floor height");
    }
  }  
}
 
// basic block with cutout in top to be stackable, optional holes in bottom
// start with this and begin 'carving'
module grid_block(
  num_x=1, 
  num_y=2, 
  num_z=2, 
  magnet_diameter=gf_magnet_diameter, 
  screw_depth=gf_cupbase_screw_depth, 
  position = "default",
  hole_overhang_remedy=0, 
  half_pitch=false, 
  box_corner_attachments_only = false, 
  flat_base=false, 
  stackable = true,
  center_magnet_diameter = 0,
  center_magnet_thickness = 0,
  fn = 32,
  help)
{
  outer_size = gf_pitch - gf_tolerance;  // typically 41.5
  block_corner_position = outer_size/2 - gf_cup_corner_radius;  // need not match center of pad corners

  magnet_position = min(gf_pitch/2-8, gf_pitch/2-4-magnet_diameter/2);
   
  overhang_fix = hole_overhang_remedy > 0 && magnet_diameter > 0 && screw_depth > 0 ? hole_overhang_remedy : 0;
  overhang_fix_depth = 0.3;  // assume this is enough
  
  totalht=gf_zpitch*num_z+3.75;
  translate(cupPosition(position,num_x,num_y))
  difference() {
    intersection() {
      union() {
        // logic for constructing odd-size grids of possibly half-pitch pads
        color(color_base)
        pad_grid(num_x, num_y, half_pitch, flat_base);
        // main body will be cut down afterward
        translate([-gf_pitch/2, -gf_pitch/2, 5]) 
        cube([gf_pitch*num_x, gf_pitch*num_y, totalht-5]);
      }
      
      color(color_cup)
      translate([0, 0, -fudgeFactor])
      hull() 
      cornercopy(block_corner_position, num_x, num_y) 
      cylinder(r=gf_cup_corner_radius, h=totalht+fudgeFactor*2, $fn=fn);
    }
    
    if(center_magnet_diameter> 0 && center_magnet_thickness>0){
      //Center Magnet
      for(x =[0:1:num_x-1])
      {
        for(y =[0:1:num_y-1])
        {
          color(color_basehole)
          translate([x*gf_pitch,y*gf_pitch,-fudgeFactor])
            cylinder(h=center_magnet_thickness-fudgeFactor, d=center_magnet_diameter);
        }
      }
    }
    
    if(stackable)
    {
      // remove top so XxY can fit on top
      color(color_topcavity) 
        translate([0, 0, gf_zpitch*num_z]) 
        pad_oversize(num_x, num_y, 1);
    }
    else{
      color(color_topcavity) 
        translate([-gf_pitch/2, -gf_pitch/2, gf_zpitch*num_z]) 
        cube([num_x*gf_pitch,num_y*gf_pitch, gf_zpitch]);
    }
    
    color(color_basehole)
    translate([0,0,-fudgeFactor])
    gridcopycorners(num_x, num_y, magnet_position, box_corner_attachments_only)
        SequentialBridgingDoubleHole(
          outerHoleRadius = magnet_diameter/2,
          outerHoleDepth = gf_magnet_thickness+0.1,
          innerHoleRadius = gf_cupbase_screw_diameter/2,
          innerHoleDepth = screw_depth > 0 ? screw_depth+fudgeFactor : 0,
          overhangBridgeCount = overhang_fix,
          overhangBridgeThickness = overhang_fix_depth);
  }
 
  HelpTxt("grid_block",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"magnet_diameter",magnet_diameter
    ,"screw_depth",screw_depth
    ,"position",position
    ,"hole_overhang_remedy",hole_overhang_remedy
    ,"half_pitch",half_pitch
    ,"box_corner_attachments_only",box_corner_attachments_only
    ,"flat_base",flat_base
    ,"stackable",stackable]
    ,help);
}


module pad_grid(num_x, num_y, half_pitch=false, flat_base=false) {
  if (flat_base) {
    pad_oversize(ceil(num_x), ceil(num_y));
  }
  else if (half_pitch) {
    gridcopy(ceil(num_x*2), ceil(num_y*2), gf_pitch/2) {
      pad_oversize(
        ($gci.x == ceil(num_x*2)-1 ? (num_x*2-$gci.x)/2 : 0.5),
        ($gci.y == ceil(num_y*2)-1 ? (num_y*2-$gci.y)/2 : 0.5));
    }
  }
  else {
    gridcopy(ceil(num_x), ceil(num_y)) {
      pad_oversize(
        //Calculate pad size, last cells might not be 100%
        ($gci.x == ceil(num_x)-1 ? num_x-$gci.x : 1),
        ($gci.y == ceil(num_y)-1 ? num_y-$gci.y : 1));
    }
  }
}

// like a cylinder but produces a square solid instead of a round one
// specified 'diameter' is the side length of the square, not the diagonal diameter
module cylsq(d, h) {
  translate([-d/2, -d/2, 0]) cube([d, d, h]);
}

// like a tapered cylinder with two diameters, but square instead of round
module cylsq2(d1, d2, h) {
  linear_extrude(height=h, scale=d2/d1)
  square([d1, d1], center=true);
}

// unit pad slightly oversize at the top to be trimmed or joined with other feet or the rest of the model
// also useful as cutouts for stacking
module pad_oversize(num_x=1, num_y=1, margins=0) {
  pad_corner_position = gf_pitch/2 - 4; // must be 17 to be compatible
  bevel1_top = 0.8;     // z of top of bottom-most bevel (bottom of bevel is at z=0)
  bevel2_bottom = 2.6;  // z of bottom of second bevel
  bevel2_top = 5;       // z of top of second bevel
  bonus_ht = 0.2;       // extra height (and radius) on second bevel
  
  // female parts are a bit oversize for a nicer fit
  radialgap = margins ? 0.25 : 0;  // oversize cylinders for a bit of clearance
  axialdown = margins ? 0.1 : 0;   // a tiny bit of axial clearance present in Zack's design
  
  translate([0, 0, -axialdown])
  difference() {
    union() {
      hull() cornercopy(pad_corner_position, num_x, num_y) {
        if (sharp_corners) {
          cylsq(d=1.6+2*radialgap, h=0.1);
          translate([0, 0, bevel1_top]) cylsq(d=3.2+2*radialgap, h=1.9);
        }
        else {
          cylinder(d=1.6+2*radialgap, h=0.1, $fn=24);
          translate([0, 0, bevel1_top]) cylinder(d=3.2+2*radialgap, h=1.9, $fn=32);
        }
      }
      
      hull() cornercopy(pad_corner_position, num_x, num_y) {
        if (sharp_corners) {
          translate([0, 0, bevel2_bottom]) 
          cylsq2(d1=3.2+2*radialgap, d2=7.5+0.5+2*radialgap+2*bonus_ht, h=bevel2_top-bevel2_bottom+bonus_ht);
        }
        else {
          translate([0, 0, bevel2_bottom]) 
          cylinder(d1=3.2+2*radialgap, d2=7.5+0.5+2*radialgap+2*bonus_ht, h=bevel2_top-bevel2_bottom+bonus_ht, $fn=32);
        }
      }
    }
    
    // cut off bottom if we're going to go negative
    if (margins) {
      translate([-gf_pitch/2, -gf_pitch/2, 0])
      cube([gf_pitch*num_x, gf_pitch*num_y, axialdown]);
    }
  }
}

// similar to cornercopy, can only copy to box corners
module gridcopycorners(num_x, num_y, r, onlyBoxCorners = false, pitch=gf_pitch) {
  for (xi=[1:ceil(num_x)]) for (yi=[1:ceil(num_y)]) 
    for (xx=[-1, 1]) for (yy=[-1, 1]) {
      quadrent = [xi+(xx == -1 ? -0.5 : 0), yi+(yy == -1 ? -0.5 : 0)];
      trans = [pitch*(xi-1)+xx*r, pitch*(yi-1)+ yy*r, 0];
      $gcci=[trans,[xi,yi],[xx,yy]];
      //echo("gridcopycorners", num_x=num_x,num_y=num_y, gcci=$gcci, quadrent=quadrent);
      //only copy if the cell is atleast half size
      if(quadrent.x <= num_x && quadrent.y <= num_y)
        //only box corners or every cell corner
        if(!onlyBoxCorners || 
          (xi == 1 && yi == 1 && xx == -1 && yy == -1) ||
          (xi == floor(num_x) && yi == floor(num_y) && xx == 1 && yy == 1) ||
          (xi == 1 && yi == floor(num_y) && xx == -1 && yy == 1) ||
          (xi == floor(num_x) && yi == 1 && xx == 1 && yy == -1)) 
          translate(trans)
          children();
    }
}

// similar to quadtranslate but expands to extremities of a block
module cornercopy(r, num_x=1, num_y=1,pitch=gf_pitch) {
  for (xx=[0, 1]) 
    for (yy=[0, 1]) 
    {
      $idx=[xx,yy,0];
      xpos = xx == 0 ? -r : pitch*(num_x-1)+r;
      ypos = yy == 0 ? -r : pitch*(num_y-1)+r;
      translate([xpos, ypos, 0]) 
        children();
    }
}


// make repeated copies of something(s) at the gridfinity spacing of 42mm
module gridcopy(num_x, num_y, pitch=gf_pitch) {
  for (xi=[0:num_x-1]) 
    for (yi=[0:num_y-1])
    {
      $gci=[xi,yi,0];
      translate([pitch*xi, pitch*yi, 0]) 
        children();
    }
}
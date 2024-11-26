include <module_utility.scad>
include <functions_general.scad>
include <gridfinity_constants.scad>
include <functions_gridfinity.scad>
include <module_gridfinity_cup_base.scad>     
include <module_lip.scad>      

// basic block with cutout in top to be stackable, optional holes in bottom
// start with this and begin 'carving'
module grid_block(
  num_x=1, 
  num_y=2, 
  num_z=2, 
  position = "zero",
  lipStyle = "normal",    //"minimum" "none" "reduced" "normal"
  filledin = "disabled", //[disabled, enabled, enabledfilllip]
  wall_thickness = 1.2,
  cupBase_settings = CupBaseSettings(),
  $fn = 32,
  help)
{
  lipHeight = 3.75;

  assert_openscad_version();
  cupBase_settings = ValidateCupBaseSettings(cupBase_settings);

  //Legacy variables.
  magnet_size=cupBase_settings[iCupBase_MagnetSize];
  screw_size=cupBase_settings[iCupBase_ScrewSize];
  hole_overhang_remedy=cupBase_settings[iCupBase_HoleOverhangRemedy];
  box_corner_attachments_only = cupBase_settings[iCupBase_CornerAttachmentsOnly];
  half_pitch=cupBase_settings[iCupBase_HalfPitch];
  flat_base=cupBase_settings[iCupBase_FlatBase];
  center_magnet_size = cupBase_settings[iCupBase_CenterMagnetSize];
  magnet_easy_release = cupBase_settings[iCupBase_MagnetEasyRelease];
  
  outer_size = gf_pitch - gf_tolerance;  // typically 41.5
  block_corner_position = outer_size/2 - gf_cup_corner_radius;  // need not match center of pad corners

  magnet_position = calculateMagnetPosition(magnet_size[iCylinderDimension_Diameter]);
   
  overhang_fix = hole_overhang_remedy > 0 && magnet_size[iCylinderDimension_Diameter] > 0 && screw_size[iCylinderDimension_Diameter] > 0 ? hole_overhang_remedy : 0;
  overhang_fix_depth = 0.3;  // assume this is enough
  
  tz(gf_zpitch*num_z-fudgeFactor*2)
  if(filledin == "enabledfilllip"){
      color(getColour(color_topcavity))
        tz(-fudgeFactor)
        hull() 
        cornercopy(block_corner_position, num_x, num_y) 
        cylinder(r=gf_cup_corner_radius, h=lipHeight, $fn=$fn);
    } else {
    cupLip(
      num_x = num_x, 
      num_y = num_y, 
      lipStyle = lipStyle,
      wall_thickness = wall_thickness);
    }
        
  translate(cupPosition(position,num_x,num_y))
  difference() {
    baseHeight = 5;
    intersection() {
      //Main cup outer shape
      color(getColour(color_cup))
        tz(-fudgeFactor)
        hull() 
        cornercopy(block_corner_position, num_x, num_y) 
        cylinder(r=gf_cup_corner_radius, h=gf_zpitch*num_z+fudgeFactor*3, $fn=$fn);

      union(){
        // logic for constructing odd-size grids of possibly half-pitch pads
        color(getColour(color_base))
          pad_grid(num_x, num_y, half_pitch, flat_base);
        
        color(getColour(color_cup))
        tz(baseHeight) 
          cube([gf_pitch*num_x, gf_pitch*num_y, gf_zpitch*num_z]);
      }
    }
    
    if(center_magnet_size[iCylinderDimension_Diameter]){
      //Center Magnet
      for(x =[0:1:num_x-1])
      {
        for(y =[0:1:num_y-1])
        {
          color(getColour(color_basehole))
          translate([x*gf_pitch,y*gf_pitch,-fudgeFactor])
            cylinder(h=center_magnet_size[iCylinderDimension_Height]-fudgeFactor, d=center_magnet_size[iCylinderDimension_Diameter], $fn=$fn);
        }
      }
    }
    
    color(getColour(color_basehole))
    tz(-fudgeFactor)
    gridcopycorners(num_x, num_y, magnet_position, box_corner_attachments_only){
        rdeg =
          $gcci[2] == [ 1, 1] ? 90 :
          $gcci[2] == [-1, 1] ? 180 :
          $gcci[2] == [-1,-1] ? -90 :
          $gcci[2] == [ 1,-1] ? 0 : 0;
        rotate([0,0,rdeg-45+(magnet_easy_release==MagnetEasyRelease_outer ? 0 : 180)])
        MagnetAndScrewRecess(
          magnetDiameter = magnet_size[iCylinderDimension_Diameter],
          magnetThickness = magnet_size[iCylinderDimension_Height]+0.1,
          screwDiameter = screw_size[iCylinderDimension_Diameter],
          screwDepth = screw_size[iCylinderDimension_Height],
          overhangFixLayers = overhang_fix,
          overhangFixDepth = overhang_fix_depth,
          easyMagnetRelease = magnet_easy_release != MagnetEasyRelease_off);
    }
  }
 
  HelpTxt("grid_block",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"magnet_size",magnet_size
    ,"screw_size",screw_size
    ,"position",position
    ,"hole_overhang_remedy",hole_overhang_remedy
    ,"half_pitch",half_pitch
    ,"box_corner_attachments_only",box_corner_attachments_only
    ,"flat_base",flat_base
    ,"lipStyle",lipStyle
    ,"filledin",filledin]
    ,help);
}

module pad_grid(num_x, num_y, half_pitch=false, flat_base=false) {
  assert(!is_undef(num_x), "num_x is undefined");
  assert(!is_undef(num_y), "num_y is undefined");

  if (flat_base) {
    pad_oversize(num_x, num_y);
  }
  else if (half_pitch) {
    gridcopy(ceil(num_x*2), ceil(num_y*2), gf_pitch/2) {
      echo("pad_grid", gci=$gci);
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


//pad_oversize(  margins=1,extend_down=5);
// unit pad slightly oversize at the top to be trimmed or joined with other feet or the rest of the model
// also useful as cutouts for stacking
module pad_oversize(
  num_x=1, 
  num_y=1, 
  margins=0,
  extend_down = 0) {
  
  assert(!is_undef(num_x), "num_x is undefined");
  assert(is_num(num_x), "num_x must be a number");
  assert(!is_undef(num_y), "num_y is undefined");
  assert(is_num(num_y), "num_y must be a number");
  assert(!is_undef(margins), "margins is undefined");
  assert(is_num(margins), "margins must be a number >= 0");
  assert(!is_undef(extend_down), "extend_down is undefined");
  assert(is_num(extend_down), "extend_down must be a number >= 0");
  
  if(IsHelpEnabled("trace")) echo("pad_oversize", num_x=num_x, num_y=num_y, margins= margins);
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
      //top over size taper
      hull() cornercopy(pad_corner_position, num_x, num_y) {
        if (sharp_corners) {
          translate(bevel2_bottom) 
          cylsq2(d1=3.2+2*radialgap, d2=7.5+0.5+2*radialgap+2*bonus_ht, h=bevel2_top-bevel2_bottom+bonus_ht);
        }
        else {
          tz(bevel2_bottom) 
          cylinder(d1=3.2+2*radialgap, d2=7.5+0.5+2*radialgap+2*bonus_ht, h=bevel2_top-bevel2_bottom+bonus_ht, $fn=32);
        }
      }
      
      hull() 
        cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            cylsq(d=1.6+2*radialgap, h=0.1);
            translate([0, 0, bevel1_top]) cylsq(d=3.2+2*radialgap, h=1.9);
          }
          else {
            cylinder(d=1.6+2*radialgap, h=0.1, $fn=24);
            translate([0, 0, bevel1_top]) 
              cylinder(d=3.2+2*radialgap, h=1.9, $fn=32);
          }
      }
 
      if(extend_down > 0)
      translate([0,0,-extend_down])
      difference(){
        hull() 
        cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            cylsq(d=1.6+2*radialgap, h=margins+extend_down+0.1);
          }
          else {
            cylinder(d=1.6+2*radialgap, h=margins+extend_down+0.1, $fn=24);
          }
        }
        //for baseplate patterns
        children();
      }
    }
    
    // cut off bottom if we're going to go negative
    if (margins && extend_down == 0) {
      cube([gf_pitch*num_x, gf_pitch*num_y, axialdown]);
    }
  }
}

function vector_sum(v,start=0,end) = 
  let(v=is_list(v)?v:[v], end = is_undef(end)?len(v)-1:min(len(v)-1,end) )
    start<end? v[start]+ vSum(v,start+1,end):
               v[start];             
 
// make repeated copies of something(s) at the gridfinity spacing of 42mm
module gridcopy(
  num_x, 
  num_y, 
  pitch=gf_pitch, 
  positionGridx = "near", 
  positionGridy = "near") {
  assert(is_num(num_x) && num_x>=0, "num_x must be a number greater than 1");
  assert(is_num(num_y) && num_y>=0, "num_y must be a number greater than 1");
  assert(is_num(pitch) && pitch>=1, "pitch must be a number greater than 1");
  
  function num_to_list(num, positionGrid = "near") = 
    let(
      centerGrid = positionGrid == "center",
      padding = ceil(num) != num ? (num - floor(num))/(centerGrid?2:1) : 0,
      count = ceil(num) + ((padding > 0 && centerGrid) ? 1 :0))
      [for (i = [ 0 : count - 1 ]) 
        i == 0 && padding != 0 && (positionGrid == "center" || positionGrid == "near") ? padding
          : i == count-1 && padding != 0 && (positionGrid == "center" || positionGrid == "far") ? padding
          : 1];
  
  xCellsList = num_to_list(num_x, positionGridx);
  yCellsList = num_to_list(num_y, positionGridy);
  
  $gc_count=[len(xCellsList), len(yCellsList)];
  
  for (xi=[0:len(xCellsList)-1]) 
    for (yi=[0:len(yCellsList)-1])
    {
      $gci=[xi,yi,0];
      $gc_size=[xCellsList[xi], yCellsList[yi], 0];
      $gc_position=[
        vector_sum(xCellsList, 0, xi)-xCellsList[xi], 
        vector_sum(yCellsList, 0, yi)-yCellsList[yi], 0];
      translate([$gc_position.x,$gc_position.y,0]*pitch)
        children();
    }
}

// similar to cornercopy, can only copy to box corners
module gridcopycorners(num_x, num_y, r, onlyBoxCorners = false, pitch=gf_pitch, center = false) {
  assert(!is_undef(r), "r is undefined");
  assert(!is_undef(num_x), "num_x is undefined");
  assert(!is_undef(num_y), "num_y is undefined");
  
  translate(center ? [0,0] : [pitch/2,pitch/2])
  for (cellx=[1:ceil(num_x)], celly=[1:ceil(num_y)]) 
    for (quadrentx=[-1, 1], quadrenty=[-1, 1]) {
      cell = [cellx, celly];
      quadrent = [quadrentx, quadrenty];
      gridPosition = [cell.x+(quadrent.x == -1 ? -0.5 : 0), cell.y+(quadrent.y == -1 ? -0.5 : 0)];
      trans = [pitch*(cell.x-1)+quadrent.x*r, pitch*(cell.y-1)+ quadrent.y*r, 0];
      $gcci=[trans,cell,quadrent];
      if(IsHelpEnabled("info")) echo("gridcopycorners", num_x=num_x,num_y=num_y, gcci=$gcci, gridPosition=gridPosition);
      //only copy if the cell is atleast half size
      if(gridPosition.x <= num_x && gridPosition.y <= num_y)
        //only box corners or every cell corner
        if(!onlyBoxCorners || 
          ((cell.x == 1 && quadrent.x == -1) && (cell.y == 1  && quadrent.y == -1)) ||
          (gridPosition.x*2 == floor(num_x*2) && gridPosition.y*2 == floor(num_y*2)) ||
          ((cell.x == 1 && quadrent.x == -1) && gridPosition.y*2 == floor(num_y*2) ) ||
          (gridPosition.x*2 == floor(num_x*2) && (cell.y == 1 && quadrent.y == -1))) 
          translate(trans)
          children();
    }
}

// Coppies the children to the corners to create a square shape
// r, position of the corner from the center for a full sized. Must be less than half of pitch (normally 17 for gridfinity) .
// num_x, num_y, size of the cube in units of pitch.
// pitch, size of one unit.
// num_x = 1 give r*2, num_x = 2 give r*2+pitch, 
// similar to quadtranslate but expands to extremities of a block
module cornercopy(r, num_x=1, num_y=1,pitch=gf_pitch, center = false) {
  assert(!is_undef(r), "r is undefined");
  assert(!is_undef(num_x), "num_x is undefined");
  assert(!is_undef(num_y), "num_y is undefined");

  translate(center ? [0,0] : [pitch/2,pitch/2])
  for (xx=[0, 1], yy=[0, 1]) {
    $idx=[xx,yy,0];
    xpos = xx == 0 ? -r : max(pitch*(num_x-1)+r,-r);
    ypos = yy == 0 ? -r : max(pitch*(num_y-1)+r,-r);
    if(IsHelpEnabled("info")) echo("cornercopy", num_x=num_x,num_y=num_y,pitch=pitch, center=center, idx=$idx, gridPosition=[xpos,ypos,0]);
    translate([xpos, ypos, 0]) 
      children();
  }
}
include <thirdparty/ub_helptxt.scad>
include <module_utility.scad>
include <functions_environment.scad>
include <functions_general.scad>
include <gridfinity_constants.scad>
include <functions_gridfinity.scad>
include <module_gridfinity_cup_base.scad>     

module pad_grid(
  num_x, 
  num_y, 
  half_pitch=false, 
  flat_base="off", 
  minimium_size = 0.2,
  pitch=env_pitch(), 
  positionGridx = "near", 
  positionGridy = "near") {
  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_bool(half_pitch));
  assert(is_string(flat_base));
  assert(is_num(minimium_size));

  //echo("pad_grid", flat_base=flat_base, half_pitch=half_pitch, positionGridx=positionGridx, positionGridy=positionGridy, minimium_size=minimium_size);
  pad_copy(
    num_x = num_x, 
    num_y = num_y, 
    half_pitch = half_pitch, 
    flat_base = flat_base, 
    minimium_size = minimium_size,
    pitch=pitch, 
    positionGridx = positionGridx, 
    positionGridy = positionGridy)
      pad_oversize($pad_copy_size.x, $pad_copy_size.y);
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

module frame_cavity(
  num_x = 2, 
  num_y = 1, 
  position_fill_grid_x = "near",
  position_fill_grid_y = "near",
  render_top = true,
  render_bottom = true,
  remove_bottom_taper = false,
  extra_down=0, 
  frameLipHeight = 4,
  cornerRadius = gf_cup_corner_radius,
  reducedWallHeight = -1,
  reducedWallWidth = -1,
  reducedWallOuterEdgesOnly=false,
  enable_grippers = false) {

  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_string(position_fill_grid_x));
  assert(is_string(position_fill_grid_y));
  assert(is_bool(render_top));
  assert(is_bool(render_bottom));
  assert(is_bool(remove_bottom_taper));
  assert(is_num(extra_down));
  assert(is_num(frameLipHeight));
  assert(is_num(cornerRadius));
  assert(is_num(reducedWallHeight));
  assert(is_num(reducedWallWidth));
  assert(is_bool(reducedWallOuterEdgesOnly));
  assert(is_bool(enable_grippers));

  frameWallReduction = reducedWallHeight >= 0 ? max(0, frameLipHeight-reducedWallHeight) : -1;

    translate([0, 0, -fudgeFactor]) 
      gridcopy(
        num_x, 
        num_y,
        positionGridx = position_fill_grid_x,
        positionGridy = position_fill_grid_y) {
      if($gc_size.x > 0.2 && $gc_size.y >= 0.2){
        if(frameWallReduction>=0)
          for(side=[[0, [$gc_size.x, $gc_size.y]*env_pitch().x, "x"],[90, [$gc_size.y, $gc_size.x]*env_pitch().y, "y"]]){
            if(side[1].x >= env_pitch().x/2)
            if(!reducedWallOuterEdgesOnly || ($gc_is_corner[1] && side[2] =="x") || ($gc_is_corner[0] && side[2] =="y"))
            translate([$gc_size.x/2*env_pitch().x,$gc_size.y/2*env_pitch().y,frameLipHeight])
            rotate([0,0,side[0]])
              WallCutout(
                lowerWidth=side[1].x-(reducedWallWidth > 0 ? reducedWallWidth*2 : 20),
                wallAngle=80,
                height=frameWallReduction,
                thickness=side[1].y+fudgeFactor*2,
                cornerRadius=frameWallReduction,
                topHeight=1);
              }

          //wall reducers, cutouts and clips
          if($children >=2) children(1);

          pad_oversize(
            num_x=$gc_size.x,
            num_y=$gc_size.y,
            margins=1,
            extend_down=extra_down,
            render_top=render_top,
            render_bottom=render_bottom,
            remove_bottom_taper=remove_bottom_taper)
              //cell cavity
              if($children >=1) children(0);
    }
  }
}

// unit pad slightly oversize at the top to be trimmed or joined with other feet or the rest of the model
// also useful as cutouts for stacking
//pad_oversize(margins=1,extend_down=5, $fn=64);
module pad_oversize(
  num_x=1, 
  num_y=1, 
  margins=0,
  render_top = true,
  render_bottom = true,
  remove_bottom_taper = false,
  extend_down = 0) {
  
  assert(!is_undef(num_x), "num_x is undefined");
  assert(is_num(num_x), "num_x must be a number");
  assert(!is_undef(num_y), "num_y is undefined");
  assert(is_num(num_y), "num_y must be a number");
  assert(!is_undef(margins), "margins is undefined");
  assert(is_num(margins), "margins must be a number >= 0");
  assert(!is_undef(extend_down), "extend_down is undefined");
  assert(is_num(extend_down), "extend_down must be a number >= 0");
  
  if(env_help_enabled("trace")) echo("pad_oversize", num_x=num_x, num_y=num_y, margins= margins);

  // pad_corner_position = [env_pitch().x/2 - 4,env_pitch().y/2 - 4]; 
  // must be 17 to be compatible
  pad_corner_position = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];

  bevel1_top = 0.8;     // z of top of bottom-most bevel (bottom of bevel is at z=0)
  bevel2_bottom = 2.6;  // z of bottom of second bevel
  bevel2_top = 5;       // z of top of second bevel
  bonus_ht = 0.2;       // extra height (and radius) on second bevel
  
  // female parts are a bit oversize for a nicer fit
  radialgap = margins ? 0.25 : 0;  // oversize cylinders for a bit of clearance
  //axialdown = margins ? 0.1 : 0;   // a tiny bit of axial clearance present in Zack's design
  //remove axialdown as it messes up the placement of the attachements 
  axialdown =0;
  fudgeFactor = 0.01;
  
  translate([0, 0, -axialdown])
  difference() {
    union() {
      //top over size taper
      if(render_top){
        hull() cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            translate(bevel2_bottom) 
            cylsq2(d1=(env_corner_radius()-2.15+radialgap)*2, d2=(env_corner_radius()+0.25+radialgap+bonus_ht)*2, h=bevel2_top-bevel2_bottom+bonus_ht);
          }
          else {
            tz(bevel2_bottom) 
            cylinder(d1=(env_corner_radius()-2.15+radialgap)*2, d2=(env_corner_radius()+0.25+radialgap+bonus_ht)*2, h=bevel2_top-bevel2_bottom+bonus_ht);
          }
        }
      }
      
      if(render_bottom){ 
        hull()
        cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            cylsq(d=1.6+2*radialgap, h=0.1);
            translate([0, 0, bevel1_top]) 
            cylsq(d=(env_corner_radius()-2.15+radialgap)*2, h=1.9+bevel2_top-bevel2_bottom+bonus_ht);
          }
          else {
            cylinder(d=remove_bottom_taper ? (env_corner_radius()-2.15+radialgap)*2 : 1.6+2*radialgap, h=0.1);
            translate([0, 0, bevel1_top]) 
              cylinder(d=(env_corner_radius()-2.15+radialgap)*2, h=1.9+bevel2_top-bevel2_bottom+bonus_ht);
          }
        }
      }
 
      if(extend_down > 0)
      translate([0,0,-extend_down])
      difference(){
        hull() 
        cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            cylsq(d=1.6+2*radialgap, h=extend_down+fudgeFactor);
          }
          else {
            cylinder(d=1.6+2*radialgap, h=extend_down+fudgeFactor);
          }
        }
        //for baseplate patterns
        children();
      }
    }
    
    // cut off bottom if we're going to go negative
    if (margins && extend_down == 0) {
      cube([env_pitch().x*num_x, env_pitch().y*num_y, axialdown]);
    }
  }
}
 
module pad_copy(
  num_x, num_y, 
  half_pitch=false, 
  flat_base="off", 
  minimium_size = 0.2,
  pitch=env_pitch(), 
  positionGridx = "near", 
  positionGridy = "near") {
  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_bool(half_pitch));
  assert(is_string(flat_base));
  assert(is_num(minimium_size));

  if(env_help_enabled("debug")) echo("pad_copy", flat_base=flat_base, half_pitch=half_pitch, minimium_size=minimium_size);
 
  if (flat_base != FlatBase_off) {
    $pad_copy_size = [num_x, num_y];
    if(env_help_enabled("debug")) echo("pad_grid_flat_base", pad_copy_size=$pad_copy_size);
    if($pad_copy_size.x >= minimium_size && $pad_copy_size.y >= minimium_size) {
      children();
    }
  }
  else if (half_pitch) {
    gridcopy(
      num_x=num_x*2, 
      num_y=num_y*2, 
      pitch=[pitch.y/2,pitch.x/2,pitch.z],
      positionGridx = positionGridx, 
      positionGridy = positionGridy) {
      $pad_copy_size = $gc_size/2;
      if(env_help_enabled("debug")) echo("pad_grid_half_pitch", gci=$gci, gc_size=$gc_size, pad_copy_size=$pad_copy_size);
      if($pad_copy_size.x >= minimium_size && $pad_copy_size.y >= minimium_size) {
         children();      }
    }
  }
  else {
    gridcopy(
      num_x=num_x, 
      num_y=num_y, 
      pitch=pitch,
      positionGridx = positionGridx, 
      positionGridy = positionGridy) {
      $pad_copy_size = $gc_size;
      if(env_help_enabled("debug")) echo("pad_grid", gci=$gci, gc_size=$gc_size, pad_copy_size=$pad_copy_size);
      if($pad_copy_size.x >= minimium_size && $pad_copy_size.y >= minimium_size) {
        children();
      }
    }
  }
}

// make repeated copies of something(s) at the gridfinity spacing of 42mm
module gridcopy(
  num_x, 
  num_y, 
  pitch=env_pitch(), 
  positionGridx = "near", 
  positionGridy = "near") {
  assert(is_num(num_x) && num_x>=0, "num_x must be a number greater than 1");
  assert(is_num(num_y) && num_y>=0, "num_y must be a number greater than 1");
  assert(is_list(pitch));
  
  function num_to_list(num, positionGrid = "near") = 
    let(
      centerGrid = positionGrid == "center",
      padding = ceil(num) != num ? (num - floor(num))/(centerGrid?2:1) : 0,
      count = ceil(num) + ((padding > 0 && centerGrid) ? 1 :0),
      hasPrePad = padding != 0 && (positionGrid == "center" || positionGrid == "far"),
      hasPostPad = padding != 0 && (positionGrid == "center" || positionGrid == "near"))
      [for (i = [ 0 : count - 1 ]) 
        i == 0 && hasPrePad ? [padding,false]
          : i == count-1 && hasPostPad ? [padding,false]
          : [1, 
            (i == 0 && !hasPrePad) ||
            (i == 1 && hasPrePad) ||
            (i == (count-1) && !hasPostPad) ||
            (i == (count-2) && hasPostPad)]];    
    
  xCellsList = num_to_list(num_x, positionGridx);
  yCellsList = num_to_list(num_y, positionGridy);
  
  $gc_count=[len(xCellsList), len(yCellsList)];
  
  if(env_help_enabled("debug")) echo("gridcopy", xCellsList=xCellsList, yCellsList=yCellsList);
  
  for (xi=[0:len(xCellsList)-1]) 
    for (yi=[0:len(yCellsList)-1])
    {
      $gci=[xi,yi,0];
      $gc_count=[len(xCellsList), len(yCellsList), 0];
      $gc_size=[xCellsList[xi][0], yCellsList[yi][0], 0];
      //is this a corner really means is outer edge.
      $gc_is_corner=[xCellsList[xi][1], yCellsList[yi][1]];
      $gc_position=[
        vector_sum(xCellsList, 0, xi,0)-xCellsList[xi][0], 
        vector_sum(yCellsList, 0, yi,0)-yCellsList[yi][0], 0];
      translate([$gc_position.x*pitch.x,$gc_position.y*pitch.y,0])
        children();
    }
}         
  
// similar to cornercopy, can only copy to box corners
// r, position of the corner from the center for a full sized. Must be less than half of pitch (normally 17 for gridfinity) .
// num_x, num_y, size of the cube in units of pitch.
// pitch, size of one unit.
// center, center the grid
// reverseAlignment, reverse the alignment of the corners
module gridcopycorners(
  num_x, 
  num_y, 
  r, 
  onlyBoxCorners = false, 
  pitch=env_pitch(), 
  center = false, 
  reverseAlignment=[false,false]) {
  assert(is_list(pitch), "pitch must be a list");
  assert(is_list(r), "pitch must be a list");
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  r = is_num(r) ? [r,r] : r;
  
  translate(center ? [0,0] : [pitch.x/2,pitch.y/2])
  for (cellx=[1:ceil(num_x)], celly=[1:ceil(num_y)]) 
    for (quadrentx=[-1, 1], quadrenty=[-1, 1]) {
      cell = [cellx, celly];
      quadrent = [quadrentx, quadrenty];
      gridPosition = [cell.x+(quadrent.x == -1 ? -0.5 : 0), cell.y+(quadrent.y == -1 ? -0.5 : 0)];
      trans = [pitch.x*(cell.x-1)+quadrent.x*r.x, pitch.y*(cell.y-1)+ quadrent.y*r.y, 0];
      $gcci=[trans,cell,quadrent];

      cornerVisible = 
        (!reverseAlignment.x && gridPosition.x <= num_x || reverseAlignment.x && 1.5-gridPosition.x <= num_x) && 
        (!reverseAlignment.y && gridPosition.y <= num_y || reverseAlignment.y && 1.5-gridPosition.y <= num_y);
      if(env_help_enabled("debug")) echo("gridcopycorners", num_x=num_x,num_y=num_y, gcci=$gcci, gridPosition=gridPosition, reverseAlignment=reverseAlignment, cornerVisible=cornerVisible);
      //only copy if the cell is atleast half size
      if(cornerVisible)
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
module cornercopy(r, num_x=1, num_y=1,pitch=env_pitch(), center = false) {
  assert(!is_undef(r), "r is undefined");
  assert(is_list(pitch), "pitch must be a list");
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  r = is_num(r) ? [r,r] : r;

  translate(center ? [0,0] : [pitch.x/2,pitch.y/2])
  for (xx=[0, 1], yy=[0, 1]) {
    $idx=[xx,yy,0];
    xpos = xx == 0 ? -r.x : max(pitch.x*(num_x-1)+r.x,-r.x);
    ypos = yy == 0 ? -r.y : max(pitch.y*(num_y-1)+r.y,-r.y);
    if(env_help_enabled("debug")) echo("cornercopy", num_x=num_x,num_y=num_y,pitch=pitch, center=center, idx=$idx, gridPosition=[xpos,ypos,0]);
    translate([xpos, ypos, 0]) 
      children();
  }
}

module debug_cut(cutx, cuty, cutz) {
  cutx = is_undef(cutx) ? env_cutx() : cutx;
  cuty = is_undef(cuty) ? env_cuty() : cuty;
  cutz = is_undef(cutz) ? env_cutz() : cutz;
  
  num_x = env_numx();
  num_y = env_numy();
  num_z = env_numz();
  
  difference(){
    children();
    
    //Render the cut, used for debugging
    if(cutx != 0 && $preview){
      color(color_cut)
      translate(cutx > 0 
        ? [-fudgeFactor,-fudgeFactor,-fudgeFactor]
        : [(num_x-abs(cutx))*env_pitch().x-fudgeFactor,-fudgeFactor,-fudgeFactor])
      translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
        cube([
            abs(cutx)*env_pitch().x, 
            num_y*env_pitch().y+fudgeFactor*2,
            (num_z+1)*env_pitch().z+fudgeFactor*2]);
    }
    if(cuty != 0 && $preview){
      color(color_cut)
      translate(cuty > 0 
        ? [-fudgeFactor,-fudgeFactor,-fudgeFactor]
        : [-fudgeFactor,(num_y-abs(cuty))*env_pitch().y-fudgeFactor,-fudgeFactor])
        cube([
          num_x*env_pitch().x+fudgeFactor*2,
          abs(cuty)*env_pitch().y,
          (num_z+1)*env_pitch().z+fudgeFactor*2]);
    }
    if(cutz != 0 && $preview){
      color(color_cut)
      translate(cutz > 0 
        ? [-fudgeFactor,-fudgeFactor,-fudgeFactor]
        : [-fudgeFactor,-fudgeFactor,(num_z+1-abs(cutz))*env_pitch().z-fudgeFactor]
        )
        cube([
          num_x*env_pitch().x+fudgeFactor*2,
          num_y*env_pitch().y+fudgeFactor*2,
          abs(cutz)*env_pitch().z]);
    }
  }
}
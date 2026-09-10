include <functions_general.scad>
include <utility/module_utility.scad>
include <utility/chamfered_shapes.scad>

slat_debug = false;

if(slat_debug && $preview){
  slat_pattern();
}

module slat_pattern(
  canvis_size=[31,31],
  thickness = 1,
  spacing = 2,
  border = 0,
  slat_width = 5,
  slat_chamfer = [-2,-2],
  center = true,
  rotateGrid = false){
  
  assert(is_list(canvis_size) && len(canvis_size) == 2, "canvis_size must be a list of len 2");
  assert(is_num(thickness), "thickness must be a number");
  assert(is_num(spacing), "spacing must be a number");
  assert(is_num(border), "border must be a number");
  assert(is_num(slat_chamfer) || is_list(slat_chamfer), "slat_chamfer must be a number");
  assert(is_bool(center), "center must be a bool");
  assert(is_bool(rotateGrid), "rotateGrid must be a bool");

  chamfer = is_num(slat_chamfer) ? [0, slat_chamfer] : slat_chamfer;
  
  assert(is_list(chamfer), "chamfer must be list"); 

  echo("slat_pattern", chamfer=chamfer, slat_chamfer=slat_chamfer);
  
  working_canvis_size = 
    let (cs = rotateGrid ? [canvis_size.y,canvis_size.x] : canvis_size)
    border > 0 ? [cs.x-border*2,cs.y-border*2] : cs;
  
  nx = floor((working_canvis_size.x + spacing) / (slat_width + spacing));
    
  if(nx > 0)
  translate(center ? [0,0,0] : [canvis_size.x/2,canvis_size.y/2,0])
  rotate(rotateGrid?[0,0,90]:[0,0,0])
  translate([-working_canvis_size.x/2,-working_canvis_size.y/2])
  for(ix=[0:nx-1]){
    let(
      width = (working_canvis_size.x + spacing)/nx-spacing,
      size = [width, working_canvis_size.y, thickness])
    translate([(width+spacing)*ix,0])
    chamfered_cube(
      size,
      topChamfer = chamfer[1],
      bottomChamfer = chamfer[0]);
  }
}
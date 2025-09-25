include <functions_general.scad>
include <module_utility.scad>

module brick_pattern(
  canvis_size=[31,31],
  thickness = 1,
  spacing = 1,
  border = 0,
  cell_size = [15,5],
  corner_radius = 3,
  center_weight = 3,
  offset_layers = false,
  center = true,
  rotateGrid = false){
  
  assert(is_list(canvis_size) && len(canvis_size) == 2, "canvis_size must be a list of len 2");
  assert(is_num(thickness), "thickness must be a number");
  assert(is_num(spacing), "spacing must be a number");
  assert(is_num(border), "border must be a number");
  assert(is_list(cell_size) && len(cell_size) == 2, "cell_size must be a list of len 2");
  assert(is_num(corner_radius), "corner_radius must be a number");
  assert(is_num(center_weight), "center_weight must be a number");
  assert(is_bool(offset_layers), "offset_layers must be a bool");
  assert(is_bool(center), "center must be a bool");
  assert(is_bool(rotateGrid), "rotateGrid must be a bool");

  corner_radius = min(corner_radius,cell_size.x/2, cell_size.y/2);
  
  working_canvis_size = 
    let (cs = rotateGrid ? [canvis_size.y,canvis_size.x] : canvis_size)
    border > 0 ? [cs.x-border*2,cs.y-border*2] : cs;
    
  ny = floor((working_canvis_size.y + spacing) / (cell_size.y + spacing));
  nx = floor((working_canvis_size.x + spacing) / (cell_size.x + spacing));

  function course(canvis_length, count, spacing, center_weight, half_offset=false) = 
    let(c = count - (half_offset ? 0 : 1),
    l = [for (i=[0:c]) 
    (((canvis_length+spacing)/(c) + cos((i)*360/(c))*-1*center_weight)/(half_offset && (i==0 || i==c) ? 2 : 1) - spacing)],
    suml = sum(l),
    comp = half_offset ? 1 : (canvis_length-(c)*spacing)/suml)
    [for (i=[0:c]) l[i]*comp];
    
  if(ny> 0 && nx > 0)
  translate(center ? [0,0,0] : [canvis_size.x/2,canvis_size.y/2,0])
  rotate(rotateGrid?[0,0,90]:[0,0,0])
  translate([-working_canvis_size.x/2,-working_canvis_size.y/2])
  for(iy=[0:ny-1]){
    let(h=(working_canvis_size.y + spacing)/ny-spacing)
    translate([0,(h+spacing)*iy])
    {
      bricks = course(canvis_length=working_canvis_size.x, count=nx, spacing=spacing, center_weight=center_weight, half_offset=offset_layers && iy%2==1);
      for(ix=[0:len(bricks)-1]) {
        pos = sum(bricks, end = ix-1) + spacing*ix;
        size = [bricks[ix], h, thickness];
        if(size.x > min(cell_size.x,cell_size.y)*0.5 && size.y > min(cell_size.x,cell_size.y)*0.5)
          translate([pos,0])
          roundedCube(
            size = size, 
            sideRadius = corner_radius,
            //supportReduction_x = [0,1]
            //supportReduction_y = [0,0],
            //supportReduction_z = [0,0]
            );
      }
    }
  }
}

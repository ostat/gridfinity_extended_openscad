include <gridfinity_constants.scad>
include <module_rounded_negative_champher.scad>
include <module_gridfinity_cup_base.scad>
use <module_gridfinity_block.scad>
use <module_utility.scad>

//creates the gird of efficient floor pads to be added to the cavity for removal from the overall filled in bin.
module efficient_floor_grid(
  num_x, num_y, 
  floorStyle = "on", 
  half_pitch=false, 
  flat_base="off", 
  floor_thickness, 
  efficientFloorGridHeight=0,
  align_grid = [ "near", "near"],
  margins=0) {
  if (flat_base != FlatBase_off) {
    EfficientFloor(num_x, num_y, 
      floor_thickness, 
      margins, 
      floorRounded=(floorStyle == "rounded"),
      floorSmooth=(floorStyle == "smooth" ? 2 : 0),
        efficientFloorGridHeight=efficientFloorGridHeight);
  }
  else if (half_pitch) {
    gridcopy(
      num_x = num_x*2, 
      num_y = num_y*2, 
      pitch = [env_pitch().y/2, env_pitch().x/2, env_pitch().z], 
      positionGridx = align_grid.x, 
      positionGridy = align_grid.y
      ) {
      EfficientFloor(
        $gc_size.x/2,
        $gc_size.y/2, 
        floor_thickness, 
        margins, 
        floorRounded=(floorStyle == "rounded"),
        floorSmooth=(floorStyle == "smooth" ? 1 : 0),
        efficientFloorGridHeight=efficientFloorGridHeight);
    }
  }
  else {
    gridcopy(
      num_x = num_x, 
      num_y = num_y,
      pitch = env_pitch(),
      positionGridx = align_grid.x,
      positionGridy = align_grid.y) {
      EfficientFloor(
        $gc_size.x,
        $gc_size.y, 
        floor_thickness, 
        margins, 
        floorRounded=(floorStyle == "rounded"),
        floorSmooth=(floorStyle == "smooth" ? 1 :0),
        efficientFloorGridHeight=efficientFloorGridHeight);
    }
  }
}

module EfficientFloorAttachmentCaps(
  grid_copy_corner_index,
  floor_thickness,
  magnet_size,
  screw_size,
  //cornerRadius,
  wall_thickness)
{
  assert(is_list(grid_copy_corner_index) && len(grid_copy_corner_index) >= 3, "grid_copy_corner_index must be a list of length > 3");
  assert(is_num(floor_thickness));
  assert(is_list(magnet_size));
  assert(is_list(screw_size));
  assert(is_num(wall_thickness));
  
  fudgeFactor = 0.01; 
  magnetPosition = calculateAttachmentPositions(magnet_size[iCylinderDimension_Diameter], screw_size[iCylinderDimension_Diameter]);
  blockSize = [env_pitch().x/2-magnetPosition.x+wall_thickness,env_pitch().y/2-magnetPosition.y+wall_thickness];
    
  //$gcci=[trans,xi,yi,xx,yy];
  rotate( grid_copy_corner_index[2] == [ 1, 1] ? [0,0,270] 
         : grid_copy_corner_index[2] == [ 1,-1] ? [0,0,180] 
         : grid_copy_corner_index[2] == [-1,-1] ? [0,0,90] 
         : [0,0,0])
    tz(floor_thickness-fudgeFactor)
    hull(){
      if(screw_size[iCylinderDimension_Diameter] > 0){
        cornerRadius = screw_size[iCylinderDimension_Diameter]/2+wall_thickness*2;
        rotate([0,0,90])
          translate([-cornerRadius,-cornerRadius,0])
          CubeWithRoundedCorner(
            size=[blockSize.x+cornerRadius, blockSize.y+cornerRadius, screw_size[iCylinderDimension_Height]], 
            cornerRadius = cornerRadius,
            edgeRadius = wall_thickness);
      }
      if(magnet_size[iCylinderDimension_Diameter] > 0){
        cornerRadius = magnet_size[iCylinderDimension_Diameter]/2+wall_thickness*2;
        rotate([0,0,90])
        translate([-cornerRadius,-cornerRadius,0])
        CubeWithRoundedCorner(
          size=[blockSize.x+cornerRadius, blockSize.y+cornerRadius, magnet_size[iCylinderDimension_Height]], 
          cornerRadius = cornerRadius,
          edgeRadius = wall_thickness);
      }
    }
}
//Creates the efficient floor pad that will be removed from the floor
module EfficientFloor(
  num_x=1, 
  num_y=1, 
  floor_thickness, 
  margins=0,
  floorRounded = true,
  floorSmooth = 0,
  efficientFloorGridHeight=0){
  fudgeFactor = 0.01;
  floorRadius=floorRounded ? 1 : 0;

  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];

  minEfficientPadSize = floorSmooth ? 0.3 : 0.15;

  cornerRadius = 1.15+margins;
  topChampherCornerRadius = cornerRadius;      
  
  smoothVersion=2;
  //Less than minEfficientPadSize is to small and glitches the cut away
  if(num_x > minEfficientPadSize && num_y > minEfficientPadSize )
  if(floorSmooth == 2) {
    //Smooth floor that does not round over the divider walls
    
    // tapered top portion
    union() {
      tz(5+floor_thickness-fudgeFactor) 
      cornercopy(num_x=num_x, num_y=num_y, r=inner_corner_center) 
      cylinder(r=cornerRadius, h=4);
      
      // tapered top portion
      tz(floor_thickness+cornerRadius)
      hull() {
        cornercopy(num_x=num_x, num_y=num_y, r=[inner_corner_center.x-cornerRadius,inner_corner_center.y-cornerRadius]) 
        sphere(r=cornerRadius);
          
        tz(2.5)
        union(){
          cornercopy(num_x=num_x, num_y=num_y, r=inner_corner_center) 
            cylinder(r=cornerRadius, h=cornerRadius);
          cornercopy(num_x=num_x, num_y=num_y, r=inner_corner_center) 
            sphere(r=cornerRadius);
        }
      }
    }
  } else if(floorSmooth == 1) {
    //Smooth floor that rounds over the divider walls
      union() {
      wallStartHeight = 5;
      topSmoothTransition = efficientFloorGridHeight-wallStartHeight;
      wallTaper = topSmoothTransition/2;
      
    // tapered top portion
      topChampherRadius = topSmoothTransition/2;
      topChampherZBottom = wallStartHeight+wallTaper;
      translate([
        env_pitch().x/2*num_x,
        env_pitch().y/2*num_y,
        topChampherZBottom]) 
      roundedNegativeChampher(
        champherRadius = topChampherRadius, 
        size=[
          (inner_corner_center.x*2+(topChampherCornerRadius)*2+env_pitch().x*(num_x-1)),
          (inner_corner_center.y*2+(topChampherCornerRadius)*2+env_pitch().y*(num_y-1))],
        cornerRadius = topChampherCornerRadius, 
        champher = true,
        height = 4);
      // tapered top portion
      //wallTaper;
     hull() {
        //Bottom layer
        tz(floor_thickness+cornerRadius)
        cornercopy(num_x=num_x, num_y=num_y, r=[inner_corner_center.x-cornerRadius,inner_corner_center.y-cornerRadius]) 
        sphere(r=cornerRadius);
          
        //Top Layer
        tz(wallStartHeight)
          cornercopy(num_x=num_x, num_y=num_y, r=inner_corner_center) 
          roundedCylinder(
            h=cornerRadius,
            r=cornerRadius,
            roundedr1=wallTaper);
      }
    }
  } else {
    //Efficient floor
    taperTopPos = 5-(+2.5-1.15-margins);
    union(){
      // establishes floor
      tz(floor_thickness) 
      hull(){
        cornercopy(num_x=num_x, num_y=num_y, r=[inner_corner_center.x-0.5,inner_corner_center.y-0.5]) 
        roundedCylinder(
          h=3,
          r=1,
          roundedr1=floorRadius);
      }
      
      // tapered top portion
     hull() {
        /*tz(3) 
        cornercopy(num_x=num_x, num_y=num_y, r=inner_corner_center-0.5) 
        cylinder(r=1, h=1);*/
        
        //Not sure why this was changed to a sphere
        tz(3+1/2) 
          cornercopy(num_x=num_x, num_y=num_y, r=[inner_corner_center.x-0.5,inner_corner_center.y-0.5]) 
          sphere(r=1); 

        tz(taperTopPos) 
          cornercopy(num_x=num_x, num_y=num_y, r=inner_corner_center) 
          cylinder(r=cornerRadius, h=4);
      }          

      tz(taperTopPos) 
      if(floorRounded){
        maxRoundOver = 1.25;
        champherRadius = min(efficientFloorGridHeight-taperTopPos,maxRoundOver);

        translate([
          env_pitch().x/2,
          env_pitch().y/2,
          efficientFloorGridHeight-taperTopPos > maxRoundOver ? efficientFloorGridHeight-taperTopPos-champherRadius : 0])
        roundedNegativeChampher(
          champherRadius = champherRadius, 
          size=[
            (inner_corner_center.x*2+(topChampherCornerRadius)*2+env_pitch().x*(num_x-1)),
            (inner_corner_center.y*2+(topChampherCornerRadius)*2+env_pitch().y*(num_y-1))],
          cornerRadius = cornerRadius, 
          height = 4);
      }
    }
  }
}
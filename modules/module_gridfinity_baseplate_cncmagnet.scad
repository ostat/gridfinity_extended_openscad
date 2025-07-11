// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
use <module_gridfinity_block.scad>
use <module_gridfinity_baseplate_common.scad>

cncmagnet_baseplate(1,2, magnetSize = [0,0]);

BasePlateSettings_cncmagnet = ["cncmagnet", [
  [iBaseplateTypeSettings_SupportsMagnets, true],
  ]];
  
module cncmagnet_baseplate(
  num_x, 
  num_y,
  cornerRadius = gf_cup_corner_radius,
  magnetSize= [gf_baseplate_magnet_od,gf_baseplate_magnet_thickness],
  roundedCorners = 15) 
{
  magnetEnable = magnetSize[0] >0 && magnetSize[1] > 0;
  magnetSize = magnetSize ? magnetSize : [0,0];
  
  magnet_position = calculateAttachmentPositions(gf_baseplate_magnet_od);
  
  frameHeight = magnetSize[1];
  magnetborder = 5;
  
  difference() {
    translate([0, 0, frameHeight])
      cnc_baseplate(num_x, num_y, 
        extra_down=frameHeight,
        cornerRadius = cornerRadius,
        roundedCorners = roundedCorners);
        
    if(magnetEnable){
      gridcopy(num_x, num_y) {
        cornercopy(magnet_position) {
          translate([0, 0, -fudgeFactor])
           cylinder(d=magnetSize[0], h=magnetSize[1]+fudgeFactor*2);
        }
      }
    }
  }
}

module cnc_baseplate(
    num_x, 
    num_y, 
    extra_down=0, 
    height = 4,
    cornerRadius = gf_cup_corner_radius,
    roundedCorners = 15) {

  corner_position = [env_pitch().x/2-cornerRadius, env_pitch().y/2-cornerRadius];
  
  difference() {
    color(color_cup)
    hull() 
      //render()
      cornercopy(r=corner_position, num_x, num_y) {
        radius = bitwise_and(roundedCorners, decimaltobitwise($idx[0],$idx[1])) > 0 ? cornerRadius : 0.01;// 0.01 is almost zero....
        ctrn = [
          ($idx[0] == 0 ? -1 : 1)*(cornerRadius-radius), 
          ($idx[1] == 0 ? -1 : 1)*(cornerRadius-radius), -extra_down];
        translate(ctrn)
        cylinder(r=radius, h=height+extra_down);
      }
      
    color(color_topcavity)
    translate([0, 0, -fudgeFactor]) 
      gridcopy(num_x, num_y)
      hull() 
        cornercopy(corner_position, 1, 1)
        cylinder(r=2,h=height+fudgeFactor*2);
  }
}
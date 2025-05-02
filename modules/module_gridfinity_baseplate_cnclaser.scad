// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
use <module_gridfinity_block.scad>
use <module_gridfinity_baseplate_common.scad>

/*
BasePlateSettings_cnclaser = ["cnclaser", [
  [iBaseplateTypeSettings_SupportsMagnets, true],
  ]];
*/

//cncmagnet_baseplate(1,2, magnetSize = [0,0]);
//baseplate_cnclaser(num_x = 1.5, num_y = 2.8, magnetSize=[6,7]);

module baseplate_cnclaser(
  num_x, 
  num_y,
  cornerRadius = gf_cup_corner_radius,
  magnetSize= [gf_baseplate_magnet_od,gf_baseplate_magnet_thickness],
  roundedCorners = 15) 
{
  magnetEnable = magnetSize[0] >0 && magnetSize[1] > 0;
  magnetSize = magnetEnable ? magnetSize : [0,0];
  
  magnet_position = calculateAttachmentPositions(magnetSize[0]);
  magnetHeight = magnetSize[1];
  magnetborder = 5;
  
  translate([0, 0, magnetHeight])
  cnclaser_baseplate_internal(num_x, num_y, 
    extra_down=magnetHeight,
    cornerRadius = cornerRadius,
    roundedCorners = roundedCorners)
      if(magnetEnable) {
        translate([env_pitch().x/2,env_pitch().y/2])
          gridcopycorners(
            r=magnet_position, 
            num_x=($gci.x == ceil(num_x)-1 ? num_x-$gci.x : 1),
            num_y=($gci.y == ceil(num_y)-1 ? num_y-$gci.y : 1),
            center= true) {
              //magnet cutout
              translate([0, 0, -fudgeFactor*3]) 
              cylinder(d=magnetSize[0], h=magnetSize[1]+fudgeFactor*4);
            }
        }
  
}

module cnclaser_baseplate_internal(
    num_x, 
    num_y, 
    extra_down=0, 
    height = 4,
    cornerRadius = gf_cup_corner_radius,
    roundedCorners = 15) {

  corner_position = [env_pitch().x/2-cornerRadius, env_pitch().y/2-cornerRadius];
  
  difference() {
    color(color_cup)
      outer_baseplate(
        num_x=num_x, 
        num_y=num_y, 
        extendedDepth=extra_down,
        height=height,
        cornerRadius = cornerRadius,
        roundedCorners = roundedCorners);
   
    color(color_topcavity)
    translate([0, 0, -fudgeFactor]) 
      gridcopy(ceil(num_x), ceil(num_y))
        union(){
          hull() 
            cornercopy(
              r=corner_position,   
              ($gci.x == ceil(num_x)-1 ? num_x-$gci.x : 1),
              ($gci.y == ceil(num_y)-1 ? num_y-$gci.y : 1))
                cylinder(r=2,h=height+fudgeFactor*2);
          translate([0,0,-extra_down])
            children();
        }
    }
}
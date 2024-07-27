include <gridfinity_constants.scad>
use <module_gridfinity.scad>

lip(
num_x = 2, 
num_y = 3
);

grid_block(stackable = false);

module lip(
    num_x = 2, 
    num_y = 3, 
    wall_thickness=0.9,
    lip_style="reduced" //[normal, reduced, minimum, none]
    ) {
  
  seventeen = gf_pitch/2-4;
    
  reducedlipstyle = lip_style;

  zpoint = 0;
  filledInZ = 0;
  floorht = 0;
  cavityHeight=0;
  
  innerLipRadius = gf_cup_corner_radius-gf_lip_lower_taper_height-gf_lip_upper_taper_height; //1.15
  innerWallRadius = gf_cup_corner_radius-wall_thickness;
  
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // arount the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  
  if(IsHelpEnabled("trace")) echo("basic_cavity", efficientFloor=efficientFloor, nofloor=nofloor, lipSupportThickness=lipSupportThickness, lipBottomZ=lipBottomZ, innerLipRadius=innerLipRadius, innerWallRadius=innerWallRadius, cavityHeight=cavityHeight, cavity_floor_radius=cavity_floor_radius);
  
    union() {
      if (reducedlipstyle == "minimum" || reducedlipstyle == "none") {
        hull() cornercopy(seventeen, num_x, num_y)
          tz(filledInZ-fudgeFactor) 
          cylinder(r=innerWallRadius, h=gf_Lip_Height, $fn=32);   // remove entire lip
      } 
      else if (reducedlipstyle == "reduced") {
        lowerTaperZ = filledInZ+gf_lip_lower_taper_height;
        hull() cornercopy(seventeen, num_x, num_y)
        union(){
          tz(lowerTaperZ) 
          cylinder(
            r1=innerWallRadius, 
            r2=gf_cup_corner_radius-gf_lip_upper_taper_height, 
            h=lipSupportThickness, $fn=32);
          tz(filledInZ-fudgeFactor) 
          cylinder(
            r=innerWallRadius, 
            h=lowerTaperZ-filledInZ+fudgeFactor*2, $fn=32);
        }
      } 
      else { // normal
        lowerTaperZ = filledInZ-gf_lip_height-lipSupportThickness;
        if(lowerTaperZ <= floorht){
          hull() cornercopy(seventeen, num_x, num_y)
            tz(floorht) 
            cylinder(r=innerLipRadius, h=filledInZ-floorht+fudgeFactor*2, $fn=32); // lip
        } else {
          hull() cornercopy(seventeen, num_x, num_y)
            tz(filledInZ-gf_lip_height-fudgeFactor) 
            cylinder(r=innerLipRadius, h=gf_lip_height+fudgeFactor*2, $fn=32); // lip
    
          hull() cornercopy(seventeen, num_x, num_y)
            tz(filledInZ-gf_lip_height-lipSupportThickness-fudgeFactor) 
            cylinder(
              r1=innerWallRadius,
              r2=innerLipRadius, h=q+fudgeFactor, $fn=32);   // ... to top of thin wall ...
        }
      }
    
      //Cavity below lip
      if(cavityHeight > 0)
       #hull() cornercopy(seventeen, num_x, num_y)
        tz(floorht)
          roundedCylinder(
            h=cavityHeight,
            r=innerWallRadius,
            roundedr1=min(cavityHeight, cavity_floor_radius),
            roundedr2=0, $fn=32);
  }
}
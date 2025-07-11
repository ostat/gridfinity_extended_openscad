// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
use <module_gridfinity_block.scad>
use <module_gridfinity_baseplate_common.scad>
include <module_gridfinity_cup_base.scad>

module baseplate_lid(
  num_x, 
  num_y,  
  lidOptions = "default",
  lidIncludeMagnets = true,
  lidEfficientFloorThickness = 0.7,
  lidEfficientBaseHeight = 0.4,
  position_fill_grid_x = "far",
  position_fill_grid_y = "far",
  magnetSize = [gf_baseplate_magnet_od,gf_baseplate_magnet_thickness],
  reducedWallHeight=-1,
  cornerScrewEnabled = true,
  cornerRadius = gf_cup_corner_radius) {
  flat_base = lidOptions == "flat" ? FlatBase_gridfinity : FlatBase_off;
  half_pitch = lidOptions == "halfpitch";
  efficient_base = lidOptions == "efficient";
  
  tray = false;
  
  height = 
    flat_base ? 0.7 : 
    half_pitch ? 0.9 : 
    efficient_base ? lidEfficientBaseHeight : 1;
 
  //These should be base constants
  minFloorThickness = 1;
  counterSinkDepth = 2.5;
  screwDepth = counterSinkDepth+3.9;
  weightDepth = 4;
  
  frameBaseHeight = magnetSize[1];
  frameLipHeight = 4;  
  frameTop = 7*height;
  difference() {
    union(){
      grid_block(
        num_x, 
        num_y, 
        efficient_base ? lidEfficientBaseHeight+0.6 : height,
        filledin = tray ? "enabled" : "enabledfilllip" , //[disabled, enabled, enabledfilllip]
        cupBase_settings = CupBaseSettings(
          flatBase=flat_base,
          halfPitch=half_pitch),
        lip_settings = LipSettings());
    }
  
  if(!tray)
  translate([0,0,frameTop])
  union(){
    translate([0,0,4.4])  
    outer_baseplate(
      num_x=num_x, 
      num_y=num_y, 
      height=frameLipHeight,
      cornerRadius = cornerRadius);

  frame_cavity(
    num_x=num_x, 
    num_y=num_y, 
    position_fill_grid_x = position_fill_grid_x,
    position_fill_grid_y = position_fill_grid_y,
    extra_down = frameBaseHeight, 
    frameLipHeight = frameLipHeight,
    cornerRadius = cornerRadius,
    reducedWallHeight = reducedWallHeight)
      difference(){
        translate([fudgeFactor,fudgeFactor,-fudgeFactor])
          cube([env_pitch().x-fudgeFactor*2,env_pitch().y-fudgeFactor*2,frameBaseHeight-fudgeFactor*2]);
          
        baseplate_cavities(
          num_x = $gc_size.x,
          num_y = $gc_size.y,
          baseCavityHeight=frameBaseHeight,
          magnetSize = magnetSize,
          magnetSouround = false,
          cornerRadius = cornerRadius);
      }
    }
  }
}
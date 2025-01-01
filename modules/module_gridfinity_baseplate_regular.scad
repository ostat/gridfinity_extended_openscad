// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
use <module_gridfinity.scad>
use <module_gridfinity_baseplate_common.scad>

module baseplate_regular(
  grid_num_x,
  grid_num_y,
  outer_num_x = 0,
  outer_num_y = 0,
  outer_height = 0,
  position_fill_grid_x = "near",
  position_fill_grid_y = "near",
  position_grid_in_outer_x = "center",
  position_grid_in_outer_y = "center",
  magnetSize = [gf_baseplate_magnet_od,gf_baseplate_magnet_thickness],
  magnetZOffset=0,
  reducedWallHeight=0,
  reduceWallTaper = false,
  centerScrewEnabled = true,
  cornerScrewEnabled = true,
  weightHolder = true,
  cornerRadius = gf_cup_corner_radius,
  roundedCorners = 15) {

  //These should be base constants
  minFloorThickness = 1;
  counterSinkDepth = 2.5;
  screwDepth = counterSinkDepth+3.9;
  weightDepth = 4;
  
  frameBaseHeight = max(
    centerScrewEnabled ? screwDepth : 0, 
    centerScrewEnabled ? counterSinkDepth + weightDepth + minFloorThickness : 0, 
    cornerScrewEnabled ? screwDepth : 0,
    cornerScrewEnabled ? magnetSize[1] + counterSinkDepth + minFloorThickness : 0,
    weightHolder ? weightDepth+minFloorThickness : 0,
    magnetSize.y+magnetZOffset);
    
    translate([0,0,frameBaseHeight])
    frame_plain(
      grid_num_x = grid_num_x,
      grid_num_y = grid_num_y,
      outer_num_x = outer_num_x,
      outer_num_y = outer_num_y,
      outer_height = outer_height,
      position_fill_grid_x = position_fill_grid_x,
      position_fill_grid_y = position_fill_grid_y,
      position_grid_in_outer_x = position_grid_in_outer_x,
      position_grid_in_outer_y = position_grid_in_outer_y,
      extra_down=frameBaseHeight,
      cornerRadius = cornerRadius,
      reducedWallHeight=reducedWallHeight,
      reduceWallTaper=reduceWallTaper,
      roundedCorners = roundedCorners)
        difference(){
          translate([fudgeFactor,fudgeFactor,0])
            cube([gf_pitch-fudgeFactor*2,gf_pitch-fudgeFactor*2,frameBaseHeight]);
            
          baseplate_cavities(
            num_x = $gc_size.x,
            num_y = $gc_size.y,
            baseCavityHeight=frameBaseHeight,
            magnetSize = magnetSize,
            magnetZOffset=magnetZOffset,
            centerScrewEnabled = centerScrewEnabled && $gc_is_corner.x && $gc_is_corner.y,
            cornerScrewEnabled = cornerScrewEnabled,
            weightHolder = weightHolder,
            cornerRadius = cornerRadius,
            roundedCorners = roundedCorners,
            reverseAlignment = [$gci.x == 0, $gci.y==0]);
        }
}

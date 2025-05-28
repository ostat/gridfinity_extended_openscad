// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
use <module_gridfinity_block.scad>
use <module_gridfinity_baseplate_common.scad>
use <modules/module_snapfinity.scad>;

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
  magnetSize = [0,0],
  magnetZOffset=0,
  magnetTopCover=0,
  reducedWallHeight=-1,
  reduceWallTaper = false,
  centerScrewEnabled = false,
  cornerScrewEnabled = false,
  weightHolder = false,
  cornerRadius = gf_cup_corner_radius,
  roundedCorners = 15,
  enable_snapfinity = false,
  snapfinity_tab_width = 5) {

    // These should be base constants (original lines)
    minFloorThickness = 1;
    counterSinkDepth = 2.5;
    screwDepth = counterSinkDepth+3.9;
    weightDepth = 4;
    
    // frameBaseHeight calculation (original lines)
    frameBaseHeight = max(
      centerScrewEnabled ? screwDepth : 0, 
      centerScrewEnabled ? counterSinkDepth + weightDepth + minFloorThickness : 0, 
      cornerScrewEnabled ? screwDepth : 0,
      cornerScrewEnabled ? magnetSize[1] + counterSinkDepth + minFloorThickness : 0,
      weightHolder ? weightDepth+minFloorThickness : 0,
      magnetSize.y+magnetZOffset+magnetTopCover);
    $frameBaseHeight = frameBaseHeight; // Used by baseplate_cavities via $gc_...

    difference() { // Main difference for Snapfinity cutaways
        union() { // Union for base structure + Snapfinity tabs
            // == Original baseplate structure START ==
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
              roundedCorners = roundedCorners
            ) {
                // This is the floor part
                difference() {
                    translate([gf_epsilon,gf_epsilon,gf_epsilon]) // Use gf_epsilon
                    cube([env_pitch().x-gf_epsilon*2,env_pitch().y-gf_epsilon*2,frameBaseHeight+gf_epsilon*2]); // Use gf_epsilon

                    baseplate_cavities(
                      num_x = $gc_size.x, // These $gc_ variables are set by frame_plain
                      num_y = $gc_size.y,
                      baseCavityHeight=frameBaseHeight+gf_epsilon, // Use gf_epsilon
                      magnetSize = magnetSize,
                      magnetZOffset=magnetZOffset,
                      magnetTopCover=magnetTopCover,
                      centerScrewEnabled = centerScrewEnabled && $gc_is_corner.x && $gc_is_corner.y,
                      cornerScrewEnabled = cornerScrewEnabled,
                      weightHolder = weightHolder,
                      cornerRadius = cornerRadius,
                      roundedCorners = roundedCorners,
                      reverseAlignment = [$gci.x == 0, $gci.y==0]);
                }
                // Original code has children(); after the difference block, as a direct child of frame_plain.
                children(); 
            }
            // == Original baseplate structure END ==

            // Add Snapfinity Tabs
            if (enable_snapfinity) {
                for (ix = [0 : grid_num_x - 1]) {
                    for (iy = [0 : grid_num_y - 1]) {
                        cell_origin_x = ix * env_pitch().x;
                        cell_origin_y = iy * env_pitch().y;
                        snapfinity_z_offset = 0; // Tabs sit on Z=0

                        // Side +Y (top edge of cell [ix,iy])
                        translate([
                            cell_origin_x + (env_pitch().x + snapfinity_tab_width) / 2, 
                            cell_origin_y + env_pitch().y - 0.25 - 1.75, 
                            snapfinity_z_offset
                        ]) rotate([0,0,-90]) mirror([0,1,0]) snapfinity_tab(snapfinity_tab_width);

                        // Side +X (right edge of cell [ix,iy])
                        translate([
                            cell_origin_x + env_pitch().x - 0.25 - 1.75,
                            cell_origin_y + (env_pitch().y - snapfinity_tab_width) / 2,
                            snapfinity_z_offset
                        ]) rotate([0,0,0]) snapfinity_tab(snapfinity_tab_width);

                        // Side -Y (bottom edge of cell [ix,iy])
                        translate([
                            cell_origin_x + (env_pitch().x - snapfinity_tab_width) / 2, 
                            cell_origin_y + 0.25 + 1.75, 
                            snapfinity_z_offset
                        ]) rotate([0,0,90]) mirror([0,1,0]) snapfinity_tab(snapfinity_tab_width);

                        // Side -X (left edge of cell [ix,iy])
                        translate([
                            cell_origin_x + 0.25 + 1.75, 
                            cell_origin_y + (env_pitch().y + snapfinity_tab_width) / 2, 
                            snapfinity_z_offset
                        ]) rotate([0,0,180]) mirror([0,1,0]) snapfinity_tab(snapfinity_tab_width);
                    }
                }
            }
        } // End union for base_structure + tabs

        // Subtract Snapfinity Cutaways
        if (enable_snapfinity) {
            for (ix = [0 : grid_num_x - 1]) {
                for (iy = [0 : grid_num_y - 1]) {
                    cell_origin_x = ix * env_pitch().x;
                    cell_origin_y = iy * env_pitch().y;
                    snapfinity_z_offset = 0; // Cutaways also start at Z=0

                    // Side +Y
                    translate([
                        cell_origin_x + (env_pitch().x + snapfinity_tab_width) / 2,
                        cell_origin_y + env_pitch().y - 0.25 - 1.75,
                        snapfinity_z_offset
                    ]) rotate([0,0,-90]) mirror([0,1,0]) snapfinity_baseplate_cutaway(snapfinity_tab_width);

                    // Side +X
                    translate([
                        cell_origin_x + env_pitch().x - 0.25 - 1.75,
                        cell_origin_y + (env_pitch().y - snapfinity_tab_width) / 2,
                        snapfinity_z_offset
                    ]) rotate([0,0,0]) snapfinity_baseplate_cutaway(snapfinity_tab_width);

                    // Side -Y
                    translate([
                        cell_origin_x + (env_pitch().x - snapfinity_tab_width) / 2,
                        cell_origin_y + 0.25 + 1.75,
                        snapfinity_z_offset
                    ]) rotate([0,0,90]) mirror([0,1,0]) snapfinity_baseplate_cutaway(snapfinity_tab_width);

                    // Side -X
                    translate([
                        cell_origin_x + 0.25 + 1.75,
                        cell_origin_y + (env_pitch().y + snapfinity_tab_width) / 2,
                        snapfinity_z_offset
                    ]) rotate([0,0,180]) mirror([0,1,0]) snapfinity_baseplate_cutaway(snapfinity_tab_width);
                }
            }
        }
    } // End main difference for cutaways
}

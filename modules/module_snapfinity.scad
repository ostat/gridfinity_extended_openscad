// modules/module_snapfinity.scad
// This file contains primitive 2D profiles extruded along Z,
// and generator modules that rotate and place these primitives
// to create Snapfinity features on baseplates and cups.

// --- A. Primitive 3D Geometry Modules ---
// These modules define 2D profiles in the XY plane (X for depth-like, Y for height-like dimensions)
// and extrude them along the Z-axis (which corresponds to the tab_width).
// Generator modules are responsible for rotating these primitives to their final orientations.

// Module for the Snapfinity tab (protrusion)
// Profile points (X,Y): (Depth, Height)
// P0: Innermost-Bottom [0,0]
// P1: Innermost-TopStraight [0,2.5]
// P2: Outermost-Tip [1.75,4.65]
// P3: Outermost-Bottom [1.75,0]
module snapfinity_tab_primitive(tab_width) {
    profile_points = [
        [0,0],       // P0
        [0,2.5],     // P1
        [1.75,4.65], // P2
        [1.75,0]     // P3
    ];
    linear_extrude(height = tab_width) polygon(points = profile_points);
}

// Module for the Snapfinity baseplate cutaway (void)
// Identical in shape to the snapfinity_tab_primitive.
// Profile points (X,Y): (Depth, Height)
// P0: Innermost-Bottom [0,0]
// P1: Innermost-TopStraight [0,2.5]
// P2: Outermost-Tip [1.75,4.65]
// P3: Outermost-Bottom [1.75,0]
module snapfinity_baseplate_cutaway_primitive(tab_width) {
    profile_points = [
        [0,0],       // P0
        [0,2.5],     // P1
        [1.75,4.65], // P2
        [1.75,0]     // P3
    ];
    linear_extrude(height = tab_width) polygon(points = profile_points);
}

// Module for the Snapfinity cup slot (void)
// Profile points (X,Y): (Depth, Height)
// P0: OuterWall-BottomOfSlot [0,0]
// P1: FullDepth-BottomOfSlot [2.15,0]
// P2: FullDepth-StartOfAngle [2.15,3.85]
// P3: ReducedDepth-TopOfSlot [1.35,4.65]
// P4: OuterWall-TopOfSlot [0,4.65]
module snapfinity_cup_slot_primitive(tab_width) {
    profile_points = [
        [0,0],       // P0
        [2.15,0],    // P1
        [2.15,3.85], // P2
        [1.35,4.65], // P3
        [0,4.65]     // P4
    ];
    linear_extrude(height = tab_width) polygon(points = profile_points);
}

// --- B. High-Level Generator for Baseplate Features ---
// These modules take the Z-extruded primitives, rotate them so their
// extrusion direction aligns with the world Y-axis (making the profile effectively in XZ world plane),
// and then place them on each side of each grid cell.

module generate_all_baseplate_tabs(num_x_units, num_y_units, snapfinity_tab_width, actual_pitch_x, actual_pitch_y) {
    union() {
        for (ix = [0 : num_x_units - 1]) {
            for (iy = [0 : num_y_units - 1]) {
                cell_origin_x = ix * actual_pitch_x;
                cell_origin_y = iy * actual_pitch_y;
                snapfinity_z_offset = 0; // Tabs sit on Z=0 of the baseplate

                // Primitive rotated: original XY profile is now XZ, extrusion (original Z) is now along world Y.
                module rotated_tab() { rotate([90,0,0]) snapfinity_tab_primitive(snapfinity_tab_width); }

                // Side +Y (top edge of cell [ix,iy] in Gridfinity layout)
                // Tab profile's depth (original X) extends along World -Y. Width (original Z) extends along World +X.
                translate([
                    cell_origin_x + (actual_pitch_x + snapfinity_tab_width) / 2,
                    cell_origin_y + actual_pitch_y - 0.25 - 1.75, // 0.25 is clearance, 1.75 is tab base depth
                    snapfinity_z_offset
                ]) rotate([0,0,-90]) mirror([0,1,0]) rotated_tab();

                // Side +X (right edge of cell [ix,iy])
                // Tab profile's depth (original X) extends along World +X. Width (original Z) extends along World +Y.
                translate([
                    cell_origin_x + actual_pitch_x - 0.25 - 1.75,
                    cell_origin_y + (actual_pitch_y - snapfinity_tab_width) / 2,
                    snapfinity_z_offset
                ]) rotate([0,0,0]) rotated_tab();

                // Side -Y (bottom edge of cell [ix,iy])
                // Tab profile's depth (original X) extends along World +Y. Width (original Z) extends along World -X.
                translate([
                    cell_origin_x + (actual_pitch_x - snapfinity_tab_width) / 2,
                    cell_origin_y + 0.25 + 1.75,
                    snapfinity_z_offset
                ]) rotate([0,0,90]) mirror([0,1,0]) rotated_tab();

                // Side -X (left edge of cell [ix,iy])
                // Tab profile's depth (original X) extends along World -X. Width (original Z) extends along World -Y.
                translate([
                    cell_origin_x + 0.25 + 1.75,
                    cell_origin_y + (actual_pitch_y + snapfinity_tab_width) / 2,
                    snapfinity_z_offset
                ]) rotate([0,0,180]) mirror([0,1,0]) rotated_tab();
            }
        }
    }
}

module generate_all_baseplate_cutaways(num_x_units, num_y_units, snapfinity_tab_width, actual_pitch_x, actual_pitch_y) {
    union() {
        for (ix = [0 : num_x_units - 1]) {
            for (iy = [0 : num_y_units - 1]) {
                cell_origin_x = ix * actual_pitch_x;
                cell_origin_y = iy * actual_pitch_y;
                snapfinity_z_offset = 0; // Cutaways start at Z=0 of the baseplate

                module rotated_cutaway() { rotate([90,0,0]) snapfinity_baseplate_cutaway_primitive(snapfinity_tab_width); }

                // Side +Y
                translate([
                    cell_origin_x + (actual_pitch_x + snapfinity_tab_width) / 2,
                    cell_origin_y + actual_pitch_y - 0.25 - 1.75,
                    snapfinity_z_offset
                ]) rotate([0,0,-90]) mirror([0,1,0]) rotated_cutaway();

                // Side +X
                translate([
                    cell_origin_x + actual_pitch_x - 0.25 - 1.75,
                    cell_origin_y + (actual_pitch_y - snapfinity_tab_width) / 2,
                    snapfinity_z_offset
                ]) rotate([0,0,0]) rotated_cutaway();

                // Side -Y
                translate([
                    cell_origin_x + (actual_pitch_x - snapfinity_tab_width) / 2,
                    cell_origin_y + 0.25 + 1.75,
                    snapfinity_z_offset
                ]) rotate([0,0,90]) mirror([0,1,0]) rotated_cutaway();

                // Side -X
                translate([
                    cell_origin_x + 0.25 + 1.75,
                    cell_origin_y + (actual_pitch_y + snapfinity_tab_width) / 2,
                    snapfinity_z_offset
                ]) rotate([0,0,180]) mirror([0,1,0]) rotated_cutaway();
            }
        }
    }
}

// --- C. High-Level Generator for Cup Slots ---
// This module takes the Z-extruded slot primitive, rotates it so its
// extrusion direction aligns with the world Y-axis, and then places it
// on each of the four outer sides of a cup.

module generate_all_cup_slots(cup_total_width_mm, cup_total_depth_mm, snapfinity_tab_width) {
    union() {
        snapfinity_slot_z_offset = 0; // Slots start at Z=0 of the cup's base

        // Primitive rotated: original XY profile is now XZ, extrusion (original Z) is now along world Y.
        module rotated_slot() { rotate([90,0,0]) snapfinity_cup_slot_primitive(snapfinity_tab_width); }

        // Side +Y (far edge in Y-dimension of the cup)
        // Slot profile's depth (original X) extends into the cup along World -Y. Width (original Z) extends along World +X.
        translate([
            (cup_total_width_mm + snapfinity_tab_width) / 2,
            cup_total_depth_mm,
            snapfinity_slot_z_offset
        ]) rotate([0,0,-90]) mirror([0,1,0]) rotated_slot();

        // Side +X (far edge in X-dimension of the cup)
        // Slot profile's depth (original X) extends into the cup along World -X. Width (original Z) extends along World +Y.
        // Note: The module_gridfinity_block.scad places slots with profile depth along +X world.
        // To match that, we don't mirror X here.
        translate([
            cup_total_width_mm,
            (cup_total_depth_mm - snapfinity_tab_width) / 2,
            snapfinity_slot_z_offset
        ]) rotate([0,0,0]) rotated_slot();


        // Side -Y (near edge in Y-dimension of the cup, y=0)
        // Slot profile's depth (original X) extends into the cup along World +Y. Width (original Z) extends along World -X.
        translate([
            (cup_total_width_mm - snapfinity_tab_width) / 2,
            0,
            snapfinity_slot_z_offset
        ]) rotate([0,0,90]) mirror([0,1,0]) rotated_slot();

        // Side -X (near edge in X-dimension of the cup, x=0)
        // Slot profile's depth (original X) extends into the cup along World +X. Width (original Z) extends along World -Y.
        // Note: The module_gridfinity_block.scad places slots with profile depth along -X world.
        // To match that, we mirror X here.
        translate([
            0,
            (cup_total_depth_mm + snapfinity_tab_width) / 2,
            snapfinity_slot_z_offset
        ]) rotate([0,0,180]) mirror([0,1,0]) rotated_slot();
    }
}

// Snapfinity Modules

// Module for the Snapfinity tab (protrusion)
// Profile points (yellow region description):
// P0: Innermost-Bottom [0,0]
// P1: Innermost-TopStraight [0,2.5] (0.7mm bottom section is not explicitly defined, inferred from P1 and P2)
// P2: Outermost-Tip [1.75,4.65] (1.8mm middle section + 2.15mm top angled section = 3.95mm; total height 4.65mm)
// P3: Outermost-Bottom [1.75,0] (base length/depth 1.75mm)
// The profile describes a shape with a 0.7mm bottom straight section,
// then a 1.8mm middle straight section, and a 2.15mm top angled section.
// Total height = 4.65mm. Base length/depth = 1.75mm.
module snapfinity_tab(tab_width) {
    profile = [
        [0,0],       // P0
        [0,2.5],     // P1
        [1.75,4.65], // P2
        [1.75,0]     // P3
    ];
    linear_extrude(height = tab_width) polygon(points = profile);
}

// Module for the Snapfinity baseplate cutaway (void)
// This module generates a shape identical to the snapfinity_tab.
// The baseplate module will use this with difference() to create the slot.
// Profile points (blue region description):
// These points correspond to the tab's geometry to ensure a perfect fit.
// P0: Innermost-Bottom [0,0]
// P1: Innermost-TopStraight [0,2.5]
// P2: Outermost-Tip [1.75,4.65]
// P3: Outermost-Bottom [1.75,0]
module snapfinity_baseplate_cutaway(tab_width) {
    profile = [
        [0,0],       // P0
        [0,2.5],     // P1
        [1.75,4.65], // P2
        [1.75,0]     // P3
    ];
    linear_extrude(height = tab_width) polygon(points = profile);
}

// Module for the Snapfinity cup slot (void)
// The cup module will use this with difference() to create the slot for the tab.
// Profile points (orange region description):
// P0: OuterWall-BottomOfSlot [0,0]
// P1: FullDepth-BottomOfSlot [2.15,0] (max depth 2.15mm)
// P2: FullDepth-StartOfAngle [2.15,3.85] (bottom 3.85mm is full depth)
// P3: ReducedDepth-TopOfSlot [1.35,4.65] (top 0.8mm vertical is angled, reducing depth by 0.8mm horizontal)
// P4: OuterWall-TopOfSlot [0,4.65] (total height 4.65mm)
module snapfinity_cup_slot(tab_width) {
    profile = [
        [0,0],       // P0
        [2.15,0],    // P1
        [2.15,3.85], // P2
        [1.35,4.65], // P3
        [0,4.65]     // P4
    ];
    linear_extrude(height = tab_width) polygon(points = profile);
}

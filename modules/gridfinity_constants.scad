// dimensions as declared on https://gridfinity.xyz/specification/

//Gridfinity grid size
gf_pitch = 42;
//Gridfinity height size
gf_zpitch = 7;

gf_taper_angle = 45;

// cup
gf_cup_corner_radius = 3.75;
gf_cup_floor_thickness = 0.7;  

// CupBase
gf_cupbase_lower_taper_height = 0.8;
gf_cupbase_riser_height = 1.8;
gf_cupbase_upper_taper_height = 2.15;
gf_cupbase_magnet_position = 4.8; 
gf_cupbase_screw_diameter = 3; 
gf_cupbase_screw_depth = 6;
gf_magnet_diameter = 6.5;
gf_magnet_thickness = 2.4;
gf_base_grid_clearance_height = 3.5;

//stacking lips
// Standard lip
// \        gf_lip_upper_taper_height 
//  |       gf_lip_riser_height
//   \      gf_lip_lower_taper_height
//    |     gf_lip_height
//   /      gf_lip_support_taper_height
//  /
// /
///
// Reduced lip
// \        gf_lip_upper_taper_height 
//  |       gf_lip_riser_height
// /        gf_lip_reduced_support_taper_height
/// 
gf_lip_lower_taper_height = 0.7;
gf_lip_riser_height = 1.8;
gf_lip_upper_taper_height = 1.9;
gf_lip_height = 1.2;
//gf_lip_support_taper_height = 2.5;
//gf_lip_reduced_support_taper_height = 1.9;

// base plate
gf_baseplate_lower_taper_height = 0.7;
gf_baseplate_riser_height = 1.8;
gf_baseplate_upper_taper_height = 2.15;
gf_baseplate_magnet_od = 6.5;
gf_baseplate_magnet_thickness = 2.4;

// top lip height 4.4mm
gf_Lip_Height = 4.4-0.6;//gf_lip_lower_taper_height + gf_lip_riser_height + gf_lip_upper_taper_height;

// cupbase height 4.75mm + 0.25.
function gfBaseHeight() = gf_cupbase_lower_taper_height + gf_cupbase_riser_height + gf_cupbase_upper_taper_height+0.25; //results in 5
gf_min_base_height = gfBaseHeight(); 

// base heighttop lip height 4.4mm
function gfBasePlateHeight() = gf_baseplate_lower_taper_height + gf_baseplate_riser_height + gf_baseplate_upper_taper_height;

 

// old names, that will get replaced
/*
gridfinity_lip_height = gf_Lip_Height; 
gridfinity_corner_radius = gf_cup_corner_radius ; 
gridfinity_zpitch = env_pitch().z;
minFloorThickness = gf_cup_floor_thickness;  
const_magnet_height = gf_magnet_thickness;
*/

//Small amount to add to prevent clipping in openSCAD
fudgeFactor = 0.01;

color_cup = "LightSlateGray";
color_divider = "Gainsboro"; //LemonChiffon
color_topcavity = "Green";//"SteelBlue";
color_label = "DarkCyan";
color_cupcavity = "LightGreen"; //IndianRed
color_wallcutout = "SandyBrown";
color_basehole = "DarkSlateGray";
color_base = "DimGray";
color_extension = "lightpink";
color_text = "Yellow"; //Gold
color_cut = "Black";
color_lid = "MediumAquamarine";
///////////////////////////////////////
//Combined version of 'gridfinity_sliding_lid.scad'. Generated 2025-11-08 11:08
///////////////////////////////////////
// Gridfinity extended basic cup
// version 2024-02-17
//
// Source
// https://www.printables.com/model/630057-gridfinity-extended-openscad
//
// Documentation
// https://docs.ostat.com/docs/openscad/gridfinity-extended/basic-cup
/* [Sliding Lid] */
// select what to render
render_choice = "both";//[both, lid, cup]
sliding_lid_enabled = true;
// 0 = wall thickness *2
sliding_lid_thickness = 0; //0.1
// 0 = wall_thickness/2
sliding_min_wall_thickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
sliding_min_support = 0;//0.1
sliding_lid_lip_enabled = true;
sliding_clearance = 0.1;//0.1
sliding_lid_cutout_enabled = false; //
sliding_lid_cutout_size = [-2,-2]; //0.1
sliding_lid_cutout_radius = -4; //0.1
sliding_lid_cutout_position = [0,0]; //0.1
/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.1
// Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [3, 0]; //0.1
// Fill in solid block (overrides all following options)
filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]
// Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
//under size the bin top by this amount to allow for better stacking
headroom = 0.8; // 0.1
/* [Cup Lip] */
// Style of the cup lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [1,1]; //0.1
// Create a relie
lip_top_relief_height = -1; // 0.1
// add a notch to the lip to prevent sliding.
lip_top_notches  = true;
/* [Subdivisions] */
chamber_wall_thickness = 1.2;
//Reduce the wall height by this amount
chamber_wall_headroom = 0;//0.1
// X dimension subdivisions
vertical_chambers = 1;
vertical_separator_bend_position = 0;
vertical_separator_bend_angle = 0;
vertical_separator_bend_separation = 0;
vertical_separator_cut_depth=0;
horizontal_chambers = 1;
horizontal_separator_bend_position = 0;
horizontal_separator_bend_angle = 0;
horizontal_separator_bend_separation = 0;
horizontal_separator_cut_depth=0;
// Enable irregular subdivisions
vertical_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
vertical_separator_config = "10.5|21|42|50|60";
// Enable irregular subdivisions
horizontal_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
horizontal_separator_config = "10.5|21|42|50|60";
/* [Base] */
// Enable magnets
enable_magnets = true;
// Enable screws
enable_screws = true;
//size of magnet, diameter and height. Zack's original used 6.5 and 2.4
magnet_size = [6.5, 2.4];  // .1
//create relief for magnet removal
magnet_easy_release = "auto";//["off","auto","inner","outer"] 
//size of screw, diameter and height. Zack's original used 3 and 6
screw_size = [3, 6]; // .1
//size of center magnet, diameter and height. 
center_magnet_size = [0,0];
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = true;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth]
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = "off"; // [off, gridfinity:gridfinity stackable, rounded]
// Remove floor to create a vertical spacer
spacer = false;
//Pads smaller than this will not be rendered as it interferes with the baseplate. Ensure appropriate support is added in slicer.
minimum_printable_pad_size = 0.2;
// Adjust the radius of the rounded flat base. -1 uses the corner radius.
flat_base_rounded_radius = -1;
// Add chamfer to the rounded bottom corner to make easier to print. -1 add auto 45deg.
flat_base_rounded_easyPrint = -1;
/* [Label] */
label_style = "normal"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]
/* [Finger Slide] */
// Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// Radius of the corner fillet
fingerslide_radius = -3;
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
fingerslide_walls=[1,0,0,0];  //[0:1:1]
//Align the fingerslide with the lip
fingerslide_lip_aligned=true;
/* [Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;
/* [Wall Pattern] */
// Grid wall patter
wallpattern_enabled=false;
// Style of the pattern
wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// Spacing between pattern
wallpattern_strength = 2; //0.1
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// rotate the grid
wallpattern_rotate_grid=false;
//Size of the hole
wallpattern_cell_size = [10,10]; //0.1
// Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both] 
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//Radius of corners
wallpattern_hole_radius = 0.5;
// pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
wallpattern_border = 0;
// depth of imprint in mm, 0 = is wall width.
wallpattern_depth = 0; // 0.1
//grid pattern hole taper
wallpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise, 
wallpattern_pattern_voronoi_noise = 0.75; //0.01
//brick pattern center weight
wallpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2
/* [Floor Pattern] */
// enable Grid floor patter
floorpattern_enabled=false;
// Style of the pattern
floorpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// Spacing between pattern
floorpattern_strength = 2; //0.1
// rotate the grid
floorpattern_rotate_grid = false;
//Size of the hole
floorpattern_cell_size = [10,10]; //0.1
//Number of sides of the hole op
floorpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//Radius of corners
floorpattern_hole_radius = 0.5;
// pattern fill mode
floorpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
floorpattern_border = 0;
// depth of imprint in mm, 0 = is wall width.
floorpattern_depth = 0; // 0.1
//grid pattern hole taper
floorpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise, 
floorpattern_pattern_voronoi_noise = 0.75; //0.01
//brick pattern center weight
floorpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
floorpattern_pattern_quality = 0.4;//0.1:0.1:2
/* [Wall Cutout] */
wallcutout_vertical ="disabled"; //[disabled, enabled, wallsonly, frontonly, backonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=-2;  //0.1
//default will be binwidth/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
//default will be binHeight
wallcutout_vertical_height=0;
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, wallsonly, leftonly, rightonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=-2;  //0.1
//default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
//default will be binHeight
wallcutout_horizontal_height=0;
wallcutout_horizontal_corner_radius=5;
/* [Extendable] */
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5; 
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5; 
extension_tabs_enabled = true;
//Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];
/* [Bottom Text] */
// Add bin size to bin bottom
text_1 = false;
// Font Size of text, in mm (0 will auto size)
text_size = 0; // 0.1
// Depth of text, in mm
text_depth = 0.3; // 0.01
// Offset of text , in mm
text_offset = [0, 0]; // 0.1
// Font to use
text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// Add free-form text line to bin bottom (printing date, serial, etc)
text_2 = false;
// Actual text to add
text_2_text = "Gridfinity Extended";
/* [debug] */
// Debug slice
cut = [0,0,0]; //0.1
// enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]
/* [Model detail] */
//assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
//where to render the model
render_position = "center"; //[default,center,zero]
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments 
fa = 6; 
// minimum size of a fragment.  Low is more fragments
fs = 0.4; 
// number of fragments, overrides $fa and $fs
fn = 0;  
// set random seed for 
random_seed = 0; //0.0001
// force render on costly components
force_render = true;
/* [Hidden] */
module end_of_customizer_opts() {}
//Combined from path gridfinity_constants.scad


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
//CombinedEnd from path gridfinity_constants.scad
//Combined from path module_gridfinity_sliding_lid.scad







iSlidingLidEnabled=0;
iSlidingLidThickness=1;
iSlidingLidMinWallThickness=2;
iSlidingLidMinSupport=3;
iSlidingClearance=4;
slidingLidLipEnabled=5;
function DisabledSlidingLidSettings() = SlidingLidSettings(
  slidingLidEnabled = false,
  slidingLidThickness = 0,
  slidingMinWallThickness = 0,
  slidingMinSupport = 0,
  slidingClearance = 0,
  wallThickness = 0,
  slidingLidLipEnabled = false);
function SlidingLidSettings(
  slidingLidEnabled,
  slidingLidThickness,
  slidingMinWallThickness,
  slidingMinSupport,
  slidingClearance,
  wallThickness,
  slidingLidLipEnabled = false) = 
  let(
    thickness = slidingLidThickness > 0 ? slidingLidThickness : wallThickness*2,
    minWallThickness = slidingMinWallThickness > 0 ? slidingMinWallThickness : wallThickness/2,
    minSupport = slidingMinSupport > 0 ? slidingMinSupport : thickness/2
  ) [
  slidingLidEnabled, 
  thickness,
  minWallThickness,
  minSupport,
  slidingClearance,
  slidingLidLipEnabled];
module AssertSlidingLidSettings(settings){
  assert(is_list(settings), "SlidingLid Settings must be a list")
  assert(len(settings)==6, "SlidingLid Settings must length 5");
} 
//SlidingLid(4,3,.8,0.1,1.6,0.8,0.4,true, true, [-2,-2],5,[0,0]);
module SlidingLid(
  num_x, 
  num_y,
  wall_thickness,
  clearance = 0,
  lidThickness,
  lidMinSupport,
  lidMinWallThickness,
  limitHeight = false,
  lipStyle = "normal",
  lip_notches = true,
  lip_top_relief_height = -1, 
  addLiptoLid = true,
  cutoutEnabled = false,
  cutoutSize = [0,0],
  cutoutRadius = 0,
  cutoutPosition = [0,0]
){
  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_num(wall_thickness));
  assert(is_num(clearance));
  assert(is_num(lidThickness));
  assert(is_num(lidMinSupport));
  assert(is_num(lidMinWallThickness));
  assert(is_bool(limitHeight));
  assert(is_string(lipStyle));
  assert(is_bool(lip_notches));
  assert(is_num(lip_top_relief_height));
  assert(is_bool(addLiptoLid));
  assert(is_bool(cutoutEnabled));
  assert(is_list(cutoutSize));
  assert(is_num(cutoutRadius));
  assert(is_list(cutoutPosition));
  innerWallRadius = env_corner_radius()-wall_thickness-clearance;
  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  lidSize = [num_x*env_pitch().x-lidMinWallThickness, num_y*env_pitch().y-lidMinWallThickness];
  lidLowerRadius = innerWallRadius+lidMinWallThickness;
  lidUpperRadius = limitHeight ? lidLowerRadius-lidThickness/2 : fudgeFactor;
  height = limitHeight ? lidThickness : innerWallRadius+lidMinWallThickness-fudgeFactor;
  difference()
  {
    union(){
      if(addLiptoLid)
      color(env_colour(color_topcavity, isLip = true))
      difference(){
        translate([0,0,lidThickness-fudgeFactor*3])
        cupLip(
          num_x = num_x, 
          num_y = num_y, 
          lipStyle = lipStyle,
          lip_notches = lip_notches,
          lip_top_relief_height = lip_top_relief_height,
          wall_thickness = 1.2);
        translate([0,lidLowerRadius,lidThickness-fudgeFactor*4])
          cube([num_x*env_pitch().x,num_y*env_pitch().y,4+fudgeFactor*2]);
      }
      color(env_colour(color_lid))
      union(){
        hull() 
          cornercopy(inner_corner_center, num_x, num_y){
          tz(lidThickness-lidMinSupport) 
            cylinder(
              r1=innerWallRadius+lidMinWallThickness,
              r2=lidUpperRadius, 
              h=limitHeight ? lidThickness/2 : innerWallRadius+lidMinWallThickness-fudgeFactor);
            cylinder(r=lidLowerRadius, h=lidThickness/2);
        }
        if(addLiptoLid)
        difference(){
          hull()
            cornercopy(inner_corner_center, num_x, num_y){
              cylinder(r=env_corner_radius(), h=lidThickness);
          }         
          translate([-fudgeFactor,lidLowerRadius,-fudgeFactor])
            cube([num_x*env_pitch().x+fudgeFactor*2,num_y*env_pitch().y+fudgeFactor,lidThickness+fudgeFactor*2]);
        }
      }
    }
    if(cutoutEnabled){
      if(env_help_enabled("debug")) echo("SlidingLid", cutoutEnabled=cutoutEnabled, cutoutSize=cutoutSize, cutoutRadius=cutoutRadius );
      sliding_lid_cutout(
        cutoutSize = cutoutSize,
        cutoutRadius = cutoutRadius,
        cutoutPosition = cutoutPosition,
        lidSize = lidSize,
        lidThickness = lidThickness);
    }
    if(env_help_enabled("debug")) echo("SlidingLid", num_x=num_x, num_y=num_y, wall_thickness=wall_thickness, clearance=clearance, lidThickness=lidThickness, lidMinSupport=lidMinSupport, lidMinWallThickness=lidMinWallThickness);
    if(env_help_enabled("debug")) echo("SlidingLid", cutoutSize=cutoutSize, cutoutRadius=cutoutRadius, cutoutPosition=cutoutPosition);
  }
}
module sliding_lid_cutout(
  cutoutSize = [0,0],
  cutoutRadius = 0,
  cutoutPosition = [0,0],
  lidSize = [0,0],
  lidThickness = 0
){
  fudgeFactor = 0.01;
  if(cutoutSize.x != 0 && cutoutSize.y != 0){
    cSize = [
      get_related_value(cutoutSize.x, lidSize.x, 0),
      get_related_value(cutoutSize.y, lidSize.y, 0)
    ];
    minSize = min(cSize.x, cSize.y);
    cRadius = min(minSize/2, get_related_value(cutoutRadius, minSize,  0.01));
    positions = [
      [-cSize.x/2+cRadius, -cSize.y/2+cRadius],
      [-cSize.x/2+cRadius, cSize.y/2-cRadius],
      [cSize.x/2-cRadius, cSize.y/2-cRadius],
      [cSize.x/2-cRadius, -cSize.y/2+cRadius]
    ];
    translate([cutoutPosition.x,cutoutPosition.y,0])
    translate([
      lidSize.x/2,
      lidSize.y/2,
      -fudgeFactor])
      hull(){
        for(i=[0:len(positions)-1]){
          translate([positions[i].x,positions[i].y,0])
          cylinder(r=cRadius, h=lidThickness+fudgeFactor*2);
        }
      }
  }
}
module SlidingLidSupportMaterial(
  num_x, 
  num_y,
  wall_thickness,
  sliding_lid_settings,
  innerWallRadius,
  zpoint){
  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  aboveLipHeight = sliding_lid_settings[iSlidingLidThickness];
  belowLedgeHeight = sliding_lid_settings[iSlidingLidThickness]/4;
  belowRampHeight = sliding_lid_settings[iSlidingLidMinSupport];
  belowLipHeight = belowLedgeHeight+belowRampHeight;
  slidingLidEdge = env_corner_radius()-sliding_lid_settings[iSlidingLidMinWallThickness]; 
  //Sliding lid lower support lip
  tz(zpoint-belowLipHeight) 
  difference(){
    hull() 
      cornercopy(inner_corner_center, num_x, num_y)
      cylinder(r=innerWallRadius, h=belowLipHeight); 
        union(){
        hull() cornercopy(inner_corner_center, num_x, num_y)
          tz(belowRampHeight-fudgeFactor)
          cylinder(r=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=belowLedgeHeight+fudgeFactor*2);
        hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(-fudgeFactor)
        cylinder(r1=slidingLidEdge, r2=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=belowRampHeight+fudgeFactor);
     }
   }
  //Sliding lid upper lip
  tz(zpoint) 
  difference(){
    hull() 
      cornercopy(inner_corner_center, num_x, num_y)
      tz(fudgeFactor) 
      cylinder(r=slidingLidEdge, h=aboveLipHeight); 
    union(){
    hull() 
      cornercopy(inner_corner_center, num_x, num_y)
      tz(fudgeFactor) 
      cylinder(r=slidingLidEdge-sliding_lid_settings[iSlidingLidMinSupport], h=aboveLipHeight+fudgeFactor); 
    *SlidingLid(
      num_x=num_x, 
      num_y=num_y,
      wall_thickness,
      clearance = 0,
      slidingLidThickness=sliding_lid_settings[iSlidingLidThickness],
      slidingLidMinSupport=sliding_lid_settings[iSlidingLidMinSupport],
      slidingLidMinWallThickness=sliding_lid_settings[iSlidingLidMinWallThickness]);
    }
  }
}
module SlidingLidCavity(
  num_x, 
  num_y,
  wall_thickness,
  sliding_lid_settings,
  aboveLidHeight
){
  SlidingLid(
    num_x=num_x, 
    num_y=num_y,
    wall_thickness,
    clearance = 0,
    lidThickness=sliding_lid_settings[iSlidingLidThickness],
    lidMinSupport=sliding_lid_settings[iSlidingLidMinSupport],
    lidMinWallThickness=sliding_lid_settings[iSlidingLidMinWallThickness],
    limitHeight = false);
  if(sliding_lid_settings[slidingLidLipEnabled])
  {
    translate([0,0,0])
      cube([num_x*env_pitch().x,env_corner_radius(),aboveLidHeight+fudgeFactor*3]);
  } else {
    //translate([-env_pitch().x/2,-env_pitch().y/2,zpoint]) 
    //cube([num_x*env_pitch().x,env_corner_radius(),headroom+gf_Lip_Height]);
    //innerWallRadius = env_corner_radius()-wall_thickness;
    translate([0,env_corner_radius(),aboveLidHeight]) 
    rotate([270,0,0])
    chamferedCorner(
      cornerRadius = aboveLidHeight/4,
      chamferLength = aboveLidHeight,
      length=num_x*env_pitch().x, 
      height = aboveLidHeight,
      width = env_corner_radius());
  }
}
//CombinedEnd from path module_gridfinity_sliding_lid.scad
//Combined from path module_gridfinity_block.scad





show_gridfinity_demo = false;
if(show_gridfinity_demo){
  grid_block($fn=64);
  translate([50,0,0])
  union(){
    frame_cavity($fn=64);
    translate([0,50*3,0])
    frame_cavity(remove_bottom_taper=true,$fn=64);
    translate([0,50*4,0])
    frame_cavity(reducedWallHeight=1,$fn=64);
  }
  translate([150,0,0])
  union(){
    pad_oversize($fn=64);
    translate([0,50,0])
    pad_oversize(extend_down=5,$fn=64);
    translate([0,50*2,0])
    pad_oversize(margins=1,$fn=64);
    translate([0,50*3,0])
    pad_oversize(remove_bottom_taper=true,$fn=64);
    translate([0,50*4,0])
    pad_oversize(render_top=false,$fn=64);
    translate([0,50*5,0])
    pad_oversize(render_bottom=false,$fn=64);
  }  
}
// basic block with cutout in top to be stackable, optional holes in bottom
// start with this and begin 'carving'
//grid_block();
module grid_block(
  num_x=1, 
  num_y=2, 
  num_z=2, 
  position = "zero",
  filledin = "disabled", //[disabled, enabled, enabledfilllip]
  wall_thickness = 1.2,
  cupBase_settings = CupBaseSettings(),
  lip_settings = LipSettings(),
  help)
{
  lipHeight = 3.75;
  assert_openscad_version();
  cupBase_settings = ValidateCupBaseSettings(cupBase_settings);
  //Legacy variables.
  magnet_size=cupBase_settings[iCupBase_MagnetSize];
  screw_size=cupBase_settings[iCupBase_ScrewSize];
  hole_overhang_remedy=cupBase_settings[iCupBase_HoleOverhangRemedy];
  box_corner_attachments_only = cupBase_settings[iCupBase_CornerAttachmentsOnly];
  half_pitch=cupBase_settings[iCupBase_HalfPitch];
  flat_base=cupBase_settings[iCupBase_FlatBase];
  center_magnet_size = cupBase_settings[iCupBase_CenterMagnetSize];
  magnet_easy_release = cupBase_settings[iCupBase_MagnetEasyRelease];
  outer_size = [env_pitch().x - env_clearance().x, env_pitch().y - env_clearance().y];  // typically 41.5
  block_corner_position = [outer_size.x/2 - env_corner_radius(), outer_size.y/2 - env_corner_radius()];  // need not match center of pad corners
  magnet_position = calculateAttachmentPositions(magnet_size[iCylinderDimension_Diameter], screw_size[iCylinderDimension_Diameter]);
  overhang_fix = hole_overhang_remedy > 0 && magnet_size[iCylinderDimension_Diameter] > 0 && screw_size[iCylinderDimension_Diameter] > 0 ? hole_overhang_remedy : 0;
  overhang_fix_depth = 0.3;  // assume this is enough
  tz(env_pitch().z*num_z-fudgeFactor*2)
  if(filledin == "enabledfilllip"){
    color(env_colour(color_topcavity))
      tz(-fudgeFactor)
      hull() 
      cornercopy(block_corner_position, num_x, num_y) 
      cylinder(r=env_corner_radius(), h=lipHeight);
  } else {
    cupLip(
      num_x = num_x, 
      num_y = num_y, 
      lipStyle = lip_settings[iLipStyle],
      wall_thickness = wall_thickness,
      lip_notches = lip_settings[iLipNotch],
      lip_top_relief_height = lip_settings[iLipTopReliefHeight],
      lip_top_relief_width = lip_settings[iLipTopReliefWidth],
      lip_clip_position = lip_settings[iLipClipPosition],
      lip_non_blocking = lip_settings[iLipNonBlocking],
      align_grid = cupBase_settings[iCupBase_AlignGrid]);
  }
  translate(gridfinityRenderPosition(position,num_x,num_y))
  difference() {
    baseHeight = 5;
    intersection() {
      //Main cup outer shape
      color(env_colour(color_cup))
        tz(-fudgeFactor)
        hull() 
        cornercopy(block_corner_position, num_x, num_y) 
        cylinder(r=env_corner_radius(), h=env_pitch().z*num_z);
      union(){
        if(flat_base == FlatBase_rounded){
          basebottomRadius = let(fbr = cupBase_settings[iCupBase_FlatBaseRoundedRadius])
            fbr == -1 ? env_corner_radius()/2 : fbr;
          color(env_colour(color_cup))
          translate([env_clearance().x/2,env_clearance().y/2,0])
          roundedCube(
            x = num_x*env_pitch().x-env_clearance().x,
            y = num_y*env_pitch().y-env_clearance().y,
            z = env_pitch().z,
            size=[],
            topRadius = 0,
            bottomRadius = basebottomRadius,
            sideRadius = env_corner_radius(),
            centerxy = false,
            supportReduction_z = [cupBase_settings[iCupBase_FlatBaseRoundedEasyPrint],0]
            );
        } else {
          // logic for constructing odd-size grids of possibly half-pitch pads
          color(env_colour(color_base))
            pad_grid(
              num_x = num_x, 
              num_y = num_y, 
              half_pitch = half_pitch, 
              flat_base = flat_base, 
              cupBase_settings[iCupBase_MinimumPrintablePadSize],
              pitch=env_pitch(), 
              positionGridx = cupBase_settings[iCupBase_AlignGrid].x,
              positionGridy = cupBase_settings[iCupBase_AlignGrid].y);
        }
        color(env_colour(color_cup))
        tz(baseHeight) 
          cube([env_pitch().x*num_x, env_pitch().y*num_y, env_pitch().z*num_z]);
      }
    }
    color(env_colour(color_cup))
    bin_overhang_chamfer(
      num_x = num_x,
      num_y = num_y,
      baseHeight = baseHeight,
      wall_thickness = wall_thickness,
      corner_radius = env_corner_radius(),
      block_corner_position=block_corner_position,
      cupBase_settings = cupBase_settings);
    if(center_magnet_size[iCylinderDimension_Diameter]){
      //Center Magnet
      for(x =[0:1:num_x-1])
      {
        for(y =[0:1:num_y-1])
        {
          color(env_colour(color_basehole))
            translate([
               x * env_pitch().x + env_pitch().x / 2, // Add half pitch in X
               y * env_pitch().y + env_pitch().y / 2, // Add half pitch in Y
               -fudgeFactor
            ])
            cylinder(h=center_magnet_size[iCylinderDimension_Height]-fudgeFactor, d=center_magnet_size[iCylinderDimension_Diameter]);
        }
      }
    }
    color(env_colour(color_basehole))
    tz(-fudgeFactor)
    gridcopycorners(num_x, num_y, magnet_position, box_corner_attachments_only){
        rdeg =
          $gcci[2] == [ 1, 1] ? 90 :
          $gcci[2] == [-1, 1] ? 180 :
          $gcci[2] == [-1,-1] ? -90 :
          $gcci[2] == [ 1,-1] ? 0 : 0;
        rotate([0,0,rdeg-45+(magnet_easy_release==MagnetEasyRelease_outer ? 0 : 180)])
        MagnetAndScrewRecess(
          magnetDiameter = magnet_size[iCylinderDimension_Diameter],
          magnetThickness = magnet_size[iCylinderDimension_Height]+0.1,
          screwDiameter = screw_size[iCylinderDimension_Diameter],
          screwDepth = screw_size[iCylinderDimension_Height],
          overhangFixLayers = overhang_fix,
          overhangFixDepth = overhang_fix_depth,
          easyMagnetRelease = magnet_easy_release != MagnetEasyRelease_off,
          magnetCaptiveHeight = cupBase_settings[iCupBase_MagnetCaptiveHeight]);
    }
  }
  HelpTxt("grid_block",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"magnet_size",magnet_size
    ,"screw_size",screw_size
    ,"position",position
    ,"hole_overhang_remedy",hole_overhang_remedy
    ,"half_pitch",half_pitch
    ,"box_corner_attachments_only",box_corner_attachments_only
    ,"flat_base",flat_base
    ,"lipSettings",lip_settings
    ,"filledin",filledin]
    ,help);
}
//TODO: be better if we could round the corners of the chamfer around the bin.
module bin_overhang_chamfer(
  num_x,
  num_y,
  baseHeight,
  wall_thickness,
  corner_radius,
  block_corner_position,
  cupBase_settings = []){
  fudgeFactor = 0.01;
  alignGrid = cupBase_settings[iCupBase_AlignGrid];
  cavityFloorRadius = cupBase_settings[iCupBase_CavityFloorRadius];
  efficientFloor = cupBase_settings[iCupBase_EfficientFloor];
  half_pitch = cupBase_settings[iCupBase_HalfPitch];
  minimumPrintablePadSize = cupBase_settings[iCupBase_MinimumPrintablePadSize];
  calculate_bin_chamfer = function (
    width,
    pitch,
    clearance,
    wallThickness,
    cavityFloorRadius,
    efficientFloor,
    halfPitch,
    minimumPrintablePadSize) 
    let(
      over_hanging_lip = halfPitch ? (width*2-floor(width*2))/2 : (width-floor(width)),
      over_hanging_lip_mm = (over_hanging_lip)*pitch-clearance/4,
      calculatedCavityFloorRadius = calculateCavityFloorRadius(cavityFloorRadius, wallThickness, efficientFloor),
      outer_wall_radius = calculatedCavityFloorRadius + wallThickness*2,
      large_h = sqrt(2 * outer_wall_radius ^ 2),
      small_h = (large_h - outer_wall_radius) * 2,
      max_chamfer = sqrt((small_h^2) / 2),
      correctable_lip = max(0, min(over_hanging_lip_mm, max_chamfer)))
    over_hanging_lip > 0 && over_hanging_lip < minimumPrintablePadSize ? correctable_lip : 0;
    chamfer_lip_x = calculate_bin_chamfer(
      width = num_x,
      pitch = env_pitch().x,
      clearance = env_clearance().x,
      wallThickness = wall_thickness,
      cavityFloorRadius = cavityFloorRadius,
      efficientFloor = efficientFloor,
      halfPitch = half_pitch,
      minimumPrintablePadSize = minimumPrintablePadSize
    );
    chamfer_lip_y = calculate_bin_chamfer(
      width = num_y,
      pitch = env_pitch().y,
      clearance = env_clearance().x,
      wallThickness = wall_thickness,
      cavityFloorRadius = cavityFloorRadius,
      efficientFloor = efficientFloor,
      halfPitch = half_pitch,
      minimumPrintablePadSize = minimumPrintablePadSize
    );
  chamfer_max= max(chamfer_lip_x, chamfer_lip_y);
  lower_radius = env_corner_radius() - chamfer_max;
  echo("bin_overhang_chamfer", num_x=num_x, num_y=num_y, chamfer_lip_x=chamfer_lip_x, chamfer_lip_y=chamfer_lip_y, chamfer_max=chamfer_max, lower_radius=lower_radius);
  if(chamfer_lip_x > 0 || chamfer_lip_y > 0)
  translate([0,0,baseHeight-fudgeFactor])
  difference() {
    cube([env_pitch().x*num_x, env_pitch().y*num_y, chamfer_max]);
    hull() 
      cornercopy(block_corner_position, num_x, num_y)
        union(){
          _translate = [
                cupBase_settings[iCupBase_AlignGrid].x == "far"
                  ? ($idx[0] == 0 ? -((-chamfer_lip_x)+env_clearance().x/4) : -env_clearance().x/4)
                  : ($idx[0] == 0 ? -env_clearance().x/4 : (-chamfer_lip_x)+env_clearance().x/4),
                cupBase_settings[iCupBase_AlignGrid].y == "far"
                  ? ($idx[1] == 0 ? -((-chamfer_lip_y)+env_clearance().y/4) : -env_clearance().y/4)
                  : ($idx[1] == 0 ? -env_clearance().y/4 : (-chamfer_lip_y)+env_clearance().y/4),
                -fudgeFactor];
        hull(){
            translate([0,0,chamfer_max+fudgeFactor*2])
            cylinder(r=env_corner_radius()+fudgeFactor, h=fudgeFactor);
            translate(_translate)
            cylinder(r=env_corner_radius()+fudgeFactor, h=fudgeFactor);
          }
        }
  }
}
//CombinedEnd from path module_gridfinity_block.scad
//Combined from path module_gridfinity.scad













module pad_grid(
  num_x, 
  num_y, 
  half_pitch=false, 
  flat_base="off", 
  minimium_size = 0.2,
  pitch=env_pitch(), 
  positionGridx = "near", 
  positionGridy = "near") {
  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_bool(half_pitch));
  assert(is_string(flat_base));
  assert(is_num(minimium_size));
  //echo("pad_grid", flat_base=flat_base, half_pitch=half_pitch, positionGridx=positionGridx, positionGridy=positionGridy, minimium_size=minimium_size);
  pad_copy(
    num_x = num_x, 
    num_y = num_y, 
    half_pitch = half_pitch, 
    flat_base = flat_base, 
    minimium_size = minimium_size,
    pitch=pitch, 
    positionGridx = positionGridx, 
    positionGridy = positionGridy)
      pad_oversize($pad_copy_size.x, $pad_copy_size.y);
}
// like a cylinder but produces a square solid instead of a round one
// specified 'diameter' is the side length of the square, not the diagonal diameter
module cylsq(d, h) {
  translate([-d/2, -d/2, 0]) cube([d, d, h]);
}
// like a tapered cylinder with two diameters, but square instead of round
module cylsq2(d1, d2, h) {
  linear_extrude(height=h, scale=d2/d1)
  square([d1, d1], center=true);
}
module frame_cavity(
  num_x = 2, 
  num_y = 1, 
  position_fill_grid_x = "near",
  position_fill_grid_y = "near",
  render_top = true,
  render_bottom = true,
  remove_bottom_taper = false,
  extra_down=0, 
  frameLipHeight = 4,
  cornerRadius = gf_cup_corner_radius,
  reducedWallHeight = -1,
  reducedWallWidth = -1,
  reducedWallOuterEdgesOnly=false,
  enable_grippers = false) {
  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_string(position_fill_grid_x));
  assert(is_string(position_fill_grid_y));
  assert(is_bool(render_top));
  assert(is_bool(render_bottom));
  assert(is_bool(remove_bottom_taper));
  assert(is_num(extra_down));
  assert(is_num(frameLipHeight));
  assert(is_num(cornerRadius));
  assert(is_num(reducedWallHeight));
  assert(is_num(reducedWallWidth));
  assert(is_bool(reducedWallOuterEdgesOnly));
  assert(is_bool(enable_grippers));
  frameWallReduction = reducedWallHeight >= 0 ? max(0, frameLipHeight-reducedWallHeight) : -1;
    translate([0, 0, -fudgeFactor]) 
      gridcopy(
        num_x, 
        num_y,
        positionGridx = position_fill_grid_x,
        positionGridy = position_fill_grid_y) {
      if($gc_size.x > 0.2 && $gc_size.y >= 0.2){
        if(frameWallReduction>=0)
          for(side=[[0, [$gc_size.x, $gc_size.y]*env_pitch().x, "x"],[90, [$gc_size.y, $gc_size.x]*env_pitch().y, "y"]]){
            if(side[1].x >= env_pitch().x/2)
            if(!reducedWallOuterEdgesOnly || ($gc_is_corner[1] && side[2] =="x") || ($gc_is_corner[0] && side[2] =="y"))
            translate([$gc_size.x/2*env_pitch().x,$gc_size.y/2*env_pitch().y,frameLipHeight])
            rotate([0,0,side[0]])
              WallCutout(
                lowerWidth=side[1].x-(reducedWallWidth > 0 ? reducedWallWidth*2 : 20),
                wallAngle=80,
                height=frameWallReduction,
                thickness=side[1].y+fudgeFactor*2,
                cornerRadius=frameWallReduction,
                topHeight=1);
              }
          //wall reducers, cutouts and clips
          if($children >=2) children(1);
          pad_oversize(
            num_x=$gc_size.x,
            num_y=$gc_size.y,
            margins=1,
            extend_down=extra_down,
            render_top=render_top,
            render_bottom=render_bottom,
            remove_bottom_taper=remove_bottom_taper)
              //cell cavity
              if($children >=1) children(0);
    }
  }
}
// unit pad slightly oversize at the top to be trimmed or joined with other feet or the rest of the model
// also useful as cutouts for stacking
//pad_oversize(margins=1,extend_down=5, $fn=64);
module pad_oversize(
  num_x=1, 
  num_y=1, 
  margins=0,
  render_top = true,
  render_bottom = true,
  remove_bottom_taper = false,
  extend_down = 0) {
  assert(!is_undef(num_x), "num_x is undefined");
  assert(is_num(num_x), "num_x must be a number");
  assert(!is_undef(num_y), "num_y is undefined");
  assert(is_num(num_y), "num_y must be a number");
  assert(!is_undef(margins), "margins is undefined");
  assert(is_num(margins), "margins must be a number >= 0");
  assert(!is_undef(extend_down), "extend_down is undefined");
  assert(is_num(extend_down), "extend_down must be a number >= 0");
  if(env_help_enabled("trace")) echo("pad_oversize", num_x=num_x, num_y=num_y, margins= margins);
  // pad_corner_position = [env_pitch().x/2 - 4,env_pitch().y/2 - 4]; 
  // must be 17 to be compatible
  pad_corner_position = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  bevel1_top = 0.8;     // z of top of bottom-most bevel (bottom of bevel is at z=0)
  bevel2_bottom = 2.6;  // z of bottom of second bevel
  bevel2_top = 5;       // z of top of second bevel
  bonus_ht = 0.2;       // extra height (and radius) on second bevel
  // female parts are a bit oversize for a nicer fit
  radialgap = margins ? 0.25 : 0;  // oversize cylinders for a bit of clearance
  //axialdown = margins ? 0.1 : 0;   // a tiny bit of axial clearance present in Zack's design
  //remove axialdown as it messes up the placement of the attachements 
  axialdown =0;
  fudgeFactor = 0.01;
  translate([0, 0, -axialdown])
  difference() {
    union() {
      //top over size taper
      if(render_top){
        hull() cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            translate(bevel2_bottom) 
            cylsq2(d1=(env_corner_radius()-2.15+radialgap)*2, d2=(env_corner_radius()+0.25+radialgap+bonus_ht)*2, h=bevel2_top-bevel2_bottom+bonus_ht);
          }
          else {
            tz(bevel2_bottom) 
            cylinder(d1=(env_corner_radius()-2.15+radialgap)*2, d2=(env_corner_radius()+0.25+radialgap+bonus_ht)*2, h=bevel2_top-bevel2_bottom+bonus_ht);
          }
        }
      }
      if(render_bottom){ 
        hull()
        cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            cylsq(d=1.6+2*radialgap, h=0.1);
            translate([0, 0, bevel1_top]) 
            cylsq(d=(env_corner_radius()-2.15+radialgap)*2, h=1.9+bevel2_top-bevel2_bottom+bonus_ht);
          }
          else {
            cylinder(d=remove_bottom_taper ? (env_corner_radius()-2.15+radialgap)*2 : 1.6+2*radialgap, h=0.1);
            translate([0, 0, bevel1_top]) 
              cylinder(d=(env_corner_radius()-2.15+radialgap)*2, h=1.9+bevel2_top-bevel2_bottom+bonus_ht);
          }
        }
      }
      if(extend_down > 0)
      translate([0,0,-extend_down])
      difference(){
        hull() 
        cornercopy(pad_corner_position, num_x, num_y) {
          if (sharp_corners) {
            cylsq(d=1.6+2*radialgap, h=extend_down+fudgeFactor);
          }
          else {
            cylinder(d=1.6+2*radialgap, h=extend_down+fudgeFactor);
          }
        }
        //for baseplate patterns
        children();
      }
    }
    // cut off bottom if we're going to go negative
    if (margins && extend_down == 0) {
      cube([env_pitch().x*num_x, env_pitch().y*num_y, axialdown]);
    }
  }
}
module pad_copy(
  num_x, num_y, 
  half_pitch=false, 
  flat_base="off", 
  minimium_size = 0.2,
  pitch=env_pitch(), 
  positionGridx = "near", 
  positionGridy = "near") {
  assert(is_num(num_x));
  assert(is_num(num_y));
  assert(is_bool(half_pitch));
  assert(is_string(flat_base));
  assert(is_num(minimium_size));
  if(env_help_enabled("debug")) echo("pad_copy", flat_base=flat_base, half_pitch=half_pitch, minimium_size=minimium_size);
  if (flat_base != FlatBase_off) {
    $pad_copy_size = [num_x, num_y];
    if(env_help_enabled("debug")) echo("pad_grid_flat_base", pad_copy_size=$pad_copy_size);
    if($pad_copy_size.x >= minimium_size && $pad_copy_size.y >= minimium_size) {
      children();
    }
  }
  else if (half_pitch) {
    gridcopy(
      num_x=num_x*2, 
      num_y=num_y*2, 
      pitch=[pitch.y/2,pitch.x/2,pitch.z],
      positionGridx = positionGridx, 
      positionGridy = positionGridy) {
      $pad_copy_size = $gc_size/2;
      if(env_help_enabled("debug")) echo("pad_grid_half_pitch", gci=$gci, gc_size=$gc_size, pad_copy_size=$pad_copy_size);
      if($pad_copy_size.x >= minimium_size && $pad_copy_size.y >= minimium_size) {
         children();      }
    }
  }
  else {
    gridcopy(
      num_x=num_x, 
      num_y=num_y, 
      pitch=pitch,
      positionGridx = positionGridx, 
      positionGridy = positionGridy) {
      $pad_copy_size = $gc_size;
      if(env_help_enabled("debug")) echo("pad_grid", gci=$gci, gc_size=$gc_size, pad_copy_size=$pad_copy_size);
      if($pad_copy_size.x >= minimium_size && $pad_copy_size.y >= minimium_size) {
        children();
      }
    }
  }
}
// make repeated copies of something(s) at the gridfinity spacing of 42mm
module gridcopy(
  num_x, 
  num_y, 
  pitch=env_pitch(), 
  positionGridx = "near", 
  positionGridy = "near") {
  assert(is_num(num_x) && num_x>=0, "num_x must be a number greater than 1");
  assert(is_num(num_y) && num_y>=0, "num_y must be a number greater than 1");
  assert(is_list(pitch));
  function num_to_list(num, positionGrid = "near") = 
    let(
      centerGrid = positionGrid == "center",
      padding = ceil(num) != num ? (num - floor(num))/(centerGrid?2:1) : 0,
      count = ceil(num) + ((padding > 0 && centerGrid) ? 1 :0),
      hasPrePad = padding != 0 && (positionGrid == "center" || positionGrid == "far"),
      hasPostPad = padding != 0 && (positionGrid == "center" || positionGrid == "near"))
      [for (i = [ 0 : count - 1 ]) 
        i == 0 && hasPrePad ? [padding,false]
          : i == count-1 && hasPostPad ? [padding,false]
          : [1, 
            (i == 0 && !hasPrePad) ||
            (i == 1 && hasPrePad) ||
            (i == (count-1) && !hasPostPad) ||
            (i == (count-2) && hasPostPad)]];    
  xCellsList = num_to_list(num_x, positionGridx);
  yCellsList = num_to_list(num_y, positionGridy);
  $gc_count=[len(xCellsList), len(yCellsList)];
  if(env_help_enabled("debug")) echo("gridcopy", xCellsList=xCellsList, yCellsList=yCellsList);
  for (xi=[0:len(xCellsList)-1]) 
    for (yi=[0:len(yCellsList)-1])
    {
      $gci=[xi,yi,0];
      $gc_count=[len(xCellsList), len(yCellsList), 0];
      $gc_size=[xCellsList[xi][0], yCellsList[yi][0], 0];
      //is this a corner really means is outer edge.
      $gc_is_corner=[xCellsList[xi][1], yCellsList[yi][1]];
      $gc_position=[
        vector_sum(xCellsList, 0, xi,0)-xCellsList[xi][0], 
        vector_sum(yCellsList, 0, yi,0)-yCellsList[yi][0], 0];
      translate([$gc_position.x*pitch.x,$gc_position.y*pitch.y,0])
        children();
    }
}         
// similar to cornercopy, can only copy to box corners
// r, position of the corner from the center for a full sized. Must be less than half of pitch (normally 17 for gridfinity) .
// num_x, num_y, size of the cube in units of pitch.
// pitch, size of one unit.
// center, center the grid
// reverseAlignment, reverse the alignment of the corners
module gridcopycorners(
  num_x, 
  num_y, 
  r, 
  onlyBoxCorners = false, 
  pitch=env_pitch(), 
  center = false, 
  reverseAlignment=[false,false]) {
  assert(is_list(pitch), "pitch must be a list");
  assert(is_list(r), "pitch must be a list");
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  r = is_num(r) ? [r,r] : r;
  translate(center ? [0,0] : [pitch.x/2,pitch.y/2])
  for (cellx=[1:ceil(num_x)], celly=[1:ceil(num_y)]) 
    for (quadrentx=[-1, 1], quadrenty=[-1, 1]) {
      cell = [cellx, celly];
      quadrent = [quadrentx, quadrenty];
      gridPosition = [cell.x+(quadrent.x == -1 ? -0.5 : 0), cell.y+(quadrent.y == -1 ? -0.5 : 0)];
      trans = [pitch.x*(cell.x-1)+quadrent.x*r.x, pitch.y*(cell.y-1)+ quadrent.y*r.y, 0];
      $gcci=[trans,cell,quadrent];
      cornerVisible = 
        (!reverseAlignment.x && gridPosition.x <= num_x || reverseAlignment.x && 1.5-gridPosition.x <= num_x) && 
        (!reverseAlignment.y && gridPosition.y <= num_y || reverseAlignment.y && 1.5-gridPosition.y <= num_y);
      if(env_help_enabled("debug")) echo("gridcopycorners", num_x=num_x,num_y=num_y, gcci=$gcci, gridPosition=gridPosition, reverseAlignment=reverseAlignment, cornerVisible=cornerVisible);
      //only copy if the cell is atleast half size
      if(cornerVisible)
        //only box corners or every cell corner
        if(!onlyBoxCorners || 
          ((cell.x == 1 && quadrent.x == -1) && (cell.y == 1  && quadrent.y == -1)) ||
          (gridPosition.x*2 == floor(num_x*2) && gridPosition.y*2 == floor(num_y*2)) ||
          ((cell.x == 1 && quadrent.x == -1) && gridPosition.y*2 == floor(num_y*2) ) ||
          (gridPosition.x*2 == floor(num_x*2) && (cell.y == 1 && quadrent.y == -1))) 
          translate(trans)
          children();
    }
}
// Coppies the children to the corners to create a square shape
// r, position of the corner from the center for a full sized. Must be less than half of pitch (normally 17 for gridfinity) .
// num_x, num_y, size of the cube in units of pitch.
// pitch, size of one unit.
// num_x = 1 give r*2, num_x = 2 give r*2+pitch, 
// similar to quadtranslate but expands to extremities of a block
module cornercopy(r, num_x=1, num_y=1,pitch=env_pitch(), center = false) {
  assert(!is_undef(r), "r is undefined");
  assert(is_list(pitch), "pitch must be a list");
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  r = is_num(r) ? [r,r] : r;
  translate(center ? [0,0] : [pitch.x/2,pitch.y/2])
  for (xx=[0, 1], yy=[0, 1]) {
    $idx=[xx,yy,0];
    xpos = xx == 0 ? -r.x : max(pitch.x*(num_x-1)+r.x,-r.x);
    ypos = yy == 0 ? -r.y : max(pitch.y*(num_y-1)+r.y,-r.y);
    if(env_help_enabled("debug")) echo("cornercopy", num_x=num_x,num_y=num_y,pitch=pitch, center=center, idx=$idx, gridPosition=[xpos,ypos,0]);
    translate([xpos, ypos, 0]) 
      children();
  }
}
module debug_cut(cutx, cuty, cutz) {
  cutx = is_undef(cutx) ? env_cutx() : cutx;
  cuty = is_undef(cuty) ? env_cuty() : cuty;
  cutz = is_undef(cutz) ? env_cutz() : cutz;
  num_x = env_numx();
  num_y = env_numy();
  num_z = env_numz();
  difference(){
    children();
    //Render the cut, used for debugging
    if(cutx != 0 && $preview){
      color(color_cut)
      translate(cutx > 0 
        ? [-fudgeFactor,-fudgeFactor,-fudgeFactor]
        : [(num_x-abs(cutx))*env_pitch().x-fudgeFactor,-fudgeFactor,-fudgeFactor])
      translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
        cube([
            abs(cutx)*env_pitch().x, 
            num_y*env_pitch().y+fudgeFactor*2,
            (num_z+1)*env_pitch().z+fudgeFactor*2]);
    }
    if(cuty != 0 && $preview){
      color(color_cut)
      translate(cuty > 0 
        ? [-fudgeFactor,-fudgeFactor,-fudgeFactor]
        : [-fudgeFactor,(num_y-abs(cuty))*env_pitch().y-fudgeFactor,-fudgeFactor])
        cube([
          num_x*env_pitch().x+fudgeFactor*2,
          abs(cuty)*env_pitch().y,
          (num_z+1)*env_pitch().z+fudgeFactor*2]);
    }
    if(cutz != 0 && $preview){
      color(color_cut)
      translate(cutz > 0 
        ? [-fudgeFactor,-fudgeFactor,-fudgeFactor]
        : [-fudgeFactor,-fudgeFactor,(num_z+1-abs(cutz))*env_pitch().z-fudgeFactor]
        )
        cube([
          num_x*env_pitch().x+fudgeFactor*2,
          num_y*env_pitch().y+fudgeFactor*2,
          abs(cutz)*env_pitch().z]);
    }
  }
}
//CombinedEnd from path module_gridfinity.scad
//Combined from path ub_helptxt.scad



// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad
/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/
// display the module variables in a copyable format
module HelpTxt(titel,string,help){ 
  help=is_undef(help)?is_undef($helpM)?false:
                                $helpM:
  help;
  idxON=is_undef($idxON)?false:$idxON?true:false;
  idx=is_undef($idx)||idxON?false:is_list($idx)?norm($idx):$idx;
   joinArray= function(in,out="",pos=0) pos>=len(in)?out:
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1); 
helpText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],",\n  ")];
 if(version()[0]<2021){ 
if(help)if(is_list(string))echo(
str("<H3> <font color=",helpMColor,"> Help ",titel, "(",
    helpText[0]
,helpText[1]?helpText[1]:""
,helpText[2]?helpText[2]:""
,helpText[3]?helpText[3]:""
,helpText[4]?helpText[4]:""
,helpText[5]?helpText[5]:""
,helpText[6]?helpText[6]:""
,helpText[7]?helpText[7]:""
,helpText[8]?helpText[8]:""
,helpText[9]?helpText[9]:""
,helpText[10]?helpText[10]:""
,helpText[11]?helpText[11]:""
,helpText[12]?helpText[12]:""
,helpText[13]?helpText[13]:""
,helpText[14]?helpText[14]:""
,helpText[15]?helpText[15]:""
,helpText[16]?helpText[16]:""
,helpText[17]?helpText[17]:""
,helpText[18]?helpText[18]:""
,helpText[19]?helpText[19]:""
,helpText[20]?helpText[20]:"" 
,helpText[21]?helpText[21]:""
,helpText[22]?helpText[22]:""
,helpText[23]?helpText[23]:""
,helpText[24]?helpText[24]:""
,helpText[25]?helpText[25]:""
,helpText[26]?helpText[26]:""
,helpText[27]?helpText[27]:""
,helpText[28]?helpText[28]:""
,helpText[29]?helpText[29]:""
// ," name=",name,
," help);"));  
else HelpTxt("Help",["titel",titel,"string",["string","data","help",help],"help",help],help=1);
}
else{ // current versions help 
if(help&&!idx)if(is_list(string))echo(
str("🟪\nHelp ",titel, "(\n  ",
joinArray(helpText)
,"help=",help,"\n);\n"));    
else HelpTxt("Help",["titel",titel,"string",string,"help",help],help=1);
}
}
//CombinedEnd from path ub_helptxt.scad
//Combined from path ub_common.scad


// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad
/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/
useVersion=undef;
co=[
["silver","lightgrey","darkgrey","grey","slategrey","red","orange","lime","cyan","lightblue","darkblue","purple",[.8,.8,.8,.3],[.8,.8,.8,.6],"cyan","magenta","yellow","black","white","red","green","blue",[0.77,0.75,0.72]],//std
["White","Yellow","Magenta","Red","Cyan","Lime","Blue","Gray","Silver","Olive","Purple","Maroon","Teal","Green","Navy","Black"],//VGA
["Gainsboro","LightGray","Silver","DarkGray","Gray","DimGray","LightSlateGray","SlateGray","DarkSlateGray","Black"],//grey
["Pink","LightPink","HotPink","DeepPink","PaleVioletRed","MediumVioletRed"],//pink
["LightSalmon","Salmon","DarkSalmon","LightCoral","IndianRed","Crimson","Firebrick","DarkRed","Red"],//red
["OrangeRed","Tomato","Coral","DarkOrange","Orange"],//orange
["Yellow","LightYellow","LemonChiffon","LightGoldenrodYellow","PapayaWhip","Moccasin","PeachPuff","PaleGoldenrod","Khaki","DarkKhaki","Gold"],//yellows
["Cornsilk","BlanchedAlmond","Bisque","NavajoWhite","Wheat","Burlywood","Tan","RosyBrown","SandyBrown","Goldenrod","DarkGoldenrod","Peru","Chocolate","SaddleBrown","Sienna","Brown","Maroon"],//browns
["DarkOliveGreen","Olive","OliveDrab","YellowGreen","LimeGreen","Lime","LawnGreen","Chartreuse","GreenYellow","SpringGreen","MediumSpringGreen","LightGreen","PaleGreen","DarkSeaGreen","MediumAquamarine","MediumSeaGreen","SeaGreen","ForestGreen","Green","DarkGreen"],//greens
["Cyan","LightCyan","PaleTurquoise","Aquamarine","Turquoise","MediumTurquoise","DarkTurquoise","LightSeaGreen","CadetBlue","DarkCyan","Teal"],//cyans
["LightSteelBlue","PowderBlue","LightBlue","SkyBlue","LightSkyBlue","DeepSkyBlue","DodgerBlue","CornflowerBlue","SteelBlue","RoyalBlue","Blue","MediumBlue","DarkBlue","Navy","MidnightBlue"],//blue
["Lavender","Thistle","Plum","Violet","Orchid","Magenta","MediumOrchid","MediumPurple","BlueViolet","DarkViolet","DarkOrchid","DarkMagenta","Purple","Indigo","DarkSlateBlue","SlateBlue","MediumSlateBlue"],//violetts
["White","Snow","Honeydew","MintCream","Azure","AliceBlue","GhostWhite","WhiteSmoke","Seashell","Beige","OldLace","FloralWhite","Ivory","AntiqueWhite","Linen","LavenderBlush","MistyRose"],//white
["Red","darkorange","Orange","Yellow","Greenyellow","lime","limegreen","turquoise","cyan","deepskyblue","dodgerblue","Blue","Purple","magenta"],//rainbow
["magenta","Purple","Blue","dodgerblue","deepskyblue","cyan","turquoise","limegreen","lime","Greenyellow","Yellow","Orange","darkorange","Red","darkorange","Orange","Yellow","Greenyellow","lime","limegreen","turquoise","cyan","deepskyblue","dodgerblue","Blue","Purple"]//rainbow2
];
styles=[
"Condensed",
"Condensed Oblique",
"Condensed Bold",
"Condensed Bold Oblique",
"Condensed Bold Italic",
"SemiCondensed",
"SemiLight Condensed",
"SemiLight SemiCondensed",
"SemiBold SemiCondensed",
"SemiBold Condensed",
"Light Condensed",
"Light SemiCondensed",
"SemiLight",
"Light",
"ExtraLight",
"Light Italic",
"Bold",
"Bold SemiCondensed",
"Semibold",
"Semibold Italic",
"Bold Italic",
"Bold Oblique",
"Black",
"Black Italic",
"Book",
"Regular",
"Italic",
"Medium",
"Oblique",
];
needs2D=["Rand","WKreis","Welle","Rund","Rundrum", "LinEx", "RotEx","SBogen","Bogen","HypKehle","Roof"]; /// modules needing 2D children 
function bool(n,bool)= b(n,bool);
function b(n,bool)=  is_list(n)?[for(i=[0:len(n)-1])b(n[i],bool)]:
                               is_num(n)?bool||is_undef(bool)?n?true:
                                                                false:
                                                              n?n:
                                                                0:
                                         bool?n?true:  // n = bool
                                                false:
                                              n?1:
                                                0;
function v3(v)= [
is_num(v.x)?v.x:is_num(v)?v:0,
is_num(v.y)?v.y:0,
is_num(v.z)?v.z:0,
 ];
function gradB(b,r)=360/(PI*r*2)*b; // winkel zur Bogen strecke b des Kreisradiuses r
// list of parent modules [["name",id]]
function parentList(n=-1,start=1)=  is_undef($parent_modules)||$parent_modules==start?undef:[for(i=[start:$parent_modules +n])[parent_module(i),i]];
function is_parent(parent= needs2D, i= 0)=
is_list(parent)?is_num(search(parent,parentList())[i])?true:
                                                      i<len(parent)-1?is_parent(parent=parent,i=i+1):
                                                                      false:
                is_num(search([parent],parentList())[0]);
/** \name stringChunk
\page Functions
stringChunk() separates charcter from a string
\param txt input string
\param start start of extraction
\param length number of characters to extract
*/
function stringChunk(txt,start=0,length,string="")=
  let(
    start=abs(start),
    length=is_undef(length)?len(str(txt))-start:length
  )
  len(string)<length&&start<len(txt)?stringChunk(txt=txt,length=length,start=start+1,string=str(string,str(txt)[start])):string;
/// display variable values
module InfoTxt(name,string,info,help=false){
  $tab=is_undef($tab)?0:$tab;
  info=is_undef(info)?is_undef($info)?false:
                                $info:
  info;
  //  https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/User-Defined_Functions_and_Modules#Function_Literals
 noInfo=is_undef($noInfo)?false:$noInfo; 
 idx=is_undef($idx)?false:is_list($idx)?norm($idx):$idx;
 idxON=is_undef($idxON)?false:$idxON?true:false;
 joinArray= function(in,out="",pos=0) pos>=len(in)?out: // scad version > 2021
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1);   
 if(version()[0]<2021){   
  infoText=[for(i=[0:2:len(string)-1])str(string[i],"=",is_num(string[i+1])?negRed(string[i+1]):string[i+1],i<len(string)-2?", ":"")];
if(info)if(is_list(string))echo( 
 str(is_bool(info)?"":"<b>",info," ",name," ", 
infoText[0]
,infoText[1]?infoText[1]:""
,infoText[2]?infoText[2]:""
,infoText[3]?infoText[3]:""
,infoText[4]?infoText[4]:""
,infoText[5]?infoText[5]:""
,infoText[6]?infoText[6]:""
,infoText[7]?infoText[7]:""
,infoText[8]?infoText[8]:""
,infoText[9]?infoText[9]:""
));
else HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=1);
}
else { // current version info
  infoText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],i<len(string)-2?", ":"")];
if(info&&(!idx||idxON)&&!noInfo)if(is_list(string))echo( 
 str(is_string(info)?$tab?"⏩\t":
                          "🟩\t••":
                     "",$tab?" ╞▷   ":
                             "",b($tab,false)>1?" ┗▶   ":
                                                " ",info," ",name," ",
joinArray(infoText)));
else HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=1);
}
HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=help);
}
/// missing object text
module MO(condition=true,warn=false){
$idx=is_undef($idx)?false:$idx;
Echo(str(parent_module(2)," has no children!"),color=warn?"warning":"red",condition=condition&&$parent_modules>1&&!$idx,help=false);    
}
/// short for translate[];
module T(x=0,y=0,z=0,help=false)
{
    //translate([x,y,z])children();
if(is_list(x))
    multmatrix(m=[
    [1,0,0,x[0]],
    [0,1,0,x[1]],    
    [0,0,1,is_undef(x.z)?z:x[2]+z],
    [0,0,0,1]    
    ])children(); 
else
    multmatrix(m=[
    [1,0,0,x],
    [0,1,0,y],    
    [0,0,1,z],
    [0,0,0,1]    
    ])children(); 
    MO(!$children);
    HelpTxt("T",["x",x,"y",y,"z",z],help);
}
module Text(text="»«",size=5,h,cx,cy,cz,center=0,spacing=1,fn,fs=$fs,radius=0,rot=[0,0,0],font="Bahnschrift:style=bold",style,help,name,textmetrics=true,viewPos=false,trueSize="body")
{
text=str(text);
lenT=len(text);
textmetrics=version()[0]<2022?false:textmetrics;
Echo(str("Sizing inactive trueSize=",trueSizeSW),color="warning",condition=trueSize!="size"&&( (!textmetrics&&trueSize!="body")||(is_num(useVersion)&&useVersion<22.208) ) );
trueSizeSW=is_num(useVersion)&&useVersion<22.208?"size":trueSize;
inputSize=size;
style=is_string(style)?style:styles[style];
font=is_num(font)?fonts[font]:font;
fontstr=is_undef(style)?font:str(font,":style=",style);
hp=textmetrics?textmetrics(text="hpbdlq",font=fontstr,size=1,spacing=spacing).size.y:1;
cap=textmetrics?textmetrics(text="HTAME",font=fontstr,size=1,spacing=spacing).size.y:1;
textSize=textmetrics?textmetrics(text=text,font=fontstr,size=1,spacing=spacing).size:[lenT*spacing,1];
fontS=textmetrics?fontmetrics(font=fontstr,size=1).nominal:1;
size=trueSizeSW=="body"?size*.72:
     trueSizeSW=="hp"?size/hp:
     trueSizeSW=="cap"?size/cap:
     trueSizeSW=="text"?size/textSize.y:
     trueSizeSW=="textl"?size/textSize.x:
     trueSizeSW=="font"?size/(fontS.ascent-fontS.descent):
     size;
    h=is_parent(needs2D)?0:is_undef(h)?size:h;
    cx=center?is_undef(cx)?1:cx:is_undef(cx)?0:cx;
    cy=center?is_undef(cy)?1:cy:is_undef(cy)?0:cy;
    cz=center?is_undef(cz)?1:cz:is_undef(cz)?0:cz;
    txtSizeX=textmetrics?textmetrics(text=text,font=fontstr,size=size,spacing=spacing).size.x:size*spacing*lenT;
    txtSizeY=textmetrics?textmetrics(text=text,font=fontstr,size=size,spacing=spacing).size.y:size;
    fontSize=[for(i=[0:max(lenT-1,0)])textmetrics?
      textmetrics(text=stringChunk(txt=text,length=i),font=fontstr,size=size,spacing=spacing).advance.x + textmetrics(text=text[i],font=fontstr,size=size,spacing=1).advance.x/2*(cx?1:1)
      :
      (size*spacing)*i];
 valign=cy?b(cy,false)<0?"bottom":
                         b(cy,false)>1?"top":
                                       "center":
           "baseline";
 halign=bool(cx,false)>0?"center"
                        :bool(cx,false)<0?"right"
                                         :"left";
 if(text)
  if(!radius){   
    if(h)    
    rotate(rot)translate([0,0,cz?-abs(h)/2:h<0?h:0]) linear_extrude(abs(h),convexity=10){
    text(str(text),size=size,halign=halign,valign=valign,font=fontstr,spacing=spacing,$fn=fn,$fs=fs);
    }
    else rotate(rot)translate([0,0,cz?-h/2:0])text(text,size=size,halign=halign,valign=valign,spacing=spacing,font=fontstr,$fn=fn,$fs=fs); 
  }
  else if (lenT){
   iRadius=radius+(cy?-txtSizeY/2:0);
    rotate(center?textmetrics?gradB(txtSizeX/2,iRadius):gradB(max(fontSize),iRadius)/2:0)
    for(i=[0:lenT-1])rotate(-gradB(fontSize[i],iRadius))
    if(h)    
    translate([0,radius,0])rotate(rot)Tz(cz?-abs(h)/2:h<0?h:0){
    %color("Chartreuse")if(viewPos&&$preview)translate([0,-1])rotate(-30)circle($fn=3);// pos Marker
    linear_extrude(abs(h),convexity=10)text(text[i],size=size,halign=true?"center":"left",valign=valign,font=fontstr,$fn=fn,$fs=fs);
    }
    else  translate([0,radius,cz?-h/2:0])rotate(rot)text(text[i],size=size,halign=true?"center":"left",valign=valign,font=fontstr,$fn=fn,$fs=fs); 
  }
 InfoTxt("Text",["font",font,"style",style,"trueSize",trueSizeSW,"size",str(inputSize," ⇒ ",size)],name);   
 HelpTxt("Text",[
"text",str("\"",text,"\""),
"size",inputSize,
"h",str(h," /*0 for 2D*/"),
"cx",cx,
"cy",cy,
"cz",cz,
"center",center,
"spacing",spacing,
"fn",fn,
"fs",fs,
"radius",radius, 
"rot",rot,
"font",str("\"",font,"\""),
"style",str("\"",style,"\""),
"name",name,
"textmetrics",textmetrics,
"viewPos",viewPos,
"trueSize",str("\"",trueSize,"\""," /* body,size,hp,cap,text,textl,font */")
],help);
}
 // color by color lists
module Col(no=0,alpha=1,pal=0,name=0,help){
   palette=["std","VGA","grey","pink","red","orange","yellow","brown","green","cyan","blue","violett","white","rainbow"]; 
HelpTxt("Col",["no",no,"alpha",alpha,"pal",pal,"name",name],help);
    for(i=[0:1:$children-1]){
    $idx=i;
    color(co[pal][(no+i)%len(co[pal])],alpha)children(i);
    union(){
      $idx=0; 
    InfoTxt("Col",["Color children ($idx)",str(i," Farb№: ",no+i,"- ",co[pal][(no+i)%len(co[pal])])," von ",len(co[pal])-1,"Palette",str(pal,"/",palette[pal],(no+i>len(co[pal])-1)?" — Out of Range":"")],name);
    }
    }
    MO(!$children);
}
/// echo color differtiations
module Echo(title,color="#FF0000",size=2,condition=true,help=false){
 idx=is_undef($idx)?false:is_list($idx)?norm($idx):$idx;
 idxON=is_undef($idxON)?false:$idxON?true:false;
 if(condition&&(!idx||idxON))
     if(version()[0]<2021)echo(str("<H",size,"><font color=",color,">",title)); 
     else if (color=="#FF0000"||color=="red")echo(str("\n🔴\t»»» ",title));
     else if (color=="redring")echo(str("\n⭕\t»»» ",title));
     else if (color=="#FFA500"||color=="orange")echo(str("\n🟠\t»»» ",title));    
     else if (color=="#00FF00"||color=="green"||color=="info")echo(str("🟢\t ",title));
     else if (color=="#0000FF"||color=="blue") echo(str("🔵\t ",title));
     else if (color=="#FF00FF"||color=="purple") echo(str("🟣\t ",title));    
     else if (color=="#000000"||color=="black") echo(str("⬤\t ",title));
     else if (color=="#FFFFFF"||color=="white") echo(str("◯\t ",title));
     else if (color=="#FFFF00"||color=="yellow"||color=="warning") echo(str("⚠\t ",title));    
         else echo(str("• ",title)); 
 HelpTxt("Echo",["title",title,"color",color,"size",size,"condition",condition],help);
}
//Clone and mirror object
module MKlon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,mx,my,mz,help=false)
{
    mx=is_undef(mx)?sign(abs(tx)):mx;
    my=is_undef(my)?sign(abs(ty)):my;
    mz=is_undef(mz)?!mx&&!my?1:sign(abs(tz)):mz;
  $idx=0;  
    translate([tx,ty,tz])rotate([rx,ry,rz])children();
    union(){
        $helpM=0;
        $info=0; 
        $idx=1;
        $idxON=false; 
        translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])mirror([mx,my,mz]) children();
    }
    MO(!$children);
    HelpTxt("MKlon",["tx",tx,"ty",ty,"tz",tz,"rx",rx,"ry",ry,"rz",rz,"mx",mx,"my",my,"mz",mz],help);
}
// Clone and mirror (replaced by MKlon)
module Mklon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,mx=0,my=0,mz=1)
{
    mx=tx?1:mx;
    my=ty?1:my;
    mz=tz?1:mz;
  $idx=0;
    translate([tx,ty,tz])rotate([rx,ry,rz])children(); 
    union(){
        $helpM=0;
        $info=0;
        $idx=1;
        $idxON=false;
    translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])mirror([mx,my,mz]) children(); }   
   MO(!$children);
}
//CombinedEnd from path ub_common.scad
//Combined from path module_utility.scad





utility_demo = false;
if(utility_demo && $preview){
  translate([400,0,0])
  union(){
    bentWall(separation=0);
    translate([0,100,0])
    bentWall(separation=0, thickness = [10,5]);
    translate([0,200,0])
    bentWall(separation=0, thickness = [10,5], top_radius = -2);
    translate([20,0,0])
    bentWall(separation=10);
    translate([20,100,0])
    bentWall(separation=10, thickness = [10,5]);
    translate([20,200,0])
    bentWall(separation=10, thickness = [10,5], top_radius = -2);
  }
}
//Wall is centred on the middle of the start. Bend is not taken in to account
module bentWall(
  length=80,
  bendPosition=0,
  bendAngle=45,
  separation=20,
  lowerBendRadius=0,
  upperBendRadius=0,
  height=30,
  thickness=[10,10],
  wall_cutout_depth = 0,
  wall_cutout_width = 0,
  wall_cutout_radius = 0,
  top_radius = 0,
  centred_x=true) {
  assert(is_num(thickness) || (is_list(thickness) && len(thickness) ==2), "thickness should be a list of len 2");
  thickness = is_num(thickness) ? [thickness,thickness] : thickness;
  thickness_bottom  = thickness.x;
  thickness_top = thickness.y;
  top_scale = thickness.y/thickness.x;
  top_radius = get_related_value(
    user_value = top_radius, 
    base_value = thickness_top, 
    max_value = thickness_top/2,
    default_value = 0);
  bendPosition = get_related_value(bendPosition, length, length/2);
  fudgeFactor = 0.01;
  //#render()
  difference()
  {
    if(separation != 0) { 
      translate(centred_x ? [0,0,0] : [(thickness.x+separation)/2,0,0])
      translate([0,bendPosition,0])
      linear_extrude(height, scale = [top_scale,1], )
      SBogen(
        TwoD=thickness.x,
        dist=separation,
        //x0=true,
        grad=bendAngle,
        r1=lowerBendRadius <= 0 ? separation : lowerBendRadius,
        r2=upperBendRadius <= 0 ? separation : upperBendRadius,
        l1=bendPosition,
        l2=length-bendPosition);   
    } else {
      translate(centred_x ? [-thickness.x/2,0,0] : [0,0,0])
      hull(){
        rotate([90,0,0])
        translate([(thickness_bottom-thickness_top)/2,0,-length])
        roundedCube(
          size =[thickness_top, height, length],
          sideRadius = top_radius);
        cube([thickness_bottom, length, thickness_bottom/2]);
      }
    }
    cutoutHeight = get_related_value(wall_cutout_depth, height, 0);
    cutoutRadius = get_related_value(wall_cutout_radius, cutoutHeight, cutoutHeight);
    cutoutLength = get_related_value(wall_cutout_width, length, length/2); 
    if(wall_cutout_depth != 0){
      translate(centred_x ? [0,0,0] : [(separation+thickness)/2+fudgeFactor,0,0])
      translate([0,length/2,height])
      rotate([0,0,90])
      WallCutout(
        height = cutoutHeight,
        lowerWidth = cutoutLength,
        cornerRadius = cutoutRadius,
        thickness = (separation+thickness[0]+fudgeFactor*2),
        topHeight = 1);
    }
   }
 }
 if(utility_demo){
  translate([200,0,0])
  roundedCube(
    size = [100,100,100],
    //cornerRadius=2,
    topRadius = 0, bottomRadius = 2, sideRadius = 4, 
    supportReduction_z=[-1,0],
    $fn=128);
  translate([200,150,0])
  roundedCube(
    size = [100,100,100],
    //cornerRadius=2,
    topRadius = 5, bottomRadius = 2, sideRadius = 5,
    supportReduction_x = [-1, -1],
    supportReduction_y = [-1, -1],
    supportReduction_z=[-1,0],
    $fn=128);
  translate([200,300,0])
  roundedCube(
    size = [54.5,39.5,41],
    cornerRadius=0,
    topRadius = 0, bottomRadius = 2, sideRadius = 3.75, 
    supportReduction_x = [0, 0], supportReduction_y = [0, 0], supportReduction_z = [1, 0],
    $fn=128);
}
//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
//topRadius = the radius of the top of the cube
//bottomRadius = the radius of the top of the cube
//sideRadius = the radius of the sides. This must be over 0.
module roundedCube(
  x,
  y,
  z,
  size=[],
  cornerRadius = 0,
  topRadius = 0,
  bottomRadius = 0,
  sideRadius = 0 ,
  centerxy = false,
  supportReduction_x = [0,0],
  supportReduction_y = [0,0],
  supportReduction_z = [0,0])
{
  minSideRadius = 0.01;
  assert(is_list(size), "size must be a list");
  size = len(size) == 3 ? size : [x,y,z];
  topRadius = topRadius > 0 ? topRadius : cornerRadius;
  bottomRadius = bottomRadius > 0 ? bottomRadius : cornerRadius;
  sideRadius = max(minSideRadius, sideRadius > 0 ? sideRadius : cornerRadius);
  supportReduction_z = is_num(supportReduction_z) ? [supportReduction_z, supportReduction_z] : supportReduction_z;
  supportReduction_x = is_num(supportReduction_x) ? [supportReduction_x, supportReduction_x] : supportReduction_x;
  supportReduction_y = is_num(supportReduction_y) ? [supportReduction_y, supportReduction_y] : supportReduction_y;
  assert(topRadius <= sideRadius, str("topRadius must be less than or equal to sideRadius. topRadius:", topRadius, " sideRadius:", sideRadius));
  assert(bottomRadius <= sideRadius, str("bottomRadius must be less than or equal to sideRadius. bottomRadius:", bottomRadius, " sideRadius:", sideRadius));
  //Support reduction should move in to roundedCylinder
  function auto_support_reduction(supportReduction, corner_radius, center_radius) = 
    let(center_radius = is_num(center_radius) ? center_radius : corner_radius,
      sr = (supportReduction == -1 ? corner_radius/2 : supportReduction)+max(0,center_radius-corner_radius))
    min(sr, center_radius);
  //z needs to account for the side radius as the side radius can be greater than the top and bottom radius.
  supReduction_z = [auto_support_reduction(supportReduction_z[0], bottomRadius, sideRadius), auto_support_reduction(supportReduction_z[1], topRadius, sideRadius)];
  supReduction_x = [auto_support_reduction(supportReduction_x[0], sideRadius), auto_support_reduction(supportReduction_x[1], sideRadius)];
  supReduction_y = [auto_support_reduction(supportReduction_y[0], sideRadius), auto_support_reduction(supportReduction_y[1], sideRadius)];
  //x and y need and offset to account for the top and bottom radius
  supReduction_x_offset = [auto_support_reduction(supportReduction_x[0], bottomRadius), auto_support_reduction(supportReduction_x[1], topRadius)];
  supReduction_y_offset = [auto_support_reduction(supportReduction_y[0], bottomRadius), auto_support_reduction(supportReduction_y[1], topRadius)];
  positions=[
     [[sideRadius                         ,sideRadius],                        [0,0]]
    ,[[max(size.x-sideRadius, sideRadius) ,sideRadius]                        ,[1,0]]
    ,[[max(size.x-sideRadius, sideRadius) ,max(size.y-sideRadius, sideRadius)],[1,1]]
    ,[[sideRadius                         ,max(size.y-sideRadius, sideRadius)],[0,1]]
    ];
  translate(centerxy ? [-size.x/2,-size.y/2,0] : [0,0,0])
  hull() 
  {
    for (i =[0:1:len(positions)-1])
    {
      translate(positions[i][0]) 
        union(){
        roundedCylinder(h=size.z,r=sideRadius,roundedr2=topRadius,roundedr1=bottomRadius);
        if(supReduction_z[1] > 0)
          translate([0,0,size.z-topRadius])
          cylinder(h=topRadius, r=supReduction_z[1]);
        if(supReduction_z[0] > 0)
          cylinder(h=bottomRadius, r=supReduction_z[0]);
        if(supReduction_x[0] > 0 && positions[i][1].x ==0){
          if(topRadius ==0 && bottomRadius == 0)
          {
            translate([0,0,size.z/2])
            cube(size=[sideRadius*2,supReduction_x[0]*2,size.z],center=true);
          } else {
            //bottom
            translate([0,0,supReduction_x[0]+supReduction_x_offset[0]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[0],center=true);
            //top
            translate([0,0,size.z-supReduction_x[0]-supReduction_x_offset[1]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[0],center=true);
          }
        }
        if(supReduction_x[1] > 0 && positions[i][1].x ==1){
         if(topRadius == 0 && bottomRadius == 0)
         {
            translate([0,0,size.z/2])
            cube(size=[sideRadius*2,supReduction_x[1]*2,size.z],center=true);
          } else {
            //bottom
            translate([0,0,supReduction_x[1]+supReduction_x_offset[0]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[1],center=true);
            //top
            translate([0,0,size.z-supReduction_x[1]-supReduction_x_offset[1]])
            rotate([0,90,0])
            cylinder(h=sideRadius*2, r=supReduction_x[1],center=true);
          }
        }
        if(supReduction_y[0] > 0 && positions[i][1].y == 0){
            //bottom
            translate([0,0,supReduction_y[0]+supReduction_y_offset[0]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[0],center=true);
            //top
            translate([0,0,size.z-supReduction_y[0]-supReduction_y_offset[1]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[0],center=true);
        }
        if(supReduction_y[1] > 0 && positions[i][1].y == 1){
            //bottom
            translate([0,0,supReduction_y[1]+supReduction_y_offset[0]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[1], center=true);
            //top
            translate([0,0,size.z-supReduction_y[1]-supReduction_y_offset[1]])
            rotate([0,90,90])
            cylinder(h=sideRadius*2, r=supReduction_y[1], center=true);
        }
      }
    }
  }
}
//Creates a rounded cube
//x=width in mm
//y=length in mm
//z=height in mm
//cornerRadius = the radius of the cube corners
module roundedCubeV1(
  x,
  y,
  z,
  cornerRadius)
{
  positions=[
     [cornerRadius                      ,cornerRadius                      ,cornerRadius]
    ,[max(x-cornerRadius, cornerRadius) ,cornerRadius                      ,cornerRadius]
    ,[max(x-cornerRadius, cornerRadius) ,max(y-cornerRadius, cornerRadius) ,cornerRadius]
    ,[cornerRadius                      ,max(y-cornerRadius, cornerRadius) ,cornerRadius]
    ];
  hull(){
    for (x =[0:1:len(positions)-1])
    {
      translate(positions[x]) 
        sphere(cornerRadius);
      translate(positions[x]) 
        cylinder(z-cornerRadius,r=cornerRadius);
    }
  }
}
if(utility_demo){
roundedCorner(
  radius = 10, 
  length = 100, 
  height = 25,
  $fn=128); 
}
//create a negative rouneded corner that subtracted from a shape
//radius = the radius of the corner 
//length = the extrusion/length
//height = the distance past the corner.
module roundedCorner(
  radius = 10, 
  length, 
  height)
{
  assert(is_num(length), "length must be a number");
  assert(is_num(height), "height must be a number");
  assert(is_num(radius), "radius must be a number");
  difference(){
    union(){
      //main corner to be removed
      translate([0,-radius, -radius])
        cube([length, radius*2,  radius*2]);
      //corner extension in y
      translate([0,0, -radius])
        cube([length, height, radius]);
      //corner extension in x
      translate([0,-radius, 0])
        cube([length, radius, height]);
    }
    translate([-1,radius, radius])
      rotate([90, 0, 90])
      cylinder(h = length+2, r=radius);
  }  
}
if(utility_demo){
translate([0,50,0])
chamferedCorner(
  chamferLength = 10, 
  cornerRadius = 4, 
  length=100, 
  height=25,
  width = 20,
  $fn=128);
}
//create a negative chamfer corner that subtracted from a shape
//chamferLength = the amount that will be subtracted from the 
//cornerRadius = the radius of the corners 
//length = the extrusion/length
//height = the distance past the corner
module chamferedCorner(
  chamferLength = 10, 
  cornerRadius = 4, 
  length, 
  height,
  width = 0,
  angled_extension = false)
{
  fudgeFactor = 0.01;
  width = width>0 ? width : chamferLength;
  difference(){
    union(){
      //main corner to be removed
      translate([0,-width, -width])
        cube([length, chamferLength+width,  chamferLength+width]);
      //corner extension in y
      translate([0,chamferLength-fudgeFactor, -width])
        rotate_around_point(point=[0,0,width], rotation=angled_extension ? [-45,0,0] : [0,0,0])
        cube([length, height-chamferLength, width]);
      //corner extension in x
      translate([0,-width, chamferLength-fudgeFactor])
        rotate_around_point(point=[0,width,0], rotation=angled_extension ? [45,0,0] : [0,0,0])
        cube([length, width, height-chamferLength]);
    }
    hull(){
      positions = [
        [-1,chamferLength, cornerRadius],
        [-1,cornerRadius, chamferLength],
        [-1,chamferLength, chamferLength]];
      for(i=[0:len(positions)-1])
      {
        translate(positions[i])
          rotate([90, 0, 90])
          cylinder(h = length+2, r=cornerRadius);
      }
    }
  }        
}
module rotate_around_point(point=[], rotation=[]){
  translate(point)
  rotate(rotation)
  translate(-point)
  children();
}
//sequential bridging for hanging hole. 
//ref: https://hydraraptor.blogspot.com/2014/03/buried-nuts-and-hanging-holes.html
//ref: https://www.youtube.com/watch?v=KBuWcT8XkhA
module SequentialBridgingDoubleHole(
  outerHoleRadius = 0,
  outerHoleDepth = 0,
  innerHoleRadius = 0,
  innerHoleDepth = 0,
  overhangBridgeCount = 2,
  overhangBridgeThickness = 0.3,
  overhangBridgeCutin = 0.05, //How far should the bridge cut in to the second smaller hole. This helps support the
  magnetCaptiveHeight = 0,
  ) 
{
  fudgeFactor = 0.01;
  hasOuter = outerHoleRadius > 0 && outerHoleDepth >0;
  hasInner = innerHoleRadius > 0 && innerHoleDepth > 0;
  bridgeRequired = hasOuter && hasInner && outerHoleRadius > innerHoleRadius && innerHoleDepth > outerHoleDepth;
  overhangBridgeCount = bridgeRequired ? overhangBridgeCount : 0;
  overhangBridgeHeight = overhangBridgeCount*overhangBridgeThickness;
  outerPlusBridgeHeight = hasOuter ? outerHoleDepth + overhangBridgeHeight : 0;
  if(hasOuter || hasInner)
  union(){
    difference(){
      if (hasOuter) {
        // move the cylinder up into the body to create internal void
        translate([0,0,magnetCaptiveHeight])
        if($children >=1){
          translate([0,0,outerHoleDepth]);
          cylinder(r=outerHoleRadius, h=overhangBridgeHeight+fudgeFactor);
          children(0); 
        } else { 
          cylinder(r=outerHoleRadius, h=outerPlusBridgeHeight+fudgeFactor);
        }
      }
      if (overhangBridgeCount > 0) {
        for(i = [0:overhangBridgeCount-1]) 
          rotate([0,0,180/overhangBridgeCount*i])
          for(x = [0:1]) 
          rotate([0,0,180]*x)
            translate([-outerHoleRadius,innerHoleRadius-overhangBridgeCutin,outerHoleDepth+overhangBridgeThickness*i])
            cube([outerHoleRadius*2, outerHoleRadius, overhangBridgeThickness*overhangBridgeCount+fudgeFactor*2]);
              }
      }
      if (hasInner) {
        translate([0,0,outerPlusBridgeHeight])
        cylinder(r=innerHoleRadius, h=innerHoleDepth-outerPlusBridgeHeight);
    }
  }
}
//Creates a cube with a single rounded corner.
//Centered around the rounded corner
module CubeWithRoundedCorner(
  size=[10,10,10], 
  cornerRadius = 2, 
  edgeRadius = 0,
  center=false){
  assert(is_list(size) && len(size)==3, "size should be a list of size 3");
  assert(is_num(cornerRadius) && cornerRadius >= 0, "cornerRadius should be a number greater than 0");
  assert(is_num(edgeRadius), "edgeRadius should be a number");
  fudgeFactor = 0.01;
  translate(center ? -size/2 : [0,0,0])
  if(edgeRadius <=0) {
    hull(){
      translate([cornerRadius,cornerRadius,0])
      cylinder(r=cornerRadius, h=size.z+fudgeFactor);
      translate([cornerRadius,0,0])
        cube([size.x-cornerRadius,size.y,size.z+fudgeFactor]);
      translate([0,cornerRadius,0])
        cube([size.x,size.y-cornerRadius,size.z+fudgeFactor]);
    }
  }
  else{
    hull(){
      translate([cornerRadius,cornerRadius,0])
      roundedCylinder(h=size.z+fudgeFactor,r=cornerRadius,roundedr2=edgeRadius);
      translate([(size.x+cornerRadius)/2,size.y/2,size.z/2])
      rotate([0,90,0])
      CubeWithRoundedCorner(
        size=[size.z,size.y,size.x-cornerRadius], 
        cornerRadius = edgeRadius,
        edgeRadius=0,
        center=true);
      translate([size.x/2,(size.y+cornerRadius)/2,size.z/2])
      rotate([0,90,270])
      CubeWithRoundedCorner(
        size=[size.z,size.y,size.x-cornerRadius], 
        cornerRadius = edgeRadius,
        edgeRadius=0,
        center=true);        
    }
  }
}
module roundedCylinder(h,r,roundedr=0,roundedr1=0,roundedr2=0)
{
  assert(is_num(h), "h must have a value");
  assert(is_num(r), "r must have a value");
  roundedr1 = roundedr1 > 0 ? roundedr1 : roundedr;
  roundedr2 = roundedr2 > 0 ? roundedr2 : roundedr;
  assert(is_num(roundedr1), "roundedr1 or roundedr must have a value");
  assert(is_num(roundedr2), "roundedr2 or roundedr must have a value");
  if(roundedr1 > 0 || roundedr2 > 0){
    hull(){
      if(roundedr1 > 0)
        roundedDisk(r,roundedr1,half=-1);
      else
        cylinder(r=r,h=h-roundedr2);
      if(roundedr2 > 0)
        translate([0,0,h-roundedr2*2]) 
          roundedDisk(r,roundedr2,half=1);
      else
        translate([0,0,roundedr1]) 
          cylinder(r=r,h=h-roundedr1);
    }
  }
  else {
    cylinder(r=r,h=h);
  }
}
module roundedDisk(r,roundedr, half=0){
 hull(){
    translate([0,0,roundedr]) 
    rotate_extrude() 
    translate([r-roundedr,0,0])
    difference(){
      circle(roundedr);
      //Remove inner half so we dont get error when r<roundedr*2
      translate([-roundedr*2,-roundedr,0])
      square(roundedr*2);
      if(half<0){
        //Remove top half
        translate([-roundedr,0,0])
        square(roundedr*2);   
      }
      if(half>0){
        //Remove bottom half
        translate([-roundedr,-roundedr*2,0])
        square(roundedr*2);   
      }
    }
  }
}
module tz(z) {
  translate([0, 0, z]) children();
}
//rounded_taper();
module rounded_taper(
  upperRadius=35,
  upperLength=20,
  lowerRadius=10,
  lowerLength=20,
  transitionLength=10,
  cornerRadius=0,
  roundedUpper=false,
  roundedLower=false,
  alignTop = false) {
  bottomWidth = lowerRadius*2;
  //topWidth = lowerWidth+(height/tan(wallAngle))*2;
  topWidth = upperRadius*2;
  height = upperLength+transitionLength+lowerLength;
  translate([0,0,alignTop?-height:0])
  rotate_extrude(angle=360, convexity=10)
  intersection(){
    square([topWidth,height]);
    //Use triple offset to fillet corners
    //https://www.reddit.com/r/openscad/comments/ut1n7t/quick_tip_simple_fillet_for_2d_shapes/
    offset(r=-cornerRadius)
    offset(r=2 * cornerRadius)
    offset(r=-cornerRadius)
    union(){
      hull(){
        //upper
        translate([-topWidth/2,lowerLength+transitionLength])
          square([topWidth,upperLength+(roundedUpper?0:cornerRadius)]);
        //transition
        translate([-bottomWidth/2,lowerLength])
          square([bottomWidth,transitionLength]);
      }
      //lower
      translate([-bottomWidth/2,roundedLower?0:-cornerRadius])
      square([bottomWidth,lowerLength+(roundedLower?0:cornerRadius)]);
    }
  }
}
module PartialCylinder(h, r, part) {
    rotate_extrude(angle = part)
        square([r, h]);
}
//CombinedEnd from path module_utility.scad
//Combined from path ub_sbogen.scad






// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad
/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/
minVal=0.0000001; // minimum für nicht 0
pivotSize=$vpd/15;
function Hypotenuse(a,b)=sqrt(pow(a,2)+pow(b,2));
function hypotenuse(a,b)=sqrt(pow(a,2)+pow(b,2));
function Kathete(hyp,kat)=sqrt(pow(hyp,2)-pow(kat,2));
function kathete(hyp,kat)=sqrt(pow(hyp,2)-pow(kat,2));
function Hexstring(c)=str("#",Hex(c[0]*255),Hex(c[1]*255),Hex(c[2]*255));
// two digit dec max 255
function Hex(dec)= 
    let(
    dec=min(abs(dec),255),
    sz=floor(dec/16),
    s1=floor(dec)-(sz*16)
    )
    str(sz>14?"F":
        sz>13?"E":
        sz>12?"D":
        sz>11?"C": 
        sz>10?"B":
        sz>9?"A":sz,      
        s1>14?"F":
        s1>13?"E":
        s1>12?"D":
        s1>11?"C": 
        s1>10?"B":
        s1>9?"A":s1   
    );
function RotLang(rot=0,l=10,l2,z,e,lz)=let(
rot=is_undef(rot)?0:rot%360,
l=is_undef(l)?0:l,
l2=is_undef(l2)?l:l2,
lz=is_undef(lz)?l:lz
)
is_undef(z)?is_undef(e)?[sin(rot)*l,cos(rot)*l2]:
                        [sin(rot)*cos(e%360)*l,cos(rot)*cos(e%360)*l2,sin(e%360)*lz]:
            [sin(rot)*l,cos(rot)*l,z];
/** \page Functions \name kreis
kreis() generates points on a circle or arc
\param r radius
\param rand dist second radius
\param grad angle
\param grad2 angle second arc
\param fn fragments
\param center center angle
\param sek  chord or center point
\param r2  y component
\param rand2  y component
\param rot rotate points
\param t translate points
\param z z value for polyhedron
\param d ovewrite radius with diameter
\param endPoint end angle with point
\param fs fragment size
\param fs2 fragment size second arc
\param fn2 fragments second arc
\param minF minimum fragments 
*/
function Kreis(r=10,rand=+5,grad=360,grad2,fn=$fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0])=kreis(r,rand,grad,grad2,fn,center,sek,r2,rand2,rcenter,rot,t);
function kreis(r=10,rand=+5,grad=360,grad2,fn=$fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0],z,d,endPoint=true,fs=$fs,fs2,fn2,minF=1,fa=$fa)=
let (
minF=bool(minF,bool=false),
grad2=is_undef(grad2)?grad:grad2,
r=is_num(d)?rcenter?(d+rand)/2:d/2:
            rcenter?r+rand/2:r,
rand2=is_undef(rand2)?rand:rand2,
r2=r2?
    rcenter?r2+rand2/2:r2
    :r,
ifn=is_num(fn)&&fn>0?max(1,ceil(abs(fn)))
                    :min(max(abs(grad)<180?1
                                       :abs(grad)==360?3
                                                      :2,ceil(abs(PI*r*2/360*grad/max(fs,0.001))),minF),round(abs(grad)/fa) ),
fs2=is_undef(fs2)?fs:fs2,
fn2=is_num(fn)&&fn>0?is_undef(fn2)?ifn:max(1,ceil(abs(fn2)))
                    :min(max(abs(grad2)<180?1:abs(grad2)==360?3:2,ceil(abs(PI*(r-rand)*2/360*grad2/max(fs2,0.001))),minF),round(grad/fa)),
step=grad/ifn,
step2=grad2/fn2,
t=is_list(t)?t:[t,0],
endPoint=rand?true:endPoint
)
is_num(z)?[
if(!sek&&!rand&&abs(grad)!=360&&grad)[0+t[0],0+t[1],z], // single points replacement
if(grad==0&&minF)for([0:minF])[sin(rot+(center?-grad/2-90:0))*r  +t[0],
     cos(rot+(center?-grad/2-90:0))*r2 +t[1],
     z],
if(grad)for(i=[0:endPoint?ifn:ifn-1])
        let(iw=abs(grad)==360?i%ifn:i)
    [sin(rot+(center?-grad/2-90:0)+iw*step)*r  +t[0],
     cos(rot+(center?-grad/2-90:0)+iw*step)*r2 +t[1],
     z],
if(rand)for(i=[0:endPoint?fn2:fn2 -1])
    let(iw=abs(grad2)==360?i%fn2:i)
    [sin(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r  -rand )+t[0],
     cos(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r2 -rand2)+t[1],
    z]
]:
[ // if TwoD
if(!sek&&!rand&&abs(grad)!=360&&grad||r==0)[0+t[0],0+t[1]], // single points replacement
if(r&&grad)for(i=[0:endPoint?ifn:ifn-1])
        let(iw=abs(grad)==360?i%ifn:i)
    [sin(rot+(center?-grad/2-90:0)+iw*step)*r+t[0],
    cos(rot+(center?-grad/2-90:0)+iw*step)*r2+t[1]],
if(grad==0&&minF)for([0:minF])[sin(rot+(center?-grad/2-90:0))*r  +t[0],
     cos(rot+(center?-grad/2-90:0))*r2 +t[1]],
if(rand)for(i=[0:endPoint?fn2:fn2-1])
    let(iw=abs(grad2)==360?i%fn2:i)
    [sin(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r-rand)+t[0],
    cos(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r2-rand2)+t[1]]
];
/**
\name SBogen
SBogen() creates an S-shape double counter arc between parallels
\param dist distance between verticals
\param r1 r2 radii
\param grad connecton angle
\param l1 l2 lower and upper length 
\param center center on x
\param fn,fs,fa  fraqments
\param messpunkt show arc center
\param TwoD make TwoD
\param extrude extrude in TwoD from x=0
\param grad2 angle endsection
\param x0 set x axis origin=0
\param lRef reference for l1 l2 0=center -1/1 lower/upper tangentP -2/2 tangent+grad2 -3/3 radius center
\param name help name help
\param lap overlap for 3D
*/
//SBogen(TwoD=true);
//SBogen(extrude=10, grad2=[26,-40]*1,r1=2,l1=20,lRef=+3,messpunkt=true);
module SBogen(dist=10,r1=10,r2,grad=45,l1=15,l2,center=1,fn,fs=$fs,fa=$fa,messpunkt=false,TwoD=0,extrude=false,grad2=0,x0=0,lRef=0,name,help,spiel,lap=0){
    lap=is_undef(spiel)?lap:spiel;
    center=is_bool(center)?center?1:0:sign(center);
    r2=is_undef(r2)?r1:r2;
    l2=is_undef(l2)?l1:l2;
    TwoD=is_parent(needs2D)&&!$children?TwoD?b(TwoD,false):
                                         1:
                                      b(TwoD,false);
// echo(parent_module(1),$parent_modules);
    grad2=is_list(grad2)?grad2:[grad2,grad2];
    extrudeTrue=extrude;
    extrude=is_bool(extrude)?0:extrude*sign(dist);
    gradN=grad; // detect negativ grad
    grad=abs(grad);// negativ grad done by mirror
    y=(grad>0?1:-1)*(abs(dist)/tan(grad)+r1*tan(grad/2)+r2*tan(grad/2));
    yRef=lRef?lRef>0?(lRef> 2?0: tan((grad- (lRef> 1?grad2[1]:0) )/2)*r2)-y/2 // move polygon circles to keep fixpoint according lRef
                    :(lRef<-2?0:-tan((grad- (lRef<-1?grad2[0]:0) )/2)*r1)+y/2
             :0;
    yrest=y-abs(sin(grad))*r1-abs(sin(grad))*r2;//y ohne Kreisstücke
    distrest=dist-r2-r1+cos(grad)*r1+cos(grad)*r2;//dist ohne Kreisstücke
    l2m=Hypotenuse(distrest,yrest)/2+minVal;// Mittelstück
    dist=grad>0?dist:-dist;
  $fn=fn;
  $fa=fa;
  $fs=fs;
  $idxON=false;
  $info=is_undef($info)?is_undef(name)?1:name:$info;
  grad2Y=[-l1+y/2-yRef+r1*sin(grad2[0]),l2-y/2-yRef-r2*sin(grad2[1])]; // Abstand Kreisende zu Punkt l1/l2
  grad2X=[r1-r1*cos(grad2[0])-tan(grad2[0])*grad2Y[0],-r2+r2*cos(grad2[1])-tan(grad2[1])*grad2Y[1]];// Versatz der Punkte durch grad2
  KreisCenterR1=[[-abs(dist)/2+extrude+r1,-y/2+yRef],[extrude+r1-abs(dist),-y/2-l2+yRef],[extrude+r1,-y/2+l1+yRef]];
  KreisCenterR2=[[abs(dist)/2+extrude-r2,y/2+yRef],[extrude-r2,y/2-l2+yRef],[abs(dist)+extrude-r2,y/2+l1+yRef]];
  selectKC=center?center>0?0:
                           1:
                  2;
  endPunkte=center?center==1?[extrude-abs(dist/2)+grad2X[0],extrude+abs(dist/2)+grad2X[1]]:[extrude-abs(dist)+grad2X[0],extrude+grad2X[1]]:[extrude+grad2X[0],extrude+abs(dist)+grad2X[1]];
    InfoTxt(parent_module(search(["Anschluss"],parentList(+0))[0]?
        search(["Anschluss"],parentList(+0,start=0))[0]:
        1)
        ,["ext",str(endPunkte[0],"/",endPunkte[1])," 2×=",str(2*endPunkte[0],"/",2*endPunkte[1]),"Kreiscenter",str(KreisCenterR1[selectKC],"/",KreisCenterR2[selectKC])
    ],name);
 if(grad&&!extrudeTrue)mirror(gradN<0?[1,0]:[0,0])translate(center?[0,0,0]:[dist/2,l1]){
    translate([dist/2,y/2,0])T(-r2)rotate(grad2[1])T(r2)Bogen(rad=r2,grad=grad+grad2[1],center=false,l1=l2-y/2,l2=l2m,help=0,name=0,messpunkt=messpunkt,TwoD=TwoD,fn=fn,fs=fs,d=TwoD,lap=lap)
    if($children){
      $idx=is_undef($idx)?0:$idx;
      $tab=is_undef($tab)?1:b($tab,false)+1;
      children();
    }
    else circle($fn=fn,$fs=fs);
  T(-dist/2,-y/2) mirror([1,0,0])rotate(180)T(r1)rotate(-grad2[0])T(-r1)Bogen(rad=r1,grad=-grad-grad2[0],center=false,l1=l1-y/2,l2=l2m,help=0,name=0,messpunkt=messpunkt,TwoD=TwoD,fn=fn,fs=fs,d=TwoD,lap=lap)
    if($children){
      $idx=1;
      children();
    }
    else circle($fn=fn,$fs=fs);
 }
 if(!grad&&!extrudeTrue) //0 grad Grade
     if(!TwoD)T(0,center?0:l1+l2)R(90)linear_extrude(l1+l2,convexity=5,center=center?true:false)
         if($children)children();
         else circle($fn=fn);
 else T(center?0:-TwoD/2) square([TwoD,l1+l2],center?true:false);
 if(extrudeTrue){
     points=center?center==1?concat(//center=1
     [[x0*sign(dist),l2]],[[extrude+abs(dist)/2+grad2X[1],l2+0]],
     kreis(r=-r2,rand=0,grad=abs(grad)+grad2[1],rot=-90-grad2[1],center=false,fn=fn,fs=fs,fa=fa,t=[abs(dist)/2+extrude-r2,y/2+yRef]), // ok
     kreis(r=-r1,rand=0,grad=-abs(grad)-grad2[0],fn=fn,fs=fs,fa=fa,rot=90+abs(grad),center=false,t=[-abs(dist)/2+extrude+r1,-y/2+yRef]),  // ok   
     [[extrude-abs(dist)/2+grad2X[0],-l1]],     
     [[x0*sign(dist),-l1]]
     ): concat(//center==-1||>1
     [[x0*sign(dist),0]],[[extrude+grad2X[1],0]],
     kreis(r=-r2,rand=0,grad=abs(grad)+grad2[1],rot=-90-grad2[1],center=false,fn=fn,fs=fs,fa=fa,t=[extrude-r2,y/2-l2+yRef]), // ok
     kreis(r=-r1,rand=0,grad=-abs(grad)-grad2[0],fn=fn,fs=fs,rot=90+abs(grad),center=false,t=[extrude+r1-abs(dist),-y/2-l2+yRef]),  // ok   
     [[extrude-abs(dist)+grad2X[0],-l2-l1]],     
     [[x0*sign(dist),-l2-l1]]     
     ):
     concat(//center==0
     [[x0*sign(dist),l2+l1]],[[extrude+abs(dist)+grad2X[1],l2+l1]],
     kreis(r=-r2,rand=0,grad=abs(grad)+grad2[1],rot=-90-grad2[1],center=false,fn=fn,fs=fs,fa=fa,t=[abs(dist)+extrude-r2,y/2+l1+yRef]), // ok
     kreis(r=-r1,rand=0,grad=-abs(grad)-grad2[0],fn=fn,fs=fs,fa=fa,rot=90+abs(grad),center=false,t=[extrude+r1,-y/2+l1+yRef]),  // ok   
     [[extrude+grad2X[0],0]],     
     [[x0*sign(dist),0]]     
     );
  if(dist>0&&gradN>0)  polygon(points,convexity=5);
  if(dist<0||gradN<0)mirror([1,0])  polygon(points,convexity=5);    
 }
 if(messpunkt&&is_num(extrude)){
     Pivot(KreisCenterR1[selectKC],messpunkt=messpunkt,active=[1,0,0,1]);
     Pivot(KreisCenterR2[selectKC],messpunkt=messpunkt,active=[1,0,0,1]);
 //echo(KreisCenterR1,KreisCenterR2);
 }
    //Warnings    
  Echo(str(name," SBogen has no TwoD-Object"),color=Hexstring([1,0.5,0]),size=4,condition=!$children&&!TwoD&&!extrudeTrue);
  Echo(str(name," SBogen width is determined by var TwoD=",TwoD,"mm"),color="info",size=4,condition=TwoD==1&&!extrudeTrue&&(is_undef($idx)||!$idx)&&$info);       
  Echo(str(name," SBogen r1/r2 to big  middle <0"),condition=l2m<0);
  Echo(str(name," SBogen radius 1 negative"),condition=r1<0);
  Echo(str(name," SBogen radius 2 negative"),condition=r2<0);    
  Echo(str(name," SBogen r1/r2 to big or angle or dist to short"),condition=grad!=0&&r1-cos(grad)*r1+r2-cos(grad)*r2>abs(dist));
  Echo(str(name," SBogen angle to small/ l1+l2 to short =",l1-y/2+yRef,"/",l2-y/2-yRef),condition=l1-y/2+yRef<0||l2-y/2-yRef<0);
   //Help    
  HelpTxt("SBogen",["dist",dist,"r1",r1,"r2",r2,"grad",grad,"l1",l1,"l2",l2,"center",center,"fn",fn,"messpunkt",messpunkt,"TwoD",TwoD,"extrude",extrude,"grad2",grad2,"x0",x0, "lRef", lRef, "lap",lap," ,name=",name],help); 
}
/** \name Bogen \page Objects
Bogen() creates a bended cylinder or children
\param grad angle
\param rad bend radius
\param l,l1,l2 straight length l⇒ [l1,l2]
\param fn fn2 fs fraqments
\param tcenter tangent
\param center centern
\param lap,spiel  overlap
\param d diameter (if no children)
\param messpunkt show bend center
\param TwoD  make TwoD
*/
//Bogen(TwoD=1,lap=+0,fn=0);
//Bogen();
module Bogen(grad=90,rad=5,l,l1=10,l2=12,fn=$fn,center=true,tcenter=false,name,d=3,fn2=0,fs=$fs,fa=$fa,lap=minVal,spiel,help,messpunkt=messpunkt,TwoD=false)
{
    $fn=fn;
    $fs=fs;
    $fa=fa;
    $helpM=0;
    $info=0;
    $idxON=false;
    ueberlapp=is_num(spiel)?-spiel:lap;
    l1=is_undef(l)?l1+ueberlapp:is_list(l)?l[0]+ueberlapp:l+ueberlapp;
    l2=is_undef(l)?l2+ueberlapp:is_list(l)?l[1]+ueberlapp:l+ueberlapp;
    TwoD=is_parent(needs2D)&&!$children?TwoD?b(TwoD,false):
                                       1:
                                    b(TwoD,false);
    c=sin(abs(grad)/2)*rad*2;//  Sekante 
    w1=abs(grad)/2;          //  Schenkelwinkel
    w3=180-abs(grad);        //  Scheitelwinkel
    a=(c/sin(w3/2))/2;    
    hc=grad!=180?Kathete(a,c/2):0;  // Sekante tangenten center
    hSek=Kathete(rad,c/2); //center Sekante
    bl=PI*rad/180*grad;//Bogenlänge
    mirror([grad<0?1:0,0,0])rotate(center?0:tcenter?-abs(grad)/2:+0)T(tcenter?grad>180?hSek+hc:-hSek-hc:0)rotate(tcenter?abs(grad)/2:0) T(center?0:tcenter?0:-rad){
    if(!TwoD) T(rad)R(+90,+0)Tz(-l1+ueberlapp){
      $idx=0;
      $tab=is_undef($tab)?1:b($tab,false)+1;
      color("green")   linear_extrude(l1,convexity=5)
            if ($children)mirror([grad<0?1:0,0,0])children();
            else circle(d=d,$fn=fn2);
     //color("lightgreen",.5)   T(0,0,l1)if(messpunkt&&$preview)R(0,-90,-90)Dreieck(h=l1,ha=pivotSize,grad=5,n=0);//Pivot(active=[1,1,1,0]);        
        }
    else T(rad)R(0,+0)T(0,-ueberlapp)color("green")T(-d/2)square([d,l1]);
    if(grad)if(!TwoD) rotate_extrude(angle=-abs(grad)-0,$fa = fn?abs(grad)/fn:fa, $fs = $fs,$fn=0,convexity=5)intersection(){
      $idx=1;
      $fn=fn;
      $fa=fa;
      T(rad)
            if ($children)mirror([grad<0?1:0,0,0])children();
                else circle(d=d,$fn=fn2); 
                translate([0,-500])square(1000);
            }
     else  Kreis(rand=d,grad=abs(grad),center=false,r=rad+d/2,fn=fn,fs=fs,name=0,help=0); 
     if (!TwoD)R(z=-abs(grad)-180) T(-rad,-ueberlapp)R(-90,180,0){
       $idx=2;
         color("darkorange")linear_extrude(l2,convexity=5)
            if ($children)mirror([grad<0?1:0,0,0])children();
            else circle(d=d,$fn=fn2);
         //color("orange",0.5)if(messpunkt&&$preview)T(0,0,l2)R(0,-90,-90)Dreieck(h=l2,ha=pivotSize,grad=5,n=0);//Pivot(active=[1,1,1,0]);   
        }
     else R(z=-abs(grad)-180) T(-rad,-ueberlapp) color("darkorange")T(-d/2)square([d,l2]);
    union(){//messpunkt
       color("yellow") Pivot(active=[1,0,0,1],messpunkt=messpunkt); 
       if(grad!=180)color("blue")mirror([0,grad<0?1:0,0]) translate(RotLang(90+grad/2,hc+hSek))Pivot(active=[1,0,0,1],messpunkt=messpunkt); 
       if(grad>180)color("lightblue")mirror([0,grad<0?1:0,0]) translate(RotLang(90+grad/2,-hc-hSek))Pivot(active=[1,0,0,1],messpunkt=messpunkt);     
    }  
    }
  if(name&&!$children)echo(str("»»» »»» ",name," Bogen ",grad,"° Durchmesser= ",d,"mm — Innenmaß= ",2*max(rad,d/2)-d,"mm Außenmaß= ",2*max(rad,d/2)+d));
  if(name)echo(str(name," Bogen ",grad,"° Radius=",rad,"mm Sekantenradius= ",hSek,"mm — Tangentenschnittpunkt=",hSek+hc,"mm TsSekhöhe=",hc,"mm Kreisstücklänge=",bl," inkl l=",bl+l1+l2,"mm"));
  if(!$children&&name&&!TwoD)Echo("Bogen missing Object! using circle",color="warning");
  HelpTxt("Bogen",["grad",grad,"rad",rad,"l",l,"l1",l1,"l2",l2,"fn",fn,"center",center,"tcenter",tcenter,"name",name,"d",d,"fn2",fn2,"fs",fs,"lap",lap,"messpunkt",messpunkt,"TwoD",TwoD],help);
}
/** \page Polygons
Kreis() creates a circle polygon
\name Kreis
\param r radius
\param dicke rim
\param grad angle
\param grad2 optional rim angle
\param fn fragments
\param center center (angle <360)
\param sek  secant or center point (angle <360)
\param r2  y radius for oval
\param rcenter rim center
\param rot rotate circle
\param t   translate circle
\param name name for circle
\param help help
\param d diameter optional to r = d↦r
\param id optional to dicke
\param b optional to grad, L of the circular arc
\param fs,fa fragment size optional to fn fs↦fn,min fraqment angle
*/
//Kreis(d=10,id=8,grad=270);
module Kreis(r=10,dicke=0,grad=360,grad2,fn,center=true,sek=false,r2=0,rand2,rcenter=0,rot=0,t=[0,0],name,help,d,b,fs=$fs,fa=$fa,rand,id){
    r=is_undef(d)?r:d/2;
    d=2*r;
    dicke=is_undef(rand)?is_undef(id)?dicke:(d-id)/2
                        :rand;
    grad=is_undef(b)?grad:r==0?0:b/(2*PI*r)*360;
    b=2*r*PI*grad/360;
   polygon( kreis(r=r,rand=dicke,grad=grad,grad2=grad2,fn=fn,center=center,sek=sek,r2=r2,rand2=rand2,rcenter=rcenter,rot=grad==360?center?rot:rot+90:center?rot+180:rot+90,t=t,fs=fn?undef:fs,endPoint=grad==360?false:true,fa=fa),convexity=5);
    HelpTxt("Kreis",["r",r,"dicke",dicke,"grad",grad,"grad2",grad2,"fn",fn,"center",center,"sek",sek,"r2",r2,"rand2",rand2,"rcenter",rcenter,"rot",rot,"t",t,"name",name,"d",d,", b",b,"id",id,"fs",fs],help);
    if(!rcenter){
      if(dicke>0)InfoTxt("Kreis",["id",2*(r-abs(dicke)),"od",2*r],name);
      if(dicke<0)InfoTxt("Kreis",["id",2*r,"od",2*(r+abs(dicke))],name); 
    }
    else if(dicke)InfoTxt("Kreis",["id",2*r-abs(dicke)," od=",2*r+abs(dicke)],name);   
}
/** \page Helper
Pivot() creates a pivot gizmo
* \name Pivot
* \brief creates a pivot gizmo
* \param p0  position of the Gizmo
* \param size size of the Gizmo
* \param active activate parts (center axis rotation text 
* \param messpunkt activates
* \param txt adds text
* \param rot rotates
* \param vpr orient text
* \param help activate help
*/
module Pivot(p0=[0,0,0],size,active=[1,1,1,1,1,1],messpunkt,txt,rot=0,vpr=$vpr,help=false){
  messpunkt=is_undef(messpunkt)?is_undef($messpunkt)?true:$messpunkt:messpunkt;
    p0=is_num(p0)?[p0,0]:p0;
    size=is_undef(size)?is_bool(messpunkt)?pivotSize:messpunkt:size;
    size2=size/+5;
  if(messpunkt&&$preview)translate(p0)%union(){
      if(active[3])rotate(rot)  color("blue")cylinder(size,d1=.5*size2,d2=0,center=false,$fn=4);
      if(active[2])rotate(rot)  color("green")rotate([-90,0,0])cylinder(size,d1=.5*size2,d2=0,center=false,$fn=4);
      if(active[1])rotate(rot)  color("red")rotate([0,90,0])cylinder(size,d1=.5*size2,d2=0,center=false,$fn=4);   
       if(active[0]) color("yellow")sphere(d=size2*.6,$fn=12);
       //Text
       if(active[4]) %color("grey")rotate(vpr)
          //linear_extrude(.1,$fn=1)
       text(text=str(norm(p0)?p0:""," ",rot?str(rot,"°"):"","   "),size=size2,halign="right",valign="top",font="Bahnschrift:style=light",$fn=1);    
       if(txt&&active[5])%color("lightgrey")rotate(vpr)translate([0,size/15])//linear_extrude(.1,$fn=1)
         Tz(0.1) text(text=str(txt,"   "),size=size2,font="Bahnschrift:style=light",halign="right",valign="bottom",$fn=1);
  }     
  HelpTxt("Pivot",[
     "p0",p0,
    "size",size,
    "active",active,
    "messpunkt",messpunkt,
    "txt",txt,
    "rot",rot,
    "vpr",vpr]
    ,help); 
}
// short for rotate(a,v=[0,0,0])
module R(x=0,y=0,z=0,help=false)
{
    rotate([x,y,z])children();
    MO(!$children);
    HelpTxt("R",["x",x,"y",y,"z",z],help);
}
//CombinedEnd from path ub_sbogen.scad
//Combined from path module_utility_wallcutout.scad


iwalcutoutconfig_type = 0;
iwalcutoutconfig_position = 1;
iwalcutoutconfig_width = 2;
iwalcutoutconfig_angle = 3;
iwalcutoutconfig_height = 4;
iwalcutoutconfig_cornerradius = 5;
function WallCutoutSettings(
    type = "disabled", 
    position = 0, 
    width = 0,
    angle = 0,
    height = 0, 
    corner_radius = 0) = 
  let(
    result = [
      type,
      position,
      width,
      angle,
      height,
      corner_radius],
    validatedResult = ValidateWallCutoutSettings(result)
  ) validatedResult;
function ValidateWallCutoutSettings(settings) =
  assert(is_list(settings), "Settings must be a list")
  assert(len(settings)==6, "Settings must length 6")
  assert(is_string(settings[iwalcutoutconfig_type]), "type must be a string")
  assert(is_num(settings[iwalcutoutconfig_position]) || is_list(settings[iwalcutoutconfig_position]), "position must be a list or number")
  assert(is_num(settings[iwalcutoutconfig_width]), "width must be a number")
  assert(is_num(settings[iwalcutoutconfig_angle]), "angle must be a number")
  assert(is_num(settings[iwalcutoutconfig_height]), "height must be a number")
  assert(is_num(settings[iwalcutoutconfig_cornerradius]), "corner radius must be a number")
  [
    settings[iwalcutoutconfig_type],
    is_num(settings[iwalcutoutconfig_position]) ? [settings[iwalcutoutconfig_position]] : settings[iwalcutoutconfig_position],
    settings[iwalcutoutconfig_width],
    settings[iwalcutoutconfig_angle],
    settings[iwalcutoutconfig_height],
    settings[iwalcutoutconfig_cornerradius]
  ];
iwalcutout_config = 0;
iwalcutout_enabled = 1;
iwalcutout_position = 2;
iwalcutout_size = 3;
iwalcutout_rotation = 4;
iwalcutout_reposition = 5;
function calculateWallCutouts(
  wall_length,
  opposite_wall_distance,
  wallcutout_settings,
  wallcutout_rotation = [0,0,0],
  wallcutout_reposition = [0,0,0],
  wall_thickness,
  cavityFloorRadius,
  wallTop,
  z_point,
  floorHeight,
  pitch,
  pitch_opposite) =
    let(wallcutout_positions = wallcutout_settings[iwalcutoutconfig_position])
    [for (i = [0:len(wallcutout_positions)-1])
      calculateWallCutout(
        wall_length = wall_length,
        opposite_wall_distance = opposite_wall_distance,
        wallcutout_settings = wallcutout_settings,
        wallcutout_position = wallcutout_positions[i],
        wallcutout_rotation = wallcutout_rotation,
        wallcutout_reposition = wallcutout_reposition,
        wall_thickness = wall_thickness,
        cavityFloorRadius = cavityFloorRadius,
        wallTop = wallTop,
        z_point = z_point,
        floorHeight = floorHeight,
        pitch = pitch,
        pitch_opposite = pitch_opposite)];
function calculateWallCutout(
  wall_length,
  opposite_wall_distance,
  wallcutout_settings,
  wallcutout_position,
  wallcutout_rotation = [0,0,0],
  wallcutout_reposition = [0,0,0],
  wall_thickness,
  cavityFloorRadius,
  wallTop,
  z_point,
  floorHeight,
  pitch,
  pitch_opposite) =
     let(
        wallcutout_type = wallcutout_settings[iwalcutoutconfig_type],
        wallcutout_width = wallcutout_settings[iwalcutoutconfig_width],
        wallcutout_angle = wallcutout_settings[iwalcutoutconfig_angle],
        wallcutout_height = wallcutout_settings[iwalcutoutconfig_height],
        wallcutout_corner_radius = wallcutout_settings[iwalcutoutconfig_cornerradius],
        is_enabled = wallcutout_position <= -1 || wallcutout_position >= 0,
        max_height = wallcutout_type == "inneronly" ? z_point : wallTop,
        fullEnabled = wallcutout_type == "enabled",
        innerEnabled = wallcutout_type == "inneronly",
        closeEnabled = wallcutout_type == "wallsonly" || wallcutout_type == "leftonly" || wallcutout_type == "frontonly",
        farEnabled = wallcutout_type == "wallsonly" || wallcutout_type == "rightonly" || wallcutout_type == "backonly",
        wallcutoutThickness = wall_thickness*2+max(wall_thickness*2,cavityFloorRadius), //wall_thickness*2 should be lip thickness
        wallcutoutHeight = wallcutout_height < 0 
            ? (max_height - floorHeight)/abs(wallcutout_height)
            : wallcutout_height == 0 ? max_height - floorHeight - cavityFloorRadius
            : wallcutout_height,
        wallcutoutLowerWidth=wallcutout_width <= 0 ? max(wallcutout_corner_radius*2, wall_length*pitch/3) : wallcutout_width,
        closeThickness = 
          fullEnabled ? opposite_wall_distance*pitch_opposite 
          : innerEnabled ? opposite_wall_distance*pitch_opposite - wallcutoutThickness*2 
          : wallcutoutThickness,
        clearance = env_clearance().x, //This should take in to account if its x or y, but for now we assume they are the same.
        closePosition = 
          innerEnabled ? closeThickness/2+clearance/2+wallcutoutThickness
          : closeThickness/2+clearance/2-fudgeFactor,
      //This could be more specific based on the base height, and the lip style.
      wallcutout_close = [
          //walcutout_config
          [wallcutout_type, wallcutout_position, wallcutout_width, wallcutout_angle, wallcutout_height, wallcutout_corner_radius],
          //walcutout_enabled
          is_enabled && (closeEnabled || fullEnabled || innerEnabled),
          //wallcutout_position
          [wallCutoutPosition_mm(wallcutout_position,wall_length,pitch), closePosition, max_height],
          //wallcutout_size
          [wallcutoutLowerWidth, closeThickness, wallcutoutHeight],
          //wallcutout_rotation
          wallcutout_rotation,
          //wallcutout_reposition
          wallcutout_reposition],
      wallcutout_far = [
          //walcutout_config
          [wallcutout_type, wallcutout_position, wallcutout_width, wallcutout_angle, wallcutout_height, wallcutout_corner_radius],
          //walcutout_enabled
          is_enabled && farEnabled,
          //wallcutout_position
          [wallCutoutPosition_mm(wallcutout_position,wall_length,pitch), opposite_wall_distance*pitch_opposite-wallcutoutThickness/2-clearance/2+fudgeFactor, max_height],
          //wallcutout_size
          [wallcutoutLowerWidth, wallcutoutThickness, wallcutoutHeight],
          //wallcutout_rotation
          wallcutout_rotation,
          //wallcutout_reposition
          wallcutout_reposition]) [wallcutout_close, wallcutout_far];
module WallCutout(
  lowerWidth=50,
  wallAngle=70,
  height=21,
  thickness=10,
  cornerRadius=5,
  topHeight) {
  topHeight = is_undef(topHeight) || topHeight < 0 ? cornerRadius*4 : topHeight;
  bottomWidth = lowerWidth;
  topWidth = lowerWidth+(height/tan(wallAngle))*2;
  rotate([90,0,0])
  translate([0,0,-thickness/2])
  linear_extrude(height=thickness)
  intersection(){
    translate([0,-height/2+topHeight/2,0])
    square([topWidth+cornerRadius*2,height+topHeight], true);
    //Use triple offset to fillet corners
    //https://www.reddit.com/r/openscad/comments/ut1n7t/quick_tip_simple_fillet_for_2d_shapes/
    offset(r=-cornerRadius)
    offset(r=2 * cornerRadius)
    offset(r=-cornerRadius)
    union(){
      translate([0,cornerRadius*4/2])
      square([topWidth*2,cornerRadius*4], true);
      hull(){
        translate([0,cornerRadius*4/2])
        square([topWidth,cornerRadius*4], true);
        translate([0,-height/2])
        square([bottomWidth,height], true);
      }
    }
  }
}
//CombinedEnd from path module_utility_wallcutout.scad
//Combined from path functions_general.scad



function sum(list, c = 0, end) = 
  let(end = is_undef(end) ? len(list) : end)
  c < 0 || end < 0 ? 0 : 
  c < len(list) - 1 && c < end
    ? list[c] + sum(list, c + 1, end=end) 
    : list[c];
function vector_sum(v, start=0, end, itemIndex) = 
  let(v=is_list(v)?v:[v], end = is_undef(end)?len(v)-1:min(len(v)-1,end))
  is_num(itemIndex) 
    ? start<end ? v[start][itemIndex] + vector_sum(v, start+1, end, itemIndex) : v[start][itemIndex]
    : start<end ? v[start] + vector_sum(v, start+1, end, itemIndex) : v[start];    
//round a number to a decimal with a defined number of significant figures
function roundtoDecimal(value, sigFigs = 0) = 
  assert(is_num(value), "value must be a number")
  assert(is_num(sigFigs) && sigFigs >= 0, "sigFigs must be a number")
  let(
    sigFigs = round(sigFigs),
    factor = 10^round(sigFigs))
    sigFigs == 0 
      ? round(value) 
      : round(value*factor)/factor;
function DictGet(list, key, alert=false) = 
  let(matchResults = search([key],list,1),
    matchIndex = is_list(matchResults) && len(matchResults)==1 && is_num(matchResults[0]) ? matchResults[0]: undef,
    alertMessage = str("count not find key in list key:'", key, "' matchResults:'", matchResults, "' matchIndex:'", matchIndex),
    matchValue = is_num(matchIndex) ? list[matchIndex] : undef,
    x = !alert && is_undef(matchValue) ? echo(alertMessage) : 1)
    assert(!alert || !is_undef(matchValue), alertMessage)
      matchValue[1];
function DictSetRange(list, keyValueArray) = !(len(keyValueArray)>0) ? list : 
  assert(is_list(list), str("DictSetRange(keyValueArray, arr) - arr is not a list. list:",list))
  assert(is_list(keyValueArray), str("DictSetRange(keyValueArray, arr) - keyValueArray is not a list. keyValueArray:", keyValueArray))
  let(currentKeyValue = keyValueArray[0])
  assert(is_list(currentKeyValue), str("DictSetRange(keyValueArray, arr) - currentKeyValue is not a list. currentKeyValue:",currentKeyValue))
  assert(len(currentKeyValue)==2, str("DictSetRange(keyValueArray, arr) - currentKeyValue is not length of 2. currentKeyValue:",currentKeyValue))
  assert(is_string(currentKeyValue[0]), str("DictSetRange(keyValueArray, arr) - currentKeyValue[0] is not a string, currentKeyValue:",currentKeyValue))
  let(keyValueArrayNext = remove_item(keyValueArray,0),
    updatedList = DictSet(list, currentKeyValue)
  ) concat(DictSetRange(updatedList, keyValueArrayNext));
function DictSet(list, keyValue) = 
  assert(is_list(list), str("DictSet(keyValueArray, arr) - arr is not a list list:", list))
  assert(is_list(keyValue), str("DictSet(keyValueArray, arr) - keyValueArray is not a list. keyValue:",keyValue))
  assert(len(keyValue)==2, str("DictSet(keyValueArray, arr) - keyValueArray is not a list. keyValue:",keyValue))
  let(matchResults = search([keyValue[0]],list,1),
    matchIndex = is_list(matchResults) && len(matchResults)==1 && is_num(matchResults[0]) ? matchResults[0] : undef)
  assert(!is_undef(matchIndex), str("count not find key in list, key:'", keyValue[0], "'", DictToString(list)))
    replace(list, matchIndex, keyValue);
module DictDisplay(list, name = ""){
  echo(DictToString(list=list,name=name));
}
function DictToString(list, name = "") =
  let(infoText=[for(i=[0:len(list)-1])str(list[i][0],"=",list[i][1])])
  str("🟧", name, concatstringarray(infoText));
function concatstringarray(in, out="",pos=0, sep="\r\n  ") = pos>=len(in)?out:
  concatstringarray(in=in,out=str(out,sep,in[pos]),pos=pos +1); 
//Replace multiple values in an array
function replace_Items(keyValueArray, arr) = !(len(keyValueArray)>0) ? arr : 
  assert(is_list(arr), "replace_Items(keyValueArray, arr) - arr is not a list")
  assert(is_list(keyValueArray), "replace_Items(keyValueArray, arr) - keyValueArray is not a list")
  let(currentKeyValue = keyValueArray[0])
  assert(is_list(currentKeyValue), "replace_Items(keyValueArray, arr) - currentKeyValue is not a list")
  assert(is_num(currentKeyValue[0]), "replace_Items(keyValueArray, arr) - currentKeyValue[0] is not a number")
  let(keyValueArrayNext = remove_item(keyValueArray,0),
    updatedList = replace(arr, currentKeyValue[0],currentKeyValue[1])
) concat(replace_Items(keyValueArrayNext, updatedList));
//Replace a value in an array
function replace(list,position,value) = 
  assert(is_list(list), "replace(list,position,value) - list is not a list")
  assert(is_num(position), "replace(list,position,value) - position is not a number")
  let (
    l1 = position > 0 ? partial(list,start=0,end=position-1) : [], 
    l2 = position < len(list)-1 ? partial(list,start=position+1,end=len(list)-1) :[]
  ) concat(l1,[value],l2);
// takes part of an array
function partial(list,start,end) = [for (i = [start:end]) list[i]];
//Removes item from an array
function remove_item(list,position) = [for (i = [0:len(list)-1]) if (i != position) list[i]];
//Takes a string and converts it in to an array of arrays.
//I.E.  "0, 0, 0.5, 3, 2, 6|0.5, 0, 0.5, 3,2, 6|1, 0, 3, 1.5|1, 1.5, 3, 1.5";
//becomes  [[0, 0, 0.5, 3, 2, 6], [0.5, 0, 0.5, 3, 2, 6], [1, 0, 3, 1.5], [1, 1.5, 3, 1.5]]
function splitCustomConfig(customConfig) = let(
  compartments = split(customConfig, "|")
) [for (x =[0:1:len(compartments)-1]) csv_parse(compartments[x])];
/*
U+1F7E5 🟥 LARGE RED SQUARE
U+1F7E6 🟦 LARGE BLUE SQUARE
U+1F7E7 🟧 LARGE ORANGE SQUARE
U+1F7E8 🟨 LARGE YELLOW SQUARE
U+1F7E9 🟩 LARGE GREEN SQUARE
U+1F7EA 🟪 LARGE PURPLE SQUARE
U+1F7EB 🟫 LARGE BROWN SQUARE
U+2B1B ⬛ BLACK LARGE SQUARE
U+2B1C ⬜ WHITE LARGE SQUARE
*/
function outputCustomConfig(typecode, arr) = let(
  config = createCustomConfig(arr),
  dynamicConfig = str("\"", typecode,"\"", ",", config)
) str("🟦 Generating 'tray' config, to be used in custom config.\r\nLocal Config\r\n\t", config, "\r\nDynamic Config\r\n\t", dynamicConfig,"\r\n");
function createCustomConfig(arr, pos=0, sep = ",") = pos >= len(arr) ? "" :
  let(
    current = is_list(arr[pos]) ? createCustomConfig(arr[pos], sep=";") 
      : is_string(arr[pos]) ? str("\"",arr[pos],"\"")
      : arr[pos],
    strNext = createCustomConfig(arr, pos+1, sep)
  ) str(current, strNext!=""?str(sep, strNext):"");
module assert_openscad_version(){
  assert(version()[0]>2022,"Gridfinity Extended requires an OpenSCAD version greater than 2022 https://openscad.org/downloads. Use Development Snapshots if the release version is still 2021.01 https://openscad.org/downloads.html#snapshots.");
}
// Gets one value base on another.
// if user_value = 0 use the base value
// user_value > 0 use that value
// user_value < 0 base_value/abs(user_value) (i.e. -3 is 1/3 the base_value)
function get_related_value(user_value, base_value, default_value, max_value) = 
  let(
      max_value = is_undef(max_value) ? base_value : max_value,
      default = is_undef(default_value) ? base_value : default_value,
      calculated = user_value == 0 ? default :
      user_value < 0 ? base_value/abs(user_value) : user_value)
      min(calculated, max_value);
module highlight_conditional(enable=false){
  if(enable)
    #children();
  else
    children();
}
function color_from_list(index) = 
let(
  colours = ["white","red","blue","Green","pink","orange","purple","black", "Coral", "Gray", "Teal"],
  mod_index = index%len(colours)
) colours[mod_index];
module color_conditional(enable=true, c, alpha = 1){
  if(enable)
  color(c, alpha)
    children();
  else
    children();
}
module exclusive_conditional(enable=true){
  if(enable)
    !children();
  else
    children();
}
module render_conditional(enable=true){
  if(enable)
    render()
      children();
  else
    union()
      children();
}
module hull_conditional(enabled = true)
{
  if(enabled){
    hull(){
      children();
    }
  }
  else{
    union(){
      children();
    }
  }
}
//CombinedEnd from path functions_general.scad
//Combined from path functions_string.scad


// String functions found here https://github.com/thehans/funcutils/blob/master/string.scad
join = function (l,delimiter="") 
  let(s = len(l), d = delimiter,
      jb = function (b,e) let(s = e-b, m = floor(b+s/2)) // join binary
        s > 2 ? str(jb(b,m), jb(m,e)) : s == 2 ? str(l[b],l[b+1]) : l[b],
      jd = function (b,e) let(s = e-b, m = floor(b+s/2))  // join delimiter
        s > 2 ? str(jd(b,m), d, jd(m,e)) : s == 2 ? str(l[b],d,l[b+1]) : l[b])
  s > 0 ? (d=="" ? jb(0,s) : jd(0,s)) : "";
substr = function(s,b,e) let(e=is_undef(e) || e > len(s) ? len(s) : e) (b==e) ? "" : join([for(i=[b:1:e-1]) s[i] ]);
split = function(s,separator=" ") separator=="" ? [for(i=[0:1:len(s)-1]) s[i]] :
  let(t=separator, e=len(s), f=len(t),
    _s=function(b,c,d,r) b<e ?
      (s[b]==t[c] ?
        (c+1 == f ?
          _s(b+1,0,b+1,concat(r,substr(s,d,b-c))) : // full separator match, concat substr to result
          _s(b+1,c+1,d,r) ) : // separator match char, more to test
        _s(b-c+1,0,d,r) ) : // separator mismatch
      concat(r,substr(s,d,e))) // end of input string, return result
  _s(0,0,0,[]);
fixed = function(x,w,p,sp="0")
  assert(len(sp)==1)
  let(mult = pow(10,p), x2 = round(x*mult)/mult,
    lz = function (x, l) l>1 && abs(x) < pow(10,l-1) ? str(sp, lz(x,l-1)) : "",
    tz = function (x, t) let(mult=pow(10,t-1)) t>0 && abs(floor(x*mult)-x*mult) < 1e-9 ? str(sp, tz(x,t-1)) : ""
  )
  str(x2<0?"-":" ", lz(x2,w-p-2), abs(x2), abs(floor(x)-x2)<1e-9 ? "." : "" ,tz(x2,p));
float = function(s) let(
    _f = function(s, i, x, vM, dM, ddM, m)
      i >= len(s) ? round(x*dM)/dM :
      let(
        d = ord(s[i])
      )
      (d == 32 && m == 0) || (d == 43 && (m == 0 || m == 2)) ?
        _f(s, i+1, x, vM, dM, ddM, m) :
      d == 45 && (m == 0 || m == 2) ?
        _f(s, i+1, x, vM, -dM, ddM, floor(m/2)+1) :
      d >= 48 && d <= 57 ?
        _f(s, i+1, x*vM + (d-48)/dM, vM, dM*ddM, ddM, floor(m/2)+1) :
      d == 46 && m<=1 ? _f(s, i+1, x, 1, 10*dM, 10, max(m, 1)) :
      (d == 69 || d == 101) && m==1 ? let(
          expon = _f(s, i+1, 0, 10, 1, 1, 2)
        )
        (is_undef(expon) ? undef : expon >= 0 ?
          (round(x*dM)*(10^expon/dM)) :
          (round(x*dM)/dM)/10^(-expon)) :
      undef
  )
  _f(s, 0, 0, 10, 1, 1, 0);
csv_parse = function(s) [for (e=split(s, ",")) float(e)];
//CombinedEnd from path functions_string.scad
//Combined from path functions_environment.scad





//Set up the Environment, if not run object should still render using defaults
module set_environment(
  width,
  depth,
  height = 0,
  height_includes_lip = false,
  lip_enabled = false,
  clearance = [0.5, 0.5, 0],
  setColour = "preview",
  help = false,
  render_position = "center", //[default,center,zero]
  cut = [0,0,0],
  pitch = [gf_pitch, gf_pitch, gf_zpitch],
  corner_radius = gf_cup_corner_radius,
  randomSeed = 0,
  force_render = true,
  generate_filter = ""){
  //Set special variables, that child modules can use
  $pitch = pitch;
  $setColour = setColour;
  $showHelp = help;
  $randomSeed = randomSeed;
  $forceRender = force_render;
  $clearance = clearance;
  $corner_radius = corner_radius;
  $user_width = width;
  $user_depth = depth;
  $user_height = height;
  $generate_filter = generate_filter;
  num_x = calcDimensionWidth(width, true); 
  num_y = calcDimensionDepth(depth, true); 
  num_z = 
    let(z_temp = calcDimensionHeight(height, true)) 
    height_includes_lip && lip_enabled ? z_temp - gf_Lip_Height/pitch.z : z_temp;
  $num_x = num_x; 
  $num_y = num_y; 
  $num_z = num_z; 
  $cutx = calcDimensionWidth(cut.x);
  $cuty = calcDimensionWidth(cut.y);
  $cutz = calcDimensionWidth(cut.z);
  echo("🟩set_environment", fs=$fs, fa=$fa, fn=$fn,  clearance=clearance, corner_radius=corner_radius, height_includes_lip=height_includes_lip, lip_enabled=lip_enabled);
  echo("🟩set_environment", width=width, depth=depth, height=height, pitch=pitch);
  echo("🟩set_environment", num_x=num_x, num_y=num_y, num_z=num_z);
  //Position the object
  translate(gridfinityRenderPosition(render_position,num_x,num_y))
  union(){
    difference(){
      //Render the object
      children(0);
      //Render the cut, used for debugging
      /*
      if(cutx > 0 && cutz > 0 && $preview){
        color(color_cut)
        translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
          cube([env_pitch().x*cutx,num_y*env_pitch().y+fudgeFactor*2,(cutz+1)*env_pitch().z]);
      }
      if(cuty > 0 && cutz > 0 && $preview){
        color(color_cut)
        translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
          cube([num_x*env_pitch().x+fudgeFactor*2,env_pitch().y*cuty,(cutz+1)*env_pitch().z]);
      }*/
    }
    //children(1);
  }
}
function env_numx() = is_undef($num_x) || !is_num($num_x) ? 0 : $num_x;
function env_numy() = is_undef($num_y) || !is_num($num_y) ? 0 : $num_y;
function env_numz() = is_undef($num_z) || !is_num($num_z) ? 0 : $num_z;
function env_clearance() = is_undef($clearance) || !is_list($clearance) ? [0,0,0] : $clearance;
function env_generate_filter() = (is_undef($generate_filter) || !is_string($generate_filter)) ? "" : $generate_filter;
function env_pitch() =  is_undef($pitch) || !is_list($pitch) ? [gf_pitch, gf_pitch, gf_zpitch] : $pitch; 
function env_corner_radius() =  is_undef($corner_radius) || !is_num($corner_radius) ? gf_cup_corner_radius : $corner_radius; 
function env_cutx() = is_undef($cutx) || !is_num($cutx) ? 0 : $cutx;
function env_cuty() = is_undef($cuty) || !is_num($cuty) ? 0 : $cuty;
function env_cutz() = is_undef($cutz) || !is_num($cutz) ? 0 : $cutz;
function env_random_seed() = is_undef($randomSeed) || !is_num($randomSeed) || $randomSeed == 0 ? undef : $randomSeed;
function env_force_render() = is_undef($forceRender) ? true : $forceRender;
//set_colour = "preview"; //[disabled, preview, lip]
function env_colour(colour, isLip = false, fallBack = color_cup) = 
    is_undef($setColour) 
      ? $preview ? colour : fallBack
      : is_string($setColour) 
        ? $setColour == "enable" ? colour
        : $setColour == "preview" && $preview ? colour
          : $setColour == "lip" && isLip ? colour
            : fallBack
          : fallBack;
function env_generate_filter_enabled(filter) = 
  echo("env_generate_filter_enabled", filter=filter, env_generate_filter=env_generate_filter())
  env_generate_filter() == filter || 
  env_generate_filter() == "" || 
  env_generate_filter() == "everything" || 
  is_undef(env_generate_filter());
function env_help_enabled(level) = 
  is_string(level) && level == "force" ? true
    : is_undef($showHelp) ? false
      : is_bool($showHelp) ? $showHelp
        : is_string($showHelp) 
          ? $showHelp == "info" && level == "info" ? true
            : $showHelp == "debug" && (level == "info" || level == "debug") ? true
            : $showHelp == "trace" && (level == "info" || level == "debug" || level == "trace") ? true
            : false
          : false;
//CombinedEnd from path functions_environment.scad
//Combined from path functions_gridfinity.scad





// set this to produce sharp corners on baseplates and bins
// not for general use (breaks compatibility) but may be useful for special cases
sharp_corners = 0;
function calcDimensionWidth(width, shouldLog = false) = calcDimension(width, "width", env_pitch().x, shouldLog);
function calcDimensionDepth(depth, shouldLog = false) = calcDimension(depth, "depth", env_pitch().y, shouldLog);
function calcDimensionHeight(height, shouldLog = false) = calcDimension(height, "height", env_pitch().z, shouldLog); 
function calcDimension(value, name, unitSize, shouldLog) = 
  is_num(value) ? 
    (shouldLog ? echo(str("🟩",name,": ", value, "gf (",value*unitSize,"mm)"), input=value) value : value)
  : assert(is_list(value) && len(value) == 2, str(unitSize ," should be array of length 2"))
    let(calcUnits = value[1] != 0 ? value[1]/unitSize : value[0],
    roundedCalcUnits = roundtoDecimal(calcUnits,4))
    (shouldLog ? echo(str("🟩",name,": ", calcUnits, "gf (",calcUnits*unitSize,"mm)"), input=value, roundedCalcUnits=roundedCalcUnits) roundedCalcUnits: roundedCalcUnits);
constTopHeight = let(fudgeFactor = 0.01) 5.7+fudgeFactor*5; //Need to confirm this
//returns unit position to mm.
//positive values are in units.
//negative values are ration total/abs(value)
function wallCutoutPosition_mm(userPosition, wallLength, pitch) = unitPositionTo_mm(userPosition, wallLength, pitch);
function unitPositionTo_mm(userPosition, wallLength, pitch) = 
  assert(is_num(userPosition), "userPosition must be a number")
  assert(is_num(wallLength), "wallLength must be a number")
  assert(is_num(pitch), "pitch must be a number")
  (userPosition < 0 ? wallLength*pitch/abs(userPosition) : pitch*userPosition);
//0.6 is needed to align the top of the cutout, need to fix this
function calculateWallTop(num_z, lip_style) =
  //env_pitch().z * num_z + (lip_style != "none" ? gf_Lip_Height-0.6 : 0);
  env_pitch().z * num_z + (lip_style != "none" ? gf_Lip_Height : 0);
  //calculates the magent position in from the center of the pitch in a single dimention
function calculateAttachmentPosition(magnet_diameter=0, screw_diameter=0, pitch = env_pitch().x) = 
  assert(is_num(magnet_diameter) && magnet_diameter >= 0, "magnet_diameter must be a non-negative number")
  assert(is_num(screw_diameter) && screw_diameter >= 0, "screw_diameter must be a non-negative number")
  assert(is_num(pitch) && pitch >= 0, "pitch must be a non-negative number")
  let(attachment_diameter = max(magnet_diameter, screw_diameter))
  attachment_diameter == 0 
    ? 0
    : min(pitch/2-8, pitch/2-4-attachment_diameter/2);
//calculates the magent position in from the center of the pitch in a both x and y dimention
function calculateAttachmentPositions(magnet_diameter=0, screw_diameter=0, pitch = env_pitch()) = 
  assert(is_num(magnet_diameter) && magnet_diameter >= 0, "magnet_diameter must be a non-negative number")
  assert(is_num(screw_diameter) && screw_diameter >= 0, "screw_diameter must be a non-negative number")
  assert(is_list(pitch) && len(pitch) == 3, "pitch must be a list of three numbers")
  [calculateAttachmentPosition(magnet_diameter, screw_diameter, pitch.x),
  calculateAttachmentPosition(magnet_diameter, screw_diameter, pitch.y)];
//zpos from 0 for wall pattern to clear. outer walls and dividers use this
function wallpatternClearanceHeight(magnet_depth, screw_depth, center_magnet, floor_thickness, num_z=1, filled_in="disabled", efficient_floor, flat_base, floor_inner_radius, outer_cup_radius) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_num(floor_thickness))
  assert(is_num(num_z))
  assert(is_string(filled_in)) 
  assert(is_string(efficient_floor)) 
  assert(is_string(flat_base))
  assert(is_num(floor_inner_radius))
  assert(is_num(outer_cup_radius))
  let(cfh = calculateFloorHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor=efficient_floor, flat_base=flat_base),
      cbch = cupBaseClearanceHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, center_magnet=center_magnet, flat_base=flat_base),
      _floor_inner_radius = efficient_floor == FlatBase_off ? floor_inner_radius : 0,
      result = max(
        (efficient_floor == EfficientFloor_off ? cfh+floor_inner_radius : 5.3), //5.3 clears the inner radius of smooth
        (flat_base == FlatBase_gridfinity ? cfh + _floor_inner_radius : 0),
        (flat_base == FlatBase_rounded ? max(outer_cup_radius, _floor_inner_radius+floor_thickness) : 0)))
      env_help_enabled("trace") ? echo("wallpatternClearanceHeight", result=result, cbch=cbch, magnet_depth=magnet_depth, screw_depth=screw_depth, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor=efficient_floor, flat_base=flat_base) result : result;
function calculateCavityFloorRadius(cavity_floor_radius, wall_thickness, efficientFloor) = let(
  q = 1.65 - wall_thickness + 0.95 // default 1.65 corresponds to wall thickness of 0.95
  //efficient floor has an effective radius of 0
) efficientFloor != "off" ? 0 
  : cavity_floor_radius >= 0 ? min((2.3+2*q)/2, cavity_floor_radius) : (2.3+2*q)/2;
//Height to clear the voids in the base (attachments and inner grid).
function cupBaseClearanceHeight(magnet_depth, screw_depth, center_magnet, flat_base=FlatBase_off) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_string(flat_base))
  flat_base == FlatBase_rounded ? max(magnet_depth, screw_depth) //todo should consider rounded radius.
    : flat_base == FlatBase_gridfinity ? max(gf_base_grid_clearance_height, magnet_depth, screw_depth) //3.5 clears the side stacking indents
    : max(magnet_depth, screw_depth, gfBaseHeight());
//Height of base including the floor.
function calculateFloorHeight(magnet_depth, screw_depth, center_magnet=0, floor_thickness, num_z=1, filled_in="disabled", efficient_floor, flat_base, captive_magnet_height=0) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_num(floor_thickness))
  assert(is_num(num_z))
  assert(is_string(filled_in))
  assert(is_string(efficient_floor))
  assert(is_string(flat_base))
  assert(is_num(captive_magnet_height))
  let(
    filled_in = validateFilledIn(filled_in),
    floorThickness = max(floor_thickness, gf_cup_floor_thickness),
    clearanceHeight = cupBaseClearanceHeight(magnet_depth=magnet_depth + captive_magnet_height, screw_depth=screw_depth, center_magnet=center_magnet, flat_base=flat_base), 
    result = 
      filled_in != FilledIn_disabled ? num_z * env_pitch().z 
        : efficient_floor != "off" 
          ? floorThickness
          : max(0, clearanceHeight + floorThickness))
  env_help_enabled("trace") ? echo("calculateFloorHeight", result=result, magnet_depth=magnet_depth, screw_depth=screw_depth, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor=efficient_floor, flat_base=flat_base) result : result;
//Usable floor depth (floor height - height of voids)
//used in the item holder
function calculateUsableFloorThickness(magnet_depth, screw_depth, center_magnet=0,floor_thickness, num_z, filled_in, flat_base=FlatBase_off) = 
  assert(is_num(magnet_depth))
  assert(is_num(screw_depth))
  assert(is_num(center_magnet))
  assert(is_num(floor_thickness))
  assert(is_num(num_z))
  assert(is_string(filled_in))
  assert(is_string(flat_base))
  let(
    cfh = calculateFloorHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, center_magnet=center_magnet, floor_thickness=floor_thickness, num_z=num_z, filled_in=filled_in, efficient_floor="off", flat_base=flat_base),
    cbch = cupBaseClearanceHeight(magnet_depth=magnet_depth, screw_depth=screw_depth, center_magnet=center_magnet, flat_base=flat_base),
    usableFloorThickness = cfh - cbch)
  env_help_enabled("trace") ? 
  echo("calculateFloorThickness", usableFloorThickness=usableFloorThickness, cfh=cfh, cbch=cbch, num_z=num_z, magnet_depth=magnet_depth,screw_depth=screw_depth, floor_thickness=floor_thickness, filledin=filledin) usableFloorThickness :
  usableFloorThickness;
function gridfinityRenderPosition(position, num_x, num_y) = 
    position == "center" ? [-(num_x)*env_pitch().x/2, -(num_y)*env_pitch().y/2, 0] 
    : position == "zero" ? [0, 0, 0] 
    : [-env_pitch().x/2, -env_pitch().y/2, 0]; 
//wall_thickness default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm) 
function wallThickness(wall_thickness, num_z) = wall_thickness != 0 ? wall_thickness
        : num_z < 6 ? 0.95
        : num_z < 12 ? 1.2
        : 1.6;
/* Data types */
function list_contains(list,value,index=0) = 
  assert(is_list(list), "list must be a list")
  assert(index >= 0 && index < len(list), str("List does not contain value '", value, "'index is invalid len '" , len(list) , "' index '", index, "' List:", list))
  list[index] == value 
    ? true 
    : index <= len(list)  ? list_contains(list,value,index+1)
    : false;
function typeerror(type, value) = str("invalid value for type '" , type , "'; value '" , value ,"'");
function typeerror_list(name, list, expectedLength) = str(name, " must be a list of length ", expectedLength, ", length:", is_list(list) ? len(list) : "not a list");
FilledIn_disabled = "disabled";
FilledIn_enabled = "enabled";
FilledIn_enabledfilllip = "enabledfilllip";
FilledIn_values = [FilledIn_disabled,FilledIn_enabled,FilledIn_enabledfilllip];
function validateFilledIn(value) = 
  //Convert boolean to list value
  let(value = is_bool(value) ? value ? FilledIn_enabled : FilledIn_disabled : value)
  assert(list_contains(FilledIn_values, value), typeerror("FilledIn", value))
  value;
Stackable_enabled = "enabled";
Stackable_disabled = "disabled";
Stackable_filllip = "filllip";
Stackable_values = [Stackable_enabled,Stackable_disabled,Stackable_filllip];
  function validateStackable(value) = 
  //Convert boolean to list value
  let(value = is_bool(value) ? value ? Stackable_enabled : Stackable_disabled : value) 
  assert(list_contains(Stackable_values, value), typeerror("Stackable", value))
  value;  
//CombinedEnd from path functions_gridfinity.scad
//Combined from path module_gridfinity_cup_base.scad




/* [Base]
// (Zack's design uses magnet diameter of 6.5) 
magnet_diameter = 0;  // .1
//create relief for magnet removal 
magnet_easy_release  = "auto";//["off","auto","inner","outer"] 
// (Zack's design uses depth of 6)
screw_depth = 0;
center_magnet_diameter =0;
center_magnet_thickness = 0;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = true;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth] 
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = false;
// Remove floor to create a vertical spacer
spacer = false;
*/
iCupBase_MagnetSize=0;
iCupBase_MagnetEasyRelease=1;
iCupBase_CenterMagnetSize=2;
iCupBase_ScrewSize=3;
iCupBase_HoleOverhangRemedy=4;
iCupBase_CornerAttachmentsOnly=5;
iCupBase_FloorThickness=6;
iCupBase_CavityFloorRadius=7;
iCupBase_EfficientFloor=8;
iCupBase_HalfPitch=9;
iCupBase_FlatBase=10;
iCupBase_Spacer=11;
iCupBase_MinimumPrintablePadSize=12;
iCupBase_FlatBaseRoundedRadius=13;
iCupBase_FlatBaseRoundedEasyPrint=14;
iCupBase_MagnetCaptiveHeight=15;
iCupBase_AlignGrid=16;
iCylinderDimension_Diameter=0;
iCylinderDimension_Height=1;
EfficientFloor_off = "off";
EfficientFloor_on = "on";
EfficientFloor_rounded = "rounded";
EfficientFloor_smooth = "smooth";
EfficientFloor_values = [EfficientFloor_off, EfficientFloor_on, EfficientFloor_rounded, EfficientFloor_smooth];
  function validateEfficientFloor(value) = 
    //Convert boolean to list value
    let(value = is_bool(value) ? value ? EfficientFloor_on : EfficientFloor_off : value)
    assert(list_contains(EfficientFloor_values, value), typeerror("EfficientFloor", value))
    value;  
FlatBase_off = "off";
FlatBase_gridfinity = "gridfinity";
FlatBase_rounded = "rounded";
FlatBase_values = [FlatBase_off, FlatBase_gridfinity, FlatBase_rounded];
  function validateFlatBase(value) = 
    //Convert boolean to list value
    let(value = is_bool(value) ? value ? FlatBase_gridfinity : FlatBase_off : value)
    assert(list_contains(FlatBase_values, value), typeerror("FlatBase", value))
    value;  
function CupBaseSettings(
    magnetSize = [0,0], 
    magnetEasyRelease = MagnetEasyRelease_auto, 
    centerMagnetSize = [0,0], 
    screwSize = [0,0], 
    holeOverhangRemedy = 2, 
    cornerAttachmentsOnly = true,
    floorThickness = gf_cup_floor_thickness,
    cavityFloorRadius = -1,
    efficientFloor = EfficientFloor_off,
    halfPitch = false,
    flatBase = FlatBase_off,
    spacer = false,
    minimumPrintablePadSize = 0,
    flatBaseRoundedRadius=-1,
    flatBaseRoundedEasyPrint=-1,
    magnetCaptiveHeight = 0,
    alignGrid = ["near", "near"]
    ) = 
  let(
    magnetSize = 
      is_num(magnetSize) 
        ? [magnetSize, gf_magnet_thickness]
        : magnetSize,
    screwSize = 
      is_num(screwSize) 
        ? [gf_cupbase_screw_diameter, screwSize]
        : screwSize,
    efficientFloor = validateEfficientFloor(efficientFloor),
    centerMagnetSize = efficientFloor != EfficientFloor_off ? [0, 0] : centerMagnetSize,
    cavityFloorRadius = efficientFloor != EfficientFloor_off ? 0 : cavityFloorRadius,
    magnetEasyRelease = validateMagnetEasyRelease(magnetEasyRelease, efficientFloor),
    result = [
      magnetSize[0] == 0 || magnetSize[1] == 0 ? [0,0] : magnetSize, 
      validateMagnetEasyRelease(magnetEasyRelease), 
      centerMagnetSize[0] == 0 || centerMagnetSize[1] == 0 ? [0,0] : centerMagnetSize,
      screwSize[0] == 0 || screwSize[1] == 0 ? [0,0] : screwSize, 
      holeOverhangRemedy, 
      cornerAttachmentsOnly,
      floorThickness,
      cavityFloorRadius,
      validateEfficientFloor(efficientFloor),
      halfPitch,
      validateFlatBase(flatBase),
      spacer,
      minimumPrintablePadSize,
      flatBaseRoundedRadius,
      flatBaseRoundedEasyPrint,
      magnetCaptiveHeight,
      alignGrid
      ],
    validatedResult = ValidateCupBaseSettings(result)
  ) validatedResult;
function ValidateCupBaseSettings(settings, num_x, num_y) =
  assert(is_list(settings) && len(settings) == 17, typeerror_list("CupBase Settings", settings, 17))
  assert(is_list(settings[iCupBase_MagnetSize]) && len(settings[iCupBase_MagnetSize])==2, "CupBase Magnet Setting must be a list of length 2")
  assert(is_list(settings[iCupBase_CenterMagnetSize]) && len(settings[iCupBase_CenterMagnetSize])==2, "CenterMagnet Magnet Setting must be a list of length 2")
  assert(is_list(settings[iCupBase_ScrewSize]) && len(settings[iCupBase_ScrewSize])==2, "ScrewSize Magnet Setting must be a list of length 2")
  assert(is_num(settings[iCupBase_HoleOverhangRemedy]), "CupBase HoleOverhangRemedy Settings must be a number")
  assert(is_bool(settings[iCupBase_CornerAttachmentsOnly]), "CupBase CornerAttachmentsOnly Settings must be a boolean")
  assert(is_num(settings[iCupBase_FloorThickness]), "CupBase FloorThickness Settings must be a number")
  assert(is_num(settings[iCupBase_CavityFloorRadius]), "CupBase CavityFloorRadius Settings must be a number")
  assert(is_bool(settings[iCupBase_HalfPitch]), "CupBase HalfPitch Settings must be a boolean")
  assert(is_string(settings[iCupBase_FlatBase]), "CupBase FlatBase Settings must be a string")
  assert(is_bool(settings[iCupBase_Spacer]), "CupBase Spacer Settings must be a boolean")
  assert(is_num(settings[iCupBase_MinimumPrintablePadSize]), "CupBase minimumPrintablePadSize Settings must be a number")
  assert(is_num(settings[iCupBase_MagnetCaptiveHeight]), "CupBase Magnet Captive height setting must a number")
  assert(is_list(settings[iCupBase_AlignGrid]) && len(settings[iCupBase_AlignGrid])==2, "CupBase AlignGrid Setting must be a list of length 2")
  let(
    efficientFloor = validateEfficientFloor(settings[iCupBase_EfficientFloor]),
    magnetEasyRelease = validateMagnetEasyRelease(settings[iCupBase_MagnetEasyRelease], efficientFloor),
    flatBase = validateFlatBase(settings[iCupBase_FlatBase])
  ) [
      settings[iCupBase_MagnetSize],
      magnetEasyRelease,
      settings[iCupBase_CenterMagnetSize],
      settings[iCupBase_ScrewSize],
      settings[iCupBase_HoleOverhangRemedy],
      settings[iCupBase_CornerAttachmentsOnly],
      settings[iCupBase_FloorThickness],
      settings[iCupBase_CavityFloorRadius],
      efficientFloor,
      settings[iCupBase_HalfPitch],
      flatBase,
      settings[iCupBase_Spacer],
      settings[iCupBase_MinimumPrintablePadSize],
      settings[iCupBase_FlatBaseRoundedRadius],
      settings[iCupBase_FlatBaseRoundedEasyPrint],
      settings[iCupBase_MagnetCaptiveHeight],
      settings[iCupBase_AlignGrid]
      ];
//CombinedEnd from path module_gridfinity_cup_base.scad
//Combined from path module_lip.scad







//Lip object configuration
iLipStyle=0;
iLipSideReliefTrigger=1;
iLipTopReliefHeight=2;
iLipTopReliefWidth=3;
iLipNotch=4;
iLipClipPosition=5;
iLipNonBlocking=6;
LipStyle_normal = "normal";
LipStyle_reduced = "reduced";
LipStyle_reduced_double = "reduced_double";
LipStyle_minimum = "minimum";
LipStyle_none = "none";
LipStyle_values = [LipStyle_normal,LipStyle_reduced, LipStyle_reduced_double, LipStyle_minimum,LipStyle_none];
function validateLipStyle(value) = 
  assert(list_contains(LipStyle_values, value), typeerror("LipStyle", value))
  value;
LipClipPosition_disabled = "disabled";
LipClipPosition_center_wall = "center_wall";
LipClipPosition_intersection = "intersection";
LipClipPosition_both = "both";
LipClipPosition_values = [LipClipPosition_disabled,LipClipPosition_center_wall,LipClipPosition_intersection,LipClipPosition_both];
function validateLipClipPosition(value) = 
  assert(list_contains(LipClipPosition_values, value), typeerror("LipClipPosition", value))
  value;
function LipSettings(
  lipStyle = LipStyle_normal, 
  lipSideReliefTrigger = [1,1], 
  lipTopReliefHeight = -1, 
  lipTopReliefWidth = -1, 
  lipNotch = true,
  lipClipPosition = LipClipPosition_disabled,
  lipNonBlocking = false) =  
  let(
    result = [
      lipStyle,
      lipSideReliefTrigger,
      lipTopReliefHeight,
      lipTopReliefWidth,
      lipNotch,
      lipClipPosition,
      lipNonBlocking],
    validatedResult = ValidateLipSettings(result)
  ) validatedResult;
function ValidateLipSettings(settings) =
  assert(is_list(settings), "LipStyle Settings must be a list")
  assert(len(settings)==7, "LipStyle Settings must length 7")
  assert(is_bool(settings[iLipNotch]), "Lip Notch must be a bool")
    [validateLipStyle(settings[iLipStyle]),
      settings[iLipSideReliefTrigger],
      settings[iLipTopReliefHeight],
      settings[iLipTopReliefWidth],
      settings[iLipNotch],
      validateLipClipPosition(settings[iLipClipPosition]),
      settings[iLipNonBlocking]];
module cupLip(
  num_x = 2, 
  num_y = 3, 
  lipStyle = LipStyle_normal, 
  wall_thickness = 1.2,
  lip_notches = true,
  lip_top_relief_height = -1,
  lip_top_relief_width = -1,
  lip_clip_position = LipClipPosition_disabled,
  lip_non_blocking = false,
  align_grid = [ "near", "near"]){
  assert(is_num(num_x) && num_x > 0, "num_x must be a number greater than 0");
  assert(is_num(num_y) && num_y > 0, "num_y must be a number greater than 0");
  assert(is_string(lipStyle));
  assert(is_num(wall_thickness) && wall_thickness > 0, "wall_thickness must be a number greater than 0");
  assert(is_num(lip_top_relief_height));
  assert(is_num(lip_top_relief_width));
  assert(is_bool(lip_notches));
  assert(is_string(lip_clip_position));
  assert(is_bool(lip_non_blocking));
  connectorsEnabled = lip_clip_position != LipClipPosition_disabled;
  $allowConnectors = connectorsEnabled ? [1,1,1,1] : [0,0,0,0];
  $frameBaseHeight = 0; //$num_z * env_pitch().z;
  //Difference between the wall and support thickness
  lipSupportThickness = (lipStyle == "minimum" || lipStyle == "none") ? 0
    : lipStyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : lipStyle == "reduced_double" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;
  floorht=0;
  // should be 17 for default settings
  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  innerLipRadius = env_corner_radius()-gf_lip_lower_taper_height-gf_lip_upper_taper_height; //1.15
  innerWallRadius = env_corner_radius()-wall_thickness;
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // around the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  lipHeight = 3.75;
  outer_size = [env_pitch().x - env_clearance().x, env_pitch().y - env_clearance().y];  // typically 41.5
  block_corner_position = [outer_size.x/2 - env_corner_radius(), outer_size.y/2 - env_corner_radius()];  // need not match center of pad corners
  coloredLipHeight=min(2,lipHeight);
  if(lipStyle != "none")
    color(env_colour(color_topcavity, isLip = true))
    tz(-fudgeFactor*2)
    difference() {
      //Lip outer shape
      tz(fudgeFactor*2)
      hull() 
        cornercopy(block_corner_position, num_x, num_y) 
        cylinder(r=env_corner_radius(), h=lipHeight+fudgeFactor);
      cupLip_cavity(
        num_x = num_x, 
        num_y = num_y, 
        lipStyle = lipStyle, 
        wall_thickness = wall_thickness,
        lip_notches = lip_notches,
        lip_top_relief_height = lip_top_relief_height,
        lip_top_relief_width = lip_top_relief_width,
        lip_clip_position = lip_clip_position,
        lip_non_blocking = lip_non_blocking,
        align_grid = align_grid);
    }
}
module cupLip_cavity(
  num_x = 2, 
  num_y = 3, 
  lipStyle = LipStyle_normal, 
  wall_thickness = 1.2,
  lip_notches = true,
  lip_top_relief_height = -1,
  lip_top_relief_width = -1,
  lip_clip_position = LipClipPosition_disabled,
  lip_non_blocking = false,
  align_grid = [ "near", "near"]){
  assert(is_num(num_x) && num_x > 0, "num_x must be a number greater than 0");
  assert(is_num(num_y) && num_y > 0, "num_y must be a number greater than 0");
  assert(is_string(lipStyle));
  assert(is_num(wall_thickness) && wall_thickness > 0, "wall_thickness must be a number greater than 0");
  assert(is_num(lip_top_relief_height));
  assert(is_num(lip_top_relief_width));
  assert(is_bool(lip_notches));
  assert(is_string(lip_clip_position));
  assert(is_bool(lip_non_blocking));
  connectorsEnabled = lip_clip_position != LipClipPosition_disabled;
  $allowConnectors = connectorsEnabled ? [1,1,1,1] : [0,0,0,0];
  $frameBaseHeight = 0; //$num_z * env_pitch().z;
  //Difference between the wall and support thickness
  lipSupportThickness = (lipStyle == "minimum" || lipStyle == "none") ? 0
    : lipStyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : lipStyle == "reduced_double" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;
  floorht=0;
  // should be 17 for default settings
  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  innerLipRadius = env_corner_radius()-gf_lip_lower_taper_height-gf_lip_upper_taper_height; //1.15
  innerWallRadius = env_corner_radius()-wall_thickness;
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // around the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  lipHeight = 3.75;
  outer_size = [env_pitch().x - env_clearance().x, env_pitch().y - env_clearance().y];  // typically 41.5
  block_corner_position = [outer_size.x/2 - env_corner_radius(), outer_size.y/2 - env_corner_radius()];  // need not match center of pad corners
  coloredLipHeight=min(2,lipHeight);
  pitch=env_pitch();
  // remove top so XxY can fit on top
  //pad_oversize(num_x, num_y, 1);
  union(){
    //Top cavity, with lip relief
    frame_cavity(
      num_x = lip_non_blocking ? ceil(num_x) : num_x, 
      num_y = lip_non_blocking ? ceil(num_y) : num_y, 
      position_fill_grid_x = align_grid.x,
      position_fill_grid_y = align_grid.y,
      render_top = lip_notches,
      render_bottom = false,
      frameLipHeight = 4,
      cornerRadius = env_corner_radius(),
      reducedWallHeight = lip_top_relief_height,
      reducedWallWidth = lip_top_relief_width,
      reducedWallOuterEdgesOnly=true){
        echo("donothign");
        frame_connectors(
          width = num_x, 
          depth = num_y,
          connectorPosition = lip_clip_position,
          connectorClipEnabled = connectorsEnabled);
      };
    //lower cavity
    frame_cavity(
      num_x = 1, 
      num_y = 1, 
      position_fill_grid_x = "far",
      position_fill_grid_y = "far",
      render_top = !lip_notches,
      render_bottom = true,
      frameLipHeight = 4,
      cornerRadius = env_corner_radius(),
      reducedWallHeight = -1, 
      reducedWallWidth = -1,
      $pitch=[
        pitch.x*(lip_non_blocking ? ceil(num_x) : num_x),
        pitch.y*(lip_non_blocking ? ceil(num_y) : num_y),
        pitch.z]);
  }
  if (lipStyle == "minimum" || lipStyle == "none") {
    hull() cornercopy(inner_corner_center, num_x, num_y)
      tz(-fudgeFactor) 
      cylinder(r=innerWallRadius, h=gf_Lip_Height);   // remove entire lip
  } 
  else if (lipStyle == "reduced" || lipStyle == "reduced_double") {
    lowerTaperZ = gf_lip_lower_taper_height;
    hull() cornercopy(inner_corner_center, num_x, num_y)
    union(){
      tz(lowerTaperZ) 
      cylinder(
        r1=innerWallRadius, 
        r2=env_corner_radius()-gf_lip_upper_taper_height, 
        h=lipSupportThickness);
      tz(-fudgeFactor) 
      cylinder(
        r=innerWallRadius, 
        h=lowerTaperZ+fudgeFactor*2);
    }
  } 
  else { // normal
    lowerTaperZ = -gf_lip_height-lipSupportThickness;
    if(lowerTaperZ <= floorht){
      hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(floorht) 
        cylinder(r=innerLipRadius, h=-floorht+fudgeFactor*2); // lip
    } else {
      hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(-gf_lip_height-fudgeFactor) 
        cylinder(r=innerLipRadius, h=gf_lip_height+fudgeFactor*2); // lip
      hull() cornercopy(inner_corner_center, num_x, num_y)
        tz(-gf_lip_height-lipSupportThickness-fudgeFactor) 
        cylinder(
          r1=innerWallRadius,
          r2=innerLipRadius, h=q+fudgeFactor);   // ... to top of thin wall ...
    }
  }
}
//CombinedEnd from path module_lip.scad
//Combined from path module_gridfinity_frame_connectors.scad






// include instead of use, so we get the pitch
iAllowConnectorsFront = 0;
iAllowConnectorsBack = 1;
iAllowConnectorsLeft = 2;
iAllowConnectorsRight = 3;
show_frame_connector_demo = false;
if(show_frame_connector_demo){
  $fn = 64;
  translate([0,0,0]) {
    ClippedWall(fullIntersection = true);
    translate([15,0,0])
    ClipConnector(fullIntersection=true);
    translate([30,0,0])
    ClipCutter(fullIntersection=true);
   }
  translate([0,15,0]) {
    ClippedWall(straightIntersection = true);
    translate([15,0,0])
    ClipConnector(straightIntersection = true);
    translate([30,0,0])
    ClipCutter(straightIntersection = true);
   }
  translate([0,30,0]) {
    ClippedWall(cornerIntersection = true);
    //translate([15,0,0])
    //ClipConnector(cornerIntersection = true);
    translate([30,0,0])
    ClipCutter(cornerIntersection = true);
  }
  translate([0,45,0]) {
    ClippedWall(straightWall = true);
    translate([15,0,0])
    ClipConnector(straightWall = true);
    translate([30,0,0])
    ClipCutter(straightWall = true);
   }
}
module frame_connectors(
  width = 1, 
  depth = 1,
  connectorPosition = "both",
  connectorClipEnabled = false,
  connectorClipSize = 10,
  connectorClipTolerance = 0.1,
  connectorButterflyEnabled = false,
  connectorButterflySize = [5,3,2],
  connectorButterflyRadius = 0.5,
  connectorButterflyTolerance = 0.1,
  connectorFilamentEnabled = false,
  connectorFilamentLength = 10,
  connectorFilamentDiameter = 2) {
  if(connectorButterflyEnabled || connectorFilamentEnabled || connectorClipEnabled){
    union(){
      if(env_help_enabled("debug")) echo("baseplate", gci=$gci, gc_size=$gc_size, gc_is_corner=$gc_is_corner, gc_position=$gc_position, width=width, depth=depth);
      if(connectorPosition == "center_wall" || connectorPosition == "both")
      PositionCellCenterConnector(
        left=$gci.x==0&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsLeft],
        right=$gci.x>=$gc_count.x-1&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsRight],
        front=$gci.y==0&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsFront],
        back=$gci.y>=$gc_count.y-1&&$gc_size.x==1&&$gc_size.y==1&& $allowConnectors[iAllowConnectorsBack]) {
          if($preview)
            *rotate([0,0,90])
            cylinder_printable(h=10,r=1);
          if(connectorClipEnabled)
            ClipCutter(size=connectorClipSize, 
              height= 0.8, //height of bevel1_top
              frameHeight = 4,
              clearance = connectorClipTolerance,
              cornerRadius = env_corner_radius(),
              straightWall=true);
          if(connectorButterflyEnabled)
            translate([0,0,-$frameBaseHeight])
            rotate([0,0,90])
            ButterFlyConnector(
              size=connectorButterflySize,
              r=connectorButterflyRadius,
              clearance = connectorButterflyTolerance,
              taper=false,half=false);
          if(connectorFilamentEnabled)
            translate([0,0,-$frameBaseHeight/2])
            FilamentCutter(
              l=connectorFilamentLength,
              d=connectorFilamentDiameter);
          }
        if(connectorPosition == "intersection" || connectorPosition == "both")
        PositionCellCornerConnector(
        left=$gci.x==0&&$gc_size.x==1&&$gc_size.y==1,
        right=$gci.x>=$gc_count.x-1 && $gc_size.x==1&&$gc_size.y==1,
        front=$gci.y==0&&$gc_size.x==1&&$gc_size.y==1,
        back=$gci.y>=$gc_count.y-1&&$gc_size.x==1&&$gc_size.y==1) {
          if($preview)
            *rotate([0,0,90])
            cylinder_printable(h=$corner ? 20 : 15,r=2);
          if(connectorClipEnabled)
            rotate([0,0,270])
            ClipCutter(size=connectorClipSize, 
              height= 0.8, //height of bevel1_top
              frameHeight = 4,
              clearance = connectorButterflyTolerance,
              cornerRadius = env_corner_radius(),
              straightIntersection = !$corner,
              cornerIntersection = $corner);
          if(connectorButterflyEnabled && !$corner)
            translate([0,0,-$frameBaseHeight])
            rotate([0,0,90])
            ButterFlyConnector(
              size=connectorButterflySize,
              r=connectorButterflyRadius,
              clearance = connectorButterflyTolerance,
              taper=false,half=false);
          if(connectorFilamentEnabled && !$corner)
            translate([0,0,-$frameBaseHeight/2])
            FilamentCutter(
              l=connectorFilamentLength,
              d=connectorFilamentDiameter);
        }
    }
  }
}
module PositionCellCenterConnector(left, right,front,back){
    if(left)
      translate([0,env_pitch().y/2,0])
      children();
    if(right)
      translate([env_pitch().x,env_pitch().y/2,0])
      rotate([0,0,180])
      children();
    if(front)
      translate([env_pitch().x/2,0,0])
      rotate([0,0,90])
      children();
    if(back)
      translate([env_pitch().x/2,env_pitch().y,0])
      rotate([0,0,270])
      children();
}
module PositionCellCornerConnector(left, right, front, back){
  if(left || right || front || back)
  {
    if(left && front) {
      if($allowConnectors[iAllowConnectorsLeft] && $allowConnectors[iAllowConnectorsFront])
        let($corner = true)
        rotate([0,0,90])
        children();
      let($corner = false){
        if($allowConnectors[iAllowConnectorsFront])
        translate([env_pitch().x,0,0])
        rotate([0,0,90])
        children();
        if($allowConnectors[iAllowConnectorsLeft])
        translate([0,env_pitch().y,0])
        children();
      }
    }
    if(left && back) {
      if($allowConnectors[iAllowConnectorsLeft] && $allowConnectors[iAllowConnectorsBack])
        let($corner = true)
        translate([0,env_pitch().y,0])
        children();
      let($corner = false) {
        if($allowConnectors[iAllowConnectorsLeft])
        children();
        if($allowConnectors[iAllowConnectorsBack])
        translate([env_pitch().x,env_pitch().y,0])
        rotate([0,0,270])
        children();
      }
    }
    if(right && front){
      if($allowConnectors[iAllowConnectorsRight] && $allowConnectors[iAllowConnectorsFront])
        let($corner = true)
        translate([env_pitch().x,0,0])
        rotate([0,0,180])
        children();
      let($corner = false) {
        if($allowConnectors[iAllowConnectorsFront])
        rotate([0,0,90])
        children();
        if($allowConnectors[iAllowConnectorsRight])
        translate([env_pitch().x,env_pitch().y,0])
        rotate([0,0,180])
        children();
      }
    }
    if(right && back){
      if($allowConnectors[iAllowConnectorsRight] && $allowConnectors[iAllowConnectorsBack])
        let($corner = true)
        translate([env_pitch().x,env_pitch().y,0])
        rotate([0,0,270])
        children();
      let($corner = false) {
        if($allowConnectors[iAllowConnectorsRight])
        translate([env_pitch().x,0,0])
        rotate([0,0,180])
        children();
        if($allowConnectors[iAllowConnectorsBack])
        translate([0,env_pitch().y,0])
        rotate([0,0,270])
        children();
      }
    }
    if(left && !back && !front && !front && $gci.y<=$gc_count.y-3 && $allowConnectors[iAllowConnectorsLeft]){
      $corner = false;
      translate([0,env_pitch().y,0])
      children();
    }
    if(front && !left && !right && $gci.x<=$gc_count.x-3 && $allowConnectors[iAllowConnectorsFront]){
      $corner = false;
      translate([env_pitch().x,0,0])
      rotate([0,0,90])
      children();
    }
    if(right && !back && !front && $gci.y<=$gc_count.y-3 && $allowConnectors[iAllowConnectorsRight]){
      $corner = false;
      translate([env_pitch().x,env_pitch().y,0])
      rotate([0,0,180])
      children();
    }
    if(back && !left && !right && $gci.x<=$gc_count.x-3 && $allowConnectors[iAllowConnectorsBack]){
      $corner = false;
      translate([env_pitch().x,env_pitch().y,0])
      rotate([0,0,270])
      children();
    }
  }
}
module FilamentCutter(
    l = 5, 
    d = 1.75){
  translate([-fudgeFactor, 0,0])
  rotate([90,0,90])
  cylinder_printable(h=l,d=d);
}
module cylinder_printable(h=10,r=1,d,center=false){
  r = is_num(d) ? d/2 : r;
  d=2*r;
  flat_top_width = d/2.5;
  flat_top_height = d/2+0.5;
  translate(center ? [0,0,0] : [0,0,h/2])
  hull(){
    //Printable Cylinder
    cylinder(h=h,d=d, center=true);
    translate([-flat_top_width/2,d/2-flat_top_height,-h/2])
      cube([flat_top_width,flat_top_height,h]); 
  }
}
//What is to be removed from the baseplate, to make room for the corner clip
module ClipCutter(
  size=10, 
  height= 0.8, //height of bevel1_top
  frameHeight = 4,
  clippedWallThickness = 2,
  clippedWallHeight = 1.6,
  clearance = 0.1,
  cornerRadius = gf_cup_corner_radius,
  straightWall = false,
  straightIntersection = false,
  cornerIntersection = false,
  fullIntersection = false){
  height = height-clearance/2;
  translate([0,0,height+fudgeFactor])
  difference(){
    if(straightIntersection) {
      translate([-size/2-clearance,-fudgeFactor,0])
        cube(size=[size+clearance*2,size/2+clearance+fudgeFactor,frameHeight-height+fudgeFactor]);
    } else if(cornerIntersection) {
      translate([-fudgeFactor,-fudgeFactor,0])
        cube(size=[size/2+fudgeFactor+clearance,size/2+clearance+fudgeFactor,frameHeight-height+fudgeFactor]);
    } else {
      translate([-size/2-clearance,-size/2-clearance,0])
        cube(size=[size+clearance*2,size+clearance*2,frameHeight-height+fudgeFactor]);
    }
    //clipped inner wall
    translate([0,0,-fudgeFactor])
    ClippedWall(
      clipSize=size+clearance*2, 
      cornerRadius = cornerRadius,
      clippedWallThickness = clippedWallThickness,
      clippedWallHeight = clippedWallHeight-clearance,
      straightWall = straightWall,
      straightIntersection = straightIntersection,
      cornerIntersection = cornerIntersection,
      fullIntersection = fullIntersection);
  }
}
module ClipConnector(
  size=10, 
  height= 0.8, //height of bevel1_top
  frameHeight = 4,
  clippedWallThickness = 2,
  clippedWallHeight = 1.6,
  clearance = 0.1,
  cornerRadius = gf_cup_corner_radius,
  straightWall = false,
  straightIntersection = false,
  fullIntersection = false){
  render()
  difference(){
    translate([
        -size/2,
        straightIntersection ? 0 : -size/2,
        0])
      cube(size=[size,
          straightIntersection ? size/2 : size,
          frameHeight-height]);
    if(!straightWall) {
      translate([-env_pitch().x,-env_pitch().y,-height])
        frame_cavity(
          num_x=2, 
          num_y=2);
    } else {
      translate([-env_pitch().x,-env_pitch().y/2,-height])
        frame_cavity(
          num_x=2, 
          num_y=1);
    }
    //clipped inner wall
    translate([0,0,-fudgeFactor])
    ClippedWall(
      clipSize=size, 
      cornerRadius = cornerRadius,
      clippedWallThickness = clippedWallThickness+clearance,
      clippedWallHeight = clippedWallHeight+clearance,
      straightWall = straightWall,
      straightIntersection = straightIntersection,
      fullIntersection = fullIntersection);
  }
}
//The wall that is ls left once the clip shape is removed
module ClippedWall(
  clipSize=10, 
  cornerRadius = gf_cup_corner_radius,
  clippedWallHeight = 2,
  clippedWallThickness = 1,
  frameWallHeight = 1.6,
  straightWall = false,
  straightIntersection = false,
  cornerIntersection = false,
  fullIntersection = false){
  corners = straightWall ? 0 
    : cornerIntersection ? 1 
    : straightIntersection ? 2 
    : 4;
    height = clippedWallHeight+fudgeFactor;
    clipRadius = cornerRadius - clippedWallThickness/2;
    xlength = straightWall ? 0
      : cornerIntersection ? clipSize/2+fudgeFactor
      : clipSize+fudgeFactor*2;
    ylength = cornerIntersection  || straightIntersection? clipSize/2+fudgeFactor
      : clipSize+fudgeFactor*2;
    union(){
      rotate([0,0,180])
      translate([-clippedWallThickness/2,-clipSize/2-fudgeFactor,0])
        cube(size=[clippedWallThickness,ylength,height]);
      rotate([0,0,180])
      translate([-clipSize/2-fudgeFactor,-clippedWallThickness/2,0])
        cube(size=[xlength,clippedWallThickness,height]);
    }
    if(corners > 0)
    difference(){
      if(cornerIntersection){
        translate([-(+clippedWallThickness)/2,-(clippedWallThickness)/2,0])
          cube(size=[clipRadius+clippedWallThickness,clipRadius+clippedWallThickness,height]);
      } else if (straightIntersection){
        translate([-(clipRadius*2+clippedWallThickness)/2,-(clippedWallThickness)/2,0])
          cube(size=[clipRadius*2+clippedWallThickness,clipRadius+clippedWallThickness,height]);
      } else {
        translate([-(clipRadius*2+clippedWallThickness)/2,-(clipRadius*2+clippedWallThickness)/2,0])
          cube(size=[clipRadius*2+clippedWallThickness,clipRadius*2+clippedWallThickness,height]);
      }
      for(i=[0:1:corners-1]){
        rotate([0,0,i*90])
        translate([clippedWallThickness/2+clipRadius,clippedWallThickness/2+clipRadius,-fudgeFactor])
          cylinder(r=clipRadius,h=height+fudgeFactor*2);
      }
  }
}
module ButterFlyConnector(
  size,
  r,
  clearance = 0,
  taper=false,
  half=false)
  {
  h = taper ? size.y/2+size.z : size.z;
  //render()
  intersection(){
    positions = [
      [-(size.x/2-r), size.y/2-r, h/2],
      [size.x/2-r, size.y/2-r, h/2],
      [0, -(size.y/2-r), h/2]];
    union()
    for(ri = [0:half?0:1]){
      mirror([0,1,0]*ri)
      hull(){
        for(pi = [0:len(positions)-1]){
          translate(positions[pi])
            cylinder(h=h,r=r,center=true);
        }
      }
    }
    if(taper)
    rotate([0,90,0])
    cylinder(h=size.x,r=size.y/2+size.z,$fn=4,center=true);
  }
}
//CombinedEnd from path module_gridfinity_frame_connectors.scad
//Combined from path module_magnet.scad




MagnetEasyRelease_off = "off";
MagnetEasyRelease_auto = "auto";
MagnetEasyRelease_inner = "inner"; 
MagnetEasyRelease_outer = "outer"; 
MagnetEasyRelease_values = [MagnetEasyRelease_off, MagnetEasyRelease_auto, MagnetEasyRelease_inner, MagnetEasyRelease_outer];
  function validateMagnetEasyRelease(value, efficientFloorValue) = 
  //Convert boolean to list value
  let(value = is_bool(value) ? value ? MagnetEasyRelease_auto : MagnetEasyRelease_off : value,
      autoValue = value == MagnetEasyRelease_auto 
        ? efficientFloorValue == EfficientFloor_off ? MagnetEasyRelease_inner : MagnetEasyRelease_outer 
        : value) 
  assert(list_contains(MagnetEasyRelease_values, autoValue), typeerror("MagnetEasyRelease", autoValue))
  autoValue;
module MagnetAndScrewRecess(
  magnetDiameter = 10,
  magnetThickness = 2,
  screwDiameter = 2,
  screwDepth = 6,
  overhangFixLayers = 3,
  overhangFixDepth = 0.2,
  easyMagnetRelease = true,
  magnetCaptiveHeight = 0){
     fudgeFactor = 0.01;
    union(){
      SequentialBridgingDoubleHole(
        outerHoleRadius = magnetDiameter/2,
        outerHoleDepth = magnetThickness,
        innerHoleRadius = screwDiameter/2,
        innerHoleDepth = screwDepth > 0 ? screwDepth+fudgeFactor : 0,
        overhangBridgeCount = overhangFixLayers,
        overhangBridgeThickness = overhangFixDepth,
        magnetCaptiveHeight = magnetCaptiveHeight);
      magnet_easy_release(
        magnetDiameter = magnetDiameter,
        magnetThickness = magnetThickness,
        easyMagnetRelease = easyMagnetRelease
      );
  }
}
module magnet_easy_release(
  magnetDiameter = 10,
  magnetThickness = 2,
  easyMagnetRelease = true,
  center = false
){
  fudgeFactor = 0.01;
  releaseWidth = 1.3;
  releaseLength = 1.5;
  outerPlusBridgeHeight = magnetThickness;
  translate(center ? [0,0,-outerPlusBridgeHeight/2] : [0,0,0] )
  union(){
    cylinder(r=magnetDiameter/2, h=outerPlusBridgeHeight);
    if(easyMagnetRelease && magnetDiameter > 0)
    difference(){
      hull(){
        translate([0,-releaseWidth/2,0])  
          cube([magnetDiameter/2+releaseLength,releaseWidth,magnetThickness]);
        translate([magnetDiameter/2+releaseLength,0,0])  
          cylinder(d=releaseWidth, h=magnetThickness);
      }
      champherRadius = min(magnetThickness, releaseLength+releaseWidth/2);
      totalReleaseLength = magnetDiameter/2+releaseLength+releaseWidth/2;
      translate([totalReleaseLength,-releaseWidth/2-fudgeFactor,magnetThickness])
      rotate([270,0,90])
      roundedCorner(
        radius = champherRadius, 
        length = releaseWidth+2*fudgeFactor, 
        height = totalReleaseLength);
    }
  }
}
//CombinedEnd from path module_magnet.scad
//Combined from path module_gridfinity_cup.scad





















// X dimension. grid units (multiples of 42mm) or mm.
default_width = [2, 0]; //0.1
// Y dimension. grid units (multiples of 42mm) or mm.
default_depth = [1, 0]; //0.1
// Z dimension excluding. grid units (multiples of 7mm) or mm.
default_height = [3, 0]; //0.1
default_position = "default"; //["default","center","zero"]
default_filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]
//assign colours to the bin, will may 
default_set_colour = "preview"; //[disabled, preview, lip]
// Thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
default_wall_thickness = 0;// 0.01
// Set magnet diameter and depth to 0 to print without magnet holes
// (Zack's design uses magnet diameter of 6.5)
//under size the bin top by this amount to allow for better stacking
default_headroom = 0.8; // 0.1
/* Cup Lip */
// Style of the cup lip
default_lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// Below this the inside of the lip will be reduced for easier access.
default_lip_side_relief_trigger = [1,1]; //0.1
// Create a relief in the lip
default_lip_top_relief_height = -1; // 0.1
// add a notch to the lip to prevent sliding.
default_lip_top_notches  = 0; // 0.1
/* Label */
// Include overhang for labeling
default_label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// Include overhang for labeling (and specify left/right/center justification)
default_label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
default_label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropriate. Width, depth, height, radius
default_label_relief = [0,0,0,0.6]; // 0.1
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
default_label_walls=[0,1,0,0];  //[0:1:1]
/* Sliding Lid */
default_sliding_lid_enabled = false;
// 0 = wall thickness *2
default_sliding_lid_thickness = 0; //0.1
// 0 = wall_thickness/2
default_sliding_min_wallThickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
default_sliding_min_support = 0;//0.1
default_sliding_clearance = 0.1;//0.1
default_sliding_lid_lip_enabled = false;
/* Finger Slide */
// Include larger corner fillet
default_fingerslide = "none"; //[none, rounded, chamfered]
// radius of the corner fillet
default_fingerslide_radius = -3;
// wall to enable on, front, back, left, right.  0: disabled; 1: enabled;
default_fingerslide_walls=[1,0,0,0]; //[0:1:1]
default_fingerslide_lip_aligned = true;
/* Subdivisions */
// X dimension subdivisions
default_chamber_wall_thickness = 1.2;//0.1
//Reduce the wall height by this amount
default_chamber_wall_headroom = 0;//0.1
default_vertical_chambers = 1;
default_vertical_separator_bend_position = 0;//0.1
default_vertical_separator_bend_angle = 45;//0.1
default_vertical_separator_bend_separation = 0;//0.1
default_vertical_separator_cut_depth = 0;//0.1
default_horizontal_chambers = 1;
default_horizontal_separator_bend_position = 0; //0.1
default_horizontal_separator_bend_angle = 45; //0.1
default_horizontal_separator_bend_separation = 0; //0.1
default_horizontal_separator_cut_depth = 0;//0.1
// Enable irregular subdivisions
default_vertical_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
default_vertical_separator_config = "10.5|21|42|50|60";
// Enable irregular subdivisions
default_horizontal_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
default_horizontal_separator_config = "10.5|21|42|50|60";
/* Base */
//size of magnet, diameter and height. Zack's original used 6.5 and 2.4 
default_magnet_size = [6.5, 2.4];  // .1
//create relief for magnet removal
default_magnet_easy_release = "auto";//["off","auto","inner","outer"] 
// move magnet inside part for print-in magnets 
default_magnet_captive_height = 0;
//size of screw, diameter and height. Zack's original used 3 and 6
default_screw_size = [3, 6]; // .1
//size of center magnet, diameter and height. 
default_center_magnet_size = [0,0];
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
default_floor_thickness = 1.2;
default_cavity_floor_radius = -1;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
default_hole_overhang_remedy = 2;
// Save material with thinner floor
default_efficient_floor = "off";//["off","on","rounded","smooth"] 
// Remove floor to create a spacer
default_spacer = false;
// Half-pitch base pads for offset stacking
default_half_pitch = false;
// Limit attachments (magnets and screws) to box corners for faster printing.
default_box_corner_attachments_only = true;
// Removes the base grid from inside the shape
default_flat_base = false;
/* Tapered Corner */
default_tapered_corner = "none"; //[none, rounded, chamfered]
default_tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
default_tapered_setback = -1;//gf_cup_corner_radius/2;
/* Wall Cutout */
default_wallcutout_vertical ="disabled"; //[disabled, enabled, wallsonly, frontonly, backonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
default_wallcutout_vertical_position=-2;  //0.1
//default will be binwidth/2
default_wallcutout_vertical_width=0;
default_wallcutout_vertical_angle=70;
//default will be binHeight
default_wallcutout_vertical_height=0;
default_wallcutout_vertical_corner_radius=5;
default_wallcutout_horizontal ="disabled"; //[disabled, enabled, wallsonly, leftonly, rightonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
default_wallcutout_horizontal_position=-2;  //0.1
//default will be binwidth/2
default_wallcutout_horizontal_width=0;
default_wallcutout_horizontal_angle=70;
//default will be binHeight
default_wallcutout_horizontal_height=0;
default_wallcutout_horizontal_corner_radius=5;
/* Wall Pattern */
default_wallpattern_enabled=false; 
default_wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
default_wallpattern_rotate_grid = false;
default_wallpattern_dividers_enabled ="disabled"; //["disabled", "horizontal", "vertical", "both"] 
default_wallpattern_fill = "none"; //["none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"]
default_wallpattern_walls=[1,0,0,0];  //[0:1:1]
default_wallpattern_hole_sides = 6;
default_wallpattern_cell_size = [10,10]; //0.1
default_wallpattern_strength = 2; //0.1
default_wallpattern_hole_radius = 0.5;
default_wallpattern_border = 0;
default_wallpattern_depth = 0;
default_wallpattern_pattern_grid_chamfer = 0; //0.1
default_wallpattern_pattern_voronoi_noise = 0.75; //0.01
default_wallpattern_pattern_brick_weight = 5;
default_wallpattern_pattern_quality = 0;
/* Extendable */
default_extension_x_enabled = "disabled"; //[disabled, front, back]
default_extension_x_position = 0.5; 
default_extension_y_enabled = "disabled"; //[disabled, front, back]
default_extension_y_position = 0.5; 
default_extension_tabs_enabled = true;
//Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
default_extension_tab_size= [10,0,0,0];
/* Bottom Text */
// Add bin size to bin bottom
default_text_1 = false;
// Size of text, in mm
default_text_size = 0; // 0.1
// Depth of text, in mm
default_text_depth = 0.3; // 0.01
// Offset of text , in mm
default_text_offset = [0, 0]; // 0.1
// Font to use
default_text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// Add free-form text line to bin bottom (printing date, serial, etc)
default_text_2 = false;
// Actual text to add
default_text_2_text = "Gridfinity";
module end_of_customizer_opts() {}
/*
//[debug] 
default_cutx = 0;//0.01
default_cuty = 0;//0.01
default_help = "info"; //["off","info","debug","trace"]
  width = default_width,
  depth = default_depth,
  height = default_height,
*/
// It's recommended that all parameters other than x, y, z size should be specified by keyword 
// and not by position.  The number of parameters makes positional parameters error prone, and
// additional parameters may be added over time and break things.
// separator positions are defined in units from the left side
module gridfinity_cup(
  width,
  depth,
  height,
  filled_in=default_filled_in,
  wall_thickness=default_wall_thickness,
  label_settings=LabelSettings(
    labelStyle=default_label_style, 
    labelPosition=default_label_position, 
    labelSize=default_label_size,
    labelRelief=default_label_relief,
    labelWalls=default_label_walls),
  finger_slide_settings = FingerSlideSettings(
    type=default_fingerslide,
    radius=default_fingerslide_radius,
    walls=default_fingerslide_walls,
    lip_aligned=default_fingerslide_lip_aligned),
  cupBase_settings = CupBaseSettings(
    magnetSize = default_magnet_size, 
    magnetEasyRelease = default_magnet_easy_release, 
    magnetCaptiveHeight = default_magnet_captive_height,
    centerMagnetSize = default_center_magnet_size, 
    screwSize = default_screw_size, 
    holeOverhangRemedy = default_hole_overhang_remedy, 
    cornerAttachmentsOnly = default_box_corner_attachments_only,
    floorThickness = default_floor_thickness,
    cavityFloorRadius = default_cavity_floor_radius,
    efficientFloor=default_efficient_floor,
    halfPitch=default_half_pitch,
    flatBase=default_flat_base,
    spacer=default_spacer),
  vertical_chambers = ChamberSettings(
    chambers_count = default_vertical_chambers,
    separator_bend_position = default_vertical_separator_bend_position,
    separator_bend_angle = default_vertical_separator_bend_angle,
    separator_bend_separation = default_vertical_separator_bend_separation,
    separator_cut_depth = default_vertical_separator_cut_depth,
    irregular_subdivisions = default_vertical_irregular_subdivisions,
    separator_config = default_vertical_separator_config),
  horizontal_chambers = ChamberSettings(
    chambers_count = default_horizontal_chambers,
    separator_bend_position = default_horizontal_separator_bend_position,
    separator_bend_angle = default_horizontal_separator_bend_angle,
    separator_bend_separation = default_horizontal_separator_bend_separation,
    separator_cut_depth = default_horizontal_separator_cut_depth,
    irregular_subdivisions = default_horizontal_irregular_subdivisions,
    separator_config = default_horizontal_separator_config),
  lip_settings = LipSettings(
    lipStyle=default_lip_style, 
    lipSideReliefTrigger=default_lip_side_relief_trigger, 
    lipTopReliefHeight=default_lip_top_relief_height, 
    lipNotch=default_lip_top_notches),
  headroom=default_headroom,
  tapered_corner = default_tapered_corner,
  tapered_corner_size = default_tapered_corner_size,
  tapered_setback = default_tapered_setback,
  wallpattern_walls=default_wallpattern_walls, 
  wallpattern_dividers_enabled = default_wallpattern_dividers_enabled,
  wall_pattern_settings  = PatternSettings(
    patternEnabled = default_wallpattern_enabled, 
    patternStyle = default_wallpattern_style, 
    patternRotate = default_wallpattern_rotate_grid,
    patternFill = default_wallpattern_fill,
    patternBorder = default_wallpattern_border, 
    patternDepth = default_wallpattern_depth,
    patternCellSize = default_wallpattern_cell_size, 
    patternHoleSides = default_wallpattern_hole_sides,
    patternStrength = default_wallpattern_strength, 
    patternHoleRadius = default_wallpattern_hole_radius,
    patternGridChamfer = default_wallpattern_pattern_grid_chamfer,
    patternVoronoiNoise = default_wallpattern_pattern_voronoi_noise,
    patternBrickWeight = default_wallpattern_pattern_brick_weight,
    patternFs = default_wallpattern_pattern_quality), 
  floor_pattern_settings = PatternSettings(
    patternEnabled = default_wallpattern_enabled, 
    patternStyle = default_wallpattern_style, 
    patternRotate = default_wallpattern_rotate_grid,
    patternFill = default_wallpattern_fill,
    patternBorder = default_wallpattern_border, 
    patternDepth = default_wallpattern_depth,
    patternCellSize = default_wallpattern_cell_size, 
    patternHoleSides = default_wallpattern_hole_sides,
    patternStrength = default_wallpattern_strength, 
    patternHoleRadius = default_wallpattern_hole_radius,
    patternGridChamfer = default_wallpattern_pattern_grid_chamfer,
    patternVoronoiNoise = default_wallpattern_pattern_voronoi_noise,
    patternBrickWeight = default_wallpattern_pattern_brick_weight,
    patternFs = default_wallpattern_pattern_quality), 
  wallcutout_vertical_settings=WallCutoutSettings(
    type = default_wallcutout_vertical, 
    position = default_wallcutout_vertical_position, 
    width = default_wallcutout_vertical_width,
    angle = default_wallcutout_vertical_angle,
    height = default_wallcutout_vertical_height, 
    corner_radius = default_wallcutout_vertical_corner_radius),
  wallcutout_horizontal_settings=WallCutoutSettings(
    type = default_wallcutout_horizontal, 
    position = default_wallcutout_horizontal_position, 
    width = default_wallcutout_horizontal_width,
    angle = default_wallcutout_horizontal_angle,
    height = default_wallcutout_horizontal_height, 
    corner_radius = default_wallcutout_horizontal_corner_radius),
  extendable_Settings = ExtendableSettings(
    extendablexEnabled = default_extension_x_enabled, 
    extendablexPosition = default_extension_x_position, 
    extendableyEnabled = default_extension_y_enabled, 
    extendableyPosition = default_extension_y_position, 
    extendableTabsEnabled = default_extension_tabs_enabled, 
    extendableTabSize = default_extension_tab_size),
  sliding_lid_enabled = default_sliding_lid_enabled,
  sliding_lid_thickness = default_sliding_lid_thickness,
  sliding_lid_lip_enabled=default_sliding_lid_lip_enabled,
  sliding_min_wall_thickness = default_sliding_min_wallThickness, 
  sliding_min_support = default_sliding_min_support, 
  sliding_clearance = default_sliding_clearance,
  cupBaseTextSettings = CupBaseTextSettings(
    baseTextLine1Enabled = default_text_1,
    baseTextLine2Enabled = default_text_2,
    baseTextLine2Value = default_text_2_text,
    baseTextFontSize = default_text_size,
    baseTextFont = default_text_font,
    baseTextDepth = default_text_depth,
    baseTextOffset = default_text_offset)) {
  //num_x = is_undef($num_x) ? calcDimensionWidth(width, true) : $num_x;
  //num_y = is_undef($num_y) ? calcDimensionDepth(depth, true) : $num_y;
  //num_z = is_undef($num_z) ? calcDimensionHeight(height, true) : $num_z;
  num_x = is_undef(width) ?  $num_x : calcDimensionWidth(width, true);
  num_y = is_undef(depth) ? $num_y : calcDimensionDepth(depth, true);
  num_z = is_undef(height) ? $num_z : calcDimensionHeight(height, true);
  //wall_thickness default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
  wall_thickness = wallThickness(wall_thickness, num_z);
  filled_in = validateFilledIn(filled_in);
  label_settings=ValidateLabelSettings(label_settings);
  extendable_Settings = ValidateExtendableSettings(extendable_Settings, num_x=num_x, num_y=num_y);
  cupBase_settings = ValidateCupBaseSettings(cupBase_settings);
  floor_pattern_settings = ValidatePatternSettings(floor_pattern_settings);
  wall_pattern_settings = ValidatePatternSettings(wall_pattern_settings);
  slidingLidSettings= SlidingLidSettings(
          sliding_lid_enabled, 
          sliding_lid_thickness, 
          sliding_min_wall_thickness, 
          sliding_min_support,
          sliding_clearance,
          wall_thickness,
          sliding_lid_lip_enabled);
  headroom = headroom + (sliding_lid_enabled ? slidingLidSettings[iSlidingLidThickness] : 0);
  filledInZ = env_pitch().z*num_z;
  zpoint = filledInZ-headroom;
  efficient_floor = cupBase_settings[iCupBase_EfficientFloor];
  floor_thickness = cupBase_settings[iCupBase_FloorThickness];
  floorHeight = calculateFloorHeight(
    magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
    screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
    floor_thickness=cupBase_settings[iCupBase_FloorThickness],
    num_z=num_z,
    filled_in=filled_in, 
    efficient_floor=efficient_floor, 
    flat_base=cupBase_settings[iCupBase_FlatBase],
    captive_magnet_height=cupBase_settings[iCupBase_MagnetCaptiveHeight]);
  sepFloorHeight = (efficient_floor != "off" ? floor_thickness : floorHeight);
  calculated_vertical_separator_positions = calculateSeparators(
    separator_config = vertical_chambers[iChamber_irregular_subdivisions] 
      ? vertical_chambers[iChamber_separator_config]  
      : splitChamber(vertical_chambers[iChamber_count]-1, divider_width=vertical_chambers[iChamber_wall_thickness].x, container_width=num_x*env_pitch().x - env_clearance().x - wall_thickness*2), 
    length = env_pitch().y*num_y,
    height = env_pitch().z*(num_z)-sepFloorHeight+fudgeFactor*2-max(headroom, vertical_chambers[iChamber_wall_headroom]),
    wall_thickness = vertical_chambers[iChamber_wall_thickness],
    wall_top_radius = vertical_chambers[iChamber_wall_top_radius],
    bend_position = vertical_chambers[iChamber_separator_bend_position],
    bend_angle = vertical_chambers[iChamber_separator_bend_angle],
    bend_separation = vertical_chambers[iChamber_separator_bend_separation],
    cut_depth = vertical_chambers[iChamber_separator_cut_depth]);
  calculated_horizontal_separator_positions = calculateSeparators(
    separator_config = horizontal_chambers[iChamber_irregular_subdivisions] 
      ? horizontal_chambers[iChamber_separator_config] 
      : splitChamber(horizontal_chambers[iChamber_count]-1, divider_width=horizontal_chambers[iChamber_wall_thickness].x, container_width=num_y*env_pitch().y - env_clearance().y - wall_thickness*2), 
    length = env_pitch().x*num_x,
    height = env_pitch().z*(num_z)-sepFloorHeight+fudgeFactor*2-max(headroom, horizontal_chambers[iChamber_wall_headroom]),
    wall_thickness = horizontal_chambers[iChamber_wall_thickness],
    wall_top_radius = horizontal_chambers[iChamber_wall_top_radius],
    bend_position = horizontal_chambers[iChamber_separator_bend_position],
    bend_angle = horizontal_chambers[iChamber_separator_bend_angle],
    bend_separation = horizontal_chambers[iChamber_separator_bend_separation],
    cut_depth = horizontal_chambers[iChamber_separator_cut_depth]);
  //wallpattern_hole_size = is_list(wallpattern_hole_size) ? wallpattern_hole_size : [wallpattern_hole_size,wallpattern_hole_size];
  $gfc=[["num_x",num_x],["num_y",num_y],["num_z",num_z],["calculated_vertical_separator_positions",calculated_vertical_separator_positions],["calculated_horizontal_separator_positions",calculated_horizontal_separator_positions]];
  //Correct legacy values, values that used to work one way but were then changed.
  wallpattern_dividers_enabled = is_bool(wallpattern_dividers_enabled)
    ? wallpattern_dividers_enabled ? "vertical" : "disabled"
    : wallpattern_dividers_enabled;
  cavityFloorRadius = calculateCavityFloorRadius(cupBase_settings[iCupBase_CavityFloorRadius], wall_thickness, cupBase_settings[iCupBase_EfficientFloor]);
  if(env_generate_filter_enabled("cup"))
  debug_cut()
  union(){
    difference() {
        border = 0; //Believe this to be no longer needed
        wallpatternzpos = wallpatternClearanceHeight(
          magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
          screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
          center_magnet=cupBase_settings[iCupBase_CenterMagnetSize][iCylinderDimension_Height], 
          floor_thickness = cupBase_settings[iCupBase_FloorThickness],
          num_z=num_z, 
          filled_in=FilledIn_disabled, 
          efficient_floor=efficient_floor, 
          flat_base=cupBase_settings[iCupBase_FlatBase], 
          floor_inner_radius = cavityFloorRadius, 
          outer_cup_radius = 1);
        //I feel this should use wallTop, but it seems to work...
        heightz = env_pitch().z*(num_z)-wallpatternzpos + (
          //Position specific to each LIP style
          lip_settings[iLipStyle] == "reduced" ? 0.6 :
          lip_settings[iLipStyle] == "reduced_double" ? 0.6 :
          lip_settings[iLipStyle] == "minimum" ? 3 -border*2
           : -gf_lip_height-1.8);
        z=wallpatternzpos+heightz/2;
        cutoutclearance_divider = env_corner_radius()/2;
        wallTop = calculateWallTop(num_z, lip_settings[iLipStyle]);
        tapered_setback = tapered_setback < 0 ? env_corner_radius() : tapered_setback;
        tapered_corner_size =
              tapered_corner_size == -2 ? (wallTop - floorHeight)/2
            : tapered_corner_size < 0 ? wallTop - floorHeight //meant for -1, but also catch others
            : tapered_corner_size == 0 ? wallTop - floorHeight - cavityFloorRadius
            : tapered_corner_size;
      coloured_wall_pattern(
        wall_pattern_settings=wall_pattern_settings, wall_thickness=wall_thickness, wallpattern_walls=wallpattern_walls,
        pattern_floor = z, pattern_height = heightz, colored_pattern = wall_pattern_settings[iPatternColored]){ 
        //coloured_wall_pattern child 0 (Outer block)
        grid_block(
          num_x, num_y, num_z,
          cupBase_settings = cupBase_settings,
          wall_thickness = wall_thickness,
          lip_settings = lip_settings,
          filledin = filled_in);
        //coloured_wall_pattern child 1 bin cavities and negative volumes
        union(){
          //primary cavity
          if(filled_in == FilledIn_disabled) 
          partitioned_cavity(
            num_x, num_y, num_z,
            label_settings=label_settings,
            cupBase_settings = cupBase_settings,
            finger_slide_settings = finger_slide_settings,
            wall_thickness=wall_thickness,
            calculated_vertical_separator_positions = calculated_vertical_separator_positions,
            calculated_horizontal_separator_positions = calculated_horizontal_separator_positions,
            lip_settings=lip_settings,
            headroom=headroom,
            sliding_lid_settings= slidingLidSettings);
          bin_cutouts(
            num_x = num_x, num_y = num_y, num_z = num_z,
            wall_thickness = wall_thickness,
            cavityFloorRadius = cavityFloorRadius,
            wallTop = wallTop,
            floorHeight = floorHeight,
            wallcutout_vertical_settings = wallcutout_vertical_settings, 
            wallcutout_horizontal_settings = wallcutout_horizontal_settings, 
            tapered_corner = tapered_corner,
            tapered_corner_size = tapered_corner_size,
            tapered_setback = tapered_setback);
          bin_floor_pattern(
            num_x = num_x,
            num_y = num_y,
            wall_thickness = wall_thickness,
            cupBase_settings = cupBase_settings,
            calculated_vertical_separator_positions = calculated_vertical_separator_positions,
            calculated_horizontal_separator_positions = calculated_horizontal_separator_positions,
            floor_pattern_settings = floor_pattern_settings,
            sepFloorHeight = sepFloorHeight,
            fudgeFactor = fudgeFactor,
            cutoutclearance_divider = cutoutclearance_divider);
        bin_wall_pattern(
            num_x = num_x,
            num_y = num_y,
            num_z = num_z,
            wall_thickness = wall_thickness,
            cavityFloorRadius = cavityFloorRadius,
            wallTop = wallTop,
            floorHeight = floorHeight,
            label_settings = label_settings,
            calculated_vertical_separator_positions = calculated_vertical_separator_positions,
            calculated_horizontal_separator_positions = calculated_horizontal_separator_positions,
            wall_pattern_settings = wall_pattern_settings,
            wallpattern_walls = wallpattern_walls,
            wallpattern_dividers_enabled = wallpattern_dividers_enabled,
            sepFloorHeight = sepFloorHeight,
            cutoutclearance_divider = cutoutclearance_divider,
            border = border,
            heightz = heightz,
            z = z,
            wallpatternzpos = wallpatternzpos,
            tapered_corner = tapered_corner,
            tapered_corner_size = tapered_corner_size,
            tapered_setback = tapered_setback,
            wallcutout_vertical_settings = wallcutout_vertical_settings,
            wallcutout_horizontal_settings = wallcutout_horizontal_settings,
            enable_outer_walls = false,
            enable_inner_walls = true);
        }
        //coloured_wall_pattern child 2 wall pattern cavities
        //color(env_colour(color_wallcutout))
        bin_wall_pattern(
            num_x = num_x,
            num_y = num_y,
            num_z = num_z,
            wall_thickness = wall_thickness,
            cavityFloorRadius = cavityFloorRadius,
            wallTop = wallTop,
            floorHeight = floorHeight,
            label_settings = label_settings,
            calculated_vertical_separator_positions = calculated_vertical_separator_positions,
            calculated_horizontal_separator_positions = calculated_horizontal_separator_positions,
            wall_pattern_settings = wall_pattern_settings,
            wallpattern_walls = wallpattern_walls,
            wallpattern_dividers_enabled = wallpattern_dividers_enabled,
            sepFloorHeight = sepFloorHeight,
            cutoutclearance_divider = cutoutclearance_divider,
            border = border,
            heightz = heightz,
            z = z,
            wallpatternzpos = wallpatternzpos,
            tapered_corner = tapered_corner,
            tapered_corner_size = tapered_corner_size,
            tapered_setback = tapered_setback,
            wallcutout_vertical_settings = wallcutout_vertical_settings,
            wallcutout_horizontal_settings = wallcutout_horizontal_settings,
            enable_outer_walls = true,
            enable_inner_walls = false);
      } //coloured_wall_pattern
      if(label_settings[iLabelSettings_style] != LabelStyle_disabled){
        //generate the label sockets
        gridfinity_label(
          num_x = num_x,
          num_y = num_y,
          zpoint = zpoint,
          vertical_separator_positions = calculated_vertical_separator_positions,
          horizontal_separator_positions = calculated_horizontal_separator_positions,
          label_settings=label_settings,
          render_option = "socket",
          socket_padding = [0,0,4]);
    }
    // add text to the bottom
    _magnet_position = calculateAttachmentPositions(cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Diameter], cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Diameter]);
    if(env_help_enabled("trace")) echo("cup_base_text", _magnet_position=_magnet_position, iCupBase_MagnetSize=cupBase_settings[iCupBase_MagnetSize]);
    cup_base_text(
      cupBaseTextSettings = cupBaseTextSettings, 
      wall_thickness = wall_thickness,
      magnet_position = _magnet_position.x);
    cut_bins_for_extension(
      num_x = num_x,
      num_y = num_y,
      num_z = num_z,
      extendable_Settings = extendable_Settings);
    }
    //add the extention tabs
    extension_tabs(
      num_x = num_x,
      num_y = num_y,
      num_z = num_z,
      extendable_Settings = extendable_Settings,
      cupBase_settings = cupBase_settings,
      lip_settings = lip_settings,
      floor_thickness = floor_thickness,
      wall_thickness = wall_thickness,
      headroom = headroom);
    if (lip_settings[iLipStyle] == "reduced_double") {
      label_size=calculateLabelSize(label_settings[iLabelSettings_size]);
      labelCornerRadius = label_size[3];
      lipHeight = 3.75;
      tz(- lipHeight -labelCornerRadius)
      tz(zpoint)
      cupLip(
      num_x = num_x,
      num_y = num_y,
      lipStyle = lip_settings[iLipStyle],
      wall_thickness = wall_thickness,
      lip_notches = false,
      lip_top_relief_height = lip_settings[iLipTopReliefHeight],
      lip_top_relief_width = lip_settings[iLipTopReliefWidth],
      lip_clip_position = lip_settings[iLipClipPosition],
      lip_non_blocking = lip_settings[iLipNonBlocking]);
    }
  }  
  if(env_help_enabled("info"))
    //translate(gridfinityRenderPosition(position,num_x,num_y))
    ShowCalipers(
      env_cutx(), 
      env_cuty(), 
      size=[num_x,num_y,num_z], 
      lip_settings[iLipStyle],
      cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
      cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
      cupBase_settings[iCupBase_CenterMagnetSize][iCylinderDimension_Height], 
      floor_thickness = cupBase_settings[iCupBase_FloorThickness], 
      filled_in,
      wall_thickness,
      efficient_floor = cupBase_settings[iCupBase_EfficientFloor], 
      flat_base = cupBase_settings[iCupBase_FlatBase]); 
  HelpTxt("gridfinity_cup",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"filled_in",filled_in
    ,"label_settings",label_settings
    ,"finger_slide_settings",finger_slide_settings
    ,"cupBase_settings",cupBase_settings
    ,"wall_thickness",wall_thickness
    ,"vertical_chambers",vertical_chambers
    ,"horizontal_chambers",horizontal_chambers
    ,"lip_settings",lip_settings
    ,"headroom",headroom
    ,"tapered_corner",tapered_corner
    ,"tapered_corner_size",tapered_corner_size
    ,"tapered_setback",tapered_setback
    ,"wallpattern_walls",wallpattern_walls
    ,"wall_pattern_settings",wall_pattern_settings
    ,"floor_pattern_settings",floor_pattern_settings
    ,"wallcutout_vertical_settings",wallcutout_vertical_settings
    ,"wallcutout_horizontal_settings",wallcutout_horizontal_settings
    ,"extendable_Settings",extendable_Settings
    ]
    ,env_help_enabled("info"));  
}
module bin_wall_pattern(
  num_x,
  num_y,
  num_z,
  wall_thickness,
  cavityFloorRadius,
  wallTop,
  floorHeight,
  label_settings,
  calculated_vertical_separator_positions,
  calculated_horizontal_separator_positions,
  wall_pattern_settings,
  wallpattern_walls,
  wallpattern_dividers_enabled,
  sepFloorHeight,
  cutoutclearance_divider,
  border,
  heightz,
  z,
  wallpatternzpos,
  tapered_corner,
  tapered_corner_size,
  tapered_setback,
  wallcutout_vertical_settings,
  wallcutout_horizontal_settings,
  enable_outer_walls = true,
  enable_inner_walls = true,
) {
  fudgeFactor = 0.01;
  wallpattern_thickness = get_related_value(wall_pattern_settings[iPatternDepth], wall_thickness) + fudgeFactor*4;
  cutout_clearance_border = max(wall_thickness, wall_pattern_settings[iPatternBorder]);
  //TODO: wall pattern needs to take in to account head room.
  //TODO: wall pattern should partial depth walls.
  //Wall patterns
  //Wall pattern in outerwalls
  if(wall_pattern_settings[iPatternEnabled]){
    difference(){
      union(){
        if(wall_pattern_settings[iPatternEnabled]){
          labelSize = calculateLabelSize(label_settings[iLabelSettings_size]);
          //Subtracting the wallpattern_thickness is a bit of a hack, its needed as the label extends in to the wall.
          labelSizez = (label_settings[iLabelSettings_style] != LabelStyle_disabled ? labelSize.z-wallpattern_thickness : 0);
          positions = get_wallpattern_positions(
            border = border,
            heightz = heightz,
            positionz = z,
            wall_thickness = wall_thickness,
            wallpattern_thickness = wallpattern_thickness,
            wallpattern_walls = wallpattern_walls,
            label_walls = label_settings[iLabelSettings_walls],
            label_sizez = labelSizez);
          ylocations = positions.y;
          xlocations = positions.x;
          front = xlocations[0];
          left = ylocations[0];
          //patterns in the outer walls x
          difference(){
            union(){
              for(i = [0:1:len(ylocations)-1])
                if(enable_outer_walls && ylocations[i][4] > 0)
                  translate(ylocations[i][1])
                  mirror(ylocations[i][3])
                  rotate(ylocations[i][2])
                  render_conditional(env_force_render())
                    cutout_pattern(
                      patternStyle = wall_pattern_settings[iPatternStyle],
                      canvasSize = [ylocations[i][0].x, ylocations[i][0].y],
                      border = wall_pattern_settings[iPatternBorder],
                      customShape = false,
                      circleFn = wall_pattern_settings[iPatternHoleSides],
                      cellSize = wall_pattern_settings[iPatternCellSize],
                      strength = wall_pattern_settings[iPatternStrength],
                      holeHeight = ylocations[i][0].z + fudgeFactor,
                      center=true,
                      centerz = true,
                      fill = wall_pattern_settings[iPatternFill], //"none", "space", "crop"
                      patternGridChamfer = wall_pattern_settings[iPatternGridChamfer],
                      patternVoronoiNoise = wall_pattern_settings[iPatternVoronoiNoise],
                      patternBrickWeight = wall_pattern_settings[iPatternBrickWeight],
                      partialDepth = wall_pattern_settings[iPatternDepth] != 0,
                      holeRadius = wall_pattern_settings[iPatternHoleRadius],
                      source = "wall_pattern",
                      rotateGrid = wall_pattern_settings[iPatternRotate],
                      patternFs = wall_pattern_settings[iPatternFs]);
                if(enable_inner_walls && wallpattern_dividers_enabled == "vertical" || wallpattern_dividers_enabled == "both")
                  position_separators(
                    calculatedSeparators = calculated_vertical_separator_positions, 
                    separator_orientation = "vertical")
                      let(verSepThickness = $sepCfg[iSeparatorWallThickness][0]+$sepCfg[iSeparatorBendSeparation]+fudgeFactor*2)
                      //translate([verSepThickness/2+wall_thickness/2-fudgeFactor, 0, 0])
                      translate([wall_thickness/2-fudgeFactor*2, 0, 0])
                      translate(left[1])
                      mirror(left[3])
                      rotate(left[2])
                      render_conditional(env_force_render())
                        //separator wall pattern
                        cutout_pattern(
                          patternStyle = wall_pattern_settings[iPatternStyle],
                          canvasSize = [left[0].x, left[0].y], 
                          border = wall_pattern_settings[iPatternBorder],
                          customShape = false,
                          circleFn = wall_pattern_settings[iPatternHoleSides],
                          cellSize = wall_pattern_settings[iPatternCellSize],
                          strength = wall_pattern_settings[iPatternStrength],
                          holeHeight = verSepThickness+fudgeFactor,
                          center=true,
                          centerz = true,
                          fill=wall_pattern_settings[iPatternFill],
                          patternGridChamfer = wall_pattern_settings[iPatternGridChamfer],
                          patternVoronoiNoise = wall_pattern_settings[iPatternVoronoiNoise],
                          patternBrickWeight = wall_pattern_settings[iPatternBrickWeight],
                          partialDepth = wall_pattern_settings[iPatternDepth] != 0,
                          holeRadius = wall_pattern_settings[iPatternHoleRadius],
                          source="vertical separator wall pattern",
                          rotateGrid = wall_pattern_settings[iPatternRotate],
                          patternFs = wall_pattern_settings[iPatternFs]);
            }    
            //subtract dividers from wall patterns
            translate([env_pitch().x*num_x, wall_thickness+env_clearance().y/2, sepFloorHeight-fudgeFactor])
            separators(
              calculatedSeparators = calculated_horizontal_separator_positions,
              separator_orientation = "horizontal",
              pad_wall_thickness = cutoutclearance_divider*2,
              pad_wall_height = fudgeFactor,
              source = "bin_wall_pattern");
          }
          //patterns in the outer walls y
          difference(){
            union(){
              for(i = [0:1:len(xlocations)-1])
                if(enable_outer_walls && xlocations[i][4] > 0)
                  translate(xlocations[i][1])
                  mirror(xlocations[i][3])
                  rotate(xlocations[i][2])
                  render_conditional(env_force_render())
                    cutout_pattern(
                      patternStyle = wall_pattern_settings[iPatternStyle],
                      canvasSize = [xlocations[i][0].x, xlocations[i][0].y],
                      border = wall_pattern_settings[iPatternBorder],
                      customShape = false,
                      circleFn = wall_pattern_settings[iPatternHoleSides],
                      cellSize = wall_pattern_settings[iPatternCellSize],
                      strength = wall_pattern_settings[iPatternStrength],
                      holeHeight = xlocations[i][0].z+fudgeFactor,
                      center = true,
                      centerz = true,
                      fill = wall_pattern_settings[iPatternFill], //"none", "space", "crop"
                      patternGridChamfer = wall_pattern_settings[iPatternGridChamfer],
                      patternVoronoiNoise = wall_pattern_settings[iPatternVoronoiNoise],
                      patternBrickWeight = wall_pattern_settings[iPatternBrickWeight],
                      partialDepth = wall_pattern_settings[iPatternDepth] != 0,
                      holeRadius = wall_pattern_settings[iPatternHoleRadius],
                      source = "wall_pattern",
                      rotateGrid = wall_pattern_settings[iPatternRotate],
                      patternFs = wall_pattern_settings[iPatternFs]);
                  if(enable_inner_walls && wallpattern_dividers_enabled == "horizontal" || wallpattern_dividers_enabled == "both")
                    position_separators(
                      calculatedSeparators = calculated_horizontal_separator_positions, 
                      separator_orientation = "horizontal")
                        let(hozSepThickness = $sepCfg[iSeparatorWallThickness][0]+$sepCfg[iSeparatorBendSeparation]+fudgeFactor*2)
                        rotate([0,0,-90])
                        //translate([0, hozSepThickness/2+wall_thickness/2-fudgeFactor, 0])
                        translate([0, wall_thickness/2-fudgeFactor*2, 0])
                        translate(front[1])
                        mirror(front[3])
                        rotate(front[2])
                        render_conditional(env_force_render())
                          //separator wall pattern
                          cutout_pattern(
                            patternStyle = wall_pattern_settings[iPatternStyle],
                            canvasSize = [front[0].x, front[0].y], 
                            border = wall_pattern_settings[iPatternBorder],
                            customShape = false,
                            circleFn = wall_pattern_settings[iPatternHoleSides],
                            cellSize = wall_pattern_settings[iPatternCellSize],
                            strength = wall_pattern_settings[iPatternStrength],
                            holeHeight = hozSepThickness+fudgeFactor,
                            center = true,
                            centerz = true,
                            fill = wall_pattern_settings[iPatternFill], 
                            patternGridChamfer = wall_pattern_settings[iPatternGridChamfer],
                            patternVoronoiNoise = wall_pattern_settings[iPatternVoronoiNoise],
                            patternBrickWeight = wall_pattern_settings[iPatternBrickWeight],
                            partialDepth = wall_pattern_settings[iPatternDepth] != 0,
                            holeRadius = wall_pattern_settings[iPatternHoleRadius],
                            source = "horizontal separator wall pattern",
                            rotateGrid = wall_pattern_settings[iPatternRotate],
                            patternFs = wall_pattern_settings[iPatternFs]);
            }
            //subtract dividers from outer wall pattern
            translate([wall_thickness+env_clearance().x/2, 0, sepFloorHeight-fudgeFactor])
            separators(
              calculatedSeparators = calculated_vertical_separator_positions,
              separator_orientation = "vertical",
              pad_wall_thickness = cutoutclearance_divider*2,
              pad_wall_height = fudgeFactor,
              source = "bin_wall_pattern");
          }
        }
      }
      bin_cutouts(
        num_x = num_x,
        num_y = num_y,
        num_z = num_z,
        wall_thickness = wall_thickness,
        cavityFloorRadius = cavityFloorRadius,
        wallTop = wallTop,
        floorHeight = floorHeight,
        wallcutout_vertical_settings = wallcutout_vertical_settings,
        wallcutout_horizontal_settings = wallcutout_horizontal_settings,
        tapered_corner = tapered_corner,
        tapered_corner_size = tapered_corner_size,
        tapered_setback = tapered_setback,
        cutout_clearance_border = cutout_clearance_border);
    }
  }
}
module bin_floor_pattern(
  num_x,
  num_y,
  wall_thickness,
  cupBase_settings,
  calculated_vertical_separator_positions,
  calculated_horizontal_separator_positions,
  floor_pattern_settings,
  sepFloorHeight,
  fudgeFactor,
  cutoutclearance_divider,
) {
  if(floor_pattern_settings[iPatternEnabled]){
    difference(){
      pad_copy(
        num_x = num_x, 
        num_y = num_y, 
        half_pitch = cupBase_settings[iCupBase_HalfPitch], 
        flat_base = cupBase_settings[iCupBase_FlatBase], 
        minimium_size = cupBase_settings[iCupBase_MinimumPrintablePadSize])
          translate([$pad_copy_size.x*env_pitch().x/2, $pad_copy_size.y*env_pitch().y/2,-fudgeFactor])
          cutout_pattern(
            patternStyle = floor_pattern_settings[iPatternStyle],
            canvasSize = [$pad_copy_size.x*env_pitch().x, $pad_copy_size.y*env_pitch().y],
            circleFn = floor_pattern_settings[iPatternHoleSides],
            cellSize = floor_pattern_settings[iPatternCellSize],
            strength = floor_pattern_settings[iPatternStrength],
            holeHeight = sepFloorHeight + fudgeFactor*6,
            center = true,
            fill = floor_pattern_settings[iPatternFill],
            patternGridChamfer = floor_pattern_settings[iPatternGridChamfer],
            patternVoronoiNoise = floor_pattern_settings[iPatternVoronoiNoise],
            patternBrickWeight = floor_pattern_settings[iPatternBrickWeight],
            partialDepth = floor_pattern_settings[iPatternDepth] != 0,
            border = max(5, floor_pattern_settings[iPatternBorder],
              cupBase_settings[iCupBase_EfficientFloor] == EfficientFloor_smooth? 6.5 : 0),
            holeRadius = floor_pattern_settings[iPatternHoleRadius],
            patternFs = floor_pattern_settings[iPatternFs],
            rotateGrid = floor_pattern_settings[iPatternRotate],
            source="floor_pattern");
      //subtract dividers from floor pattern
      //Potential bug if the wall height is less than the floor height
      translate([wall_thickness+env_clearance().x/2, 0, -fudgeFactor])
      separators(
        calculatedSeparators = calculated_vertical_separator_positions,
        separator_orientation = "vertical",
        pad_wall_thickness = cutoutclearance_divider*2,
        source = "bin_floor_pattern");
      //subtract dividers from floor pattern
      //Potential bug if the wall height is less than the floor height
      translate([env_pitch().x*num_x, wall_thickness+env_clearance().y/2, -fudgeFactor])
      separators(
        calculatedSeparators = calculated_horizontal_separator_positions,
        separator_orientation = "horizontal",
        pad_wall_thickness = cutoutclearance_divider*2,
        source = "bin_floor_pattern");
      // Subtract magnet/screw pads if enabled
      magnet_diameter = cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Diameter];
      screw_diameter = cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Diameter];
      if (magnet_diameter > 0 || screw_depth > 0) {
        magnet_positions = calculateAttachmentPositions(magnet_diameter, screw_diameter);
        pad_radius = max(magnet_diameter, screw_diameter) / 2 + cutoutclearance_divider*2;
        pad_height = sepFloorHeight + fudgeFactor * 6;
        gridcopycorners(num_x, num_y, magnet_positions, cupBase_settings[iCupBase_CornerAttachmentsOnly])
            cylinder(r = pad_radius, h = pad_height, $fn = 32);
      }
    }
  }
}
module bin_cutouts(
  num_x = 0,
  num_y = 0,
  num_z = 0,
  wall_thickness,
  cavityFloorRadius,
  wallTop,
  floorHeight,
  wallcutout_vertical_settings,
  wallcutout_horizontal_settings,
  tapered_corner = "none",
  tapered_corner_size = 0,
  tapered_setback = 0,
  cutout_clearance_border = 0
) {
  wallcutouts_vertical = calculateWallCutouts(
    wall_length = num_x,
    opposite_wall_distance = num_y,
    wallcutout_settings = wallcutout_vertical_settings,
    wallcutout_rotation = [0,0,0],
    wallcutout_reposition = [0,0,0],
    wall_thickness = wall_thickness,
    cavityFloorRadius = cavityFloorRadius,
    wallTop = wallTop,
    z_point = num_z*env_pitch().z,
    floorHeight = floorHeight,
    pitch = env_pitch().x,
    pitch_opposite = env_pitch().y);
  wallcutouts_horizontal = calculateWallCutouts(
    wall_length = num_y,
    opposite_wall_distance = num_x,
    wallcutout_settings = wallcutout_horizontal_settings,
    wallcutout_rotation = [0,0,90],
    wallcutout_reposition = [num_x*env_pitch().x,0,0],
    wall_thickness = wall_thickness,
    cavityFloorRadius = cavityFloorRadius,
    wallTop = wallTop,
    z_point = num_z*env_pitch().z,
    floorHeight = floorHeight,
    pitch = env_pitch().y,
    pitch_opposite = env_pitch().x);
  wallcutout_locations = concat(wallcutouts_vertical, wallcutouts_horizontal);
  if(wallcutout_vertical_settings[iwalcutoutconfig_type] != "disabled" || wallcutout_horizontal_settings[iwalcutoutconfig_type] !="disabled" )
    for(wallcutout_location_near_far = wallcutout_locations)
    for(wallcutout_location = wallcutout_location_near_far)
      if(wallcutout_location[iwalcutout_enabled] == true)
        translate(wallcutout_location[iwalcutout_reposition])
        rotate(wallcutout_location[iwalcutout_rotation])
        translate(wallcutout_location[iwalcutout_position])
        WallCutout(
          lowerWidth=wallcutout_location[iwalcutout_size].x+cutout_clearance_border*2,
          wallAngle=wallcutout_location[iwalcutout_config][iwalcutoutconfig_angle],
          height=wallcutout_location[iwalcutout_size].z+cutout_clearance_border,
          thickness=wallcutout_location[iwalcutout_size].y,
          cornerRadius=wallcutout_location[iwalcutout_config][iwalcutoutconfig_cornerradius]);
  //Tapered corner cutout  // Add tapered corner cutout if enabled
  if(tapered_corner == "rounded" || tapered_corner == "chamfered"){
    translate([0, 
      tapered_setback + env_clearance().y+cutout_clearance_border, 
      env_pitch().z * num_z + gf_Lip_Height - env_clearance().z-cutout_clearance_border])
    rotate([270,0,0])
    union(){
      if(tapered_corner == "rounded"){
        roundedCorner(
          radius = tapered_corner_size+cutout_clearance_border*2,
          length = (num_x + 1) * env_pitch().x,
          height = tapered_corner_size,
          width = tapered_corner_size + tapered_setback);
      }
      else if(tapered_corner == "chamfered"){
        chamferedCorner(
          chamferLength = tapered_corner_size,
          length = (num_x + 1) * env_pitch().x,
          height = tapered_corner_size,
          width = tapered_corner_size + tapered_setback);
      }
    }
  }
}
module partitioned_cavity(num_x, num_y, num_z, 
    label_settings=[],
    cupBase_settings=[],
    finger_slide_settings=[],
    wall_thickness=0,
    calculated_vertical_separator_positions=calculated_vertical_separator_positions,
    calculated_horizontal_separator_positions=calculated_horizontal_separator_positions,
    lip_settings=[], 
    headroom=default_headroom, 
    sliding_lid_settings=[]) {
  //Legacy variables
  flat_base=cupBase_settings[iCupBase_FlatBase];
  cavity_floor_radius=cupBase_settings[iCupBase_CavityFloorRadius];
  spacer=cupBase_settings[iCupBase_Spacer];
  box_corner_attachments_only=cupBase_settings[iCupBase_CornerAttachmentsOnly];
  efficient_floor=cupBase_settings[iCupBase_EfficientFloor]; 
  half_pitch=cupBase_settings[iCupBase_HalfPitch];        
  magnet_diameter=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Diameter];
  screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height];
  magnet_easy_release=cupBase_settings[iCupBase_MagnetEasyRelease];
  floor_thickness=cupBase_settings[iCupBase_FloorThickness];  
  zpoint = env_pitch().z*num_z-headroom;
  floorHeight = calculateFloorHeight(
    magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
    screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
    floor_thickness=cupBase_settings[iCupBase_FloorThickness],
    num_z=num_z,
    filled_in="disabled", 
    efficient_floor=efficient_floor, 
    flat_base=cupBase_settings[iCupBase_FlatBase],
    captive_magnet_height=cupBase_settings[iCupBase_MagnetCaptiveHeight]);
  difference() {
    color(env_colour(color_cupcavity))
    union(){
    basic_cavity(num_x, num_y, num_z,
      cupBase_settings=cupBase_settings,
      finger_slide_settings = finger_slide_settings,
      wall_thickness=wall_thickness,
      lip_settings=lip_settings, 
      sliding_lid_settings=sliding_lid_settings, 
      headroom=headroom);
    }
    if(env_help_enabled("trace")) echo("partitioned_cavity", vertical_separator_positions=calculated_vertical_separator_positions);
    sepFloorHeight = (efficient_floor != "off" ? floor_thickness : floorHeight);
    color(env_colour(color_divider))
    tz(sepFloorHeight-fudgeFactor)
    translate([wall_thickness+env_clearance().x/2, 0, 0])
    separators(
      calculatedSeparators = calculated_vertical_separator_positions,
      separator_orientation = "vertical",
      source = "partitioned_cavity");
    if(env_help_enabled("trace")) echo("partitioned_cavity", horizontal_separator_positions=calculated_horizontal_separator_positions);
    color(env_colour(color_divider))
    translate([env_pitch().x*num_x, wall_thickness+env_clearance().y/2, sepFloorHeight-fudgeFactor])
    separators(
      calculatedSeparators = calculated_horizontal_separator_positions, 
      separator_orientation = "horizontal",
      source = "partitioned_cavity");
    if(label_settings[iLabelSettings_style] != LabelStyle_disabled){
      gridfinity_label(
        num_x = num_x,
        num_y = num_y,
        zpoint = zpoint,
        vertical_separator_positions = calculated_vertical_separator_positions,
        horizontal_separator_positions = calculated_horizontal_separator_positions,
        label_settings=label_settings,
        render_option = "labelwithsocket");
    }
  }
}           
module basic_cavity(num_x, num_y, num_z, 
    finger_slide_settings = [],
    wall_thickness=default_wall_thickness,
    lip_settings = [],
    cupBase_settings = [],
    sliding_lid_settings = [],
    divider_wall_removable_settings = [],
    headroom = 0) {
  //Legacy variables
  floor_thickness=cupBase_settings[iCupBase_FloorThickness]; 
  magnet_diameter=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Diameter];
  screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height];
  magnet_easy_release=cupBase_settings[iCupBase_MagnetEasyRelease];
  flat_base=cupBase_settings[iCupBase_FlatBase];
  spacer=cupBase_settings[iCupBase_Spacer];
  box_corner_attachments_only=cupBase_settings[iCupBase_CornerAttachmentsOnly];
  half_pitch=cupBase_settings[iCupBase_HalfPitch];
  //zpoint = env_pitch().z*num_z-headroom;
  AssertSlidingLidSettings(sliding_lid_settings);
  innerWallRadius = max(0.1, env_corner_radius()-wall_thickness); //prevent radius going negative
  corner_post_adjust = min(0, env_corner_radius()-wall_thickness-innerWallRadius)*-1;
  inner_corner_center = [
    env_pitch().x/2-env_corner_radius()-env_clearance().x/2, 
    env_pitch().y/2-env_corner_radius()-env_clearance().y/2];
  wall_inner_corner_center = let(
    corner_post_adjust = min(0, env_corner_radius()-wall_thickness-innerWallRadius)*-1
    ) [
    inner_corner_center.x-corner_post_adjust, 
    inner_corner_center.y-corner_post_adjust];
  lip_inner_corner_center = corner_post_adjust > 0 ? wall_inner_corner_center : inner_corner_center;
  innerLipRadius = env_corner_radius()-gf_lip_lower_taper_height-gf_lip_upper_taper_height; 
  reducedlipstyle = 
    // replace "reduced" with "none" if z-height is less than 1.2
    (num_z < 1.2) ? "none" 
    // replace with "reduced" if z-height is less than 1.8
    : (num_z < 1.8) ? "reduced" 
    : lip_settings[iLipStyle];
  filledInZ = env_pitch().z*num_z;
  zpoint = filledInZ-headroom;
  floorht = min(filledInZ, calculateFloorHeight(
      magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
      screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
      center_magnet=cupBase_settings[iCupBase_CenterMagnetSize][iCylinderDimension_Height], 
      floor_thickness=cupBase_settings[iCupBase_FloorThickness], 
      num_z=num_z,
      filled_in=FilledIn_disabled,
      efficient_floor=cupBase_settings[iCupBase_EfficientFloor],
      flat_base=cupBase_settings[iCupBase_FlatBase],
      captive_magnet_height=cupBase_settings[iCupBase_MagnetCaptiveHeight]));
  //Remove floor to create a vertical spacer.
  nofloor = spacer && finger_slide_settings[iFingerSlideType] == "none";
  //Difference between the wall and support thickness
  lipSupportThickness = (reducedlipstyle == "minimum" || reducedlipstyle == "none") ? 0
    : reducedlipstyle == "reduced" ? gf_lip_upper_taper_height - wall_thickness
    : reducedlipstyle == "reduced_double" ? gf_lip_upper_taper_height - wall_thickness
    : gf_lip_upper_taper_height + gf_lip_lower_taper_height- wall_thickness;
  lipHeight = (reducedlipstyle == "none") ? 0 : gf_Lip_Height-0.65;
  //bottom of the lip where it touches the wall
  lipBottomZ = ((reducedlipstyle == "minimum" || reducedlipstyle == "none") ? env_pitch().z*num_z +fudgeFactor*3
    : reducedlipstyle == "reduced" ? env_pitch().z*num_z+fudgeFactor*3
    : reducedlipstyle == "reduced_double" ? env_pitch().z*num_z+fudgeFactor*3
    : env_pitch().z*num_z-gf_lip_height-lipSupportThickness);
  //lipBottomZ = env_pitch().z*num_z+fudgeFactor*3;
  if(env_help_enabled("trace")) echo("basic_cavity", gf_cup_corner_radius=env_corner_radius(),wall_thickness=wall_thickness, env_clearance=env_clearance(), inner_corner_center=inner_corner_center, innerWallRadius=innerWallRadius, innerLipRadius=innerLipRadius);
  aboveLidHeight =  sliding_lid_settings[iSlidingLidThickness] + lipHeight;
  //cavityHeight= max(lipBottomZ-floorht,0);
  cavityHeight= max(lipBottomZ-floorht,0);
  cavity_floor_radius = calculateCavityFloorRadius(cupBase_settings[iCupBase_CavityFloorRadius], wall_thickness,cupBase_settings[iCupBase_EfficientFloor]);
  // I couldn't think of a good name for this ('q') but effectively it's the
  // size of the overhang that produces a wall thickness that's less than the lip
  // arount the top inside edge.
  q = 1.65-wall_thickness+0.95;  // default 1.65 corresponds to wall thickness of 0.95
  if(env_help_enabled("trace")) echo("basic_cavity", floorht=floorht, efficient_floor=cupBase_settings[iCupBase_EfficientFloor], nofloor=nofloor, lipSupportThickness=lipSupportThickness, lipBottomZ=lipBottomZ, innerLipRadius=innerLipRadius, innerWallRadius=innerWallRadius, cavityHeight=cavityHeight, cavity_floor_radius=cavity_floor_radius, flat_base=cupBase_settings[iCupBase_FlatBase]);
  if(filledInZ>floorht) {
    union(){
    difference() {
    union() {
      if (reducedlipstyle == "minimum" || reducedlipstyle == "none") {
      } 
      else if (reducedlipstyle == "reduced") {
      } 
      else if (reducedlipstyle == "reduced_double") {
      }
      else { // normal
        lowerTaperZ = filledInZ-gf_lip_height-lipSupportThickness;
        if(lowerTaperZ <= floorht){
          hull() cornercopy(lip_inner_corner_center, num_x, num_y)
            tz(floorht) 
            cylinder(r=innerLipRadius, h=filledInZ-floorht+fudgeFactor*4); // lip
        } else {
          if(headroom > 0)
          hull() cornercopy(inner_corner_center, num_x, num_y)
            tz(filledInZ-headroom-fudgeFactor) 
            cylinder(r=innerLipRadius, h=headroom+fudgeFactor*4); // lip
          hull() cornercopy(lip_inner_corner_center, num_x, num_y)
            tz(filledInZ-gf_lip_height-fudgeFactor) 
            cylinder(r=(innerLipRadius > innerWallRadius ? innerWallRadius : innerLipRadius), h=gf_lip_height+fudgeFactor*4); // lip
          hull() cornercopy(lip_inner_corner_center, num_x, num_y)
            tz(filledInZ-gf_lip_height-lipSupportThickness-fudgeFactor) 
            cylinder(
              r1=innerWallRadius,
              r2=innerLipRadius, h=q+fudgeFactor);   // ... to top of thin wall ...
        }
      }
      //Cavity below lip
      if(cavityHeight > 0)
       hull() cornercopy(wall_inner_corner_center, num_x, num_y)
        tz(floorht)
          roundedCylinder(
            h=cavityHeight,
            r=innerWallRadius,
            roundedr1=min(cavityHeight, cavity_floor_radius),
            roundedr2=0);
    } //union of main cavity
    if(sliding_lid_settings[iSlidingLidEnabled])
      SlidingLidSupportMaterial(
        num_x = num_x, 
        num_y = num_y,
        wall_thickness = wall_thickness,
        sliding_lid_settings = sliding_lid_settings,
        zpoint=zpoint);
    // fingerslide inside bottom of cutout
    if(finger_slide_settings[iFingerSlideType] != "none"){
      FingerSlide(
        num_x = num_x, 
        num_y = num_y,
        num_z = num_z,
        fingerslide_walls=finger_slide_settings[iFingerSlideWalls],
        lipAligned=finger_slide_settings[iFingerSlideLipAligned],
        fingerslide=finger_slide_settings[iFingerSlideType],
        fingerslide_radius=finger_slide_settings[iFingerSlideRadius],
        reducedlipstyle=reducedlipstyle,
        wall_thickness=wall_thickness,
        floorht=floorht,
        inner_corner_center=wall_inner_corner_center);
    }
    if (cupBase_settings[iCupBase_EfficientFloor] != "off") {
      magnetPosition = calculateAttachmentPositions(magnet_diameter, cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Diameter]);
      magnetCoverHeight = max(
        cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
        cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height]);
      hasCornerAttachments = magnet_diameter > 0 || screw_depth > 0;
      efficientFloorGridHeight = max(magnetCoverHeight,gfBaseHeight())+floor_thickness;
      if(env_help_enabled("trace")) echo("basic_cavity", efficient_floor=cupBase_settings[iCupBase_EfficientFloor], efficientFloorGridHeight=efficientFloorGridHeight,  floor_thickness=floor_thickness);
      difference(){
        tz(-fudgeFactor)
          cube([num_x*env_pitch().x, num_y*env_pitch().y, efficientFloorGridHeight]);
        difference(){
          efficient_floor_grid(
            num_x, num_y,
            floorStyle = cupBase_settings[iCupBase_EfficientFloor],
            half_pitch=half_pitch,
            flat_base=flat_base,
            floor_thickness=floor_thickness,
            efficientFloorGridHeight=efficientFloorGridHeight,
            align_grid = cupBase_settings[iCupBase_AlignGrid],
            margins=q);
           //Screw and magnet covers required for efficient floor
           if(hasCornerAttachments)
             gridcopycorners(num_x, num_y, magnetPosition, box_corner_attachments_only)
                let(magnet_size=cupBase_settings[iCupBase_MagnetSize])
                EfficientFloorAttachmentCaps(
                  grid_copy_corner_index = $gcci,
                  floor_thickness = floor_thickness,
                  magnet_size = cupBase_settings[iCupBase_MagnetSize] + [0, cupBase_settings[iCupBase_MagnetCaptiveHeight]],
                  screw_size = cupBase_settings[iCupBase_ScrewSize],
                  wall_thickness = magnet_easy_release == MagnetEasyRelease_inner ? wall_thickness*2 : wall_thickness );
          }
        }
      }
    }  // difference removals from main body.
    //Sliding lid rebate.
    if(sliding_lid_settings[iSlidingLidEnabled])
      tz(zpoint)
      SlidingLidCavity(
        num_x = num_x,
        num_y = num_y,
        wall_thickness = wall_thickness,
        sliding_lid_settings = sliding_lid_settings,
        aboveLidHeight = aboveLidHeight);
  }}
  // cut away side lips if num_x is less than 1
  if(env_help_enabled("trace")) echo(str("cutaway input:", num_x, " rounded:", roundtoDecimal(num_x, sigFigs = 2), " numx<1:", num_x < 1," round<1:", roundtoDecimal(num_x, sigFigs = 2)<1, " numx=round:", num_x==roundtoDecimal(num_x, sigFigs = 2)));
  if (roundtoDecimal(num_x,2) < lip_settings[iLipSideReliefTrigger].x) {
    top = num_z*env_pitch().z+gf_Lip_Height;
    height = top-lipBottomZ+fudgeFactor*2;
    hull()
    for (x=[1.5+0.25+wall_thickness, num_x*env_pitch().x-1.5-0.25-wall_thickness]){
      for (y=[11, (num_y)*env_pitch().y-wall_inner_corner_center.y])
      translate([x, y, top-height])
      cylinder(d=3, h=height);
    }
  }
  if (roundtoDecimal(num_y,2) < lip_settings[iLipSideReliefTrigger].y) {
    top = num_z*env_pitch().z+gf_Lip_Height;
    height = top-lipBottomZ+fudgeFactor*2;
    hull()
    for (y=[1.5+0.25+wall_thickness, num_y*env_pitch().y-1.5-0.25-wall_thickness]){
      for (x=[11, (num_x)*env_pitch().x-wall_inner_corner_center.x])
      translate([x, y, top-height])
      cylinder(d=3, h=height);
    }
  }
  if (nofloor) {
    tz(-fudgeFactor)
      hull()
      cornercopy(num_x=num_x, num_y=num_y, r=wall_inner_corner_center)
      cylinder(r=2, h=gf_cupbase_lower_taper_height+fudgeFactor);
    gridcopy(1, 1)
      EfficientFloor(num_x, num_y,-fudgeFactor, q);
  }
}
//CombinedEnd from path module_gridfinity_cup.scad
//Combined from path module_patterns.scad





iPatternEnabled=0;
iPatternStyle=1;
iPatternRotate=2;
iPatternFill=3;
iPatternBorder=4;
iPatternDepth=5;
iPatternCellSize=6;
iPatternHoleSides=7;
iPatternStrength=8;
iPatternHoleRadius=9;
iPatternFs=10;
iPatternGridChamfer=11;
iPatternVoronoiNoise=12;
iPatternBrickWeight=13;
iPatternColored=14;
PatternStyle_grid = "grid";
PatternStyle_hexgrid = "hexgrid";
PatternStyle_voronoi = "voronoi";
PatternStyle_voronoigrid = "voronoigrid";
PatternStyle_voronoihexgrid = "voronoihexgrid";
PatternStyle_brick = "brick";
PatternStyle_brickoffset = "brickoffset";
PatternStyle_values = [
    PatternStyle_grid, PatternStyle_hexgrid,
    PatternStyle_voronoi, PatternStyle_voronoigrid, PatternStyle_voronoihexgrid, 
    PatternStyle_brick, PatternStyle_brickoffset
    ];
function validatePatternStyle(value, name = "PatternStyle") = 
  assert(list_contains(PatternStyle_values, value), typeerror(name, value))
  value;
PatternFill_none = "none";
PatternFill_space = "space";
PatternFill_crop = "crop";
PatternFill_crophorizontal = "crophorizontal";
PatternFill_cropvertical = "cropvertical";
PatternFill_crophorizontal_spacevertical = "crophorizontal_spacevertical";
PatternFill_cropvertical_spacehorizontal = "cropvertical_spacehorizontal";
PatternFill_spacevertical = "spacevertical";
PatternFill_spacehorizontal = "spacehorizontal";
PatternFill_values = [PatternFill_none, PatternFill_space, PatternFill_crop, PatternFill_crophorizontal, PatternFill_cropvertical, PatternFill_crophorizontal_spacevertical, PatternFill_cropvertical_spacehorizontal, PatternFill_spacevertical, PatternFill_spacehorizontal];
function validatePatternFill(value, name = "PatternFill") = 
  assert(list_contains(PatternFill_values, value), typeerror(name, value))
  value;
function PatternSettings(
    patternEnabled, 
    patternStyle, 
    patternRotate = false,
    patternFill,
    patternBorder = -1, 
    patternDepth = 0,
    patternCellSize, 
    patternHoleSides,
    patternStrength, 
    patternHoleRadius,
    patternFs = 0,
    patternGridChamfer=0,
    patternVoronoiNoise=0,
    patternBrickWeight=0,
    patternColored="disabled"
    ) = 
  let(
    result = [
      patternEnabled,
      patternStyle,
      patternRotate,
      patternFill,
      patternBorder,
      patternDepth,
      is_num(patternCellSize) ? [patternCellSize, patternCellSize] : patternCellSize,
      patternHoleSides,
      is_num(patternStrength) ? [patternStrength, patternStrength] : patternStrength,
      patternHoleRadius,
      patternFs,
      patternGridChamfer,
      patternVoronoiNoise,
      patternBrickWeight,
      patternColored
      ],
    validatedResult = ValidatePatternSettings(result)
  ) validatedResult;
function ValidatePatternSettings(settings, num_x, num_y) =
  assert(is_list(settings), "Settings must be a list")
  assert(len(settings)==15, "Settings must length 15")
  assert(is_bool(settings[iPatternEnabled]), "settings[iPatternEnabled] must be a boolean")
  assert(is_string(settings[iPatternStyle]), "settings[iPatternStyle] must be a string")
  assert(is_bool(settings[iPatternRotate]), "settings[iPatternRotate] must be a boolean")
  assert(is_string(settings[iPatternFill]), "settings[iPatternFill] must be a string")
  assert(is_num(settings[iPatternBorder]), "settings[iPatternBorder] must be a non-negative number or -1")
  assert(is_num(settings[iPatternDepth]), "settings[iPatternDepth] must be a number")
  assert(is_list(settings[iPatternCellSize]) && len(settings[iPatternCellSize])==2, "settings[iPatternCellSize] must be a list two positive numbers")
  assert(is_num(settings[iPatternHoleSides]) && settings[iPatternHoleSides] >=  3, "settings[iPatternHoleSides] must be a number >= 3")
  assert(is_list(settings[iPatternStrength]) && len(settings[iPatternStrength])==2 && 
  is_num(settings[iPatternStrength].x) && settings[iPatternStrength].x > 0 && 
  is_num(settings[iPatternStrength].y) && settings[iPatternStrength].y > 0, "settings[iPatternStrength] must be a list of two positive numbers")
  assert(is_num(settings[iPatternHoleRadius]) && settings[iPatternHoleRadius] >= 0, "settings[iPatternHoleRadius] must be a non-negative number")
  assert(is_num(settings[iPatternFs]) && settings[iPatternFs] >= 0, "settings[iPatternFs] must be a non-negative number")
  assert(is_num(settings[iPatternGridChamfer]), "settings[iPatternGridChamfer] must be a number")
  assert(is_num(settings[iPatternVoronoiNoise]) && settings[iPatternVoronoiNoise] >= 0 && settings[iPatternVoronoiNoise] <= 1, "settings[iPatternVoronoiNoise] must be between 0 and 1")
  assert(is_num(settings[iPatternBrickWeight]) && settings[iPatternBrickWeight] >= 0, "settings[iPatternBrickWeight] must be a non-negative number")
    [settings[iPatternEnabled],
      validatePatternStyle(settings[iPatternStyle]),
      settings[iPatternRotate],
      validatePatternFill(settings[iPatternFill]),
      settings[iPatternBorder],
      settings[iPatternDepth],
      settings[iPatternCellSize],
      settings[iPatternHoleSides],
      settings[iPatternStrength],
      settings[iPatternHoleRadius],
      settings[iPatternFs],
      settings[iPatternGridChamfer],
      settings[iPatternVoronoiNoise],
      settings[iPatternBrickWeight],
      settings[iPatternColored]
      ];
function get_wallpattern_positions(
  border,
  heightz,
  positionz,
  wall_thickness,
  wallpattern_thickness,
  wallpattern_walls= [0,0,0,0],
  label_walls = [0,0,0,0],
  label_sizez=0) = 
  let(
      fudgeFactor= 0.01,
      bin_size=[env_numx()*env_pitch().x-env_clearance().x, env_numy()*env_pitch().y-env_clearance().y],
      x_width = bin_size.x-env_corner_radius()*2-border,
      y_width = bin_size.y-env_corner_radius()*2-border, 
      wallpattern_thickness=wallpattern_thickness+fudgeFactor,
      front = [
      //width, height, depth
      [x_width, heightz - (label_walls[0] != 0 ? label_sizez : 0), wallpattern_thickness],
      //Position
      [bin_size.x/2+env_clearance().x/2,  
        env_clearance().y/2+wall_thickness/2-(wall_thickness-wallpattern_thickness)/2, 
        positionz - (label_walls[0] != 0 ? label_sizez : 0)/2],
      //rotation, mirror
      [90,0,0], [0,0,0],
      //enabled
      wallpattern_walls[0]],
    back = [
      //width, height, depth
      [x_width, heightz - (label_walls[1] != 0 ? label_sizez : 0), wallpattern_thickness],
      //Position
      [bin_size.x/2+env_clearance().x/2, 
        bin_size.y+env_clearance().y/2-wall_thickness/2+(wall_thickness-wallpattern_thickness)/2, 
         positionz - (label_walls[1] != 0 ? label_sizez : 0)/2],
      //rotation, mirror
      [90,0,0], [0,1,0],
      //enabled
      wallpattern_walls[1]],
    left = [
      //width, height, depth
      [y_width, heightz - (label_walls[2] != 0 ? label_sizez : 0), wallpattern_thickness],
      //Position
      [env_clearance().x/2+wall_thickness/2-(wall_thickness-wallpattern_thickness)/2,
        bin_size.y/2+env_clearance().y/2, 
        positionz - (label_walls[2] != 0 ? label_sizez : 0)/2],
      //rotation, mirror (for chamfer)
      [90,0,90], [1,0,0],
      //enabled
      wallpattern_walls[2]],
    right = [
      //width, height, depth
      [y_width, heightz - (label_walls[3] != 0 ? label_sizez : 0), wallpattern_thickness],
      //Position
      [bin_size.x+env_clearance().x/2-wall_thickness/2+(wall_thickness-wallpattern_thickness)/2,
        bin_size.y/2+env_clearance().y/2, 
        positionz - (label_walls[3] != 0 ? label_sizez : 0)/2],
      //rotation, mirror (for chamfer)
      [90,0,90], [0,1,0],
      //enabled
      wallpattern_walls[3]],
    ylocations = [left, right],
    xlocations = [front, back])
    [xlocations, ylocations];
// cuts the wall pattern section from the bin walls and replaces them with coloured sections
module coloured_wall_pattern(
  wall_pattern_settings=[], 
  wallpattern_walls=[],
  wall_thickness=1,
  pattern_floor, 
  pattern_height,
  border = 0,
  colored_pattern = false,
){
  colored_pattern = is_string(colored_pattern) ? colored_pattern : (colored_pattern ? "enabled" : "disabled");
  fudgeFactor = 0.001;
  wallpattern_thickness = get_related_value(wall_pattern_settings[iPatternDepth], wall_thickness);
  positions = get_wallpattern_positions(
    border = border,
    heightz = pattern_height,
    positionz = pattern_floor,
    wall_thickness = wall_thickness,
    wallpattern_thickness = wallpattern_thickness,
    wallpattern_walls = wall_pattern_settings[iPatternEnabled] ? wallpattern_walls : [0,0,0,0]);
  locations = [positions.x[0], positions.x[1], positions.y[0], positions.y[1]];
  assert($children == 3, "coloured_wall_pattern expects three children");
  difference(){
    colored_block(colored_pattern){
      children(0);
      //subtracted block
      wall_pattern_canvas_negative(locations, colored_pattern);
      //added blockblock
      wall_pattern_canvas_positive(locations, colored_pattern);
      if($children >=3) children(2);
    }
    // Child 1 is bin cavities and negatives
    if($children >=2) children(1);
  }
}
module wall_pattern_canvas_negative(locations, colored_pattern){
  for(i = [0:1:len(locations)-1])
    if(locations[i][4] > 0)
      translate(locations[i][1])
      rotate(locations[i][2])
      cube([locations[i][0].x,locations[i][0].y,locations[i][0].z+fudgeFactor], center=true);
}
module wall_pattern_canvas_positive(locations, colored_pattern){
  for(i = [0:1:len(locations)-1])
    if(locations[i][4] > 0)
      translate(locations[i][1])
      rotate(locations[i][2]) {
        thickness = locations[i][0].z;
        cube([locations[i][0].x,locations[i][0].y,thickness], center=true);
      }
}
module colored_block(coloured_pattern = "enabled"){
  union(){
    if(coloured_pattern == "enabled"){
      difference(){
        // Child 0 is bin block
        children(0);
        //Subtract the wall pattern block so it can be coloured.
        color(env_colour(color_cup))
        children(1);
      }
      color(env_colour(color_wallcutout, isLip=true))
      //render_conditional(true)
      difference(){
        children(2);
        // Child 3 is wall pattern
        color(env_colour(color_wallcutout, isLip=true))
        children(3);
      }
    } else {
      difference(){
        // Child 0 is bin block
        children(0);
        // Child 3 is wall pattern
        color(env_colour(color_wallcutout, isLip=true))
        children(3);
      }
    }
  }
}
module cutout_pattern(
  patternStyle,
  canvasSize,
  customShape = false,
  circleFn,
  cellSize = [],
  strength,
  holeHeight,
  holeRadius,
  center = true,
  centerz = false,
  fill,
  patternGridChamfer=0,
  patternVoronoiNoise=0,
  patternBrickWeight=0,
  partialDepth = false,
  border = 0,
  patternFs = 0,
  rotateGrid = false,
  source = ""){
  // validate inputs
  assert(is_list(canvasSize) && len(canvasSize) == 2, "canvasSize must be a list of two numbers");
  assert(is_num(canvasSize.x) && canvasSize.x > 0, "canvasSize.x must be a positive number");
  assert(is_num(canvasSize.y) && canvasSize.y > 0, "canvasSize.y must be a positive number");
  assert(is_num(holeHeight) && holeHeight > 0, "holeHeight must be a positive number");
  assert(is_num(holeRadius) && holeRadius >= 0, "holeRadius must be a non-negative number");
  assert(is_num(border) && border >= 0, "border must be a non-negative number");
  assert(is_num(patternFs) && patternFs >= 0, "patternFs must be a non-negative number");
  assert(is_num(patternGridChamfer), "patternGridChamfer must be a number");
  assert(is_num(patternVoronoiNoise) && patternVoronoiNoise >= 0  && patternVoronoiNoise <= 1, "patternVoronoiNoise must be between 0 and 1");
  assert(is_num(patternBrickWeight) && patternBrickWeight >= 0, "patternBrick Weight must be a non-negative number");
  assert(is_list(strength) && len(strength) == 2 && is_num(strength.x) && strength.x > 0 && is_num(strength.y) && strength.y > 0, "strength must be a list of two positive numbers");
  canvasSize = 
    let(cs = rotateGrid ? [canvasSize.y,canvasSize.x] : canvasSize)
    border > 0
    ? [cs.x-border*2, cs.y-border*2]
    : cs;
  function calculate_chamfer(chamfer, thickness, partialDepth) = 
    let(
      _chamfer = is_num(chamfer) ? (partialDepth ? [0, chamfer] : [chamfer, chamfer]) : chamfer,
      dual_chamfer = (_chamfer[0] != 0 && _chamfer[1] != 0) ? 2 : 1)
      [get_related_value(_chamfer.x, thickness/dual_chamfer, 0),get_related_value(_chamfer.y, thickness/dual_chamfer, 0)];
  chamfer = calculate_chamfer(chamfer = patternGridChamfer, thickness=holeHeight, partialDepth=partialDepth);
  //override the FS for the pattern, if required
  $fs = patternFs > 0 ? patternFs : $fs;
  //translate(border>0 ? [border,border,0] : [0,0,0])
  translate(center ? [0,0,0] : [border,border,0])
  translate(centerz ? [0,0,-holeHeight/2] : [0,0,0])
  rotate(rotateGrid ? [0,0,90] : [0,0,0])
  union(){
    if(patternStyle == PatternStyle_grid || patternStyle == PatternStyle_hexgrid) {
      GridItemHolder(
        canvasSize = canvasSize,
        hexGrid = patternStyle == PatternStyle_hexgrid,
        customShape = customShape,
        circleFn = circleFn,
        holeSize = cellSize,
        holeSpacing = strength,
        holeHeight = holeHeight,
        center=center,
        fill=fill, //"none", "space", "crop"
        rotateGrid = true,
        //border = border,
        holeChamfer = chamfer);
    }
    else if(patternStyle == PatternStyle_voronoi || patternStyle == PatternStyle_voronoigrid || patternStyle == PatternStyle_voronoihexgrid){
      if(env_help_enabled("trace")) echo("cutout_pattern", canvasSize = [canvasSize.x,canvasSize.y,holeHeight], thickness = holeSpacing.x, round=1);
      rectangle_voronoi(
        canvasSize = [canvasSize.x,canvasSize.y,holeHeight], 
        spacing = strength.x, 
        cellsize = cellSize.x,
        grid = (patternStyle == PatternStyle_voronoigrid || patternStyle == PatternStyle_voronoihexgrid),
        gridOffset = (patternStyle == PatternStyle_voronoihexgrid),
        noise=patternVoronoiNoise,
        radius = holeRadius,
        center=center,
        seed=env_random_seed());
    }
    else if(patternStyle == PatternStyle_brick || patternStyle == PatternStyle_brickoffset){
      if(env_help_enabled("trace")) echo("cutout_pattern", canvasSize = [canvasSize.x,canvasSize.y,holeHeight], thickness = holeSpacing.x, round=1);
      brick_pattern(
        canvis_size=[canvasSize.x,canvasSize.y],
        thickness = holeHeight,
        spacing=strength.x,
        center=center,
        cell_size = cellSize,
        corner_radius = holeRadius,
        center_weight = patternBrickWeight,
        rotateGrid = true,
        offset_layers = patternStyle == PatternStyle_brickoffset
      );
    }
    else {
      echo("cutout_pattern: Unknown patternStyle", patternStyle=patternStyle);
    }
  }
}
//CombinedEnd from path module_patterns.scad
//Combined from path module_item_holder.scad








griditemholder_demo = false;
if(griditemholder_demo)
{
  GridItemHolder(fill="space", center=true, rotateGrid = true);
  translate([0,50,0])
  GridItemHolder(fill="space", center=true, rotateGrid = false);
  translate([100,0,0])
  GridItemHolder(fill="space", hexGrid=false, rotateGrid = true);
  translate([100,50,0])
  GridItemHolder(fill="space", hexGrid=false, rotateGrid = false);
  translate([0,0,20])
  chamfered_cube(size = [13,20,10], chamfer = 1, cornerRadius = 0);
}
module GridItemHolder(
  canvasSize = [100,50],
  hexGrid = true, //false, true, "auto"
  customShape=false,
  circleFn = 6,
  holeSize = [10,10],
  holeSpacing = [2,2],
  holeGrid = [0,0],
  holeHeight = 3,
  holeChamfer = 0,
  border = 0,
  center=false,
  fill="none", //"none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"
  //crop = true,
  rotateGrid = false) 
{
  assert(is_list(canvasSize) && len(canvasSize)==2, "canvasSize must be list of len 2");
  assert(is_bool(hexGrid) || is_string(hexGrid), "hexGrid must be bool or string");
  assert(is_bool(customShape), "customShape must be bool");    
  assert(is_num(circleFn), "circleFn must be number");    
  assert(is_list(holeSize) && len(holeSize)>=2, "holeSize must be list of len 2");
  assert(is_num(holeSize[0]), "holeSize[0] must be list of number");
  assert(is_num(holeSize[1]), "holeSize[1] must be list of number");
  assert(is_list(holeSpacing) && len(holeSpacing)==2, "holeSpacing must be list of len 2");
  assert(is_list(holeGrid) && len(holeGrid)==2, "canvasSize must be list of len 2");  
  assert(is_num(holeHeight), "holeHeight must be number");    
  assert(is_num(border), "border must be number");    
  assert(is_string(fill), "fill must be a string");
  assert(is_bool(rotateGrid), "rotateGrid must be bool");  
  //holeChamfer = let(chamfer = is_num(holeChamfer) ? [0, holeChamfer] : holeChamfer) [min(chamfer.x,holeHeight/2),min(chamfer.y,holeHeight/2)];
  function calculate_chamfer(chamfer, thickness) = 
    let(
      _chamfer = is_num(chamfer) ? [0, chamfer] : chamfer,
      dual_chamfer = (_chamfer[0] != 0 && _chamfer[1] != 0) ? 2 : 1)
      [get_related_value(_chamfer.x, thickness/dual_chamfer, 0),get_related_value(_chamfer.y, thickness/dual_chamfer, 0)];
  holeChamfer= calculate_chamfer(chamfer=holeChamfer,thickness=holeHeight);
  assert(is_list(holeChamfer), "holeChamfer must be list");  
  fudgeFactor = 0.01;
  //Sides, 
  // 0 is circle
  // 4 is square
  // 6 is hex
  //Rc, outer radius is the shape
  //Ri. inner radius of the shape.
  //Ri=Rc * Cos(180/sides)
  Rc = circleFn<=2 || circleFn>16 ? holeSize[0]/2 : (holeSize[0]/2)/cos(180/circleFn);
  //For hex in a hex grid we can optomise the spacing, otherwise its too hard      
  Ri = holeSize[0]/2;//(circleFn==6 && hexGrid) || (circleFn==4) ? (holeSize[0]/2) : Rc;
  _canvasSize = 
    let (cs = rotateGrid ? [canvasSize.y,canvasSize.x] : canvasSize)
      border > 0 ? 
        [cs.x-border*2,cs.y-border*2] : 
        cs;
  calcHoledimensions = [
      customShape ? holeSize[0] :
      circleFn == 4 ? Rc*2 : 
      circleFn == 6 ? Rc*2 : Rc*2,
      customShape ? holeSize[1] :
      circleFn == 4 ? Rc*2 : 
      circleFn == 6 ? Ri*2 : Rc*2];
        //x spacing for hex, center to center 
  hexxSpacing = 
    circleFn == 4 ? holeSpacing[1]/2 + calcHoledimensions[1]/2
    : customShape ? holeSize[0]+holeSpacing[0]
    : sqrt((Ri*2+holeSpacing[0])^2-((calcHoledimensions[1]+holeSpacing[1])/2)^2);
  //Calculate the x and y items count for hexgrid
  eHexGrid = [
      holeGrid[0] !=0 ? holeGrid[0]
        : floor((_canvasSize[0]-calcHoledimensions[0])/hexxSpacing+1), 
      holeGrid[1] !=0 ? holeGrid[1]
        : floor(((_canvasSize[1]+holeSpacing[1])/(calcHoledimensions[1]+holeSpacing[1])-0.5)*2)/2
      ];
  //Calculate the x and y hex items count for squaregrid
  eSquareGrid = [
      holeGrid[0]!=0 ? holeGrid[0]
        : floor((_canvasSize[0]+holeSpacing[0])/(calcHoledimensions[0]+holeSpacing[0])),
      holeGrid[1]!=0 ? holeGrid[1]
        : floor((_canvasSize[1]+holeSpacing[1])/(calcHoledimensions[1]+holeSpacing[1]))];
  //Single lines should not be hex
  hexGrid = 
    _canvasSize.x<=holeSize.x+holeSpacing.x || 
    _canvasSize.y<=holeSize.y+holeSpacing.y ||
    holeGrid.x ==1 || holeGrid.y ==1 ? false : hexGrid;
  if(env_help_enabled("trace")) echo("GridItemHolder", eHexGrid0 =eHexGrid[0], eHexGrid1 = eHexGrid[1], mod=eHexGrid[0]%2);
  hexGridCount = let(count = eHexGrid[0]*eHexGrid[1]) eHexGrid[0] % 2 == 0 ? floor(count) : ceil(count);
  squareCount = eSquareGrid[0]*eSquareGrid[1];
  _hexGrid = hexGrid != "auto" ? hexGrid //if not auto use what was chose
          : hexGridCount == squareCount ? false //if equal prefer square
          : hexGridCount > squareCount;
  if(env_help_enabled("info")) echo(str("🟩ItemGrid: count ", _hexGrid?hexGridCount:squareCount, " using grid ", _hexGrid?"hex":"square"), input=hexGrid==true?"hex":hexGrid==false?"square":hexGrid, hexGridCount=hexGridCount, squareCount=squareCount);
  translate(center ? [0, 0, 0] : [(rotateGrid?canvasSize.x:0)+ border, border, 0])
  //translate(rotateGrid && !center ?[canvasSize.x,0,0]:[0,0,0])
  rotate(rotateGrid?[0,0,90]:[0,0,0])
  intersection(){
    //Crop to ensure that we dont go outside the bounds 
    if(fill == "crop" || fill == "crophorizontal"  || fill == "cropvertical"  || fill ==  "crophorizontal_spacevertical"  || fill == "cropvertical_spacehorizontal")
      translate([-fudgeFactor,-fudgeFactor,(center?holeHeight/2:0)-fudgeFactor])
      cube([_canvasSize[0]+fudgeFactor*2,_canvasSize[1]+fudgeFactor*2,holeHeight+fudgeFactor*2], center = center);
    if(_hexGrid){
      //x and y spacing including the item size.
      es = [
        fill == "space" || fill == "spacevertical" ||fill == "crophorizontal_spacevertical"
          ? calcHoledimensions[0]+(eHexGrid[0]<=1?0:((_canvasSize[0]-eHexGrid[0]*calcHoledimensions[0])/(eHexGrid[0]-1))) 
          : hexxSpacing,
        fill == "space" || fill == "spacehorizontal" ||fill == "cropvertical_spacehorizontal"
          ? calcHoledimensions[1]+(eHexGrid[1]<=0.5?0:((_canvasSize[1]-(eHexGrid[1]+0.5)*calcHoledimensions[1])/(eHexGrid[1]-0.5))) 
          : holeSpacing[1] + calcHoledimensions[1]];
      eFill=[
        fill == "crop" || fill == "cropvertical" || fill == "cropvertical_spacehorizontal"
          ? eHexGrid[0]+2 : eHexGrid[0],
        fill == "crop" || fill == "crophorizontal" || fill == "crophorizontal_spacevertical"
          ? eHexGrid[1]+2 : eHexGrid[1]];
      /*Grid(4)Text($pos.xy,size=3);
      // Grid but with alternating row offset - hex or circle packing
      HexGrid()circle(d=$es.y);
      HexGrid()circle(d=Umkreis(6,$d-.1),$fn=6);
      HexGrid() children(); creates an interlaced grid of children
      \param e elements [x,y]
      \param es element spacing [x,y]
      \param center true/false or -7 ⇔ 7 for x shift
      \param $d $r $es $idx $idx2 $pos output for children
      \param name help  name help
      module HexGrid(e=[11,4],es=5,center=true,name,help){
      */
      HexGrid(e=eFill, es=es, center=center)
        if(customShape){
          translate(center ? [-calcHoledimensions[0]/2,-calcHoledimensions[1]/2,0] : [0,0,0])
            children();
        } else {
          translate(!center ? [calcHoledimensions[0]/2,calcHoledimensions[1]/2,0] : [0,0,0])
            chamferedCylinder(h=holeHeight, r=Rc, bottomChamfer=holeChamfer[0], topChamfer=holeChamfer[1], circleFn = circleFn);
        }
    }
    else {
      es = [
        fill == "space" || fill == "spacevertical" || fill == "crophorizontal_spacevertical"
          ? calcHoledimensions[0]+(eSquareGrid[0]<=1?0:((_canvasSize[0]-eSquareGrid[0]*calcHoledimensions[0])/(eSquareGrid[0] - (center ? 0.5 :1))))
          : calcHoledimensions[0]+holeSpacing[0],
        fill == "space" || fill == "spacehorizontal" ||fill == "cropvertical_spacehorizontal"
          ? calcHoledimensions[1]+(eSquareGrid[1]<=1?0:((_canvasSize[1]-eSquareGrid[1]*calcHoledimensions[1])/(eSquareGrid[1] - (center ? 0.5 :1))))
          : calcHoledimensions[1]+holeSpacing[1]];
      eFill=[
        fill == "crop" || fill == "cropvertical" || fill == "cropvertical_spacehorizontal"
          ? eSquareGrid[0]+2 : eSquareGrid[0],
        fill == "crop" || fill == "crophorizontal" || fill == "crophorizontal_spacevertical"
          ? eSquareGrid[1]+2 : eSquareGrid[1]];
      /*Grid() children(); creates a grid of children
      \param e elements [x,y]
      \param es element spacing [x,y]
      \param s total space ↦ es
      \param center true/false 
      // multiply children in a given matrix (e= number es =distance)
      module Grid(e=[2,2,1],es=10,s,center=true,name,help)
      */
      Grid(e=eFill, es=es, center=center)
        if(customShape){
          translate(center ? [-calcHoledimensions[0]/2,-calcHoledimensions[1]/2,0] : [0,0,0])
          children();
        } else {
          translate(center ? [0,0,0] : [calcHoledimensions[0]/2,calcHoledimensions[1]/2,0])
            chamferedCylinder(h=holeHeight, r=Rc, bottomChamfer=holeChamfer[0], topChamfer=holeChamfer[1], circleFn = circleFn);
        }
    }
  }
  HelpTxt("GridItemHolder",[
    "canvasSize",canvasSize
    ,"_canvasSize",_canvasSize
    ,"circleFn",circleFn
    ,"hexGrid",hexGrid
    ,"holeSize",holeSize
    ,"holeSpacing",holeSpacing
    ,"holeGrid",holeGrid
    ,"center",center
    ,"fill",fill
    ,"customShape",customShape
    ,"hexxSpacing",hexxSpacing
    ,"calcHoledimensions",calcHoledimensions
    ,"eHexGrid",eHexGrid
    ,"eSquareGrid",eSquareGrid  
    ,"hexGridCount",hexGridCount  
    ,"squareCount",squareCount  
     ,"Rc",Rc
    ,"Ri",Ri]
    ,env_help_enabled("info"));
}
module multiCard(longCenter, smallCenter, side, chamfer = 1, alternate = false){
  fudgeFactor = 0.01;
  assert(is_list(longCenter) && len(longCenter) >= 3, "longCenter should be a list of length 5");
  assert(is_list(smallCenter) && len(smallCenter) >= 3, "longCenter should be a list of length 5");
  assert(is_list(side) && len(side) >= 3, "longCenter should be a list of length 5");
  iitemDiameter= 0;
  iitemx = 1;
  iitemy = 2;
  idepthneeded = 3;
  iitemHeight = 4;
  ishape = 5;
  if(env_help_enabled("trace")) echo(longCenter=longCenter,smallCenter=smallCenter,side=side,chamfer=chamfer,alternate=alternate);
  render() //Render on item holder multiCard as it can be complex
  union(){
    minspacing = 3;
    translate([(longCenter[iitemx])/2,side[iitemx]/2,0])
    union(){
    translate([-(longCenter[iitemx])/2,-longCenter[iitemy]/2,0])
    chamfered_cube([longCenter[iitemx], longCenter[iitemy], longCenter[idepthneeded]+fudgeFactor], chamfer);
    translate([-smallCenter[iitemx]/2,-smallCenter[iitemy]/2,(longCenter[idepthneeded]-smallCenter[idepthneeded])])
    chamfered_cube([smallCenter[iitemx], smallCenter[iitemy], smallCenter[idepthneeded]+fudgeFactor], chamfer);
    if(alternate){
      pos = let(targetPos = (longCenter[iitemx])/4-(side[iitemy])/2) max(targetPos, smallCenter[iitemy]+minspacing);
      translate([-pos-side[iitemy]/2, 0, 0])
        rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamfered_cube([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
      translate([+pos+side[iitemy]/2, 0, 0])
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamfered_cube([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
    } else {
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamfered_cube([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
      translate([-(longCenter[iitemx])/2+(side[iitemy])/2, 0, 0])
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamfered_cube([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
      translate([(longCenter[iitemx])/2-(side[iitemy])/2, 0, 0])
      rotate([0,0,90])
        translate([-(side[iitemx])/2,-(side[iitemy])/2,(longCenter[idepthneeded]-side[idepthneeded])])
        chamfered_cube([side[iitemx], side[iitemy], side[idepthneeded]+fudgeFactor], chamfer);
      }
    }
  }
}
//CombinedEnd from path module_item_holder.scad
//Combined from path ub_hexgrid.scad






// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad
/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/
/** \name Grid \page Modifier
Grid() children(); creates a grid of children
\param e elements [x,y]
\param es element spacing [x,y]
\param s total space ↦ es
\param center true/false 
*/
// multiply children in a given matrix (e= number es =distance)
module Grid(e=[2,2,1],es=10,s,center=true,name,help){
     name=is_undef(name)?is_undef($info)?false:
                                                   $info:
                                   name;
    function n0(e)=is_undef(e)?1:max(round(e),0);
    function n0s(e)=max(e-1,1);// e-1 must not be 0
    center=is_list(center)?v3(center):[center,center,center];
    e=is_list(e)?is_num(e[2])?[max(round(e[0]),0),max(round(e[1]),0),n0(e[2])]:
                    [round(e.x),round(e.y),1]: // z = 1
        es[2]?[n0(e),n0(e),n0(e)]:
        [n0(e),n0(e),1];
    es=is_undef(s)?is_list(es)?is_num(es[2])?es:
                                concat(es,[0]):
                    is_undef(es)?[0:0:0]:
                        [es,es,es]:
       is_list(s)?is_num(s[2])?[s[0]/n0s(e[0]),s[1]/n0s(e[1]),s[2]/n0s(e[2])]:
                    [s[0]/n0s(e[0]),s[1]/n0s(e[1]),0]:
        [s/n0s(e[0]),s/n0s(e[1]),s/n0s(e[2])];
   MO(!$children);
   InfoTxt("Grid",[str("Gridsize(",e,")"),str(e[0]*e[1]*e[2]," elements= ",(e[0]-1)*es[0],"×",(e[1]-1)*es[1],"×",(e[2]-1)*es[2],"mm \n element spacing= ",es," mm",
    center.x?str("\n\tX ",-(e[0]-1)*es[0]/2," ⇔ ",(e[0]-1)*es[0]/2," mm"):"",
    center.y?str("\n\tY ",-(e[1]-1)*es[1]/2," ⇔ ",(e[1]-1)*es[1]/2," mm"):"",
    center.z?str("\n\tZ ",-(e[2]-1)*es[2]/2," ⇔ ",(e[2]-1)*es[2]/2," mm"):"")
    ],name);  
    HelpTxt("Grid",[
    "e",e
    ,"es",es
    ,"s",[(e[0]-1)*es[0],(e[1]-1)*es[1],(e[2]-1)*es[2]]
    ,"center",center
    ,"name",name]
    ,help);
    centerPos=[
   center.x?((1-e[0])*es[0])/2:0,
   center.y?((1-e[1])*es[1])/2:0,
   center.z?((1-e[2])*es[2])/2:0];
   if(e.x&&e.y&&e.z) for(x=[0:e[0]-1],y=[0:e[1]-1],z=[0:e[2]-1]){
       $idx=[x,y,z];
       $idx2=[e.y*e.x*z+e.y*y+x,e.y*e.x*z+e.x*x+y];
       $pos=[x*es.x,y*es.y,z*es.z]+centerPos;
       $info=norm($idx)?false:name;
       $tab=is_undef($tab)?1:b($tab,false)+1;
       $es=es;
      // $helpM=norm($idx)?false:$helpM;
       translate([x*es[0],y*es[1],z*es[2]]+centerPos)children();
   }
}
//Grid(4)Text($pos.xy,size=3);
// Grid but with alternating row offset - hex or circle packing
//HexGrid()circle(d=$es.y);
//HexGrid()circle(d=Umkreis(6,$d-.1),$fn=6);
/** \name HexGrid \page Modifier
HexGrid() children(); creates an interlaced grid of children
\param e elements [x,y] e+.1 or -.1 will change the pattern
\param es element spacing [x,y]
\param center true/false or -7 ⇔ 7 for x shift
\param $d $r $es $idx $idx2 $pos output for children
\param name help  name help
*/
module HexGrid(e=[11,4],es=5,center=true,name,help){
  es=is_list(es)?es:[es*sin(60),es];
  e=is_list(e)?e:[e,e,1];
  $d=es.y;
  $r=$d/2;
  icenter=abs(b(center,bool=false));
  //shifting for center and pattern change
  yCor=(is_undef(useVersion)||useVersion>23.300)&&icenter?-es.y/4:0;
  shift=[0,e.y>round(e.y)?-es.y/2:e.y<round(e.y)?0:yCor]+sign(b(center,bool=false))*(
     icenter==2?[es.x/2,0]
    :icenter==3?[es.x/3,0]
    :icenter==4?[es.x,0]
    :icenter==5?[es.x*2/3,0]
    :icenter==6?[es.x*1/6,0]
    :icenter==7?[es.x/(2/3),0]
    :[0,0]);
    Grid(e=e,es=es,center=center,name=name)
      translate([shift.x,shift.y+( // shift for center and pattern
        $idx[0]%2?is_list(es)?es[1]/2:es/2:
                  0)
      ]){
// calculating $pos for post processing
    $pos=$pos+[shift.x,shift.y+($idx[0]%2?is_list(es)?es[1]/2
                                                      :es/2
                                          :0),0];
// pattern change by omiting elementst
    if(e.y%1){
      if(e.y<round(e.y)?$idx.y<round(e.y)-1||($idx.x+1)%2
                       :$idx.y>0||($idx.x)%2)children();
      }
    else children();
    }
    MO(!$children);
// info of Grid will be used additional for changed pattern this:
  if(e.y%1)InfoTxt("HexGrid",["elements",round(e.x)*round(e.y)*(e.z?e.z:1) 
    - (e.y<round(e.y)?floor(round(e.x)/2):ceil(round(e.x)/2))
    ],name);
  HelpTxt("HexGrid",[
    "e",e
    ,"es",es
    ,"center",center
    ,"name",name]
    ,help);
}
//CombinedEnd from path ub_hexgrid.scad
//Combined from path module_chamfered_shapes.scad




// Creates a slot with a small chamfer for easy insertertion
//#slotCutout(100,20,40);
//width = width of slot
//depth = depth of slot
//height = height of slot
//chamfer = chamfer size
module chamfered_cube(
  size = [10,10,10], 
  chamfer=0, topChamfer = 0, bottomChamfer = 0, 
  cornerRadius = 0, topRadius=0, bottomRadius=0,
  centerxy = false)
{
  assert(is_list(size) && len(size) == 3, "size should be a list of length 3");
  assert(is_num(chamfer), "chamfer should be a number");
  assert(is_num(topChamfer), "topChamfer should be a number");
  assert(is_num(bottomChamfer), "bottomChamfer should be a number");
  topChamfer = min(size.z, chamfer > 0 ? chamfer : topChamfer);
  bottomChamfer = min(size.z, chamfer > 0 ? chamfer : bottomChamfer);
  bottomRadius = min(bottomRadius, cornerRadius);
  topRadius = min(topRadius, cornerRadius);
  // echo("chamfered_cube", size=size, topChamfer=topChamfer, bottomChamfer=bottomChamfer);
  fudgeFactor = 0.01;
  chamfer = min(size.z, chamfer);
  translate(centerxy ? [-size.x/2, -size.y/2, 0] : [0,0,0])
  union(){
    roundedCube(
      size=size,
      topRadius = topRadius,
      bottomRadius = bottomRadius,
      sideRadius = cornerRadius);
    if(topChamfer > 0)
       translate([0,0,size.z+fudgeFactor-topChamfer-cornerRadius])
       chamferedRectangleTop(size=size, chamfer=topChamfer, cornerRadius=cornerRadius);
    if(bottomChamfer > 0)
       translate([0,0,bottomChamfer])
       mirror([0,0,1])
       chamferedRectangleTop(size=size, chamfer=bottomChamfer, cornerRadius=cornerRadius);
  }
}
module chamferedRectangleTop(size, chamfer, cornerRadius){
  fudgeFactor = 0.01;
  chamferFn = cornerRadius > 0 ? $fn : 4;
  //champherExtention caused errors in slat wall, Need to find the scenario it was needed to debug. For now disabled.
  //when the chamferFn value is 4 we need to change the formula as the radius is corner to corner not edge to edge.
  champherExtention = 0;// cornerRadius > 0 ? 0 : (min(size.x,size.y,size.z)-chamfer)/4;
  conesizeTop = chamfer+cornerRadius+champherExtention;
  conesizeBottom = conesizeTop>size.z ? conesizeTop-size.z: 0;
  //echo("chamferedRectangleTop", size=size, chamfer=chamfer, cornerRadius=cornerRadius, champherExtention=champherExtention, conesizeTop=conesizeTop, conesizeBottom=conesizeBottom);
  //if cornerRadius = 0, we can further increase the height of the 'cone' so we can extend inside the shape
  hull(){
    translate([cornerRadius+champherExtention/2,cornerRadius+champherExtention/2,conesizeBottom-champherExtention])
      rotate([0,0,45])
      cylinder(h=conesizeTop-conesizeBottom,r2=conesizeTop,r1=conesizeBottom,$fn=chamferFn);
    translate([size.x-cornerRadius-champherExtention/2,cornerRadius+champherExtention/2,conesizeBottom-champherExtention])
    rotate([0,0,45])
      cylinder(h=conesizeTop-conesizeBottom,r2=conesizeTop,r1=conesizeBottom,$fn=chamferFn);
    translate([cornerRadius+champherExtention/2,size.y-cornerRadius-champherExtention/2,conesizeBottom-champherExtention])
    rotate([0,0,45])
      cylinder(h=conesizeTop-conesizeBottom,r2=conesizeTop,r1=conesizeBottom,$fn=chamferFn);
    translate([size.x-cornerRadius-champherExtention/2,size.y-cornerRadius-champherExtention/2,conesizeBottom-champherExtention])
    rotate([0,0,45])
      cylinder(h=conesizeTop-conesizeBottom,r2=conesizeTop,r1=conesizeBottom,$fn=chamferFn);          
  }
}
module chamferedHalfCylinder(h, r, circleFn, chamfer=0.5) {
  fudgeFactor = 0.01;
  chamfer = min(h, chamfer);
  translate([0,-h/2,r])
  union(){
    rotate([-90,0,0])
    difference(){
      cylinder(h=h, r=r, $fn = circleFn);
      translate([-r-fudgeFactor,-r,-fudgeFactor])
      cube([(r+fudgeFactor)*2,r,h+fudgeFactor*2]);
    }
    if(r>0)
      translate([-r, 0, -chamfer+fudgeFactor]) 
      chamferedRectangleTop(size=[r*2,h,r], chamfer=chamfer, cornerRadius=0);
  }
}
module chamferedCylinder(h, r, circleFn, chamfer=0, topChamfer = 0.5, bottomChamfer = 0) {
  topChamfer = min(h, chamfer > 0 ? chamfer : topChamfer);
  bottomChamfer = min(h, chamfer > 0 ? chamfer : bottomChamfer);
  union(){
    cylinder(h=h, r=r, $fn = circleFn);
    if(topChamfer >0)
      translate([0, 0, h-topChamfer]) 
      cylinder(h=topChamfer, r1=r, r2=r+topChamfer,$fn = circleFn);
    if(bottomChamfer >0)
      cylinder(h=bottomChamfer, r1=r+bottomChamfer, r2=r,$fn = circleFn);
  }
}
//CombinedEnd from path module_chamfered_shapes.scad
//Combined from path module_pattern_voronoi.scad


/**
* m_transpose.scad
* use <../matrix/m_transpose.scad>
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-m_transpose.html
**/
function m_transpose(m) =
  let(
    column = len(m[0]),
    row = len(m)
  )
  [
    for(y = 0; y < column; y = y + 1)
    [
      for(x = 0; x < row; x = x + 1)
      m[x][y]
    ]
  ];
/**
* unit_vector.scad
* use <../util/unit_vector.scad>
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
**/
function unit_vector(v) = v / norm(v);
/**
* vrn2_from.scad
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_from.html
**/
module vrn2_from(points, spacing = 1, r = 0, delta = 0, chamfer = false, region_type = "square") {
    transposed = m_transpose(points);
    xs = transposed[0];
    ys = transposed[1];
    region_size = max([max(xs) -  min(xs), max(ys) -  min(ys)]);    
    half_region_size = 0.5 * region_size; 
    offset_leng = spacing * 0.5 + half_region_size;
    module region(pt) {
        intersection_for(p = [for(p = points) if(pt != p) p]) {
            v = p - pt;
            translate((pt + p) / 2 - unit_vector(v) * offset_leng)
            rotate(atan2(v.y, v.x))
                children();
        }
    }    
    module offseted_region(pt) {
        if(r != 0) {
            offset(r) 
            region(pt) 
                children();
        }
        else {
            offset(delta = delta, chamfer = chamfer) 
            region(pt) 
                children();
        }     
    }
    for(p = points) {	
        if(region_type == "square") {
            offseted_region(p)
                square(region_size, center = true);
        }
        else {
            offseted_region(p)
                circle(half_region_size);
        }
    }
}
module rectangle_voronoi(
   canvasSize = [200,200,10],
   points=[],
   cellsize=10,
   noise=0.5, 
   grid=false,
   gridOffset = false,
   spacing = 2, 
   radius = 0.5,
   seed = undef,
   center=true)
{
  _spacing = spacing + radius*2;
  points = points != undef && is_list(points) && len(points) > 0 
    ? points 
    : grid ?
     let(
      _pointCount = [ceil(canvasSize.x/cellsize)+1,ceil(canvasSize.y/cellsize)+1],
      seed = seed == undef ? rands(0, 100000, 2)[0] : seed,
      seeds = rands(0, 100000, 2, seed), // you need a different seed for x and y
      pointsx = rands(-cellsize/2*noise, cellsize/2*noise, _pointCount.x*_pointCount.y, seeds[0]),
      pointsy = rands(-cellsize/2*noise, cellsize/2*noise, _pointCount.x*_pointCount.y, seeds[1])
    )[for(i = [0:_pointCount.x-1], y = [0:_pointCount.y-1]) 
        [i*cellsize + pointsx[i+y*_pointCount.x]-canvasSize.x/2 + (y % 2 == 0 && gridOffset ? cellsize/2 : 0),
          y*cellsize + pointsy[i*_pointCount.y+y]-canvasSize.y/2]]
    : let(
      _pointCount = max((canvasSize.x * canvasSize.y)/(cellsize^2), 30),
      seed = seed == undef ? rands(0, 100000, 2)[0] : seed,
      seeds = rands(0, 100000, 2, seed), // you need a different seed for x and y
      pointsx = rands(-canvasSize.x/2, canvasSize.x/2, _pointCount, seeds[0]),
      pointsy = rands(-canvasSize.y/2, canvasSize.y/2, _pointCount, seeds[1])
    )[for(i = [0:_pointCount-1]) [pointsx[i],pointsy[i]]];
  translate(center ? [0, 0, 0] : [canvasSize.x/2, canvasSize.y/2, 0])
  intersection() {
    translate([0,0,canvasSize.z/2])
      cube(size = [canvasSize.x,canvasSize.y,canvasSize.z*2], center=true);
    linear_extrude(height = canvasSize.z)
      vrn2_from(
        points, 
        spacing=_spacing,
        chamfer=false,
        delta=0,
        r=radius, 
        region_type = "square");
  }
}
//CombinedEnd from path module_pattern_voronoi.scad
//Combined from path module_pattern_brick.scad






module brick_pattern(
  canvis_size=[31,31],
  thickness = 1,
  spacing = 1,
  border = 0,
  cell_size = [15,5],
  corner_radius = 3,
  center_weight = 3,
  offset_layers = false,
  center = true,
  rotateGrid = false){
  assert(is_list(canvis_size) && len(canvis_size) == 2, "canvis_size must be a list of len 2");
  assert(is_num(thickness), "thickness must be a number");
  assert(is_num(spacing), "spacing must be a number");
  assert(is_num(border), "border must be a number");
  assert(is_list(cell_size) && len(cell_size) == 2, "cell_size must be a list of len 2");
  assert(is_num(corner_radius), "corner_radius must be a number");
  assert(is_num(center_weight), "center_weight must be a number");
  assert(is_bool(offset_layers), "offset_layers must be a bool");
  assert(is_bool(center), "center must be a bool");
  assert(is_bool(rotateGrid), "rotateGrid must be a bool");
  corner_radius = min(corner_radius,cell_size.x/2, cell_size.y/2);
  working_canvis_size = 
    let (cs = rotateGrid ? [canvis_size.y,canvis_size.x] : canvis_size)
    border > 0 ? [cs.x-border*2,cs.y-border*2] : cs;
  ny = floor((working_canvis_size.y + spacing) / (cell_size.y + spacing));
  nx = floor((working_canvis_size.x + spacing) / (cell_size.x + spacing));
  function course(canvis_length, count, spacing, center_weight, half_offset=false) = 
    let(c = count - (half_offset ? 0 : 1),
    l = [for (i=[0:c]) 
    (((canvis_length+spacing)/(c) + cos((i)*360/(c))*-1*center_weight)/(half_offset && (i==0 || i==c) ? 2 : 1) - spacing)],
    suml = sum(l),
    comp = half_offset ? 1 : (canvis_length-(c)*spacing)/suml)
    [for (i=[0:c]) l[i]*comp];
  if(ny> 0 && nx > 0)
  translate(center ? [0,0,0] : [canvis_size.x/2,canvis_size.y/2,0])
  rotate(rotateGrid?[0,0,90]:[0,0,0])
  translate([-working_canvis_size.x/2,-working_canvis_size.y/2])
  for(iy=[0:ny-1]){
    let(h=(working_canvis_size.y + spacing)/ny-spacing)
    translate([0,(h+spacing)*iy])
    {
      bricks = course(canvis_length=working_canvis_size.x, count=nx, spacing=spacing, center_weight=center_weight, half_offset=offset_layers && iy%2==1);
      for(ix=[0:len(bricks)-1]) {
        pos = sum(bricks, end = ix-1) + spacing*ix;
        size = [bricks[ix], h, thickness];
        if(size.x > min(cell_size.x,cell_size.y)*0.5 && size.y > min(cell_size.x,cell_size.y)*0.5)
          translate([pos,0])
          roundedCube(
            size = size, 
            sideRadius = corner_radius,
            //supportReduction_x = [0,1]
            //supportReduction_y = [0,0],
            //supportReduction_z = [0,0]
            );
      }
    }
  }
}
//CombinedEnd from path module_pattern_brick.scad
//Combined from path module_gridfinity_label.scad






labeldemo = false;
if(labeldemo == true){
  //demo of the label voids
  // https://github.com/ndevenish/gflabel
  label_gflabel_socket();
  // https://github.com/CullenJWebb/Cullenect-Labels
  translate([0,15,0])
  label_cullenect_socket($fn = 64);
  // https://makerworld.com/en/models/446624#profileId-849444
  translate([0,30,0])
  label_cullenect_legacy_socket($fn = 64);
  //https://www.printables.com/model/592545-gridfinity-bin-with-printable-label-by-pred-parametric
  translate([0,45,0])
  label_pred_socket($fn = 64);
}
ilabelWall_Width=0;
ilabelWall_Position=1;
ilabelWall_Rotation=2;
ilabelWall_SeparatorConfig=3;
ilabelWall_Reversed=4;
iLabelSettings_style = 0;
iLabelSettings_position = 1;
iLabelSettings_size = 2;
iLabelSettings_relief = 3;
iLabelSettings_walls = 4;
LabelStyle_disabled = "disabled";
LabelStyle_normal = "normal";
LabelStyle_cullenect = "cullenect";
LabelStyle_cullenectlegacy = "cullenect_legacy";
LabelStyle_gflabel = "gflabel";
LabelStyle_pred = "pred";
LabelStyle_values = [LabelStyle_disabled,LabelStyle_normal,LabelStyle_cullenect,LabelStyle_cullenectlegacy,LabelStyle_gflabel,LabelStyle_pred];
function validateLabelStyle(value) = 
  assert(list_contains(LabelStyle_values, value), typeerror("LabelStyle", value))
  value;
LabelPosition_left = "left";
LabelPosition_center = "center";
LabelPosition_right = "right";
LabelPosition_leftchamber = "leftchamber";
LabelPosition_rightchamber = "rightchamber";
LabelPosition_centerchamber = "centerchamber";
LabelPosition_values = [LabelPosition_left,LabelPosition_center,LabelPosition_right,LabelPosition_leftchamber,LabelPosition_rightchamber,LabelPosition_centerchamber];
function validateLabelPosition(value) = 
  assert(list_contains(LabelPosition_values, value), typeerror("LabelPosition", value))
  value;
function calculateLabelSize(label_size) = 
    assert(is_list(label_size), "label_size must be a list")
    let(
      labelxtemp = is_num(label_size) ? label_size : is_list(label_size) && len(label_size) >= 1 ? label_size.x : 0,
      labelx = labelxtemp <= 0 ? 0 : labelxtemp,
      labelytemp = is_list(label_size) && len(label_size) >= 2 ? label_size.y : 0,
      labely = labelytemp <= 0 ? 14 : labelytemp,
      labelztemp = is_list(label_size) && len(label_size) >= 3 ? label_size.z : 0,
      labelz = labelztemp == -1 ? labely*3/4 : labelztemp == 0 ? labely : labelztemp,
      labelrtemp = is_list(label_size) && len(label_size) >= 4 ? label_size[3] : 0,
      labelr = labelrtemp <= 0 ? 0.6 : labelrtemp)
        [labelx,labely,labelz,labelr];
function LabelSettings(
    labelStyle= "normal", 
    labelPosition="left", 
    // Width, Depth, Height, Radius.   
    labelSize=[0,14,0,0.6],
    // Size in mm of relief where appropiate. Width, depth, height, radius
    labelRelief=[0,0,0,0.6],
    // wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
    labelWalls=[0,1,0,0]) = 
  let(
    labelRelief = is_num(labelRelief) ? [0,0,labelRelief,0] : labelRelief,
    labelWalls = is_undef(labelWalls) ? [0,1,0,0] : labelWalls,
    result = [
      labelStyle,
      labelPosition,
      labelSize,
      labelRelief,
      labelWalls],
    validatedResult = ValidateLabelSettings(result)
  ) validatedResult;
 function CalculateLabelSocketPosition(label_position, labelSocketSize, label_num_x, socketPadding =  2.65) =  
                label_position == LabelPosition_left || label_position == LabelPosition_leftchamber  ? socketPadding 
                : label_position == LabelPosition_right || label_position == LabelPosition_rightchamber ? label_num_x-labelSocketSize.x-socketPadding
                : label_position == LabelPosition_center || label_position == LabelPosition_centerchamber ? (label_num_x-labelSocketSize.x)/2
                : socketPadding;
function ValidateLabelSettings(settings) =
  assert(is_list(settings) && len(settings)== 5, "Label Settings must be a list of length 5")
  assert(is_list(settings[iLabelSettings_size]) && len(settings[iLabelSettings_size])==4, "Label Settings Size must length 4")
  assert(is_list(settings[iLabelSettings_relief]) && len(settings[iLabelSettings_relief])==4, "Label Settings relief must length 4")
  assert(is_list(settings[iLabelSettings_walls]) && len(settings[iLabelSettings_walls])==4, "Label Settings walls must length 4") [
      validateLabelStyle(settings[iLabelSettings_style]),
      validateLabelPosition(settings[iLabelSettings_position]),
      settings[iLabelSettings_size],
      settings[iLabelSettings_relief],
      settings[iLabelSettings_walls]];
module gridfinity_label(
  num_x,
  num_y,
  zpoint,
  vertical_separator_positions,
  horizontal_separator_positions,
  label_settings,
  render_option = "labelwithsocket", //"label", "socket", "labelwithsocket"
  socket_padding = [0,0,0]
)
{
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(zpoint), "zpoint must be a number");
  assert(is_string(label_position), "label_position must be a string");
  assert(is_string(vertical_separator_positions) || is_list(vertical_separator_positions), "vertical_separator_positions must be a list");
  assert(is_string(horizontal_separator_positions) || is_list(horizontal_separator_positions), "horizontal_separator_positions must be a list");
  label_settings=ValidateLabelSettings(label_settings);
  label_style=label_settings[iLabelSettings_style];
  label_position=label_settings[iLabelSettings_position];
  label_size=calculateLabelSize(label_settings[iLabelSettings_size]);
  label_relief=label_settings[iLabelSettings_relief];
  label_walls =label_settings[iLabelSettings_walls];
  labelSize=label_size;
  //label_style = label_style ? "pred" : "pred";
  labelCornerRadius = labelSize[3];
  frontWall = [
    //width
    num_x*env_pitch().x,
    //Position
    [num_x*env_pitch().x, 0, 0],
    //rotation
    [0,0,180],
    vertical_separator_positions,
    //is reversed
    true,
    "front",
    env_pitch().x];
  backWall = [
    //width
    num_x*env_pitch().x,
    //Position
    [0, num_y*env_pitch().y, 0],
    //rotation
    [0,0,0],
    vertical_separator_positions,
    //is reversed
    false,
    "back",
    env_pitch().x];
  leftWall = [
    //width
    num_y*env_pitch().y,
    //Position
    [0, 0, 0],
    //rotation
    [0,0,90],
    horizontal_separator_positions,
    //is reversed
    false,
    "left",
    env_pitch().y];
  rightWall = [
    //width
    num_y*env_pitch().y,
    //Position
    [num_x*env_pitch().x, num_y*env_pitch().y, 0],
    //rotation
    [0,0,270],
    horizontal_separator_positions,
    //is reversed
    true,
    "right",
    env_pitch().y];
  wallLocations = [frontWall, backWall, leftWall, rightWall];
  color(env_colour(color_label))
  tz(zpoint+fudgeFactor)
  //Loop the sides 
  for(l = [0:1:len(wallLocations)-1]){
    wallLocation = wallLocations[l];
    separator_positions = wallLocation[ilabelWall_SeparatorConfig];//calculateSeparators(wallLocation[3]);
    labelPoints = [[ 0-labelSize.y, -labelCornerRadius],
      [ 0, -labelCornerRadius ],
      [ 0, -labelCornerRadius-labelSize.z ]
    ];
    labelWidthmm = labelSize.x <=0 ? wallLocation[ilabelWall_Width] : labelSize.x * wallLocation[6];
    // Calculate list of chambers. 
    chamberWidths = len(separator_positions) < 1 || 
      labelWidthmm == 0 ||
      label_position == LabelPosition_left ||
      label_position == LabelPosition_center ||
      label_position == LabelPosition_right ?
        [ wallLocation[ilabelWall_Width] ] // single chamber equal to the bin length
        : [ for (i=[0:len(separator_positions)]) 
          (i==len(separator_positions) 
            ? wallLocation[ilabelWall_Width]
            : separator_positions[i][iSeparatorPosition]) - (i==0 ? 0 : separator_positions[i-1][iSeparatorPosition]) ];
    if(env_help_enabled("trace")) echo("gridfinity_label", l=l, wallLocation = wallLocation, chamberWidths=chamberWidths, separator_positions = separator_positions);
    union()
    if(label_walls[l] != 0)
      translate(wallLocation[ilabelWall_Position])
      rotate(wallLocation[ilabelWall_Rotation])     
      for (i=[0:len(chamberWidths)-1]) {
          chamberStart = i == 0 
            ? 0 
            : separator_positions[i-1][iSeparatorPosition] + 
              separator_positions[i-1][iSeparatorBendSeparation]/2
                *(separator_positions[i-1][iSeparatorBendAngle] < 0 ? -1 : 1)
                *(wallLocation[ilabelWall_Reversed] ? -1 : 1);
          chamberWidth = chamberWidths[i];
          label_num_x = (labelWidthmm == 0 || labelWidthmm > chamberWidth) ? chamberWidth : labelWidthmm;
          label_pos_x = ((label_position == "center" || label_position == "centerchamber" )? (chamberWidth - label_num_x) / 2 
                          : (label_position == "right" || label_position == "rightchamber" )? chamberWidth - label_num_x 
                          : 0);
        if(env_help_enabled("trace")) echo("gridfinity_label", i=i, chamberStart=chamberStart, label_num_x=label_num_x, label_pos_x=label_pos_x,  separator_position=separator_positions[i-1]);
          translate([(chamberStart + label_pos_x)+labelCornerRadius,-labelCornerRadius,0])
          union(){
            difference(){
              if(render_option == "label" || render_option == "labelwithsocket")
              union(){
                hull() for (y=[0, 1, 2])
                translate([0, labelPoints[y][0], labelPoints[y][1]])
                  rotate([0, 90, 0])
                  union(){
                    //left
                    tz(abs(label_num_x-labelCornerRadius*2))//tz(abs(label_num_x))
                    sphere(r=labelCornerRadius);
                    //Right
                    sphere(r=labelCornerRadius);
                  }
                }
              //Create Label Sockets as negative volume
              if(render_option == "labelwithsocket")
                labelSockets(
                  label_style=label_style,
                  label_relief=label_relief,
                  labelPoints=labelPoints,
                  label_position=label_position,
                  labelCornerRadius=labelCornerRadius,
                  label_num_x=label_num_x,
                  socket_padding = socket_padding);
            }
            //Create Label Sockets as positive volume
            if(render_option == "socket")
              labelSockets(
                label_style=label_style,
                label_relief=label_relief,
                labelPoints=labelPoints,
                label_position=label_position,
                labelCornerRadius=labelCornerRadius,
                label_num_x=label_num_x,
                socket_padding = socket_padding);
          }
    }
  }
}
module labelSockets(
  label_style,
  label_relief,
  labelPoints,
  label_position,
  labelCornerRadius,
  label_num_x,
  socket_padding) {
  fudgeFactor = 0.01;
  binClearance = 0.5;
  fullLipWidth = 2.65;
  if(label_style == LabelStyle_cullenectlegacy){
      extraHeightToCleanLip = 3.75;
      labelSize=[
        label_relief.x == 0 ? 36.7 : label_relief.x,
        label_relief.y == 0 ? 11.3 : label_relief.y,
        (label_relief.z == 0 ? 1.5 : label_relief.z)+extraHeightToCleanLip];
      labelLeftPosition = CalculateLabelSocketPosition(
        label_position=label_position, 
        labelSocketSize=labelSize, 
        label_num_x=label_num_x);
      translate([labelLeftPosition-max(0,(labelSize.x-36))/2-binClearance,labelPoints[0][0]+.75,extraHeightToCleanLip])
      label_cullenect_legacy_socket(clickSize=labelSize);
    }
    else if(label_style == LabelStyle_cullenect){
      extraHeightToCleanLip = 0.5;
      cullenect_relief_x = label_num_x - 5.7;
      labelSize=[
        label_relief.x == 0 ? cullenect_relief_x : label_relief.x,
        label_relief.y == 0 ? 11.3 : label_relief.y,
        (label_relief.z == 0 ? 1.5 : label_relief.z)+extraHeightToCleanLip];
      labelLeftPosition = CalculateLabelSocketPosition(
        label_position=label_position, 
        labelSocketSize=labelSize, 
        label_num_x=label_num_x);
      translate([labelLeftPosition-0.4,labelPoints[0][0]+0.4,extraHeightToCleanLip])
      label_cullenect_socket(labelSize=labelSize);
    } 
    else if(label_style == LabelStyle_pred){
      predSize=[
        abs(label_num_x)-fullLipWidth*2-binClearance,
        abs(labelPoints[0][0]-labelPoints[1][0])-fullLipWidth,
        (label_relief.z == 0 ? 1 : label_relief.z) + fudgeFactor];
      translate([-labelCornerRadius+binClearance/2+fullLipWidth,-.3+labelPoints[0][0]+max(labelCornerRadius,label_relief.y+0.5),0-label_relief.z-fudgeFactor])
      label_pred_socket(size=predSize);
    } 
    else if(label_style == LabelStyle_gflabel){
            gflabelSize=[
                label_relief.x == 0 ? label_num_x-fullLipWidth*2-binClearance : label_relief.x,
                label_relief.y == 0 ? 11 : label_relief.y,
                label_relief.z == 0 ? 1.2 : label_relief.z];
            gflabelLeftPosition = 
              label_position == LabelPosition_left ? fullLipWidth 
              : label_position == LabelPosition_right ? fullLipWidth
              : label_position == LabelPosition_center ? (label_num_x-gflabelSize.x)/2
              : fullLipWidth;
        translate([gflabelLeftPosition-labelCornerRadius/2,labelPoints[0][0]+0.25,0])
      label_gflabel_socket(
        size=gflabelSize,
        radius=label_relief[3]);
    } else if(label_style == LabelStyle_normal) {
        fullLipWidth = 2.6;
        if (label_relief.z > 0){
        translate([0,labelPoints[0][0]+max(labelCornerRadius,label_relief.z+0.5),0-label_relief.z-fudgeFactor])
          cube([abs(label_num_x)-labelCornerRadius*2-fullLipWidth*2,abs(labelPoints[0][0]-labelPoints[1][0]),label_relief.z+fudgeFactor]);
    }
  }
}
//https://www.printables.com/model/592545-gridfinity-bin-with-printable-label-by-pred-parame
module label_pred_socket(
    size = [36, 12, 1], //should be full width of the label
    tab_size = [1, 6.7, 1],
    radius = 1
    ){
  translate([0,0,-size.z])
  union(){
    roundedCube(size=size,sideRadius=radius);
    translate([-tab_size.x,(size.y-tab_size.y)/2,0])
    cube(size=[size.x+tab_size.x*2, tab_size.y, size.z]);
  }
}
//https://github.com/ndevenish/gflabel
module label_gflabel_socket(
    size = [36.4, 11, 1.2],
    radius = 0.25
    ){
  translate([0,0,-size.z])
  roundedCube(size=size,sideRadius=radius);
}
//https://makerworld.com/en/models/446624#profileId-849444
module label_cullenect_legacy_socket(
    clickSize= [36.7,11.3, 1.2],
    socket_padding = [0.3,0.3,0.3],
    clickRadius = 0.25
    ){
  fudgeFactor = 0.01;
  paddedSocketSize = clickSize + socket_padding;   
  translate([0,0,-paddedSocketSize.z])
  difference(){
    roundedCube(size=paddedSocketSize, sideRadius=clickRadius);
    for(i = [0:2]){
      translate([(i+0.5)*clickSize.x/3,clickSize.y+fudgeFactor,0.23])
      rotate([90,210,0])
      cylinder(h=clickSize.y+fudgeFactor*2,r=.75, $fn=3);
    }}
}
// Generate negative volume of socket
// https://github.com/CullenJWebb/Cullenect-Labels
module label_cullenect_socket(
  labelSize=[36.3,11.3,1.5],
  labelRadius = 0.5,
  rib_height = 0.4, //height of the ribz
  rib_width = 0.2, //width of the ribxy
  rib_zoffset = 0.2 //z offset of the
){
  fudgeFactor = 0.01;
  echo("label_cullenect_socket", labelSize=labelSize);
  translate([0,0,-labelSize.z])
  difference(){
    roundedCube(size=[labelSize.x, labelSize.y, labelSize.z], sideRadius=labelRadius);
	  translate([0, -fudgeFactor, rib_zoffset])
      cube([labelSize.x, rib_width+fudgeFactor, rib_height]);
		translate([0, labelSize.y - rib_width, rib_zoffset])
      cube([labelSize.x, rib_width+fudgeFactor, rib_height]);
	}
}
//CombinedEnd from path module_gridfinity_label.scad
//Combined from path module_gridfinity_Extendable.scad







/* [Extendable]
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5; 
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5; 
extension_tabs_enabled = true;
//Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];
*/
iExtendablex=0;
iExtendabley=1;
iExtendableTabsEnabled=2;
iExtendableTabSize=3;
iExtendableEnabled=0;
iExtendablePosition=1;
iExtendablePositionmm=2;
iExtendableTabSizeHeight=0;
iExtendableTabSizeWidth=1;
iExtendableTabSizeThickness=2;
iExtendableTabSizeStyle=3;
BinExtensionEnabled_disabled = "disabled";
BinExtensionEnabled_front = "front";
BinExtensionEnabled_back = "back";
BinExtensionEnabled_values = [BinExtensionEnabled_disabled, BinExtensionEnabled_front, BinExtensionEnabled_back];
function validateBinExtensionEnabled(value, name = "BinExtensionEnabled") = 
  assert(list_contains(BinExtensionEnabled_values, value), typeerror(name, value))
  value;
function ExtendableSettings(
    extendablexEnabled, 
    extendablexPosition, 
    extendableyEnabled, 
    extendableyPosition, 
    extendableTabsEnabled, 
    extendableTabSize) = 
  let(
    xEnabled = validateBinExtensionEnabled(
      is_bool(extendablexEnabled) 
        ? extendablexEnabled ? BinExtensionEnabled_front : BinExtensionEnabled_disabled 
        : extendablexEnabled),
    yEnabled = validateBinExtensionEnabled(
      is_bool(extendableyEnabled) 
        ? extendableyEnabled ? BinExtensionEnabled_front : BinExtensionEnabled_disabled 
        : extendableyEnabled),
    xPosition = is_bool(extendablexEnabled) ? 0.5 : extendablexPosition,
    yPosition = is_bool(extendableyEnabled) ? 0.5 : extendableyPosition,
    result = [
      [xEnabled, xPosition],
      [yEnabled, yPosition],
      extendableTabsEnabled,
      extendableTabSize],
    validatedResult = ValidateExtendableSettings(result)
  ) validatedResult;
function ValidateExtendableSettings(settings, num_x, num_y) =
  assert(is_list(settings), "Extendable Settings must be a list")
  assert(len(settings)==4, "Extendable Settings must length 4")
  assert(is_list(settings[iExtendablex]) && len(settings[iExtendablex])>=2 && len(settings[iExtendablex])<=3, "Extendable x Settings must length 2 or 3")
  assert(is_list(settings[iExtendabley]) && len(settings[iExtendabley])>=2 && len(settings[iExtendabley])<=3, "Extendable y Settings must length 2 or 3")
  let(
    xetendableEnabled = validateBinExtensionEnabled(settings[iExtendablex][iExtendableEnabled]),
    yetendableEnabled = validateBinExtensionEnabled(settings[iExtendabley][iExtendableEnabled]),
    cutx = !is_undef(num_x) ? unitPositionTo_mm(settings.x[iExtendablePosition],num_x,env_pitch().x) : num_x,
    cuty = !is_undef(num_y) ? unitPositionTo_mm(settings.y[iExtendablePosition],num_y,env_pitch().y) : num_y
  ) [
      [xetendableEnabled, settings[iExtendablex][iExtendablePosition], cutx],
      [yetendableEnabled, settings[iExtendabley][iExtendablePosition], cuty],
      settings[iExtendableTabsEnabled],
      settings[iExtendableTabSize]];
module cut_bins_for_extension(
  num_x,
  num_y,
  num_z,
  extendable_Settings
){
  fudgeFactor = 0.01;
      if(extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_disabled)
      color(env_colour(color_wallcutout))
      if(extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_front)
      tz(-fudgeFactor)
        cube([unitPositionTo_mm(extendable_Settings.x[1],num_x,env_pitch().x),num_y*env_pitch().y,(num_z+1)*env_pitch().z]);
      else
        translate([unitPositionTo_mm(extendable_Settings.x[1],num_x,env_pitch().x),0,-fudgeFactor])
          cube([num_x*env_pitch().x-unitPositionTo_mm(extendable_Settings.x[1],num_x,env_pitch().x),num_y*env_pitch().y,(num_z+1)*env_pitch().z]);
    if(extendable_Settings.y[0]!=BinExtensionEnabled_disabled)
      color(env_colour(color_wallcutout))
      if(extendable_Settings.y[0]==BinExtensionEnabled_front)
        tz(-fudgeFactor)
        cube([env_pitch().x*num_x,unitPositionTo_mm(extendable_Settings.y[1],num_y,env_pitch().y),(num_z+1)*env_pitch().z]);
      else
        translate([0,unitPositionTo_mm(extendable_Settings.y[1],num_y,env_pitch().y),-fudgeFactor])
        cube([env_pitch().x*num_x,num_y*env_pitch().x-unitPositionTo_mm(extendable_Settings.y[1],num_y,env_pitch().y),(num_z+1)*env_pitch().z]);
}
module extension_tabs(
  num_x,
  num_y,
  num_z,
  extendable_Settings,
  cupBase_settings,
  lip_settings,
  floor_thickness,
  wall_thickness,
  headroom
  ){
    if((extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_disabled || extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_disabled) && extendable_Settings[iExtendableTabsEnabled]) {
      refTabHeight = extendable_Settings[iExtendableTabSize].x;
      tabThickness = extendable_Settings[iExtendableTabSize].z == 0 ? 1.4 : extendable_Settings[iExtendableTabSize].z;//1.4; //This should be calculated
      tabWidth = extendable_Settings[iExtendableTabSize].y;
      tabStyle = extendable_Settings[iExtendableTabSize][iExtendableTabSizeStyle];
      calculatedFloorHeight = calculateFloorHeight(
        magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
        screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
        center_magnet=cupBase_settings[iCupBase_CenterMagnetSize][iCylinderDimension_Height], 
        floor_thickness=floor_thickness,
        filled_in="disabled",
        efficient_floor=cupBase_settings[iCupBase_EfficientFloor], 
        flat_base=cupBase_settings[iCupBase_FlatBase],
        captive_magnet_height=cupBase_settings[iCupBase_MagnetCaptiveHeight]);
      calculatedCavityFloorRadius = calculateCavityFloorRadius(
          cupBase_settings[iCupBase_CavityFloorRadius], 
          wall_thickness, 
          cupBase_settings[iCupBase_EfficientFloor]);
      calculatedcupBaseClearanceHeight = cupBaseClearanceHeight(
        magnet_depth=cupBase_settings[iCupBase_MagnetSize][iCylinderDimension_Height], 
        screw_depth=cupBase_settings[iCupBase_ScrewSize][iCylinderDimension_Height], 
        center_magnet=cupBase_settings[iCupBase_CenterMagnetSize][iCylinderDimension_Height], 
        flat_base=cupBase_settings[iCupBase_FlatBase]);
      floorHeight = calculatedcupBaseClearanceHeight + floor_thickness + calculatedCavityFloorRadius - tabThickness;
      echo("extension tabs", calculatedFloorHeight=calculatedFloorHeight, calculatedCavityFloorRadius=calculatedCavityFloorRadius, floorHeight=floorHeight, tabThickness=tabThickness);
      //todo need to correct this
      lipheight = lip_settings[iLipStyle] == "none" ? tabThickness
        : lip_settings[iLipStyle] == "reduced" ? gf_lip_upper_taper_height+tabThickness
        : lip_settings[iLipStyle] == "reduced_double" ? gf_lip_upper_taper_height+tabThickness
        //Add tabThickness, as the taper can bleed in to the lip
        : gf_lip_upper_taper_height + gf_lip_lower_taper_height-tabThickness;
      ceilingHeight = env_pitch().z*num_z-headroom-lipheight;
      //tabWorkingheight = (num_z-1)*env_pitch().z-gf_Lip_Height;
      tabWorkingheight = ceilingHeight-floorHeight;
      tabsCount = max(floor(tabWorkingheight/refTabHeight),1);
      tabHeight = tabWorkingheight/tabsCount;
      if(env_help_enabled("debug")) echo("tabs", binHeight =num_z, tabHeight=tabHeight, floorHeight=floorHeight, cavity_floor_radius=cupBase_settings[iCupBase_CavityFloorRadius], tabThickness=tabThickness);
      cutx = extendable_Settings.x[iExtendablePositionmm];
      cuty = extendable_Settings.y[iExtendablePositionmm];
      even = (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_back) ?
                [[0,180,90], [cutx,num_y*env_pitch().y-wall_thickness-env_clearance().y/2,floorHeight], "darkgreen"]
              : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,180,180], [wall_thickness+env_clearance().x/2,cuty,floorHeight], "green"]
              : (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,180,270], [cutx,wall_thickness+env_clearance().y/2,floorHeight], "lime"]
              : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,180,0], [num_x*env_pitch().x-wall_thickness-env_clearance().x/2,cuty,floorHeight], "aqua"] 
              : [[0,0,0],[0,0,0], extendable_Settings, "grey"];
      odd = (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,0,90], [cutx,wall_thickness+env_clearance().y/2,floorHeight], "pink"]
            : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_front && extendable_Settings.x[iExtendableEnabled]!=BinExtensionEnabled_back) ?
                [[0,0,180], [num_x*env_pitch().x-wall_thickness-env_clearance().y/2,cuty,floorHeight], "red"]
            : (extendable_Settings.x[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_back) ?
                [[0,0,270], [cutx,num_y*env_pitch().y-wall_thickness-env_clearance().y/2,floorHeight], "orange"]
            : (extendable_Settings.y[iExtendableEnabled]==BinExtensionEnabled_back && extendable_Settings.y[iExtendableEnabled]!=BinExtensionEnabled_front) ?
                [[0,0,0], [wall_thickness+env_clearance().x/2,cuty,floorHeight], "yellow"]
            : [[0,0,0],[0,0,0], extendable_Settings, "grey"];
      for(i=[0:1:tabsCount-1])
      {
        isOdd = i % 2;
        tabPos = isOdd == 0 ? even : odd;
        if(env_help_enabled("trace")) echo("tabs", i=i, isOdd=isOdd, tabPos=tabPos);
        tz((i+0.5)*tabHeight)
        translate(tabPos[1])
          rotate(tabPos[0])
          attachment_clip(height=tabHeight, width=tabWidth, thickness=tabThickness, footingThickness=wall_thickness, tabStyle=tabStyle);
      }
    }
}
//CombinedEnd from path module_gridfinity_Extendable.scad
//Combined from path module_attachment_clip.scad








/*
  Module: attachment_clip
  Description: Creates a wall clip that is used when the box is split.
*/
/*
attachment_clip(height = 13,
  width = 0,
  thickness = 2,
  footingThickness= 2,
  tabStyle = 0);
*/
// Creates a wall clip that is used when the box is split
// Parameters:
// - height: The height of the clip (default: 8)
// - width: The width of the clip (default: 0, which means it will be set to half of the height)
// - thickness: The thickness of the clip (default: gf_lip_support_taper_height)
// - footingThickness: The thickness of the footing (default: 1)
// - tabStyle: The style of the tab (default: 0)s
module attachment_clip(
  height = 8,
  width = 0,
  thickness = gf_lip_support_taper_height,
  footingThickness = 1,
  tabStyle = 0)
{
  // Assertions to check the input parameters
  assert(is_num(height) && height > 0, "height must be a positive number");
  assert(is_num(width) && width >= 0, "width must be a non-negative number");
  assert(is_num(thickness) && thickness > 0, "thickness must be a positive number");
  assert(is_num(footingThickness) && footingThickness > 0, "footingThickness must be a positive number");
  assert(is_num(tabStyle) && tabStyle >= 0, "tabStyle must be a non-negative number");
  if(env_help_enabled("debug")) echo("attachment_clip", height=height, width=width, thickness=thickness, tabStyle=tabStyle);
  tabVersion = 0;
  width = width > 0 ? width : height / 2;
  tabHeight = height - thickness * 2;
  tabDepth = min(tabHeight / 2 * 0.8, width * 0.8, 3.5);
  tabStyle = floor(tabStyle);
  translate([0, 0, -height / 2])
  union()
  {
    if(tabStyle == 2){
      // using hull prevents shape not being closed
      hull()
      polyhedron
        (points = [
           [0, 0, 0],                                             //0
           [0, -width, 0],                                                 //1
           [0, -width, height],                                            //2
           [0, 0, height],                                        //3
           [0, thickness, height-thickness],                                       //4
           [0, thickness, thickness],                                              //5
           [thickness, thickness, thickness],                                      //6
           [thickness, -width+thickness, thickness],                       //7
           [thickness, -width+thickness, height-thickness],       //8
           [thickness, thickness, height-thickness]                                //9
           ], 
         faces = [[0,1,2,3,4,5],[6,7,8,9]]
      );
      hull()
      polyhedron
        (points = [
           [0, thickness, thickness],                             //0
           [0, -width+thickness, thickness],                    //1
           [0, -width+thickness, height-thickness],           //2
           [0, thickness, height-thickness],                    //3
           [0, tabDepth, height-tabDepth],                      //4
           [0, tabDepth, tabDepth],                               //5
           [thickness, thickness, thickness],                     //6
           [thickness, -width+thickness, thickness],            //7
           [thickness, -width+thickness, height-thickness],   //8
           [thickness, thickness, height-thickness],            //9
           [thickness, tabDepth, height-tabDepth],              //10
           [thickness, tabDepth, tabDepth]                        //11
           ], 
           faces = [[0,1,2,3,4,5],[6,7,8,9,10,11]]
      );
    } else if(tabStyle == 1){
      // using hull prevents shape not being closed
      hull()
      polyhedron
        (points = [
           [0, -thickness, 0],                                  //0
           [0, -width, 0],                                      //1
           [0, -width, height],                                 //2
           [0, -thickness, height],                             //3
           [0, 0, height-thickness],                          //4
           [0, 0, thickness],                                   //5
           [thickness, 0, thickness],                           //6
           [thickness, -width+thickness, thickness],          //7
           [thickness, -width+thickness, height-thickness], //8
           [thickness, 0, height-thickness]                   //9
           ], 
         faces = [[0,1,2,3,4,5],[6,7,8,9]]
      );
      hull()
      polyhedron
        (points = [
           [0, 0, thickness],                                   //0
           [0, -width+thickness, thickness],                  //1
           [0, -width+thickness, height-thickness],         //2
           [0, 0, height-thickness],                          //3
           [0, tabDepth, height-thickness-tabDepth],        //4
           [0, tabDepth, thickness+tabDepth],                 //5
           [thickness, 0, thickness],                           //6
           [thickness, -width+thickness, thickness],          //7
           [thickness, -width+thickness, height-thickness], //8
           [thickness, 0, height-thickness],                  //9
           [thickness, tabDepth, height-thickness-tabDepth],//10
           [thickness, tabDepth, thickness+tabDepth]          //11
           ], 
           faces = [[0,1,2,3,4,5],[6,7,8,9,10,11]]
      );
    } else {
      // using hull prevents shape not being closed
      hull()
      polyhedron
        (points = [
           [0, 0, 0],                                           //0
           [0, -width, 0],                                      //1
           [0, -width, height],                                 //2
           [0, 0, height],                                      //3
           [thickness, 0, thickness],                           //4
           [thickness, -width+thickness, thickness],          //5
           [thickness, -width+thickness, height-thickness], //6
           [thickness, 0, height-thickness],                  //7
           [-footingThickness, 0, 0],                           //8
           [-footingThickness, -width, 0],                      //9
           [-footingThickness, -width, height],                 //10
           [-footingThickness, 0, height]                       //11
           ], 
         faces = [[0,1,2,3],[4,5,6,7],[8,9,10,11]]
      );
      hull()
      polyhedron
        (points = [
           [0, 0, thickness],                                   //0
           [0, -width+thickness, thickness],                  //1
           [0, -width+thickness, height-thickness],         //2
           [0, 0, height-thickness],                          //3
           [0, tabDepth, height-thickness-tabDepth],        //4
           [0, tabDepth, thickness+tabDepth],                 //5
           [thickness, 0, thickness],                           //6
           [thickness, -width+thickness, thickness],          //7
           [thickness, -width+thickness, height-thickness], //8
           [thickness, 0, height-thickness],                  //9
           [thickness, tabDepth, height-thickness-tabDepth],//10
           [thickness, tabDepth, thickness+tabDepth]          //11
           ], 
           faces = [[0,1,2,3,4,5],[6,7,8,9,10,11]]
      );
    }
  }
}
//CombinedEnd from path module_attachment_clip.scad
//Combined from path module_gridfinity_cup_base_text.scad






iCupBaseTextLine1Enabled = 0;
iCupBaseTextLine2Enabled = 1;
iCupBaseTextLine1Value = 2;
iCupBaseTextLine2Value = 3;
iCupBaseTextFontSize = 4;
iCupBaseTextFont = 5;
iCupBaseTextDepth = 6;
iCupBaseTextOffset = 7;
function CupBaseTextSettings(
  baseTextLine1Enabled,
  baseTextLine2Enabled,
  baseTextLine1Value,
  baseTextLine2Value,
  baseTextFontSize,
  baseTextFont,
  baseTextDepth,
  baseTextOffset) = 
  [baseTextLine1Enabled, 
  baseTextLine2Enabled,
  baseTextLine1Value,
  baseTextLine2Value,
  baseTextFontSize,
  baseTextFont,
  baseTextDepth,
  baseTextOffset];
module AssertCupBaseTextSettings(settings){
  assert(is_list(settings), "BaseText Settings must be a list")
  assert(len(settings)==8, "BaseText Settings must length 8");
} 
// add text to the bottom
module cup_base_text(
  cupBaseTextSettings,
  wall_thickness = 1.2,
  base_clearance = 4,
  magnet_position = 0){
  maxTextWidth = 30;
  maxTextSize= 10;
  if(env_help_enabled("trace")) echo("cup_base_text", magnet_position=magnet_position);
  AssertCupBaseTextSettings(cupBaseTextSettings);
  text_line1_enabled = cupBaseTextSettings[iCupBaseTextLine1Enabled];
  text_line2_enabled = cupBaseTextSettings[iCupBaseTextLine2Enabled];
  text_line1_value = cupBaseTextSettings[iCupBaseTextLine1Value];
  text_line2_value = cupBaseTextSettings[iCupBaseTextLine2Value];
  text_size = cupBaseTextSettings[iCupBaseTextFontSize]; 
  text_font = cupBaseTextSettings[iCupBaseTextFont];
  text_depth = cupBaseTextSettings[iCupBaseTextDepth];
  text_x_offset = cupBaseTextSettings[iCupBaseTextOffset][0];
  text_y_offset = cupBaseTextSettings[iCupBaseTextOffset][1];
  _text_x = wall_thickness + max(base_clearance, magnet_position * 1/3);
  _text_1_y = max(base_clearance, magnet_position * 1/3);
  _text_1_text = 
    is_string(text_line1_value) && text_line1_value!="" 
    ? text_line1_value 
    : str(
      str($num_x),
      " x ",
      str($num_y),
      " x ",
      str($num_z));
  _text_1_size = text_size > 0 ? text_size : 
    let(sample_text_1_width = textmetrics(text=_text_1_text, size=5, font=text_font).size.x) 
      5*maxTextWidth/sample_text_1_width;
  if (text_line1_enabled) {
    color(env_colour(color_wallcutout))
    translate([
      _text_x + text_x_offset,
      _text_1_y + text_y_offset,
      -1 * text_depth
    ])
    linear_extrude(height = text_depth * 2) {
      rotate(a = [0, 180, 180])
      text(
        text = _text_1_text,
        size = _text_1_size,
        font = text_font,
        halign = "left",
        valign = "top"
      );
    }
  }
  if (text_line2_enabled) {
    _text_2_size = text_size > 0 ? text_size : 
    let(sample_text_2_width = textmetrics(text=text_line2_value, size=5, font=text_font).size.x) 
      min(5*maxTextWidth/sample_text_2_width, maxTextSize);
    _text_2_y = _text_1_y + _text_1_size + min(_text_1_size * 0.25, 3);
    color(env_colour(color_wallcutout))
    translate([
      _text_x + text_x_offset,
      _text_2_y + text_y_offset,
      -1 * text_depth
    ])
    linear_extrude(height = text_depth * 2) {
      rotate(a = [0, 180, 180])
      text(
        text = text_line2_value,
        size = _text_2_size,
        font = text_font,
        halign = "left",
        valign = "top"
      );
    }
  }
}
//CombinedEnd from path module_gridfinity_cup_base_text.scad
//Combined from path module_divider_walls.scad


//CombinedEnd from path module_divider_walls.scad
//Combined from path module_bin_chambers.scad


iChamber_count = 0;
iChamber_wall_thickness = 1;
iChamber_wall_headroom = 2;
iChamber_wall_top_radius = 3;
iChamber_separator_bend_position = 4;
iChamber_separator_bend_angle = 5;
iChamber_separator_bend_separation = 6;
iChamber_separator_cut_depth = 7;
iChamber_irregular_subdivisions = 8;
iChamber_separator_config = 9;
function ChamberSettings(
    chambers_count = 0,
    chamber_wall_thickness = 0,
    chamber_wall_headroom = 0,
    chamber_wall_top_radius = 0,
    separator_bend_position = 0,
    separator_bend_angle = 0,
    separator_bend_separation = 0,
    separator_cut_depth = 0,
    irregular_subdivisions = false,
    separator_config = "") = 
  let(
    result = [
      chambers_count,
      chamber_wall_thickness,
      chamber_wall_headroom,
      chamber_wall_top_radius,
      separator_bend_position,
      separator_bend_angle,
      separator_bend_separation,
      separator_cut_depth,
      irregular_subdivisions,
      separator_config],
    validatedResult = ValidateChamberSettings(result)
  ) validatedResult;
function ValidateChamberSettings(settings, wall_thickness = 0) =
  assert(is_list(settings), "Chamber Settings must be a list")
  assert(len(settings)==10, "Chamber Settings must length 10")
  assert(is_num(settings[iChamber_count]), "Chamber Count must be a number")
  assert(is_num(settings[iChamber_wall_thickness]) || (is_list(settings[iChamber_wall_thickness]) && len(settings[iChamber_wall_thickness]) ==2), "Wall Thickness must be a list")
  assert(is_num(settings[iChamber_wall_headroom]), "Wall Headroom must be a number")
  assert(is_num(settings[iChamber_wall_top_radius]), "Wall Top Radius must be a number")
  assert(is_num(settings[iChamber_separator_bend_position]), "Separator Bend Position must be a number")
  assert(is_num(settings[iChamber_separator_bend_angle]), "Separator Bend Angle must be a number")
  assert(is_num(settings[iChamber_separator_bend_separation]), "Separator Bend Separation must be a number")
  assert(is_num(settings[iChamber_separator_cut_depth]), "Separator Cut Depth must be a number")
  assert(is_bool(settings[iChamber_irregular_subdivisions]), "Separator Irregular Subdivisions must be a boolean")
  assert(is_string(settings[iChamber_separator_config]) || is_list(settings[iChamber_separator_config]), "Separator Config must be a string or a list")
  [
    settings[iChamber_count],
    is_num(settings[iChamber_wall_thickness])? [settings[iChamber_wall_thickness], settings[iChamber_wall_thickness]] : settings[iChamber_wall_thickness],
    settings[iChamber_wall_headroom],
    settings[iChamber_wall_top_radius],
    settings[iChamber_separator_bend_position],
    settings[iChamber_separator_bend_angle],
    settings[iChamber_separator_bend_separation],
    settings[iChamber_separator_cut_depth],
    settings[iChamber_irregular_subdivisions],
    settings[iChamber_separator_config]
  ];
iSeparatorPosition = 0;
iSeparatorLength = 1;
iSeparatorHeight = 2;
iSeparatorWallThickness = 3;
iSeparatorWallTopRadius = 4;
iSeparatorBendPosition = 5;
iSeparatorBendSeparation = 6;
iSeparatorBendAngle = 7;
iSeparatorWallCutDepth = 8;
iSeparatorWallCutoutWidth = 9;  
// calculate the position of separators from the size
function splitChamber(num_separators, container_width, divider_width) = num_separators < 1 
      ? [] 
      : let(
          chamber_count = num_separators + 1, // number of chambers
          chamber_width = (container_width - divider_width * num_separators)/chamber_count) // calculate the width of each chamber
      [ for (i=[1:num_separators]) i*chamber_width + (i-1)*divider_width+divider_width/2];
//Takes the user config and calculates the separators positions
function calculateSeparators(
                  separator_config, 
                  length,
                  height,
                  wall_thickness = 0,
                  wall_top_radius = 0,
                  bend_position = 0,
                  bend_angle = 0,
                  bend_separation = 0,
                  cut_depth = 0) = 
  is_string(separator_config) 
    //TODO: could reduce the duplication using a 
    //(is_string(separator_config) ||(is_list(separator_config) && len(separator_config) > 0))
    //  let(separator_config_list = is_string(separator_config) 
    //    ? [for (s = split(separator_config, "|")) csv_parse(s)]
    //    : separator_config)
    ? let(seps = [for (s = split(separator_config, "|")) csv_parse(s)]) // takes part of an array
      [for (i = [0:len(seps)-1]) 
        let(
          sepConfig = seps[i],
          _separator_position = is_list(sepConfig) && len(sepConfig) >= 1 ? sepConfig[0] : is_num(sepConfig) ? sepConfig : 0,
          _bend_separation = is_list(sepConfig) && len(sepConfig) >= 2 ? sepConfig[1] : bend_separation,
          _bend_angle = is_list(sepConfig) && len(sepConfig) >= 3 ? sepConfig[2] : bend_angle*(i%2==1?1:-1),
          _cut_depth = is_list(sepConfig) && len(sepConfig) >= 4 ? sepConfig[3] : cut_depth,
          _cut_width = is_list(sepConfig) && len(sepConfig) >= 5 ? sepConfig[4] : 0,
          _wall_thickness = is_list(sepConfig) && len(sepConfig) >= 6 ? sepConfig[5] : wall_thickness,
        )
        [
          _separator_position,        //0 iSeparatorPosition
          length,                     //1 iSeparatorLength
          height,                     //2 iSeparatorHeight
          _wall_thickness,            //3 iSeparatorWallThickness
          wall_top_radius,            //4 iSeparatorWallTopRadius
          bend_position,              //5 iSeparatorBendPosition
          _bend_separation,           //6 iSeparatorBendSeparation
          _bend_angle,                //7 iSeparatorBendAngle
          _cut_depth,                 //8 iSeparatorWallCutDepth
          _cut_width                  //9 iSeparatorWallCutoutWidth
        ]]
    : (is_list(separator_config) && len(separator_config) > 0) 
      ? [for (i = [0:len(separator_config)-1])
        let(
          sepConfig = separator_config[i],
          _separator_position = is_list(sepConfig) && len(sepConfig) >= 1 ? sepConfig[0] : is_num(sepConfig) ? sepConfig : 0,
          _bend_separation = is_list(sepConfig) && len(sepConfig) >= 2 ? sepConfig[1] : bend_separation,
          _bend_angle = is_list(sepConfig) && len(sepConfig) >= 3 ? sepConfig[2] : bend_angle*(i%2==1?1:-1),
          _cut_depth = is_list(sepConfig) && len(sepConfig) >= 4 ? sepConfig[3] : cut_depth,
          _cut_width = is_list(sepConfig) && len(sepConfig) >= 5 ? sepConfig[4] : 0,
          _wall_thickness_phase1 = is_list(sepConfig) && len(sepConfig) >= 6 ? sepConfig[5] : wall_thickness,
          _wall_thickness_phase2 = is_num(_wall_thickness_phase1) ? [_wall_thickness_phase1, _wall_thickness_phase1] : _wall_thickness_phase1,
          //allow wall thickness top to be relative to bottom
          _wall_thickness = [_wall_thickness_phase1.x, get_related_value(_wall_thickness_phase1.y, _wall_thickness_phase1.x, _wall_thickness_phase1.x)]
        ) [
          _separator_position,        //0 iSeparatorPosition
          length,                     //1 iSeparatorLength
          height,                     //2 iSeparatorHeight
          _wall_thickness,            //3 iSeparatorWallThickness
          wall_top_radius,            //4 iSeparatorWallTopRadius
          bend_position,              //5 iSeparatorBendPosition
          _bend_separation,           //6 iSeparatorBendSeparation
          _bend_angle,                //7 iSeparatorBendAngle
          _cut_depth,                 //8 iSeparatorWallCutDepth
          _cut_width                  //9 iSeparatorWallCutoutWidth
          ]]
      : [];
//Renders the physical separators
//calculatedSeparators - the calculated separator positions
//separator_orientation - the orientation of the separators (vertical or horizontal)
//override_wall_thickness - overrides the wallthickness 
module separators(
  calculatedSeparators,
  separator_orientation = "vertical",
  pad_wall_thickness = 0,
  pad_wall_height = 0,
  source = "")
{
 position_separators(
    calculatedSeparators = calculatedSeparators,
    separator_orientation = separator_orientation){
      bentWall(
        length=$sepCfg[iSeparatorLength],
        bendPosition=$sepCfg[iSeparatorBendPosition],
        bendAngle=$sepCfg[iSeparatorBendAngle],
        separation=$sepCfg[iSeparatorBendSeparation],
        lowerBendRadius=$sepCfg[iSeparatorBendSeparation]/2,
        upperBendRadius=$sepCfg[iSeparatorBendSeparation]/2,
        height = $sepCfg[iSeparatorHeight] + pad_wall_height,
        wall_cutout_depth = $sepCfg[iSeparatorWallCutDepth],
        wall_cutout_width = $sepCfg[iSeparatorWallCutoutWidth],
        thickness = let(wallThickness = $sepCfg[iSeparatorWallThickness])
          is_list(wallThickness) 
          ? [wallThickness[0] + pad_wall_thickness, wallThickness[1] + pad_wall_thickness]
          : wallThickness + pad_wall_thickness,
        top_radius = $sepCfg[iSeparatorWallTopRadius]);
      }
}
//positions the child in the correct location for the settings.
//This is a generic function that can be used for any separator, for example, the actual wall or the wall cutout
module position_separators(  
  calculatedSeparators,
  separator_orientation)
{
  assert(separator_orientation == "horizontal" || separator_orientation == "vertical", "separator_orientation must be 'horizontal' or 'vertical'");
  sepConfigs = calculatedSeparators;
  if(env_help_enabled("trace")) echo("separators",sepConfigs=sepConfigs);
  if(is_list(sepConfigs) && len(sepConfigs) > 0){
    for (i=[0:len(sepConfigs)-1]) {
      //set the current separator config for the child to access
      $sepCfg = sepConfigs[i];
      if(separator_orientation == "vertical"){
        translate([$sepCfg[iSeparatorPosition],0,0])
        children();
      }
      if(separator_orientation == "horizontal"){
        translate([0,$sepCfg[iSeparatorPosition],0])
        rotate([0,0,90])
        children();
      }
    }
  }
}
//CombinedEnd from path module_bin_chambers.scad
//Combined from path module_fingerslide.scad


iFingerSlideType=0;
iFingerSlideRadius=1;
iFingerSlideWalls=2;
iFingerSlideLipAligned=3;
function FingerSlideSettings(
    type, 
    radius, 
    walls,
    lip_aligned,
    ) = 
  let(
    result = [
      type,
      radius,
      walls,
      lip_aligned
      ],
    validatedResult = ValidateFingerSlideSettings(result)
  ) validatedResult;
function ValidateFingerSlideSettings(settings) =
  assert(is_list(settings), "Settings must be a list")
  assert(len(settings)==4, "Settings must length 4")
  assert(is_string(settings[iFingerSlideType]), "Type must be a string")
  assert(is_num(settings[iFingerSlideRadius]), "Radius must be a number")
  assert(is_list(settings[iFingerSlideWalls]) && len(settings[iFingerSlideWalls])==4, "Walls must be a list of four numbers")
  assert(is_bool(settings[iFingerSlideLipAligned]), "Lip Aligned must be a boolean")
    [settings[iFingerSlideType],
      settings[iFingerSlideRadius],
      settings[iFingerSlideWalls],
      settings[iFingerSlideLipAligned]
      ];
///Creates the finger slide that will be subtracted from the cavity  
module FingerSlide(
        num_x = num_x, 
        num_y = num_y,
        num_z = num_z,
        fingerslide_walls=fingerslide_walls,
        fingerslide=fingerslide,
        fingerslide_radius=fingerslide_radius,
        reducedlipstyle=reducedlipstyle,
        wall_thickness=wall_thickness,
        floorht=floorht,
        lipAligned = true,
        inner_corner_center=inner_corner_center) {
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(num_z), "num_z must be a number");
  assert(is_list(fingerslide_walls), "fingerslide_walls must be a list");
  assert(is_string(fingerslide), "fingerslide must be a string");
  assert(is_num(fingerslide_radius), "fingerslide_radius must be a number");
  assert(is_string(reducedlipstyle), "reducedlipstyle must be a string");
  assert(is_num(wall_thickness), "wall_thickness must be a number");
  assert(is_num(floorht), "floorht must be a number");
  assert(is_bool(lipAligned), "lipAligned must be a bool");
  assert(is_list(inner_corner_center), "inner_corner_center must be a number");
  echo("fingerslide", fingerslide_walls=fingerslide_walls, fingerslide=fingerslide);
  front = [
    //width
    num_x*env_pitch().x,
    //Position
    [0, 0, 0],
    //rotation
    [0,0,0],
    //cup width for finger slide (opposide dimention)
    num_y*env_pitch().y,
    //cup height
    num_z*env_pitch().z];
  back = [
    //width
    num_x*env_pitch().x,
    //Position
    [num_x*env_pitch().x, num_y*env_pitch().y, 0],
    //rotation
    [0,0,180],
    //cup width for finger slide (opposide dimention)
    num_y*env_pitch().y,
    //cup height
    num_z*env_pitch().z];
  left = [
    //width
    num_y*env_pitch().y,
    //Position
    [0, num_y*env_pitch().y, 0],
    //rotation
    [0,0,270],
    //cup width for finger slide (opposide dimention)
    num_x*env_pitch().x,
    //cup height
    num_z*env_pitch().z];
  right = [
    //width
    num_y*env_pitch().y,
    //Position
    [num_x*env_pitch().x, 0, 0],
    //rotation
    [0,0,90],
    //cup width for finger slide (opposide dimention)
    num_x*env_pitch().x,
    //cup height
    num_z*env_pitch().z];
  locations = [front, back, left, right];
  function get_fingerslide_radius(wall, cup_size, cup_height, fingerslide_radius) = 
  let(radius_start = wall == 1 ? fingerslide_radius : wall,
      calculated_radius = radius_start < 0 ? min(cup_height, cup_size)/abs(radius_start) : radius_start,
      limited_radius = min(calculated_radius,cup_height,cup_size/2))
    limited_radius;
  for(i = [0:1:len(locations)-1])
    union()
      if(fingerslide_walls[i] != 0)
        //patterns in the outer walls
        translate(locations[i][1])
        rotate(locations[i][2])                  
      translate([0, 
        lipAligned && reducedlipstyle =="normal" ? -inner_corner_center.x-1.15+env_pitch().x/2
        : lipAligned && reducedlipstyle == "reduced" ? -inner_corner_center.x-1.15+env_pitch().x/2-gf_lip_lower_taper_height
        : lipAligned && reducedlipstyle == "reduced_double" ? -inner_corner_center.x-1.15+env_pitch().x/2-gf_lip_lower_taper_height
        : 0.25+wall_thickness, floorht]) //todo:pitch issue here?
    //translate([0,-inner_corner_center-1.15+env_pitch().x/2, floorht])
      union(){
        if(fingerslide == "rounded"){
          roundedCorner(
            radius = get_fingerslide_radius(fingerslide_walls[i], locations[i][3], locations[i][4], fingerslide_radius), 
            length=locations[i][0], 
            height = env_pitch().z*num_z-floorht+fudgeFactor);
        }
        else if(fingerslide == "chamfered"){
          chamferedCorner(
            chamferLength = get_fingerslide_radius(fingerslide_walls[i], locations[i][3], locations[i][4], fingerslide_radius), 
            length=locations[i][0],
            height = env_pitch().z*num_z-floorht+fudgeFactor);
      }
    }
}
//CombinedEnd from path module_fingerslide.scad
//Combined from path module_gridfinity_efficient_floor.scad











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
//CombinedEnd from path module_gridfinity_efficient_floor.scad
//Combined from path module_rounded_negative_champher.scad


champher_demo = false;
if(champher_demo)
{
  rotate([90,0,0])
  chamferedSquare(size=50, radius = 0, $fn=64);
  translate([0,0,30])
  roundedNegativeChampher(
    champherRadius = 10, 
    size=[400,200], 
    cornerRadius = 20, $fn=64);
  translate([0,0,60])
  roundedNegativeChampher(
    champherRadius = 20, 
    size=[200,100], 
    cornerRadius = 10,
    champher = false, $fn=64);
  translate([0,0,90])
  roundedNegativeChampher(
    champherRadius = 10, 
    size=[100,50], 
    cornerRadius = 5,
    height = 20, $fn=64);
}
module roundedNegativeChampher(
  champherRadius = 10, 
  size=[80,100], 
  cornerRadius = 10, 
  height = 0,
  champher = false)
{
  eps = 0.01;
  height = height <= champherRadius ? champherRadius : height;
  postions = [
    [[0,0,0],
      size.y-cornerRadius*2,
      [size.x/2+champherRadius,size.y/2-cornerRadius,0],
      [size.x/2-cornerRadius,size.y/2-cornerRadius,0]],
    [[90,0,0],
      size.x-cornerRadius*2,
      [size.y/2+champherRadius,size.x/2-cornerRadius,0],
      [-size.x/2+cornerRadius,-size.y/2+cornerRadius,0]],
    [[180,0,0],
      size.y-cornerRadius*2,
      [size.x/2+champherRadius,size.y/2-cornerRadius,0],
      [size.x/2-cornerRadius,-size.y/2+cornerRadius,0]],
    [[270,0,0],
      size.x-cornerRadius*2,
      [size.y/2+champherRadius,size.x/2-cornerRadius,0],
      [-size.x/2+cornerRadius,size.y/2-cornerRadius,0]]
    ];
  difference(){
    hull(){
      for (pos = postions){  
        translate(pos[3])
          cylinder(r=(cornerRadius+champherRadius), h=height);
      }
    }
    union(){  
      for (pos = postions){  
        rotate(pos[0][0])
        translate(pos[2])
        union(){
          translate([-cornerRadius-champherRadius, 0]) 
          rotate_extrude(angle=90, convexity=cornerRadius)
            translate([cornerRadius+champherRadius, 0]) 
            if(champher){
                chamferedSquare(champherRadius*2);
            } else {
              circle(champherRadius);
            }
          translate([0, eps, 0]) 
           rotate([90, 0, 0]) 
            if(champher){
              linear_extrude(height=pos[1]+eps*2)
                chamferedSquare(champherRadius*2);
            } else {
              cylinder(r=champherRadius, h=pos[1]+eps*2);
            }
        }    
      }
    }
  }
}
module chamferedSquare(size=0, radius = 0){
  assert(is_num(size), "size must be a number");
  assert(is_num(radius), "radius must be a number");
  radius = radius <= 0 ? size/4 : radius;
  hull()
  {
    translate([0,radius])
      circle(radius);
    translate([-radius,0])
      circle(radius);
    translate([0,-size/2])
      square([size/2,size]);
    translate([-size/2,-size/2])
      square([size,size/2]);
  }
}
//CombinedEnd from path module_rounded_negative_champher.scad
//Combined from path module_calipers.scad











module ShowCalipers(
  cutx, cuty, 
  size, 
  lip_style, 
  magnet_depth, 
  screw_depth, 
  center_magnet_depth, 
  floor_thickness, 
  filled_in,
  wall_thickness,
  efficient_floor,
  flat_base){
  assert(is_num(cutx));
  assert(is_num(cuty));
  assert(is_list(size));
  assert(is_string(lip_style));
  assert(is_num(magnet_depth));
  assert(is_num(screw_depth));
  assert(is_num(center_magnet_depth));
  assert(is_num(floor_thickness));
  assert(is_string(filled_in));
  assert(is_num(wall_thickness));
  assert(is_string(efficient_floor));
  assert(is_string(flat_base));
  if(cuty > 0 && $preview)
  {
    color(color_text)
    translate([0,env_pitch().y*cuty,0]) 
    rotate([90,0,0])
    showCalipersForSide("width", size.x, size.z, lip_style, magnet_depth, screw_depth, center_magnet_depth, floor_thickness, filled_in,wall_thickness,efficient_floor,flat_base,env_pitch().x);
  }  
  if(cutx > 0 && $preview)
  {
    color(color_text)
    translate([env_pitch().x*cutx,env_pitch().y*size.y,0]) 
    rotate([90,0,270])
    showCalipersForSide("depth", size.y, size.z, lip_style, magnet_depth, screw_depth, center_magnet_depth, floor_thickness, filled_in,wall_thickness,efficient_floor,flat_base,env_pitch().y);
  }
}
module showCalipersForSide(description, gf_num, num_z, lip_style, magnet_depth, screw_depth, center_magnet_depth, floor_thickness, filled_in, wall_thickness, efficient_floor, flat_base, pitch){
  assert(is_string(description));
  assert(is_num(gf_num));
  assert(is_num(num_z));
  assert(is_string(lip_style));
  assert(is_num(magnet_depth));
  assert(is_num(screw_depth));
  assert(is_num(center_magnet_depth));
  assert(is_num(floor_thickness));
  assert(is_string(filled_in));
  assert(is_num(wall_thickness));
  assert(is_string(efficient_floor));
  assert(is_string(flat_base));
  assert(is_num(pitch));
    fontSize = 5;  
    gridHeight= gfBaseHeight();
    baseClearanceHeight = cupBaseClearanceHeight(magnet_depth, screw_depth, center_magnet_depth, flat_base);
    floorHeight = calculateFloorHeight(
          magnet_depth=magnet_depth, 
          screw_depth=screw_depth, 
          floor_thickness=floor_thickness, 
          num_z=num_z, 
          filled_in=filled_in,
          efficient_floor=efficient_floor,
          flat_base=flat_base);
    floorDepth = efficient_floor != "off"
      ? floor_thickness :
      floorHeight - baseClearanceHeight;
      if(env_help_enabled("info")) echo("showClippersForSide", description=description, gf_num=gf_num,num_z=num_z,lip_style=lip_style,magnet_depth=magnet_depth,screw_depth=screw_depth,floor_thickness=floor_thickness,filled_in=filled_in,wall_thickness=wall_thickness,efficient_floor=efficient_floor,flat_base=flat_base);
      if(env_help_enabled("info")) echo("showClippersForSide", floorHeight=floorHeight, floorDepth=floorDepth, baseClearanceHeight=baseClearanceHeight);
  wallTop = calculateWallTop(num_z, lip_style);
  isCutX = description == "depth";
  translate([env_clearance().x/2,wallTop,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize,
        end=0, in=1,
        translate=[0,5,0],
        l=gf_num*pitch-env_clearance().x, 
        txt2 = str("total ", description, " ", gf_num));
    translate([env_clearance().x/2+wall_thickness,(1+(num_z-1)/2)*env_pitch().z,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize,
        end=0, in=1,
        l=gf_num*pitch-env_clearance().x-wall_thickness*2, 
        txt2 = str("inner ", description)); 
    translate(isCutX
      ?[(gf_num)*pitch,0,0]
      :[0,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, size = fontSize,
        cx=isCutX ? 0: -1, 
        end=0, in=2,
        l=num_z*env_pitch().z, 
        translate=isCutX ? [1,0,0] : [-1,0,0],
        txt2 = str("height ", num_z));
    if(lip_style != "none")
    translate(isCutX
      ?[(gf_num)*pitch,num_z*env_pitch().z,0]
      :[0,num_z*env_pitch().z,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, size = fontSize,
        cx=isCutX ? 0: -1, 
        end=0, in=2,
        l=wallTop - (num_z*env_pitch().z),//gf_Lip_Height, 
        translate=isCutX ? [1,0,0] : [-1,0,0],
        txt2 = str("lip height"));
     if(lip_style != "none")
     translate(isCutX 
      ?[(gf_num)*pitch,0,0]
      :[0,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, size = fontSize,
        cx=isCutX ? 0: -1,
        end=0, in=2,
        translate=isCutX ? [fontSize*3,0,0] : [fontSize*-3,0,0],
        l=wallTop, 
        txt2 = str("total height"));
    if(!flat_base)
    translate(isCutX 
      ? gf_num < 1 ? [gf_num*pitch-1,0,0] : [(floor(gf_num)-1)*pitch-1,0,0]
      : gf_num < 1 ? [1,0,0] : [pitch,0,0])
      Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.75,
        cx=isCutX ? 0 : -1, 
        end=0, in=2,
        translate=isCutX ?[3,0,0]:[-3,0,0],
        l=gridHeight, 
        txt2 = "grid height");
    if(baseClearanceHeight > 0)
    translate(isCutX 
      ? gf_num < 1 ? [1,0,0] : [+pitch*(gf_num-1),0,0]
      : gf_num < 1 ? [gf_num*pitch-1,0,0] : [pitch-1,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.7,
        cx=isCutX ? -1 : 0, 
        end=0, in=2,
        translate=isCutX ?[-2,0,0]:[2,0,0],
        l=baseClearanceHeight, 
        txt2 = "clearance height");
    if(efficient_floor == "off")
    translate(isCutX 
      ? gf_num < 1 ? [1,baseClearanceHeight,0] : [pitch*(gf_num-1),baseClearanceHeight,0]
      : gf_num < 1 ? [gf_num*pitch-1,baseClearanceHeight,0] : [pitch-1,baseClearanceHeight,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.75,
        cx=isCutX ? -1 : 0, 
        end=0, in=2,
        translate=isCutX ?[-2,0,0]:[2,0,0],
        l=floorDepth, 
        txt2 = "floor thickness");
    translate(isCutX
      ? gf_num < 1 ? [pitch*gf_num/2,0,0] : [pitch*(gf_num-1/2),0,0]
      : gf_num < 1 ? [pitch*gf_num/2,0,0] : [pitch/2,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*0.8,
        cx=1, end=0, in=2,
        translate=[0,-floorHeight/2+2,0],
        l=floorHeight, 
        txt2 = "floor height");
    if(screw_depth > 0)
    translate(isCutX
      ? [pitch*(gf_num)-6,0,0]
      : [10,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.75,
        cx=1, end=0, in=2,
        l=screw_depth, 
        txt2 = "screw");
    if(magnet_depth > 0)
    translate(isCutX 
      ? [pitch*(gf_num)-10,0,0]
      : [6,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.75,
        //translate=[-2,0,0],
        cx=1, end=0, in=2,
        l=magnet_depth, 
        txt2 = "magnet");
}
//CombinedEnd from path module_calipers.scad
//Combined from path ub_caliper.scad






// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad
/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/
/** \page Helper
 Caliper() shows a distance and can be used as annotation
 \brief Caliper shows a distance and can be used as annotation
 \param l length to show
 \param in direction
 \param center centered length
 \param messpunkt show / size of gizmo
 \param translate  translates the text and arrow
 \param end differnt end options [0:none,1:triangle, 2:square, 3:arrow in, 4:arrow out]
 \param h height while end=0,3,4 can be 2D if h=0 
 \param on switch on=2 if Caliper should be rendered
 \param l2 arrow width
 \param txt  l+mm is used optional text
 \param txt2  optional second text
 \param size size
*/
//Caliper(end=0,messpunkt=0,in=1,translate=[20,-5],center=+1);
//Caliper(end=3);
//Caliper(end=3,txt2="X—Length",in=+1);
module Caliper(l=40,in=1,center=true,messpunkt=true,translate=[0,0,0],end=1,h,on=$preview,l2,txt,txt2,size=$vpd/15,render,s,t,cx,cy,help=false){
    on=render?render:on;
    s=s?s:size;
    txt=is_undef(txt)?str(l,end==2?"":"mm"):str(txt);
    center=is_bool(center)?center?1:0:center;
    textl=in>1?s/2.5:s/4*(len(str(txt)));// end=0,3,4 use own def
    line=s/20;
    translate=t?v3(t):v3(translate);
    //l2=is_undef(l2)?s:l2;
    if(on&&$preview||on==2)translate(translate)translate(in>1?center?[0,0]:[0,l/2]:center?[0,0]:[l/2,0]){
      if(end==1)Col(5){
        h=is_undef(h)?1.1:max(minVal,h);
        rotate(in?in==2?90:in==3?-90:180:0)linear_extrude(h,center=true)Mklon(tx=l/2,mz=0)polygon([[max(-5,-l/3),0],[0,s],[0,0]]);
        rotate(in?in==2?90:in==3?-90:180:0)linear_extrude(h,center=true)Mklon(tx=-l/2,mz=0)polygon([[max(-5,-l/3),0],[0,-s],[0,0]]);
        Text(h=h+.1,text=txt,center=true,size=s/4,trueSize="size",cx=cx,cy=cy);
        }
     else if(end==2)Col(3)union(){
        h=is_undef(h)?1.1:max(minVal,h);
        rotate(in?in==2?90:in==3?-90:180:0)MKlon(tx=l/2)T(-(l-textl*2)/4,0)cube([max(l-textl*2,.01)/2,line,h],center=true);
        rotate(in?in==2?90:in==3?-90:180:0)MKlon(tx=l/2)cube([line,s,h],center=true);    
        translate([(l<textl+1&&in<2)?l/2+textl/2+1.5:0,
          l<s/2 +1&&in>1?l/2+s/4+1:0,0])
            Text(h=h+.1,text=txt,center=true,size=s/2,trueSize="size",cx=cx,cy=cy);
         if(l<textl+1&&in<2)translate([.25,0])square([l+.5,line],true);
         if(l<s+1&&in>=2) translate([0,.25])square([line,l+.5],true);
        }
        else Col(1) {
        h=is_undef(h)?.1:h;
          if(h) linear_extrude(h,convexity=5) Dimensioning();
          else Dimensioning();
        }
    }    
Echo("Caliper will render",color="warning",condition=on==2);  
if(h&&end&&on&&end<3)
Pivot(messpunkt=messpunkt,p0=translate,active=[1,1,1,1,norm(translate)]);
    HelpTxt("Caliper",[
    "l",l,
    "in",in,
    "size",size,
    "center",center,
    "messpunkt",messpunkt,
    "translate",translate,
    "end",end,
    "h",h,
    "on",on,
    "l2",l2,
    "txt",txt,
    "txt2",txt2]
    ,help);
  module Dimensioning (t=translate){
            s=s==$vpd/15?5:s;
            txt2=txt2?str(txt2):"";
            line=s/20;
            textS=len(txt2)?s/2*.72:s*.72;//text size
            l2=l2?l2:s/1.5;
            textl=in>1?(len(txt2)?3:1.5)*textS:1+textS*max(len(txt),len(txt2))*0.95;
            arrowL=min(l/6,s);
            textOut=l<textl+arrowL*2||(abs(translate.y)>l/2&& (in==2||in==3) )||(abs(translate.x)>l/2&&in!=2&&in!=3); // is text outside l
            textOffset=l<textl+arrowL*2?l/2+textl/2+1:0;
            diffT=in!=2&&in!=3? t.x:-t.y;
// text line
        if(l-textl>0)rotate(in?in==2?90:in==3?-90:180:0){
         if(!textOut&&l-textl - diffT*2>0) T(-l/2)T((l-textl)/4 +diffT/2,0)square([(l-textl)/2-diffT,line],center=true);
         if(!textOut&&l-textl + diffT*2>0) T( l/2)T(-(l-textl)/4 +diffT/2,0)square([(l-textl)/2+diffT,line],center=true);
        }
//End lines vertical
        translate(in!=2&&in!=3?[-translate.x,0]:[0,-translate.y])rotate(in?in==2?90:in==3?-90:180:0){
        MKlon(tx=l/2){
           T(end?end==4?-line/2:+line/2:0) square([line,s],center=true);
           if(end)rotate(end==4?180:0)Pfeil([0,arrowL],b=[line,l2],center=[-1,1],name=false);
        }
        if(textOut) square([l,line],true); // Verbindung Pfeile
// text pos
        translate(in!=2&&in!=3?[(in?1:-1) * -translate.x,0]:[(in==2?1:-1)*translate.y,0]){
          translate([textOffset,0])rotate(in>1?-90:180){
            if(len(txt2))translate([0,-textS/1.5])Text(h=0,text=txt2,center=true,size=textS,trueSize="size",name=false,cx=cx,cy=cy);
            translate([0,len(txt2)?textS/1.5:0])Text(h=0,text=txt,center=true,size=textS,trueSize="size",name=false,cx=cx,cy=cy);
          }
        }
// verbindung text ausserhalb
        tOutDist=(in!=2&&in!=3)? t.x *(in   ?-1:1) + textOffset :
                                 t.y *(in==3?-1:1) + textOffset ;                                
        if(textOut&&tOutDist)rotate(tOutDist<0?180:0)translate([0,-line/2])square([abs(tOutDist)-textl/2 ,line]);
        }
// verlängerungen translate auf 0.5
      mkL=end?end==4?l/2-line:l/2:l/2-line/2;
       if(abs(translate.y)>(l2/2+.5)&&in!=2&&in!=3)translate([-translate.x,0])MKlon(tx=mkL) mirror([0,translate.y>0?1:0,0])square([line,abs(translate.y)-.5],false);
       if(abs(translate.x)>(l2/2+.5)&&(in==2||in==3))translate([0,-translate.y])MKlon(ty=mkL) mirror([translate.x>0?1:0,0,0])square([abs(translate.x)-.5,line],false);    
       //if(translate.x) mirror([translate.x>0?1:0,0,0])T(l/2,-line/2)square([abs(translate.x),line],false);
  }// end Dimensioning
}// end Caliper
//CombinedEnd from path ub_caliper.scad
/*<!!end gridfinity_basic_cup!!>*/
//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;  
set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  cut = cut,
  setColour = set_colour,
  randomSeed = random_seed,
  force_render = force_render)
  union(){
  if(render_choice == "both" || render_choice == "cup")
  {
    gridfinity_cup(
      width=width, depth=depth, height=height,
      filled_in=filled_in,
      label_settings=LabelSettings(
        labelStyle=label_style, 
        labelPosition=label_position, 
        labelSize=label_size,
        labelRelief=label_relief,
        labelWalls=label_walls),
      finger_slide_settings = FingerSlideSettings(
        type = fingerslide,
        radius = fingerslide_radius,
        walls = fingerslide_walls,
        lip_aligned = fingerslide_lip_aligned),
      cupBase_settings = CupBaseSettings(
        magnetSize = enable_magnets ? magnet_size : [0,0], 
        magnetEasyRelease = magnet_easy_release, 
        centerMagnetSize = center_magnet_size, 
        screwSize = enable_screws ? screw_size : [0,0], 
        holeOverhangRemedy = hole_overhang_remedy, 
        cornerAttachmentsOnly = box_corner_attachments_only,
        floorThickness = floor_thickness,
        cavityFloorRadius = cavity_floor_radius,
        efficientFloor=efficient_floor,
        halfPitch=half_pitch,
        flatBase=flat_base,
        spacer=spacer,
        minimumPrintablePadSize=minimum_printable_pad_size,
        flatBaseRoundedRadius = flat_base_rounded_radius,
        flatBaseRoundedEasyPrint = flat_base_rounded_easyPrint),
      wall_thickness=wall_thickness,
      vertical_chambers = ChamberSettings(
        chambers_count = vertical_chambers,
        chamber_wall_thickness = chamber_wall_thickness,
        chamber_wall_headroom = chamber_wall_headroom,
        separator_bend_position = vertical_separator_bend_position,
        separator_bend_angle = vertical_separator_bend_angle,
        separator_bend_separation = vertical_separator_bend_separation,
        separator_cut_depth = vertical_separator_cut_depth,
        irregular_subdivisions = vertical_irregular_subdivisions,
        separator_config = vertical_separator_config),
      horizontal_chambers = ChamberSettings(
        chambers_count = horizontal_chambers,
        chamber_wall_thickness = chamber_wall_thickness,
        chamber_wall_headroom = chamber_wall_headroom,
        separator_bend_position = horizontal_separator_bend_position,
        separator_bend_angle = horizontal_separator_bend_angle,
        separator_bend_separation = horizontal_separator_bend_separation,
        separator_cut_depth = horizontal_separator_cut_depth,
        irregular_subdivisions = horizontal_irregular_subdivisions,
        separator_config = horizontal_separator_config),
      lip_settings = LipSettings(
        lipStyle=lip_style, 
        lipSideReliefTrigger=lip_side_relief_trigger, 
        lipTopReliefHeight=lip_top_relief_height, 
        lipNotch=lip_top_notches),
      headroom=headroom,
      tapered_corner=tapered_corner,
      tapered_corner_size = tapered_corner_size,
      tapered_setback = tapered_setback,
      wallpattern_walls=wallpattern_walls, 
      wallpattern_dividers_enabled=wallpattern_dividers_enabled,
      wall_pattern_settings = PatternSettings(
        patternEnabled = wallpattern_enabled, 
        patternStyle = wallpattern_style, 
        patternRotate = wallpattern_rotate_grid,
        patternFill = wallpattern_fill,
        patternBorder = wallpattern_border, 
        patternDepth = wallpattern_depth,
        patternCellSize = wallpattern_cell_size, 
        patternHoleSides = wallpattern_hole_sides,
        patternStrength = wallpattern_strength, 
        patternHoleRadius = wallpattern_hole_radius,
        patternGridChamfer = wallpattern_pattern_grid_chamfer,
        patternVoronoiNoise = wallpattern_pattern_voronoi_noise,
        patternBrickWeight = wallpattern_pattern_brick_weight,
        patternFs = wallpattern_pattern_quality), 
      floor_pattern_settings = PatternSettings(
        patternEnabled = floorpattern_enabled, 
        patternStyle = floorpattern_style, 
        patternRotate = floorpattern_rotate_grid,
        patternFill = floorpattern_fill,
        patternBorder = floorpattern_border, 
        patternDepth = floorpattern_depth,
        patternCellSize = floorpattern_cell_size, 
        patternHoleSides = floorpattern_hole_sides,
        patternStrength = floorpattern_strength, 
        patternHoleRadius = floorpattern_hole_radius,
        patternGridChamfer = floorpattern_pattern_grid_chamfer,
        patternVoronoiNoise = floorpattern_pattern_voronoi_noise,
        patternBrickWeight = floorpattern_pattern_brick_weight,
        patternFs = floorpattern_pattern_quality), 
      wallcutout_vertical_settings = WallCutoutSettings(
        type = wallcutout_vertical, 
        position = wallcutout_vertical_position, 
        width = wallcutout_vertical_width,
        angle = wallcutout_vertical_angle,
        height = wallcutout_vertical_height, 
        corner_radius = wallcutout_vertical_corner_radius),
      wallcutout_horizontal_settings = WallCutoutSettings(
        type = wallcutout_horizontal, 
        position = wallcutout_horizontal_position, 
        width = wallcutout_horizontal_width,
        angle = wallcutout_horizontal_angle,
        height = wallcutout_horizontal_height, 
        corner_radius = wallcutout_horizontal_corner_radius),
      extendable_Settings = ExtendableSettings(
        extendablexEnabled = extension_x_enabled, 
        extendablexPosition = extension_x_position, 
        extendableyEnabled = extension_y_enabled, 
        extendableyPosition = extension_y_position, 
        extendableTabsEnabled = extension_tabs_enabled, 
        extendableTabSize = extension_tab_size),
      sliding_lid_enabled = sliding_lid_enabled, 
      sliding_lid_thickness = sliding_lid_thickness, 
      sliding_min_wall_thickness = sliding_min_wall_thickness, 
      sliding_min_support = sliding_min_support, 
      sliding_clearance = sliding_clearance,
      sliding_lid_lip_enabled=sliding_lid_lip_enabled,
      cupBaseTextSettings = CupBaseTextSettings(
        baseTextLine1Enabled = text_1,
        baseTextLine2Enabled = text_2,
        baseTextLine2Value = text_2_text,
        baseTextFontSize = text_size,
        baseTextFont = text_font,
        baseTextDepth = text_depth,
        baseTextOffset = text_offset));
  }
  if(render_choice == "both" || render_choice == "lid")
  {
    num_x = calcDimensionWidth(width);
    num_y = calcDimensionDepth(depth);
    num_z = calcDimensionHeight(height);
    wall_thickness = wallThickness(wall_thickness, num_z);
    slidingLidSettings= SlidingLidSettings(
      sliding_lid_enabled, 
      sliding_lid_thickness, 
      sliding_min_wall_thickness, 
      sliding_min_support,
      sliding_clearance,
      wall_thickness,
      sliding_lid_lip_enabled);
    headroom = headroom + (sliding_lid_enabled ? slidingLidSettings[iSlidingLidThickness] : 0);
    filledInZ = env_pitch().z*num_z;
    zpoint = filledInZ-headroom;
    translate(
      render_choice == "both" && !$preview 
      ? [(num_x+0.5)*env_pitch().x, 0, 0] 
      : [0, 0, render_choice == "lid" ? 0 : zpoint])
    difference()
    {
      SlidingLid(
        num_x=num_x, 
        num_y=num_y,
        wall_thickness,
        clearance = slidingLidSettings[iSlidingClearance],
        lidThickness=slidingLidSettings[iSlidingLidThickness],
        lidMinSupport=slidingLidSettings[iSlidingLidMinSupport],
        lidMinWallThickness=slidingLidSettings[iSlidingLidMinWallThickness],
        lipStyle = lip_style,
        lip_notches = lip_top_notches,
        lip_top_relief_height = lip_top_relief_height, 
        addLiptoLid = sliding_lid_lip_enabled,
        limitHeight=true,
        cutoutEnabled = sliding_lid_cutout_enabled,
        cutoutSize = sliding_lid_cutout_size,
        cutoutRadius = sliding_lid_cutout_radius,
        cutoutPosition = sliding_lid_cutout_position);
    }
  }
}

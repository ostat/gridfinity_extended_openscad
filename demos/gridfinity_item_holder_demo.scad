// include <gridfinity_modules.scad>
use <../gridfinity_item_holder.scad>
//use <modules/gridfinity_cup_modules.scad>
include <../modules/functions_general.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "demo"; //["demo","grid", "hole_grid", "hole_sides", "hole_size", "hole_spacing", "hole_clearance", "hole_depth", "compartments", "compartment_spacing", "compartment_centered", "compartment_fill", "auto_bin_height", "floorheight","magnet","custom"]
showtext = true;

//Include help info in the logs
help=false;
setViewPort=true;

module end_of_customizer_opts() {}
iitemholder_known_item = 0;
iitemholder_hex_grid = 1;
iitemholder_hole_sides = 2;
iitemholder_hole_size = 3;
iitemholder_hole_spacing = 4;
iitemholder_hole_grid = 5;
iitemholder_hole_clearance = 6;
iitemholder_hole_depth = 7;
iitemholder_compartments = 8;
iitemholder_compartment_spacing = 9;
iitemholder_compartment_centered = 10;
iitemholder_compartment_fill  = 11;
iitemholder_customcompartments = 12;
iitemholder_auto_bin_height = 13;
extendedsettingscount=14;

iwidth=extendedsettingscount;
idepth=1+extendedsettingscount;
iheight=2+extendedsettingscount;
iposition=3+extendedsettingscount;
ifilled_in=4+extendedsettingscount;
ilabel=5+extendedsettingscount;
ilabel_width=6+extendedsettingscount;
iwall_thickness=7+extendedsettingscount;
ilip_style=8+extendedsettingscount;
ichambers=9+extendedsettingscount;
iirregular_subdivisions=10+extendedsettingscount;
iseparator_positions=11+extendedsettingscount;
imagnet_diameter=12+extendedsettingscount;
iscrew_depth=13+extendedsettingscount;
icenter_magnet_diameter=14+extendedsettingscount;
icenter_magnet_thickness=15+extendedsettingscount;
ihole_overhang_remedy=16+extendedsettingscount;
ibox_corner_attachments_only=17+extendedsettingscount;
ifloor_thickness=18+extendedsettingscount;
icavity_floor_radius=19+extendedsettingscount;
iefficient_floor=20+extendedsettingscount;
ihalf_pitch=21+extendedsettingscount;
iflat_base=22+extendedsettingscount;
ifingerslide=23+extendedsettingscount;
ifingerslide_radius=24+extendedsettingscount;
itapered_corner=25+extendedsettingscount;
itapered_corner_size=26+extendedsettingscount;
itapered_setback=27+extendedsettingscount;
iwallcutout_enabled=28+extendedsettingscount;
iwallcutout_walls=29+extendedsettingscount;
iwallcutout_width=30+extendedsettingscount;
iwallcutout_angle=31+extendedsettingscount;
iwallcutout_height=32+extendedsettingscount;
iwallcutout_corner_radius=33+extendedsettingscount;
iwallpattern_enabled=34+extendedsettingscount;
iwallpattern_hexgrid=35+extendedsettingscount;
iwallpattern_walls=36+extendedsettingscount;
iwallpattern_fill=37+extendedsettingscount;
iwallpattern_hole_sides=38+extendedsettingscount;
iwallpattern_hole_size=39+extendedsettingscount;
iwallpattern_hole_spacing=40+extendedsettingscount;
icutx=41+extendedsettingscount;
icuty=42+extendedsettingscount;

$vpr = setViewPort ? [60,0,320] : $vpr;
$vpt = setViewPort ? [32,13,16] : $vpt; //shows translation (i.e. won't be affected by rotate and zoom)
$vpf = setViewPort ? 25 : $vpf; //shows the FOV (Field of View) of the view [Note: Requires version 2021.01]
$vpd = setViewPort ? 280 : $vpd;//shows the camera distance [Note: Requires version 2015.03]
     
//Basic cup default settings for demo
defaultDemoSetting = 
    //itemholder_known_item, itemholder_hex_grid, itemholder_hole_sides, itemholder_hole_size, itemholder_hole_spacing, 
    ["1/4hexshank", false, 6, 5, 2,
    //itemholder_hole_grid, itemholder_hole_clearance, itemholder_hole_depth,
    [0, 0], 0.65, 0,
    //itemholder_compartments, itemholder_compartment_spacing, itemholder_compartment_centered, itemholder_compartment_fill
    [1,1], 5, true, "none",
    //itemholder_customcompartments, itemholder_auto_bin_height, 
    "", true,
  
    //Gridfinity settins
    //width, depth, height, filled_in, label, label_width
    3,2,2,"default","off","disabled",1.5,
    //wall_thickness, lip_style, chambers, irregular_subdivisions, separator_positions
    0.95, "normal", 1, false, [], 
    //magnet_diameter, screw_depth, icenter_magnet_diameter, icenter_magnet_thickness, hole_overhang_remedy, box_corner_attachments_only
    0, 0, 0, 0, 2, false, 
    //floor_thickness, cavity_floor_radius, efficient_floor, half_pitch, flat_base
    10, -1, false, false, false, 
    //fingerslide,fingerslide_radius,
    "none", 8,
    //tapered_corner, tapered_corner_size, tapered_setback
    "none", 10, -1,
    //wallcutout_enabled, wallcutout_walls, wallcutout_width, wallcutout_angle, wallcutout_height, wallcutout_corner_radius
    false, [1,0,0,0], 0, 70, 0, 5, 
    //wallpattern_enabled, wallpattern_hexgrid, wallpattern_walls, wallpattern_fill, wallpattern_hole_sides, wallpattern_hole_size, wallpattern_hole_spacing
    false, true, [1,1,1,1], "none", 6, 5, 2, 
    //cutx,cuty
    false, false];
   
   //iitemholder_hole_grid
scenarioSteps = 
  scenario == "demo" ? [["Item Holder",6,[]],
      ["4mm Hex Shank",false, [[iitemholder_known_item,"4hexshank"]]],
      ["1/4\" Hex Shank",false, [[iitemholder_known_item,"1/4hexshank"],[iitemholder_hex_grid,true]]],
      ["AAA on hex grid",false, [[iitemholder_known_item,"aaa"],[iitemholder_hex_grid,true]]],
      ["AA",false, [[iitemholder_known_item,"aa"]]],
      ["18650",false, [[iitemholder_known_item,"18650"]]],
      ["Nintendo DS",false, [[iitemholder_known_item,"nintendo2ds"],[iitemholder_hole_spacing,5], [iheight,5],
          [iwallpattern_enabled,true],[iwallpattern_walls,[0,1,1,1]], [iitemholder_auto_bin_height,false],[iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,90],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]]]//endscenario

  : scenario == "grid" ? [["grid",2,[[iitemholder_known_item,"aaa"]]],
      ["square",false, [[iitemholder_hex_grid,false]]],
      ["hex",false, [[iitemholder_hex_grid,true]]]]//endscenario

  : scenario == "hole_sides" ? [["hole sides",4,[[iitemholder_known_item,""],[iitemholder_hole_depth, 10], [icuty,true]]],
      [4,false, [[iitemholder_hole_sides,4]]],
      [6,false, [[iitemholder_hole_sides,6]]],
      [8,false, [[iitemholder_hole_sides,8]]],
      [64,false, [[iitemholder_hole_sides,64]]]]//endscenario

  : scenario == "hole_size" ? [["hole size",3,[[iitemholder_known_item,""],[iitemholder_hole_depth, 10], [icuty,true]]],
      ["5mm",false, [[iitemholder_hole_size,5]]],
      ["7.5mm",false, [[iitemholder_hole_size,7.5]]],
      ["10mm",false, [[iitemholder_hole_size,10]]]]//endscenario

  : scenario == "hole_spacing" ? [["hole spacing",3,[[iitemholder_known_item,"aa"]]],
      ["2mm",false, [[iitemholder_hole_spacing,2]]],
      ["4mm",false, [[iitemholder_hole_spacing,4]]],
      ["6mm",false, [[iitemholder_hole_spacing,6]]]]//endscenario

  : scenario == "hole_grid" ? [["hole grid",3,[[iitemholder_known_item,"aa"]]],
      ["auto [0,0]",false, [[iitemholder_hole_grid,[0,0]]]],
      ["[5,4]",false, [[iitemholder_hole_grid,[5,4]]]],
      ["[9,2]",false, [[iitemholder_hole_grid,[9,2]]]]]//endscenario
      
  : scenario == "hole_clearance" ? [["hole clearance AA battery",3,[[iitemholder_known_item,"aa"]]],
      [0.7,false, [[iitemholder_hole_clearance,0.7]]],
      [1,false, [[iitemholder_hole_clearance,1]]],
      [2,false, [[iitemholder_hole_clearance,2]]]]//endscenario
 
  : scenario == "hole_depth" ? [["hole depth AA battery",4,[[iitemholder_known_item,"aa"], [iitemholder_auto_bin_height, false], [icuty,true]]],
      ["default (0)",false, [[iitemholder_hole_depth,0], [iitemholder_auto_bin_height, true]]],
      [5,false, [[iitemholder_hole_depth,5]]],
      [10,false, [[iitemholder_hole_depth,10]]],
      [20,false, [[iitemholder_hole_depth,20]]]]//endscenario

  : scenario == "compartments" ? [["compartments",3,[[iitemholder_known_item,"aaa"], [icuty,true]]],
      ["default ([1,1])",false, [[iitemholder_compartments, [1,1]]]],
      ["[1,2]",false, [[iitemholder_compartments, [1,2]]]],
      ["[2,2]",false, [[iitemholder_compartments, [2,2]]]]]//endscenario
      
  : scenario == "compartment_spacing" ? [["compartment spacing",3,[[iitemholder_known_item,"aaa"], [icuty,true]]],
      ["5mm",false, [[iitemholder_compartment_spacing, 5]]],
      ["10mm",false, [[iitemholder_compartment_spacing, 10]]],
      ["15mm",false, [[iitemholder_compartment_spacing, 15]]]]//endscenario

  : scenario == "compartment_centered" ? [["compartment centered", 4, [[iitemholder_known_item,"aaa"]]],
      ["on",false, [[iitemholder_compartment_centered, true], [iitemholder_compartments, [1,1]]]],
      ["off",false, [[iitemholder_compartment_centered, false], [iitemholder_compartments, [1,1]]]],
      ["on",false, [[iitemholder_compartment_centered, true], [iitemholder_compartments, [2,2]]]],
      ["off",false, [[iitemholder_compartment_centered, false], [iitemholder_compartments, [2,2]]]]]//endscenario
      
  : scenario == "compartment_fill" ? [["compartment fill", 3, [[iitemholder_known_item,"aaa"]]],
      ["none",false, [[iitemholder_compartment_fill, "none"], [iitemholder_compartments, [1,1]]]],
      ["space",false, [[iitemholder_compartment_fill, "space"], [iitemholder_compartments, [1,1]]]],
      ["crop",false, [[iitemholder_compartment_fill, "crop"], [iitemholder_compartments, [1,1]]]]]//endscenario

  : scenario == "auto_bin_height" ? [["auto bin height",2, [[iitemholder_known_item,"1/4hexlongshank"]]],
      ["on",false, [[iitemholder_auto_bin_height, true]]],
      ["off",false, [[iitemholder_auto_bin_height, false]]]]//endscenario
    
  : scenario == "floorheight" ? [["Floor height", 4, [[itrayverticalcompartments, 2],[iheight, 2]]],
     ["5mm",false, [[ifloor_thickness, 5]]],
     ["10mm",false, [[ifloor_thickness, 10]]],
     ["filledin",false, [[ifilled_in, "on"]]],
     ["filledin not stackable",false, [[ifilled_in, "notstackable"]]]]//endscenario

  : scenario == "custom" ? [["Custom", 3, []]]//endscenario

   : [["unknown scenario",[]]];

scenarioDefaults = scenarioSteps[0];
animationStep = len(scenarioSteps) >= round($t*(len(scenarioSteps)-1)) ? scenarioSteps[min(round($t*(len(scenarioSteps)-1))+1,len(scenarioSteps)-1)] : scenarioSteps[1];  
scenarioStepSettings = replace_Items(concat(scenarioDefaults[2],animationStep[2]), defaultDemoSetting);

echo("🟧gridfinity_item_holder",scenario = scenario, steps=len(scenarioSteps)-1, t=$t, time=$t*(len(scenarioSteps)-1), animationStep=animationStep, scenarioStepSettings=scenarioStepSettings);

if(showtext)
color("GhostWhite")
translate($vpt)
rotate($vpr)
translate([0,-45,60])
 linear_extrude(height = 0.1)
 text(str(scenarioDefaults[0], " - ", animationStep[0]), size=5,halign="center");
 
if(scenarioDefaults[0] != "unknown scenario")
rotate(animationStep[1] ? [180,0,0] : [0,0,0]) 
translate(animationStep[1] ? [0,-gridfinity_pitch,0] : [0,0,0])
gridfinity_itemholder(
  //itemholder settings
  itemholder_hex_grid = scenarioStepSettings[iitemholder_hex_grid],
  itemholder_hole_sides = scenarioStepSettings[iitemholder_hole_sides],
  itemholder_hole_size = scenarioStepSettings[iitemholder_hole_size],
  itemholder_hole_spacing = scenarioStepSettings[iitemholder_hole_spacing],
  itemholder_hole_grid = scenarioStepSettings[iitemholder_hole_grid],
  itemholder_hole_clearance = scenarioStepSettings[iitemholder_hole_clearance],
  itemholder_hole_depth = scenarioStepSettings[iitemholder_hole_depth],
  itemholder_compartments = scenarioStepSettings[iitemholder_compartments],
  itemholder_compartment_spacing = scenarioStepSettings[iitemholder_compartment_spacing],
  itemholder_compartment_centered = scenarioStepSettings[iitemholder_compartment_centered],
  itemholder_compartment_fill  = scenarioStepSettings[iitemholder_compartment_fill],
  itemholder_customcompartments = scenarioStepSettings[iitemholder_customcompartments],
  itemholder_auto_bin_height = scenarioStepSettings[iitemholder_auto_bin_height],
  itemholder_known_item = scenarioStepSettings[iitemholder_known_item],
  
  width = scenarioStepSettings[iwidth],
  depth = scenarioStepSettings[idepth],
  height = scenarioStepSettings[iheight],
  position = scenarioStepSettings[iposition],
  filled_in = scenarioStepSettings[ifilled_in],
  label=scenarioStepSettings[ilabel],
  label_width=scenarioStepSettings[ilabel_width],
  wall_thickness=scenarioStepSettings[iwall_thickness],
  lip_style=scenarioStepSettings[ilip_style],
  chambers=scenarioStepSettings[ichambers],
  irregular_subdivisions=scenarioStepSettings[iirregular_subdivisions],
  separator_positions=scenarioStepSettings[iseparator_positions],
  magnet_diameter=scenarioStepSettings[imagnet_diameter],
  screw_depth=scenarioStepSettings[iscrew_depth],
  center_magnet_diameter = scenarioStepSettings[icenter_magnet_diameter], 
  center_magnet_thickness = scenarioStepSettings[icenter_magnet_thickness],
  hole_overhang_remedy=scenarioStepSettings[ihole_overhang_remedy],
  box_corner_attachments_only=scenarioStepSettings[ibox_corner_attachments_only],
  floor_thickness=scenarioStepSettings[ifloor_thickness],
  cavity_floor_radius=scenarioStepSettings[icavity_floor_radius],
  efficient_floor=scenarioStepSettings[iefficient_floor],
  half_pitch=scenarioStepSettings[ihalf_pitch],
  flat_base=scenarioStepSettings[iflat_base],
  fingerslide=scenarioStepSettings[ifingerslide],
  fingerslide_radius=scenarioStepSettings[ifingerslide_radius],
  tapered_corner=scenarioStepSettings[itapered_corner],
  tapered_corner_size=scenarioStepSettings[itapered_corner_size],
  tapered_setback=scenarioStepSettings[itapered_setback],
  wallcutout_enabled=scenarioStepSettings[iwallcutout_enabled],
  wallcutout_walls=scenarioStepSettings[iwallcutout_walls],
  wallcutout_width=scenarioStepSettings[iwallcutout_width],
  wallcutout_angle=scenarioStepSettings[iwallcutout_angle],
  wallcutout_height=scenarioStepSettings[iwallcutout_height],
  wallcutout_corner_radius=scenarioStepSettings[iwallcutout_corner_radius],
  wallpattern_enabled=scenarioStepSettings[iwallpattern_enabled],
  wallpattern_hexgrid=scenarioStepSettings[iwallpattern_hexgrid],
  wallpattern_walls=scenarioStepSettings[iwallpattern_walls],
  wallpattern_fill=scenarioStepSettings[iwallpattern_fill],
  wallpattern_hole_sides=scenarioStepSettings[iwallpattern_hole_sides],
  wallpattern_hole_size=scenarioStepSettings[iwallpattern_hole_size],
  wallpattern_hole_spacing=scenarioStepSettings[iwallpattern_hole_spacing],
  cutx=scenarioStepSettings[icutx],
  cuty=scenarioStepSettings[icuty],
  help=help);
// include <gridfinity_modules.scad>
use <../gridfinity_tray.scad>
//use <modules/gridfinity_cup_modules.scad>
include <../modules/functions_general.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "demo"; //["demo","verticalcompartments","horizontalcompartments","traycornerradius","floorheight","magnet","custom"]
showtext = true;

//Include help info in the logs
help=false;
setViewPort=true;

module end_of_customizer_opts() {}
itraycornerradius = 0;
itrayzpos = 1;
itrayspacing = 2;
itrayverticalcompartments = 3;
itrayhorizontalcompartments = 4;
itraycustomcompartments = 5;
traysettingscount=6;

iwidth=traysettingscount;
idepth=1+traysettingscount;
iheight=2+traysettingscount;
iposition=3+traysettingscount;
ifilled_in=4+traysettingscount;
ilabel=5+traysettingscount;
ilabel_width=6+traysettingscount;
iwall_thickness=7+traysettingscount;
ilip_style=8+traysettingscount;
ichambers=9+traysettingscount;
iirregular_subdivisions=10+traysettingscount;
iseparator_positions=11+traysettingscount;
imagnet_diameter=12+traysettingscount;
iscrew_depth=13+traysettingscount;
icenter_magnet_diameter=14+traysettingscount;
icenter_magnet_thickness=15+traysettingscount;
ihole_overhang_remedy=16+traysettingscount;
ibox_corner_attachments_only=17+traysettingscount;
ifloor_thickness=18+traysettingscount;
icavity_floor_radius=19+traysettingscount;
iefficient_floor=20+traysettingscount;
ihalf_pitch=21+traysettingscount;
iflat_base=22+traysettingscount;
ifingerslide=23+traysettingscount;
ifingerslide_radius=24+traysettingscount;
itapered_corner=25+traysettingscount;
itapered_corner_size=26+traysettingscount;
itapered_setback=27+traysettingscount;
iwallcutout_enabled=28+traysettingscount;
iwallcutout_walls=29+traysettingscount;
iwallcutout_width=30+traysettingscount;
iwallcutout_angle=31+traysettingscount;
iwallcutout_height=32+traysettingscount;
iwallcutout_corner_radius=33+traysettingscount;
iwallpattern_enabled=34+traysettingscount;
iwallpattern_hexgrid=35+traysettingscount;
iwallpattern_walls=36+traysettingscount;
iwallpattern_fill=37+traysettingscount;
iwallpattern_hole_sides=38+traysettingscount;
iwallpattern_hole_size=39+traysettingscount;
iwallpattern_hole_spacing=40+traysettingscount;
icutx=41+traysettingscount;
icuty=42+traysettingscount;

$vpr = setViewPort ? [60,0,320] : $vpr;
$vpt = setViewPort ? [32,13,16] : $vpt; //shows translation (i.e. won't be affected by rotate and zoom)
$vpf = setViewPort ? 25 : $vpf; //shows the FOV (Field of View) of the view [Note: Requires version 2021.01]
$vpd = setViewPort ? 280 : $vpd;//shows the camera distance [Note: Requires version 2015.03]
     
//Basic cup default settings for demo
defaultDemoSetting = 
    //TrayCornerRadius, TrayZpos, TraySpacing, TrayVerticalCompartments, TrayHorizontalCompartments, TrayCustomCompartments
    [2,0,3,1,1,"",
  
    //Gridfinity settins
    //width, depth, height, filled_in, label, label_width
    3,2,1,"default","off","disabled",1.5,
    //wall_thickness, lip_style, chambers, irregular_subdivisions, separator_positions
    0.95, "normal", 1, false, [], 
    //magnet_diameter, screw_depth, icenter_magnet_diameter, icenter_magnet_thickness, hole_overhang_remedy, box_corner_attachments_only
    0, 0, 0, 0, 2, false, 
    //floor_thickness, cavity_floor_radius, efficient_floor, half_pitch, flat_base
    0.7, -1, false, false, false, 
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
   
scenarioSteps = 
  scenario == "demo" ? [["Tray",5,[]],
      ["catchall",false, [[itraycornerradius, 1],[ifloor_thickness, 10]]],
      ["parts holder",false, [[itraycornerradius, 5],[ifloor_thickness, 10],[itrayhorizontalcompartments, 2],[itrayverticalcompartments, 3]]],
      ["custom parts1",false, [[iwidth, 3],[idepth, 2],[iheight,2],[ifilled_in, "notstackable"],[itraycustomcompartments, "0, 0, 0.5, 2, 2, 6|0.5, 0, 0.5, 2,2, 6|1, 0, 2, 1|1, 1, 2, 1"]]],
      ["custom parts1",false, [[iwidth, 4],[idepth, 3],[iheight,1],[ifilled_in, "notstackable"],[itraycustomcompartments, "0, 0, 2, 1.5, 1, 1|0, 1.5, 2, 1.5, 1, 1|2, 0, 2, 3,6"]]],
      ["walled catchall ",false, [[itraycornerradius, 1],[ifloor_thickness, 10], [iheight,5],
      [iwallpattern_enabled,true],[iwallpattern_walls,[0,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,90],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]]]
      
  : scenario == "traycornerradius" ? [["Tray Corner Radius", 3, [[ifilled_in, "notstackable"]]],
      ["1",false, [[itraycornerradius, 1]]],
      ["2",false, [[itraycornerradius, 2]]],
      ["4",false, [[itraycornerradius, 4]]]]
      
  : scenario == "verticalcompartments" ? [["Vertical Compartments", 4, [[ifilled_in, "on"]]],
      ["0",false, [[itrayverticalcompartments, 0]]],
      ["1",false, [[itrayverticalcompartments, 1]]],
      ["2",false, [[itrayverticalcompartments, 2]]],
      ["4",false, [[itrayverticalcompartments, 4]]]]

  : scenario == "horizontalcompartments" ? [["Horizontal Compartments", 4, [[ifilled_in, "on"]]],
      ["0",false, [[itrayhorizontalcompartments, 0]]],
      ["1",false, [[itrayhorizontalcompartments, 1]]],
      ["2",false, [[itrayhorizontalcompartments, 2]]],
      ["4",false, [[itrayhorizontalcompartments, 4]]]]
      
  : scenario == "magnet" ? [["Tray Magnet",5,[]],
     ["6mm x 2.4mm",true, [[icenter_magnet_diameter, 6], [icenter_magnet_thickness, 2.4]]],
     ["10mm x 5mm",true, [[icenter_magnet_diameter, 10], [icenter_magnet_thickness, 5]]],
     ["15mm x 5mm",true, [[icenter_magnet_diameter, 15], [icenter_magnet_thickness, 5]]],
     ["20mm x 5mm",true, [[icenter_magnet_diameter, 20], [icenter_magnet_thickness, 5]]],
     ["off",true, []]]
    
  : scenario == "floorheight" ? [["Floor height",4,[[itrayverticalcompartments, 2],[iheight, 2]]],
     ["5mm",false, [[ifloor_thickness, 5]]],
     ["10mm",false, [[ifloor_thickness, 10]]],
     ["filledin",false, [[ifilled_in, "on"]]],
     ["filledin not stackable",false, [[ifilled_in, "notstackable"]]]]

  : scenario == "custom" ? [["Custom",3,[]],
      ["1",false, [[iwidth, 4],[idepth, 3],[iheight,2],[ifilled_in, "notstackable"],[itraycustomcompartments, "0, 0, 0.5, 3, 2, 6|0.5, 0, 0.5, 3,2, 6|1, 0, 3, 1.5|1, 1.5, 3, 1.5"]]],
      ["2",false, [[iwidth, 4],[idepth, 3],[iheight,1],[ifilled_in, "notstackable"],[itraycustomcompartments, "0, 0, 2, 1.5, 1, 1|0, 1.5, 2, 1.5, 1, 1|2, 0, 2, 3,6"]]],
      ["3",false, [[iwidth, 4],[idepth, 3],[iheight,1.5],[ifilled_in, "on"],[itraycustomcompartments, "0,0,0.5,1.5,1,1|0.5,0,0.5,1.5,1,2|1,0,0.5,1.5,1,3|1.5,0,0.5,1.5,1,4|0,1.5,0.5,1.5,1,1|0.5,1.5,0.5,1.5,2,1|1,1.5,0.5,1.5,3,1|1.5,1.5,0.5,1.5,4,1|2, 0, 2, 3,6"]]]]

   : [["unknown scenario",[]]];

scenarioDefaults = scenarioSteps[0];
animationStep = len(scenarioSteps) >= round($t*(len(scenarioSteps)-1)) ? scenarioSteps[min(round($t*(len(scenarioSteps)-1))+1,len(scenarioSteps)-1)] : scenarioSteps[1];  
scenarioStepSettings = replace_Items(concat(scenarioDefaults[2],animationStep[2]), defaultDemoSetting);

echo("🟧gridfinity_tray", scenario = scenario, steps=len(scenarioSteps)-1, t=$t, time=$t*(len(scenarioSteps)-1), animationStep=animationStep, scenarioStepSettings=scenarioStepSettings);

if(showtext)
color("GhostWhite")
//translate([-5,-45,-5])
//rotate($vpr)
translate($vpt)
rotate($vpr)
translate([0,-45,60])
 linear_extrude(height = 0.1)
 text(str(scenarioDefaults[0], " - ", animationStep[0]), size=5,halign="center");

if(scenarioDefaults[0] != "unknown scenario")
rotate(animationStep[1] ? [180,0,0] : [0,0,0]) 
translate(animationStep[1] ? [0,-gridfinity_pitch,0] : [0,0,0])
gridfinity_tray(
  tray_spacing = scenarioStepSettings[itrayspacing],
  tray_corner_radius = scenarioStepSettings[itraycornerradius], 
  tray_zpos = scenarioStepSettings[itrayzpos], 
  tray_vertical_compartments = scenarioStepSettings[itrayverticalcompartments],
  tray_horizontal_compartments = scenarioStepSettings[itrayhorizontalcompartments],
  tray_custom_compartments = scenarioStepSettings[itraycustomcompartments],
  
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
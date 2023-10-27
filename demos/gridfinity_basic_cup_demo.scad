// include <gridfinity_modules.scad>
use <../gridfinity_basic_cup.scad>
use <../modules/gridfinity_cup_modules.scad>
include <../modules/functions_general.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "basiccup"; //["demos","basiccup","position","chambers","label", "halfpitch", "lip_style","fingerslide","basecorner","wallpattern","wallcutout","taperedcorner","floorthickness","filledin","efficient_floor","box_corner_attachments_only","flatbase"]
height = 5;
showtext = true;

//Include help info in the logs
help=false;
setViewPort=true;

module end_of_customizer_opts() {}

iwidth=0;
idepth=1;
iheight=2;
iposition=3;
ifilled_in=4;
ilabel=5;
ilabel_width=6;
iwall_thickness=7;
ilip_style=8;
ichambers=9;
iirregular_subdivisions=10;
iseparator_positions=11;
imagnet_diameter=12;
iscrew_depth=13;
ihole_overhang_remedy=14;
ibox_corner_attachments_only=15;
ifloor_thickness=16;
icavity_floor_radius=17;
iefficient_floor=18;
ihalf_pitch=19;
iflat_base=20;
ifingerslide=21;
ifingerslide_radius=22;
itapered_corner=23;
itapered_corner_size=24;
itapered_setback=25;
iwallcutout_enabled=26;
iwallcutout_walls=27;
iwallcutout_width=28;
iwallcutout_angle=29;
iwallcutout_height=30;
iwallcutout_corner_radius=31;
iwallpattern_enabled=32;
iwallpattern_hexgrid=33;
iwallpattern_walls=34;
iwallpattern_fill=35;
iwallpattern_hole_sides=36;
iwallpattern_hole_size=37;
iwallpattern_hole_spacing=38;
icutx=39;
icuty=40;

$vpr = setViewPort ? [60,0,320] : $vpr;
//$vpr = [240,0,40];
$vpt = setViewPort ? [32,13,16] : $vpt; //shows translation (i.e. won't be affected by rotate and zoom)
$vpf = setViewPort ? 25 : $vpf; //shows the FOV (Field of View) of the view [Note: Requires version 2021.01]
$vpd = setViewPort ? 300 : $vpd;//shows the camera distance [Note: Requires version 2015.03]

//Basic cup default settings for demo
defaultDemoSetting = 
    //width, depth, height, filled_in, label, label_width
    [3,2,height,"default","off","disabled",1.5,
    //wall_thickness, lip_style, chambers, irregular_subdivisions, separator_positions
    0.95, "normal", 1, false, [], 
    //magnet_diameter, screw_depth, hole_overhang_remedy, box_corner_attachments_only
    0, 0, true, false, 
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
selectedScenario = 
  scenario == "basiccup" ? [["",1,[]],
      ["basiccup",false, []]]
 
   : scenario == "basiccupdemo" ? [["Bin Height",16,[]],
      ["basiccup",false, []],
      ["multi chamber",false, [[ichambers, 3]]],
      ["multi chamber",false, [[ichambers, 6]]],
      ["efficient floor",false, [[iefficient_floor,true]]],
      ["half pitch",false, [[ihalf_pitch, true], [iefficient_floor,false]]],
      ["half pitch with efficient floor",false, [[ihalf_pitch, true], [iefficient_floor,true]]],
      ["label full",false, [[ilabel, "center"],[ilabel_width, 3],[ichambers, 0]]],
      ["label left",false, [[ilabel, "left"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["label right",false, [[ilabel, "right"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["label center",false, [[ilabel, "center"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["label left",false, [[ilabel, "left"],[ilabel_width, 1.5],[ichambers, 3]]],
      ["label right",false, [[ilabel, "right"],[ilabel_width, 1.5],[ichambers, 3]]],
      ["label center",false, [[ilabel, "center"],[ilabel_width, 1.5],[ichambers, 3]]],
      ["label left chamber",false, [[ilabel, "leftchamber"],[ilabel_width, 0.5],[ichambers, 3]]],
      ["label right chamber",false, [[ilabel, "rightchamber"],[ilabel_width, 0.5],[ichambers, 3]]],
      ["label center chamber",false, [[ilabel, "centerchamber"],[ilabel_width, 0.5],[ichambers, 3]]]]
      
  : scenario == "position" ? [["",3,[]],
      ["default",false, [[iposition, "default"]]],
      ["center",false, [[iposition, "center"]]],
      ["zero",false, [[iposition, "zero"]]]]
      
  : scenario == "lip_style" ? [["Lip Style",3,[[icuty, true]]],
      ["normal",false, [[ilip_style, "normal"]]],
      ["reduced",false, [[ilip_style, "reduced"]]],
      ["none",false, [[ilip_style, "none"]]]]
      
  : scenario == "fingerslide" ? [["Finger Slide",9,[[icuty, true]]],
      ["rounded 5mm",false, [[ifingerslide, "rounded"],[ifingerslide_radius, 5]]],
      ["chamfered 5mm",false, [[ifingerslide, "chamfered"],[ifingerslide_radius, 5]]],
      ["rounded 8mm (default)",false, [[ifingerslide, "rounded"],[ifingerslide_radius, 8]]],
      ["chamfered 8mm",false, [[ifingerslide, "chamfered"],[ifingerslide_radius, 8]]],
      ["rounded 12mm",false, [[ifingerslide, "rounded"],[ifingerslide_radius, 12]]],
      ["chamfered 12mm",false, [[ifingerslide, "chamfered"],[ifingerslide_radius, 12]]],
      ["rounded 20mm",false, [[ifingerslide, "rounded"],[ifingerslide_radius, 20]]],
      ["chamfered 20mm",false, [[ifingerslide, "chamfered"],[ifingerslide_radius, 20]]],
      ["none",false, [[ifingerslide, "none"]]]]
      
   : scenario == "basecorner" ? [["Internal Corner",4,[[icuty, true]]],
      ["normal",false, [[icavity_floor_radius, -1]]],
      ["0mm",false, [[icavity_floor_radius, 0]]],
      ["1mm",false, [[icavity_floor_radius, 1]]],
      ["2mm",false, [[icavity_floor_radius, 2]]]]
      
   : scenario == "filledin" ? [["Filled in",3,[[icuty, true]]],
      ["on",false, [[ifilled_in, "on"]]],
      ["on, stackable false",false, [[ifilled_in, "notstackable"]]],
      ["off",false, [[ifilled_in, "off"]]]]
      
   : scenario == "floorthickness" ? [["Floor Thickness",5,[[icuty, true]]],
      ["0.7mm (default)",false, [[ifloor_thickness, 0.7]]],
      ["1mm",false, [[ifloor_thickness, 1]]],
      ["5mm",false, [[ifloor_thickness, 5]]],
      ["10mm",false, [[ifloor_thickness, 10]]],
      ["20mm",false, [[ifloor_thickness, 20]]]]
      
  : scenario == "label" ? [["Label",10,[]],
      ["full",false, [[ilabel, "center"],[ilabel_width, 3],[ichambers, 0]]],
      ["left",false, [[ilabel, "left"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["right",false, [[ilabel, "right"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["center",false, [[ilabel, "center"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["left",false, [[ilabel, "left"],[ilabel_width, 1.5],[ichambers, 3]]],
      ["right",false, [[ilabel, "right"],[ilabel_width, 1.5],[ichambers, 3]]],
      ["center",false, [[ilabel, "center"],[ilabel_width, 1.5],[ichambers, 3]]],
      ["leftchamber",false, [[ilabel, "leftchamber"],[ilabel_width, 0.5],[ichambers, 3]]],
      ["rightchamber",false, [[ilabel, "rightchamber"],[ilabel_width, 0.5],[ichambers, 3]]],
      ["centerchamber",false, [[ilabel, "centerchamber"],[ilabel_width, 0.5],[ichambers, 3]]]]
      
   : scenario == "chambers" ? [["",5,[]],
      ["1 chamber",false, [[ichambers, 1]]],
      ["2 chambers",false, [[ichambers, 2]]],
      ["3 chambers",false, [[ichambers, 3]]],     
      ["4 chambers",false, [[ichambers, 4]]],     
      ["irregular chambers",false, [[iirregular_subdivisions, true], [iseparator_positions, [0.25, 0.5, 1, 2]]]]]
  
  : scenario == "efficient_floor" ? [["Efficient Floor",4,[[icuty, true]]],
      ["enabled",false, [[iefficient_floor,true]]],
      ["disabled",false, [[iefficient_floor,false]]],
      ["enabled",true, [[iefficient_floor,true]]],
      ["disabled",true, [[iefficient_floor,false]]]]
      
  : scenario == "flatbase" ? [["Flat Base",6,[[icuty, true]]],
      ["enabled",false, [[iflat_base,true]]],
      ["enabled with efficient floor",false, [[iflat_base, true], [iefficient_floor,true]]],
      ["disabled",false, [[iflat_base,false]]],
      ["enabled",true, [[iflat_base,true]]],
      ["enabled with efficient floor",true, [[iflat_base, true], [iefficient_floor,true]]],
      ["disabled",true, [[iflat_base,false]]]]

  : scenario == "box_corner_attachments_only" ? [["Corner Attachments only",2,[[imagnet_diameter,6.5],[iscrew_depth,6]]],
      ["enabled",true, [[ibox_corner_attachments_only,true]]],
      ["disabled",true, [[ibox_corner_attachments_only,false]]]]
      
  : scenario == "halfpitch" ? [["Half Pitch",6,[[icuty, true]]],
      ["enabled",false, [[ihalf_pitch, true], [iefficient_floor,false]]],
      ["enabled with efficient floor",false, [[ihalf_pitch, true], [iefficient_floor,true]]],
      ["disabled",false, [[ihalf_pitch, false], [iefficient_floor,false]]],
      ["enabled",true, [[ihalf_pitch, true], [iefficient_floor,false]]],
      ["enabled with efficient floor",true, [[ihalf_pitch, true], [iefficient_floor,true]]],
      ["disabled",true, [[ihalf_pitch, false], [iefficient_floor,false]]]]
      
   : scenario == "wallcutout" ? [["Wall Cutout",11,[[iwallcutout_enabled, true],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,0],[iwallcutout_corner_radius,5]]],
      ["front",false, [[iwallcutout_walls,[1,0,0,0]]]],
      ["back",false, [[iwallcutout_walls,[0,1,0,0]]]],
      ["left",false, [[iwallcutout_walls,[0,0,1,0]]]],
      ["right",false, [[iwallcutout_walls,[0,0,0,1]]]],
      ["all sides",false, [[iwallcutout_walls,[1,1,1,1]]]],
      ["floor height",false, [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_height,-1]]],
      ["width 75mm",false, [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,75]]],
      ["width 75mm",false, [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,75]]],
      ["45deg angle",false, [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_angle,45]]],
      ["corner radius 10mm",false, [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_corner_radius,10]]],
      ["depth 20mm",false, [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_height,20]]]]
      
   : scenario == "wallpattern" ? [["Wall Pattern",16,[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2], [iwallpattern_hole_size,5]]],
      ["front",false, [[iwallpattern_walls,[1,0,0,0]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["back",false, [[iwallpattern_walls,[0,1,0,0]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["left",false, [[iwallpattern_walls,[0,0,1,0]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["right",false, [[iwallpattern_walls,[0,0,0,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["square grid - diamond",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,false],[iwallpattern_hole_sides,4],[iwallpattern_fill,"none"]]],
      ["square grid - hex",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,false],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["square grid - circle",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,false],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"]]],
      ["hex grid - diamond",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,4],[iwallpattern_fill,"none"]]],
      ["hex grid - hex",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["hex grid - hex",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["hex grid - circle",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"]]],
      ["hex grid - hex space fill",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"space"]]],
      ["hex grid - hex crop fill",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"crop"]]],
      ["hex grid - corner radius 0mm",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6], [iwallpattern_fill,"crop"], [icavity_floor_radius,0]]],
      ["hex grid - hex 7.5mm",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true], [iwallpattern_hole_size,7.5],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["hex grid - hex 9mm crop fill",false, [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true], [iwallpattern_hole_size,9], [iwallpattern_hole_sides,6],[iwallpattern_fill,"crop"]]]]
      
   : scenario == "taperedcorner" ? [["Tapered Box",9,[]],
      ["",false, [[itapered_corner, "none"],[itapered_corner_size,0],[itapered_setback,-1]]],
      ["rounded",false, [[itapered_corner, "rounded"],[itapered_corner_size,0],[itapered_setback,-1]]],
      ["chamfered",false, [[itapered_corner, "chamfered"],[itapered_corner_size,0],[itapered_setback,-1]]],
      ["chamfered radius 20",false, [[itapered_corner, "chamfered"],[itapered_corner_size,20],[itapered_setback,-1]]],
      ["chamfered setback 15",false, [[itapered_corner, "chamfered"],[itapered_corner_size,20],[itapered_setback,15]]],
      ["rounded radius 20",false, [[itapered_corner, "rounded"],[itapered_corner_size,20],[itapered_setback,-1]]],
      ["rounded setback 15",false, [[itapered_corner, "rounded"],[itapered_corner_size,20],[itapered_setback,15]]],
      ["rounded to floor",false, [[itapered_corner, "rounded"],[itapered_corner_size,-1],[itapered_setback,15]]],
      ["rounded to raised floor",false, [[itapered_corner, "rounded"],[itapered_corner_size,-1],[itapered_setback,15],[ifloor_thickness, 10]]]]
      
  : scenario == "demos" ? [["Gridfinity Extended",3,[]],
      ["Demo 1",false, [[iwallpattern_enabled,true],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"],[ilabel, "center"],[ilabel_width, 1.5]]],
      ["Demo 2",false, [[iirregular_subdivisions, true], [iseparator_positions, [0.25, 0.5, 1, 2]],
      [itapered_corner, "rounded"],[itapered_corner_size,30],[itapered_setback,15]]],
      ["Demo 3",false, [[ifloor_thickness, 10], [icavity_floor_radius, 0],
          [iwallpattern_enabled,true],[iwallpattern_walls,[0,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]]]
   : [];

scenarioDefaults = selectedScenario[0];
animationStep = len(selectedScenario) >= round($t*(len(selectedScenario)-1)) ? selectedScenario[min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1)] : selectedScenario[1];  
currentStepSettings = replace_Items(concat(scenarioDefaults[2],animationStep[2]), defaultDemoSetting);

echo(scenario = scenario, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1));
echo(animationStep=animationStep);
echo(currentStepSettings=currentStepSettings);

if(showtext)
color("GhostWhite")
translate([-5,-45,-5])
rotate($vpr)
 linear_extrude(height = 0.1)
 text(str(scenarioDefaults[0], " ", animationStep[0]), size=5,halign="center");

//translate(animation[1] ? [0,gridfinity_pitch,0] : [0,0,0])
rotate(animationStep[1] ? [180,0,0] : [0,0,0]) 
translate(animationStep[1] ? [0,-gridfinity_pitch,-gridfinity_pitch] : [0,0,0])
gridfinity_basic_cup(
  width = currentStepSettings[iwidth],
  depth = currentStepSettings[idepth],
  height = currentStepSettings[iheight],
  position = currentStepSettings[iposition],
  filled_in = currentStepSettings[ifilled_in],
  label=currentStepSettings[ilabel],
  label_width=currentStepSettings[ilabel_width],
  wall_thickness=currentStepSettings[iwall_thickness],
  lip_style=currentStepSettings[ilip_style],
  chambers=currentStepSettings[ichambers],
  irregular_subdivisions=currentStepSettings[iirregular_subdivisions],
  separator_positions=currentStepSettings[iseparator_positions],
  magnet_diameter=currentStepSettings[imagnet_diameter],
  screw_depth=currentStepSettings[iscrew_depth],
  hole_overhang_remedy=currentStepSettings[ihole_overhang_remedy],
  box_corner_attachments_only=currentStepSettings[ibox_corner_attachments_only],
  floor_thickness=currentStepSettings[ifloor_thickness],
  cavity_floor_radius=currentStepSettings[icavity_floor_radius],
  efficient_floor=currentStepSettings[iefficient_floor],
  half_pitch=currentStepSettings[ihalf_pitch],
  flat_base=currentStepSettings[iflat_base],
  fingerslide=currentStepSettings[ifingerslide],
  fingerslide_radius=currentStepSettings[ifingerslide_radius],
  tapered_corner=currentStepSettings[itapered_corner],
  tapered_corner_size=currentStepSettings[itapered_corner_size],
  tapered_setback=currentStepSettings[itapered_setback],
  wallcutout_enabled=currentStepSettings[iwallcutout_enabled],
  wallcutout_walls=currentStepSettings[iwallcutout_walls],
  wallcutout_width=currentStepSettings[iwallcutout_width],
  wallcutout_angle=currentStepSettings[iwallcutout_angle],
  wallcutout_height=currentStepSettings[iwallcutout_height],
  wallcutout_corner_radius=currentStepSettings[iwallcutout_corner_radius],
  wallpattern_enabled=currentStepSettings[iwallpattern_enabled],
  wallpattern_hexgrid=currentStepSettings[iwallpattern_hexgrid],
  wallpattern_walls=currentStepSettings[iwallpattern_walls],
  wallpattern_fill=currentStepSettings[iwallpattern_fill],
  wallpattern_hole_sides=currentStepSettings[iwallpattern_hole_sides],
  wallpattern_hole_size=currentStepSettings[iwallpattern_hole_size],
  wallpattern_hole_spacing=currentStepSettings[iwallpattern_hole_spacing],
  cutx=currentStepSettings[icutx],
  cuty=currentStepSettings[icuty],
  help=help);
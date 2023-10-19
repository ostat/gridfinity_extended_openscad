// include <gridfinity_modules.scad>
use <gridfinity_basic_cup.scad>
use <modules/gridfinity_cup_modules.scad>
include <modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "basiccup"; //["demos","basiccup","chambers","label", "halfpitch", "lip_style","fingerslide","basecorner","wallpattern","wallcutout","taperedcorner","floorthickness","filledin"]
//Include help info in the logs
help=false;

module end_of_customizer_opts() {}

iwidth=0;
idepth=1;
iheight=2;
ifilled_in=3;
ilabel=4;
ilabel_width=5;
iwall_thickness=6;
ilip_style=7;
ichambers=8;
iirregular_subdivisions=9;
iseparator_positions=10;
imagnet_diameter=11;
iscrew_depth=12;
ihole_overhang_remedy=13;
ibox_corner_attachments_only=14;
ifloor_thickness=15;
icavity_floor_radius=16;
iefficient_floor=17;
ihalf_pitch=18;
iflat_base=19;
ifingerslide=20;
ifingerslide_radius=21;
itapered_corner=22;
itapered_corner_size=23;
itapered_setback=24;
iwallcutout_enabled=25;
iwallcutout_walls=26;
iwallcutout_width=27;
iwallcutout_angle=28;
iwallcutout_height=29;
iwallcutout_corner_radius=30;
iwallpattern_enabled=31;
iwallpattern_hexgrid=32;
iwallpattern_walls=33;
iwallpattern_fill=34;
iwallpattern_hole_sides=35;
iwallpattern_hole_size=36;
iwallpattern_hole_spacing=37;
icutx=38;
icuty=39;

$vpr = [60,0,320];
//$vpr = [240,0,40];
$vpt = [32,13,16]; //shows translation (i.e. won't be affected by rotate and zoom)
$vpf = 25; //shows the FOV (Field of View) of the view [Note: Requires version 2021.01]
$vpd = 300;//shows the camera distance [Note: Requires version 2015.03]
     
function replace_Items(keyValueArray, arr) = !(len(keyValueArray)>0) ? arr : let(
    currentKeyValue = keyValueArray[0],
    keyValueArrayNext = remove_item(keyValueArray,0),
    updatedList = replace(arr, currentKeyValue[1],currentKeyValue[0])
) concat(replace_Items(keyValueArrayNext, updatedList));

function replace(list,value,position) = let (
  l1 = partial(list,0,position-1), 
  l2 = partial(list,position+1,len(list)-1)
  ) concat(l1,[value],l2);

function partial(list,start,end) = [for (i = [start:end]) list[i]];

function remove_item(list,position) = [for (i = [0:len(list)-1]) if (i != position) list[i]];

//Basic cup default settings for demo
defaultDemoSetting = 
    //width, depth, height, filled_in, label, label_width
    [3,2,5,false,"disabled",1.5,
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
scenarioSteps = 
  scenario == "basiccup" ? [["",[]],
      ["basiccup",false, false, []]]
      
  : scenario == "lip_style" ? [["Lip Style",[[icuty, true]]],
      ["normal",false, [[ilip_style, "normal"]]],
      ["reduced",false, [[ilip_style, "reduced"]]],
      ["none",false, [[ilip_style, "none"]]]]
      
  : scenario == "fingerslide" ? [["Finger Slide",[[icuty, true]]],
      ["rounded 5mm",false, [[ifingerslide, "rounded"],[ifingerslide_radius, 5]]],
      ["champhered 5mm",false, [[ifingerslide, "champhered"],[ifingerslide_radius, 5]]],
      ["rounded 8mm (default)",false, [[ifingerslide, "rounded"],[ifingerslide_radius, 8]]],
      ["champhered 8mm (default)",false, [[ifingerslide, "champhered"],[ifingerslide_radius, 8]]],
      ["rounded 12mm",false, [[ifingerslide, "rounded"],[ifingerslide_radius, 12]]],
      ["champhered 12mm",false, [[ifingerslide, "champhered"],[ifingerslide_radius, 12]]],
      ["rounded 20mm",false, [[ifingerslide, "rounded"],[ifingerslide_radius, 20]]],
      ["champhered 20mm",false, [[ifingerslide, "champhered"],[ifingerslide_radius, 20]]],
      ["none",false, [[ifingerslide, "none"]]]]
      
   : scenario == "basecorner" ? [["base Inter Corner",[[icuty, true]]],
      ["normal",false, [[icavity_floor_radius, -1]]],
      ["0mm",false, [[icavity_floor_radius, 0]]],
      ["1mm",false, [[icavity_floor_radius, 1]]],
      ["2mm",false, [[icavity_floor_radius, 2]]]]
      
   : scenario == "filledin" ? [["Filled in",[[icuty, true]]],
      ["on",false, [[ifilled_in, true]]],
      ["off",false, [[ifilled_in, false]]]]
      
   : scenario == "floorthickness" ? [["Floor Thickness",[[icuty, true]]],
      ["0.7mm (default)",false, [[ifloor_thickness, 0.7]]],
      ["1mm",false, [[ifloor_thickness, 1]]],
      ["5mm",false, [[ifloor_thickness, 5]]],
      ["10mm",false, [[ifloor_thickness, 10]]],
      ["20mm",false, [[ifloor_thickness, 20]]]]
      
  : scenario == "label" ? [["Label",[]],
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
      
   : scenario == "chambers" ? [["",[]],
      ["1 chamber",false, [[ichambers, 1]]],
      ["2 chambers",false, [[ichambers, 2]]],
      ["3 chambers",false, [[ichambers, 3]]],     
      ["4 chambers",false, [[ichambers, 4]]],     
      ["irregular chambers",false, [[iirregular_subdivisions, true], [iseparator_positions, [0.25, 0.5, 1, 2]]]]]
      
  : scenario == "halfpitch" ? [["Half Pitch",[[icuty, true]]],
      ["endabled",false, [[ihalf_pitch, true], [iefficient_floor,false]]],
      ["enabled with efficient floor",false, [[ihalf_pitch, true], [iefficient_floor,true]]],
      ["disabled",false, [[ihalf_pitch, false], [iefficient_floor,false]]]]
      
   : scenario == "wallcutout" ? [["Wall Cutout",[[iwallcutout_enabled, true],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,0],[iwallcutout_corner_radius,5]]],
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
      
   : scenario == "wallpattern" ? [["Wall Pattern",[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2], [iwallpattern_hole_size,5]]],
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
      
   : scenario == "taperedcorner" ? [["",[]],
      ["",false, [[itapered_corner, "none"],[itapered_corner_size,0],[itapered_setback,-1]]],
      ["rounded",false, [[itapered_corner, "rounded"],[itapered_corner_size,0],[itapered_setback,-1]]],
      ["champhered",false, [[itapered_corner, "champhered"],[itapered_corner_size,0],[itapered_setback,-1]]],
      ["champhered radius 30",false, [[itapered_corner, "champhered"],[itapered_corner_size,30],[itapered_setback,-1]]],
      ["champhered setback 15",false, [[itapered_corner, "champhered"],[itapered_corner_size,30],[itapered_setback,15]]],
      ["rounded radius 30",false, [[itapered_corner, "rounded"],[itapered_corner_size,30],[itapered_setback,-1]]],
      ["rounded setback 15",false, [[itapered_corner, "rounded"],[itapered_corner_size,30],[itapered_setback,15]]]]
      
  : scenario == "demos" ? [["Demo",[]],
      ["1",false, [[ifloor_thickness, 10], [icavity_floor_radius, 0],
          [iwallpattern_enabled,true],[iwallpattern_walls,[0,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]],
      ["2",false, [[iwallpattern_enabled,true],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"],[ilabel, "center"],[ilabel_width, 1.5]]],
      ["3",false, [[iirregular_subdivisions, true], [iseparator_positions, [0.25, 0.5, 1, 2]],
      [itapered_corner, "rounded"],[itapered_corner_size,30],[itapered_setback,15]]]]
   : [];

scenarioDefaults = scenarioSteps[0];
animationStep = len(scenarioSteps) >= round($t*(len(scenarioSteps)-1)) ? scenarioSteps[min(round($t*(len(scenarioSteps)-1))+1,len(scenarioSteps)-1)] : scenarioSteps[1];  
scenarioStepSettings = replace_Items(concat(scenarioDefaults[1],animationStep[2]), defaultDemoSetting);

echo(scenario = scenario, steps=len(scenarioSteps)-1, t=$t, time=$t*(len(scenarioSteps)-1));
echo(animationStep=animationStep);
echo(scenarioStepSettings=scenarioStepSettings);

color("GhostWhite")
translate([0,-40,0])
rotate($vpr)
 linear_extrude(height = 0.1)
 text(str(scenarioDefaults[0], " ", animationStep[0]), size=5,halign="center");

//translate(animation[1] ? [0,gridfinity_pitch,0] : [0,0,0])
rotate(animationStep[1] ? [180,0,0] : [0,0,0]) 
translate(animationStep[1] ? [0,-gridfinity_pitch,0] : [0,0,0])
gridfinity_basic_cup(
  width = scenarioStepSettings[iwidth],
  depth = scenarioStepSettings[idepth],
  height = scenarioStepSettings[iheight],
  filled_in = false,
  label=scenarioStepSettings[ilabel],
  label_width=scenarioStepSettings[ilabel_width],
  wall_thickness=scenarioStepSettings[iwall_thickness],
  lip_style=scenarioStepSettings[ilip_style],
  chambers=scenarioStepSettings[ichambers],
  irregular_subdivisions=scenarioStepSettings[iirregular_subdivisions],
  separator_positions=scenarioStepSettings[iseparator_positions],
  magnet_diameter=scenarioStepSettings[imagnet_diameter],
  screw_depth=scenarioStepSettings[iscrew_depth],
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
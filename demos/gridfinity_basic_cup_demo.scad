// include <gridfinity_modules.scad>
use <../gridfinity_basic_cup.scad>
use <../modules/gridfinity_cup_modules.scad>
include <../modules/functions_general.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "demo"; //["demo","multi","multicutout","multipattern","basiccup","position","chambers","label", "halfpitch","lip_style","fingerslide","basecorner","sequentialbridging","wallpattern", "wallcutout","taperedcorner","floorthickness","filledin","efficient_floor", "box_corner_attachments_only","center_magnet","flatbase"]
height = -1;
width=-1;
depth=-1;
stepIndex = -1;
showtext = true;
colour = "";

//Include help info in the logs
help=false;
setViewPort=true;

multi_spacing = [0.2,0.5];

/* [Hidden] */
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
icenter_magnet_diameter=14;
icenter_magnet_thickness=15;
ihole_overhang_remedy=16;
ibox_corner_attachments_only=17;
ifloor_thickness=18;
icavity_floor_radius=19;
iefficient_floor=20;
ihalf_pitch=21;
iflat_base=22;
ifingerslide=23;
ifingerslide_radius=24;
itapered_corner=25;
itapered_corner_size=26;
itapered_setback=27;
iwallcutout_enabled=28;
iwallcutout_walls=29;
iwallcutout_width=30;
iwallcutout_angle=31;
iwallcutout_height=32;
iwallcutout_corner_radius=33;
iwallpattern_enabled=34;
iwallpattern_hexgrid=35;
iwallpattern_walls=36;
iwallpattern_dividers_enabled=37;
iwallpattern_fill=38;
iwallpattern_hole_sides=39;
iwallpattern_hole_size=40;
iwallpattern_hole_spacing=41;
icutx=42;
icuty=43;
itranslate=44;
irotate=45;

iscenarioName=0;
iscenarioCount=1;
iscenarioVp=2;
iscenariokv=3;
   
istepName=0;
istepkv=1;

selectedScenario = getScenario(scenario);
vp=selectedScenario[0][iscenarioVp];
$vpr = setViewPort ? let(vpr = getcustomVpr(vp)) is_list(vpr) ? vpr : [60,0,320] : $vpr;
//shows translation (i.e. won't be affected by rotate and zoom)
$vpt = setViewPort ? let(vpt = getcustomVpt(vp)) is_list(vpt) ? vpt : [32,13,16] : $vpt; 
//shows the camera distance [Note: Requires version 2015.03]
$vpd = setViewPort ? let(vpd = getcustomVpd(vp)) is_num(vpd) ? vpd : 280 : $vpd;
 //shows the FOV (Field of View) of the view [Note: Requires version 2021.01]
$vpf = setViewPort ? let(vpf = getcustomVpf(vp)) is_num(vpf) ? vpf : 25 : $vpf;

module end_of_customizer_opts() {}

echo("start",vp=vp, vpr = getcustomVpr(vp), vpt = getcustomVpt(vp), vpd = getcustomVpd(vp), vpf = getcustomVpf(vp));

//Basic cup default settings for demo
defaultDemoSetting = 
    //width, depth, height, filled_in, label, label_width
    [3,2,5,"default","off","disabled",1.5,
    //wall_thickness, lip_style, chambers, irregular_subdivisions, separator_positions
    0.95, "normal", 1, false, [], 
    //magnet_diameter, screw_depth, center_magnet_diameter, center_magnet_thickness, hole_overhang_remedy, box_corner_attachments_only
    0, 0, 0, 0, 2, false, 
    //floor_thickness, cavity_floor_radius, efficient_floor, half_pitch, flat_base
    0.7, -1, false, false, false, 
    //fingerslide,fingerslide_radius,
    "none", 8,
    //tapered_corner, tapered_corner_size, tapered_setback
    "none", 10, -1,
    //wallcutout_enabled, wallcutout_walls, wallcutout_width, wallcutout_angle, wallcutout_height, wallcutout_corner_radius
    false, [1,0,0,0], 0, 70, 0, 5, 
    //wallpattern_enabled, wallpattern_hexgrid, wallpattern_walls, wallpattern_dividers_enabled, wallpattern_fill, wallpattern_hole_sides, wallpattern_hole_size, wallpattern_hole_spacing
    false, true, [1,1,1,1], false, "none", 6, 5, 2, 
    //cutx,cuty,translate,rotate
    0, 0,[0,0,0],[0,0,0]];
    
function isMulti(scenario) = search("multi",scenario) == [0, 1, 2, 3, 4];
function iscustomVP(scenarioVp, length = 0) = is_list(scenarioVp) && len(scenarioVp) >= length;
function getcustomVpr(scenarioVp) = iscustomVP(scenarioVp, 1) ? let(vpr = scenarioVp[0]) is_list(vpr) && len(vpr)==3 ? vpr : false : false;
function getcustomVpt(scenarioVp) = iscustomVP(scenarioVp, 2) ? let(vpt = scenarioVp[1]) is_list(vpt) && len(vpt)==3? vpt : false : false;
function getcustomVpd(scenarioVp) = iscustomVP(scenarioVp, 3) ? let(vpd = scenarioVp[2]) is_num(vpd) ? vpd : false : false;
function getcustomVpf(scenarioVp) = iscustomVP(scenarioVp, 4) ? let(vpf = scenarioVp[3]) is_num(vpf) ? vpf : false : false;

function getScenario(scenario) = 
//[0]: seenarioName,scenarioCount,[vpr,vpt,vpd,vpf],[[key,value]]
//[1]: name,[[key,value]]

  scenario == "demo" ? [["Basic Cup",16,[],[]],
      ["Demo", [
          [iirregular_subdivisions, true], [iseparator_positions, [0.75, 2.25]],
          [iwallpattern_enabled,true],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_dividers_enabled, true],[iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [itapered_corner, "chamfered"],[itapered_corner_size,20],[itapered_setback,-1]]],
     ["Demo", [
          [iirregular_subdivisions, true], [iseparator_positions, [0.75, 2.25]],
          [iwallpattern_enabled,true],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_dividers_enabled, true],[iwallpattern_hexgrid,true],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]],
      ["Simple", []],
      ["Multi Chamber", [[ichambers, 3]]],
      ["Multi Chamber", [[ichambers, 6]]],
      ["Efficient Floor", [[iefficient_floor,true]]],
      ["Half Pitch", [[ihalf_pitch, true], [iefficient_floor,false]]],
      ["Half Pitch with Efficient Floor", [[ihalf_pitch, true], [iefficient_floor,true]]],
      ["Label Full", [[ilabel, "center"],[ilabel_width, 3],[ichambers, 0]]],
      ["Label Left", [[ilabel, "left"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["Label Right", [[ilabel, "right"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["Label Center", [[ilabel, "center"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["Label Center", [[ilabel, "center"],[ilabel_width, 1.5],[ichambers, 3]]],
      ["Label Center Chamber", [[ilabel, "centerchamber"],[ilabel_width, 0.5],[ichambers, 3]]], 
      ["Wall Cutout", [[ifloor_thickness, 1], [icavity_floor_radius, 0],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,1,0,0]],[iwallcutout_width,70],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]],
      ["Chamfered", [[iirregular_subdivisions, true], [iseparator_positions, [0.5, 1, 2]],
      [itapered_corner, "chamfered"],[itapered_corner_size,25],[itapered_setback,-1]]],
      ["Demo 3", [[ifloor_thickness, 2], [icavity_floor_radius, -1],
          [iwallpattern_enabled,true],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]]]
          
  : scenario == "basiccup" ? [["Basic Cup",1,[],[]],
      ["simple", []]]
      
  : scenario == "position" ? [["",3,[],[]],
      ["default", [[iposition, "default"]]],
      ["center", [[iposition, "center"]]],
      ["zero", [[iposition, "zero"]]]]
      
  : scenario == "lip_style" ? [["Lip Style",3,[],[[icutx, 0.5]]],
      ["normal", [[ilip_style, "normal"]]],
      ["reduced", [[ilip_style, "reduced"]]],
      ["none", [[ilip_style, "none"]]]]
      
  : scenario == "fingerslide" ? [["Finger Slide",9,[[70,0,270],[30,20,20],280],[[icutx, 0.5]]],
      ["rounded 5mm", [[ifingerslide, "rounded"],[ifingerslide_radius, 5]]],
      ["chamfered 5mm", [[ifingerslide, "chamfered"],[ifingerslide_radius, 5]]],
      ["rounded 8mm (default)", [[ifingerslide, "rounded"],[ifingerslide_radius, 8]]],
      ["chamfered 8mm", [[ifingerslide, "chamfered"],[ifingerslide_radius, 8]]],
      ["rounded 12mm", [[ifingerslide, "rounded"],[ifingerslide_radius, 12]]],
      ["chamfered 12mm", [[ifingerslide, "chamfered"],[ifingerslide_radius, 12]]],
      ["rounded 20mm", [[ifingerslide, "rounded"],[ifingerslide_radius, 20]]],
      ["chamfered 20mm", [[ifingerslide, "chamfered"],[ifingerslide_radius, 20]]],
      ["none", [[ifingerslide, "none"]]]]
      
   : scenario == "basecorner" ? [["Internal Corner",4,[],[[icutx, 0.5]]],
      ["normal", [[icavity_floor_radius, -1]]],
      ["0mm", [[icavity_floor_radius, 0]]],
      ["1mm", [[icavity_floor_radius, 1]]],
      ["2mm", [[icavity_floor_radius, 2]]]]
      
   : scenario == "filledin" ? [["Filled In",3,[],[[icutx, 0.5]]],
      ["on", [[ifilled_in, "on"]]],
      ["on, stackable false", [[ifilled_in, "notstackable"]]],
      ["off", [[ifilled_in, "off"]]]]
      
   : scenario == "floorthickness" ? [["Floor Thickness",5,[],[[icutx, 0.5]]],
      ["0.7mm (default)", [[ifloor_thickness, 0.7]]],
      ["1mm", [[ifloor_thickness, 1]]],
      ["5mm", [[ifloor_thickness, 5]]],
      ["10mm", [[ifloor_thickness, 10]]],
      ["20mm", [[ifloor_thickness, 20]]]]
      
  : scenario == "label" ? [["Label",10,[],[]],
      ["full", [[ilabel, "center"],[ilabel_width, 3],[ichambers, 0]]],
      ["left", [[ilabel, "left"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["right", [[ilabel, "right"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["center", [[ilabel, "center"],[ilabel_width, 1.5],[ichambers, 0]]],
      ["left", [[ilabel, "left"],[ilabel_width, 1.5],[ichambers, 3]]],
      ["right", [[ilabel, "right"],[ilabel_width, 1.5],[ichambers, 3]]],
      ["center", [[ilabel, "center"],[ilabel_width, 1.5],[ichambers, 3]]],
      ["leftchamber", [[ilabel, "leftchamber"],[ilabel_width, 0.5],[ichambers, 3]]],
      ["rightchamber", [[ilabel, "rightchamber"],[ilabel_width, 0.5],[ichambers, 3]]],
      ["centerchamber", [[ilabel, "centerchamber"],[ilabel_width, 0.5],[ichambers, 3]]]]
      
   : scenario == "chambers" ? [["",5,[],[]],
      ["1 chamber", [[ichambers, 1]]],
      ["2 chambers", [[ichambers, 2]]],
      ["3 chambers", [[ichambers, 3]]],     
      ["4 chambers", [[ichambers, 4]]],     
      ["irregular chambers", [[iirregular_subdivisions, true], [iseparator_positions, [0.25, 0.5, 1, 2]]]]]
  
  : scenario == "efficient_floor" ? [["Efficient Floor",4,[],[[icutx, 0.5]]],
      ["enabled", [[iefficient_floor,true]]],
      ["disabled", [[iefficient_floor,false]]],
      ["enabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iefficient_floor,true]]],
      ["disabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iefficient_floor,false]]]]
      
  : scenario == "flatbase" ? [["Flat Base",6,[],[[icutx, 0.5]]],
      ["enabled",[[iflat_base,true]]],
      ["enabled with efficient floor", [[iflat_base, true], [iefficient_floor,true]]],
      ["disabled", [[iflat_base,false]]],
      ["enabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iflat_base,true]]],
      ["enabled with efficient floor", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iflat_base, true], [iefficient_floor,true]]],
      ["disabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iflat_base,false]]]]

  : scenario == "box_corner_attachments_only" ? [["Corner Attachments only",2,[],[[imagnet_diameter,6.5],[iscrew_depth,6]]],
      ["enabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ibox_corner_attachments_only,true]]],
      ["disabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ibox_corner_attachments_only,false]]]]

  : scenario == "sequentialbridging" ? [["Sequential Bridging",2,[],[[imagnet_diameter,6.5],[iscrew_depth,6]]],
      ["1", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,1]]],
      ["2", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,2]]],
      ["3", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,3]]],
      ["disabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,0]]]]
      
  : scenario == "halfpitch" ? [["Half Pitch",6,[],[[icutx, 0.5]]],
      ["enabled", [[ihalf_pitch, true], [iefficient_floor,false]]],
      ["enabled with efficient floor",false, [[ihalf_pitch, true], [iefficient_floor,true]]],
      ["disabled", [[ihalf_pitch, false], [iefficient_floor,false]]],
      ["enabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihalf_pitch, true], [iefficient_floor,false]]],
      ["enabled with efficient floor", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihalf_pitch, true], [iefficient_floor,true]]],
      ["disabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihalf_pitch, false], [iefficient_floor,false]]]]
      
  : scenario == "center_magnet" ? [["Center Magnet",5,[],[]],
     ["6mm x 2.4mm", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [icenter_magnet_diameter, 6], [icenter_magnet_thickness, 2.4]]],
     ["10mm x 5mm", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [icenter_magnet_diameter, 10], [icenter_magnet_thickness, 5]]],
     ["15mm x 5mm", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [icenter_magnet_diameter, 15], [icenter_magnet_thickness, 5]]],
     ["20mm x 5mm", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [icenter_magnet_diameter, 20], [icenter_magnet_thickness, 5]]],
     ["off", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]]]]]
     
   : scenario == "wallcutout" ? [["Wall Cutout",11,[],[[iwallcutout_enabled, true],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,0],[iwallcutout_corner_radius,5]]],
      ["front", [[iwallcutout_walls,[1,0,0,0]]]],
      ["back", [[iwallcutout_walls,[0,1,0,0]]]],
      ["left", [[iwallcutout_walls,[0,0,1,0]]]],
      ["right", [[iwallcutout_walls,[0,0,0,1]]]],
      ["all sides", [[iwallcutout_walls,[1,1,1,1]]]],
      ["floor height", [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_height,-1]]],
      ["width 75mm", [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,75]]],
      ["width 75mm", [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,75]]],
      ["45deg angle", [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_angle,45]]],
      ["corner radius 10mm", [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_corner_radius,10]]],
      ["depth 20mm", [[iwallcutout_walls,[1,0,0,0]],[iwallcutout_height,20]]]]
      
   : scenario == "wallpattern" ? [["Wall Pattern",16,[],[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2], [iwallpattern_hole_size,5]]],
      ["front", [[iwallpattern_walls,[1,0,0,0]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["back", [[iwallpattern_walls,[0,1,0,0]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["left", [[iwallpattern_walls,[0,0,1,0]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["right", [[iwallpattern_walls,[0,0,0,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["chambers", [[iwallpattern_walls,[0,0,0,0]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],[ichambers, 3],[iwallpattern_dividers_enabled,true]]],
      ["square grid - diamond", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,false],[iwallpattern_hole_sides,4],[iwallpattern_fill,"none"]]],
      ["square grid - hex", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,false],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["square grid - circle", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,false],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"]]],
      ["hex grid - diamond", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,4],[iwallpattern_fill,"none"]]],
      ["hex grid - hex", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["hex grid - hex", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["hex grid - circle", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"]]],
      ["hex grid - hex space fill", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"space"]]],
      ["hex grid - hex crop fill", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"crop"]]],
      ["hex grid - corner radius 0mm", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6], [iwallpattern_fill,"crop"], [icavity_floor_radius,0]]],
      ["hex grid - hex 7.5mm", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true], [iwallpattern_hole_size,7.5],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["hex grid - hex 9mm crop fill", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true], [iwallpattern_hole_size,9], [iwallpattern_hole_sides,6],[iwallpattern_fill,"crop"],[ichambers, 3],[iwallpattern_dividers_enabled,true]]]]
      
   : scenario == "taperedcorner" ? [["Tapered Box",9,[],[]],
      ["", [[itapered_corner, "none"],[itapered_corner_size,0],[itapered_setback,-1]]],
      ["rounded", [[itapered_corner, "rounded"],[itapered_corner_size,0],[itapered_setback,-1]]],
      ["chamfered", [[itapered_corner, "chamfered"],[itapered_corner_size,0],[itapered_setback,-1]]],
      ["chamfered radius 20", [[itapered_corner, "chamfered"],[itapered_corner_size,20],[itapered_setback,-1]]],
      ["chamfered setback 15", [[itapered_corner, "chamfered"],[itapered_corner_size,20],[itapered_setback,15]]],
      ["rounded radius 20", [[itapered_corner, "rounded"],[itapered_corner_size,20],[itapered_setback,-1]]],
      ["rounded setback 15", [[itapered_corner, "rounded"],[itapered_corner_size,20],[itapered_setback,15]]],
      ["rounded to floor", [[itapered_corner, "rounded"],[itapered_corner_size,-1],[itapered_setback,15]]],
      ["rounded to raised floor", [[itapered_corner, "rounded"],[itapered_corner_size,-1],[itapered_setback,15],[ifloor_thickness, 10]]]]
      
   : scenario == "multi" ? [["Multi",1,[[60,0,0],[180,0,90],700],[]],
      ["demo",1,[0, 0, 0], 5],
      ["demo",2,[gf_pitch*(3+multi_spacing.x), 0, 0], 5],
      ["demo",0,[gf_pitch*(3+multi_spacing.x)*2, 0, 0], 5],
      ["demo",15,[0, gf_pitch*(2+multi_spacing.y), 0], 8],
      ["demo",14,[gf_pitch*(3+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0], 8],
      ["demo",13,[gf_pitch*(3+multi_spacing.x)*2, gf_pitch*(2+multi_spacing.y), 0], 8]]

   : scenario == "multicutout" ? [["Multi Cutout",1,[[60,0,0],[140,0,90],650],[[iwallcutout_enabled, true],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,0],[iwallcutout_corner_radius,5]]],
      ["",[[iheight,2], [iwidth,1],[idepth,4+multi_spacing.y],[iwallcutout_walls,[0,0,1,1]]]],
      ["",[[iwidth,1],[idepth,4+multi_spacing.y],[iwallcutout_walls,[0,0,1,1]],[itranslate, [gf_pitch*(1+multi_spacing.x), 0, 0]]]],
      ["",[[iwidth,2],[itranslate, [gf_pitch*(2+multi_spacing.x*2), 0, 0]]]],
      ["",[[iwidth,2],[iheight,8],[itranslate, [gf_pitch*(2+multi_spacing.x*2), gf_pitch*(2+multi_spacing.y), 0]]]],
      ["",[[itranslate, [gf_pitch*(4+multi_spacing.x*3), 0, 0]]]],
      ["",[[iheight,8],[itranslate, [gf_pitch*(4+multi_spacing.x*3), gf_pitch*(2+multi_spacing.y), 0]]]]]

   : scenario == "multipattern" ? [["Multi Pattern",1,[[60,0,0],[60,0,65],350],[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2], [iwallpattern_hole_size,5],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"crophorizontal"],[idepth,2]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,0.5]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,0.5],[iheight,8],[itranslate, [0, gf_pitch*(2+multi_spacing.y), 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,1],[itranslate, [gf_pitch*(0.5+multi_spacing.x), 0, 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,1],[iheight,8],[itranslate, [gf_pitch*(0.5+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,2],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), 0, 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,2],[iheight,8],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), gf_pitch*(2+multi_spacing.y), 0]]]]      
      ]
      
   : ["unknown scenario"];
   
module RenderScenario(scenario, showtext=true, height=height, stepIndex=-1){
  selectedScenario = getScenario(scenario);
  scenarioDefaults = selectedScenario[0];
  stepIndex = stepIndex > -1 ? stepIndex+1 : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1);
  animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]);  
  currentStepSettings = replace_Items(concat(scenarioDefaults[iscenariokv],animationStep[istepkv]), defaultDemoSetting);

  echo("🟧RenderScenario",scenario = scenario, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1), animationStep=animationStep, currentStepSettings=currentStepSettings);

  if(showtext && $preview)
  color("DimGray")
  translate($vpt)
  rotate($vpr)
  translate([0,-45,60])
   linear_extrude(height = 0.1)
   text(str(scenarioDefaults[iscenarioName], " - ", animationStep[istepName]), size=5,halign="center");
  
  if(scenarioDefaults[iscenarioName] != "unknown scenario")
    rotate(currentStepSettings[irotate]) 
    translate(currentStepSettings[itranslate])
    gridfinity_basic_cup(
      width = width > -1 ? width : currentStepSettings[iwidth],
      depth = depth > -1 ? depth : currentStepSettings[idepth],
      height = height > -1 ? height : currentStepSettings[iheight],
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
      center_magnet_diameter=currentStepSettings[icenter_magnet_diameter],
      center_magnet_thickness=currentStepSettings[icenter_magnet_thickness],
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
      wallpattern_dividers_enabled=currentStepSettings[iwallpattern_dividers_enabled],
      wallpattern_fill=currentStepSettings[iwallpattern_fill],
      wallpattern_hole_sides=currentStepSettings[iwallpattern_hole_sides],
      wallpattern_hole_size=currentStepSettings[iwallpattern_hole_size],
      wallpattern_hole_spacing=currentStepSettings[iwallpattern_hole_spacing],
      cutx=currentStepSettings[icutx],
      cuty=currentStepSettings[icuty],
      help=help);
}

color(colour)
union(){
  if(isMulti(scenario)){
    multiScenario = getScenario(scenario);
    for(i =[1:len(multiScenario)-1])
    {
      multiStep = multiScenario[i];
      if(len(multiStep) == 4)
      {
        echo(multiStep=multiStep);
        //["demo",1, [0, 0, 0], 5]],
        translate(multiStep[2])
        RenderScenario(scenario = multiStep[0], height = multiStep[3], stepIndex = multiStep[1], showtext = false);
      }
      else{
        RenderScenario(scenario, stepIndex=i-1, showtext = false);
      }
    }
  } else{
    RenderScenario(scenario, showtext);
  }
}

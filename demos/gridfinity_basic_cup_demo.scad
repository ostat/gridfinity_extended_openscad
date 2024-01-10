// include <gridfinity_modules.scad>
use <../gridfinity_basic_cup.scad>
use <../modules/gridfinity_cup_modules.scad>
include <../modules/functions_general.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "demo"; //["demo","multi","multicutout","multipattern","multirounded","multichamfered","basiccup","position","chambers","label", "halfpitch","lip_style","fingerslide","basecorner","sequentialbridging","wallpattern","wallpatternfill", "wallcutout","taperedcorner","floorthickness","filledin","efficient_floor", "box_corner_attachments_only","center_magnet","spacer","flatbase","split_bin","debug"]
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
idepth=iwidth+1;
iheight=idepth+1;
iposition=iheight+1;
ifilled_in=iposition+1;
ilabel=ifilled_in+1;
ilabel_width=ilabel+1;
iwall_thickness=ilabel_width+1;
ilip_style=iwall_thickness+1;
ichamber_wall_thickness=ilip_style+1;
ivertical_chambers=ichamber_wall_thickness+1;
ivertical_separator_bend_position=ivertical_chambers+1;
ivertical_separator_bend_angle=ivertical_separator_bend_position+1;
ivertical_separator_bend_separation=ivertical_separator_bend_angle+1;
ivertical_separator_cut_depth=ivertical_separator_bend_separation+1;
ivertical_irregular_subdivisions=ivertical_separator_cut_depth+1;
ivertical_separator_config=ivertical_irregular_subdivisions+1;
ihorizontal_chambers=ivertical_separator_config+1;
ihorizontal_separator_bend_position=ihorizontal_chambers+1;
ihorizontal_separator_bend_angle=ihorizontal_separator_bend_position+1;
ihorizontal_separator_bend_separation=ihorizontal_separator_bend_angle+1;
ihorizontal_separator_cut_depth=ihorizontal_separator_bend_separation +1;
ihorizontal_irregular_subdivisions=ihorizontal_separator_cut_depth+1;
ihorizontal_separator_config=ihorizontal_irregular_subdivisions+1;
imagnet_diameter=ihorizontal_separator_config+1;
iscrew_depth=imagnet_diameter+1;
icenter_magnet_diameter=iscrew_depth+1;
icenter_magnet_thickness=icenter_magnet_diameter+1;
ihole_overhang_remedy=icenter_magnet_thickness+1;
ibox_corner_attachments_only=ihole_overhang_remedy+1;
ifloor_thickness=ibox_corner_attachments_only+1;
icavity_floor_radius=ifloor_thickness+1;
iefficient_floor=icavity_floor_radius+1;
ihalf_pitch=iefficient_floor+1;
iflat_base=ihalf_pitch+1;
ispacer=iflat_base+1;
ifingerslide=ispacer+1;
ifingerslide_radius=ifingerslide+1;
itapered_corner=ifingerslide_radius+1;
itapered_corner_size=itapered_corner+1;
itapered_setback=itapered_corner_size+1;
iwallcutout_enabled=itapered_setback+1;
iwallcutout_walls=iwallcutout_enabled+1;
iwallcutout_width=iwallcutout_walls+1;
iwallcutout_angle=iwallcutout_width+1;
iwallcutout_height=iwallcutout_angle+1;
iwallcutout_corner_radius=iwallcutout_height+1;
iwallpattern_enabled=iwallcutout_corner_radius+1;
iwallpattern_hexgrid=iwallpattern_enabled+1;
iwallpattern_walls=iwallpattern_hexgrid+1;
iwallpattern_dividers_enabled=iwallpattern_walls+1;
iwallpattern_fill=iwallpattern_dividers_enabled+1;
iwallpattern_hole_sides=iwallpattern_fill+1;
iwallpattern_hole_size=iwallpattern_hole_sides+1;
iwallpattern_hole_spacing=iwallpattern_hole_size+1;
iextention_enabled = iwallpattern_hole_spacing+1;
iextention_tabs_enabled = iextention_enabled+1;
icutx=iextention_tabs_enabled+1;
icuty=icutx+1;
ihelp=icuty+1;
itranslate=ihelp+1;
irotate=itranslate+1;

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
    //wall_thickness, lip_style, chamber_wall_thickness
    0.95, "normal",  1.2,
    //vertical_chambers, vertical_separator_bend_position, vertical_separator_bend_angle, vertical_separator_bend_separation,
    1, 0,45,0,0,
    //vertical_separator_cut_depth, vertical_irregular_subdivisionsvertical_separator_config
    false,"10.5|21|42|50|60",
    //horizontal_chambers, horizontal_separator_bend_position, horizontal_separator_bend_angle, horizontal_separator_bend_separation
    1, 0,45,0,0,
    //horizontal_separator_cut_depth, horizontal_irregular_subdivisions, horizontal_separator_config
    false,"10.5|21|42|50|60",
    //magnet_diameter, screw_depth, center_magnet_diameter, center_magnet_thickness, hole_overhang_remedy, box_corner_attachments_only
    0, 0, 0, 0, 2, false, 
    //floor_thickness, cavity_floor_radius, efficient_floor, half_pitch, flat_base
    0.7, -1, false, false, false, 
    //spacer, fingerslide,fingerslide_radius,
    false, "none", 8,
    //tapered_corner, tapered_corner_size, tapered_setback
    "none", 10, -1,
    //wallcutout_enabled, wallcutout_walls, wallcutout_width, wallcutout_angle, wallcutout_height, wallcutout_corner_radius
    false, [1,0,0,0], 0, 70, 0, 5, 
    //wallpattern_enabled, wallpattern_hexgrid, wallpattern_walls, wallpattern_dividers_enabled, wallpattern_fill, wallpattern_hole_sides, wallpattern_hole_size, wallpattern_hole_spacing
    false, true, [1,1,1,1], false, "none", 6, 5, 2, 
    //extention_enabled, extention_tabs_enabled
    [false,false],false,
    //cutx,cuty,help,translate,rotate
    0, 0,false,[0,0,0],[0,0,0]];
    
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
          [ivertical_chambers, 3],
          [iwallpattern_enabled,true],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_dividers_enabled, true],[iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [itapered_corner, "chamfered"],[itapered_corner_size,20],[itapered_setback,-1]]],
     ["Demo", [
          [ivertical_irregular_subdivisions, true], [ivertical_separator_config, "31.5|94.5"],
          [iwallpattern_enabled,true],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_dividers_enabled, true],[iwallpattern_hexgrid,true],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]],
      ["Simple", []],
      ["Multi Chamber 3", [[ivertical_chambers, 3]]],
      ["Multi Chamber 6", [[ivertical_chambers, 6]]],
      ["Efficient Floor", [[iefficient_floor,true]]],
      ["Half Pitch", [[ihalf_pitch, true], [iefficient_floor,false]]],
      ["Half Pitch with Efficient Floor", [[ihalf_pitch, true], [iefficient_floor,true]]],
      ["Label Full", [[ilabel, "center"],[ilabel_width, 3],[ivertical_chambers, 0]]],
      ["Label Left", [[ilabel, "left"],[ilabel_width, 1.5],[ivertical_chambers, 0]]],
      ["Label Right", [[ilabel, "right"],[ilabel_width, 1.5],[ivertical_chambers, 0]]],
      ["Label Center", [[ilabel, "center"],[ilabel_width, 1.5],[ivertical_chambers, 0]]],
      ["Label Center", [[ilabel, "center"],[ilabel_width, 1.5],[ivertical_chambers, 3]]],
      ["Label Center Chamber", [[ilabel, "centerchamber"],[ilabel_width, 0.5],[ivertical_chambers, 3]]], 
      ["Wall Cutout", [[ifloor_thickness, 1], [icavity_floor_radius, 0],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,1,0,0]],[iwallcutout_width,70],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]],
      ["Chamfered", [[ivertical_irregular_subdivisions, true], [ivertical_separator_config, "21|42|84"],
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
      ["full", [[ilabel, "center"],[ilabel_width, 3],[ivertical_chambers, 0]]],
      ["left", [[ilabel, "left"],[ilabel_width, 1.5],[ivertical_chambers, 0]]],
      ["right", [[ilabel, "right"],[ilabel_width, 1.5],[ivertical_chambers, 0]]],
      ["center", [[ilabel, "center"],[ilabel_width, 1.5],[ivertical_chambers, 0]]],
      ["left", [[ilabel, "left"],[ilabel_width, 1.5],[ivertical_chambers, 3]]],
      ["right", [[ilabel, "right"],[ilabel_width, 1.5],[ivertical_chambers, 3]]],
      ["center", [[ilabel, "center"],[ilabel_width, 1.5],[ivertical_chambers, 3]]],
      ["leftchamber", [[ilabel, "leftchamber"],[ilabel_width, 0.5],[ivertical_chambers, 3]]],
      ["rightchamber", [[ilabel, "rightchamber"],[ilabel_width, 0.5],[ivertical_chambers, 3]]],
      ["centerchamber", [[ilabel, "centerchamber"],[ilabel_width, 0.5],[ivertical_chambers, 3]]]]
      
   : scenario == "chambers" ? [["chambers",7,[],[]],
      ["3 vertical", [[ivertical_chambers, 3]]],
      ["2mm walls", [[ivertical_chambers, 3], [ichamber_wall_thickness,2]]],     
      ["3 horizontal", [[ihorizontal_chambers, 3]]],
      ["2 by 3", [[ivertical_chambers, 3], [ihorizontal_chambers, 2]]],
      ["bent walls", [[ivertical_chambers, 4], [ivertical_separator_bend_angle, 30], [ivertical_separator_bend_separation,10]]],     
      ["relief cut walls", [[ivertical_chambers, 3], [ivertical_separator_cut_depth,-3]]],     
      ["irregular chambers", [[ivertical_irregular_subdivisions, true], [ivertical_separator_config, "30,0,0,-3|60,15,-30|90"]]]]

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

  : scenario == "split_bin" ? [["split bin",5,[],[]],
      ["x with tabs", [[iextention_enabled,[true,false]],[iextention_tabs_enabled, true]]],
      ["x", [[iextention_enabled,[true,false]],[iextention_tabs_enabled, false]]],
      ["x and y with tabs", [[iextention_enabled,[true,true]],[iextention_tabs_enabled, true]]],
      ["x and y", [[iextention_enabled,[true,true]],[iextention_tabs_enabled, false]]],
      ["disabled", []]]
      
  : scenario == "box_corner_attachments_only" ? [["Corner Attachments only",2,[],[[imagnet_diameter,6.5],[iscrew_depth,6]]],
      ["enabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ibox_corner_attachments_only,true]]],
      ["disabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ibox_corner_attachments_only,false]]]]

  : scenario == "sequentialbridging" ? [["Sequential Bridging",4,[[24,0,330],[20,25,10],53],[[imagnet_diameter,6.5],[iscrew_depth,6]]],
      ["1", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,1]]],
      ["2", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,2]]],
      ["3", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,3]]],
      ["disabled", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,0]]]]
      
  : scenario == "spacer" ? [["Spacer",2,[],[]],
      ["enabled", [[ispacer,true]]],
      ["disabled", [[ispacer,false]]]]
      
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
      ["chambers", [[iwallpattern_walls,[0,0,0,0]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],[ivertical_chambers, 3],[iwallpattern_dividers_enabled,true]]],
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
      ["hex grid - hex 9mm crop fill", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true], [iwallpattern_hole_size,9], [iwallpattern_hole_sides,6],[iwallpattern_fill,"crop"],[ivertical_chambers, 3],[iwallpattern_dividers_enabled,true]]]]
      
   : scenario == "wallpatternfill" ? [["Wall Pattern fill",9,[],[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2],[iwallpattern_hole_size,5],[iwallpattern_walls,[1,1,1,1]],[iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6]]],
      ["none", [[iwallpattern_fill,"none"]]],
      ["space", [[iwallpattern_fill,"space"]]],
      ["crop", [[iwallpattern_fill,"crop"]]],
      ["crophorizontal", [[iwallpattern_fill,"crophorizontal"]]],
      ["cropverticle", [[iwallpattern_fill,"cropverticle"]]],
      ["crophorizontal_spaceverticle", [[iwallpattern_fill,"crophorizontal_spaceverticle"]]],
      ["cropverticle_spacehorizontal", [[iwallpattern_fill,"cropverticle_spacehorizontal"]]],
      ["spaceverticle", [[iwallpattern_fill,"spaceverticle"]]],
      ["spacehorizontal", [[iwallpattern_fill,"spacehorizontal"]]]]
      
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

  : scenario == "debug" ? [["Debug",4,[[90,0,270],[30,0,25],180],[[iwidth,2],[idepth,1]]],
      ["cutx", [[icutx, 0.2],[ihelp, true]]],
      ["cuty", [[icuty, 0.2]]],
      ["cutx", [[icutx, 0.2]]],
      ["off", []]]
      
   : scenario == "multi" ? [["Multi",1,[[60,0,0],[180,0,90],700],[]],
      ["demo",1,[0, 0, 0], 5],
      ["demo",2,[gf_pitch*(3+multi_spacing.x), 0, 0], 5],
      ["demo",0,[gf_pitch*(3+multi_spacing.x)*2, 0, 0], 5],
      ["demo",15,[0, gf_pitch*(2+multi_spacing.y), 0], 8],
      ["demo",14,[gf_pitch*(3+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0], 8],
      ["demo",13,[gf_pitch*(3+multi_spacing.x)*2, gf_pitch*(2+multi_spacing.y), 0], 8]]

   : scenario == "multicutout" ? [["Multi Cutout",1,[[60,0,0],[140,0,90],650],[[iwallcutout_enabled, true],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,0],[iwallcutout_corner_radius,5], [iefficient_floor,false]]],
      ["",[[iheight,2], [iwidth,1],[idepth,4+multi_spacing.y],[iwallcutout_walls,[0,0,1,1]]]],
      ["",[[iwidth,1],[idepth,4+multi_spacing.y],[iwallcutout_walls,[0,0,1,1]],[itranslate, [gf_pitch*(1+multi_spacing.x), 0, 0]]]],
      ["",[[iwidth,2],[itranslate, [gf_pitch*(2+multi_spacing.x*2), 0, 0]],[iwallcutout_walls,[1,0,0,0]]]],
      ["",[[iwidth,2],[iheight,8],[itranslate, [gf_pitch*(2+multi_spacing.x*2), gf_pitch*(2+multi_spacing.y), 0]],[iwallcutout_walls,[1,0,0,0]]]],
      ["",[[itranslate, [gf_pitch*(4+multi_spacing.x*3), 0, 0]],[iwallcutout_walls,[1,0,0,0]]]],
      ["",[[iheight,8],[itranslate, [gf_pitch*(4+multi_spacing.x*3), gf_pitch*(2+multi_spacing.y), 0]],[iwallcutout_walls,[1,1,0,0]]]]]

   : scenario == "multipattern" ? [["Multi Pattern",1,[[60,0,0],[60,0,65],350],[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2], [iwallpattern_hole_size,5],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"crophorizontal"],[idepth,2]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,0.5]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,0.5],[iheight,8],[itranslate, [0, gf_pitch*(2+multi_spacing.y), 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,1],[itranslate, [gf_pitch*(0.5+multi_spacing.x), 0, 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,1],[iheight,8],[itranslate, [gf_pitch*(0.5+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,2],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), 0, 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,2],[iheight,8],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), gf_pitch*(2+multi_spacing.y), 0]]]]      
      ]

//, 
   : scenario == "multirounded" ? [["Multi Rounded",1,[[60,0,330],[100,0,60],650],[[itapered_corner, "rounded"],[itapered_setback,-1]]],
      ["",[[iheight,4],[iwidth,2],[idepth,3], [irotate,[0,0,270]], [itranslate,[0,gf_pitch*1,0]],[itapered_corner_size,-1]]],
      ["",[[iheight,4],[iwidth,2],[idepth,3], [irotate,[0,0,270]], [itranslate,[0,gf_pitch*3.5,0]],[itapered_corner_size,-2]]],
      ["",[[iheight,5],[itranslate, [gf_pitch*(3+multi_spacing.x), 0, 0]], [iwidth,2],[itapered_corner_size,-1]]],
      ["",[[iheight,10], [iwidth,2],[itranslate, [gf_pitch*(3+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0]],[itapered_corner_size,-2]]],
      ["",[[iheight,8], [iwidth,4+multi_spacing.y],[idepth,3], [irotate,[0,0,90]], [itranslate,[gf_pitch*(7+multi_spacing.x*2),0,0]],[itapered_corner_size,-1]]]]
      
   : scenario == "multichamfered" ? [["Multi Chamfered",1,[[60,0,330],[100,0,60],650],[[itapered_corner, "chamfered"],[itapered_setback,-1]]],
      ["",[[iheight,4],[iwidth,2],[idepth,3], [irotate,[0,0,270]], [itranslate,[0,gf_pitch*1,0]],[itapered_corner_size,-1]]],
      ["",[[iheight,4],[iwidth,2],[idepth,3], [irotate,[0,0,270]], [itranslate,[0,gf_pitch*3.5,0]],[itapered_corner_size,-2]]],
      ["",[[iheight,5],[itranslate, [gf_pitch*(3+multi_spacing.x), 0, 0]], [iwidth,2],[itapered_corner_size,-1]]],
      ["",[[iheight,10], [iwidth,2],[itranslate, [gf_pitch*(3+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0]],[itapered_corner_size,-2]]],
      ["",[[iheight,8], [iwidth,4+multi_spacing.y],[idepth,3], [irotate,[0,0,90]], [itranslate,[gf_pitch*(7+multi_spacing.x*2),0,0]],[itapered_corner_size,-1]]]]
        
   : ["unknown scenario"];
   
module RenderScenario(scenario, showtext=true, height=height, stepIndex=-1){
  selectedScenario = getScenario(scenario);
  scenarioDefaults = selectedScenario[0];
  stepIndex = stepIndex > -1 ? stepIndex+1 : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1);
  animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]);  
  currentStepSettings = replace_Items(concat(scenarioDefaults[iscenariokv],animationStep[istepkv]), defaultDemoSetting);

  echo("🟧RenderScenario",scenario = scenario, stepIndex=stepIndex, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1), animationStep=animationStep, currentStepSettings=currentStepSettings);

  if(showtext && $preview)
  color("DimGray")
  translate($vpt)
  rotate($vpr)
  translate([0,-45,60])
   linear_extrude(height = 0.1)
   text(str(scenarioDefaults[iscenarioName], " - ", animationStep[istepName]), size=5,halign="center");
   
  echo(wallcutout_walls=currentStepSettings[iwallcutout_walls], efficient_floor=currentStepSettings[iefficient_floor], iwallcutout_walls=iwallcutout_walls, iefficient_floor=iefficient_floor);
  
  if(scenarioDefaults[iscenarioName] != "unknown scenario")
    translate(currentStepSettings[itranslate])
    rotate(currentStepSettings[irotate]) 
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
      chamber_wall_thickness=currentStepSettings[ichamber_wall_thickness],
      vertical_chambers=currentStepSettings[ivertical_chambers],
      vertical_separator_bend_position=currentStepSettings[ivertical_separator_bend_position],
      vertical_separator_bend_angle=currentStepSettings[ivertical_separator_bend_angle],
      vertical_separator_bend_separation=currentStepSettings[ivertical_separator_bend_separation],
      vertical_separator_cut_depth=currentStepSettings[ivertical_separator_cut_depth],
      vertical_irregular_subdivisions=currentStepSettings[ivertical_irregular_subdivisions],
      vertical_separator_config=currentStepSettings[ivertical_separator_config],
      horizontal_chambers=currentStepSettings[ihorizontal_chambers],
      horizontal_separator_bend_position=currentStepSettings[ihorizontal_separator_bend_position],
      horizontal_separator_bend_angle=currentStepSettings[ihorizontal_separator_bend_angle],
      horizontal_separator_bend_separation=currentStepSettings[ihorizontal_separator_bend_separation],
      horizontal_separator_cut_depth=currentStepSettings[ihorizontal_separator_cut_depth],
      horizontal_irregular_subdivisions=currentStepSettings[ihorizontal_irregular_subdivisions],
      horizontal_separator_config=currentStepSettings[ihorizontal_separator_config],
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
      spacer=currentStepSettings[ispacer],
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
      extention_enabled=currentStepSettings[iextention_enabled],
      extention_tabs_enabled=currentStepSettings[iextention_tabs_enabled],
      cutx=currentStepSettings[icutx],
      cuty=currentStepSettings[icuty],
      help=help || currentStepSettings[ihelp]);
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

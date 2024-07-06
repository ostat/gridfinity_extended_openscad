// include <gridfinity_modules.scad>
use <../gridfinity_basic_cup.scad>
use <../modules/gridfinity_cup_modules.scad>
include <../modules/functions_general.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "demo"; //["demo","basiccup","position","chambers","draw","label","label_relief","halfpitch","lip_style","fingerslide", "basecorner","sequentialbridging","wallpattern","wallpatternstyle","wallpatternfill","wallcutout","taperedcorner","floorthickness","filledin","efficient_floor", "box_corner_attachments_only","center_magnet","spacer","flatbase","split_bin","debug", "multi","multi_cutout","multi_hexpattern","multi_voronoipattern","multi_voronoigridpattern","multi_voronoihexgridpattern","multi_rounded","multi_chamfered","multi_drawer", "multibatch_basiccup",multibatch_basiccup_magnet,multibatch_basiccup_magnetscrew,multibatch_basiccup_halfpitch,multibatch_basiccup_halfpitch_magnet, multibatch_basiccup_halfpitch_magnetscrew,multibatch_batch_flatbase,multibatch_efficientfloor,multibatch_efficientfloor_magnet,multibatch_efficientfloor_magnetscrew, multibatch_efficientfloor_halfpitch,multibatch_efficientfloor_halfpitch_magnet,multibatch_efficientfloor_halfpitch_magnetscrew,multibatch_efficientfloor_flatbase, multi_floor_demo, multi_floor_demo_ef_off, floor_demo]
    
height = -1;
width=-1;
depth=-1;
stepIndex = -1;
showtext = true;
colour = "";

//Include help info in the logs
help=false;
setViewPort=true;

multi_spacing = [0.25,0.25];

/* [Hidden] */
iwidth=0;
idepth=iwidth+1;
iheight=idepth+1;
iposition=iheight+1;
ifilled_in=iposition+1;
ilabel=ifilled_in+1;
ilabel_size=ilabel+1;
ilabel_relief=ilabel_size+1;
iwall_thickness=ilabel_relief+1;
ilip_style=iwall_thickness+1;
izClearance=ilip_style+1;
ichamber_wall_thickness=izClearance+1;
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
iwallpattern_style=iwallpattern_enabled+1;
iwallpattern_walls=iwallpattern_style+1;
iwallpattern_dividers_enabled=iwallpattern_walls+1;
iwallpattern_fill=iwallpattern_dividers_enabled+1;
iwallpattern_hole_sides=iwallpattern_fill+1;
iwallpattern_hole_size=iwallpattern_hole_sides+1;
iwallpattern_hole_spacing=iwallpattern_hole_size+1;
iwallpattern_voronoi_noise = iwallpattern_hole_spacing+1;
iwallpattern_voronoi_radius = iwallpattern_voronoi_noise+1;
iextension_enabled = iwallpattern_voronoi_radius+1;
iextension_tabs_enabled = iextension_enabled+1;
icutx=iextension_tabs_enabled+1;
icuty=icutx+1;
ihelp=icuty+1;
itranslate=ihelp+1;
irotate=itranslate+1;
itranslate_rotate=irotate+1;
iscale=itranslate_rotate+1;
icolor=iscale+1;

iscenarioName=0;
iscenarioCount=1;
iscenarioVp=2;
iscenariokv=3;
   
istepName=0;
istepkv=1;

selectedScenario = getDerviedScenario(scenario);
echo(selectedScenario=selectedScenario);
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
    //width, depth, height, position, filled_in, label, label_size, label_relief
    [3,2,5,"default",false,"disabled",[1.5,14,0], 0,
    //wall_thickness, lip_style, zClearance, chamber_wall_thickness
    0.95, "normal", 0, 1.2,
    //vertical_chambers, vertical_separator_bend_position, vertical_separator_bend_angle, vertical_separator_bend_separation,
    1, 0,45,0,0,
    //vertical_separator_cut_depth, vertical_irregular_subdivisionsvertical_separator_config
    false,"10.5|21|42|50|60",
    //horizontal_chambers, horizontal_separator_bend_position, horizontal_separator_bend_angle, horizontal_separator_bend_separation
    1, 0,45,0,0,
    //horizontal_separator_cut_depth, horizontal_irregular_subdivisions, horizontal_separator_config
    false,"10.5|21|42|50|60",
    //magnet_diameter, screw_depth, center_magnet_diameter, center_magnet_thickness, hole_overhang_remedy, box_corner_attachments_only
    6.5, 6, 0, 0, 2, true, 
    //floor_thickness, cavity_floor_radius, efficient_floor, half_pitch, flat_base
    0.7, -1, "off", false, false, 
    //spacer, fingerslide,fingerslide_radius,
    false, "none", 8,
    //tapered_corner, tapered_corner_size, tapered_setback
    "none", 10, -1,
    //wallcutout_enabled, wallcutout_walls, wallcutout_width, wallcutout_angle, wallcutout_height, wallcutout_corner_radius
    false, [1,0,0,0], 0, 70, 0, 5, 
    
    //wallpattern_enabled, wallpattern_style, wallpattern_walls, wallpattern_dividers_enabled, wallpattern_fill, wallpattern_hole_sides, wallpattern_hole_size, wallpattern_hole_spacing, wallpattern_voronoi_noise, wallpattern_voronoi_radius 
    false, "hexgrid", [1,1,1,1], false, "none", 6, 5, 2, 0.6, 0.5,
    //extension_enabled, extension_tabs_enabled
    [false,false],false,
    //cutx,cuty,help,translate,rotate,scale,colour
    0, 0,false,[0,0,0],[0,0,0],[0,0,0],[1,1,1],""];
    
function isMulti(scenario) = search("multi",scenario) == [0, 1, 2, 3, 4];
function iscustomVP(scenarioVp, length = 0) = is_list(scenarioVp) && len(scenarioVp) >= length;
function getcustomVpr(scenarioVp) = iscustomVP(scenarioVp, 1) ? let(vpr = scenarioVp[0]) is_list(vpr) && len(vpr)==3 ? vpr : false : false;
function getcustomVpt(scenarioVp) = iscustomVP(scenarioVp, 2) ? let(vpt = scenarioVp[1]) is_list(vpt) && len(vpt)==3? vpt : false : false;
function getcustomVpd(scenarioVp) = iscustomVP(scenarioVp, 3) ? let(vpd = scenarioVp[2]) is_num(vpd) ? vpd : false : false;
function getcustomVpf(scenarioVp) = iscustomVP(scenarioVp, 4) ? let(vpf = scenarioVp[3]) is_num(vpf) ? vpf : false : false;

function multipos(binx,spacex,biny,spacey) = [gf_pitch*(binx+multi_spacing.x*spacex),gf_pitch*(biny+multi_spacing.y*spacey),0];

function getScenario(scenario) = 
//[0]: seenarioName,scenarioCount,[vpr,vpt,vpd,vpf],[[key,value]]
//[1]: name,[[key,value]]

  scenario == "demo" ? [["Basic Cup",16,[],[]],
      ["Demo", [
          [ivertical_chambers, 3],
          [iwallpattern_enabled,true],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_dividers_enabled, true],[iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [itapered_corner, "chamfered"],[itapered_corner_size,20],[itapered_setback,-1]]],
     ["Demo", [
          [iefficient_floor,"on"],[ihalf_pitch, true],[ivertical_irregular_subdivisions, true], [ivertical_separator_config, "31.5|94.5"],
          [iwallpattern_enabled,true],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_dividers_enabled, true],[iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]],
      ["Simple", []],
      ["Multi Chamber 3x2", [[ivertical_chambers, 3], [ihorizontal_chambers, 2]]],
      ["Multi Chamber custom", [[ivertical_irregular_subdivisions, true], [ivertical_separator_config, "35,0,0,-3|70,0,0,-3|110,15,-30,-3|160,15,30,-3|215,15,-30,-3"]]],
      ["Efficient Floor", [[iefficient_floor,"on"]]],
      ["Half Pitch with Efficient Floor", [[ihalf_pitch, true], [iefficient_floor,"on"]]],
      ["Label Full", [[ilabel, "center"],[ilabel_size, [3,14,0]],[ivertical_chambers, 0]]],
      ["Label Left", [[ilabel, "left"],[ilabel_size, [1.5,14,0]],[ivertical_chambers, 0]]],
      ["Label Right", [[ilabel, "right"],[ilabel_size, [1.5,14,0]],[ivertical_chambers, 0]]],
      ["Label Center", [[ilabel, "center"],[ilabel_size, [1.5,14,0]],[ivertical_chambers, 0]]],
      ["Label Center", [[ilabel, "center"],[ilabel_size, [1.5,14,0]],[ivertical_chambers, 3]]],
      ["Label Center Chamber", [[ilabel, "centerchamber"],[ilabel_size, [0.5,14,0]],[ivertical_chambers, 3]]], 
      ["Wall Cutout", [[ifloor_thickness, 1], [icavity_floor_radius, 0],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,1,0,0]],[iwallcutout_width,70],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]],
      ["Chamfered", [[ivertical_irregular_subdivisions, true], [ivertical_separator_config, "21|42|84"],
      [itapered_corner, "rounded"],[itapered_corner_size,25],[itapered_setback,-1]]],
      ["Demo 3", [[ifloor_thickness, 2], [icavity_floor_radius, -1],
          [iwallpattern_enabled,true],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"voronoihexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]]]
  
  
  : scenario == "basiccup" ? [["Basic Cup",1,[],[]],
      ["simple", []]]
      
  : scenario == "position" ? [["",3,[],[]],
      ["default", [[iposition, "default"]]],
      ["center", [[iposition, "center"]]],
      ["zero", [[iposition, "zero"]]]]
      
  : scenario == "lip_style" ? [["Lip Style",4,[],[[icutx, 0.5]]],
      ["normal", [[ilip_style, "normal"]]],
      ["reduced", [[ilip_style, "reduced"]]],
      ["minimum", [[ilip_style, "minimum"]]],
      ["none, not stackable", [[ilip_style, "none"]]]]
      
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
      ["on", [[ifilled_in, true]]],
      ["on, stackable false", [[ifilled_in, true], [ilip_style, "none"]]],
      ["off", [[ifilled_in, false]]]]
      
   : scenario == "floorthickness" ? [["Floor Thickness",5,[],[[icutx, 0.5]]],
      ["0.7mm (default)", [[ifloor_thickness, 0.7]]],
      ["1mm", [[ifloor_thickness, 1]]],
      ["5mm", [[ifloor_thickness, 5]]],
      ["10mm", [[ifloor_thickness, 10]]],
      ["20mm", [[ifloor_thickness, 20]]]]
      
  : scenario == "label" ? [["Label",13,[],[]],
      ["full", [[ilabel, "center"],[ilabel_size, [3,14,0]],[ivertical_chambers, 0]]],
      ["height = 0 uses depth", [[ilabel, "center"],[ilabel_size, [3,14,0]],[ivertical_chambers, 0],[icutx,0.2]]],
      ["height = 0 uses depth * 3/4", [[ilabel, "center"],[ilabel_size, [3,14,-1]],[ivertical_chambers, 0],[icutx,0.2]]],
      ["depth 8mm", [[ilabel, "center"],[ilabel_size, [3,8,0]],[ivertical_chambers, 0],[icutx,0.2]]],      
      ["left", [[ilabel, "left"],[ilabel_size, [1.5,14,0]],[ivertical_chambers, 0]]],
      ["right", [[ilabel, "right"],[ilabel_size, [1.5,14,0]],[ivertical_chambers, 0]]],
      ["center", [[ilabel, "center"],[ilabel_size, [1.5,14,0]],[ivertical_chambers, 0]]],
      ["left", [[ilabel, "left"],[ilabel_size, [1.5,14,0]],[ivertical_chambers, 3]]],
      ["right", [[ilabel, "right"],[ilabel_size, [1.5,14,0]],[ivertical_chambers, 3]]],
      ["center", [[ilabel, "center"],[ilabel_size, [1.5,14,0]],[ivertical_chambers, 3]]],
      ["leftchamber", [[ilabel, "leftchamber"],[ilabel_size, [0.5,14,0]],[ivertical_chambers, 3]]],
      ["rightchamber", [[ilabel, "rightchamber"],[ilabel_size, [0.5,14,0]],[ivertical_chambers, 3]]],
      ["centerchamber", [[ilabel, "centerchamber"],[ilabel_size, [0.5,14,0]],[ivertical_chambers, 3]]]]
  
  //label_size = [0,14,0,0.6]; // 0.01
  //label_relief = 0; // 0.1
  : scenario == "label_relief" ? [["label Relief",4,[[80,0,280],[20,60,25],90],[[ilabel_size, [3,14,0]],[ivertical_chambers, 0],[icutx,0.2]]],
      ["none", [[ilabel, "center"],[ilabel_relief, 0]]],
      ["0.25", [[ilabel, "center"],[ilabel_relief, 0.25]]],
      ["0.5", [[ilabel, "center"],[ilabel_relief, 0.5]]],
      ["1", [[ilabel, "center"],[ilabel_relief, 1]]]]
      
   : scenario == "chambers" ? [["chambers",7,[],[]],
      ["3 vertical", [[ivertical_chambers, 3]]],
      ["2mm walls", [[ivertical_chambers, 3], [ichamber_wall_thickness,2]]],     
      ["3 horizontal", [[ihorizontal_chambers, 3]]],
      ["2 by 3", [[ivertical_chambers, 3], [ihorizontal_chambers, 2]]],
      ["bent walls", [[ivertical_chambers, 4], [ivertical_separator_bend_angle, 30], [ivertical_separator_bend_separation,10]]],     
      ["relief cut walls", [[ivertical_chambers, 3], [ivertical_separator_cut_depth,-3]]],     
      ["irregular chambers", [[ivertical_irregular_subdivisions, true], [ivertical_separator_config, "30,0,0,-3|60,15,-30|90"]]]]

   : scenario == "draw" ? [["draw",12,[[60,0,320],[30,30,60],500],[[imagnet_diameter,6.5],[iscrew_depth,6],[iwidth,5],[
idepth,6],[iheight,6], [ichamber_wall_thickness,2]]],
      ["standard w5 d5 h6", [[ivertical_chambers, 5], [ivertical_separator_bend_angle, 30], [ivertical_separator_bend_separation,10], [ivertical_separator_cut_depth,-3]]],     
      ["straight walls w5 d5 h6", [[iwidth,5], [ivertical_chambers, 5], [ivertical_separator_cut_depth,-3]]],     
      ["irregular chambers w5 d5 h6", [[ivertical_irregular_subdivisions, true], [ivertical_separator_config, "35,0,0,-3|70,0,0,-3|110,15,-30,-3|160,15,30,-3"]]],
      ["standard w5 d5 h8", [[iheight,8], [ivertical_chambers, 5], [ivertical_separator_bend_angle, 30], [ivertical_separator_bend_separation,10], [ivertical_separator_cut_depth,-3]]],     
      ["straight walls w5 d5 h8", [[iheight,8], [iwidth,5], [ivertical_chambers, 5], [ivertical_separator_cut_depth,-3]]],     
      ["irregular chambers w5 d5 h8", [[iheight,8], [ivertical_irregular_subdivisions, true], [ivertical_separator_config, "35,0,0,-3|70,0,0,-3|110,15,-30,-3|160,15,30,-3"]]],
      ["standard w6 d5 h6", [[iwidth,6],[ivertical_chambers, 5], [ivertical_separator_bend_angle, 30], [ivertical_separator_bend_separation,10], [ivertical_separator_cut_depth,-3]]],     
      ["straight walls w6 d5 h6", [[iwidth,6], [ivertical_chambers, 5], [ivertical_separator_cut_depth,-3]]],     
      ["irregular chambers w6 d5 h6", [[iwidth,6],[ivertical_irregular_subdivisions, true], [ivertical_separator_config, "35,0,0,-3|70,0,0,-3|110,15,-30,-3|160,15,30,-3|215,15,-30,-3"]]],
      ["standard w6 d5 h8", [[iwidth,6],[iheight,8], [ivertical_chambers, 5], [ivertical_separator_bend_angle, 30], [ivertical_separator_bend_separation,10], [ivertical_separator_cut_depth,-3]]],     
      ["straight walls w6 d5 h8", [[iwidth,6],[iheight,8], [ivertical_chambers, 5], [ivertical_separator_cut_depth,-3]]],     
      ["irregular chambers w6 d5 h8", [[iwidth,6],[iheight,8], [ivertical_irregular_subdivisions, true], [ivertical_separator_config, "35,0,0,-3|70,0,0,-3|110,15,-30,-3|160,15,30,-3|215,15,-30,-3"]]]]
   
   : scenario == "multidrawer" ? [["Multi",1,[[60,0,0],[310,30,90],1700],[]],
      ["draw",0,[0, 0, 0], 5],
      ["draw",1,[gf_pitch*(5+multi_spacing.x), 0, 0], 5],
      ["draw",2,[gf_pitch*(5+multi_spacing.x)*2, 0, 0], 5],
      ["draw",9,[gf_pitch*(-1.5), gf_pitch*(6+multi_spacing.y), 0], 8],
      ["draw",10,[gf_pitch*(4.5+multi_spacing.x), gf_pitch*(6+multi_spacing.y), 0], 8],
      ["draw",11,[gf_pitch*(5.25+multi_spacing.x)*2, gf_pitch*(6+multi_spacing.y), 0], 8]]
      
    : scenario == "multidrawer" ? [["Multi",1,[[60,0,0],[180,0,90],700],[]],
      ["draw",0,[0, 0, 0], 5],
      ["draw",1,[gf_pitch*(5+multi_spacing.x), 0, 0], 5],
      ["draw",2,[gf_pitch*(5+multi_spacing.x)*2, 0, 0], 5],
      ["draw",3,[0, gf_pitch*(6+multi_spacing.y), 0], 8],
      ["draw",4,[gf_pitch*(5+multi_spacing.x), gf_pitch*(6+multi_spacing.y), 0], 8],
      ["draw",5,[gf_pitch*(5+multi_spacing.x)*2, gf_pitch*(6+multi_spacing.y), 0], 8]]  
      
  : scenario == "efficient_floor" ? [["Efficient Floor",12,[],[[imagnet_diameter,6.5],[iscrew_depth,6],[icutx, 0.2]]],
      ["enabled", [[iefficient_floor,"on"],[imagnet_diameter,0],[iscrew_depth,0]]],
      ["rounded", [[iefficient_floor,"rounded"],[imagnet_diameter,0],[iscrew_depth,0]]],
      ["slide", [[iefficient_floor,"slide"],[imagnet_diameter,0],[iscrew_depth,0]]],
      ["enabled with magnet", [[iefficient_floor,"on"],[imagnet_diameter,6.5],[iscrew_depth,0]]],
      ["rounded with magnet", [[iefficient_floor,"rounded"],[imagnet_diameter,6.5],[iscrew_depth,0]]],
      ["slide with magnet", [[iefficient_floor,"slide"],[imagnet_diameter,6.5],[iscrew_depth,0]]],
      ["enabled with magnet and screw", [[iefficient_floor,"on"],[imagnet_diameter,6.5],[iscrew_depth,6]]],
      ["rounded with magnet and screw", [[iefficient_floor,"rounded"],[imagnet_diameter,6.5],[iscrew_depth,6]]],
      ["slide with magnet and screw", [[iefficient_floor,"slide"],[imagnet_diameter,6.5],[iscrew_depth,6]]],
      ["disabled", [[iefficient_floor,"off"]]],
      ["enabled", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iefficient_floor,"on"]]],
      ["disabled", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iefficient_floor,"off"]]]]
      
  : scenario == "flatbase" ? [["Flat Base",8,[[70,0,270],[30,20,20],280],[[icutx, 0.5],[imagnet_diameter,0],[iscrew_depth,0]]],
      ["enabled",[[iflat_base,true]]],
      ["enabled with efficient floor", [[iflat_base, true], [iefficient_floor,"on"]]],
      ["enabled with efficient floor slide", [[iflat_base, true], [iefficient_floor,"slide"]]],
      ["disabled", [[iflat_base,false]]],
      ["enabled", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iflat_base,true]]],
      ["enabled with efficient floor", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iflat_base, true], [iefficient_floor,"on"]]],
      ["enabled with efficient floor slide", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iflat_base, true], [iefficient_floor,"slide"]]],
      ["disabled", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [iflat_base,false]]]]

  : scenario == "split_bin" ? [["split bin",5,[],[]],
      ["x with tabs", [[iextension_enabled,[true,false]],[iextension_tabs_enabled, true]]],
      ["x", [[iextension_enabled,[true,false]],[iextension_tabs_enabled, false]]],
      ["x and y with tabs", [[iextension_enabled,[true,true]],[iextension_tabs_enabled, true]]],
      ["x and y", [[iextension_enabled,[true,true]],[iextension_tabs_enabled, false]]],
      ["disabled", []]]
      
  : scenario == "box_corner_attachments_only" ? [["Corner Attachments only",2,[],[[imagnet_diameter,6.5],[iscrew_depth,6]]],
      ["enabled", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ibox_corner_attachments_only,true]]],
      ["disabled", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ibox_corner_attachments_only,false]]]]

  : scenario == "sequentialbridging" ? [["Sequential Bridging",4,[[24,0,330],[20,25,10],53],[[imagnet_diameter,6.5],[iscrew_depth,6], [ibox_corner_attachments_only,false]]],
      ["1", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,1]]],
      ["2", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,2]]],
      ["3", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,3]]],
      ["disabled", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihole_overhang_remedy,0]]]]
      
  : scenario == "spacer" ? [["Spacer",2,[],[]],
      ["enabled", [[ispacer,true]]],
      ["disabled", [[ispacer,false]]]]
      
  : scenario == "halfpitch" ? [["Half Pitch",6,[],[[icutx, 0.2]]],
      ["enabled", [[ihalf_pitch, true], [iefficient_floor,"off"]]],
      ["enabled with efficient floor", [[ihalf_pitch, true], [iefficient_floor,"on"]]],
      ["disabled", [[ihalf_pitch, false], [iefficient_floor,"off"]]],
      ["enabled", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihalf_pitch, true], [iefficient_floor,"off"]]],
      ["enabled with efficient floor", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihalf_pitch, true], [iefficient_floor,"on"]]],
      ["disabled", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [ihalf_pitch, false], [iefficient_floor,"off"]]]]
      
  : scenario == "center_magnet" ? [["Center Magnet",5,[],[]],
     ["6mm x 2.4mm", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [icenter_magnet_diameter, 6], [icenter_magnet_thickness, 2.4]]],
     ["10mm x 5mm", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [icenter_magnet_diameter, 10], [icenter_magnet_thickness, 5]]],
     ["15mm x 5mm", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [icenter_magnet_diameter, 15], [icenter_magnet_thickness, 5]]],
     ["20mm x 5mm", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]], [icenter_magnet_diameter, 20], [icenter_magnet_thickness, 5]]],
     ["off", [[itranslate_rotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]]]]]
     
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
      ["front", [[iwallpattern_walls,[1,0,0,0]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["back", [[iwallpattern_walls,[0,1,0,0]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["left", [[iwallpattern_walls,[0,0,1,0]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["right", [[iwallpattern_walls,[0,0,0,1]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["chambers", [[iwallpattern_walls,[0,0,0,0]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],[ivertical_chambers, 3],[iwallpattern_dividers_enabled,true]]],
      ["square grid - diamond", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"grid"],[iwallpattern_hole_sides,4],[iwallpattern_fill,"none"]]],
      ["voronoi", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"voronoi"],[iwallpattern_hole_sides,4],[iwallpattern_fill,"none"]]],
      ["voronoi - grid", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"voronoigrid"],[iwallpattern_hole_sides,4],[iwallpattern_fill,"none"]]],
      ["voronoi - hex grid", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"voronoihexgrid"],[iwallpattern_hole_sides,4],[iwallpattern_fill,"none"]]],
      ["square grid - hex", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"grid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["square grid - circle", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"grid"],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"]]],
      ["hex grid - diamond", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,4],[iwallpattern_fill,"none"]]],
      ["hex grid - hex", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["hex grid - hex", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["hex grid - circle", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,64],[iwallpattern_fill,"none"]]],
      ["hex grid - hex space fill", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"space"]]],
      ["hex grid - hex crop fill", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"crop"]]],
      ["hex grid - corner radius 0mm", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6], [iwallpattern_fill,"crop"], [icavity_floor_radius,0]]],
      ["hex grid - hex 7.5mm", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"hexgrid"], [iwallpattern_hole_size,7.5],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"]]],
      ["hex grid - hex 9mm crop fill", [[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"hexgrid"], [iwallpattern_hole_size,9], [iwallpattern_hole_sides,6],[iwallpattern_fill,"crop"],[ivertical_chambers, 3],[iwallpattern_dividers_enabled,true]]]]

   : scenario == "wallpatternstyle" ? [["Wall Pattern Style",5,[],[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2],[iwallpattern_hole_size,5],[iwallpattern_walls,[1,1,1,1]],[iwallpattern_style,"grid"],[iwallpattern_hole_sides,6]]],
      ["grid", [[iwallpattern_style,"grid"]]],
      ["hexgrid", [[iwallpattern_style,"hexgrid"]]],
      ["voronoi", [[iwallpattern_style,"voronoi"]]],
      ["voronoigrid", [[iwallpattern_style,"voronoigrid"]]],
      ["voronoihexgrid", [[iwallpattern_style,"voronoihexgrid"]]]]
      
   : scenario == "wallpatternfill" ? [["Wall Pattern Fill",9,[],[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2],[iwallpattern_hole_size,5],[iwallpattern_walls,[1,1,1,1]],[iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6]]],
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

  : scenario == "debug" ? [["Debug",6,[[90,0,270],[30,0,25],180],[[iwidth,2],[idepth,1],[imagnet_diameter, 6.5], [iscrew_depth, 6]]],
      ["cutx", [[icutx, 0.2],[ihelp, true]]],
      ["cutx", [[icutx, 0.2],[ihelp, true],[iscrew_depth,0]]],
      ["cutx", [[icutx, 0.2],[ihelp, true],[iscrew_depth,0],[iefficient_floor,"on"]]],
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

   : scenario == "multi_cutout" ? [["Multi Cutout",1,[[60,0,0],[140,0,90],650],[[iwallcutout_enabled, true],[iwallcutout_width,0],[iwallcutout_angle,70],[iwallcutout_height,0],[iwallcutout_corner_radius,5], [iefficient_floor,"off"]]],
      ["",[[iheight,2], [iwidth,1],[idepth,4+multi_spacing.y],[iwallcutout_walls,[0,0,1,1]]]],
      ["",[[iwidth,1],[idepth,4+multi_spacing.y],[iwallcutout_walls,[0,0,1,1]],[itranslate, [gf_pitch*(1+multi_spacing.x), 0, 0]]]],
      ["",[[iwidth,2],[itranslate, [gf_pitch*(2+multi_spacing.x*2), 0, 0]],[iwallcutout_walls,[1,0,0,0]]]],
      ["",[[iwidth,2],[iheight,8],[itranslate, [gf_pitch*(2+multi_spacing.x*2), gf_pitch*(2+multi_spacing.y), 0]],[iwallcutout_walls,[1,0,0,0]]]],
      ["",[[itranslate, [gf_pitch*(4+multi_spacing.x*3), 0, 0]],[iwallcutout_walls,[1,0,0,0]]]],
      ["",[[iheight,8],[itranslate, [gf_pitch*(4+multi_spacing.x*3), gf_pitch*(2+multi_spacing.y), 0]],[iwallcutout_walls,[1,1,0,0]]]]]

   : scenario == "multi_hexpattern" ? [["Multi Hex Pattern",1,[[60,0,0],[60,0,65],350],[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2], [iwallpattern_hole_size,5],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"crophorizontal"],[idepth,2]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,0.5]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,0.5],[iheight,8],[itranslate, [0, gf_pitch*(2+multi_spacing.y), 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,1],[itranslate, [gf_pitch*(0.5+multi_spacing.x), 0, 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,1],[iheight,8],[itranslate, [gf_pitch*(0.5+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,2],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), 0, 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,2],[iheight,8],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), gf_pitch*(2+multi_spacing.y), 0]]]]      
      ]

   : scenario == "multi_voronoipattern" ? [["Multi Voronoi Pattern",1,[[60,0,0],[60,0,65],350],[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"voronoi"],[idepth,2]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,0.5]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,0.5],[iheight,8],[itranslate, [0, gf_pitch*(2+multi_spacing.y), 0]],[iwallpattern_hole_size,25],[iwallpattern_hole_spacing, 3]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,1],[itranslate, [gf_pitch*(0.5+multi_spacing.x), 0, 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,1],[iheight,8],[itranslate, [gf_pitch*(0.5+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0]],[iwallpattern_hole_size,25],[iwallpattern_hole_spacing, 3]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,2],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), 0, 0]]]],
      ["",[[iwallpattern_hole_size,5],[iwidth,2],[iheight,8],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), gf_pitch*(2+multi_spacing.y), 0]],[iwallpattern_hole_size,25],[iwallpattern_hole_spacing, 3]]]      
      ]
      
  : scenario == "multi_voronoigridpattern" ? [["Multi Voronoi Pattern",1,[[60,0,0],[60,0,65],350],[[iwallpattern_enabled,true],[iwallpattern_hole_spacing,2],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"voronoigrid"],[idepth,2]]],
      ["",[[iwallpattern_hole_size,6],[iwidth,0.5]]],
      ["",[[iwallpattern_hole_size,10],[iwidth,0.5],[iheight,8],[itranslate, [0, gf_pitch*(2+multi_spacing.y), 0]],[iwallpattern_hole_spacing, 3]]],
      ["",[[iwallpattern_hole_size,6],[iwidth,1],[itranslate, [gf_pitch*(0.5+multi_spacing.x), 0, 0]]]],
      ["",[[iwallpattern_hole_size,10],[iwidth,1],[iheight,8],[itranslate, [gf_pitch*(0.5+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0]],[iwallpattern_hole_spacing, 3]]],
      ["",[[iwallpattern_hole_size,6],[iwidth,2],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), 0, 0]]]],
      ["",[[iwallpattern_hole_size,10],[iwidth,2],[iheight,8],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), gf_pitch*(2+multi_spacing.y), 0]],[iwallpattern_hole_spacing, 3]]]      
      ]
      
  : scenario == "multi_voronoihexgridpattern" ? [["Multi Voronoi Pattern",1,[[60,0,0],[60,0,65],350],[[iwallpattern_enabled,true],[iwallpattern_hole_spacing, 2],[iwallpattern_walls,[1,1,1,1]], [iwallpattern_style,"voronoihexgrid"],[idepth,2]]],
      ["",[[iwallpattern_hole_size,6],[iwidth,0.5]]],
      ["",[[iwallpattern_hole_size,9],[iwidth,0.5],[iheight,8],[itranslate, [0, gf_pitch*(2+multi_spacing.y), 0]],[iwallpattern_hole_spacing, 3]]],
      ["",[[iwallpattern_hole_size,6],[iwidth,1],[itranslate, [gf_pitch*(0.5+multi_spacing.x), 0, 0]]]],
      ["",[[iwallpattern_hole_size,9],[iwidth,1],[iheight,8],[itranslate, [gf_pitch*(0.5+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0]],[iwallpattern_hole_spacing, 3]]],
      ["",[[iwallpattern_hole_size,6],[iwidth,2],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), 0, 0]]]],
      ["",[[iwallpattern_hole_size,8],[iwidth,2],[iheight,8],[itranslate, [gf_pitch*(1.5+multi_spacing.x*2), gf_pitch*(2+multi_spacing.y), 0]],[iwallpattern_hole_spacing, 3]]]      
      ]

   : scenario == "multi_rounded" ? [["Multi Rounded",1,[[60,0,330],[100,0,60],650],[[itapered_corner, "rounded"],[itapered_setback,-1]]],
      ["",[[iheight,4],[iwidth,2],[idepth,3], [irotate,[0,0,270]], [itranslate,[0,gf_pitch*1,0]],[itapered_corner_size,-1]]],
      ["",[[iheight,4],[iwidth,2],[idepth,3], [irotate,[0,0,270]], [itranslate,[0,gf_pitch*3.5,0]],[itapered_corner_size,-2]]],
      ["",[[iheight,5],[itranslate, [gf_pitch*(3+multi_spacing.x), 0, 0]], [iwidth,2],[itapered_corner_size,-1]]],
      ["",[[iheight,10], [iwidth,2],[itranslate, [gf_pitch*(3+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0]],[itapered_corner_size,-2]]],
      ["",[[iheight,8], [iwidth,4+multi_spacing.y],[idepth,3], [irotate,[0,0,90]], [itranslate,[gf_pitch*(7+multi_spacing.x*2),0,0]],[itapered_corner_size,-1]]]]
      
   : scenario == "multi_chamfered" ? [["Multi Chamfered",1,[[60,0,330],[100,0,60],650],[[itapered_corner, "chamfered"],[itapered_setback,-1]]],
      ["",[[iheight,4],[iwidth,2],[idepth,3], [irotate,[0,0,270]], [itranslate,[0,gf_pitch*1,0]],[itapered_corner_size,-1]]],
      ["",[[iheight,4],[iwidth,2],[idepth,3], [irotate,[0,0,270]], [itranslate,[0,gf_pitch*3.5,0]],[itapered_corner_size,-2]]],
      ["",[[iheight,5],[itranslate, [gf_pitch*(3+multi_spacing.x), 0, 0]], [iwidth,2],[itapered_corner_size,-1]]],
      ["",[[iheight,10], [iwidth,2],[itranslate, [gf_pitch*(3+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0]],[itapered_corner_size,-2]]],
      ["",[[iheight,8], [iwidth,4+multi_spacing.y],[idepth,3], [irotate,[0,0,90]], [itranslate,[gf_pitch*(7+multi_spacing.x*2),0,0]],[itapered_corner_size,-1]]]]
      
    : scenario == "multibatch_basiccup" ? [["Basic Cup",1,[[75,0,315],[80,90,120],900],[[imagnet_diameter, 0],[iscrew_depth,0],[icolor,[176/255, 190/255, 197/255]]]],
      ["",[[iwidth,0.5],[idepth,1],[iheight,1]]],
      ["",[[iwidth,1],[idepth,1],[iheight,2],[itranslate, multipos(0.5,1,0,0)]]],
      ["",[[iwidth,2],[idepth,1],[iheight,3],[itranslate, multipos(1.5,2,0,0)]]],
      ["",[[iwidth,3],[idepth,1],[iheight,4],[itranslate, multipos(3.5,3,0,0)]]],
      ["",[[iwidth,4],[idepth,1],[iheight,5],[itranslate, multipos(6.5,4,0,0)]]],
      ["",[[iwidth,5],[idepth,1],[iheight,6],[itranslate, multipos(10.5,5,0,0)]]],
      ["",[[iwidth,6],[idepth,1],[iheight,7],[itranslate, multipos(15.5,6,0,0)]]],
      ["",[[iwidth,0.5],[idepth,2],[iheight,2],[itranslate, multipos(0,0,1,1)]]],
      ["",[[iwidth,1],[idepth,2],[iheight,4],[itranslate, multipos(0.5,1,1,1)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,2],[idepth,2],[iheight,6],[itranslate, multipos(1.5,2,1,1)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,3],[idepth,2],[iheight,8],[itranslate, multipos(3.5,3,1,1)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,4],[idepth,2],[iheight,10],[itranslate, multipos(6.5,4,1,1)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,5],[idepth,2],[iheight,12],[itranslate, multipos(10.5,5,1,1)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,6],[idepth,2],[iheight,14],[itranslate, multipos(15.5,6,1,1)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,0.5],[idepth,3],[iheight,3],[itranslate, multipos(0,0,3,2)]]],
      ["",[[iwidth,1],[idepth,3],[iheight,6],[itranslate, multipos(0.5,1,3,2)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,2],[idepth,3],[iheight,9],[itranslate, multipos(1.5,2,3,2)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,3],[idepth,3],[iheight,12],[itranslate, multipos(3.5,3,3,2)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,4],[idepth,3],[iheight,15],[itranslate, multipos(6.5,4,3,2)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,5],[idepth,3],[iheight,18],[itranslate, multipos(10.5,5,3,2)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,6],[idepth,3],[iheight,21],[itranslate, multipos(15.5,6,3,2)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,0.5],[idepth,4],[iheight,4],[itranslate, multipos(0,0,6,3)]]],
      ["",[[iwidth,1],[idepth,4],[iheight,8],[itranslate, multipos(0.5,1,6,3)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,2],[idepth,4],[iheight,12],[itranslate, multipos(1.5,2,6,3)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,3],[idepth,4],[iheight,16],[itranslate, multipos(3.5,3,6,3)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,4],[idepth,4],[iheight,20],[itranslate, multipos(6.5,4,6,3)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,5],[idepth,4],[iheight,24],[itranslate, multipos(10.5,5,6,3)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,6],[idepth,4],[iheight,28],[itranslate, multipos(15.5,6,6,3)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,0.5],[idepth,5],[iheight,5],[itranslate, multipos(0,0,10,4)]]],
      ["",[[iwidth,1],[idepth,5],[iheight,10],[itranslate, multipos(0.5,1,10,4)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,2],[idepth,5],[iheight,15],[itranslate, multipos(1.5,2,10,4)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,3],[idepth,5],[iheight,20],[itranslate, multipos(3.5,3,10,4)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,4],[idepth,5],[iheight,25],[itranslate, multipos(6.5,4,10,4)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,5],[idepth,5],[iheight,30],[itranslate, multipos(10.5,5,10,4)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,6],[idepth,5],[iheight,35],[itranslate, multipos(15.5,6,10,4)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,0.5],[idepth,6],[iheight,6],[itranslate, multipos(0,0,15,5)]]],
      ["",[[iwidth,1],[idepth,6],[iheight,12],[itranslate, multipos(0.5,1,15,5)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,2],[idepth,6],[iheight,18],[itranslate, multipos(1.5,2,15,5)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,3],[idepth,6],[iheight,24],[itranslate, multipos(3.5,3,15,5)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,4],[idepth,6],[iheight,30],[itranslate, multipos(6.5,4,15,5)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,5],[idepth,6],[iheight,36],[itranslate, multipos(10.5,5,15,5)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,6],[idepth,6],[iheight,42],[itranslate, multipos(15.5,6,15,5)],[ihalf_pitch,false],[iefficient_floor, "off"],[imagnet_diameter, 0],[iscrew_depth,0]]],
      ["",[[iwidth,2],[idepth,2],[iheight,5],[icuty, 0.2],[iposition, "center"],[irotate,[170,180,90]],[itranslate, [-45,-105,35]],[itranslate_rotate, [0,-5,360-315]],[iscale, 2],[icolor,""]]],
      //["",[[iwidth,3],[idepth,2],[iheight,5],[icuty, 0.5],[itranslate, [80,-120,0]],[irotate, [75+270,0,315]],[iscale, [0.75,0.75,0.75]]]],
      ["",[[iwidth,3],[idepth,2],[iheight,5],[iposition, "center"],[irotate,[180-75,0,90]],[itranslate,[-40,120,65]],[itranslate_rotate,[0,0,360-315]],[iscale, 1.5],[icolor,""]]]]        
  
   : scenario == "multibatch_basiccup_magnet" ? [["Basic Cup Magnet",1,[],[[imagnet_diameter, 6.5]],"multibatch_basiccup"]]
   : scenario == "multibatch_basiccup_magnetscrew" ? [["Basic Cup Magnet and Screw",1,[],[[imagnet_diameter, 6.5],[iscrew_depth,6]],"multibatch_basiccup"]]
   : scenario == "multibatch_basiccup_halfpitch" ? [["Half Pitch Cup HalfPitch",1,[],[[ihalf_pitch,true]],"multibatch_basiccup"]]
   : scenario == "multibatch_basiccup_halfpitch_magnet" ? [["Half Pitch Cup Magnet",1,[],[[ihalf_pitch,true],[imagnet_diameter, 6.5]],"multibatch_basiccup"]]
   : scenario == "multibatch_basiccup_halfpitch_magnetscrew" ? [["Half Pitch Cup Magnet and Screw",1,[],[[ihalf_pitch,true], [imagnet_diameter, 6.5],[iscrew_depth,6]],"multibatch_basiccup"]]
   : scenario == "multibatch_batch_flatbase" ? [["Flat Base",1,[],[[iflat_base, true]],"multibatch_basiccup"]]    
   : scenario == "multibatch_efficientfloor" ? [["Light Cup Magnet",1,[],[[iefficient_floor, "on"]],"multibatch_basiccup"]]
   : scenario == "multibatch_efficientfloor_magnet" ? [["Light Cup Magnet",1,[],[[iefficient_floor, "on"], [imagnet_diameter, 6.5]],"multibatch_basiccup"]]
   : scenario == "multibatch_efficientfloor_magnetscrew" ? [["Light Cup Magnet and Screw",1,[],[[iefficient_floor, "on"], [imagnet_diameter, 6.5],[iscrew_depth,6]],"multibatch_basiccup"]]
   : scenario == "multibatch_efficientfloor_halfpitch" ? [["Light Half Pitch Cup HalfPitch",1,[],[[iefficient_floor, "on"], [ihalf_pitch,true]],"multibatch_basiccup"]]
   : scenario == "multibatch_efficientfloor_halfpitch_magnet" ? [["Light Half Pitch Cup Magnet",1,[],[[iefficient_floor, "on"], [ihalf_pitch,true],[imagnet_diameter, 6.5]],"multibatch_basiccup"]]
   : scenario == "multibatch_efficientfloor_halfpitch_magnetscrew" ? [["Light Half Pitch Cup Magnet and Screw",1,[],[[iefficient_floor, "on"], [ihalf_pitch,true], [imagnet_diameter, 6.5],[iscrew_depth,6]],"multibatch_basiccup"]]
   : scenario == "multibatch_efficientfloor_flatbase" ? [["Light Flat Base",1,[],[[iefficient_floor, "on"], [iflat_base,true]],"multibatch_basiccup"]]

   : scenario == "floor_demo" ? [["Floor",36,[[90,0,0],[0,0,60],315],[[iheight, 5], [imagnet_diameter, 6.5], [iscrew_depth,6], [ihalf_pitch, false], [ibox_corner_attachments_only,false], [iefficient_floor,"off"]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "off"]]],//0
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "off"]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "off"], [ibox_corner_attachments_only,true]]],//2
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "off"], [ibox_corner_attachments_only,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "off"], [iscrew_depth,0], [ibox_corner_attachments_only,true]]],//4
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "off"], [iscrew_depth,0], [ibox_corner_attachments_only,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "off"], [imagnet_diameter, 0], [iscrew_depth,0]]],//6
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "off"], [imagnet_diameter, 0], [iscrew_depth,0]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "off"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]]],//8
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "off"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "on"]]],//10
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "on"]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "on"], [ibox_corner_attachments_only,true]]],//12
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "on"], [ibox_corner_attachments_only,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "on"], [iscrew_depth,0], [ibox_corner_attachments_only,true]]],//14
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "on"], [iscrew_depth,0], [ibox_corner_attachments_only,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "on"], [imagnet_diameter, 0], [iscrew_depth,0]]],//16
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "on"], [imagnet_diameter, 0], [iscrew_depth,0]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "on"], [ibox_corner_attachments_only,true], [iflat_base,true]]],//18
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "on"], [ibox_corner_attachments_only,true], [iflat_base,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "on"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]]],//20
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "on"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "slide"]]],//22
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "slide"]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "slide"], [ibox_corner_attachments_only,true]]],//24
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "slide"], [ibox_corner_attachments_only,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "slide"], [iscrew_depth,0], [ibox_corner_attachments_only,true]]],//26
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "slide"], [iscrew_depth,0], [ibox_corner_attachments_only,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "slide"], [imagnet_diameter, 0], [iscrew_depth,0]]],//28
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "slide"], [imagnet_diameter, 0], [iscrew_depth,0]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "slide"], [ibox_corner_attachments_only,true], [iflat_base,true]]],//30
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "slide"], [ibox_corner_attachments_only,true], [iflat_base,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "slide"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]]],//32
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "slide"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]]],
      ["", [[iwidth,1], [idepth,1], [iefficient_floor, "rounded"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]]],//34
      ["", [[iwidth,2], [idepth,3], [iefficient_floor, "rounded"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]]]
      ]
      
   //: scenario == "efficient_floor" ? [["Efficient Floor",8,[[70,0,270],[30,20,20],280],[[imagnet_diameter,6.5],[iscrew_depth,6],[icutx, 0.2]]],
  : scenario == "multi_floor_demo" ? [["Floor",1,[[90,0,0],[0,0,60],315],[[imagnet_diameter, 6.5], [iscrew_depth,6], [ihalf_pitch, false], [iefficient_floor,"off"], [ibox_corner_attachments_only,false], [iflat_base,false]]],
      ["", [[irotate, [0,0,0]],  [itranslate, [-gf_pitch,0.25*gf_pitch,0]], [iwidth,3], [idepth,2], [icuty,0.2], [ihelp, true]]],
      ["", [[irotate, [45,0,0]],[itranslate, [-1.6*gf_pitch,3*gf_zpitch,1.75*gf_pitch]], [iwidth,2], [idepth,2], [iheight,2]]],
      ["", [[irotate, [270-45,0,0]],[itranslate, [0.6*gf_pitch,5*gf_zpitch,2.75*gf_pitch]], [iefficient_floor, "off"],[iwidth,2], [idepth,2], [iheight,2]]]
      ]

    : scenario == "multi_floor_demo_ef_off" ? [["multi_floor_demo_ef_off",1,[],[[iefficient_floor, "off"]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_off_corner" ? [["",1,[],[[iefficient_floor, "off"], [ibox_corner_attachments_only,true]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_off_magnet_corner" ? [["",1,[],[[iefficient_floor, "off"], [iscrew_depth,0], [ibox_corner_attachments_only,true]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_off_noatt" ? [["",1,[],[[iefficient_floor, "off"], [imagnet_diameter, 0], [iscrew_depth,0]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_off_flat_noatt" ? [["",1,[],[[iefficient_floor, "off"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_on" ? [["",1,[],[[iefficient_floor, "on"]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_on_corner" ? [["",1,[],[[iefficient_floor, "on"], [ibox_corner_attachments_only,true]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_on_noatt" ? [["",1,[],[[iefficient_floor, "on"], [imagnet_diameter, 0], [iscrew_depth,0]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_on_flat_noatt" ? [["",1,[],[[iefficient_floor, "on"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_slide" ? [["",1,[],[[iefficient_floor, "slide"]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_slide_corner" ? [["",1,[],[[iefficient_floor, "slide"], [ibox_corner_attachments_only,true]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_slide_noatt" ? [["",1,[],[[iefficient_floor, "slide"], [imagnet_diameter, 0], [iscrew_depth,0]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_slide_flat_noatt" ? [["",1,[],[[iefficient_floor, "slide"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]],"multi_floor_demo"]]
    : scenario == "multi_floor_demo_ef_rounded_flat_noatt" ? [["",1,[],[[iefficient_floor, "rounded"], [imagnet_diameter, 0], [iscrew_depth,0], [iflat_base,true]],"multi_floor_demo"]]

    : assert(false, str("unknow scenario - '", scenario, "'")); 
   
module RenderScenario(scenario, showtext=true, height=height, stepIndex=-1,stepOverrides=[]){
  selectedScenario = getDerviedScenario(scenario);
  scenarioDefaults = selectedScenario[0];
  stepIndex = stepIndex > -1 ? stepIndex+1 : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1);
  animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]);  
  currentStepSettings = replace_Items(concat(scenarioDefaults[iscenariokv],animationStep[istepkv]), defaultDemoSetting);

  echo("🟧RenderScenario",scenario = scenario, stepIndex=stepIndex, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1), scenarioDefaults=scenarioDefaults, animationStep=animationStep, currentStepSettings=currentStepSettings);

  if(showtext && $preview)
  color("DimGray")
  translate($vpt)
  rotate($vpr)
  translate([0,-45,60])
   linear_extrude(height = 0.1)
   text(str(scenarioDefaults[iscenarioName], " - ", animationStep[istepName]), size=5,halign="center");
   
  echo(wallcutout_walls=currentStepSettings[iwallcutout_walls], efficient_floor=currentStepSettings[iefficient_floor], iwallcutout_walls=iwallcutout_walls, iefficient_floor=iefficient_floor);
  if(scenarioDefaults[iscenarioName] != "unknown scenario")
    color(currentStepSettings[icolor])
    rotate(currentStepSettings[itranslate_rotate]) 
    translate(currentStepSettings[itranslate])
    rotate(currentStepSettings[irotate]) 
    scale(currentStepSettings[iscale])
    gridfinity_basic_cup(
      width = width > -1 ? width : currentStepSettings[iwidth],
      depth = depth > -1 ? depth : currentStepSettings[idepth],
      height = height > -1 ? height : currentStepSettings[iheight],
      position = currentStepSettings[iposition],
      filled_in = currentStepSettings[ifilled_in],
      label=currentStepSettings[ilabel],
      label_size=currentStepSettings[ilabel_size],
      label_relief=currentStepSettings[ilabel_relief],
      wall_thickness=currentStepSettings[iwall_thickness],
      lip_style=currentStepSettings[ilip_style],
      zClearance=currentStepSettings[izClearance],
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
      wallpattern_style=currentStepSettings[iwallpattern_style],
      wallpattern_walls=currentStepSettings[iwallpattern_walls],
      wallpattern_dividers_enabled=currentStepSettings[iwallpattern_dividers_enabled],
      wallpattern_fill=currentStepSettings[iwallpattern_fill],
      wallpattern_hole_sides=currentStepSettings[iwallpattern_hole_sides],
      wallpattern_hole_size=currentStepSettings[iwallpattern_hole_size],
      wallpattern_hole_spacing=currentStepSettings[iwallpattern_hole_spacing],
      wallpattern_voronoi_noise=currentStepSettings[iwallpattern_voronoi_noise],
      wallpattern_voronoi_radius=currentStepSettings[iwallpattern_voronoi_radius],
      extension_enabled=currentStepSettings[iextension_enabled],
      extension_tabs_enabled=currentStepSettings[iextension_tabs_enabled],
      cutx=currentStepSettings[icutx],
      cuty=currentStepSettings[icuty],
      help=help || currentStepSettings[ihelp]);
}

function getDerviedScenario(scenario) = 
  let(selectedScenario = getScenario(scenario),
      baseScenario = len(selectedScenario) == 1 ? getScenario(selectedScenario[0][4]) : [],
      //If the length of the scenario is of length 1, there are no steps, so it must be a cloan
      derivedScenario = len(selectedScenario) != 1 ? [] : [
        for (i = [0:len(baseScenario)-1])
          if (i == 0 ) 
            [for (y = [0:4])
              if(y == 4) selectedScenario[0][4]
              else if (y==iscenariokv) concat(baseScenario[0][iscenariokv],selectedScenario[0][iscenariokv])
              else baseScenario[0][y]
            ]
          else baseScenario[i]
        ]
      )
    len(selectedScenario) != 1 
      ? selectedScenario : 
      derivedScenario; 

  /*
  module RenderScenario(scenario, showtext=true, height=height, stepIndex=-1,stepOverrides=[]){
selectedScenario = getScenario(scenario);
scenarioDefaults = selectedScenario[0];
stepIndex = stepIndex > -1 ? stepIndex+1 : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1);
animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]);  
currentStepSettings = replace_Items(concat(scenarioDefaults[iscenariokv],animationStep[istepkv]), defaultDemoSetting);
  */
  
color(colour)
union(){
  if(isMulti(scenario)){
    
    multiScenario = getDerviedScenario(scenario);
    for(i =[1:len(multiScenario)-1])
    {
      multiStep = multiScenario[i];
      //if the length of the step is 4, then the step is a copy from another scenario
      //["demo",1, [0, 0, 0], 5]],
      if(len(multiStep) == 4)
      {
        echo(multiStep=multiStep);
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

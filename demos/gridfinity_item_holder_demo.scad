// include <module_gridfinity_block.scad>
use <../gridfinity_item_holder.scad>
//use <modules/module_gridfinity_cup.scad>
include <../modules/functions_general.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "demo"; //["demo","grid", "hole_grid", "hole_sides", "hole_size", "hole_spacing", "hole_clearance", "hole_depth", "compartments", "compartment_spacing", "compartment_centered", "compartment_fill", "auto_bin_height", "floorheight","magnet","coaster", "multicoaster", "battery", "multibattery", "custom"]
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
/* item holder settings */
iitemholder_known_item = 0;
iitemholder_grid_style = iitemholder_known_item+1;
iitemholder_hole_sides = iitemholder_grid_style+1;
iitemholder_hole_size = iitemholder_hole_sides+1;
iitemholder_hole_spacing = iitemholder_hole_size+1;
iitemholder_hole_grid = iitemholder_hole_spacing+1;
iitemholder_hole_clearance = iitemholder_hole_grid+1;
iitemholder_hole_depth = iitemholder_hole_clearance+1;
iitemholder_hole_chamfer =iitemholder_hole_depth+1;
iitemholder_compartments = iitemholder_hole_chamfer+1;
iitemholder_compartment_spacing = iitemholder_compartments+1;
iitemholder_compartment_centered = iitemholder_compartment_spacing+1;
iitemholder_compartment_fill  = iitemholder_compartment_centered+1;
iitemholder_customcompartments = iitemholder_compartment_fill+1;
iitemholder_auto_bin_height = iitemholder_customcompartments+1;
iitemholder_multi_card_compact = iitemholder_auto_bin_height+1;
extendedsettingscount=iitemholder_multi_card_compact+1;

/*basic cup settings*/
iwidth=extendedsettingscount;
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
iwallpattern_style=iwallpattern_enabled+1;
iwallpattern_walls=iwallpattern_style+1;
iwallpattern_dividers_enabled=iwallpattern_walls+1;
iwallpattern_fill=iwallpattern_dividers_enabled+1;
iwallpattern_hole_sides=iwallpattern_fill+1;
iwallpattern_hole_size=iwallpattern_hole_sides+1;
iwallpattern_hole_spacing=iwallpattern_hole_size+1;
iwallpattern_voronoi_density_ratio = iwallpattern_hole_spacing+1;
iwallpattern_voronoi_radius =iwallpattern_voronoi_density_ratio+1;
iextension_enabled = iwallpattern_voronoi_radius+1;
iextension_tabs_enabled = iextension_enabled+1;
icutx=iextension_tabs_enabled+1;
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
    //itemholder_known_item, itemholder_grid_style, itemholder_hole_sides, itemholder_hole_size, itemholder_hole_spacing, 
    ["1/4hexshank", "square", 6, 5, 2,
    //itemholder_hole_grid, itemholder_hole_clearance, itemholder_hole_depth, itemholder_hole_chamfer
    [0, 0], 0.65, 0, 1,
    //itemholder_compartments, itemholder_compartment_spacing, itemholder_compartment_centered, itemholder_compartment_fill
    [1,1], 5, true, "none",
    //itemholder_customcompartments, itemholder_auto_bin_height, itemholder_multi_card_compact
    "", true, 0,
  
    //Gridfinity settins
    //width, depth, height, filled_in, label, label_width
    3,2,2,"default","off","disabled",1.5,
    //wall_thickness, lip_style, chamber_wall_thickness
    0.95, "normal",  1.2,
    //vertical_chambers, vertical_separator_bend_position,vertical_separator_bend_angle,vertical_separator_bend_separation,
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
    //wallpattern_enabled, wallpattern_style, wallpattern_walls, wallpattern_dividers_enabled, wallpattern_fill, wallpattern_hole_sides, wallpattern_hole_size, wallpattern_hole_spacing, wallpattern_voronoi_density_ratio, wallpattern_voronoi_radius 
    false, "hexgrid", [1,1,1,1], false, "none", 6, 5, 2, 50, 0.5,
    //extension_enabled, extension_tabs_enabled
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
  scenario == "demo" ? [["Item Holder",6,[],[]],
      ["4mm Hex Shank", [[iitemholder_known_item,"4hexshank"],[iitemholder_hole_chamfer,0.5]]],
      ["1/4\" Hex Shank", [[iitemholder_known_item,"1/4hexshank"],[iitemholder_grid_style,"hex"]]],
      ["AAA on hex grid", [[iitemholder_known_item,"aaa"],[iitemholder_grid_style,"hex"]]],
      ["AA", [[iitemholder_known_item,"aa"],[ifilled_in, "on"]]],
      ["18650", [[iitemholder_known_item,"18650"]]],
      ["Multi Card", [[iitemholder_known_item,"multicard"],[iitemholder_hole_chamfer,1],[iitemholder_multi_card_compact,0.7],[ifilled_in, "notstackable"]]],
      ["Nintendo DS", [[iitemholder_known_item,"nintendo2ds"],[iitemholder_hole_spacing,5], [iheight,5],
          [iwallpattern_enabled,true],[iwallpattern_walls,[0,1,1,1]], [iitemholder_auto_bin_height,false],[iwallpattern_style,"hexgrid"],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,90],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]]]//endscenario

  : scenario == "grid" ? [["grid",2,[],[[iitemholder_known_item,"aaa"]]],
      ["square", [[iitemholder_grid_style,"square"]]],
      ["hex", [[iitemholder_grid_style,"hex"]]]]//endscenario

  : scenario == "hole_sides" ? [["hole sides",4,[],[[iitemholder_known_item,""],[iitemholder_hole_depth, 10], [icuty,true]]],
      [4, [[iitemholder_hole_sides,4]]],
      [6, [[iitemholder_hole_sides,6]]],
      [8, [[iitemholder_hole_sides,8]]],
      [64, [[iitemholder_hole_sides,64]]]]//endscenario

  : scenario == "hole_size" ? [["hole size",3,[],[[iitemholder_known_item,""],[iitemholder_hole_depth, 10], [icuty,true]]],
      ["5mm", [[iitemholder_hole_size,5]]],
      ["7.5mm", [[iitemholder_hole_size,7.5]]],
      ["10mm", [[iitemholder_hole_size,10]]]]//endscenario

  : scenario == "hole_spacing" ? [["hole spacing",3,[],[[iitemholder_known_item,"aa"]]],
      ["2mm", [[iitemholder_hole_spacing,2]]],
      ["4mm", [[iitemholder_hole_spacing,4]]],
      ["6mm", [[iitemholder_hole_spacing,6]]]]//endscenario

  : scenario == "hole_grid" ? [["hole grid",3,[],[[iitemholder_known_item,"aa"]]],
      ["auto [0,0]", [[iitemholder_hole_grid,[0,0]]]],
      ["[5,4]", [[iitemholder_hole_grid,[5,4]]]],
      ["[9,2]", [[iitemholder_hole_grid,[9,2]]]]]//endscenario
      
  : scenario == "hole_clearance" ? [["hole clearance AA battery",3,[],[[iitemholder_known_item,"aa"]]],
      [0.7, [[iitemholder_hole_clearance,0.7]]],
      [1, [[iitemholder_hole_clearance,1]]],
      [2, [[iitemholder_hole_clearance,2]]]]//endscenario
 
  : scenario == "hole_depth" ? [["hole depth AA battery",4,[],[[iitemholder_known_item,"aa"], [iitemholder_auto_bin_height, false], [icuty,true]]],
      ["default (0)", [[iitemholder_hole_depth,0], [iitemholder_auto_bin_height, true]]],
      [5, [[iitemholder_hole_depth,5]]],
      [10, [[iitemholder_hole_depth,10]]],
      [20, [[iitemholder_hole_depth,20]]]]//endscenario

  : scenario == "compartments" ? [["compartments",3,[],[[iitemholder_known_item,"aaa"], [icuty,true]]],
      ["default ([1,1])", [[iitemholder_compartments, [1,1]]]],
      ["[1,2]", [[iitemholder_compartments, [1,2]]]],
      ["[2,2]", [[iitemholder_compartments, [2,2]]]]]//endscenario
      
  : scenario == "compartment_spacing" ? [["compartment spacing",3,[],[[iitemholder_known_item,"aaa"], [icuty,true]]],
      ["5mm", [[iitemholder_compartment_spacing, 5]]],
      ["10mm", [[iitemholder_compartment_spacing, 10]]],
      ["15mm", [[iitemholder_compartment_spacing, 15]]]]//endscenario

  : scenario == "compartment_centered" ? [["compartment centered", 4,[],[[iitemholder_known_item,"aaa"]]],
      ["on", [[iitemholder_compartment_centered, true], [iitemholder_compartments, [1,1]]]],
      ["off", [[iitemholder_compartment_centered, false], [iitemholder_compartments, [1,1]]]],
      ["on", [[iitemholder_compartment_centered, true], [iitemholder_compartments, [2,2]]]],
      ["off", [[iitemholder_compartment_centered, false], [iitemholder_compartments, [2,2]]]]]//endscenario
      
  : scenario == "compartment_fill" ? [["compartment fill", 3,[],[[iitemholder_known_item,"aaa"]]],
      ["none", [[iitemholder_compartment_fill, "none"], [iitemholder_compartments, [1,1]]]],
      ["space", [[iitemholder_compartment_fill, "space"], [iitemholder_compartments, [1,1]]]],
      ["crop", [[iitemholder_compartment_fill, "crop"], [iitemholder_compartments, [1,1]]]]]//endscenario

  : scenario == "auto_bin_height" ? [["auto bin height",2,[],[[iitemholder_known_item,"1/4hexlongshank"]]],
      ["on", [[iitemholder_auto_bin_height, true]]],
      ["off", [[iitemholder_auto_bin_height, false]]]]//endscenario
    
  : scenario == "floorheight" ? [["Floor height", 4,[],[[iitemholder_compartments, [1,2]],[iheight, 2]]],
     ["5mm", [[ifloor_thickness, 5]]],
     ["10mm", [[ifloor_thickness, 10]]],
     ["filledin", [[ifilled_in, "on"]]],
     ["filledin not stackable", [[ifilled_in, "notstackable"]]]]//endscenario

   : scenario == "coaster" ? [["Coaster", 6,[],[[iitemholder_known_item,""],[iitemholder_hole_depth,1],[iwidth, 2],[idepth, 2],[iheight, 1],[iitemholder_auto_bin_height,false]]],
     ["circle 73mm stackable", [[iitemholder_hole_size,73],[iitemholder_hole_sides,64],[ifilled_in, "on"]]],
     ["circle 73mm", [[iitemholder_hole_size,73],[iitemholder_hole_sides,64],[ifilled_in, "notstackable"]]],
     ["hex grid chamfer stackable", [[iitemholder_hole_spacing,1.5],[iitemholder_hole_sides,6],[iitemholder_grid_style,"hex"],[iitemholder_hole_chamfer,0],[ifilled_in, "on"]]],
     ["hex grid chamfer", [[iitemholder_hole_sides,6],[iitemholder_grid_style,"hex"],[iitemholder_hole_chamfer,0],[ifilled_in, "notstackable"]]],
     ["hex grid stackable", [[iitemholder_hole_sides,6],[iitemholder_grid_style,"hex"],[iitemholder_hole_chamfer,1],[ifilled_in, "on"]]],
     ["hex grid", [[iitemholder_hole_sides,6],[iitemholder_grid_style,"hex"],[iitemholder_hole_chamfer,1],[ifilled_in, "notstackable"]]]]//

   : scenario == "multicoaster" ? [["Multi",1,[[60,0,0],[120,0,60],600],[]],
      ["coaster",1,[0, 0, 0], -1],
      ["coaster",0,[0, gf_pitch*(2+multi_spacing.y), 0], -1],
      ["coaster",3,[gf_pitch*(2+multi_spacing.x), 0, 0], -1],
      ["coaster",2,[gf_pitch*(2+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0], -1],
      ["coaster",5,[gf_pitch*(2+multi_spacing.x)*2, 0, 0], -1],
      ["coaster",4,[gf_pitch*(2+multi_spacing.x)*2, gf_pitch*(2+multi_spacing.y), 0], -1]]   

     
 // [ custom:"Custom", 4hexshank:"4mm Hex Shank", 1/4hexshank:"1/4 Hex Shank", 1/4hexlongshank:"1/4 Hex Long Shank", 5/16hexshank:"5/16 Hex Shank", 3/8hexshank:"3/8 Hex Shank", "aaaa":"AAAA cell", "aaa":"AAA cell", "aa":"AA cell", "c":"C cell", "d":"d cell", "7540":"7540 cell", "8570":"8570 cell", "10180":"10180 cell", "10280":"10280 cell", "10440":"10440 cell", "10850":"10850 cell", "13400":"13400 cell", "14250":"14250 cell", "14300":"14300 cell", "14430":"14430 cell", "14500":"14500 cell", "14650":"14650 cell", "15270":"15270 cell", "16340":"16340 cell", "16650":"16650 cell", "17500":"17500 cell", "17650":"17650 cell", "17670":"17670 cell", "18350":"18350 cell", "18490":"18490 cell", "18500":"18500 cell", "18650":"18650 cell", "20700":"20700 cell", "21700":"21700 cell", "25500":"25500 cell", "26500":"26500 cell", "26650":"26650 cell", "26700":"26700 cell", "26800":"26800 cell", "32600":"32600 cell", "32650":"32650 cell", "32700":"32700 cell", "38120":"38120 cell", "38140":"38140 cell", "40152":"40152 cell", "4680":"4680 cell"]
   : scenario == "battery" ? [["Battery", 12,[],[[iitemholder_auto_bin_height,true],[ifilled_in, "on"],[iitemholder_grid_style,"auto"],[iitemholder_compartment_fill,"space"],[iwidth, 3],[idepth, 2]]],
    ["AAAA", [[iitemholder_known_item,"aaaa"]]],
    ["AAA", [[iitemholder_known_item,"aaa"]]],
    ["AA", [[iitemholder_known_item,"aa"]]],
    ["C", [[iitemholder_known_item,"c"]]],
    ["D", [[iitemholder_known_item,"d"]]],
    ["4680", [[iitemholder_known_item,"4680"]]],
    ["10440", [[iitemholder_known_item,"10440"]]],
    ["18350", [[iitemholder_known_item,"18350"]]],
    ["18650", [[iitemholder_known_item,"18650"]]],
    ["21700", [[iitemholder_known_item,"21700"]]],
    ["32600", [[iitemholder_known_item,"32600"]]],
    ["40152", [[iitemholder_known_item,"40152"]]]]//
      
   : scenario == "multibattery" ? [["Multi",1,[[60,0,0],[120,0,60],600],[]],
      ["battery",0,[0, 0, 0], [[iwidth, 1],[idepth, 2]]],
      ["battery",1,[gf_pitch*(1+multi_spacing.x), 0, 0], [[iwidth, 2],[idepth, 2]]],
      ["battery",2,[gf_pitch*(3+multi_spacing.x*2), 0, 0], [[iwidth, 3],[idepth, 2]]],
      ["battery",3,[0, gf_pitch*(2+multi_spacing.y), 0], [[iwidth, 1],[idepth, 2]]],
      ["battery",4,[gf_pitch*(1+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0], [[iwidth, 2],[idepth, 2]]],
      ["battery",5,[gf_pitch*(3+multi_spacing.x*2), gf_pitch*(2+multi_spacing.y), 0], [[iwidth, 3],[idepth, 2]]]]    
      
  : scenario == "custom" ? [["Custom", 3, []]]//endscenario

   : [["unknown scenario",[]]];

module RenderScenario(scenario, showtext=true, height=height, stepIndex=-1, multiStepOverrides = []){
  selectedScenario = getScenario(scenario);
  scenarioDefaults = selectedScenario[0];
  stepIndex = stepIndex > -1 ? stepIndex+1 : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1);
  animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]);  
  currentStepSettings = replace_Items(concat(concat(scenarioDefaults[iscenariokv],animationStep[istepkv]), multiStepOverrides), defaultDemoSetting);
  echo("🟧RenderScenario",scenario = scenario, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1), animationStep=animationStep, currentStepSettings=currentStepSettings);

  
  if(!isMulti(scenario) && len(selectedScenario)-1 != selectedScenario[0][1]){
    echo("🟧RenderScenario - warning steps is not correct, update for PS script to function",scenarioStepsConfig = selectedScenario[0][1], steps=len(selectedScenario)-1);
  }
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
    gridfinity_itemholder(
      //itemholder settings
      itemholder_grid_style = currentStepSettings[iitemholder_grid_style],
      itemholder_hole_sides = currentStepSettings[iitemholder_hole_sides],
      itemholder_hole_size = currentStepSettings[iitemholder_hole_size],
      itemholder_hole_spacing = currentStepSettings[iitemholder_hole_spacing],
      itemholder_hole_grid = currentStepSettings[iitemholder_hole_grid],
      itemholder_hole_clearance = currentStepSettings[iitemholder_hole_clearance],
      itemholder_hole_depth = currentStepSettings[iitemholder_hole_depth],
      itemholder_hole_chamfer = currentStepSettings[iitemholder_hole_chamfer],
      itemholder_compartments = currentStepSettings[iitemholder_compartments],
      itemholder_compartment_spacing = currentStepSettings[iitemholder_compartment_spacing],
      itemholder_compartment_centered = currentStepSettings[iitemholder_compartment_centered],
      itemholder_compartment_fill  = currentStepSettings[iitemholder_compartment_fill],
      itemholder_customcompartments = currentStepSettings[iitemholder_customcompartments],
      itemholder_auto_bin_height = currentStepSettings[iitemholder_auto_bin_height],
      itemholder_multi_card_compact = currentStepSettings[iitemholder_multi_card_compact],
      itemholder_known_item = currentStepSettings[iitemholder_known_item],
      
      width = width > -1 ? width : currentStepSettings[iwidth],
      depth = depth > -1 ? depth : currentStepSettings[idepth],
      height = height > -1 ? height : currentStepSettings[iheight],
      position = currentStepSettings[iposition],
      filled_in = currentStepSettings[ifilled_in],
      label=currentStepSettings[ilabel],
      label_width=currentStepSettings[ilabel_width],
      wall_thickness=currentStepSettings[iwall_thickness],
      lip_style=currentStepSettings[ilip_style],
      vertical_chambers = ChamberSettings(
        chambers_count = currentStepSettings[ivertical_chambers],
        chamber_wall_thickness = currentStepSettings[ichamber_wall_thickness],
        //chamber_wall_headroom = chamber_wall_headroom,
        separator_bend_position = currentStepSettings[ivertical_separator_bend_position],
        separator_bend_angle = currentStepSettings[ivertical_separator_bend_angle],
        separator_bend_separation = currentStepSettings[ivertical_separator_bend_separation],
        separator_cut_depth = currentStepSettings[ivertical_separator_cut_depth],
        irregular_subdivisions = currentStepSettings[ivertical_irregular_subdivisions],
        separator_config = currentStepSettings[ivertical_separator_config]),
      horizontal_chambers = ChamberSettings(
        chambers_count = currentStepSettings[ihorizontal_chambers],
        chamber_wall_thickness = currentStepSettings[ichamber_wall_thickness],
        //chamber_wall_headroom = chamber_wall_headroom,
        separator_bend_position = currentStepSettings[ihorizontal_separator_bend_position],
        separator_bend_angle = currentStepSettings[ihorizontal_separator_bend_angle],
        separator_bend_separation = currentStepSettings[ihorizontal_separator_bend_separation],
        separator_cut_depth = currentStepSettings[ihorizontal_separator_cut_depth],
        irregular_subdivisions = currentStepSettings[ihorizontal_irregular_subdivisions],
        separator_config = currentStepSettings[ihorizontal_separator_config]),
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
      wallpattern_voronoi_density_ratio=currentStepSettings[iwallpattern_voronoi_density_ratio],
      wallpattern_voronoi_radius=currentStepSettings[iwallpattern_voronoi_radius],
      extension_enabled=currentStepSettings[iextension_enabled],
      extension_tabs_enabled=currentStepSettings[iextension_tabs_enabled],
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
      if(len(multiStep) == 4 )
      {
        echo(multiStep=multiStep);
        //["demo",1, [0, 0, 0], [[],[]]]],
        translate(multiStep[2])
        RenderScenario(
          scenario = multiStep[0], 
          height = -1, 
          stepIndex = multiStep[1], 
          showtext = false,
          multiStepOverrides = len(multiStep) == 4 ? multiStep[3] : [] //Used for overriding bin size for multi
          );
      }
      else{
        RenderScenario(scenario, stepIndex=i-1, showtext = false);
      }
    }
  } else{
    RenderScenario(scenario, showtext);
  }
}
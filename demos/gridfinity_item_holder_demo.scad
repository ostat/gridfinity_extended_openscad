// include <gridfinity_modules.scad>
use <../gridfinity_item_holder.scad>
//use <modules/gridfinity_cup_modules.scad>
include <../modules/functions_general.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "demo"; //["demo","grid", "hole_grid", "hole_sides", "hole_size", "hole_spacing", "hole_clearance", "hole_depth", "compartments", "compartment_spacing", "compartment_centered", "compartment_fill", "auto_bin_height", "floorheight","magnet","coaster", "multicoaster", "custom"]
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
iitemholder_known_item = 0;
iitemholder_hex_grid = 1;
iitemholder_hole_sides = 2;
iitemholder_hole_size = 3;
iitemholder_hole_spacing = 4;
iitemholder_hole_grid = 5;
iitemholder_hole_clearance = 6;
iitemholder_hole_depth = 7;
iitemholder_hole_chamfer =8;
iitemholder_compartments = 9;
iitemholder_compartment_spacing = 10;
iitemholder_compartment_centered = 11;
iitemholder_compartment_fill  = 12;
iitemholder_customcompartments = 13;
iitemholder_auto_bin_height = 14;
iitemholder_multi_card_compact = 15; 
extendedsettingscount=16;

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
itranslate=43+extendedsettingscount;
irotate=44+extendedsettingscount;

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
    //itemholder_known_item, itemholder_hex_grid, itemholder_hole_sides, itemholder_hole_size, itemholder_hole_spacing, 
    ["1/4hexshank", false, 6, 5, 2,
    //itemholder_hole_grid, itemholder_hole_clearance, itemholder_hole_depth, itemholder_hole_chamfer
    [0, 0], 0.65, 0, 1,
    //itemholder_compartments, itemholder_compartment_spacing, itemholder_compartment_centered, itemholder_compartment_fill
    [1,1], 5, true, "none",
    //itemholder_customcompartments, itemholder_auto_bin_height, itemholder_multi_card_compact
    "", true, 0,
  
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
    //cutx,cuty,rotate,translate
    0, 0, [0,0,0], [0,0,0]];
   
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
      ["1/4\" Hex Shank", [[iitemholder_known_item,"1/4hexshank"],[iitemholder_hex_grid,true]]],
      ["AAA on hex grid", [[iitemholder_known_item,"aaa"],[iitemholder_hex_grid,true]]],
      ["AA", [[iitemholder_known_item,"aa"],[ifilled_in, "on"]]],
      ["18650", [[iitemholder_known_item,"18650"]]],
      ["Multi Card", [[iitemholder_known_item,"multicard"],[iitemholder_hole_chamfer,1],[iitemholder_multi_card_compact,0.7],[ifilled_in, "notstackable"]]],
      ["Nintendo DS", [[iitemholder_known_item,"nintendo2ds"],[iitemholder_hole_spacing,5], [iheight,5],
          [iwallpattern_enabled,true],[iwallpattern_walls,[0,1,1,1]], [iitemholder_auto_bin_height,false],[iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,90],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]]]//endscenario

  : scenario == "grid" ? [["grid",2,[],[[iitemholder_known_item,"aaa"]]],
      ["square", [[iitemholder_hex_grid,false]]],
      ["hex", [[iitemholder_hex_grid,true]]]]//endscenario

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
     ["hex grid chamfer stackable", [[iitemholder_hole_spacing,1.5],[iitemholder_hole_sides,6],[iitemholder_hex_grid,true],[iitemholder_hole_chamfer,0],[ifilled_in, "on"]]],
     ["hex grid chamfer", [[iitemholder_hole_sides,6],[iitemholder_hex_grid,true],[iitemholder_hole_chamfer,0],[ifilled_in, "notstackable"]]],
     ["hex grid stackable", [[iitemholder_hole_sides,6],[iitemholder_hex_grid,true],[iitemholder_hole_chamfer,1],[ifilled_in, "on"]]],
     ["hex grid", [[iitemholder_hole_sides,6],[iitemholder_hex_grid,true],[iitemholder_hole_chamfer,1],[ifilled_in, "notstackable"]]]]//

   : scenario == "multicoaster" ? [["Multi",1,[[60,0,0],[120,0,60],600],[]],
      ["coaster",1,[0, 0, 0], 5],
      ["coaster",0,[0, gf_pitch*(2+multi_spacing.y), 0], 8],
      ["coaster",3,[gf_pitch*(2+multi_spacing.x), 0, 0], 5],
      ["coaster",2,[gf_pitch*(2+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0], 8],
      ["coaster",5,[gf_pitch*(2+multi_spacing.x)*2, 0, 0], 5],
      ["coaster",4,[gf_pitch*(2+multi_spacing.x)*2, gf_pitch*(2+multi_spacing.y), 0], 8]]     
     
  : scenario == "custom" ? [["Custom", 3, []]]//endscenario

   : [["unknown scenario",[]]];

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
    gridfinity_itemholder(
      //itemholder settings
      itemholder_hex_grid = currentStepSettings[iitemholder_hex_grid],
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
      center_magnet_diameter = currentStepSettings[icenter_magnet_diameter], 
      center_magnet_thickness = currentStepSettings[icenter_magnet_thickness],
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
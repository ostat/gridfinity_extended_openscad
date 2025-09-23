// include <module_gridfinity_block.scad>
use <../gridfinity_tray.scad>
//use <modules/module_gridfinity_cup.scad>
include <../modules/functions_general.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "demo"; //["demo","verticalcompartments","horizontalcompartments","traycornerradius","floorheight","magnet","coastert","multicoastert","custom"]
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
itranslate=43+traysettingscount;
irotate=44+traysettingscount;

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
    //cutx,cuty,rotate, translate
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
  scenario == "demo" ? [["Tray",7,[],[]],
      ["catchall", [[itraycornerradius, 1],[ifloor_thickness, 10]]],
      ["parts holder", [[itraycornerradius, 5],[ifloor_thickness, 10],[itrayhorizontalcompartments, 2],[itrayverticalcompartments, 3]]],
      ["custom parts1", [[iwidth, 3],[idepth, 2],[iheight,2],[ifilled_in, "notstackable"],[itraycustomcompartments, "0, 0, 0.5, 2, 2, 6|0.5, 0, 0.5, 2,2, 6|1, 0, 2, 1|1, 1, 2, 1"]]],
      ["custom parts2", [[iwidth, 4],[idepth, 3],[iheight,1],[ifilled_in, "notstackable"],[itraycustomcompartments, "0, 0, 2, 1.5, 1, 1|0, 1.5, 2, 1.5, 1, 1|2, 0, 2, 3,6"]]],
      ["custom parts3", [[iwidth, 3],[idepth, 2],[iheight,3],[ifilled_in, "notstackable"],[itraycustomcompartments, "0,0,0.5,1,2,7|0,1,0.5,1,2,7|0.5,0,0.5,1,2,7|0.5,1,0.5,1,2,7|1,1,0.5,1,2,7|1.5,1,0.5,1,2,7|2,1,0.5,1,2,7|2.5,1,0.5,1,2,7|1,0,2,1,2,3|1,0,2,2,2,12"]]],
      ["walled catchall ", [[itraycornerradius, 1],[ifloor_thickness, 10], [iheight,5],
      [iwallpattern_enabled,true],[iwallpattern_walls,[0,1,1,1]], [iwallpattern_hexgrid,true],[iwallpattern_hole_sides,6],[iwallpattern_fill,"none"],
          [iwallcutout_enabled, true], [iwallcutout_walls,[1,0,0,0]],[iwallcutout_width,90],[iwallcutout_angle,70],[iwallcutout_height,-1],[iwallcutout_corner_radius,5]]]]
          
          
          
          
      
  : scenario == "traycornerradius" ? [["Tray Corner Radius", 3,[],[[ifilled_in, "notstackable"]]],
      ["1", [[itraycornerradius, 1]]],
      ["2", [[itraycornerradius, 2]]],
      ["4", [[itraycornerradius, 4]]]]
      
  : scenario == "verticalcompartments" ? [["Vertical Compartments", 4,[],[[ifilled_in, "on"]]],
      ["0", [[itrayverticalcompartments, 0]]],
      ["1", [[itrayverticalcompartments, 1]]],
      ["2", [[itrayverticalcompartments, 2]]],
      ["4", [[itrayverticalcompartments, 4]]]]

  : scenario == "horizontalcompartments" ? [["Horizontal Compartments", 4,[],[[ifilled_in, "on"]]],
      ["0", [[itrayhorizontalcompartments, 0]]],
      ["1", [[itrayhorizontalcompartments, 1]]],
      ["2", [[itrayhorizontalcompartments, 2]]],
      ["4", [[itrayhorizontalcompartments, 4]]]]
      
  : scenario == "magnet" ? [["Tray Magnet",5,[],[]],
     ["6mm x 2.4mm", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]],[icenter_magnet_diameter, 6], [icenter_magnet_thickness, 2.4]]],
     ["10mm x 5mm", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]],[icenter_magnet_diameter, 10], [icenter_magnet_thickness, 5]]],
     ["15mm x 5mm", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]],[icenter_magnet_diameter, 15], [icenter_magnet_thickness, 5]]],
     ["20mm x 5mm", [[[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]],icenter_magnet_diameter, 20], [icenter_magnet_thickness, 5]]],
     ["off", [[irotate, [180,0,0]], [itranslate, [0,-gf_pitch,-gf_pitch]]]]]
    
  : scenario == "floorheight" ? [["Floor height",4,[],[[itrayverticalcompartments, 2],[iheight, 2]]],
     ["5mm", [[ifloor_thickness, 5]]],
     ["10mm", [[ifloor_thickness, 10]]],
     ["filledin", [[ifilled_in, "on"]]],
     ["filledin not stackable", [[ifilled_in, "notstackable"]]]]
     
  : scenario == "coastert" ? [["Coaster",8,[],[[iwidth, 2],[idepth, 2],[iheight, 1]]],
     ["5x5 r1 stackable", [[itrayverticalcompartments, 5],[itrayhorizontalcompartments, 5], [itraycornerradius, 1], [ifilled_in, "on"]]],
     ["5x5 r1 not stackable", [[itrayverticalcompartments, 5],[itrayhorizontalcompartments, 5],[itraycornerradius, 1], [ifilled_in, "notstackable"]]],
     ["5x5 r2 stackable", [[itrayverticalcompartments, 5],[itrayhorizontalcompartments, 5], [itraycornerradius, 2],[ifilled_in, "on"]]],
     ["5x5 r2 not stackable", [[itrayverticalcompartments, 5],[itrayhorizontalcompartments, 5], [itraycornerradius, 2],[ifilled_in, "notstackable"]]],
     ["1x1 r1 stackable", [[itrayverticalcompartments, 1],[itrayhorizontalcompartments, 1], [itraycornerradius, 1],[ifilled_in, "on"]]],
     ["1x1 r1 not stackable", [[itrayverticalcompartments, 1],[itrayhorizontalcompartments, 1], [itraycornerradius, 1],[ifilled_in, "notstackable"]]],
     ["1x1 r2 stackable", [[itrayverticalcompartments, 1],[itrayhorizontalcompartments, 1], [itraycornerradius, 2],[ifilled_in, "on"]]],
     ["1x1 r2 not stackable", [[itrayverticalcompartments, 1],[itrayhorizontalcompartments, 1], [itraycornerradius, 2],[ifilled_in, "notstackable"]]]]
     
     
  : scenario == "custom" ? [["Custom",3,[],[]],
      ["1", [[iwidth, 4],[idepth, 3],[iheight,2],[ifilled_in, "notstackable"],[itraycustomcompartments, "0, 0, 0.5, 3, 2, 6|0.5, 0, 0.5, 3,2, 6|1, 0, 3, 1.5|1, 1.5, 3, 1.5"]]],
      ["2", [[iwidth, 4],[idepth, 3],[iheight,1],[ifilled_in, "notstackable"],[itraycustomcompartments, "0, 0, 2, 1.5, 1, 1|0, 1.5, 2, 1.5, 1, 1|2, 0, 2, 3,6"]]],
      ["3", [[iwidth, 4],[idepth, 3],[iheight,1.5],[ifilled_in, "on"],[itraycustomcompartments, "0,0,0.5,1.5,1,1|0.5,0,0.5,1.5,1,2|1,0,0.5,1.5,1,3|1.5,0,0.5,1.5,1,4|0,1.5,0.5,1.5,1,1|0.5,1.5,0.5,1.5,2,1|1,1.5,0.5,1.5,3,1|1.5,1.5,0.5,1.5,4,1|2, 0, 2, 3,6"]]]]

   : scenario == "multicoastert" ? [["Coasters",1,[[60,0,0],[120,0,60],600],[]],
      ["coastert",1,[0, 0, 0], 5],
      ["coastert",0,[0, gf_pitch*(2+multi_spacing.y), 0], 8],
      ["coastert",3,[gf_pitch*(2+multi_spacing.x), 0, 0], 5],
      ["coastert",2,[gf_pitch*(2+multi_spacing.x), gf_pitch*(2+multi_spacing.y), 0], 8],
      ["coastert",5,[gf_pitch*(2+multi_spacing.x)*2, 0, 0], 5],
      ["coastert",4,[gf_pitch*(2+multi_spacing.x)*2, gf_pitch*(2+multi_spacing.y), 0], 8]]     
      
   : [["unknown scenario",[]]];

module RenderScenario(scenario, showtext=true, height=height, stepIndex=-1){
  selectedScenario = getScenario(scenario);
  scenarioDefaults = selectedScenario[0];
  stepIndex = stepIndex > -1 ? stepIndex+1 : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1);
  animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]);  
  currentStepSettings = replace_Items(concat(scenarioDefaults[iscenariokv],animationStep[istepkv]), defaultDemoSetting);

  echo("🟧RenderScenario",scenario = scenario, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1), animationStep=animationStep, selectedScenarioLen=len(selectedScenario), defaultDemoSettingLen=len(defaultDemoSetting), currentStepSettings=currentStepSettings);

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
    gridfinity_tray(
      tray_spacing = currentStepSettings[itrayspacing],
      tray_corner_radius = currentStepSettings[itraycornerradius], 
      tray_zpos = currentStepSettings[itrayzpos], 
      tray_vertical_compartments = currentStepSettings[itrayverticalcompartments],
      tray_horizontal_compartments = currentStepSettings[itrayhorizontalcompartments],
      tray_custom_compartments = currentStepSettings[itraycustomcompartments],
      
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

      finger_slide_settings = FingerSlideSettings(
        type = currentStepSettings[ifingerslide],
        radius = currentStepSettings[ifingerslide_radius],
        walls = [1,1,1,1],
        lip_aligned = false),
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
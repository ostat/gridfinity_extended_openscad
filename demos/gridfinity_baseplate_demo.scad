// include instead of use, so we get the pitch
include <../modules/gridfinity_constants.scad>
include <../modules/functions_general.scad>
use <../modules/module_gridfinity.scad>
use <../modules/module_gridfinity_baseplate.scad>

scenario = "demo"; //["demo","demo2","baseplate","magnet","weighted", "lid","lid_flat_base","lid_half_pitch","customsize"]
showtext = true;

//Include help info in the logs
help=false;
setViewPort=true;

$vpr = setViewPort ? [60,0,320] : $vpr;
$vpt = setViewPort ? [32,13,16] : $vpt; //shows translation (i.e. won't be affected by rotate and zoom)
$vpf = setViewPort ? 25 : $vpf; //shows the FOV (Field of View) of the view [Note: Requires version 2021.01]
$vpd = setViewPort ? 280 : $vpd;//shows the camera distance [Note: Requires version 2015.03]

fa = 6; 
// minimum size of a fragment.  Low is more fragments
fs = 0.4; 
// number of fragments, overrides $fa and $fs
fn = 0;  
    
/* [Hidden] */
module end_of_customizer_opts() {}
/*<!!end gridfinity_basic_cup!!>*/

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;  

//Array index
ibasePlateOption = "basePlateOption";
iwidth = "width";
idepth = "depth";
ioversizeMethod = "oversizeMethod";
iouter_num_x = "outerNumx";
iouter_num_y = "outerNumy";
iposition_fill_grid_x = "positionFillGridx";
iposition_fill_grid_y = "positionFillGridy";
iposition_grid_in_outer_x = "positionGridInOuterx";
iposition_grid_in_outer_y = "positionGridInOutery";
iplate_corner_radius = "plateCornerRadius";
imagnetSize = "magnetSize";
ireducedWallHeight = "reducedWallHeight";
icornerScrewEnabled = "cornerScrewEnabled";
icenterScrewEnabled = "centerScrewEnabled";
iweightedEnable = "weightedEnable";

igridPositions = "gridPositions";
icustomGridEnabled = "customGridEnabled";

iconnectorButterflyEnabled = "connectorButterflyEnabled";
iconnectorButterflySize = "connectorButterflySize";
iconnectorButterflyRadius = "connectorButterflyRadius";
iconnectorFilamentEnabled = "connectorFilamentEnabled";
iconnectorFilamentDiameter = "connectorFilamentDiameter";
iconnectorFilamentLength = "connectorFilamentLength";
icutx = "cutx";
icuty = "cuty";

//depricated
iplateOptions = "plateOptions";
  
//Basic cup default settings for demo
defaultDemoSetting = 
    [[ibasePlateOption,"default"], [iwidth,[3,0]], [idepth,[2,0]],
    [ioversizeMethod,"fill"], 
    [iouter_num_x,[0, 0]], [iouter_num_y,[0, 0]],
    [iposition_fill_grid_x,"near"], [iposition_fill_grid_y,"near"],
    [iposition_grid_in_outer_x,"center"], [iposition_grid_in_outer_y,"center"],
    [ireducedWallHeight,0], [iplate_corner_radius,3.75], 
    
    //Base Plate Options
    [imagnetSize,[6.5,2.4]],
    [ireducedWallHeight,0], [icornerScrewEnabled,false], [icenterScrewEnabled,false], 
    [iweightedEnable,false],
    
    //Base Plate Clips
    [iconnectorButterflyEnabled,false],
    [iconnectorButterflySize,[6,6,1.5]],
    [iconnectorButterflyRadius,0.1],
    [iconnectorFilamentEnabled,false],
    [iconnectorFilamentDiameter,2],
    [iconnectorFilamentLength,8],
    [iplateOptions,"depricated"],
    //Custom Grid
    [icustomGridEnabled,false], [igridPositions,""],
    [icutx,0],[icuty,0]];
     
selectedScenario = 
  scenario == "demo" ? [["Base Plate", 12,[]],
      ["Simple", false,[[imagnetSize,[0,0]]]],
      ["Efficient Magnet", false,[[imagnetSize,[6.5,2.4]]]],
      ["Weighted", false,[[iplateOptions, "weighted"]]],
      ["Woodscrew", false,[[iplateOptions, "woodscrew"]]],
      ["CNC or Laser cut", false,[[iplateOptions, "cnc"]]],
      ["CNC cut with Magnet", false,[[iplateOptions, "cncmagnet"]]],
      //["Lid", false,[[iplateStyle, "lid"], [iplateOptions, ""]]],
      //["Lid Flat Base", false,[[iplateStyle, "lid"], [ilidOptions,"flat"]]],
      //["Lid Half Pitch", false,[[iplateStyle, "lid"], [ilidOptions,"halfpitch"]]],
      ["Simple - fill", false,[[iwidth,[3.5,0]], [idepth,[2.2,0]], [iplateOptions, ""]]],
      ["CNC - crop", false,[[iwidth,[3.5,0]], [idepth,[2.2,0]], [iplateOptions, "cnc"], [ioversizeMethod,"crop"]]],
      ["Custom",false,[[iplateOptions,"default"],[icustomGridEnabled,true],
          [igridPositions,"3,4,0,0|2,2,0,0|2,2,2,0|6,2,2,0"]]]]
      
  : scenario == "baseplate" ? [["", 1,[[iplateStyle, "base"]]],
      ["Base Plate", false,[[iplateStyle, "default"],[iplateOptions,""]]]]
      
   : scenario == "demo2" ? [["Magnet",4,[[iwidth,[0,420]], [idepth,[0,500]]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]
      
  : scenario == "magnet" ? [["Magnet",4,[[imagnetSize,[6.5,2.4]]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]
      
  : scenario == "weighted" ? [["Weighted",4,[[iplateStyle, "base"], [iplateOptions,"weighted"]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]
      
  : scenario == "lid" ? [["Lid",4,[[iplateStyle, "lid"], [iplateOptions,""], [ilidOptions,"default"]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]
      
  : scenario == "lid_flat_base" ? [["Lid flat base",4,[[iplateStyle, "lid"], [iplateOptions,""], [ilidOptions,"flat"]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]

  : scenario == "lid_half_pitch" ? [["Lid half pitch",4,[[iplateStyle, "lid"], [iplateOptions,""], [ilidOptions,"halfpitch"]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]

  : scenario == "customsize" ? [["Custom Size",3,[[iplateStyle, "base"], [ilidOptions,"halfpitch"]]],
      ["Base",false,[[iplateOptions,"default"],[icustomGridEnabled,true],
          [igridPositions,"3,4,0,0|2,2,0,0|2,2,2,0|6,2,2,0"]]],
      ["Magnet",false,[[iplateOptions,"magnet"],[icustomGridEnabled,true],
          [igridPositions,"3,4,0,0|2,2,0,0|6,2,2,2|0,6,2,2"]]],
      ["Weighted",false,[[iplateOptions,"weighted"],[icustomGridEnabled,true],
          [igridPositions,"3,4,0,0|2,2,0,5|6,2,2,2|0,6,2,2|0,0,6,10"]]]]
      : []; //
      
//animation = len(options) >= round($t*(len(options))) ? options[round($t*(len(options)))] : options[0];
//echo(time=$t*(len(options)), options = len(options), t=$t, animation=animation);

scenarioDefaults = selectedScenario[0];
animationStep = len(selectedScenario) >= round($t*(len(selectedScenario)-1)) ? selectedScenario[min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1)] : selectedScenario[1];  
currentStepSettings = DictSetRange(defaultDemoSetting, concat(scenarioDefaults[2],animationStep[2]));

echo(defaultDemoSetting=defaultDemoSetting);
echo("🟧gridfinity_baseplate",scenario = scenario, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1));
echo(animationStep=animationStep);
echo(currentStepSettings=currentStepSettings);

if(showtext)
color("GhostWhite")
translate($vpt)
rotate($vpr)
translate([0,-40,60])
 linear_extrude(height = 0.1)
 text(str(scenarioDefaults[0], " - ", animationStep[0]), size=5, valign = "center", halign = "center");

if(scenarioDefaults[0] != "unknown scenario")
rotate(animationStep[1] ? [180,0,0] : [0,0,0]) 
translate(animationStep[1] ? [0,-gf_pitch,0] : [0,0,0])
set_environment(
  width = DictGet(currentStepSettings, iwidth),
  depth = DictGet(currentStepSettings, idepth),
  cut = [DictGet(currentStepSettings, icutx), DictGet(currentStepSettings, icuty), 2])
gridfinity_baseplate(
  num_x = calcDimensionWidth(DictGet(currentStepSettings ,iwidth)),
  num_y = calcDimensionDepth(DictGet(currentStepSettings, idepth)),
  outer_num_x = calcDimensionWidth(DictGet(currentStepSettings, iouter_num_x)),
  outer_num_y = calcDimensionDepth(DictGet(currentStepSettings, iouter_num_y)),
  position_fill_grid_x = DictGet(currentStepSettings, iposition_fill_grid_x),
  position_fill_grid_y = DictGet(currentStepSettings, iposition_fill_grid_y),
  position_grid_in_outer_x = DictGet(currentStepSettings, iposition_grid_in_outer_x),
  position_grid_in_outer_y = DictGet(currentStepSettings, iposition_grid_in_outer_y),
  plate_corner_radius = DictGet(currentStepSettings, iplate_corner_radius),
  magnetSize = DictGet(currentStepSettings, imagnetSize),
  reducedWallHeight = DictGet(currentStepSettings, ireducedWallHeight), 
  cornerScrewEnabled  = DictGet(currentStepSettings, icornerScrewEnabled),
  centerScrewEnabled = DictGet(currentStepSettings, icenterScrewEnabled),
  weightedEnable = DictGet(currentStepSettings, iweightedEnable),
  oversizeMethod = DictGet(currentStepSettings, ioversizeMethod),
  plateOptions = DictGet(currentStepSettings, iplateOptions),
  customGridEnabled = DictGet(currentStepSettings, icustomGridEnabled),
  gridPositions = DictGet(currentStepSettings, icustomGridEnabled) ? splitCustomConfig(DictGet(currentStepSettings, igridPositions)) : [],
  connectorButterflyEnabled  = DictGet(currentStepSettings, iconnectorButterflyEnabled),
  connectorButterflySize = DictGet(currentStepSettings, iconnectorButterflySize),
  connectorButterflyRadius = DictGet(currentStepSettings, iconnectorButterflyRadius),
  connectorFilamentEnabled = DictGet(currentStepSettings, iconnectorFilamentEnabled),
  connectorFilamentDiameter = DictGet(currentStepSettings, iconnectorFilamentDiameter),
  connectorFilamentLength = DictGet(currentStepSettings, iconnectorFilamentLength));
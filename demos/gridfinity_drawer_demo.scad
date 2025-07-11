// include <module_gridfinity_block.scad>
use <../gridfinity_drawers.scad>
include <../modules/functions_general.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "demo"; //[demo,drawer,chest, drawerGridStyle,drawerBase,drawerHandle, chestTop,chestBottom,chestWalls ]
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
iMode = 0;
iDrawerInnerWidth = iMode+1;
iDrawerInnerDepth = iDrawerInnerWidth+1;
iDrawerInnerHeight = iDrawerInnerDepth+1;
iDrawerCount = iDrawerInnerHeight+1;
iDrawerEnableCustomSizes = iDrawerCount+1;
iDrawerCustomSizes = iDrawerEnableCustomSizes+1;
iClearance = iDrawerCustomSizes+1;
iChestWallThickness = iClearance+1;
iChestDrawerSlideThickness = iChestWallThickness+1;
iChestDrawerSlideWidth = iChestDrawerSlideThickness+1; 
iHandleSize = iChestDrawerSlideWidth+1;
iDrawerWallThickness = iHandleSize+1;
iDrawerBase = iDrawerWallThickness+1; 
iDrawerGridStyle = iDrawerBase+1;
iChestEnableTopGrid = iDrawerGridStyle+1;
iChestTopGridStyle = iChestEnableTopGrid+1;
iBottomGrid = iChestTopGridStyle+1;
iBottomMagnetDiameter = iBottomGrid+1; 
iBottomScrewDepth = iBottomMagnetDiameter+1;
iBottomHoleOverhangRemedy = iBottomScrewDepth+1;
iBottomCornerAttachmentsOnly = iBottomHoleOverhangRemedy+1;
iBottomHalfPitch = iBottomCornerAttachmentsOnly+1;
iBottomFlatBase = iBottomHalfPitch+1;
iWallPatternBorderWidth = iBottomFlatBase+1;
iEfficientBack = iWallPatternBorderWidth+1;
iWallPatternEnabled = iEfficientBack+1;
iWallpatternStyle = iWallPatternEnabled+1; 
iWallPatternDividersEnabled = iWallpatternStyle+1; 
iWallPatternHoleSides = iWallPatternDividersEnabled+1;
iWallPatternHoleSize = iWallPatternHoleSides+1;
iWallPatternFill = iWallPatternHoleSize+1; 
iWallPatternVoronoiNoise = iWallPatternFill+1;
iWallPatternVoronoiRadius = iWallPatternVoronoiNoise+1;

/*display settings*/
icutx=iWallPatternVoronoiRadius+1;
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
$vpr = setViewPort ? let(vpr = getcustomVpr(vp)) is_list(vpr) ? vpr : [70,0,320] : $vpr;
//shows translation (i.e. won't be affected by rotate and zoom)
$vpt = setViewPort ? let(vpt = getcustomVpt(vp)) is_list(vpt) ? vpt : [65,20,75] : $vpt; 
//shows the camera distance [Note: Requires version 2015.03]
$vpd = setViewPort ? let(vpd = getcustomVpd(vp)) is_num(vpd) ? vpd : 500 : $vpd;
 //shows the FOV (Field of View) of the view [Note: Requires version 2021.01]
$vpf = setViewPort ? let(vpf = getcustomVpf(vp)) is_num(vpf) ? vpf : 25 : $vpf;

module end_of_customizer_opts() {}

echo("start",vp=vp, vpr = getcustomVpr(vp), vpt = getcustomVpt(vp), vpd = getcustomVpd(vp), vpf = getcustomVpf(vp));

//Basic cup default settings for demo
defaultDemoSetting = 
    //mode, drawerInnerWidth, drawerInnerDepth, drawerInnerHeight, drawerCount, 
    ["everything", 4, 3, 4, 3, 
    //drawerEnableCustomSizes, drawerCustomSizes, clearance, boxWallThickness, 
    false, [1,2,3,4], 0.25, 2,
    //boxDrawerSlideThickness, boxDrawerSlideWidth, handleSize, drawerWallThickness, drawerBase, drawerGridStyle, 
    0, 10, [4, 10, -1, -1], 2, "default", "default",
    //box_enable_top_grid, box_top_grid_style, bottomgrid, magnet_diameter, screw_depth, hole_overhang_remedy, box_corner_attachments_only, half_pitch, flat_base, 
    true, "default", true, 6.5, 6, 2, true, false, false, 
    //wallpattern_border_width, efficientback, wallpattern_enabled, wallpattern_style, wallpattern_dividers_enabled, 
    -1, false, false, "hexgrid", false,
    //wallpattern_hole_sides, wallpattern_hole_size, wallpattern_fill, wallpattern_voronoi_noise, wallpattern_voronoi_radius
     6, 7, "crop", 0.75, 0.5,
    //cutx,cuty,help,translate,rotate,scale,colour
    0, 0,false,[0,0,0],[0,0,0],[0,0,0],[1,1,1],""];

function isMulti(scenario) = search("multi",scenario) == [0, 1, 2, 3, 4];
function iscustomVP(scenarioVp, length = 0) = is_list(scenarioVp) && len(scenarioVp) >= length;
function getcustomVpr(scenarioVp) = iscustomVP(scenarioVp, 1) ? let(vpr = scenarioVp[0]) is_list(vpr) && len(vpr)==3 ? vpr : false : false;
function getcustomVpt(scenarioVp) = iscustomVP(scenarioVp, 2) ? let(vpt = scenarioVp[1]) is_list(vpt) && len(vpt)==3? vpt : false : false;
function getcustomVpd(scenarioVp) = iscustomVP(scenarioVp, 3) ? let(vpd = scenarioVp[2]) is_num(vpd) ? vpd : false : false;
function getcustomVpf(scenarioVp) = iscustomVP(scenarioVp, 4) ? let(vpf = scenarioVp[3]) is_num(vpf) ? vpf : false : false;

function getScenario(scenario) = 
//[0]: seenarioName,scenarioCount,[vpr,vpt,vpd,vpf],[[key,value]]
//[1]: name,[[key,value]]
  scenario == "demo" ? [["chest ",6,[],[]],
      ["4x3", []],
      ["4 drawers", [[iDrawerInnerHeight,3],[iDrawerCount, 4],[iChestEnableTopGrid,false]]],
      ["5x3", [[iDrawerInnerWidth, 5],[iDrawerInnerDepth,3],[iChestTopGridStyle,"magnet"],[iHandleSize, [25, 10, 5, 0]]]],
      ["chest custom", [[iDrawerEnableCustomSizes, true],[iDrawerCustomSizes,[4,4,2,1]],[iHandleSize, [4, 10, -1.5, 3]]]],
      ["hex pattern ", [[iWallPatternEnabled,true], [iEfficientBack,true],[iWallpatternStyle,"hexgrid"],[iChestTopGridStyle,"magnet"]]],
      ["veroni hex grid", [[iWallPatternEnabled,true],[iEfficientBack,true], [iWallpatternStyle,"voronoihexgrid"],[iDrawerEnableCustomSizes, true],[iDrawerCustomSizes,[5,4,2]],[iHandleSize, [4, 10, -1.5, -1]]]]
      ]//endscenario

  : scenario == "drawerGridStyle" ? [["Drawer Grid Style",2,[],[[iMode,"onedrawer"]]],
      ["default", [[iDrawerGridStyle, "default"]]],
      ["magnet", [[iDrawerGridStyle, "magnet"]]]]//endscenario
      
  : scenario == "drawerBase" ? [["drawer base",3,[],[[iMode,"onedrawer"]]],
      ["grid and floor", [[iDrawerBase, "default"]]],
      ["grid", [[iDrawerBase, "grid"]]],
      ["floor", [[iDrawerBase, "floor"]]]]//endscenario

    : scenario == "drawerHandle" ? [["Drawer handle",7,[],[[iMode,"onedrawer"]]],
      ["default", []],
      ["radius 2", [[iHandleSize, [4, 10, -1, 2]]]],
      ["radius 20", [[iHandleSize, [4, 10, -1, 20]]]],
      ["height 10", [[iHandleSize, [4, 10, 10, -1]]]],
      ["width 10", [[iHandleSize, [10, 10, -1, -1]]]],
      ["depth 20", [[iHandleSize, [4, 20, -1, -1]]]],
      ["horizontal", [[iHandleSize, [25, 10, 5, 0]]]]]//endscenario
   
  : scenario == "drawer" ? [["drawer",3,[],[[iMode,"onedrawer"]]],
      ["4x3", []],
      ["4x3", [[iDrawerInnerHeight,5]]],
      ["5x3", [[iDrawerInnerWidth, 5],[iDrawerInnerDepth,3]]]]//endscenario   
      
  : scenario == "chest" ? [["chest",4,[],[[iMode,"chest"]]],
      ["4x3", []],
      ["4 drawers", [[iDrawerInnerHeight,3],[iDrawerCount, 4]]],
      ["5x3", [[iDrawerInnerWidth, 5],[iDrawerInnerDepth,3]]],
      ["chest custom", [[iDrawerEnableCustomSizes, true],[iDrawerCustomSizes,[4,4,2,1]]]]]//endscenario

  : scenario == "chestTop" ? [["chest top",3,[],[[iMode,"chest"]]],
      ["off", [[iChestEnableTopGrid,false]]],
      ["chest", [[iChestEnableTopGrid,true],[iChestTopGridStyle,"default"]]],
      ["chest", [[iChestEnableTopGrid,true],[iChestTopGridStyle,"magnet"]]]]//endscenario

  : scenario == "chestBottom" ? [["chest bottom",6,[],[[itranslate,[0,-150,-100]],[irotate,[180,0,0]],[iMode,"chest"]]],
      ["off", [[iBottomGrid,false]]],
      ["on", [[iBottomGrid,true], [iBottomCornerAttachmentsOnly, false]]],
      ["corner Corner Attachments Only", [[iBottomGrid,true]]],
      ["base attachment off", [[iBottomGrid,true],[iBottomMagnetDiameter,0],[iBottomScrewDepth,0]]],
      ["base half pitch", [[iBottomGrid,true],[iBottomHalfPitch,true]]],
      ["base falt base", [[iBottomGrid,true],[iBottomFlatBase,true]]]
      ]//endscenario
      
      //["grid", "hexgrid", "voronoi","voronoigrid","voronoihexgrid"]
  : scenario == "chestWalls" ? [["walls",7,[[85,0,340],],[[iMode,"chest"]]],
      ["default", [[iEfficientBack,false]]],
      ["Efficient Back on", [[iEfficientBack,true]]],
      ["Border Width = 5", [[iEfficientBack,true],[iWallPatternBorderWidth,5]]],
      ["hex pattern ", [[iWallPatternEnabled,true], [iWallpatternStyle,"hexgrid"]]],
      ["veroni hex grid", [[iWallPatternEnabled,true], [iWallpatternStyle,"voronoihexgrid"]]],
      ["veroni chaos", [[iWallPatternEnabled,true], [iWallpatternStyle,"voronoi"]]],
      ["patern with Efficient Back", [[iEfficientBack,true],[iWallPatternEnabled,true], [iWallpatternStyle,"voronoihexgrid"]]],
    ]  //endscenario

      
      /*
      
      iWallPatternBorderWidth = iBottomFlatBase+1;
iEfficientBack = iWallPatternBorderWidth+1;
iWallPatternEnabled = iEfficientBack+1;
iWallpatternStyle = iWallPatternEnabled+1; 
iWallPatternDividersEnabled = iWallpatternStyle+1; 
iWallPatternHoleSides = iWallPatternDividersEnabled+1;
iWallPatternHoleSize = iWallPatternHoleSides+1;
iWallPatternFill = iWallPatternHoleSize+1; 
iWallPatternVoronoiNoise = iWallPatternFill+1;
iWallPatternVoronoiRadius = iWallPatternVoronoiNoise+1;

      */
      
   : assert(false, "unknown scenario");

module RenderScenario(scenario, showtext=true, height=height, stepIndex=-1, multiStepOverrides = []){
  selectedScenario = getScenario(scenario);
  scenarioDefaults = selectedScenario[0];
  stepIndex = stepIndex > -1 ? stepIndex+1 : min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1);
  animationStep = (len(selectedScenario) >= stepIndex ? selectedScenario[stepIndex] : selectedScenario[1]);  
  currentStepSettings = replace_Items(concat(concat(scenarioDefaults[iscenariokv],animationStep[istepkv]), multiStepOverrides), defaultDemoSetting);
  echo("🟧RenderScenario",scenario = scenario, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1), animationStep=animationStep, currentStepSettings=currentStepSettings);

  
  if(!isMulti(scenario) && len(selectedScenario)-1 != selectedScenario[0][1]){
    echo("🟥RenderScenario - warning steps is not correct, update for PS script to function",scenarioStepsConfig = selectedScenario[0][1], steps=len(selectedScenario)-1);
  }
  if(showtext && $preview)
  color("DimGray")
  translate($vpt)
  rotate($vpr)
  translate([0,-85,80])
   linear_extrude(height = 0.1)
   text(str(scenarioDefaults[iscenarioName], " - ", animationStep[istepName]), size=5,halign="center");

  if(scenarioDefaults[iscenarioName] != "unknown scenario")
    rotate(currentStepSettings[irotate]) 
    translate(currentStepSettings[itranslate])
    gridfinity_drawer(
      //itemholder settings
      mode = currentStepSettings[iMode],
      drawerInnerWidth = currentStepSettings[iDrawerInnerWidth],
      drawerInnerDepth = currentStepSettings[iDrawerInnerDepth],
      drawerInnerHeight = currentStepSettings[iDrawerInnerHeight],
      drawerCount = currentStepSettings[iDrawerCount],
      drawerEnableCustomSizes = currentStepSettings[iDrawerEnableCustomSizes],
      drawerCustomSizes = currentStepSettings[iDrawerCustomSizes],
      clearance = currentStepSettings[iClearance],
      chestWallThickness = currentStepSettings[iChestWallThickness],
      chestDrawerSlideThickness = currentStepSettings[iChestDrawerSlideThickness],
      chestDrawerSlideWidth = currentStepSettings[iChestDrawerSlideWidth],
      handleSize = currentStepSettings[iHandleSize],
      drawerWallThickness = currentStepSettings[iDrawerWallThickness],
      drawerBase = currentStepSettings[iDrawerBase],
      drawerGridStyle = currentStepSettings[iDrawerGridStyle],
      chestEnableTopGrid = currentStepSettings[iChestEnableTopGrid],
      chestTopGridStyle = currentStepSettings[iChestTopGridStyle],
      bottomGrid = currentStepSettings[iBottomGrid],
      bottomMagnetDiameter = currentStepSettings[iBottomMagnetDiameter],
      bottomScrewDepth = currentStepSettings[iBottomScrewDepth],
      bottomHoleOverhangRemedy = currentStepSettings[iBottomHoleOverhangRemedy],
      bottomCornerAttachmentsOnly = currentStepSettings[iBottomCornerAttachmentsOnly],
      bottomHalfPitch = currentStepSettings[iBottomHalfPitch],
      bottomFlatBase = currentStepSettings[iBottomFlatBase],
      wallPatternBorderWidth = currentStepSettings[iWallPatternBorderWidth],
      efficientBack = currentStepSettings[iEfficientBack],
      wallPatternEnabled = currentStepSettings[iWallPatternEnabled],
      wallpatternStyle = currentStepSettings[iWallpatternStyle],
      wallPatternDividersEnabled = currentStepSettings[iWallPatternDividersEnabled],
      wallPatternHoleSides = currentStepSettings[iWallPatternHoleSides],
      wallPatternHoleSize = currentStepSettings[iWallPatternHoleSize],
      wallPatternFill = currentStepSettings[iWallPatternFill],
      wallPatternVoronoiNoise = currentStepSettings[iWallPatternVoronoiNoise],
      wallPatternVoronoiRadius = currentStepSettings[iWallPatternVoronoiRadius]
  );
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
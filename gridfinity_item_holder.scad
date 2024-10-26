include <modules/module_item_holder.scad>
include <modules/module_item_holder_data.scad>
include <modules/gridfinity_constants.scad>
include <modules/functions_general.scad>
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity.scad>

/*<!!start gridfinity_itemholder!!>*/
/* [Item Holder] */
itemholder_known_tools = "1/4hexshank"; // [ "custom":Custome, "4hexshank":4mm Hex Shank, "1/4hexshank":1/4 Hex Shank, "1/4hexshanklong":1/4 Hex Long Shank, "5/16hexshank":5/16 Hex Shank, "3/8hexshank":3/8 Hex Shank, "1/2shank":1/2 inch router bit, "12shank":12mm router bit, "10shank":10mm router bit, "3/8shank":3/8 inch router bit, "8shank":8mm router bit, "1/4shank":1/4 inch router bit, "6shank":6mm router bit, "1/8shank":1/8 inch Dremel router bit]
itemholder_known_batteries = "custom"; // [ "custom":Custome, "aaaa":AAAA cell, "aaa":AAA cell, "aa":AA cell, "9v":9v, "c":C cell, "d":d cell, "7540":7540 cell, "8570":8570 cell, "10180":10180 cell, "10280":10280 cell, "10440":10440 cell, "10850":10850 cell, "13400":13400 cell, "14250":14250 cell, "14300":14300 cell, "14430":14430 cell, "14500":14500 cell, "14650":14650 cell, "15270":15270 cell, "16340":16340 cell, "16650":16650 cell, "17500":17500 cell, "17650":17650 cell, "17670":17670 cell, "18350":18350 cell, "18490":18490 cell, "18500":18500 cell, "18650":18650 cell, "20700":20700 cell, "21700":21700 cell, "25500":25500 cell, "26500":26500 cell, "26650":26650 cell, "26700":26700 cell, "26800":26800 cell, "32600":32600 cell, "32650":32650 cell, "32700":32700 cell, "38120":38120 cell, "38140":38140 cell, "40152":40152 cell, "4680":4680 cell]
itemholder_known_cell_batteries = "custom"; // [ "custom":Custome, "cr927":CR927 cell, "cr1025":CR1025 cell, "cr1130":CR1130 cell, "cr1216":CR1216 cell, "cr1220":CR1220 cell, "cr1225":CR1225 cell, "cr1616":CR1616 cell, "cr1620":CR1620 cell, "cr1632":CR1632 cell, "cr2012":CR2012 cell, "cr2016":CR2016 cell, "cr2020":CR2020 cell, "cr2025":CR2025 cell, "cr2032":CR2032 cell, "cr2040":CR2040 cell, "cr2050":CR2050 cell, "cr2320":CR2320 cell, "cr2325":CR2325 cell, "cr2330":CR2330 cell, "br2335":BR2335 cell, "cr2354":CR2354 cell, "cr2412":CR2412 cell, "cr2430":CR2430 cell, "cr2450":CR2450 cell, "cr2477":CR2477 cell, "cr3032":CR3032 cell, "cr11108":CR11108 cell]
itemholder_known_cards = "custom"; // [ "custom":Custome, "multicard":Multi card slot, "compactflashi":CompactFlash. Type I, "compactflashii":CompactFlash. Type II, "smartmedia":SmartMedia, "mmc":MMC. MMCplus, "mmcmobile":RS-MMC. MMCmobile, "mmcmicro":MMCmicro, "sd":SD. SDHC. SDXC. SDIO. MicroP2, "minisd":miniSD. miniSDHC. miniSDIO, "microsd":microSD. microSDHC. microSDXC, "memorystickstandard":Memory Stick Standard. PRO, "memorystickduo":Memory Stick Duo. PRO Duo. PRO-HG. XC, "memorystickmicro":Memory Stick Micro (M2). XC, "nano":Nano Memory, "psvita":PS Vita Memory Card, "xqd":XQD card, "xD":xD, "usba":USB A, "usbc":USB C]
itemholder_known_cartridges = "custom"; // [ "custom":Custome, "atari800":Atari 800, "atari2600":Atari 2600/7800/Colecovision, "atari5200":Atari 5200, "atari7800":Atari 7800, "commodore":Commodore Vic20, "magnavoxodyssey":Magnavox Odyssey, "magnavoxodysseymulticard":Magnavox Odyssey (multicard), "magnavoxodyssey2":Magnavox Odyssey2, "mattelintellivision":Mattel Intellivision I & II, "nintendofamicom":Nintendo Famicom, "nintendofamicomdisk":Nintendo Famicom Disk, "nintendosuperfamicom":Nintendo Super Famicom / SNES (Pal), "nes":NES, "snes":SNES, "nintendo64":Nintendo 64, "nintendogb":Nintendo GB, "nintendogbc":Nintendo GBC, "nintendogba":Nintendo GBA, "nintendods":Nintendo DS, "nintendo2ds":Nintendo 2DS/3DS, "nintendovb":Nintendo Virtual Boy, "nintendoswitch":Nintendo Switch, "segagamegear":Sega Game Gear, "segagenesis":Sega Genesis, "segagenesistall":Sega Genesis (tall cart), "segamegadrive":Sega MegaDrive, "segamegadrivecodemasters":Sega MegaDrive Codemasters, "segamastersystem":Sega Master System, "sega32x":Sega 32x, "segacard":Sega Card/TG16, "segapico":Sega Pico, "sonyumd":Sony UMD, "sonypsvita":Sony PS Vita, "sonypsvitamemcard":Sony PS Vita (Mem Card), "necpcehucard":NEC PCE HuCard, "snkneogeoaes":SNK Neo Geo AES, "snkneogeomvs":SNK Neo Geo MVS, "bandai":Bandai Wonderswan/Color, "msx":MSX]
// Enlarge the holes by this amount for clearance
itemholder_hole_clearance = 0.25;
// Depth of hole, Overrides the know item depth. Limited by floor height
itemholder_hole_depth = 0; //0.1
// 45 deg chamfer added to the top of the hole (mm)
itemholder_hole_chamfer = 1; //0.5

/* [Item Holder - Sample Item] */
//Render just a sample of the item hole, to be used as a test print
itemholder_enable_sample = false;
//Wall thickness of the sample print
itemholder_sample_wall_thickness = 3;

/* [Item Holder - Multi Card] */
// cards to use when multi card is selected I.E. sd;USBA;microsd
itemholder_multi_cards = "sd,usba,microsd";
// Force nesting of multi cards, This has an issue where the last item could be cropped.
itemholder_multi_card_compact = 0.7; // [0:0.1:1]

/* [Item Holder - Custom Item] */
// Should the grid be square or hex
itemholder_hole_base_shape = "round"; //["round","square","halfround","multicard","custom":custom shape - beta feature]
// The number of sides for a round hole
itemholder_hole_sides = 4; 
// Diameter of the round hole
itemholder_hole_diameter = 5; //0.1
// The size the hole
itemholder_hole_size = [20, 25]; //0.1

/* [Item Holder - Item Layout] */
// Should the grid be square or hex
itemholder_grid_style = "auto"; //["square","hex","auto"]
//Spacing around the holes
itemholder_hole_spacing = 2; //0.1
// Number of holes in the x and y dimension, 0 is dynamic
itemholder_hole_gridx = 0; //1
// Number of holes in the y dimension, 0 is dynamic, y.5, is only valid for hex.
itemholder_hole_gridy = 0; //0.5
//Auto set the bin height based on the hole size.
itemholder_auto_bin_height = true;
itemholder_compartments = [1,1]; //[1:10]
// Spacing around the compartments
itemholder_compartment_spacing = 3; //0.1
// Center the holes within the compartments
itemholder_compartment_centered = true;
itemholder_compartment_fill = "none"; //["none", "space", "crop"]

/*
xpos,ypos,xsize,ysize,radius,depth. 
dimensions of the tray cutout, a string with comma separated values, and pipe (|) separated trays.
 - xpos, ypos, the x/y position in gridfinity units.
 - xsize, ysize. the x/y size in gridfinity units. 
 - radius, [optional] corner radius in mm.
 - depth, [optional] depth in mm
 - example "0,0,2,1|2,0,2,1,2,5"
*/
//[[xpos,ypos,xsize,ysize,radius,depth]]. xpos, ypos, the x/y position in gridfinity units.xsize, ysize. the x/y size in gridfinity units. radius, [optional] corner radius in mm.depth, [optional] depth in mm\nexample "0,0,2,1|2,0,2,1,2,5"
itemholder_customcompartments = "";


/*<!!end gridfinity_itemholder!!>*/

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.5
// Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.5
// Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [3, 0]; //0.1
// Fill in solid block (overrides all following options)
filled_in = false; 
// Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
// Remove some or all of lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
position = "center"; //[default,center,zero]
//under size the bin top by this amount to allow for better stacking
zClearance = 0; // 0.1

/* [Subdivisions] */
chamber_wall_thickness = 1.2;
// X dimension subdivisions
vertical_chambers = 1;
vertical_separator_bend_position = 0;
vertical_separator_bend_angle = 0;
vertical_separator_bend_separation = 0;
vertical_separator_cut_depth=0;
horizontal_chambers = 1;
horizontal_separator_bend_position = 0;
horizontal_separator_bend_angle = 0;
horizontal_separator_bend_separation = 0;
horizontal_separator_cut_depth=0;
// Enable irregular subdivisions
vertical_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
vertical_separator_config = "10.5|21|42|50|60";
// Enable irregular subdivisions
horizontal_irregular_subdivisions = false;
// Separator positions are defined in terms of grid units from the left end
horizontal_separator_config = "10.5|21|42|50|60";
      
/* [Base] */
// (Zack's design uses magnet diameter of 6.5)
magnet_diameter = 0;  // .1
// Create relief for magnet removal 
magnet_easy_release = true;
// (Zack's design uses depth of 6)
screw_depth = 0;
center_magnet_diameter =0;
center_magnet_thickness = 0;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
// Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = true;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth] 
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = false;
// Remove floor to create a vertical spacer
spacer = false;

/* [Label] */
label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels]
// Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropiate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]

/* [Finger Slide] */
// Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// Radius of the corner fillet
fingerslide_radius = 8;

/* [Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [Wall Pattern] */
// Grid wall patter
wallpattern_enabled=false;
// Style of the pattern
wallpattern_style = "grid"; //[grid, hexgrid, voronoi,voronoigrid,voronoihexgrid]
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1]; 
// Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both] 
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = 10; //0.1
// pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
wallpattern_voronoi_noise = 0.75;
wallpattern_voronoi_radius = 0.5;

/* [Wall Cutout] */
wallcutout_vertical ="disabled"; //[disabled, enabled, wallsonly, frontonly, backonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=-2;  //0.1
//default will be binwidth/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
//default will be binHeight
wallcutout_vertical_height=0;
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, wallsonly, leftonly, rightonly]
// wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=-2;  //0.1
//default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
//default will be binHeight
wallcutout_horizontal_height=0;
wallcutout_horizontal_corner_radius=5;

/* [Extendable] */
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5; 
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5; 
extension_tabs_enabled = true;
//Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];
    
/* [debug] */
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// enable loging of help messages during render.
enable_help = false;
/*<!!end gridfinity_basic_cup!!>*/

/* [Hidden] */
module end_of_customizer_opts() {}

//Function for creating a custom shape.
//To use this feature you need to define the require shape in the module below.
//Then configure the options in the customiser, is the item is space approabiatly.
module mycustomshape(){ 
  //Example custom shape
  //settings needed
  //item hole depth 30
  //item hole size 20,25
  //item grid style square
  //item spacing 4
  translate([4,0,0])
  union(){
    chamferedSquare(size=[9.9,25.3,30], chamfer = 1, cornerRadius = 1);
    translate([-2.1,7.55,0])
    chamferedSquare(size=[3,10,30], chamfer = 1, cornerRadius = 1);
  }
  
  //You can use any shapes but these are some example shapes
  //chamferedSquare(size=[10,10,10], chamfer = 1, cornerRadius = 1);
  //chamferedRectangleTop(size=[10,10,10], chamfer = 1, cornerRadius = 1);
  //chamferedHalfCylinder(h=10, r=5, circleFn=64, chamfer=0.5);
  //chamferedCylinder(h=10, r=5, circleFn=64, chamfer=0.5);
}

function LookupKnown(knowItemCode, customDiameter = [0,0], customSize=0, customDepth=0, customShape="square") = let(
      knownCard = LookupKnownCard(knowItemCode),
      knownCartridge = LookupKnownCartridge(knowItemCode),
      knownTool = LookupKnownTool(knowItemCode),
      knownBattery = LookupKnownBattery(knowItemCode),
      knownCellBattery = LookupKnownCellBattery(knowItemCode)
    ) knownCard[ishape] != "" ? knownCard 
      : knownCartridge[ishape] != "" ? knownCartridge
      : knownBattery[ishape] != "" ? knownBattery
      : knownCellBattery[ishape] != "" ? knownCellBattery
      : knownTool[ishape] != "" ? knownTool
      : [customDiameter, customSize.x, customSize.y, customDepth, 0, customShape];
      
function addClearance(dim, clearance) =
    [dim[iitemDiameter] > 0 ? dim[iitemDiameter]+clearance : 0
    ,dim[iitemx] > 0 ? dim[iitemx]+clearance : 0
    ,dim[iitemy] > 0 ? dim[iitemy]+clearance : 0
    ,dim[idepthneeded]];

icSides = 0;
icHoleSize = 1;
icMcLongCenterItem = 2;
icMcShortCenterItem = 3;
icMcSideItem = 4;
icMcCompact = 5;

function multiCardCalculations(
  multiCards = "sd,usba,microsd", 
  multiCardCompact = 0,
  holeClearance = 0
) = let(
      mc = split(multiCards, ","),
      longCenterItem = addClearance(LookupKnown(mc[0]), holeClearance),
      shortCenterItem = addClearance(LookupKnown(mc[1]), holeClearance),
      sideItem = addClearance(LookupKnown(mc[2]), holeClearance),
      multiCardCompact = multiCardCompact > 0 ? sideItem[iitemx] * (1 - min(multiCardCompact/2 + 0.5 ,1)) : 0,
      _sides = LookupKnownShapes("multicard"),
      _holeSize = [
        max(longCenterItem[iitemx],shortCenterItem[iitemx]), 
        max(longCenterItem[iitemy], shortCenterItem[iitemy], sideItem[iitemx] - multiCardCompact), 
        max(longCenterItem[idepthneeded], shortCenterItem[idepthneeded], sideItem[idepthneeded])]
    ) [_sides,
      _holeSize,
      longCenterItem,
      shortCenterItem,
      sideItem,
      multiCardCompact];

function itemCalculations(
  item,
  sides,
  holeDepth,
  holeClearance
  ) = let(
    _sides = LookupKnownShapes(item[ishape], sides),
    _depthTemp = holeDepth > 0 ? holeDepth : item[idepthneeded],
    _depth = _depthTemp <= 0 ? 5 : _depthTemp,
    _holeSize = 
      item[ishape] == "round"  || item[ishape] == "hex"
        ? [item[iitemDiameter]+holeClearance, 0, _depth]
      : item[ishape] == "halfround" 
        ? [item[iitemx]+holeClearance, item[iitemy]+holeClearance, item[iitemx]/2]
      : [item[iitemx]+holeClearance,item[iitemy]+holeClearance,_depth]
  ) [_sides,
      _holeSize,
      [],[],[],0];   
    
////////

//TODO for the hose size its not correct due to loss in the number of faces.
//E.G a 10mm circle cant contain a 10mm hex
//This also throws off the calculated spacing.
module itemholder(
  num_x = 1,
  num_y = 2,
  num_z, 
  knowItemCode = "custom",
  customHoleBaseShape = "square",
  multiCards = "sd,usba,microsd",
  multiCardCompact = 0,
  gridStyle = "auto",
  sides = 4,
  holeSize = [10,10],
  holeDiameter = 10,
  holeDepth = 5, 
  holeChamfer = 1,
  holeClearance = 0.2,
  holeSpacing = 0,
  holeGrid  = [0,0],
  floorThickness,
  wallThickness,
  compartments = [1,1],
  compartment_spacing,
  compartment_centered = true,
  compartment_fill = "none",
  customcompartments = "",
  help = false)
{
  //Non custom components
  item = LookupKnown(
    knowItemCode=knowItemCode,
    customDiameter=holeDiameter, 
    customSize=holeSize, 
    customDepth=holeDepth, 
    customShape=customHoleBaseShape);
  
  itemCalc = item[ishape] == "multicard"
      ? multiCardCalculations(
          multiCards = multiCards, 
          multiCardCompact = multiCardCompact,
          holeClearance = holeClearance)
      : itemCalculations(
          item = item,
          sides = sides,
          holeDepth = holeDepth,
          holeClearance=holeClearance);
          
  gridStyle = item[ishape] == "multicard" || item[ishape] == "square" || item[ishape] == "halfround" 
    ? "square" : gridStyle;  
  
  _sides = itemCalc[icSides];
  _holeSize = itemCalc[icHoleSize];
  _multiCardCompact = itemCalc[icMcCompact];
  _depth = min(itemCalc[icHoleSize].z, floorThickness);
  
  xSize = (num_x*gf_pitch-(compartments.x+1)*compartment_spacing)/compartments.x;
  xStep = xSize + compartment_spacing;
  ySize = (num_y*gf_pitch-(compartments.y+1)*compartment_spacing)/compartments.y - _multiCardCompact;
  yStep = ySize + compartment_spacing;
  
  if(IsHelpEnabled("info")) echo("itemholder", item=item, multiCards=multiCards,longCenter=itemCalc[icMcLongCenterItem],smallCenter=itemCalc[icMcShortCenterItem],side=itemCalc[icMcSideItem], _multiCardCompact=_multiCardCompact, _sides=_sides, _holeSize=_holeSize,_depth=_depth);
  if(IsHelpEnabled("info")) echo("itemholder", xSize=xSize, xStep=xStep, ySize=ySize, yStep=yStep);
  
  for(x =[0:1:compartments.x-1])
  { 
    for(y =[0:1:compartments.y-1])
    {
      translate(compartment_centered 
        ? [compartment_spacing+x*xStep+xSize/2, compartment_spacing+y*yStep+ySize/2, floorThickness-_depth]
        : [compartment_spacing+x*xStep, compartment_spacing+y*yStep, floorThickness-_depth])
        GridItemHolder(
          canvasSize = [xSize,ySize],
          hexGrid= gridStyle == "square" ? false : gridStyle == "hex" ? true : gridStyle,
          customShape = item[ishape] != "round" && item[ishape] != "hex",
          circleFn = _sides,
          holeSize = _holeSize,
          holeSpacing = [holeSpacing,holeSpacing],
          holeGrid = holeGrid,
          holeHeight = _depth+fudgeFactor,
          holeChamfer = holeChamfer,
          center=compartment_centered,
          fill=compartment_fill,
          help=help)
            if(item[ishape]=="multicard")
            {
              multiCard(
                itemCalc[icMcLongCenterItem], itemCalc[icMcShortCenterItem], itemCalc[icMcSideItem], 
                chamfer = holeChamfer,
                alternate = _multiCardCompact > 0 && (($idx.y % 2) != $idx.x % 2));
            } else if(item[ishape] == "square") {
              chamferedSquare(
                size = [_holeSize.x, _holeSize.y, _depth+fudgeFactor], 
                chamfer=holeChamfer, 
                cornerRadius=item[iitemDiameter]/2, $fn=64);
            } else if(item[ishape] == "halfround") {
              translate([_holeSize.x/2,_holeSize.y/2,0])
                chamferedHalfCylinder(
                  r=item[iitemx]/2, 
                  h=item[iitemy], 
                  chamfer=holeChamfer, $fn=64);
          } else if(item[ishape]=="custom") {
            mycustomshape();
          }
    }
  }
  
  HelpTxt("itemholder",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"knowItemCode",knowItemCode
    ,"gridStyle",gridStyle
    ,"sides",sides
    ,"holeSize",holeSize
    ,"holeClearance",holeClearance
    ,"holeSpacing",holeSpacing
    ,"holeGrid",holeGrid
    ,"holeChamfer",holeChamfer
    ,"floorThickness",floorThickness
    ,"wallThickness",wallThickness
    ,"compartments",compartments
    ,"compartment_spacing",compartment_spacing
    ,"compartment_fill",compartment_fill
    ,"customcompartments",customcompartments
    ,"floorThickness",floorThickness

    ,"xSize",xSize
    ,"xStep",xStep
    ,"ySize",ySize
    ,"yStep",yStep
    ,"_sides",_sides
    ,"_holeSize",_holeSize
    ,"_depth",_depth]
    ,help);
}

module samplesholder(
  knowItemCode = "custom",
  customHoleBaseShape,
  holeDiameter,
  multiCards = "sd,USBA,microsd",
  multiCardCompact = 0,
  sides = 4,
  holeSize = [10,10],
  holeDepth = 5, 
  holeChamfer = 1,
  holeClearance = 0.2,
  wallThickness,
  help = false)
{
  floorThickness=wallThickness;
  
  //Non custom components
  item = LookupKnown(
    knowItemCode=knowItemCode,
    customDiameter=holeDiameter, 
    customSize=holeSize, 
    customDepth=holeDepth, 
    customShape=customHoleBaseShape);
  mc = split(multiCards, ",");
  
  itemCalc = item[ishape] == "multicard"
      ? multiCardCalculations(
          multiCards = multiCards, 
          multiCardCompact = multiCardCompact,
          holeClearance = holeClearance)
      : itemCalculations(
          item = item,
          sides = sides,
          holeDepth = holeDepth,
          holeClearance=holeClearance);
      
    _sides = itemCalc[icSides];
    _holeSize = itemCalc[icHoleSize];
    _depth = itemCalc[icHoleSize].z;
    Rc = itemCalc[icSides]<=2 || itemCalc[icSides]>16 ? _holeSize[0]/2 : (_holeSize[0]/2)/cos(180/itemCalc[icSides]);

  if(IsHelpEnabled("info")) echo("itemholder", knowItemCode=knowItemCode, holeDepth=holeDepth, item=item, itemCalc=itemCalc, mc=mc,longCenter=itemCalc[icMcLongCenterItem],smallCenter=itemCalc[icMcShortCenterItem],side=itemCalc[icMcSideItem], _sides=_sides, _holeSize=_holeSize,_depth=_depth, Rc=Rc, Dc=Rc*2);

  if(knowItemCode=="multicard")
  {
    difference(){
      translate([-_holeSize.x/2-wallThickness,-_holeSize.y/2-wallThickness,-wallThickness-fudgeFactor])
        cube(size=[_holeSize.x+wallThickness*2,_holeSize.y+wallThickness*2, _depth+fudgeFactor+wallThickness]);
      translate([-_holeSize.x/2,-_holeSize.y/2-holeChamfer,0])
        multiCard(
          itemCalc[icMcLongCenterItem], itemCalc[icMcShortCenterItem], itemCalc[icMcSideItem], 
          chamfer = holeChamfer,
          alternate =false);
      }
  } else if(item[ishape] == "square") {
    difference(){
      translate([-_holeSize.x/2-wallThickness,-_holeSize.y/2-wallThickness,-wallThickness-fudgeFactor])
        cube(size=[_holeSize.x+wallThickness*2,_holeSize.y+wallThickness*2, _depth+fudgeFactor+wallThickness]);
      translate([-_holeSize.x/2,-_holeSize.y/2,0])
        chamferedSquare([_holeSize.x, _holeSize.y, _depth+fudgeFactor], chamfer=holeChamfer, cornerRadius=item[iitemDiameter]/2, $fn=64);
    }
  } else if(item[ishape] == "halfround") {
    difference(){
      translate([-_holeSize.x/2-wallThickness,-_holeSize.y/2-wallThickness,-wallThickness-fudgeFactor])
        cube(size=[_holeSize.x+wallThickness*2,_holeSize.y+wallThickness*2, _depth+fudgeFactor+wallThickness]);

      chamferedHalfCylinder(r=item[iitemx]/2, h=item[iitemy], chamfer=holeChamfer, $fn=64);
    }
  } else {
    difference(){
      translate([0,0,-wallThickness-fudgeFactor])
        cylinder(h=_depth+fudgeFactor+wallThickness, r=Rc+wallThickness, $fn=64);
      chamferedCylinder(h=_depth+fudgeFactor, r=Rc, chamfer=holeChamfer, circleFn = _sides);
    }
  }
  
  HelpTxt("sampleholder",[
    "knowItemCode",knowItemCode
    ,"multiCards",multiCards
    ,"multiCardCompact",multiCardCompact
    ,"sides",sides
    ,"holeSize",holeSize
    ,"holeDepth",holeDepth
    ,"holeChamfer",holeChamfer
    ,"holeClearance",holeClearance
    ,"wallThickness",wallThickness
    ,"_sides",_sides
    ,"_holeSize",_holeSize
    ,"_depth",_depth
    ,"Rc", Rc]
    ,help);
}


// Generates the gridfinity bin with cutouts.
// Runs the function without needing to pass the variables.
module gridfinity_itemholder(
  //itemholder settings
  itemholder_enable_sample = itemholder_enable_sample,
  itemholder_sample_wall_thickness = itemholder_sample_wall_thickness,
  itemholder_hole_base_shape = itemholder_hole_base_shape,
  itemholder_hole_diameter = itemholder_hole_diameter,
  itemholder_grid_style = itemholder_grid_style,
  itemholder_hole_sides = itemholder_hole_sides,
  itemholder_hole_size = itemholder_hole_size,
  itemholder_hole_spacing = itemholder_hole_spacing,
  itemholder_hole_grid = [itemholder_hole_gridx, itemholder_hole_gridy],
  itemholder_hole_clearance = itemholder_hole_clearance,
  itemholder_hole_depth = itemholder_hole_depth,
  itemholder_hole_chamfer = itemholder_hole_chamfer,
  itemholder_compartments = itemholder_compartments,
  itemholder_compartment_spacing = itemholder_compartment_spacing,
  itemholder_compartment_centered = itemholder_compartment_centered,
  itemholder_compartment_fill  = itemholder_compartment_fill,
  itemholder_customcompartments = itemholder_customcompartments,
  itemholder_auto_bin_height = itemholder_auto_bin_height,
  itemholder_multi_cards = itemholder_multi_cards,
  itemholder_multi_card_compact = itemholder_multi_card_compact,
  itemholder_known_item = 
        itemholder_known_tools != "custom" ? itemholder_known_tools  
      : itemholder_known_batteries != "custom"? itemholder_known_batteries
      : itemholder_known_cell_batteries != "custom"? itemholder_known_cell_batteries
      : itemholder_known_cards != "custom"? itemholder_known_cards
      : itemholder_known_cartridges, 
      
  //gridfinity settings
  width=width, depth=depth, height=height,
  position=position,
  filled_in=filled_in,
  label_settings=LabelSettings(
    labelStyle=label_style, 
    labelPosition=label_position, 
    labelSize=label_size,
    labelRelief=label_relief,
    labelWalls=label_walls),
  fingerslide=fingerslide,
  fingerslide_radius=fingerslide_radius,
  magnet_diameter=magnet_diameter,
  magnet_easy_release=magnet_easy_release,
  screw_depth=screw_depth,
  center_magnet_diameter=center_magnet_diameter,
  center_magnet_thickness=center_magnet_thickness,
  floor_thickness=floor_thickness,
  cavity_floor_radius=cavity_floor_radius,
  wall_thickness=wall_thickness,
  hole_overhang_remedy=hole_overhang_remedy,
  efficient_floor=efficient_floor,
  chamber_wall_thickness=chamber_wall_thickness,
  vertical_chambers = vertical_chambers,
  vertical_separator_bend_position=vertical_separator_bend_position,
  vertical_separator_bend_angle=vertical_separator_bend_angle,
  vertical_separator_bend_separation=vertical_separator_bend_separation,
  vertical_separator_cut_depth=vertical_separator_cut_depth,
  vertical_irregular_subdivisions=vertical_irregular_subdivisions,
  vertical_separator_config=vertical_separator_config,
  horizontal_chambers=horizontal_chambers,
  horizontal_separator_bend_position=horizontal_separator_bend_position,
  horizontal_separator_bend_angle=horizontal_separator_bend_angle,
  horizontal_separator_bend_separation=horizontal_separator_bend_separation,
  horizontal_separator_cut_depth=horizontal_separator_cut_depth,
  horizontal_irregular_subdivisions=horizontal_irregular_subdivisions,
  horizontal_separator_config=horizontal_separator_config, 
  half_pitch=half_pitch,
  lip_style=lip_style,
  zClearance=zClearance,
  box_corner_attachments_only=box_corner_attachments_only,
  flat_base = flat_base,
  spacer=spacer,
  tapered_corner=tapered_corner,
  tapered_corner_size = tapered_corner_size,
  tapered_setback = tapered_setback,
  wallpattern_enabled=wallpattern_enabled,
  wallpattern_style=wallpattern_style,
  wallpattern_walls=wallpattern_walls, 
  wallpattern_dividers_enabled=wallpattern_dividers_enabled,
  wallpattern_hole_sides=wallpattern_hole_sides,
  wallpattern_hole_size=wallpattern_hole_size, 
  wallpattern_hole_spacing=wallpattern_hole_spacing,
  wallpattern_fill=wallpattern_fill,
  wallpattern_voronoi_noise=wallpattern_voronoi_noise,
  wallpattern_voronoi_radius = wallpattern_voronoi_radius,
  wallcutout_vertical=wallcutout_vertical,
  wallcutout_vertical_position=wallcutout_vertical_position,
  wallcutout_vertical_width=wallcutout_vertical_width,
  wallcutout_vertical_angle=wallcutout_vertical_angle,
  wallcutout_vertical_height=wallcutout_vertical_height,
  wallcutout_vertical_corner_radius=wallcutout_vertical_corner_radius,
  wallcutout_horizontal=wallcutout_horizontal,
  wallcutout_horizontal_position=wallcutout_horizontal_position,
  wallcutout_horizontal_width=wallcutout_horizontal_width,
  wallcutout_horizontal_angle=wallcutout_horizontal_angle,
  wallcutout_horizontal_height=wallcutout_horizontal_height,
  wallcutout_horizontal_corner_radius=wallcutout_horizontal_corner_radius,
  extension_enabled=[
    [extension_x_enabled,extension_x_position],
    [extension_y_enabled,extension_y_position]],
  extension_tabs_enabled=extension_tabs_enabled,
  extension_tab_size=extension_tab_size,
  cutx=cutx,
  cuty=cuty,
  help=enable_help) {
  $showHelp = help;
  
  num_x = calcDimensionWidth(width);
  num_y = calcDimensionDepth(depth);
  num_z = calcDimensionHeight(height);

  item = LookupKnown(
      knowItemCode=itemholder_known_item,
      customDiameter=itemholder_hole_diameter, 
      customSize=itemholder_hole_size, 
      customDepth=itemholder_hole_depth, 
      customShape=itemholder_hole_base_shape);
  
  itemCalc = item[ishape] == "multicard"
      ? multiCardCalculations(
          multiCards = itemholder_multi_cards, 
          multiCardCompact = itemholder_multi_card_compact,
          holeClearance = itemholder_hole_clearance)
      : itemCalculations(
          item = item,
          sides = itemholder_hole_sides,
          holeDepth = itemholder_hole_depth,
          holeClearance = itemholder_hole_clearance);

  _depth = itemCalc[icHoleSize].z;
  // min floor height
  bch = cupBaseClearanceHeight(magnet_diameter, screw_depth);
  mfh = calculateMinFloorHeight(magnet_diameter, screw_depth);
  
  //calculate the bin height. This math is not right
  height = !itemholder_auto_bin_height || _depth <=0 ? num_z
      : filled_in
        ? (mfh+_depth)/gf_zpitch
        : ceil((mfh+_depth)/gf_zpitch);
  if(IsHelpEnabled("info")) echo("gridfinity_itemholder", _depth=_depth, bch=bch, height=height); 
  // calculate floor thickness
  ft = calculateFloorThickness(magnet_diameter, screw_depth, _depth+gf_cup_floor_thickness, height, filled_in);  

  if(itemholder_enable_sample == false)
  {
    difference() {
      /*<!!start gridfinity_basic_cup!!>*/
      gridfinity_cup(
      width=width, depth=depth, height=height,
      position=position,
      filled_in=filled_in,
      label_settings=label_settings,
      fingerslide=fingerslide,
      fingerslide_radius=fingerslide_radius,
      magnet_diameter=magnet_diameter,
      magnet_easy_release=magnet_easy_release,
      screw_depth=screw_depth,
      center_magnet_diameter=center_magnet_diameter,
      center_magnet_thickness=center_magnet_thickness,
      floor_thickness=ft,
      cavity_floor_radius=cavity_floor_radius,
      wall_thickness=wall_thickness,
      hole_overhang_remedy=hole_overhang_remedy,
      efficient_floor=efficient_floor,
      chamber_wall_thickness=chamber_wall_thickness,
      vertical_chambers = vertical_chambers,
      vertical_separator_bend_position=vertical_separator_bend_position,
      vertical_separator_bend_angle=vertical_separator_bend_angle,
      vertical_separator_bend_separation=vertical_separator_bend_separation,
      vertical_separator_cut_depth=vertical_separator_cut_depth,
      vertical_irregular_subdivisions=vertical_irregular_subdivisions,
      vertical_separator_config=vertical_separator_config,
      horizontal_chambers=horizontal_chambers,
      horizontal_separator_bend_position=horizontal_separator_bend_position,
      horizontal_separator_bend_angle=horizontal_separator_bend_angle,
      horizontal_separator_bend_separation=horizontal_separator_bend_separation,
      horizontal_separator_cut_depth=horizontal_separator_cut_depth,
      horizontal_irregular_subdivisions=horizontal_irregular_subdivisions,
      horizontal_separator_config=horizontal_separator_config, 
      half_pitch=half_pitch,
      lip_style=lip_style,
      zClearance=zClearance,
      box_corner_attachments_only=box_corner_attachments_only,
      flat_base = flat_base,
      spacer=spacer,
      tapered_corner=tapered_corner,
      tapered_corner_size = tapered_corner_size,
      tapered_setback = tapered_setback,
      wallpattern_enabled=wallpattern_enabled,
      wallpattern_style=wallpattern_style,
      wallpattern_walls=wallpattern_walls, 
      wallpattern_dividers_enabled=wallpattern_dividers_enabled,
      wallpattern_hole_sides=wallpattern_hole_sides,
      wallpattern_hole_size=wallpattern_hole_size, 
      wallpattern_hole_spacing=wallpattern_hole_spacing,
      wallpattern_fill=wallpattern_fill,
      wallpattern_voronoi_noise=wallpattern_voronoi_noise,
      wallpattern_voronoi_radius = wallpattern_voronoi_radius,
      wallcutout_vertical=wallcutout_vertical,
      wallcutout_vertical_position=wallcutout_vertical_position,
      wallcutout_vertical_width=wallcutout_vertical_width,
      wallcutout_vertical_angle=wallcutout_vertical_angle,
      wallcutout_vertical_height=wallcutout_vertical_height,
      wallcutout_vertical_corner_radius=wallcutout_vertical_corner_radius,
      wallcutout_horizontal=wallcutout_horizontal,
      wallcutout_horizontal_position=wallcutout_horizontal_position,
      wallcutout_horizontal_width=wallcutout_horizontal_width,
      wallcutout_horizontal_angle=wallcutout_horizontal_angle,
      wallcutout_horizontal_height=wallcutout_horizontal_height,
      wallcutout_horizontal_corner_radius=wallcutout_horizontal_corner_radius,
      extendable_Settings=ExtendableSettings(
        extendablexEnabled = extension_x_enabled, 
        extendablexPosition = extension_x_position, 
        extendableyEnabled = extension_y_enabled, 
        extendableyPosition = extension_y_position, 
        extendableTabsEnabled = extension_tabs_enabled, 
        extendableTabSize = extension_tab_size),
      cutx=cutx,
      cuty=cuty,
      help = enable_help);
      /*<!!end gridfinity_basic_cup!!>*/

      color(color_extension)
      translate(cupPosition(position,num_x,num_y))
      translate([0,0,bch])
      itemholder(
        num_x=num_x, num_y=num_y, num_z=height,
        knowItemCode = itemholder_known_item,
        customHoleBaseShape = itemholder_hole_base_shape,
        multiCards = itemholder_multi_cards,
        multiCardCompact = itemholder_multi_card_compact,
        gridStyle = itemholder_grid_style,
        sides = itemholder_hole_sides,
        holeSize = itemholder_hole_size,
        holeDiameter = itemholder_hole_diameter,
        holeSpacing = itemholder_hole_spacing,
        holeDepth = itemholder_hole_depth, 
        holeChamfer = itemholder_hole_chamfer,
        holeGrid  = itemholder_hole_grid,
        holeClearance = itemholder_hole_clearance,
        floorThickness = ft,
        wallThickness = wall_thickness,
        compartments = itemholder_compartments,
        compartment_spacing = itemholder_compartment_spacing,
        compartment_centered = itemholder_compartment_centered,
        compartment_fill = itemholder_compartment_fill,
        customcompartments = itemholder_customcompartments,
        help=help);
      }
  } else {
    //generate sample print
    samplesholder(
      knowItemCode = itemholder_known_item,
      customHoleBaseShape = itemholder_hole_base_shape,
      multiCards = itemholder_multi_cards,
      multiCardCompact = itemholder_multi_card_compact,
      sides = itemholder_hole_sides,
      holeSize = itemholder_hole_size,
      holeDiameter = itemholder_hole_diameter,
      holeDepth = itemholder_hole_depth, 
      holeChamfer = itemholder_hole_chamfer,
      holeClearance = itemholder_hole_clearance,
      wallThickness = itemholder_sample_wall_thickness,
      help=help);
  }
}

gridfinity_itemholder();
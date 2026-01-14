include <modules/module_item_holder.scad>
include <modules/module_item_holder_data.scad>
include <modules/gridfinity_constants.scad>
include <modules/functions_general.scad>
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity_block.scad>

/*<!!start gridfinity_itemholder!!>*/
/* [Item Holder] */
itemholder_known_tools = "1/4hexshank"; // [ "custom":Custom, "4hexshank":4mm Hex Shank, "1/4hexshank":1/4 Hex Shank, "1/4hexshanklong":1/4 Hex Long Shank, "5/16hexshank":5/16 Hex Shank, "3/8hexshank":3/8 Hex Shank, "1/2shank":1/2 inch router bit, "12shank":12mm router bit, "10shank":10mm router bit, "3/8shank":3/8 inch router bit, "8shank":8mm router bit, "1/4shank":1/4 inch router bit, "6shank":6mm router bit, "1/8shank":1/8 inch Dremel router bit]
itemholder_known_batteries = "custom"; // [ "custom":Custom, "aaaa":AAAA cell, "aaa":AAA cell, "aa":AA cell, "9v":9v, "c":C cell, "d":d cell, "7540cell":7540 cell, "8570cell":8570 cell, "10180cell":10180 cell, "10280cell":10280 cell, "10440cell":10440 cell, "10850cell":10850 cell, "13400cell":13400 cell, "14250cell":14250 cell, "14300cell":14300 cell, "14430cell":14430 cell, "14500cell":14500 cell, "14650cell":14650 cell, "15270cell":15270 cell, "16340cell":16340 cell, "16650cell":16650 cell, "17500cell":17500 cell, "17650cell":17650 cell, "17670cell":17670 cell, "18350cell":18350 cell, "18490cell":18490 cell, "18500cell":18500 cell, "18650cell":18650 cell, "20700cell":20700 cell, "21700cell":21700 cell, "25500cell":25500 cell, "26500cell":26500 cell, "26650cell":26650 cell, "26700cell":26700 cell, "26800cell":26800 cell, "32600cell":32600 cell, "32650cell":32650 cell, "32700cell":32700 cell, "38120cell":38120 cell, "38140cell":38140 cell, "40152cell":40152 cell, "4680cell":4680 cell]
itemholder_known_cell_batteries = "custom"; // [ "custom":Custom, "cr927":CR927 cell, "cr1025":CR1025 cell, "cr1130":CR1130 cell, "cr1216":CR1216 cell, "cr1220":CR1220 cell, "cr1225":CR1225 cell, "cr1616":CR1616 cell, "cr1620":CR1620 cell, "cr1632":CR1632 cell, "cr2012":CR2012 cell, "cr2016":CR2016 cell, "cr2020":CR2020 cell, "cr2025":CR2025 cell, "cr2032":CR2032 cell, "cr2040":CR2040 cell, "cr2050":CR2050 cell, "cr2320":CR2320 cell, "cr2325":CR2325 cell, "cr2330":CR2330 cell, "br2335":BR2335 cell, "cr2354":CR2354 cell, "cr2412":CR2412 cell, "cr2430":CR2430 cell, "cr2450":CR2450 cell, "cr2477":CR2477 cell, "cr3032":CR3032 cell, "cr11108":CR11108 cell]
itemholder_known_cards = "custom"; // [ "custom":Custom, "multicard":Multi card slot, "compactflashi":CompactFlash. Type I, "compactflashii":CompactFlash. Type II, "smartmedia":SmartMedia, "mmc":MMC. MMCplus, "mmcmobile":RS-MMC. MMCmobile, "mmcmicro":MMCmicro, "sd":SD. SDHC. SDXC. SDIO. MicroP2, "minisd":miniSD. miniSDHC. miniSDIO, "microsd":microSD. microSDHC. microSDXC, "memorystickstandard":Memory Stick Standard. PRO, "memorystickduo":Memory Stick Duo. PRO Duo. PRO-HG. XC, "memorystickmicro":Memory Stick Micro (M2). XC, "nano":Nano Memory, "psvita":PS Vita Memory Card, "xqd":XQD card, "xD":xD, "usba":USB A, "usbc":USB C]
itemholder_known_cartridges = "custom"; // [ "custom":Custom, "atari800":Atari 800, "atari2600":Atari 2600/7800/Colecovision, "atari5200":Atari 5200, "atari7800":Atari 7800, "commodore":Commodore Vic20, "magnavoxodyssey":Magnavox Odyssey, "magnavoxodysseymulticard":Magnavox Odyssey (multicard), "magnavoxodyssey2":Magnavox Odyssey2, "mattelintellivision":Mattel Intellivision I & II, "nintendofamicom":Nintendo Famicom, "nintendofamicomdisk":Nintendo Famicom Disk, "nintendosuperfamicom":Nintendo Super Famicom / SNES (Pal), "nes":NES, "snes":SNES, "nintendo64":Nintendo 64, "nintendogb":Nintendo GB, "nintendogbc":Nintendo GBC, "nintendogba":Nintendo GBA, "nintendods":Nintendo DS, "nintendo2ds":Nintendo 2DS/3DS, "nintendovb":Nintendo Virtual Boy, "nintendoswitch":Nintendo Switch, "segagamegear":Sega Game Gear, "segagenesis":Sega Genesis, "segagenesistall":Sega Genesis (tall cart), "segamegadrive":Sega MegaDrive, "segamegadrivecodemasters":Sega MegaDrive Codemasters, "segamastersystem":Sega Master System, "sega32x":Sega 32x, "segacard":Sega Card/TG16, "segapico":Sega Pico, "sonyumd":Sony UMD, "sonypsvita":Sony PS Vita, "sonypsvitamemcard":Sony PS Vita (Mem Card), "necpcehucard":NEC PCE HuCard, "snkneogeoaes":SNK Neo Geo AES, "snkneogeomvs":SNK Neo Geo MVS, "bandai":Bandai Wonderswan/Color, "msx":MSX]
// Enlarge the holes by this amount for clearance
itemholder_hole_clearance = 0.25;
// Depth of hole, Overrides the known item depth. Limited by floor height.
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
// Diameter of, round hole, or corners for square hole
itemholder_hole_diameter = 5; //0.1
// Radius of the bottom of the custom shape
itemholder_hole_bottom_radius = 0;
// The size the hole
itemholder_hole_size = [20, 25]; //0.1
itemholder_hole_rotation = 0;

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
itemholder_auto_bin_height = "enabled"; //["enabled","enabled_full","disabled"]
// The number of sides for a round hole 
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
//[[xpos, ypos, xsize, ysize, radius, depth]].  xpos, ypos: the x/y position in gridfinity units.  xsize, ysize: the x/y size in gridfinity units.  radius [optional]: corner radius in mm.  depth [optional]: depth in mm.  Example "0,0,2,1|2,0,2,1,2,5"
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
filled_in = "disabled"; //[disabled, enabled, "enabledfilllip":Fill cup and lip]
// Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
//under size the bin top by this amount to allow for better stacking
headroom = 0.8; // 0.1

/* [Cup Lip] */
// Style of the cup lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [1,1]; //0.1
// Create a relie
lip_top_relief_height = -1; // 0.1
// add a notch to the lip to prevent sliding.
lip_top_notches  = true;

/* [Subdivisions] */
chamber_wall_thickness = 1.2;
//Reduce the wall height by this amount
chamber_wall_headroom = 0;//0.1
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
// Enable magnets
enable_magnets = true;
// Enable screws
enable_screws = true;
//size of magnet, diameter and height. Zack's original used 6.5 and 2.4
magnet_size = [6.5, 2.4];  // .1
//create relief for magnet removal
magnet_easy_release = "auto";//["off","auto","inner","outer"] 
//size of screw, diameter and height. Zack's original used 3 and 6
screw_size = [3, 6]; // .1
//size of center magnet, diameter and height.
center_magnet_size = [0,0];
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = true;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth]
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = "off";
// Remove floor to create a vertical spacer
spacer = false;

/* [Label] */
label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]

/* [Sliding Lid] */
sliding_lid_enabled = false;
// 0 = wall thickness *2
sliding_lid_thickness = 0; //0.1
// 0 = wall_thickness/2
sliding_min_wallThickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
sliding_min_support = 0;//0.1
sliding_clearance = 0.1;//0.1
sliding_lid_lip_enabled = false;

/* [Finger Slide] */
// Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// Radius of the corner fillet, 0:none, >1: radius in mm, <0 dimention/abs(n) (i.e. -3 is 1/3 the width)
fingerslide_radius = -3;
// wall to enable on, front, back, left, right. 0: disabled; 1: enabled using radius; >1: override radius.
fingerslide_walls=[1,0,0,0];
//Align the fingerslide with the lip
fingerslide_lip_aligned=true;

/* [Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [Wall Pattern] */
// Grid wall patter
wallpattern_enabled=false;
// Style of the pattern
wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// Spacing between pattern
wallpattern_strength = 2; //0.1
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// rotate the grid
wallpattern_rotate_grid=false;
//Size of the hole
wallpattern_cell_size = [10,10]; //0.1
// Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both] 
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//Radius of corners
wallpattern_hole_radius = 0.5;
// pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
wallpattern_border = 0;
// depth of imprint in mm, 0 = is wall width.
wallpattern_depth = 0; // 0.1
//grid pattern hole taper
wallpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise, 
wallpattern_pattern_voronoi_noise = 0.75; //0.01
//brick pattern center weight
wallpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2

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

/* [Bottom Text] */
// Add bin size to bin bottom
text_1 = false;
// Size of text, in mm
text_size = 6; // 0.1
// Depth of text, in mm
text_depth = 0.3; // 0.01
// Offset of text , in mm
text_offset = [0, 0]; // 0.1
// Font to use
text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// Add free-form text line to bin bottom (printing date, serial, etc)
text_2 = false;
// Actual text to add
text_2_text = "Gridfinity";

/* [debug] */
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [Model detail] */
//assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
//where to render the model
render_position = "center"; //[default,center,zero]
// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments 
fa = 6; 
// minimum size of a fragment.  Low is more fragments
fs = 0.1; 
// number of fragments, overrides $fa and $fs
fn = 0;  
// set random seed for 
random_seed = 0; //0.0001
/*<!!end gridfinity_basic_cup!!>*/

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;   

//Function for creating a custom shape.
//To use this feature you need to define the require shape in the module below.
//Then configure the options in the customiser, is the item is space appropriately.
module mycustomshape(){ 
  //Example custom shape
  //settings needed
  //item hole depth 30
  //item hole size 20,25
  //item grid style square
  //item spacing 4
  translate([4,0,0])
  union(){
    chamfered_cube(size=[9.9,25.3,30], topChamfer = 1, cornerRadius = 1, bottomRadius=0);
    translate([-2.1,7.55,0])
    chamfered_cube(size=[3,10,30], topChamfer = 1, cornerRadius = 1, bottomRadius=0);
  }
  
  //You can use any shapes but these are some example shapes
  //chamfered_cube(size=[10,10,10], chamfer = 1, cornerRadius = 1,  bottomRadius=0);
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
      _sides = LookupKnownShapes(name="multicard"),
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
    _sides = LookupKnownShapes(name=item[ishape], default_sides=sides),
    _depthTemp = holeDepth > 0 ? holeDepth : item[idepthneeded],
    _depth = _depthTemp <= 0 ? 5 : _depthTemp,
    _holeSize = 
      item[ishape] == "round" || item[ishape] == "hex"
        ? [item[iitemDiameter] + holeClearance, 0, _depth]
      : item[ishape] == "halfround" 
        ? [item[iitemx]+holeClearance, item[iitemy]+holeClearance, item[iitemx]/2]
      : [item[iitemx]+holeClearance,item[iitemy]+holeClearance,_depth]
  ) [_sides,
      _holeSize,
      [],[],[],0];   
    
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
  holeRotation = [0,0,0],
  holeBottomRadius = 0,
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
  
  xSize = (num_x*env_pitch().x-(compartments.x+1)*compartment_spacing)/compartments.x;
  xStep = xSize + compartment_spacing;
  ySize = (num_y*env_pitch().y-(compartments.y+1)*compartment_spacing)/compartments.y - _multiCardCompact;
  yStep = ySize + compartment_spacing;
  
  if(env_help_enabled("info")) echo("itemholder", item=item, multiCards=multiCards,longCenter=itemCalc[icMcLongCenterItem],smallCenter=itemCalc[icMcShortCenterItem],side=itemCalc[icMcSideItem], _multiCardCompact=_multiCardCompact, _sides=_sides, _holeSize=_holeSize,_depth=_depth);
  if(env_help_enabled("info")) echo("itemholder", xSize=xSize, xStep=xStep, ySize=ySize, yStep=yStep);
  
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
          fill=compartment_fill)
            if(item[ishape]=="multicard")
            {
              multiCard(
                itemCalc[icMcLongCenterItem], itemCalc[icMcShortCenterItem], itemCalc[icMcSideItem], 
                chamfer = holeChamfer,
                alternate = _multiCardCompact > 0 && (($idx.y % 2) != $idx.x % 2));
            } else if(item[ishape] == "square") {
              rotate_around([0,0,holeRotation], [_holeSize.x/2, _holeSize.y/2])
              chamfered_cube(
                size = [_holeSize.x, _holeSize.y, _depth+fudgeFactor], 
                topChamfer=holeChamfer, 
                cornerRadius=item[iitemDiameter]/2, bottomRadius=holeBottomRadius);
            } else if(item[ishape] == "halfround") {
              translate([_holeSize.x/2,_holeSize.y/2,0])
                chamferedHalfCylinder(
                  r=item[iitemx]/2, 
                  h=item[iitemy], 
                  chamfer=holeChamfer);
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

module rotate_around(roation, center){
   translate([center.x,center.y])
   rotate(roation)
   translate([-center.x,-center.y])
   children();
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
  holeBottomRadius=0,
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

  if(env_help_enabled("info")) echo("itemholder", knowItemCode=knowItemCode, holeDepth=holeDepth, item=item, itemCalc=itemCalc, mc=mc,longCenter=itemCalc[icMcLongCenterItem],smallCenter=itemCalc[icMcShortCenterItem],side=itemCalc[icMcSideItem], _sides=_sides, _holeSize=_holeSize,_depth=_depth, Rc=Rc, Dc=Rc*2);

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
        chamfered_cube([_holeSize.x, _holeSize.y, _depth+fudgeFactor], topChamfer=holeChamfer, cornerRadius=item[iitemDiameter]/2, bottomRadius=holeBottomRadius);
    }
  } else if(item[ishape] == "halfround") {
    difference(){
      translate([-_holeSize.x/2-wallThickness,-_holeSize.y/2-wallThickness,-wallThickness-fudgeFactor])
        cube(size=[_holeSize.x+wallThickness*2,_holeSize.y+wallThickness*2, _depth+fudgeFactor+wallThickness]);

      chamferedHalfCylinder(r=item[iitemx]/2, h=item[iitemy], chamfer=holeChamfer);
    }
  } else {
    difference(){
      translate([0,0,-wallThickness-fudgeFactor])
        cylinder(h=_depth+fudgeFactor+wallThickness, r=Rc+wallThickness);
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
  itemholder_hole_rotation = itemholder_hole_rotation,
  itemholder_hole_bottom_radius = itemholder_hole_bottom_radius,
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
  filled_in=filled_in,
  label_settings=LabelSettings(
    labelStyle=label_style, 
    labelPosition=label_position, 
    labelSize=label_size,
    labelRelief=label_relief,
    labelWalls=label_walls),
  finger_slide_settings = FingerSlideSettings(
    type = fingerslide,
    radius = fingerslide_radius,
    walls = fingerslide_walls,
    lip_aligned = fingerslide_lip_aligned),
  magnet_size=enable_magnets?magnet_size:[0,0],
  magnet_easy_release=magnet_easy_release,
  screw_size=enable_screws?screw_size:[0,0],
  center_magnet_diameter=center_magnet_size[0],
  center_magnet_thickness=center_magnet_size[1],
  floor_thickness=floor_thickness,
  cavity_floor_radius=cavity_floor_radius,
  wall_thickness=wall_thickness,
  hole_overhang_remedy=hole_overhang_remedy,
  efficient_floor=efficient_floor,
  vertical_chambers = ChamberSettings(
    chambers_count = vertical_chambers,
    chamber_wall_thickness = chamber_wall_thickness,
    chamber_wall_headroom = chamber_wall_headroom,
    separator_bend_position = vertical_separator_bend_position,
    separator_bend_angle = vertical_separator_bend_angle,
    separator_bend_separation = vertical_separator_bend_separation,
    separator_cut_depth = vertical_separator_cut_depth,
    irregular_subdivisions = vertical_irregular_subdivisions,
    separator_config = vertical_separator_config),
  horizontal_chambers = ChamberSettings(
    chambers_count = horizontal_chambers,
    chamber_wall_thickness = chamber_wall_thickness,
    chamber_wall_headroom = chamber_wall_headroom,
    separator_bend_position = horizontal_separator_bend_position,
    separator_bend_angle = horizontal_separator_bend_angle,
    separator_bend_separation = horizontal_separator_bend_separation,
    separator_cut_depth = horizontal_separator_cut_depth,
    irregular_subdivisions = horizontal_irregular_subdivisions,
    separator_config = horizontal_separator_config),
  half_pitch=half_pitch,
  lip_settings = LipSettings(
    lipStyle=lip_style, 
    lipSideReliefTrigger=lip_side_relief_trigger, 
    lipTopReliefHeight=lip_top_relief_height, 
    lipNotch=lip_top_notches),
  headroom=headroom,
  box_corner_attachments_only=box_corner_attachments_only,
  flat_base = flat_base,
  spacer=spacer,
  tapered_corner=tapered_corner,
  tapered_corner_size = tapered_corner_size,
  tapered_setback = tapered_setback,
  wallpattern_walls=wallpattern_walls, 
  wallpattern_dividers_enabled=wallpattern_dividers_enabled,
  wall_pattern_settings = PatternSettings(
    patternEnabled = wallpattern_enabled, 
    patternStyle = wallpattern_style, 
    patternRotate = wallpattern_rotate_grid,
    patternFill = wallpattern_fill,
    patternBorder = wallpattern_border, 
    patternDepth = wallpattern_depth,
    patternCellSize = wallpattern_cell_size, 
    patternHoleSides = wallpattern_hole_sides,
    patternStrength = wallpattern_strength, 
    patternHoleRadius = wallpattern_hole_radius,
    patternGridChamfer = wallpattern_pattern_grid_chamfer,
    patternVoronoiNoise = wallpattern_pattern_voronoi_noise,
    patternBrickWeight = wallpattern_pattern_brick_weight,
    patternFs = wallpattern_pattern_quality),
  wallcutout_vertical_settings = WallCutoutSettings(
    type = wallcutout_vertical, 
    position = wallcutout_vertical_position, 
    width = wallcutout_vertical_width,
    angle = wallcutout_vertical_angle,
    height = wallcutout_vertical_height, 
    corner_radius = wallcutout_vertical_corner_radius),
  wallcutout_horizontal_settings = WallCutoutSettings(
    type = wallcutout_horizontal, 
    position = wallcutout_horizontal_position, 
    width = wallcutout_horizontal_width,
    angle = wallcutout_horizontal_angle,
    height = wallcutout_horizontal_height, 
    corner_radius = wallcutout_horizontal_corner_radius),
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

  calculatedItemDepth = itemCalc[icHoleSize].z;
  calculatedItemClearanceHeight = item[iitemHeight];
  // min floor height
  baseClearanceHeight = cupBaseClearanceHeight(magnet_size[1], screw_size[1], center_magnet_thickness);
  
  //calculate the bin height. This math is not right
  height = 
    let(itemheightneeded = itemholder_auto_bin_height == "enabled_full" ? calculatedItemClearanceHeight: calculatedItemDepth)
    itemholder_auto_bin_height == "disabled" || itemheightneeded <=0 
      ? num_z
      : filled_in != "disabled"
        ? (baseClearanceHeight + floor_thickness + itemheightneeded)/env_pitch().z
        : ceil((baseClearanceHeight + floor_thickness + itemheightneeded)/env_pitch().z);
   
  // calculate floor thickness
  calculatedUsableFloorThickness = calculateUsableFloorThickness(magnet_depth=magnet_size[1], screw_depth=screw_size[1], floor_thickness=calculatedItemDepth + floor_thickness, num_z=height, filled_in=filled_in,flat_base=flat_base);  

  
  if(env_help_enabled("info")) echo("gridfinity_itemholder", height=height, filled_in=filled_in, calculatedItemDepth=calculatedItemDepth, calculatedUsableFloorThickness=calculatedUsableFloorThickness, baseClearanceHeight=baseClearanceHeight, height=height); 

  if(itemholder_enable_sample == false)
  {
    difference() {
      /*<!!start gridfinity_basic_cup!!>*/
      gridfinity_cup(
        width=width, depth=depth, height=height,
        filled_in=filled_in,
        label_settings=LabelSettings(
          labelStyle=label_style, 
          labelPosition=label_position, 
          labelSize=label_size,
          labelRelief=label_relief,
          labelWalls=label_walls),
        finger_slide_settings = finger_slide_settings,
        cupBase_settings = CupBaseSettings(
          magnetSize = magnet_size,
          magnetEasyRelease = magnet_easy_release, 
          centerMagnetSize = center_magnet_size, 
          screwSize = enable_screws?screw_size:[0,0],
          holeOverhangRemedy = hole_overhang_remedy, 
          cornerAttachmentsOnly = box_corner_attachments_only,
          floorThickness = calculatedUsableFloorThickness, //todo this seems like the wrong value
          cavityFloorRadius = cavity_floor_radius,
          efficientFloor=efficient_floor,
          halfPitch=half_pitch,
          flatBase=flat_base,
          spacer=spacer),
        wall_thickness=wall_thickness,
        vertical_chambers = vertical_chambers,
        horizontal_chambers=horizontal_chambers,
        lip_settings=lip_settings,
        headroom=headroom,
        tapered_corner=tapered_corner,
        tapered_corner_size = tapered_corner_size,
        tapered_setback = tapered_setback,
        wallpattern_walls=wallpattern_walls,
        wallpattern_dividers_enabled=wallpattern_dividers_enabled,
        wall_pattern_settings = wall_pattern_settings, 
        wallcutout_vertical_settings=wallcutout_vertical_settings,
        wallcutout_horizontal_settings=wallcutout_horizontal_settings,
        extendable_Settings = ExtendableSettings(
          extendablexEnabled = extension_x_enabled, 
          extendablexPosition = extension_x_position, 
          extendableyEnabled = extension_y_enabled, 
          extendableyPosition = extension_y_position, 
          extendableTabsEnabled = extension_tabs_enabled, 
          extendableTabSize = extension_tab_size),
        sliding_lid_enabled = sliding_lid_enabled, 
        sliding_lid_thickness = sliding_lid_thickness, 
        sliding_min_wall_thickness = sliding_min_wallThickness, 
        sliding_min_support = sliding_min_support, 
        sliding_clearance = sliding_clearance,
        sliding_lid_lip_enabled=sliding_lid_lip_enabled,
        cupBaseTextSettings = CupBaseTextSettings(
          baseTextLine1Enabled = text_1,
          baseTextLine2Enabled = text_2,
          baseTextLine2Value = text_2_text,
          baseTextFontSize = text_size,
          baseTextFont = text_font,
          baseTextDepth = text_depth,
          baseTextOffset = text_offset));
      /*<!!end gridfinity_basic_cup!!>*/

      itemholder_z_bottom = max(
          baseClearanceHeight, 
          baseClearanceHeight + floor_thickness - calculatedItemDepth);
      
      color(color_extension)
      translate([0, 0, itemholder_z_bottom])
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
        holeRotation = itemholder_hole_rotation,
        holeBottomRadius = itemholder_hole_bottom_radius,
        floorThickness = calculatedUsableFloorThickness,
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
      holeBottomRadius = itemholder_hole_bottom_radius,
      wallThickness = itemholder_sample_wall_thickness,
      help=help);
  }
}

set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  cut = [cutx, cuty, 0],
  setColour = set_colour)
gridfinity_itemholder();

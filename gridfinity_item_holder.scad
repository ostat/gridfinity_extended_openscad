include <modules/modules_item_holder.scad>
include <modules/gridfinity_constants.scad>
include <modules/functions_general.scad>
use <modules/gridfinity_cup_modules.scad>
use <modules/gridfinity_modules.scad>

/*<!!start gridfinity_itemholder!!>*/
/* [Item Holder] */

itemholder_known_item = "1/4hexshank"; // [ custom:"Custome", 4hexshank:"4mm Hex Shank", 1/4hexshank:"1/4 Hex Shank", 1/4hexlongshank:"1/4 Hex Long Shank", 5/16hexshank:"5/16 Hex Shank", 3/8hexshank:"3/8 Hex Shank", "aaaa":"AAAA cell", "aaa":"AAA cell", "aa":"AA cell", "c":"C cell", "d":"d cell", "7540":"7540 cell", "8570":"8570 cell", "10180":"10180 cell", "10280":"10280 cell", "10440":"10440 cell", "10850":"10850 cell", "13400":"13400 cell", "14250":"14250 cell", "14300":"14300 cell", "14430":"14430 cell", "14500":"14500 cell", "14650":"14650 cell", "15270":"15270 cell", "16340":"16340 cell", "16650":"16650 cell", "17500":"17500 cell", "17650":"17650 cell", "17670":"17670 cell", "18350":"18350 cell", "18490":"18490 cell", "18500":"18500 cell", "18650":"18650 cell", "20700":"20700 cell", "21700":"21700 cell", "25500":"25500 cell", "26500":"26500 cell", "26650":"26650 cell", "26700":"26700 cell", "26800":"26800 cell", "32600":"32600 cell", "32650":"32650 cell", "32700":"32700 cell", "38120":"38120 cell", "38140":"38140 cell", "40152":"40152 cell", "4680":"4680 cell"]
itemholder_known_cards = "custom"; // [ custom:"Custome", "multicard":"Multi card slot", "compactflashi":"CompactFlash, Type I", "compactflashii":"CompactFlash, Type II", "smartmedia":"SmartMedia", "mmc":"MMC, MMCplus", "mmcmobile":"RS-MMC, MMCmobile", "mmcmicro":"MMCmicro", "sd":"SD, SDHC, SDXC, SDIO, MicroP2", "minisd":"miniSD, miniSDHC, miniSDIO", "microsd":"microSD, microSDHC, microSDXC", "memorystickstandard":"Memory Stick Standard, PRO", "memorystickduo":"Memory Stick Duo, PRO Duo, PRO-HG, XC", "memorystickmicro":"Memory Stick Micro (M2), XC", "nano":"Nano Memory", "psvita":"PS Vita Memory Card", "xqd":"XQD card", "xD":"xD", "USBA":"USB A", "USBC":"USB C"]
itemholder_known_cartridges = "custom"; // [ custom:"Custome", "atari800":"Atari 800", "atari2600":"Atari 2600/7800/Colecovision", "atari5200":"Atari 5200", "atari7800":"Atari 7800", "commodore":"Commodore Vic20", "magnavoxodyssey":"Magnavox Odyssey", "magnavoxodysseymulticard":"Magnavox Odyssey (multicard)", "magnavoxodyssey2":"Magnavox Odyssey2", "mattelintellivision":"Mattel Intellivision I & II", "nintendofamicom":"Nintendo Famicom", "nintendofamicomdisk":"Nintendo Famicom Disk", "nintendosuperfamicom":"Nintendo Super Famicom / SNES (Pal)", "nes":"NES", "snes":"SNES", "nintendo64":"Nintendo 64", "nintendogb":"Nintendo GB", "nintendogbc":"Nintendo GBC", "nintendogba":"Nintendo GBA", "nintendods":"Nintendo DS", "nintendo2ds":"Nintendo 2DS/3DS", "nintendovb":"Nintendo Virtual Boy", "nintendoswitch":"Nintendo Switch", "segagamegear":"Sega Game Gear", "segagenesis":"Sega Genesis", "segagenesistall":"Sega Genesis (tall cart)", "segamegadrive":"Sega MegaDrive", "segamegadrivecodemasters":"Sega MegaDrive Codemasters", "segamastersystem":"Sega Master System", "sega32x":"Sega 32x", "segacard":"Sega Card/TG16", "segapico":"Sega Pico", "sonyumd":"Sony UMD", "sonypsvita":"Sony PS Vita", "sonypsvitamemcard":"Sony PS Vita (Mem Card)", "necpcehucard":"NEC PCE HuCard", "snkneogeoaes":"SNK Neo Geo AES", "snkneogeomvs":"SNK Neo Geo MVS", "bandai":"Bandai Wonderswan/Color", "msx":"MSX"]

// cards to use when multi card is selected I.E. sd;USBA;microsd
itemholder_multi_cards = "sd;USBA;microsd";

// Nest multi cards, This has a but where the last one could be cropped.
itemholder_multi_card_compact = 0.7; // [0:0.1:1]

// Should the grid be square or hex
itemholder_grid_style = "auto"; //["square","hex","auto"]
//Spacing around the holes
itemholder_hole_spacing = 2; //0.1

//enlarge the holes by this amount for clearance
itemholder_hole_clearance = 0.65;

// Depth of hole, Overrides the know item depth. Limited by floor height
itemholder_hole_depth = 0; //0.1

// 45 deg chamfer added to the top of the hole (mm)
itemholder_hole_chamfer = 1; //0.5

// The number of sides for the hole, when custom is selected
itemholder_hole_sides = 4; 
// The size the hole, when custom is selected
itemholder_hole_size = 10; //0.1

// Number of holes in the x and ydimension, 0 is dynamic
itemholder_hole_gridx = 0; //1
// Number of holes in the y dimension, 0 is dynamic, y.5, is only valid for hex.
itemholder_hole_gridy = 0; //0.5
//Auto set the bin height based on the hole size.
itemholder_auto_bin_height = true;
itemholder_compartments = [1,1]; //[1:10]
// Spacing around the compartments
itemholder_compartment_spacing = 3; //0.1
// Center the holes within the compartments
itemholder_compartment_centered = true; //0.1
itemholder_compartment_fill = "none"; //["none", "space", "crop"]

/*
xpos,ypos,xsize,ysize,radius,depth. 
dimentions of the tray cutout, a string with comma separated values, and pipe (|) separated trays.
 - xpos, ypos, the x/y position in gridinity units.
 - xsize, ysize. the x/y size in gridinity units. 
 - radius, [optional] corner radius in mm.
 - depth, [optional] depth in mm
 - example "0,0,2,1|2,0,2,1,2,5"
*/
//[[xpos,ypos,xsize,ysize,radius,depth]]. xpos, ypos, the x/y position in gridinity units.xsize, ysize. the x/y size in gridinity units. radius, [optional] corner radius in mm.depth, [optional] depth in mm\nexample "0,0,2,1|2,0,2,1,2,5"
itemholder_customcompartments = "";
/*<!!end gridfinity_itemholder!!>*/

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X dimension in grid units  (multiples of 42mm)
width = 2; // [ 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Y dimension in grid units (multiples of 42mm)
depth = 1; // [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ]
// Z dimension (multiples of 7mm)
height = 3; //0.1
// Fill in solid block (overrides all following options)
filled_in = "off"; //["off","on","notstackable"]
// Include overhang for labeling (and specify left/right/center justification)
label = "disabled"; // ["disabled", "left", "right", "center", "leftchamber", "rightchamber", "centerchamber"]
// Width of the label in number of units, or zero means full width
label_width = 0;  // .01
// Wall thickness (Zack's design is 0.95)
wall_thickness = 0.95;  // .01
// Remove some or all of lip
lip_style = "normal";  // [ "normal", "reduced", "none" ]
position="default"; //["default","center","zero"]

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
// (Zack's design uses depth of 6)
screw_depth = 0;
center_magnet_diameter =0;
center_magnet_thickness = 0;
// Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = false;
// Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// Efficient floor option saves material and time, but the internal floor is not flat (only applies if no magnets, screws, or finger-slide used)
efficient_floor = false;
// Enable to subdivide bottom pads to allow half-cell offsets
half_pitch = false;
// Removes the internal grid from base the shape
flat_base = false;
// Remove floor to create a veritcal spacer
spacer = false;
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
wallpattern_style = "grid"; //["grid", "hexgrid", "voronoi"]
// Spacing between pattern
wallpattern_hole_spacing = 2; //0.1
// wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1]; 
// Add the pattern to the dividers
wallpattern_dividers_enabled=false; 
//Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:Hex, 64:circle]
//Size of the hole
wallpattern_hole_size = 5; //0.1
// pattern fill mode
wallpattern_fill = "none"; //["none", "space", "crop", "crophorizontal", "cropvertical", "crophorizontal_spacevertical", "cropvertical_spacehorizontal", "spacevertical", "spacehorizontal"]
wallpattern_voronoi_density_ratio = 50;
wallpattern_voronoi_radius = 0.5;

    
/* [Wall Cutout] */
wallcutout_enabled=false;
// wall to enable on, front, back, left, right.
wallcutout_walls=[1,0,0,0]; 
//default will be binwidth/2
wallcutout_width=0;
wallcutout_angle=70;
//default will be binHeight
wallcutout_height=0;
wallcutout_corner_radius=5;

/* [Extendable] */
extention_x_enabled = false;
extention_y_enabled = false;
extention_tabs_enabled = true;

/* [debug] */
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// enable loging of help messages during render.
help = false;
/*<!!end gridfinity_basic_cup!!>*/

module end_of_customizer_opts() {}

iitemx =0;
iitemy =1;
idepthneeded =2;
iitemHeight =3;
ishape =4;

// result is dimentions for commnly know items
//[x, y, z, item height, shape]
//x=width (diameter on round, flat to flat on hex)
//y=length (not used in round or hex)
//z=desired depth of hole
//item height=the hight object, not used.
//shape=the item shape, (circle, hex or square)
function LookupKnownItem(name="custom") = 
  name == "4hexshank" ? [4, 0, 10, 20, "hex"] :
  name == "1/4hexshank" ? [6.35, 0, 8, 15, "hex"] :
  name == "1/4hexlongshank" ? [6.35, 0, 15, 40, "hex"] :
  name == "5/16hexshank" ? [7.94, 0, 7, 0, "hex"] :
  name == "3/8hexshank" ? [9.52, 0, 10, 0, "hex"] :
  name == "aaaa" ? [8.3, 0, 10.625, 42.5, "round"] :
  name == "aaa" ? [10.5, 0, 11.125, 44.5, "round"] :
  name == "aa" ? [14.5, 0, 12.625, 50.5, "round"] :
  name == "c" ? [26.2, 0, 12.5, 50, "round"] :
  name == "d" ? [34.2, 0, 15.375, 61.5, "round"] :
  name == "7540" ? [7.5, 0, 10, 40, "round"] :    
  name == "8570" ? [8.5, 0, 17.5, 70, "round"] :  
  name == "10180" ? [10, 0, 4.5, 18, "round"] :   
  name == "10280" ? [10, 0, 7, 28, "round"] :     
  name == "10440" ? [10, 0, 11, 44, "round"] :    
  name == "10850" ? [10, 0, 21.25, 85, "round"] : 
  name == "13400" ? [13, 0, 10, 40, "round"] :    
  name == "14250" ? [14, 0, 6.25, 25, "round"] :  
  name == "14300" ? [14, 0, 7.5, 30, "round"] :   
  name == "14430" ? [14, 0, 10.75, 43, "round"] : 
  name == "14500" ? [14, 0, 13.25, 53, "round"] : 
  name == "14650" ? [14, 0, 16.25, 65, "round"] : 
  name == "15270" ? [15, 0, 6.75, 27, "round"] :  
  name == "16340" ? [16, 0, 8.5, 34, "round"] :   
  name == "16650" ? [16, 0, 16.25, 65, "round"] : 
  name == "17500" ? [17, 0, 12.5, 50, "round"] :  
  name == "17650" ? [17, 0, 16.25, 65, "round"] :
  name == "17670" ? [17, 0, 16.75, 67, "round"] :
  name == "18350" ? [18, 0, 8.75, 35, "round"] :
  name == "18490" ? [18, 0, 12.25, 49, "round"] :
  name == "18500" ? [18, 0, 12.5, 50, "round"] :
  name == "18650" ? [18, 0, 16.25, 65, "round"] :
  name == "20700" ? [20, 0, 17.5, 70, "round"] :
  name == "21700" ? [21, 0, 17.5, 70, "round"] :
  name == "25500" ? [25, 0, 12.5, 50, "round"] :
  name == "26500" ? [26, 0, 12.5, 50, "round"] :
  name == "26650" ? [26, 0, 16.25, 65, "round"] :
  name == "26700" ? [26, 0, 17.5, 70, "round"] :
  name == "26800" ? [26, 0, 20, 80, "round"] :
  name == "32600" ? [32, 0, 15, 60, "round"] :
  name == "32650" ? [32, 0, 16.925, 67.7, "round"] :
  name == "32700" ? [32, 0, 17.5, 70, "round"] :
  name == "38120" ? [38, 0, 30, 120, "round"] :
  name == "38140" ? [38, 0, 35, 140, "round"] :
  name == "40152" ? [40, 0, 38, 152, "round"] :
  name == "4680" ? [46, 0, 20, 80, "round"] :
  [0,0,0,0,""];

 // result is dimentions for commnly know items
//[width, thickness, depthneeded, itemHeight, shape]
function LookupKnownCard(name="custom") = 
  name == "multicard" ? [0, 0, 0, 0, "square"] :
  name == "compactflashi" ? [43, 3.3, 9, 36, "square"] :
  name == "compactflashii" ? [43, 5, 9, 36, "square"] :
  name == "smartmedia" ? [37, 0.76, 11.25, 45, "square"] :
  name == "mmc" ? [24, 1.4, 8, 32, "square"] :
  name == "mmcmobile" ? [24, 1.4, 4.5, 18, "square"] :
  name == "mmcmicro" ? [14, 1.1, 3, 12, "square"] :
  name == "sd" ? [24, 2.1, 18, 32, "square"] :
  name == "minisd" ? [20, 1.4, 10, 21.5, "square"] :
  name == "microsd" ? [11, 0.7, 9, 15, "square"] :
  name == "memorystickstandard" ? [21.5, 2.8, 12.5, 50, "square"] :
  name == "memorystickduo" ? [20, 1.6, 7.75, 31, "square"] :
  name == "memorystickmicro" ? [12.5, 1.2, 3.75, 15, "square"] :
  name == "nano" ? [12.3, 0.7, 2.2, 8.8, "square"] :
  name == "psvita" ? [15, 1.6, 3.125, 12.5, "square"] :
  name == "xqd" ? [38.5, 3.8, 7.45, 29.8, "square"] :
  name == "xD" ? [25, 1.78, 5, 20, "square"] :
  name == "USBA" ? [12, 4.5, 13, 13, "square"] :
  name == "USBC" ? [8.5, 4, 10, 0, "square"] :
  [0,0,0,0,""];

//[width, thickness, depthneeded, itemHeight, shape]
function LookupKnownCartridge(name="custom") = 
  name == "atari800" ? [68, 21, 19.25, 77, "square"] :
  name == "atari2600" ? [81, 19, 21.75, 87, "square"] :
  name == "atari5200" ? [104, 20, 28, 112, "square"] :
  name == "atari7800" ? [81, 19, 21.75, 87, "square"] :
  name == "commodore" ? [79, 17, 34.75, 139, "square"] :
  name == "magnavoxodyssey" ? [100, 5.5, 15, 60, "square"] :
  name == "magnavoxodysseymulticard" ? [105, 15, 27.5, 110, "square"] :
  name == "magnavoxodyssey2" ? [80, 21, 31.75, 127, "square"] :
  name == "mattelintellivision" ? [68, 16, 22, 88, "square"] :
  name == "nintendofamicom" ? [71, 17, 27, 108, "square"] :
  name == "nintendofamicomdisk" ? [76, 4, 22.5, 90, "square"] :
  name == "nintendosuperfamicom" ? [127, 20, 21.5, 86, "square"] :
  name == "nes" ? [120, 17, 33.5, 134, "square"] :
  name == "snes" ? [136, 20, 21.925, 87.7, "square"] :
  name == "nintendo64" ? [116, 18, 18.75, 75, "square"] :
  name == "nintendogb" ? [57, 7.5, 16.375, 65.5, "square"] :
  name == "nintendogbc" ? [57, 9, 16.375, 65.5, "square"] :
  name == "nintendogba" ? [35, 6, 14.25, 57, "square"] :
  name == "nintendods" ? [33, 3.8, 8.75, 35, "square"] :
  name == "nintendo2ds" ? [35, 3.8, 8.75, 35, "square"] :
  name == "nintendovb" ? [75, 7, 17, 68, "square"] :
  name == "nintendoswitch" ? [21, 3, 7.75, 31, "square"] :
  name == "segagamegear" ? [66, 10, 17, 68, "square"] :
  name == "segagenesis" ? [118, 15, 17, 68, "square"] :
  name == "segagenesistall" ? [96, 16, 22, 88, "square"] :
  name == "segamegadrive" ? [93, 17, 16.75, 67, "square"] :
  name == "segamegadrivecodemasters" ? [109, 17, 18.75, 75, "square"] :
  name == "segamastersystem" ? [69, 17, 27, 108, "square"] :
  name == "sega32x" ? [72, 16, 27.75, 111, "square"] :
  name == "segacard" ? [84, 2, 13.25, 53, "square"] :
  name == "segapico" ? [181, 15, 55.75, 223, "square"] :
  name == "sonyumd" ? [64, 0, 1.05, 4.2, "round"] :
  name == "sonypsvita" ? [22, 2, 7.5, 30, "square"] :
  name == "sonypsvitamemcard" ? [12.5, 1.6, 3.75, 15, "square"] :
  name == "necpcehucard" ? [53, 2, 21, 84, "square"] :
  name == "snkneogeoaes" ? [146.05, 31.75, 47.625, 190.5, "square"] :
  name == "snkneogeomvs" ? [145, 35, 46.25, 185, "square"] :
  name == "bandai" ? [41, 6, 16.5, 66, "square"] :
  name == "msx" ? [109, 16.8, 17.35, 69.4, "square"] :
  [0,0,0,0,""];
  
function LookupKnownShapes(name="round") = 
  name == "square" ? 4 :
  name == "hex" ? 6 : 64;
  
function LookupKnown(knowItem) = let(
      knownCard = LookupKnownCard(knowItem),
      knownCartridge = LookupKnownCartridge(knowItem),
      knownItem = LookupKnownItem(knowItem)
    ) knownCard[4] != "" ? knownCard 
      : knownCartridge[4] != "" ? knownCartridge
      : knownItem;
function addClearance(dim, clearance) =
    [dim.x > 0 ? dim.x+clearance : 0
    ,dim.y > 0 ? dim.y+clearance : 0
    ,dim.z];

//TODO for the hose size its not correct due to loss in the number of faces.
//E.G a 10mm circle cant contain a 10mm hex
//This also throws off the calculated spacing.
module itemholder(
  num_x = 1,
  num_y = 2,
  num_z, 
  knowItem = "custom",
  multiCards = "sd,USBA,microsd",
  multiCardCompact = 0,
  gridStyle = "auto",
  sides = 4,
  holeSize = 10,
  holeDepth = 5, 
  holeChamfer = 1,
  holeClearance = 0.65,
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
  item = LookupKnown(knowItem);
  mc = split(multiCards, ";");
  
  longCenter = addClearance(LookupKnown(mc[0]), holeClearance);
  smallCenter = addClearance(LookupKnown(mc[1]), holeClearance);
  side = addClearance(LookupKnown(mc[2]), holeClearance);
  
  _multiCardCompact = (knowItem == "multicard" && multiCardCompact > 0 ? side.x * (1 - min(multiCardCompact/2 + 0.5 ,1)) : 0);
  
  _sides = knowItem == "multicard" ? 4
    : item[4] == "" ? sides : LookupKnownShapes(item[4]);
  _holeSize = knowItem == "multicard" ? [max(longCenter.x,smallCenter.x), max(longCenter.y, smallCenter.y, side.x -_multiCardCompact)]
    : item[4] != "square" ?
    let(s = (item[0] == 0 ? holeSize : item[0])+holeClearance) [s, s]
    : [item[0],item[1]];
    
  _depth= let( 
    itemDepth = knowItem == "multicard" ? max(longCenter.z, smallCenter.z, side.z) : item.z,
    desiredDepth=(holeDepth > 0 ? holeDepth : itemDepth))
      desiredDepth > floorThickness ? floorThickness : desiredDepth;

  xSize = (num_x*gf_pitch-(compartments.x+1)*compartment_spacing)/compartments.x;
  xStep = xSize + compartment_spacing;
  ySize = (num_y*gf_pitch-(compartments.y+1)*compartment_spacing)/compartments.y - _multiCardCompact;
  yStep = ySize + compartment_spacing;
  
  for(x =[0:1:compartments.x-1])
  {
    for(y =[0:1:compartments.y-1])
    {
      translate(compartment_centered 
        ? [compartment_spacing+x*xStep+(xSize-gf_pitch)/2, compartment_spacing+y*yStep+(ySize-gf_pitch)/2, floorThickness-_depth]
        : [compartment_spacing+x*xStep-gf_pitch/2, compartment_spacing+y*yStep-gf_pitch/2, floorThickness-_depth])
        GridItemHolder(
          canvisSize = [xSize,ySize],
          hexGrid= gridStyle == "square" ? false : gridStyle == "hex" ? true : gridStyle,
          customShape = item[4] == "square",
          circleFn = _sides,
          holeSize = _holeSize,
          holeSpacing = [holeSpacing,holeSpacing],
          holeGrid = holeGrid,
          holeHeight = _depth+fudgeFactor,
          holeChamfer = holeChamfer,
          center=compartment_centered,
          fill=compartment_fill,
          help=help)
          union(){
            if(knowItem=="multicard")
            {
              multiCard(
                longCenter, smallCenter, side, 
                chamfer = holeChamfer,
                alternate = _multiCardCompact > 0 && (($idx.y % 2) != $idx.x % 2));
            }else if(item[4] == "square") {
              slotCutout([_holeSize.x, _holeSize.y, _depth+fudgeFactor], chamfer=holeChamfer);
            }
          }
    }
  }
  
  HelpTxt("itemholder",[
    "num_x",num_x
    ,"num_y",num_y
    ,"num_z",num_z
    ,"knowItem",knowItem
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

// Generates the gridfinity bin with cutouts.
// Runs the function without needing to pass the variables.
module gridfinity_itemholder(
  //itemholder settings
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
  itemholder_known_item = itemholder_known_item != "custom" ? itemholder_known_item  
      : itemholder_known_cards != "custom"? itemholder_known_cards
      : itemholder_known_cartridges, 
      
    //gridfinity settings
    width = width,
    depth = depth,
    height = height,
    position=position,
    filled_in = filled_in,
    label=label,
    label_width=label_width,
    wall_thickness=wall_thickness,
    lip_style=lip_style,
    chamber_wall_thickness = chamber_wall_thickness,
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
    magnet_diameter=magnet_diameter,
    screw_depth=screw_depth,
    center_magnet_diameter=center_magnet_diameter,
    center_magnet_thickness=center_magnet_thickness,
    hole_overhang_remedy=hole_overhang_remedy,
    box_corner_attachments_only=box_corner_attachments_only,
    floor_thickness=floor_thickness,
    cavity_floor_radius=cavity_floor_radius,
    efficient_floor=efficient_floor,
    half_pitch=half_pitch,
    flat_base=flat_base,
    spacer=spacer,
    fingerslide=fingerslide,
    fingerslide_radius=fingerslide_radius,
    tapered_corner=tapered_corner,
    tapered_corner_size=tapered_corner_size,
    tapered_setback=tapered_setback,
    wallcutout_enabled=wallcutout_enabled,
    wallcutout_walls=wallcutout_walls,
    wallcutout_width=wallcutout_width,
    wallcutout_angle=wallcutout_angle,
    wallcutout_height=wallcutout_height,
    wallcutout_corner_radius=wallcutout_corner_radius,
    wallpattern_enabled=wallpattern_enabled,
    wallpattern_style=wallpattern_style,
    wallpattern_walls=wallpattern_walls,
    wallpattern_dividers_enabled=wallpattern_dividers_enabled,
    wallpattern_fill=wallpattern_fill,
    wallpattern_hole_sides=wallpattern_hole_sides,
    wallpattern_hole_size=wallpattern_hole_size,
    wallpattern_hole_spacing=wallpattern_hole_spacing,
    wallpattern_voronoi_density_ratio=wallpattern_voronoi_density_ratio,
    wallpattern_voronoi_radius=wallpattern_voronoi_radius,
    extention_enabled = [extention_x_enabled, extention_y_enabled],
    extention_tabs_enabled = extention_tabs_enabled,
    cutx=cutx,
    cuty=cuty,
  help=help) {
  
  difference() {
    //calcualte height if needed.
   knowItemDepth = itemholder_known_item == "multicard" ? 
    let (
      mc = split(itemholder_multi_cards, ";"), 
      longCenter = LookupKnown(mc[0]),
      smallCenter = LookupKnown(mc[1]),
      side = LookupKnown(mc[2])) max(longCenter.z,smallCenter.z,side.z)
    : let( item = LookupKnown(itemholder_known_item)) item.z;
   
    itemholder_hole_depth=(itemholder_hole_depth > 0 ? itemholder_hole_depth : knowItemDepth);
    
    // min floor height
    bch = cupBaseClearanceHeight(magnet_diameter, screw_depth);
    mfh = calculateMinFloorHeight(magnet_diameter, screw_depth);
    
    //calculate the bin height. This math is not right
    height = !itemholder_auto_bin_height ? height
        : itemholder_hole_depth <=0 ? height
        : filled_in == "notstackable" ? (mfh+itemholder_hole_depth)/gf_zpitch
        : filled_in == "on" ? ceil((mfh+itemholder_hole_depth)/gf_zpitch)
        : ceil((mfh+itemholder_hole_depth)/gf_zpitch);

    // calculate floor thickness
    ft = calculateFloorThickness(magnet_diameter, screw_depth, itemholder_hole_depth+gf_cup_floor_thickness, height, filled_in);  
      
    itemZpos = filled_in == "notstackable" ? mfh+itemholder_hole_depth
        : filled_in == "on" ? height*gf_zpitch
        : mfh+itemholder_hole_depth;
      
    /*<!!start gridfinity_basic_cup!!>*/
    sepPositions = [];
    
    irregular_cup(
    num_x=width, num_y=depth, num_z=height,
    position=position,
    filled_in=filled_in,
    label_style=label,
    labelWidth=label_width,
    fingerslide=fingerslide,
    fingerslide_radius=fingerslide_radius,
    magnet_diameter=magnet_diameter,
    screw_depth=screw_depth,
    center_magnet_diameter=center_magnet_diameter,
    center_magnet_thickness=center_magnet_thickness,
    floor_thickness=ft,
    cavity_floor_radius=cavity_floor_radius,
    wall_thickness=wall_thickness,
    hole_overhang_remedy=hole_overhang_remedy,
    efficient_floor=efficient_floor,
    chamber_wall_thickness=chamber_wall_thickness,
    vertical_separator_bend_position=vertical_separator_bend_position,
    vertical_separator_bend_angle=vertical_separator_bend_angle,
    vertical_separator_bend_separation=vertical_separator_bend_separation,
    vertical_separator_cut_depth=vertical_separator_cut_depth,
    vertical_separator_positions=vertical_irregular_subdivisions 
      ? vertical_separator_config 
      : splitChamber(vertical_chambers-1, width),
    horizontal_separator_bend_position=horizontal_separator_bend_position,
    horizontal_separator_bend_angle=horizontal_separator_bend_angle,
    horizontal_separator_bend_separation=horizontal_separator_bend_separation,
    horizontal_separator_cut_depth=horizontal_separator_cut_depth,
    horizontal_separator_positions=horizontal_irregular_subdivisions 
      ? horizontal_separator_config 
      : splitChamber(horizontal_chambers-1, depth),
    half_pitch=half_pitch,
    lip_style=lip_style,
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
    wallpattern_voronoi_density_ratio=wallpattern_voronoi_density_ratio,
    wallpattern_voronoi_radius=wallpattern_voronoi_radius,
    wallcutout_enabled=wallcutout_enabled,
    wallcutout_walls=wallcutout_walls,
    wallcutout_width=wallcutout_width,
    wallcutout_angle=wallcutout_angle,
    wallcutout_height=wallcutout_height,
    wallcutout_corner_radius=wallcutout_corner_radius,
    extention_enabled = extention_enabled,
    extention_tabs_enabled = extention_tabs_enabled,
    cutx=cutx,
    cuty=cuty,
    help = help);
    /*<!!end gridfinity_basic_cup!!>*/

    color(color_extention)
    translate([0,0,bch])
    itemholder(
      num_x=width, num_y=depth, num_z=height,
      knowItem = itemholder_known_item,
      multiCards = itemholder_multi_cards,
      multiCardCompact = itemholder_multi_card_compact,
      gridStyle = itemholder_grid_style,
      sides = itemholder_hole_sides,
      holeSize = itemholder_hole_size,
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
}

gridfinity_itemholder();
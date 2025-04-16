iitemDiameter= 0;
iitemx = 1;
iitemy = 2;
idepthneeded = 3;
iitemHeight = 4;
ishape = 5;

function LookupKnownShapes(name="round", default_sides=64) = 
  name == "square" || name == "halfround" || name == "multicard" ? 4 :
  name == "hex" ? 6 : 
  name == "round" ? 64 :
  default_sides;
  
// result is dimensions for commonly know items
//[diameter, x, y, z, item height, shape]
//x=diameter on round, flat to flat on hex, corner diameter in square.
//x=width for square
//y=length for square
//z=desired depth of hole
//item height=the hight object, not used currently.
//shape=the item shape, (circle, hex, halfround or square)
//[diameter, width, thickness, depthneeded, itemHeight, shape]
function LookupKnownTool(name="custom") = 
  name == "4hexshank" ? [4, 0, 0, 5, 20, "hex"] :
  name == "1/4hexshank" ? [6.35, 0, 0, 8, 15, "hex"] :
  name == "1/4hexshanklong" ? [6.35, 0, 0, 15, 40, "hex"] :
  name == "5/16hexshank" ? [7.94, 0, 0, 7, 0, "hex"] :
  name == "3/8hexshank" ? [9.52, 0, 0, 10, 0, "hex"] :
  name == "1/2shank" ? [12.7, 0, 0, 20, 50, "round"] :
  name == "12shank" ? [12, 0, 0, 20, 50, "round"] :
  name == "10shank" ? [10, 0, 0, 20, 50, "round"] :
  name == "3/8shank" ? [9.525, 0, 0, 20, 50, "round"] :
  name == "8shank" ? [8, 0, 0, 20, 50, "round"] :
  name == "1/4shank" ? [6.35, 0, 0, 20, 50, "round"] :
  name == "6shank" ? [6, 0, 0, 15, 40, "round"] :
  name == "1/8shank" ? [3.2, 0, 0, 15, 40, "round"] :
  [0,0,0,0,0,"","LookupKnownTool"];

//[diameter, width, thickness, depthneeded, itemHeight, shape]
function LookupKnownBattery(name="custom") = 
  name == "aaaa" ? [8.3, 0, 0, 10.625, 42.5, "round"] :
  name == "aaa" ? [10.5, 0, 0, 11.125, 44.5, "round"] :
  name == "aa" ? [14.5, 0, 0, 12.625, 50.5, "round"] :
  name == "9v" ? [1, 17.5, 26.5, 12.5, 48.5, "square"] :
  name == "c" ? [26.2, 0, 0, 12.5, 50, "round"] :
  name == "d" ? [34.2, 0, 0, 15.375, 61.5, "round"] :
  name == "7540cell" ? [7.5, 0, 0, 10, 40, "round"] :
  name == "8570cell" ? [8.5, 0, 0, 17.5, 70, "round"] :
  name == "10180cell" ? [10, 0, 0, 4.5, 18, "round"] :
  name == "10280cell" ? [10, 0, 0, 7, 28, "round"] :
  name == "10440cell" ? [10, 0, 0, 11, 44, "round"] :
  name == "10850cell" ? [10, 0, 0, 21.25, 85, "round"] :
  name == "13400cell" ? [13, 0, 0, 10, 40, "round"] :
  name == "14250cell" ? [14, 0, 0, 6.25, 25, "round"] :
  name == "14300cell" ? [14, 0, 0, 7.5, 30, "round"] :
  name == "14430cell" ? [14, 0, 0, 10.75, 43, "round"] :
  name == "14500cell" ? [14, 0, 0, 13.25, 53, "round"] :
  name == "14650cell" ? [14, 0, 0, 16.25, 65, "round"] :
  name == "15270cell" ? [15, 0, 0, 6.75, 27, "round"] :
  name == "16340cell" ? [16, 0, 0, 8.5, 34, "round"] :
  name == "16650cell" ? [16, 0, 0, 16.25, 65, "round"] :
  name == "17500cell" ? [17, 0, 0, 12.5, 50, "round"] :
  name == "17650cell" ? [17, 0, 0, 16.25, 65, "round"] :
  name == "17670cell" ? [17, 0, 0, 16.75, 67, "round"] :
  name == "18350cell" ? [18, 0, 0, 8.75, 35, "round"] :
  name == "18490cell" ? [18, 0, 0, 12.25, 49, "round"] :
  name == "18500cell" ? [18, 0, 0, 12.5, 50, "round"] :
  name == "18650cell" ? [18, 0, 0, 16.25, 65, "round"] :
  name == "20700cell" ? [20, 0, 0, 17.5, 70, "round"] :
  name == "21700cell" ? [21, 0, 0, 17.5, 70, "round"] :
  name == "25500cell" ? [25, 0, 0, 12.5, 50, "round"] :
  name == "26500cell" ? [26, 0, 0, 12.5, 50, "round"] :
  name == "26650cell" ? [26, 0, 0, 16.25, 65, "round"] :
  name == "26700cell" ? [26, 0, 0, 17.5, 70, "round"] :
  name == "26800cell" ? [26, 0, 0, 20, 80, "round"] :
  name == "32600cell" ? [32, 0, 0, 15, 60, "round"] :
  name == "32650cell" ? [32, 0, 0, 16.925, 67.7, "round"] :
  name == "32700cell" ? [32, 0, 0, 17.5, 70, "round"] :
  name == "38120cell" ? [38, 0, 0, 30, 120, "round"] :
  name == "38140cell" ? [38, 0, 0, 35, 140, "round"] :
  name == "40152cell" ? [40, 0, 0, 38, 152, "round"] :
  name == "4680cell" ? [46, 0, 0, 20, 80, "round"] :
  [0,0,0,0,0,"","LookupKnownBattery"];

//[diameter, width, thickness, depthneeded, itemHeight, shape]
function LookupKnownCellBattery(name="custom") = 
  name == "cr927" ? [0, 9.5, 2.7, 0, 0, "halfround"] :
  name == "cr1025" ? [0, 10, 2.5, 0, 0, "halfround"] :
  name == "cr1130" ? [0, 11.5, 3, 0, 0, "halfround"] :
  name == "cr1216" ? [0, 12.5, 1.6, 0, 0, "halfround"] :
  name == "cr1220" ? [0, 12.5, 2, 0, 0, "halfround"] :
  name == "cr1225" ? [0, 12.5, 2.5, 0, 0, "halfround"] :
  name == "cr1616" ? [0, 16, 1.6, 0, 0, "halfround"] :
  name == "cr1620" ? [0, 16, 2, 0, 0, "halfround"] :
  name == "cr1632" ? [0, 16, 3.2, 0, 0, "halfround"] :
  name == "cr2012" ? [0, 20, 1.2, 0, 0, "halfround"] :
  name == "cr2016" ? [0, 20, 1.6, 0, 0, "halfround"] :
  name == "cr2020" ? [0, 20, 2, 0, 0, "halfround"] :
  name == "cr2025" ? [0, 20, 2.5, 0, 0, "halfround"] :
  name == "cr2032" ? [0, 20, 3.2, 0, 0, "halfround"] :
  name == "cr2040" ? [0, 20, 4, 0, 0, "halfround"] :
  name == "cr2050" ? [0, 20, 5, 0, 0, "halfround"] :
  name == "cr2320" ? [0, 23, 2, 0, 0, "halfround"] :
  name == "cr2325" ? [0, 23, 2.5, 0, 0, "halfround"] :
  name == "cr2330" ? [0, 23, 3, 0, 0, "halfround"] :
  name == "br2335" ? [0, 23, 3.5, 0, 0, "halfround"] :
  name == "cr2354" ? [0, 23, 5.4, 0, 0, "halfround"] :
  name == "cr2412" ? [0, 24.5, 1.2, 0, 0, "halfround"] :
  name == "cr2430" ? [0, 24.5, 3, 0, 0, "halfround"] :
  name == "cr2450" ? [0, 24.5, 5, 0, 0, "halfround"] :
  name == "cr2477" ? [0, 24.5, 7.7, 0, 0, "halfround"] :
  name == "cr3032" ? [0, 30, 3.2, 0, 0, "halfround"] :
  name == "cr11108" ? [0, 11.6, 10.8, 0, 0, "halfround"] :
  [0,0,0,0,0,"","LookupKnownCellBattery"];
  
//[diameter, width, thickness, depthneeded, itemHeight, shape]
function LookupKnownCard(name="custom") = 
  name == "multicard" ? [0, 0, 0, 0, 0, "multicard"] :
  name == "compactflashi" ? [0, 43, 3.3, 9, 36, "square"] :
  name == "compactflashii" ? [0, 43, 5, 9, 36, "square"] :
  name == "smartmedia" ? [0, 37, 0.76, 11.25, 45, "square"] :
  name == "mmc" ? [0, 24, 1.4, 8, 32, "square"] :
  name == "mmcmobile" ? [0, 24, 1.4, 4.5, 18, "square"] :
  name == "mmcmicro" ? [0, 14, 1.1, 3, 12, "square"] :
  name == "sd" ? [0, 24, 2.1, 18, 32, "square"] :
  name == "minisd" ? [0, 20, 1.4, 10, 21.5, "square"] :
  name == "microsd" ? [0, 11, 0.7, 9, 15, "square"] :
  name == "memorystickstandard" ? [0, 21.5, 2.8, 12.5, 50, "square"] :
  name == "memorystickduo" ? [0, 20, 1.6, 7.75, 31, "square"] :
  name == "memorystickmicro" ? [0, 12.5, 1.2, 3.75, 15, "square"] :
  name == "nano" ? [0, 12.3, 0.7, 2.2, 8.8, "square"] :
  name == "psvita" ? [0, 15, 1.6, 3.125, 12.5, "square"] :
  name == "xqd" ? [0, 38.5, 3.8, 7.45, 29.8, "square"] :
  name == "xD" ? [0, 25, 1.78, 5, 20, "square"] :
  name == "usba" ? [0, 12, 4.5, 13, 13, "square"] :
  name == "usbc" ? [0, 8.5, 4, 10, 0, "square"] :
  [0,0,0,0,0,"","LookupKnownCard"];

//[diameter, width, thickness, depthneeded, itemHeight, shape]
function LookupKnownCartridge(name="custom") = 
  name == "atari800" ? [0, 68, 21, 19.25, 77, "square"] :
  name == "atari2600" ? [0, 81, 19, 21.75, 87, "square"] :
  name == "atari5200" ? [0, 104, 20, 28, 112, "square"] :
  name == "atari7800" ? [0, 81, 19, 21.75, 87, "square"] :
  name == "commodore" ? [0, 79, 17, 34.75, 139, "square"] :
  name == "magnavoxodyssey" ? [0, 100, 5.5, 15, 60, "square"] :
  name == "magnavoxodysseymulticard" ? [0, 105, 15, 27.5, 110, "square"] :
  name == "magnavoxodyssey2" ? [0, 80, 21, 31.75, 127, "square"] :
  name == "mattelintellivision" ? [0, 68, 16, 22, 88, "square"] :
  name == "nintendofamicom" ? [0, 71, 17, 27, 108, "square"] :
  name == "nintendofamicomdisk" ? [0, 76, 4, 22.5, 90, "square"] :
  name == "nintendosuperfamicom" ? [0, 127, 20, 21.5, 86, "square"] :
  name == "nes" ? [0, 120, 17, 33.5, 134, "square"] :
  name == "snes" ? [0, 136, 20, 21.925, 87.7, "square"] :
  name == "nintendo64" ? [0, 116, 18, 18.75, 75, "square"] :
  name == "nintendogb" ? [0, 57, 7.5, 16.375, 65.5, "square"] :
  name == "nintendogbc" ? [0, 57, 9, 16.375, 65.5, "square"] :
  name == "nintendogba" ? [0, 35, 6, 14.25, 57, "square"] :
  name == "nintendods" ? [0, 33, 3.8, 8.75, 35, "square"] :
  name == "nintendo2ds" ? [0, 35, 3.8, 8.75, 35, "square"] :
  name == "nintendovb" ? [0, 75, 7, 17, 68, "square"] :
  name == "nintendoswitch" ? [0, 21, 3, 7.75, 31, "square"] :
  name == "segagamegear" ? [0, 66, 10, 17, 68, "square"] :
  name == "segagenesis" ? [0, 118, 15, 17, 68, "square"] :
  name == "segagenesistall" ? [0, 96, 16, 22, 88, "square"] :
  name == "segamegadrive" ? [0, 93, 17, 16.75, 67, "square"] :
  name == "segamegadrivecodemasters" ? [0, 109, 17, 18.75, 75, "square"] :
  name == "segamastersystem" ? [0, 69, 17, 27, 108, "square"] :
  name == "sega32x" ? [0, 72, 16, 27.75, 111, "square"] :
  name == "segacard" ? [0, 84, 2, 13.25, 53, "square"] :
  name == "segapico" ? [0, 181, 15, 55.75, 223, "square"] :
  name == "sonyumd" ? [0, 64, 0, 1.05, 4.2, "round"] :
  name == "sonypsvita" ? [0, 22, 2, 7.5, 30, "square"] :
  name == "sonypsvitamemcard" ? [0, 12.5, 1.6, 3.75, 15, "square"] :
  name == "necpcehucard" ? [0, 53, 2, 21, 84, "square"] :
  name == "snkneogeoaes" ? [0, 146.05, 31.75, 47.625, 190.5, "square"] :
  name == "snkneogeomvs" ? [0, 145, 35, 46.25, 185, "square"] :
  name == "bandai" ? [0, 41, 6, 16.5, 66, "square"] :
  name == "msx" ? [0, 109, 16.8, 17.35, 69.4, "square"] :
  [0,0,0,0,0,"","LookupKnownCartridge"];
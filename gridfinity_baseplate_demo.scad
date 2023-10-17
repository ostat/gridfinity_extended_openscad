// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <gridfinity_baseplate.scad>

scenario = "baseplate"; //["baseplate","magnet","weighted", "lid","lid_flat_base","lid_half_pitch","customsize"]

$vpr = [60,0,320];
//$vpr = [240,0,40];
$vpt = [32,13,16]; //shows translation (i.e. won't be affected by rotate and zoom)
$vpf = 25; //shows the FOV (Field of View) of the view [Note: Requires version 2021.01]
$vpd = 300;//shows the camera distance [Note: Requires version 2015.03]   

xpos1 = [3,4,0,0,0,0,0];
xpos2 = [2,2,0,5,0,0,0];
xpos3 = [6,2,2,2,0,0,0];
xpos4 = [0,6,2,2,0,0,0];
xpos5 = [0,0,6,10,0,0,0];
xpos6 = [0,0,0,0,0,0,0];
xpos7 = [0,0,0,0,0,0,0];
    
//[name,rotate,cuty,[plateStyle,plateOptions,lidOptions,customGridEnabled]]
options = 
  scenario == "baseplate" ? [
      ["Base Plate",false, false,["base","default","",false]]]
  : scenario == "magnet" ? [
      ["Magnet",false, false,["base","magnet","",false]],
      ["Magnet",false, true,["base","magnet","",false]],
      ["Magnet bottom",true, false,["base","magnet","",false]],
      ["Magnet bottom",true, true,["base","magnet","",false]]]
   : scenario == "weighted" ? [
      ["Weighted",false, false,["base","weighted","",false]],
      ["Weighted",false, true,["base","weighted","",false]],
      ["Weighted bottom",true, false,["base","weighted","",false]],
      ["Weighted bottom",true, true,["base","weighted","",false]]]
   : scenario == "lid" ? [
      ["Lid",false, false,["lid","","default",false]],
      ["Lid",false, true,["lid","","default",false]],
      ["Lid bottom",true, false,["lid","","default",false]],
      ["Lid bottom",true, true,["lid","","default",false]]]    
   : scenario == "lid_flat_base" ? [
      ["Lid flat base",false, false,["lid","","flat",false]],
      ["Lid flat base",false, true,["lid","","flat",false]],
      ["Lid flat base bottom",true, false,["lid","","flat",false]],
      ["Lid flat base bottom",true, true,["lid","","flat",false]]]  
   : scenario == "lid_half_pitch" ? [
      ["Lid half pitch",false, false,["lid","","halfpitch",false]],
      ["Lid half pitch",false, true,["lid","","halfpitch",false]],
      ["Lid half pitch bottom",true, false,["lid","","halfpitch",false]],
      ["Lid half pitch bottom",true, true,["lid","","halfpitch",false]]]
   : scenario == "customsize" ? [
      ["Custom Size Base",false, false,["base","default","",true]],      
      ["Custom Size Magnet",false, false,["base","magnet","",true]],
      ["Custom Size Weighted",false, false,["base","weighted","",true]]]
      : [];
animation = len(options) >= round($t*(len(options))) ? options[round($t*(len(options)))] : options[0];

echo(time=$t*(len(options)), options = len(options), t=$t, animation=animation);

color("GhostWhite")
//translate(flipped ? [-60,40,35] : [0,-30,0])
translate([0,-20,-20])
rotate($vpr)
 linear_extrude(height = 0.1)
 text(animation[0], size=5,);

//translate(animation[1] ? [0,gridfinity_pitch,0] : [0,0,0])
rotate(animation[1] ? [180,0,0] : [0,0,0]) 
translate(animation[1] ? [0,-gridfinity_pitch,0] : [0,0,0])
gridfinity_baseplate(
  width = 3,
  depth = 2,
  plateStyle = animation[3][0],
  plateOptions = animation[3][1],
  lidOptions = animation[3][2],
  customGridEnabled = animation[3][3],
  gridPossitions=[xpos1,xpos2,xpos3,xpos4,xpos5,xpos6,xpos7],
  cutx = false,
  cuty = animation[2]);
  

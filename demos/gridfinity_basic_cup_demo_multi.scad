use <gridfinity_basic_cup_demo.scad>
include <../modules/gridfinity_constants.scad>

//Demo scenario. You need to manually set to the steps to match the scenario options, and the FPS to 1
scenario = "demo"; //["demo","basiccup","position","chambers","label", "halfpitch", "lip_style","fingerslide","basecorner","sequentialbridging","wallpattern","wallcutout","taperedcorner","floorthickness","filledin","efficient_floor","box_corner_attachments_only","center_magnet","flatbase"]
height = 5;
stepIndex = 0;
showtext = true;
space = [0.2,0.5];
//Include help info in the logs
help=false;
setViewPort=true;

color("GhostWhite")
gridfinity_basic_cup_demo(
  scenario = "demo",
  height = 5,
  stepIndex = 1,
  showtext = false,
  help=false,
  setViewPort=false);
  
translate([gf_pitch*(3+space.x), 0, 0])
color("GhostWhite")
gridfinity_basic_cup_demo(
  scenario = "demo",
  height = 5,
  stepIndex = 0,
  showtext = false,
  help=false,
  setViewPort=false);
  
color("GhostWhite")
translate([gf_pitch*(3+space.x)*2, 0, 0])
gridfinity_basic_cup_demo(
  scenario = "demo",
  height = 5,
  stepIndex = 2,
  showtext = false,
  help=false,
  setViewPort=false);
  
color("GhostWhite")
translate([0, gf_pitch*(2+space.y), 0])
gridfinity_basic_cup_demo(
  scenario = "demo",
  height =8,
  stepIndex = 4,
  showtext = false,
  help=false,
  setViewPort=false);
  
color("GhostWhite")
translate([gf_pitch*(3+space.x), gf_pitch*(2+space.y), 0])
gridfinity_basic_cup_demo(
  scenario = "demo",
  height = 8,
  stepIndex = 5,
  showtext = false,
  help=false,
  setViewPort=false);
  
  
  color("GhostWhite")
translate([gf_pitch*(3+space.x)*2, gf_pitch*(2+space.y), 0])
gridfinity_basic_cup_demo(
  scenario = "demo",
  height = 8,
  stepIndex = 6,
  showtext = false,
  help=false,
  setViewPort=false);

@set OPENSCAD="C:\Program Files\OpenSCAD\openscad.exe"

rem basic cup with finger scoop
%OPENSCAD% gridfinity_basic_cup.scad -D width=2 -D depth=1 -D height=3 -o Images/basic_cup_2x1x3.png --view=axes,scales --projection=o --camera=19.20,1.91,15.44,64.80,0,231.5,263.43

rem basic cup with dividers and subdivisions into 5
%OPENSCAD% gridfinity_basic_cup.scad -D width=2 -D depth=1 -D height=3 -D chambers=5 -D fingerslide=true -D withLabel=true -o Images/divided_cup_2x1x3x5.png --view=axes,scales --projection=o --camera=20.33,3.70,17.31,57.10,0,22.7,292.71

rem basic cup with irregular subdivisions
%OPENSCAD% gridfinity_basic_cup.scad -D width=2 -D depth=1 -D height=3 -D irregular_subdivisions=true -D separator_positions=[0.25,0.5,1.4] -D withLabel=true -o Images/irregular_cup_2x1x3.png --view=axes,scales --projection=o --camera=19.31,5.79,3.29,48.7,0,15.2,263.43

rem half-width bin
%OPENSCAD% gridfinity_basic_cup.scad -D width=0.5 -D depth=2 -D height=4 -D fingerslide=true -D withLabel=true -o Images/basic_cup_halfx2x4.png --view=axes,scales --projection=o --camera=-13.56,3.63,30.18,50.1,0,339.3,237.09

rem show bottom hole print remedy
%OPENSCAD% gridfinity_basic_cup.scad -D width=1 -D depth=1 -D height=4 -D magnet_diameter=6.5 -D screw_depth=6 -o Images/overhang_remedy.png --view=axes,scales --projection=o --camera=-23.23,7.43,25.06,151.6,0,43,102.06

rem show material-efficient bottom
%OPENSCAD% gridfinity_basic_cup.scad -D width=3 -D depth=3 -D height=3 -D fingerslide=false -D efficient_floor=true -o Images/efficient_floor.png --view=axes,scales --projection=o --camera=23.48,47.07,3.45,54.3,0,73.8,495.7

rem frame baseplates:
%OPENSCAD% gridfinity_baseplate.scad -o images/frame_baseplate.png --view=axes,scales --projection=o --camera=23.48,47.07,3.45,54.3,0,73.8,495.7

rem weighted baseplate top and bottom
%OPENSCAD% gridfinity_baseplate.scad -D xsize=3 -D ysize=2 -D weighted=true -o images/weighted_baseplate_top.png --view=axes,scales --projection=o --camera=52.23,10.30,16.49,37.50,0,47.4,446.13
%OPENSCAD% gridfinity_baseplate.scad -D xsize=3 -D ysize=2 -D weighted=true -o images/weighted_baseplate_bottom.png --view=axes,scales --projection=o --camera=40.31,25.87,2.67,148.8,0,44.6,446.13

rem lid/baseplate combo
%OPENSCAD% gridfinity_baseplate.scad -D xsize=3 -D ysize=2 -D lid=true -o images/lid_baseplate_combo.png --view=axes,scales --projection=o --render --camera=38.04,24.18,3.69,60.60,0,47.4,446.13

pause
@set OPENSCAD="C:\Program Files\OpenSCAD\openscad.exe"
@set PYTHON="C:\Users\Vector\Anaconda3\python.exe"

%OPENSCAD% gridfinity_basic_cup.scad -D width=2 -D depth=1 -D height=2 -D chambers=1 -D fingerslide=true -o Renders/basic_cup_2x1x2.stl --export-format binstl
%PYTHON% canonicalize.py Renders/basic_cup_2x1x2.stl

%OPENSCAD% gridfinity_basic_cup.scad -D width=2 -D depth=1 -D height=2 -D chambers=5 -D fingerslide=true -o Renders/divided_cup_2x1x2x5.stl --export-format binstl
%PYTHON% canonicalize.py Renders/divided_cup_2x1x2x5.stl

%OPENSCAD% gridfinity_basic_cup.scad -D width=2 -D depth=1 -D height=3 -D chambers=5 -D fingerslide=true -D withLabel=true -o Renders/divided_cup_2x1x3x5.stl --export-format binstl
%PYTHON% canonicalize.py Renders/divided_cup_2x1x3x5.stl

%OPENSCAD% gridfinity_basic_cup.scad -D width=2 -D depth=1 -D height=3 -D filled_in=true -o Renders/filled_block_2x1x3x5.stl --export-format binstl
%PYTHON% canonicalize.py Renders/filled_block_2x1x3x5.stl

%OPENSCAD% gridfinity_basic_cup.scad -D width=0.5 -D depth=2 -D height=4 -D fingerslide=true -D withLabel=true -o Renders/basic_cup_halfx2x4.stl --export-format binstl
%PYTHON% canonicalize.py Renders/basic_cup_halfx2x4.stl

%OPENSCAD% gridfinity_basic_cup.scad -D width=1 -D depth=1 -D height=4 -D remove_lip=true -D fingerslide=true -o Renders/basic_cup_1x1x3_nolip.stl --export-format binstl
%PYTHON% canonicalize.py Renders/basic_cup_1x1x3_nolip.stl

%OPENSCAD% gridfinity_baseplate.scad -o Renders/baseplate.stl --export-format binstl
%PYTHON% canonicalize.py Renders/baseplate.stl

%OPENSCAD% gridfinity_baseplate.scad -D weighted=true -o Renders/weighted_baseplate.stl --export-format binstl
%PYTHON% canonicalize.py Renders/weighted_baseplate.stl

%OPENSCAD% gridfinity_baseplate.scad -D lid=true -o Renders/base_lid.stl --export-format binstl
%PYTHON% canonicalize.py Renders/base_lid.stl

%OPENSCAD% gridfinity_glue_stick.scad -o Renders/glue_stick_cup.stl --export-format binstl
%PYTHON% canonicalize.py Renders/glue_stick_cup.stl

%OPENSCAD% gridfinity_flsun_q5.scad -o Renders/flsun_q5.stl --export-format binstl
%PYTHON% canonicalize.py Renders/flsun_q5.stl

%OPENSCAD% gridfinity_socket_holder.scad -D part=1 -o Renders/socket_holder_metric.stl --export-format binstl
%PYTHON% canonicalize.py Renders/socket_holder_metric.stl

%OPENSCAD% gridfinity_socket_holder.scad -D part=2 -o Renders/socket_holder_imperial.stl --export-format binstl
%PYTHON% canonicalize.py Renders/socket_holder_imperial.stl

%OPENSCAD% gridfinity_socket_holder.scad -D part=3 -o Renders/socket_holder_imperial_small.stl --export-format binstl
%PYTHON% canonicalize.py Renders/socket_holder_imperial_small.stl

%OPENSCAD% gridfinity_socket_holder.scad -D part=4 -o Renders/socket_holder_imperial_big.stl --export-format binstl
%PYTHON% canonicalize.py Renders/socket_holder_imperial_big.stl

%OPENSCAD% gridfinity_socket_holder.scad -D part=5 -o Renders/socket_holder_metric_stacking.stl --export-format binstl
%PYTHON% canonicalize.py Renders/socket_holder_metric_stacking.stl

%OPENSCAD% gridfinity_socket_holder.scad -D part=6 -o Renders/socket_holder_metric_small.stl --export-format binstl
%PYTHON% canonicalize.py Renders/socket_holder_metric_small.stl

pause
@set OPENSCAD="C:\Program Files\OpenSCAD\openscad.exe"
@set PYTHON="C:\Users\Vector\Anaconda3\python.exe"

for %%p in (tile, pawn, knight, bishop, rook, queen, king) do (
%OPENSCAD% gridfinity_chess.scad -D "part=""%%p""" -o Renders/chess/%%p.stl --export-format binstl
%PYTHON% canonicalize.py Renders/chess/%%p.stl
)

pause
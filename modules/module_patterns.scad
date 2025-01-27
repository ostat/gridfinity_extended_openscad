include <module_item_holder.scad>
include <module_pattern_voronoi.scad>
include <module_pattern_brick.scad>

iPatternEnabled=0;
iPatternStyle=1;
iPatternFill=2;
iPatternBorder=3;
iPatternHoleSize=4;
iPatternHoleSides=5;
iPatternHoleSpacing=6;
iPatternHoleRadius=7;
iPatternVariable=8;
iPatternFs=9;

PatternStyle_grid = "grid";
PatternStyle_gridrotated = "gridrotated";
PatternStyle_hexgrid = "hexgrid";
PatternStyle_hexgridrotated = "hexgridrotated";
PatternStyle_voronoi = "voronoi";
PatternStyle_voronoigrid = "voronoigrid";
PatternStyle_voronoihexgrid = "voronoihexgrid";
PatternStyle_brick = "brick";
PatternStyle_brickrotated = "brickrotated";
PatternStyle_brickoffset = "brickoffset";
PatternStyle_brickoffsetrotated = "brickoffsetrotated";

PatternStyle_values = [PatternStyle_grid, PatternStyle_gridrotated, PatternStyle_hexgrid, PatternStyle_hexgridrotated, PatternStyle_voronoi, PatternStyle_voronoigrid, PatternStyle_voronoihexgrid, PatternStyle_brick, PatternStyle_brickrotated, PatternStyle_brickoffset, PatternStyle_brickoffsetrotated];
function validatePatternStyle(value, name = "PatternStyle") = 
  assert(list_contains(PatternStyle_values, value), typeerror(name, value))
  value;

PatternFill_none = "none";
PatternFill_space = "space";
PatternFill_crop = "crop";
PatternFill_crophorizontal = "crophorizontal";
PatternFill_cropvertical = "cropvertical";
PatternFill_crophorizontal_spacevertical = "crophorizontal_spacevertical";
PatternFill_cropvertical_spacehorizontal = "cropvertical_spacehorizontal";
PatternFill_spacevertical = "spacevertical";
PatternFill_spacehorizontal = "spacehorizontal";

PatternFill_values = [PatternFill_none, PatternFill_space, PatternFill_crop, PatternFill_crophorizontal, PatternFill_cropvertical, PatternFill_crophorizontal_spacevertical, PatternFill_cropvertical_spacehorizontal, PatternFill_spacevertical, PatternFill_spacehorizontal];

function validatePatternFill(value, name = "PatternFill") = 
  assert(list_contains(PatternFill_values, value), typeerror(name, value))
  value;
  
function PatternSettings(
    patternEnabled, 
    patternStyle, 
    patternFill,
    patternBorder = -1, 
    patternHoleSize, 
    patternHoleSides,
    patternHoleSpacing, 
    patternHoleRadius,
    patternVariable = 0,
    patternFs = 0) = 
  let(
    result = [
      patternEnabled,
      patternStyle,
      patternFill,
      patternBorder,
      patternHoleSize,
      patternHoleSides,
      patternHoleSpacing,
      patternHoleRadius,
      patternVariable,
      patternFs],
    validatedResult = ValidatePatternSettings(result)
  ) validatedResult;

function ValidatePatternSettings(settings, num_x, num_y) =
  assert(is_list(settings), "PatternStyle Settings must be a list")
  assert(len(settings)==10, "PatternStyle Settings must length 10")
    [settings[iPatternEnabled],
      validatePatternStyle(settings[iPatternStyle]),
      validatePatternFill(settings[iPatternFill]),
      settings[iPatternBorder],
      settings[iPatternHoleSize],
      settings[iPatternHoleSides],
      settings[iPatternHoleSpacing],
      settings[iPatternHoleRadius],
      settings[iPatternVariable],
      settings[iPatternFs]];

module cutout_pattern(
  patternStyle,
  canvasSize,
  customShape = false,
  circleFn,
  holeSize = [],
  holeSpacing,
  holeHeight,
  center = true,
  centerz = false,
  fill,
  patternVariable=0,
  holeRadius,
  border = 0,
  patternFs = 0,
  source = "",
  help){
  
  canvasSize = border > 0
    ? [canvasSize.x-border*2, canvasSize.y-border*2]
    : canvasSize;
  if(IsHelpEnabled("trace")) echo("cutout_pattern", canvasSize=canvasSize, patternVariable=patternVariable, patternFs=patternFs, source=source);
  
  $fs = patternFs > 0 ? patternFs : $fs;
  
  //translate(border>0 ? [border,border,0] : [0,0,0])
  translate(centerz ? [0,0,-holeHeight/2] : [0,0,0])
  union(){
    if(patternStyle == PatternStyle_grid || patternStyle == PatternStyle_hexgrid || patternStyle == PatternStyle_gridrotated || patternStyle == PatternStyle_hexgridrotated) {
      GridItemHolder(
        canvasSize = canvasSize,
        hexGrid = (patternStyle == PatternStyle_hexgrid || patternStyle == PatternStyle_hexgridrotated),
        customShape = customShape,
        circleFn = circleFn,
        holeSize = holeSize,
        holeSpacing = holeSpacing,
        holeHeight = holeHeight,
        center=center,
        fill=fill, //"none", "space", "crop"
        rotateGrid = (patternStyle == PatternStyle_gridrotated || patternStyle == PatternStyle_hexgridrotated),
        //border = border,
        holeChamfer=[patternVariable,patternVariable],
        help=help);
    }
    else if(patternStyle == PatternStyle_voronoi || patternStyle == PatternStyle_voronoigrid || patternStyle == "voronoihexgrid"){
      if(IsHelpEnabled("trace")) echo("cutout_pattern", canvasSize = [canvasSize.x,canvasSize.y,holeHeight], thickness = holeSpacing.x, round=1);
      rectangle_voronoi(
        canvasSize = [canvasSize.x,canvasSize.y,holeHeight], 
        spacing = holeSpacing.x, 
        cellsize = holeSize.x,
        grid = (patternStyle == PatternStyle_voronoigrid || patternStyle == PatternStyle_voronoihexgrid),
        gridOffset = (patternStyle == PatternStyle_voronoihexgrid),
        noise=patternVariable,
        radius = holeRadius,
        center=center,
        seed=getRandomSeed());
    }
    else if(patternStyle == PatternStyle_brick || patternStyle == PatternStyle_brickrotated ||
            patternStyle == PatternStyle_brickoffset || patternStyle == PatternStyle_brickoffsetrotated){
      if(IsHelpEnabled("trace")) echo("cutout_pattern", canvasSize = [canvasSize.x,canvasSize.y,holeHeight], thickness = holeSpacing.x, round=1);
      brick_pattern(
        canvis_size=[canvasSize.x,canvasSize.y],
        thickness = holeHeight,
        spacing=holeSpacing.x,
        center=center,
        cell_size = holeSize,
        corner_radius = holeRadius,
        center_weight = patternVariable,
        rotateGrid = (patternStyle == PatternStyle_brickrotated || patternStyle == PatternStyle_brickoffsetrotated),
        offset_layers = (patternStyle == PatternStyle_brickoffset || patternStyle == PatternStyle_brickoffsetrotated)
      );
    }
  }
}
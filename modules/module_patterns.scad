include <module_item_holder.scad>
include <module_pattern_voronoi.scad>
include <module_pattern_brick.scad>

iPatternEnabled=0;
iPatternStyle=1;
iPatternRotate=2;
iPatternFill=3;
iPatternBorder=4;
iPatternDepth=5;
iPatternCellSize=6;
iPatternHoleSides=7;
iPatternStrength=8;
iPatternHoleRadius=9;
iPatternFs=10;
iPatternGridChamfer=11;
iPatternVoronoiNoise=12;
iPatternBrickWeight=13;
iPatternColored=14;

PatternStyle_grid = "grid";
PatternStyle_hexgrid = "hexgrid";
PatternStyle_voronoi = "voronoi";
PatternStyle_voronoigrid = "voronoigrid";
PatternStyle_voronoihexgrid = "voronoihexgrid";
PatternStyle_brick = "brick";
PatternStyle_brickoffset = "brickoffset";

PatternStyle_values = [
    PatternStyle_grid, PatternStyle_hexgrid,
    PatternStyle_voronoi, PatternStyle_voronoigrid, PatternStyle_voronoihexgrid, 
    PatternStyle_brick, PatternStyle_brickoffset
    ];
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
    patternRotate = false,
    patternFill,
    patternBorder = -1, 
    patternDepth = 0,
    patternCellSize, 
    patternHoleSides,
    patternStrength, 
    patternHoleRadius,
    patternFs = 0,
    patternGridChamfer=0,
    patternVoronoiNoise=0,
    patternBrickWeight=0,
    patternColored="disabled"
    ) = 
  let(
    result = [
      patternEnabled,
      patternStyle,
      patternRotate,
      patternFill,
      patternBorder,
      patternDepth,
      is_num(patternCellSize) ? [patternCellSize, patternCellSize] : patternCellSize,
      patternHoleSides,
      is_num(patternStrength) ? [patternStrength, patternStrength] : patternStrength,
      patternHoleRadius,
      patternFs,
      patternGridChamfer,
      patternVoronoiNoise,
      patternBrickWeight,
      patternColored
      ],
    validatedResult = ValidatePatternSettings(result)
  ) validatedResult;

function ValidatePatternSettings(settings, num_x, num_y) =
  assert(is_list(settings), "Settings must be a list")
  assert(len(settings)==15, "Settings must length 15")
  assert(is_bool(settings[iPatternEnabled]), "settings[iPatternEnabled] must be a boolean")
  assert(is_string(settings[iPatternStyle]), "settings[iPatternStyle] must be a string")
  assert(is_bool(settings[iPatternRotate]), "settings[iPatternRotate] must be a boolean")
  assert(is_string(settings[iPatternFill]), "settings[iPatternFill] must be a string")
  assert(is_num(settings[iPatternBorder]), "settings[iPatternBorder] must be a non-negative number or -1")
  assert(is_num(settings[iPatternDepth]), "settings[iPatternDepth] must be a number")
  assert(is_list(settings[iPatternCellSize]) && len(settings[iPatternCellSize])==2, "settings[iPatternCellSize] must be a list two positive numbers")
  assert(is_num(settings[iPatternHoleSides]) && settings[iPatternHoleSides] >=  3, "settings[iPatternHoleSides] must be a number >= 3")
  assert(is_list(settings[iPatternStrength]) && len(settings[iPatternStrength])==2 && 
  is_num(settings[iPatternStrength].x) && settings[iPatternStrength].x > 0 && 
  is_num(settings[iPatternStrength].y) && settings[iPatternStrength].y > 0, "settings[iPatternStrength] must be a list of two positive numbers")
  assert(is_num(settings[iPatternHoleRadius]) && settings[iPatternHoleRadius] >= 0, "settings[iPatternHoleRadius] must be a non-negative number")
  assert(is_num(settings[iPatternFs]) && settings[iPatternFs] >= 0, "settings[iPatternFs] must be a non-negative number")
  assert(is_num(settings[iPatternGridChamfer]), "settings[iPatternGridChamfer] must be a number")
  assert(is_num(settings[iPatternVoronoiNoise]) && settings[iPatternVoronoiNoise] >= 0 && settings[iPatternVoronoiNoise] <= 1, "settings[iPatternVoronoiNoise] must be between 0 and 1")
  assert(is_num(settings[iPatternBrickWeight]) && settings[iPatternBrickWeight] >= 0, "settings[iPatternBrickWeight] must be a non-negative number")
    [settings[iPatternEnabled],
      validatePatternStyle(settings[iPatternStyle]),
      settings[iPatternRotate],
      validatePatternFill(settings[iPatternFill]),
      settings[iPatternBorder],
      settings[iPatternDepth],
      settings[iPatternCellSize],
      settings[iPatternHoleSides],
      settings[iPatternStrength],
      settings[iPatternHoleRadius],
      settings[iPatternFs],
      settings[iPatternGridChamfer],
      settings[iPatternVoronoiNoise],
      settings[iPatternBrickWeight],
      settings[iPatternColored]
      ];

function get_wallpattern_positions(
  border,
  heightz,
  positionz,
  wall_thickness,
  wallpattern_thickness,
  wallpattern_walls= [0,0,0,0],
  label_walls = [0,0,0,0],
  label_sizez=0) = 
  let(
      fudgeFactor= 0.01,
      bin_size=[env_numx()*env_pitch().x-env_clearance().x, env_numy()*env_pitch().y-env_clearance().y],
      x_width = bin_size.x-env_corner_radius()*2-border,
      y_width = bin_size.y-env_corner_radius()*2-border, 
      wallpattern_thickness=wallpattern_thickness+fudgeFactor,
      front = [
      //width, height, depth
      [x_width, heightz - (label_walls[0] != 0 ? label_sizez : 0), wallpattern_thickness],
      //Position
      [bin_size.x/2+env_clearance().x/2,  
        env_clearance().y/2+wall_thickness/2-(wall_thickness-wallpattern_thickness)/2, 
        positionz - (label_walls[0] != 0 ? label_sizez : 0)/2],
      //rotation, mirror
      [90,0,0], [0,0,0],
      //enabled
      wallpattern_walls[0]],
    back = [
      //width, height, depth
      [x_width, heightz - (label_walls[1] != 0 ? label_sizez : 0), wallpattern_thickness],
      //Position
      [bin_size.x/2+env_clearance().x/2, 
        bin_size.y+env_clearance().y/2-wall_thickness/2+(wall_thickness-wallpattern_thickness)/2, 
         positionz - (label_walls[1] != 0 ? label_sizez : 0)/2],
      //rotation, mirror
      [90,0,0], [0,1,0],
      //enabled
      wallpattern_walls[1]],
    left = [
      //width, height, depth
      [y_width, heightz - (label_walls[2] != 0 ? label_sizez : 0), wallpattern_thickness],
      //Position
      [env_clearance().x/2+wall_thickness/2-(wall_thickness-wallpattern_thickness)/2,
        bin_size.y/2+env_clearance().y/2, 
        positionz - (label_walls[2] != 0 ? label_sizez : 0)/2],
      //rotation, mirror (for chamfer)
      [90,0,90], [1,0,0],
      //enabled
      wallpattern_walls[2]],
    right = [
      //width, height, depth
      [y_width, heightz - (label_walls[3] != 0 ? label_sizez : 0), wallpattern_thickness],
      //Position
      [bin_size.x+env_clearance().x/2-wall_thickness/2+(wall_thickness-wallpattern_thickness)/2,
        bin_size.y/2+env_clearance().y/2, 
        positionz - (label_walls[3] != 0 ? label_sizez : 0)/2],
      //rotation, mirror (for chamfer)
      [90,0,90], [0,1,0],
      //enabled
      wallpattern_walls[3]],
    ylocations = [left, right],
    xlocations = [front, back])
    [xlocations, ylocations];


// cuts the wall pattern section from the bin walls and replaces them with coloured sections
module coloured_wall_pattern(
  wall_pattern_settings=[], 
  wallpattern_walls=[],
  wall_thickness=1,
  pattern_floor, 
  pattern_height,
  border = 0,
  colored_pattern = false,
){
  colored_pattern = is_string(colored_pattern) ? colored_pattern : (colored_pattern ? "enabled" : "disabled");
  fudgeFactor = 0.001;
  wallpattern_thickness = get_related_value(wall_pattern_settings[iPatternDepth], wall_thickness);
  
  positions = get_wallpattern_positions(
    border = border,
    heightz = pattern_height,
    positionz = pattern_floor,
    wall_thickness = wall_thickness,
    wallpattern_thickness = wallpattern_thickness,
    wallpattern_walls = wall_pattern_settings[iPatternEnabled] ? wallpattern_walls : [0,0,0,0]);

  locations = [positions.x[0], positions.x[1], positions.y[0], positions.y[1]];

  assert($children == 3, "coloured_wall_pattern expects three children");

  difference(){

    colored_block(colored_pattern){
      children(0);

      //subtracted block
      wall_pattern_canvas_negative(locations, colored_pattern);

      //added blockblock
      wall_pattern_canvas_positive(locations, colored_pattern);

      if($children >=3) children(2);
    }

    // Child 1 is bin cavities and negatives
    if($children >=2) children(1);
  }
}

module wall_pattern_canvas_negative(locations, colored_pattern){
  for(i = [0:1:len(locations)-1])
    if(locations[i][4] > 0)
      translate(locations[i][1])
      rotate(locations[i][2])
      cube([locations[i][0].x,locations[i][0].y,locations[i][0].z+fudgeFactor], center=true);
}

module wall_pattern_canvas_positive(locations, colored_pattern){
  for(i = [0:1:len(locations)-1])
    if(locations[i][4] > 0)
      translate(locations[i][1])
      rotate(locations[i][2]) {
        thickness = locations[i][0].z;
        cube([locations[i][0].x,locations[i][0].y,thickness], center=true);
      }
}

module colored_block(coloured_pattern = "enabled"){
  union(){
    if(coloured_pattern == "enabled"){
      difference(){
        // Child 0 is bin block
        children(0);

        //Subtract the wall pattern block so it can be coloured.
        color(env_colour(color_cup))
        children(1);
      }

      color(env_colour(color_wallcutout, isLip=true))
      //render_conditional(true)
      difference(){
        children(2);

        // Child 3 is wall pattern
        color(env_colour(color_wallcutout, isLip=true))
        children(3);
      }
    } else {
      difference(){
        // Child 0 is bin block
        children(0);

        // Child 3 is wall pattern
        color(env_colour(color_wallcutout, isLip=true))
        children(3);
      }
    }
  }
}

module cutout_pattern(
  patternStyle,
  canvasSize,
  customShape = false,
  circleFn,
  cellSize = [],
  strength,
  holeHeight,
  holeRadius,
  center = true,
  centerz = false,
  fill,
  patternGridChamfer=0,
  patternVoronoiNoise=0,
  patternBrickWeight=0,
  partialDepth = false,
  border = 0,
  patternFs = 0,
  rotateGrid = false,
  source = ""){

  // validate inputs
  assert(is_list(canvasSize) && len(canvasSize) == 2, "canvasSize must be a list of two numbers");
  assert(is_num(canvasSize.x) && canvasSize.x > 0, "canvasSize.x must be a positive number");
  assert(is_num(canvasSize.y) && canvasSize.y > 0, "canvasSize.y must be a positive number");
  assert(is_num(holeHeight) && holeHeight > 0, "holeHeight must be a positive number");
  assert(is_num(holeRadius) && holeRadius >= 0, "holeRadius must be a non-negative number");
  assert(is_num(border) && border >= 0, "border must be a non-negative number");
  assert(is_num(patternFs) && patternFs >= 0, "patternFs must be a non-negative number");
  assert(is_num(patternGridChamfer), "patternGridChamfer must be a number");
  assert(is_num(patternVoronoiNoise) && patternVoronoiNoise >= 0  && patternVoronoiNoise <= 1, "patternVoronoiNoise must be between 0 and 1");
  assert(is_num(patternBrickWeight) && patternBrickWeight >= 0, "patternBrick Weight must be a non-negative number");
  assert(is_list(strength) && len(strength) == 2 && is_num(strength.x) && strength.x > 0 && is_num(strength.y) && strength.y > 0, "strength must be a list of two positive numbers");

  canvasSize = 
    let(cs = rotateGrid ? [canvasSize.y,canvasSize.x] : canvasSize)
    border > 0
    ? [cs.x-border*2, cs.y-border*2]
    : cs;

  function calculate_chamfer(chamfer, thickness, partialDepth) = 
    let(
      _chamfer = is_num(chamfer) ? (partialDepth ? [0, chamfer] : [chamfer, chamfer]) : chamfer,
      dual_chamfer = (_chamfer[0] != 0 && _chamfer[1] != 0) ? 2 : 1)
      [get_related_value(_chamfer.x, thickness/dual_chamfer, 0),get_related_value(_chamfer.y, thickness/dual_chamfer, 0)];
  
  chamfer = calculate_chamfer(chamfer = patternGridChamfer, thickness=holeHeight, partialDepth=partialDepth);
  //override the FS for the pattern, if required
  $fs = patternFs > 0 ? patternFs : $fs;
  
  //translate(border>0 ? [border,border,0] : [0,0,0])
  translate(center ? [0,0,0] : [border,border,0])
  translate(centerz ? [0,0,-holeHeight/2] : [0,0,0])
  rotate(rotateGrid ? [0,0,90] : [0,0,0])
  union(){
    if(patternStyle == PatternStyle_grid || patternStyle == PatternStyle_hexgrid) {
      GridItemHolder(
        canvasSize = canvasSize,
        hexGrid = patternStyle == PatternStyle_hexgrid,
        customShape = customShape,
        circleFn = circleFn,
        holeSize = cellSize,
        holeSpacing = strength,
        holeHeight = holeHeight,
        center=center,
        fill=fill, //"none", "space", "crop"
        rotateGrid = true,
        //border = border,
        holeChamfer = chamfer);
    }
    else if(patternStyle == PatternStyle_voronoi || patternStyle == PatternStyle_voronoigrid || patternStyle == PatternStyle_voronoihexgrid){
      if(env_help_enabled("trace")) echo("cutout_pattern", canvasSize = [canvasSize.x,canvasSize.y,holeHeight], thickness = holeSpacing.x, round=1);
      rectangle_voronoi(
        canvasSize = [canvasSize.x,canvasSize.y,holeHeight], 
        spacing = strength.x, 
        cellsize = cellSize.x,
        grid = (patternStyle == PatternStyle_voronoigrid || patternStyle == PatternStyle_voronoihexgrid),
        gridOffset = (patternStyle == PatternStyle_voronoihexgrid),
        noise=patternVoronoiNoise,
        radius = holeRadius,
        center=center,
        seed=env_random_seed());
    }
    else if(patternStyle == PatternStyle_brick || patternStyle == PatternStyle_brickoffset){
      if(env_help_enabled("trace")) echo("cutout_pattern", canvasSize = [canvasSize.x,canvasSize.y,holeHeight], thickness = holeSpacing.x, round=1);
      brick_pattern(
        canvis_size=[canvasSize.x,canvasSize.y],
        thickness = holeHeight,
        spacing=strength.x,
        center=center,
        cell_size = cellSize,
        corner_radius = holeRadius,
        center_weight = patternBrickWeight,
        rotateGrid = true,
        offset_layers = patternStyle == PatternStyle_brickoffset
      );
    }
    else {
      echo("cutout_pattern: Unknown patternStyle", patternStyle=patternStyle);
    }
  }
}
include <thridparty/kumikoPatterns/kumiko.scad>

function get_kumiko_strength(cell_size, strength) = strength;
function get_kumiko_fillingStrength(cell_size, strength, fill_ratio) = strength*fill_ratio;
function get_kumiko_goma_gap(cell_size, strength, gap_ratio) = strength*gap_ratio;
function get_kumiko_height(fill_height, height) = fill_height <= 0 ? height : min(height, height/fill_height);
function get_kumiko_fill_height(fill_height, height) = min(height, height*fill_height);

function make_even(value) = ceil(value/2)*2;

debug_kumiko = false;

if(debug_kumiko)
{
  rectangle_asanoha();
}

module crop_kumiko(
   canvasSize = [200,200,10],
   cell_size=10,
   center=true
){
  // ratio of cell height to width
  cell_dimentions=[cell_size/2*sqrt(3), cell_size];
  
  // force an even number of cells to make symeterical. 
  $widthInCells = make_even(ceil(canvasSize.x/cell_dimentions.x));
  $heightInCells = make_even(ceil(canvasSize.y/cell_dimentions.y));
  
  // size of resulting pattern
  pattern_size = [$widthInCells*cell_dimentions.x, $heightInCells*cell_dimentions.y];
  
  intersection() {
    translate([0,0,canvasSize.z/2])
      cube(size = [canvasSize.x,canvasSize.y,canvasSize.z*2], center=true);

    translate(center ? [-pattern_size.x/2, -pattern_size.y/2, 0] : [0, 0, 0])
      children();
  }
}

module rectangle_asanoha(
  canvasSize = [200,200,10],
  cell_size=10,
  height = 5,
  strength = 2,
  fillRatio = 0.5,
  fillHeight = 1,
  center=true
){
  crop_kumiko(
   canvasSize = canvasSize,
   cell_size = cell_size,
   center = center)
  asanoha(
    cellSize=cell_size,
    widthInCells=$widthInCells,
    heightInCells=$heightInCells,
    strength=get_kumiko_strength(cell_size, strength)*0.75,
    fillingStrength=get_kumiko_fillingStrength(cell_size, strength, fillRatio)*0.75,
    extrusionHeight=get_kumiko_height(fillHeight, height),
    fillextrusionHeight=get_kumiko_fill_height(fillHeight, height)
  );
}

module rectangle_tobiAsanoha(
  canvasSize = [200,200,10],
  cell_size=10,
  height = 5,
  strength = 2,
  fillRatio = 0.5,
  fillHeight = 1,
  center=true
){
  crop_kumiko(
    canvasSize = canvasSize,
    cell_size = cell_size,
    center = center)
  tobiAsanoha(
    cellSize=cell_size, 
    widthInCells=$widthInCells,
    heightInCells=$heightInCells,
    strength = get_kumiko_strength(cell_size, strength)/3,
    fillingStrength = get_kumiko_fillingStrength(cell_size, strength, fillRatio),
    extrusionHeight=get_kumiko_height(fillHeight, height),
    fillextrusionHeight=get_kumiko_fill_height(fillHeight, height)
    );
}

module rectangle_goma(
  canvasSize = [200,200,10],
  cell_size=10,
  height = 5,
  strength = 2,
  fillRatio = 0.5,
  fillHeight = 1,
  center=true
){
  crop_kumiko(
    canvasSize = canvasSize,
    cell_size = cell_size,
    center = center)
  goma(
    cellSize=cell_size, 
    widthInCells=$widthInCells,
    heightInCells=$heightInCells,
    gap=get_kumiko_goma_gap(cell_size, strength, fillRatio*2)/1.7,
    strength=get_kumiko_strength(cell_size, strength)/2,
    fillingStrength=get_kumiko_fillingStrength(cell_size, strength, fillRatio)/1.6,
    extrusionHeight=get_kumiko_height(fillHeight, height),
    fillextrusionHeight=get_kumiko_fill_height(fillHeight, height)
  );
}

module rectangle_mikado(
  canvasSize = [200,200,10],
  cell_size=10,
  height = 5,
  strength = 2,
  fillRatio = 0.5,
  fillHeight = 1,
  center=true
){
  crop_kumiko(
    canvasSize = canvasSize,
    cell_size = cell_size,
    center = center)
  mikado(
    cellSize=cell_size, 
    widthInCells=$widthInCells,
    heightInCells=$heightInCells,
    strength=get_kumiko_strength(cell_size, strength),
    fillingStrength=get_kumiko_fillingStrength(cell_size, strength, fillRatio),
    extrusionHeight=get_kumiko_height(fillHeight, height),
    fillextrusionHeight=get_kumiko_fill_height(fillHeight, height)
  );
}

module rectangle_tsumiishiKikko(
  canvasSize = [200,200,10],
  cell_size=10,
  height = 5,
  strength = 2,
  fillRatio = 0.5,
  fillHeight = 1,
  center=true
){
  crop_kumiko(
    canvasSize = canvasSize,
    cell_size = cell_size,
    center = center)
  tsumiishiKikko(
    cellSize=cell_size, 
    widthInCells=$widthInCells,
    heightInCells=$heightInCells,
    strength=get_kumiko_strength(cell_size, strength),
    fillingStrength=get_kumiko_fillingStrength(cell_size, strength, fillRatio),
    extrusionHeight=get_kumiko_height(fillHeight, height),
    fillextrusionHeight=get_kumiko_fill_height(fillHeight, height)
  );
}

module rectangle_bishamonKikkou(
  canvasSize = [200,200,10],
  cell_size=10,
  height = 5,
  strength = 2,
  fillRatio = 0.5,
  fillHeight = 1,
  center=true
){
  crop_kumiko(
    canvasSize = canvasSize,
    cell_size = cell_size,
    center = center)
  bishamonKikkou(
    cellSize=cell_size, 
    widthInCells=$widthInCells,
    heightInCells=$heightInCells,
    strength=get_kumiko_strength(cell_size, strength),
    fillingStrength=get_kumiko_fillingStrength(cell_size, strength, fillRatio),
    extrusionHeight=get_kumiko_height(fillHeight, height),
    fillextrusionHeight=get_kumiko_fill_height(fillHeight, height)
  );
}
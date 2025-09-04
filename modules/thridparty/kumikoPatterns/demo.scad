use <kumiko.scad>

canvasSize = [114, 200];
border = [5,5];
cellSize = 20;

spacing = border.x*3;
ratio = [104/6,100/5];
kumiko_ratio = 20/ratio;

widthInCells=1;//ceil((canvasSize.x*kumiko_ratio.x)/cellSize);
heightInCells=1;//ceil((canvasSize.y*kumiko_ratio.y)/cellSize);

canvas_size = [
  widthInCells*cellSize*kumiko_ratio.x, 
  heightInCells*cellSize*kumiko_ratio.y];
echo(heightInCells=heightInCells, cellSize=cellSize, kumiko_ratio_y=kumiko_ratio.y, heightInCells*cellSize*kumiko_ratio.y);
echo(ratio=ratio,cellSize=cellSize,  canvas_size=canvas_size, canvasSize=canvasSize, widthInCells=widthInCells, heightInCells=heightInCells);

translate([0,0])
	difference() {
		square(canvas_size+border*2);
		translate(border)
    	tobiAsanoha(cellSize=cellSize, widthInCells=widthInCells, heightInCells=heightInCells, 0.8, 1.2);
}

translate([canvasSize.x+spacing,0])
	difference() {
		square(canvasSize+border*2);
		translate(border)
			asanoha(cellSize=cellSize, widthInCells=widthInCells, heightInCells=heightInCells, 1.6, 1.2);
	}

translate([(canvasSize.x+spacing)*2,0])
	difference() {
		square(canvasSize+border*2);
		translate(border)
			goma(cellSize=cellSize, widthInCells=(canvasSize.x*kumiko_ratio.x)/cellSize, heightInCells=(canvasSize.y*kumiko_ratio.y)/cellSize, gap=3, 1.6, 1.2);
	}
	
translate([0,(canvasSize.y+spacing)])
	difference() {
		square(canvasSize+border*2);
		translate(border)
			mikado(cellSize=cellSize, widthInCells=(canvasSize.x*kumiko_ratio.x)/cellSize, heightInCells=(canvasSize.y*kumiko_ratio.y)/cellSize, 1.6, 1.2);
	}

translate([(canvasSize.x+spacing),(canvasSize.y+spacing)])
	difference() {
		square(canvasSize+border*2);
		translate(border)
			tsumiishiKikko(cellSize=cellSize, widthInCells=(canvasSize.x*kumiko_ratio.x)/cellSize, heightInCells=(canvasSize.y*kumiko_ratio.y)/cellSize, 1.6, 1.2);
	}
	
translate([(canvasSize.x+spacing)*2,(canvasSize.y+spacing)])
	difference() {
		square(canvasSize+border*2);
		translate(border)
			bishamonKikkou(cellSize=cellSize, widthInCells=(canvasSize.x*kumiko_ratio.x)/cellSize, heightInCells=(canvasSize.y*kumiko_ratio.y)/cellSize, 1.6, 1.2);
	}
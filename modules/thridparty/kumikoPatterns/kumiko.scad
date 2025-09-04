$fn = 20;

module triangleGrid(cellSize, cellHeight, width, height, strength) {
	// vertical
	for (i = [0 : cellHeight : width]) {
		translate([i,0])
			hull() {
				circle(d=strength);
				translate([0,height])
					circle(d=strength);
			}
	}
	// rising
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		translate([0,i])
			hull() {
				circle(d=strength);
				translate([width,width*tan(30)])
					circle(d=strength);
			}
	}
	// falling
	for (i = [0 : cellSize : height+width*tan(30)]) {
		translate([0,i])
			hull() {
				circle(d=strength);
				translate([width,-width*tan(30)])
					circle(d=strength);
			}
	}
}

module asanohaFilling(cellHeight, fillingStrength) {
	hull() {
		circle(d=fillingStrength);
		translate([cellHeight*2/3,0])
			circle(d=fillingStrength);
	}
}

module asanohaPattern(cellSize, cellHeight, width, height, strength, fillingStrength) {
	triangleGrid(cellSize, cellHeight, width, height, strength);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) asanohaFilling(cellHeight, fillingStrength);
				rotate([0,0,60]) asanohaFilling(cellHeight, fillingStrength);
				rotate([0,0,120]) asanohaFilling(cellHeight, fillingStrength);
				rotate([0,0,180]) asanohaFilling(cellHeight, fillingStrength);
				rotate([0,0,240]) asanohaFilling(cellHeight, fillingStrength);
				rotate([0,0,300]) asanohaFilling(cellHeight, fillingStrength);
			}
		}
	}
}

module gomaFilling(cellSize, gap, fillingStrength) {
	// left
	hull() {
		translate([-gap, gap*tan(30)])
			circle(d=fillingStrength);
		translate([-gap,cellSize-gap*tan(30)])
			circle(d=fillingStrength);
	}
	// right
	hull() {
		translate([gap, gap*tan(30)])
			circle(d=fillingStrength);
		translate([gap,cellSize-gap*tan(30)])
			circle(d=fillingStrength);
	}
}

module gomaPattern(cellSize, cellHeight, width, height, gap, strength, fillingStrength) {
	triangleGrid(cellSize, cellHeight, width, height, strength);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) gomaFilling(cellSize, gap, fillingStrength);
				rotate([0,0,60]) gomaFilling(cellSize, gap, fillingStrength);
				rotate([0,0,120]) gomaFilling(cellSize, gap, fillingStrength);
				rotate([0,0,180]) gomaFilling(cellSize, gap, fillingStrength);
				rotate([0,0,240]) gomaFilling(cellSize, gap, fillingStrength);
				rotate([0,0,300]) gomaFilling(cellSize, gap, fillingStrength);
			}
		}
	}	
}

module tobiAsanohaFilling(cellSize, cellHeight, fillingStrength) {
	// right 
	hull() {
		circle(d=fillingStrength);
		translate([cellSize/4/cos(30),0])
			circle(d=fillingStrength);
	}
	// right down
	hull() {
		translate([cellSize/4/cos(30),0])
			circle(d=fillingStrength);
		translate([cellHeight/2,-cellSize/4])
			circle(d=fillingStrength);
	}
	// right up
	hull() {
		translate([cellSize/4/cos(30),0])
			circle(d=fillingStrength);
		translate([cellHeight/2,cellSize/4])
			circle(d=fillingStrength);
	}
}

module tobiAsanohaPattern(cellSize, cellHeight, width, height, strength, fillingStrength) {
	triangleGrid(cellSize, cellHeight, width, height, strength);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength); 
				rotate([0,0,180]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,60]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,120]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,-60]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,-120]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength);
			}
		}
	}
}

module mikadoFilling(cellSize, cellHeight, fillingStrength) {
	hull() {
		translate([0,cellSize/3])
			circle(d=fillingStrength);
		translate([cellHeight/3,cellSize/2])
			circle(d=fillingStrength);
	}
	hull() {
		rotate([0,0,-60])
			translate([0,cellSize/3])
				circle(d=fillingStrength);
		translate([cellHeight/3,cellSize/2])
			circle(d=fillingStrength);
	}
}

module mikadoPattern(cellSize, cellHeight, width, height, strength, fillingStrength) {
	triangleGrid(cellSize, cellHeight, width, height, strength);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) mikadoFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,60]) mikadoFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,120]) mikadoFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,180]) mikadoFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,240]) mikadoFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,300]) mikadoFilling(cellSize, cellHeight, fillingStrength);
			}
		}
	}
}

module tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength) {
	hull() {
		translate([0,cellSize/2])
			circle(d=fillingStrength);
		translate([cellHeight/3,cellSize/2])
			circle(d=fillingStrength);
	}
	hull() {
		rotate([0,0,-60])
			translate([0,cellSize/2])
				circle(d=fillingStrength);
		translate([cellHeight/3,cellSize/2])
			circle(d=fillingStrength);
	}
}

module tsumiishiKikkoPattern(cellSize, cellHeight, width, height, strength, fillingStrength) {
	triangleGrid(cellSize, cellHeight, width, height, strength);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,60]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,120]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,180]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,240]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,300]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength);
			}
		}
	}
}

module bishamonKikkouFilling(cellSize, cellHeight, fillingStrength) {
	hull() {
		translate([0,cellSize*2/3])
			circle(d=fillingStrength);
		translate([cellHeight/3,cellSize/2])
			circle(d=fillingStrength);
	}
	hull() {
		translate([0,cellSize*2/3])
			circle(d=fillingStrength);
		translate([-cellHeight/3,cellSize/2])
			circle(d=fillingStrength);
	}
}

module bishamonKikkouPattern(cellSize, cellHeight, width, height, strength, fillingStrength) {
	triangleGrid(cellSize, cellHeight, width, height, strength);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) bishamonKikkouFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,120]) bishamonKikkouFilling(cellSize, cellHeight, fillingStrength);
				rotate([0,0,240]) bishamonKikkouFilling(cellSize, cellHeight, fillingStrength);
			}
		}
	}
}

module asanoha(cellSize, widthInCells, heightInCells, strength, fillingStrength) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		translate([strength/2, strength/2]) 
			square([width-strength, height-strength]);
		asanohaPattern(cellSize, cellHeight, width, height, strength, fillingStrength);
	}
}

module goma(cellSize, widthInCells, heightInCells, gap, strength, fillingStrength) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		square([width, height]);
		gomaPattern(cellSize, cellHeight, width, height, gap, strength, fillingStrength);
	}
}

module tobiAsanoha(cellSize, widthInCells, heightInCells, strength, fillingStrength) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		square([width, height]);
		tobiAsanohaPattern(cellSize, cellHeight, width, height, strength, fillingStrength);
	}
}

module mikado(cellSize, widthInCells, heightInCells, strength, fillingStrength) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		square([width, height]);
		mikadoPattern(cellSize, cellHeight, width, height, strength, fillingStrength);
	}
}

module tsumiishiKikko(cellSize, widthInCells, heightInCells, strength, fillingStrength) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		translate([0, 0]) 
			square([width, height]);
		tsumiishiKikkoPattern(cellSize, cellHeight, width, height, strength, fillingStrength);
	}
}

module bishamonKikkou(cellSize, widthInCells, heightInCells, strength, fillingStrength) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		translate([0, 0]) 
			square([width, height]);
		bishamonKikkouPattern(cellSize, cellHeight, width, height, strength, fillingStrength);
	}
}
/*
Kumiko Patterns
This is an OpenSCAD implementation of various traditional japanese Kumiko patterns. They are all based on the triangle shape and add various infills. Implemented right now are the following patterns:

by froqstar
https://github.com/froqstar/kumikoPatterns

*/
module triangleGrid(cellSize, cellHeight, width, height, strength, extrusionHeight) {
	// vertical
	for (i = [0 : cellHeight : width]) {
		translate([i,0])
			hull() {
				cylinder(d=strength, h=extrusionHeight);
				translate([0,height])
					cylinder(d=strength, h=extrusionHeight);
			}
	}
	// rising
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		translate([0,i])
			hull() {
				cylinder(d=strength, h=extrusionHeight);
				translate([width,width*tan(30)])
					cylinder(d=strength, h=extrusionHeight);
			}
	}
	// falling
	for (i = [0 : cellSize : height+width*tan(30)]) {
		translate([0,i])
			hull() {
				cylinder(d=strength, h=extrusionHeight);
				translate([width,-width*tan(30)])
					cylinder(d=strength, h=extrusionHeight);
			}
	}
}

module asanohaFilling(cellHeight, fillingStrength, extrusionHeight) {
	hull() {
		cylinder(d=fillingStrength, h=extrusionHeight);
		translate([cellHeight*2/3,0])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
}

module asanohaPattern(cellSize, cellHeight, width, height, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	triangleGrid(cellSize, cellHeight, width, height, strength, extrusionHeight);

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

module gomaFilling(cellSize, gap, fillingStrength, extrusionHeight) {
	// left
	hull() {
		translate([-gap, gap*tan(30)])
			cylinder(d=fillingStrength, h=extrusionHeight);
		translate([-gap,cellSize-gap*tan(30)])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
	// right
	hull() {
		translate([gap, gap*tan(30)])
			cylinder(d=fillingStrength, h=extrusionHeight);
		translate([gap,cellSize-gap*tan(30)])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
}

module gomaPattern(cellSize, cellHeight, width, height, gap, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	triangleGrid(cellSize, cellHeight, width, height, strength, extrusionHeight);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) gomaFilling(cellSize, gap, fillingStrength, fillextrusionHeight);
				rotate([0,0,60]) gomaFilling(cellSize, gap, fillingStrength, fillextrusionHeight);
				rotate([0,0,120]) gomaFilling(cellSize, gap, fillingStrength, fillextrusionHeight);
				rotate([0,0,180]) gomaFilling(cellSize, gap, fillingStrength, fillextrusionHeight);
				rotate([0,0,240]) gomaFilling(cellSize, gap, fillingStrength, fillextrusionHeight);
				rotate([0,0,300]) gomaFilling(cellSize, gap, fillingStrength, fillextrusionHeight);
			}
		}
	}	
}

module tobiAsanohaFilling(cellSize, cellHeight, fillingStrength, extrusionHeight) {
	// right 
	hull() {
		cylinder(d=fillingStrength, h=extrusionHeight);
		translate([cellSize/4/cos(30),0])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
	// right down
	hull() {
		translate([cellSize/4/cos(30),0])
			cylinder(d=fillingStrength, h=extrusionHeight);
		translate([cellHeight/2,-cellSize/4])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
	// right up
	hull() {
		translate([cellSize/4/cos(30),0])
			cylinder(d=fillingStrength, h=extrusionHeight);
		translate([cellHeight/2,cellSize/4])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
}

module tobiAsanohaPattern(cellSize, cellHeight, width, height, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	triangleGrid(cellSize, cellHeight, width, height, strength, extrusionHeight);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight); 
				rotate([0,0,180]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,60]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,120]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,-60]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,-120]) tobiAsanohaFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
			}
		}
	}
}

module mikadoFilling(cellSize, cellHeight, fillingStrength, extrusionHeight) {
	hull() {
		translate([0,cellSize/3])
			cylinder(d=fillingStrength, h=extrusionHeight);
		translate([cellHeight/3,cellSize/2])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
	hull() {
		rotate([0,0,-60])
			translate([0,cellSize/3])
				cylinder(d=fillingStrength, h=extrusionHeight);
		translate([cellHeight/3,cellSize/2])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
}

module mikadoPattern(cellSize, cellHeight, width, height, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	triangleGrid(cellSize, cellHeight, width, height, strength, extrusionHeight);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) mikadoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,60]) mikadoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,120]) mikadoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,180]) mikadoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,240]) mikadoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,300]) mikadoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
			}
		}
	}
}

module tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength, extrusionHeight) {
	hull() {
		translate([0,cellSize/2])
			cylinder(d=fillingStrength, h=extrusionHeight);
		translate([cellHeight/3,cellSize/2])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
	hull() {
		rotate([0,0,-60])
			translate([0,cellSize/2])
				cylinder(d=fillingStrength, h=extrusionHeight);
		translate([cellHeight/3,cellSize/2])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
}

module tsumiishiKikkoPattern(cellSize, cellHeight, width, height, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	triangleGrid(cellSize, cellHeight, width, height, strength, extrusionHeight);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,60]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,120]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,180]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,240]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,300]) tsumiishiKikkoFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
			}
		}
	}
}

module bishamonKikkouFilling(cellSize, cellHeight, fillingStrength, extrusionHeight) {
	hull() {
		translate([0,cellSize*2/3])
			cylinder(d=fillingStrength, h=extrusionHeight);
		translate([cellHeight/3,cellSize/2])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
	hull() {
		translate([0,cellSize*2/3])
			cylinder(d=fillingStrength, h=extrusionHeight);
		translate([-cellHeight/3,cellSize/2])
			cylinder(d=fillingStrength, h=extrusionHeight);
	}
}

module bishamonKikkouPattern(cellSize, cellHeight, width, height, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	triangleGrid(cellSize, cellHeight, width, height, strength, extrusionHeight);

	// fillings
	for (i = [-ceil(width*tan(30)/cellSize)*cellSize : cellSize : height]) {
		for (x = [0 : cellHeight : width+cellHeight]) {
			y = i + x*tan(30);
			translate([x,y]) {
				rotate([0,0,0]) bishamonKikkouFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,120]) bishamonKikkouFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
				rotate([0,0,240]) bishamonKikkouFilling(cellSize, cellHeight, fillingStrength, fillextrusionHeight);
			}
		}
	}
}

module asanoha(cellSize, widthInCells, heightInCells, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		translate([0,0,-0.01])
      cube([width, height, max(extrusionHeight, fillextrusionHeight)+0.02]);
		asanohaPattern(cellSize, cellHeight, width, height, strength, fillingStrength, extrusionHeight, fillextrusionHeight);
	}
}

module goma(cellSize, widthInCells, heightInCells, gap, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		translate([0,0,-0.01])
		cube([width, height, max(extrusionHeight, fillextrusionHeight)+0.02]);
		gomaPattern(cellSize, cellHeight, width, height, gap, strength, fillingStrength, extrusionHeight, fillextrusionHeight);
	}
}

module tobiAsanoha(cellSize, widthInCells, heightInCells, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		translate([0,0,-0.01])
		cube([width, height, max(extrusionHeight, fillextrusionHeight)+0.02]);
		tobiAsanohaPattern(cellSize, cellHeight, width, height, strength, fillingStrength, extrusionHeight, fillextrusionHeight);
	}
}

module mikado(cellSize, widthInCells, heightInCells, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		translate([0,0,-0.01])
		cube([width, height, max(extrusionHeight, fillextrusionHeight)+0.02]);
		mikadoPattern(cellSize, cellHeight, width, height, strength, fillingStrength, extrusionHeight, fillextrusionHeight);
	}
}

module tsumiishiKikko(cellSize, widthInCells, heightInCells, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		translate([0,0,-0.01])
		cube([width, height, max(extrusionHeight, fillextrusionHeight)+0.02]);
		tsumiishiKikkoPattern(cellSize, cellHeight, width, height, strength, fillingStrength, extrusionHeight, fillextrusionHeight);
	}
}


module bishamonKikkou(cellSize, widthInCells, heightInCells, strength, fillingStrength, extrusionHeight, fillextrusionHeight) {
	cellHeight = cellSize/2*sqrt(3);
	height = heightInCells*cellSize;
	width = widthInCells*cellHeight;

	difference() {
		translate([0,0,-0.01])
		cube([width, height, max(extrusionHeight, fillextrusionHeight)+0.02]);
		bishamonKikkouPattern(cellSize, cellHeight, width, height, strength, fillingStrength, extrusionHeight, fillextrusionHeight);
	}
}
/**
* m_transpose.scad
* use <../matrix/m_transpose.scad>
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-m_transpose.html
**/
function m_transpose(m) =
  let(
    column = len(m[0]),
    row = len(m)
  )
  [
    for(y = 0; y < column; y = y + 1)
    [
      for(x = 0; x < row; x = x + 1)
      m[x][y]
    ]
  ];

/**
* unit_vector.scad
* use <../util/unit_vector.scad>
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
**/
function unit_vector(v) = v / norm(v);

/**
* vrn2_from.scad
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_from.html
**/
module vrn2_from(points, spacing = 1, r = 0, delta = 0, chamfer = false, region_type = "square") {
    transposed = m_transpose(points);
    xs = transposed[0];
    ys = transposed[1];

    region_size = max([max(xs) -  min(xs), max(ys) -  min(ys)]);    
    half_region_size = 0.5 * region_size; 
    offset_leng = spacing * 0.5 + half_region_size;
    
    module region(pt) {
        intersection_for(p = [for(p = points) if(pt != p) p]) {
            v = p - pt;
            translate((pt + p) / 2 - unit_vector(v) * offset_leng)
            rotate(atan2(v.y, v.x))
                children();
        }
    }    

    module offseted_region(pt) {
        if(r != 0) {
            offset(r) 
            region(pt) 
                children();
        }
        else {
            offset(delta = delta, chamfer = chamfer) 
            region(pt) 
                children();
        }     
    }
    
    for(p = points) {	
        if(region_type == "square") {
            offseted_region(p)
                square(region_size, center = true);
        }
        else {
            offseted_region(p)
                circle(half_region_size);
        }
    }
}

module rectangle_voronoi(
   canvasSize = [200,200,10],
   points=[],
   cellsize=10,
   noise=0.5, 
   grid=false,
   gridOffset = false,
   spacing = 2, 
   radius = 0.5,
   seed = undef,
   center=true,
   fillBorderCells = false,
   borderMargin = -1)
{
  _spacing = spacing + radius*2;
  
  // Calculate border margin: if fillBorderCells is true and borderMargin is not specified,
  // use cellsize/2 as default to eliminate border cells
  effectiveBorderMargin = fillBorderCells && borderMargin < 0 ? cellsize/2 : 
                          borderMargin >= 0 ? borderMargin : 0;
  
  // Adjust canvas size to account for border margin
  adjustedCanvasSize = [canvasSize.x - 2*effectiveBorderMargin, 
                        canvasSize.y - 2*effectiveBorderMargin];
  
  points = points != undef && is_list(points) && len(points) > 0 
    ? points 
    : grid ?
     let(
      _pointCount = [ceil(adjustedCanvasSize.x/cellsize)+1,ceil(adjustedCanvasSize.y/cellsize)+1],
      seed = seed == undef ? rands(0, 100000, 2)[0] : seed,
      seeds = rands(0, 100000, 2, seed), // you need a different seed for x and y
      pointsx = rands(-cellsize/2*noise, cellsize/2*noise, _pointCount.x*_pointCount.y, seeds[0]),
      pointsy = rands(-cellsize/2*noise, cellsize/2*noise, _pointCount.x*_pointCount.y, seeds[1])
    )[for(i = [0:_pointCount.x-1], y = [0:_pointCount.y-1]) 
        [i*cellsize + pointsx[i+y*_pointCount.x]-adjustedCanvasSize.x/2 + (y % 2 == 0 && gridOffset ? cellsize/2 : 0),
          y*cellsize + pointsy[i*_pointCount.y+y]-adjustedCanvasSize.y/2]]
    : let(
      _pointCount = max((adjustedCanvasSize.x * adjustedCanvasSize.y)/(cellsize^2), 30),
      seed = seed == undef ? rands(0, 100000, 2)[0] : seed,
      seeds = rands(0, 100000, 2, seed), // you need a different seed for x and y
      pointsx = rands(-adjustedCanvasSize.x/2, adjustedCanvasSize.x/2, _pointCount, seeds[0]),
      pointsy = rands(-adjustedCanvasSize.y/2, adjustedCanvasSize.y/2, _pointCount, seeds[1])
    )[for(i = [0:_pointCount-1]) [pointsx[i],pointsy[i]]];
  
  translate(center ? [0, 0, 0] : [canvasSize.x/2, canvasSize.y/2, 0])
  intersection() {
    translate([0,0,canvasSize.z/2])
      cube(size = [canvasSize.x,canvasSize.y,canvasSize.z*2], center=true);
  
    linear_extrude(height = canvasSize.z)
      vrn2_from(
        points, 
        spacing=_spacing,
        chamfer=false,
        delta=0,
        r=radius, 
        region_type = "square");
  }
}
/**
* m_transpose.scad
* use <../matrix/m_transpose.scad>
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-m_transpose.html
*
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
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_from.html
*
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
   canvisSize = [200,150,10],
   pointCount=0,
   densityRatio = 50,
   spacing = 2, 
   radius = 0.5, 
   seed = undef, 
   fn = 32)
{
  $fn=fn;
  _spacing = spacing + radius*2;
  _pointCount = max(pointCount == 0 ? (canvisSize.x * canvisSize.y)/densityRatio : pointCount, 30);

  echo("random_rectangle_voronoi", canvisSize=canvisSize, radius=radius, spacing=_spacing, _pointCount=_pointCount);
  
  seed = seed == undef ? rands(0, 100000, 2)[0] : seed;
  seeds = rands(0, 100000, 2, seed); // you need a different seed for x and y
  pointsx = rands(-canvisSize.x/2, canvisSize.x/2, _pointCount, seeds[0]);
  pointsy = rands(-canvisSize.y/2, canvisSize.y/2, _pointCount, seeds[1]);
  
  points = [for(i = [0:_pointCount-1]) [pointsx[i],pointsy[i]]];
  
  intersection() {
    translate([0,0,canvisSize.z/2])
      cube(size = [canvisSize.x,canvisSize.y,canvisSize.z*2], center=true);
  
    linear_extrude(height = canvisSize.z)
      vrn2_from(
        points, 
        spacing=_spacing,
        chamfer=false,
        delta=0,
        r=radius, 
        region_type = "square");
  }
}

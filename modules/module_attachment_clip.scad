/*
  Module: attachment_clip
  Description: Creates a wall clip that is used when the box is split.
*/
include <functions_general.scad>
include <gridfinity_constants.scad>
include <functions_environment.scad>
/*
attachment_clip(height = 13,
  width = 0,
  thickness = 2,
  footingThickness= 2,
  tabStyle = 0);
*/

// Creates a wall clip that is used when the box is split
// Parameters:
// - height: The height of the clip (default: 8)
// - width: The width of the clip (default: 0, which means it will be set to half of the height)
// - thickness: The thickness of the clip (default: gf_lip_support_taper_height)
// - footingThickness: The thickness of the footing (default: 1)
// - tabStyle: The style of the tab (default: 0)s
module attachment_clip(
  height = 8,
  width = 0,
  thickness = gf_lip_support_taper_height,
  footingThickness = 1,
  tabStyle = 0)
{
  // Assertions to check the input parameters
  assert(is_num(height) && height > 0, "height must be a positive number");
  assert(is_num(width) && width >= 0, "width must be a non-negative number");
  assert(is_num(thickness) && thickness > 0, "thickness must be a positive number");
  assert(is_num(footingThickness) && footingThickness > 0, "footingThickness must be a positive number");
  assert(is_num(tabStyle) && tabStyle >= 0, "tabStyle must be a non-negative number");

  if(env_help_enabled("debug")) echo("attachment_clip", height=height, width=width, thickness=thickness, tabStyle=tabStyle);
  tabVersion = 0;
  width = width > 0 ? width : height / 2;
  tabHeight = height - thickness * 2;
  tabDepth = min(tabHeight / 2 * 0.8, width * 0.8, 3.5);
  tabStyle = floor(tabStyle);
  translate([0, 0, -height / 2])
  
  union()
  {
    if(tabStyle == 2){
      // using hull prevents shape not being closed
      hull()
      polyhedron
        (points = [
           [0, 0, 0],                                             //0
           [0, -width, 0],                                                 //1
           [0, -width, height],                                            //2
           [0, 0, height],                                        //3
           [0, thickness, height-thickness],                                       //4
           [0, thickness, thickness],                                              //5
           [thickness, thickness, thickness],                                      //6
           [thickness, -width+thickness, thickness],                       //7
           [thickness, -width+thickness, height-thickness],       //8
           [thickness, thickness, height-thickness]                                //9
           ], 
         faces = [[0,1,2,3,4,5],[6,7,8,9]]
      );
      hull()
      polyhedron
        (points = [
           [0, thickness, thickness],                             //0
           [0, -width+thickness, thickness],                    //1
           [0, -width+thickness, height-thickness],           //2
           [0, thickness, height-thickness],                    //3
           [0, tabDepth, height-tabDepth],                      //4
           [0, tabDepth, tabDepth],                               //5
           [thickness, thickness, thickness],                     //6
           [thickness, -width+thickness, thickness],            //7
           [thickness, -width+thickness, height-thickness],   //8
           [thickness, thickness, height-thickness],            //9
           [thickness, tabDepth, height-tabDepth],              //10
           [thickness, tabDepth, tabDepth]                        //11
           ], 
           faces = [[0,1,2,3,4,5],[6,7,8,9,10,11]]
      );
    } else if(tabStyle == 1){
      // using hull prevents shape not being closed
      hull()
      polyhedron
        (points = [
           [0, -thickness, 0],                                  //0
           [0, -width, 0],                                      //1
           [0, -width, height],                                 //2
           [0, -thickness, height],                             //3
           [0, 0, height-thickness],                          //4
           [0, 0, thickness],                                   //5
           [thickness, 0, thickness],                           //6
           [thickness, -width+thickness, thickness],          //7
           [thickness, -width+thickness, height-thickness], //8
           [thickness, 0, height-thickness]                   //9
           ], 
         faces = [[0,1,2,3,4,5],[6,7,8,9]]
      );
      hull()
      polyhedron
        (points = [
           [0, 0, thickness],                                   //0
           [0, -width+thickness, thickness],                  //1
           [0, -width+thickness, height-thickness],         //2
           [0, 0, height-thickness],                          //3
           [0, tabDepth, height-thickness-tabDepth],        //4
           [0, tabDepth, thickness+tabDepth],                 //5
           [thickness, 0, thickness],                           //6
           [thickness, -width+thickness, thickness],          //7
           [thickness, -width+thickness, height-thickness], //8
           [thickness, 0, height-thickness],                  //9
           [thickness, tabDepth, height-thickness-tabDepth],//10
           [thickness, tabDepth, thickness+tabDepth]          //11
           ], 
           faces = [[0,1,2,3,4,5],[6,7,8,9,10,11]]
      );
    } else {
      // using hull prevents shape not being closed
      hull()
      polyhedron
        (points = [
           [0, 0, 0],                                           //0
           [0, -width, 0],                                      //1
           [0, -width, height],                                 //2
           [0, 0, height],                                      //3
           [thickness, 0, thickness],                           //4
           [thickness, -width+thickness, thickness],          //5
           [thickness, -width+thickness, height-thickness], //6
           [thickness, 0, height-thickness],                  //7
           [-footingThickness, 0, 0],                           //8
           [-footingThickness, -width, 0],                      //9
           [-footingThickness, -width, height],                 //10
           [-footingThickness, 0, height]                       //11
           ], 
         faces = [[0,1,2,3],[4,5,6,7],[8,9,10,11]]
      );
      hull()
      polyhedron
        (points = [
           [0, 0, thickness],                                   //0
           [0, -width+thickness, thickness],                  //1
           [0, -width+thickness, height-thickness],         //2
           [0, 0, height-thickness],                          //3
           [0, tabDepth, height-thickness-tabDepth],        //4
           [0, tabDepth, thickness+tabDepth],                 //5
           [thickness, 0, thickness],                           //6
           [thickness, -width+thickness, thickness],          //7
           [thickness, -width+thickness, height-thickness], //8
           [thickness, 0, height-thickness],                  //9
           [thickness, tabDepth, height-thickness-tabDepth],//10
           [thickness, tabDepth, thickness+tabDepth]          //11
           ], 
           faces = [[0,1,2,3,4,5],[6,7,8,9,10,11]]
      );
    }
  }
}

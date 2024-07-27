// Creates an wall clip that is used when box is split
module attachement_clip(
  height = 8,
  width = 0,
  thickness = gf_lip_support_taper_height,
  tabStyle = 0)
{
  if(IsHelpEnabled($showHelp, "debug")) echo("attachement_clip", height=height, width=width, thickness=thickness, tabStyle=tabStyle);
  tabVersion = 0;
  width = width > 0 ? width : height/2;
  tabHeight=height-thickness*2;
  tabDepth = min(tabHeight/2*0.8, width*0.8, 3.5);
  tabStyle = floor(tabStyle);
  translate([0,0,-height/2])
  
  union()
  {
    if(tabStyle == 2){
      // using hull prevents shape not being closed
      hull()
      polyhedron
        (points = [
           [0, 0, 0],                                  //0
           [0, -width, 0],                                      //1
           [0, -width, height],                                 //2
           [0, 0, height],                             //3
           [0, thickness, height-thickness],                            //4
           [0, thickness, thickness],                                   //5
           [thickness, thickness, thickness],                           //6
           [thickness, -width+thickness, thickness],            //7
           [thickness, -width+thickness, height-thickness],     //8
           [thickness, thickness, height-thickness]                     //9
           ], 
         faces = [[0,1,2,3,4,5],[6,7,8,9]]
      );
      hull()
      polyhedron
        (points = [
           [0, thickness, thickness],                                   //0
           [0, -width+thickness, thickness],                    //1
           [0, -width+thickness, height-thickness],             //2
           [0, thickness, height-thickness],                            //3
           [0, tabDepth, height-tabDepth],          //4
           [0, tabDepth, tabDepth],                 //5
           [thickness, thickness, thickness],                           //6
           [thickness, -width+thickness, thickness],            //7
           [thickness, -width+thickness, height-thickness],     //8
           [thickness, thickness, height-thickness],                    //9
           [thickness, tabDepth, height-tabDepth],  //10
           [thickness, tabDepth, tabDepth]          //11
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
           [0, 0, height-thickness],                            //4
           [0, 0, thickness],                                   //5
           [thickness, 0, thickness],                           //6
           [thickness, -width+thickness, thickness],            //7
           [thickness, -width+thickness, height-thickness],     //8
           [thickness, 0, height-thickness]                     //9
           ], 
         faces = [[0,1,2,3,4,5],[6,7,8,9]]
      );
      hull()
      polyhedron
        (points = [
           [0, 0, thickness],                                   //0
           [0, -width+thickness, thickness],                    //1
           [0, -width+thickness, height-thickness],             //2
           [0, 0, height-thickness],                            //3
           [0, tabDepth, height-thickness-tabDepth],          //4
           [0, tabDepth, thickness+tabDepth],                 //5
           [thickness, 0, thickness],                           //6
           [thickness, -width+thickness, thickness],            //7
           [thickness, -width+thickness, height-thickness],     //8
           [thickness, 0, height-thickness],                    //9
           [thickness, tabDepth, height-thickness-tabDepth],  //10
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
           [thickness, -width+thickness, thickness],            //5
           [thickness, -width+thickness, height-thickness],     //6
           [thickness, 0, height-thickness]                     //7
           ], 
         faces = [[0,1,2,3],[4,5,6,7]]
      );
      hull()
      polyhedron
        (points = [
           [0, 0, thickness],                                   //0
           [0, -width+thickness, thickness],                    //1
           [0, -width+thickness, height-thickness],             //2
           [0, 0, height-thickness],                            //3
           [0, tabDepth, height-thickness-tabDepth],            //4
           [0, tabDepth, thickness+tabDepth],                   //5
           [thickness, 0, thickness],                           //6
           [thickness, -width+thickness, thickness],            //7
           [thickness, -width+thickness, height-thickness],     //8
           [thickness, 0, height-thickness],                    //9
           [thickness, tabDepth, height-thickness-tabDepth],    //10
           [thickness, tabDepth, thickness+tabDepth]            //11
           ], 
           faces = [[0,1,2,3,4,5],[6,7,8,9,10,11]]
      );
    }
  }
}

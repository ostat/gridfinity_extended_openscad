// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad

/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/

include <ub_helptxt.scad>
include <ub_common.scad>

/** \name Grid \page Modifier
Grid() children(); creates a grid of children
\param e elements [x,y]
\param es element spacing [x,y]
\param s total space ↦ es
\param center true/false 
*/
// multiply children in a given matrix (e= number es =distance)

module Grid(e=[2,2,1],es=10,s,center=true,name,help){
  
     name=is_undef(name)?is_undef($info)?false:
                                                   $info:
                                   name;

    function n0(e)=is_undef(e)?1:max(round(e),0);
    function n0s(e)=max(e-1,1);// e-1 must not be 0
    center=is_list(center)?v3(center):[center,center,center];
    e=is_list(e)?is_num(e[2])?[max(round(e[0]),0),max(round(e[1]),0),n0(e[2])]:
                    [round(e.x),round(e.y),1]: // z = 1
        es[2]?[n0(e),n0(e),n0(e)]:
        [n0(e),n0(e),1];
    
    es=is_undef(s)?is_list(es)?is_num(es[2])?es:
                                concat(es,[0]):
                    is_undef(es)?[0:0:0]:
                        [es,es,es]:
       is_list(s)?is_num(s[2])?[s[0]/n0s(e[0]),s[1]/n0s(e[1]),s[2]/n0s(e[2])]:
                    [s[0]/n0s(e[0]),s[1]/n0s(e[1]),0]:
        [s/n0s(e[0]),s/n0s(e[1]),s/n0s(e[2])];
        
   MO(!$children);
   InfoTxt("Grid",[str("Gridsize(",e,")"),str(e[0]*e[1]*e[2]," elements= ",(e[0]-1)*es[0],"×",(e[1]-1)*es[1],"×",(e[2]-1)*es[2],"mm \n element spacing= ",es," mm",
    
    center.x?str("\n\tX ",-(e[0]-1)*es[0]/2," ⇔ ",(e[0]-1)*es[0]/2," mm"):"",
    center.y?str("\n\tY ",-(e[1]-1)*es[1]/2," ⇔ ",(e[1]-1)*es[1]/2," mm"):"",
    center.z?str("\n\tZ ",-(e[2]-1)*es[2]/2," ⇔ ",(e[2]-1)*es[2]/2," mm"):"")
    ],name);  
    
    
       
    HelpTxt("Grid",[
    "e",e
    ,"es",es
    ,"s",[(e[0]-1)*es[0],(e[1]-1)*es[1],(e[2]-1)*es[2]]
    ,"center",center
    ,"name",name]
    ,help);
    
    centerPos=[
   center.x?((1-e[0])*es[0])/2:0,
   center.y?((1-e[1])*es[1])/2:0,
   center.z?((1-e[2])*es[2])/2:0];

   if(e.x&&e.y&&e.z) for(x=[0:e[0]-1],y=[0:e[1]-1],z=[0:e[2]-1]){
       $idx=[x,y,z];
       $idx2=[e.y*e.x*z+e.y*y+x,e.y*e.x*z+e.x*x+y];
       $pos=[x*es.x,y*es.y,z*es.z]+centerPos;
       $info=norm($idx)?false:name;
       $tab=is_undef($tab)?1:b($tab,false)+1;
       $es=es;
      // $helpM=norm($idx)?false:$helpM;
       translate([x*es[0],y*es[1],z*es[2]]+centerPos)children();
   }
}

//Grid(4)Text($pos.xy,size=3);

// Grid but with alternating row offset - hex or circle packing
//HexGrid()circle(d=$es.y);
//HexGrid()circle(d=Umkreis(6,$d-.1),$fn=6);

/** \name HexGrid \page Modifier
HexGrid() children(); creates an interlaced grid of children
\param e elements [x,y] e+.1 or -.1 will change the pattern
\param es element spacing [x,y]
\param center true/false or -7 ⇔ 7 for x shift
\param $d $r $es $idx $idx2 $pos output for children
\param name help  name help
*/
module HexGrid(e=[11,4],es=5,center=true,name,help){
  
  es=is_list(es)?es:[es*sin(60),es];
  e=is_list(e)?e:[e,e,1];
  $d=es.y;
  $r=$d/2;
  icenter=abs(b(center,bool=false));
  //shifting for center and pattern change
  yCor=(is_undef(useVersion)||useVersion>23.300)&&icenter?-es.y/4:0;
  shift=[0,e.y>round(e.y)?-es.y/2:e.y<round(e.y)?0:yCor]+sign(b(center,bool=false))*(
     icenter==2?[es.x/2,0]
    :icenter==3?[es.x/3,0]
    :icenter==4?[es.x,0]
    :icenter==5?[es.x*2/3,0]
    :icenter==6?[es.x*1/6,0]
    :icenter==7?[es.x/(2/3),0]
    :[0,0]);

    Grid(e=e,es=es,center=center,name=name)
      translate([shift.x,shift.y+( // shift for center and pattern
        $idx[0]%2?is_list(es)?es[1]/2:es/2:
                  0)
      ]){
// calculating $pos for post processing
    $pos=$pos+[shift.x,shift.y+($idx[0]%2?is_list(es)?es[1]/2
                                                      :es/2
                                          :0),0];
// pattern change by omiting elementst
    if(e.y%1){
      if(e.y<round(e.y)?$idx.y<round(e.y)-1||($idx.x+1)%2
                       :$idx.y>0||($idx.x)%2)children();
      }
    else children();
    }
    
    MO(!$children);
// info of Grid will be used additional for changed pattern this:
  if(e.y%1)InfoTxt("HexGrid",["elements",round(e.x)*round(e.y)*(e.z?e.z:1) 
    - (e.y<round(e.y)?floor(round(e.x)/2):ceil(round(e.x)/2))
    ],name);
  
  
  HelpTxt("HexGrid",[
    "e",e
    ,"es",es
    ,"center",center
    ,"name",name]
    ,help);
}
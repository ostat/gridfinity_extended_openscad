// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad

/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/

include <ub_helptxt.scad>
include <ub_common.scad>

minVal=0.0000001; // minimum für nicht 0
pivotSize=$vpd/15;

function Hypotenuse(a,b)=sqrt(pow(a,2)+pow(b,2));
function hypotenuse(a,b)=sqrt(pow(a,2)+pow(b,2));
function Kathete(hyp,kat)=sqrt(pow(hyp,2)-pow(kat,2));
function kathete(hyp,kat)=sqrt(pow(hyp,2)-pow(kat,2));

function Hexstring(c)=str("#",Hex(c[0]*255),Hex(c[1]*255),Hex(c[2]*255));

// two digit dec max 255
function Hex(dec)= 
    let(
    dec=min(abs(dec),255),
    sz=floor(dec/16),
    s1=floor(dec)-(sz*16)
    )
    str(sz>14?"F":
        sz>13?"E":
        sz>12?"D":
        sz>11?"C": 
        sz>10?"B":
        sz>9?"A":sz,      
        s1>14?"F":
        s1>13?"E":
        s1>12?"D":
        s1>11?"C": 
        s1>10?"B":
        s1>9?"A":s1   
  
    );

function RotLang(rot=0,l=10,l2,z,e,lz)=let(
rot=is_undef(rot)?0:rot%360,
l=is_undef(l)?0:l,
l2=is_undef(l2)?l:l2,
lz=is_undef(lz)?l:lz
)
is_undef(z)?is_undef(e)?[sin(rot)*l,cos(rot)*l2]:
                        [sin(rot)*cos(e%360)*l,cos(rot)*cos(e%360)*l2,sin(e%360)*lz]:
            [sin(rot)*l,cos(rot)*l,z];

/** \page Functions \name kreis
kreis() generates points on a circle or arc
\param r radius
\param rand dist second radius
\param grad angle
\param grad2 angle second arc
\param fn fragments

\param center center angle
\param sek  chord or center point
\param r2  y component
\param rand2  y component
\param rot rotate points
\param t translate points
\param z z value for polyhedron
\param d ovewrite radius with diameter
\param endPoint end angle with point
\param fs fragment size
\param fs2 fragment size second arc
\param fn2 fragments second arc
\param minF minimum fragments 
*/

function Kreis(r=10,rand=+5,grad=360,grad2,fn=$fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0])=kreis(r,rand,grad,grad2,fn,center,sek,r2,rand2,rcenter,rot,t);




function kreis(r=10,rand=+5,grad=360,grad2,fn=$fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0],z,d,endPoint=true,fs=$fs,fs2,fn2,minF=1,fa=$fa)=
let (
minF=bool(minF,bool=false),
grad2=is_undef(grad2)?grad:grad2,
r=is_num(d)?rcenter?(d+rand)/2:d/2:
            rcenter?r+rand/2:r,
rand2=is_undef(rand2)?rand:rand2,
r2=r2?
    rcenter?r2+rand2/2:r2
    :r,
ifn=is_num(fn)&&fn>0?max(1,ceil(abs(fn)))
                    :min(max(abs(grad)<180?1
                                       :abs(grad)==360?3
                                                      :2,ceil(abs(PI*r*2/360*grad/max(fs,0.001))),minF),round(abs(grad)/fa) ),
fs2=is_undef(fs2)?fs:fs2,

fn2=is_num(fn)&&fn>0?is_undef(fn2)?ifn:max(1,ceil(abs(fn2)))
                    :min(max(abs(grad2)<180?1:abs(grad2)==360?3:2,ceil(abs(PI*(r-rand)*2/360*grad2/max(fs2,0.001))),minF),round(grad/fa)),

step=grad/ifn,
step2=grad2/fn2,
t=is_list(t)?t:[t,0],
endPoint=rand?true:endPoint
)
is_num(z)?[
if(!sek&&!rand&&abs(grad)!=360&&grad)[0+t[0],0+t[1],z], // single points replacement
if(grad==0&&minF)for([0:minF])[sin(rot+(center?-grad/2-90:0))*r  +t[0],
     cos(rot+(center?-grad/2-90:0))*r2 +t[1],
     z],
if(grad)for(i=[0:endPoint?ifn:ifn-1])
        let(iw=abs(grad)==360?i%ifn:i)
    [sin(rot+(center?-grad/2-90:0)+iw*step)*r  +t[0],
     cos(rot+(center?-grad/2-90:0)+iw*step)*r2 +t[1],
     z],
if(rand)for(i=[0:endPoint?fn2:fn2 -1])
    let(iw=abs(grad2)==360?i%fn2:i)
    [sin(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r  -rand )+t[0],
     cos(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r2 -rand2)+t[1],
    z]
]:
[ // if TwoD
if(!sek&&!rand&&abs(grad)!=360&&grad||r==0)[0+t[0],0+t[1]], // single points replacement
if(r&&grad)for(i=[0:endPoint?ifn:ifn-1])
        let(iw=abs(grad)==360?i%ifn:i)
    [sin(rot+(center?-grad/2-90:0)+iw*step)*r+t[0],
    cos(rot+(center?-grad/2-90:0)+iw*step)*r2+t[1]],
if(grad==0&&minF)for([0:minF])[sin(rot+(center?-grad/2-90:0))*r  +t[0],
     cos(rot+(center?-grad/2-90:0))*r2 +t[1]],
if(rand)for(i=[0:endPoint?fn2:fn2-1])
    let(iw=abs(grad2)==360?i%fn2:i)
    [sin(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r-rand)+t[0],
    cos(rot+(center?grad2/2-90:grad2)+iw*-step2)*(r2-rand2)+t[1]]
];

/**
\name SBogen
SBogen() creates an S-shape double counter arc between parallels
\param dist distance between verticals
\param r1 r2 radii
\param grad connecton angle
\param l1 l2 lower and upper length 
\param center center on x
\param fn,fs,fa  fraqments
\param messpunkt show arc center
\param TwoD make TwoD
\param extrude extrude in TwoD from x=0
\param grad2 angle endsection
\param x0 set x axis origin=0
\param lRef reference for l1 l2 0=center -1/1 lower/upper tangentP -2/2 tangent+grad2 -3/3 radius center
\param name help name help
\param lap overlap for 3D
*/

//SBogen(TwoD=true);
//SBogen(extrude=10, grad2=[26,-40]*1,r1=2,l1=20,lRef=+3,messpunkt=true);

module SBogen(dist=10,r1=10,r2,grad=45,l1=15,l2,center=1,fn,fs=$fs,fa=$fa,messpunkt=false,TwoD=0,extrude=false,grad2=0,x0=0,lRef=0,name,help,spiel,lap=0){
    lap=is_undef(spiel)?lap:spiel;
    center=is_bool(center)?center?1:0:sign(center);
    r2=is_undef(r2)?r1:r2;
    l2=is_undef(l2)?l1:l2;
    TwoD=is_parent(needs2D)&&!$children?TwoD?b(TwoD,false):
                                         1:
                                      b(TwoD,false);
// echo(parent_module(1),$parent_modules);
    grad2=is_list(grad2)?grad2:[grad2,grad2];
    extrudeTrue=extrude;
    extrude=is_bool(extrude)?0:extrude*sign(dist);
    gradN=grad; // detect negativ grad
    grad=abs(grad);// negativ grad done by mirror
    y=(grad>0?1:-1)*(abs(dist)/tan(grad)+r1*tan(grad/2)+r2*tan(grad/2));
    
    yRef=lRef?lRef>0?(lRef> 2?0: tan((grad- (lRef> 1?grad2[1]:0) )/2)*r2)-y/2 // move polygon circles to keep fixpoint according lRef
                    :(lRef<-2?0:-tan((grad- (lRef<-1?grad2[0]:0) )/2)*r1)+y/2
             :0;
    
    yrest=y-abs(sin(grad))*r1-abs(sin(grad))*r2;//y ohne Kreisstücke
    distrest=dist-r2-r1+cos(grad)*r1+cos(grad)*r2;//dist ohne Kreisstücke
        
    l2m=Hypotenuse(distrest,yrest)/2+minVal;// Mittelstück
 
    dist=grad>0?dist:-dist;
  $fn=fn;
  $fa=fa;
  $fs=fs;
  $idxON=false;
  $info=is_undef($info)?is_undef(name)?1:name:$info;

  grad2Y=[-l1+y/2-yRef+r1*sin(grad2[0]),l2-y/2-yRef-r2*sin(grad2[1])]; // Abstand Kreisende zu Punkt l1/l2
  grad2X=[r1-r1*cos(grad2[0])-tan(grad2[0])*grad2Y[0],-r2+r2*cos(grad2[1])-tan(grad2[1])*grad2Y[1]];// Versatz der Punkte durch grad2


  KreisCenterR1=[[-abs(dist)/2+extrude+r1,-y/2+yRef],[extrude+r1-abs(dist),-y/2-l2+yRef],[extrude+r1,-y/2+l1+yRef]];
  KreisCenterR2=[[abs(dist)/2+extrude-r2,y/2+yRef],[extrude-r2,y/2-l2+yRef],[abs(dist)+extrude-r2,y/2+l1+yRef]];


  selectKC=center?center>0?0:
                           1:
                  2;


  endPunkte=center?center==1?[extrude-abs(dist/2)+grad2X[0],extrude+abs(dist/2)+grad2X[1]]:[extrude-abs(dist)+grad2X[0],extrude+grad2X[1]]:[extrude+grad2X[0],extrude+abs(dist)+grad2X[1]];


    InfoTxt(parent_module(search(["Anschluss"],parentList(+0))[0]?
        search(["Anschluss"],parentList(+0,start=0))[0]:
        1)
        
        ,["ext",str(endPunkte[0],"/",endPunkte[1])," 2×=",str(2*endPunkte[0],"/",2*endPunkte[1]),"Kreiscenter",str(KreisCenterR1[selectKC],"/",KreisCenterR2[selectKC])
    ],name);



 if(grad&&!extrudeTrue)mirror(gradN<0?[1,0]:[0,0])translate(center?[0,0,0]:[dist/2,l1]){
    translate([dist/2,y/2,0])T(-r2)rotate(grad2[1])T(r2)Bogen(rad=r2,grad=grad+grad2[1],center=false,l1=l2-y/2,l2=l2m,help=0,name=0,messpunkt=messpunkt,TwoD=TwoD,fn=fn,fs=fs,d=TwoD,lap=lap)
    if($children){

      $idx=is_undef($idx)?0:$idx;
      $tab=is_undef($tab)?1:b($tab,false)+1;
      children();
    }
    else circle($fn=fn,$fs=fs);
  T(-dist/2,-y/2) mirror([1,0,0])rotate(180)T(r1)rotate(-grad2[0])T(-r1)Bogen(rad=r1,grad=-grad-grad2[0],center=false,l1=l1-y/2,l2=l2m,help=0,name=0,messpunkt=messpunkt,TwoD=TwoD,fn=fn,fs=fs,d=TwoD,lap=lap)
    if($children){
      $idx=1;
      children();
    }
    else circle($fn=fn,$fs=fs);
 }
 
 if(!grad&&!extrudeTrue) //0 grad Grade
     if(!TwoD)T(0,center?0:l1+l2)R(90)linear_extrude(l1+l2,convexity=5,center=center?true:false)
         if($children)children();
         else circle($fn=fn);
 else T(center?0:-TwoD/2) square([TwoD,l1+l2],center?true:false);
     

 
 
 
 if(extrudeTrue){

     
     points=center?center==1?concat(//center=1
     [[x0*sign(dist),l2]],[[extrude+abs(dist)/2+grad2X[1],l2+0]],
     kreis(r=-r2,rand=0,grad=abs(grad)+grad2[1],rot=-90-grad2[1],center=false,fn=fn,fs=fs,fa=fa,t=[abs(dist)/2+extrude-r2,y/2+yRef]), // ok
     kreis(r=-r1,rand=0,grad=-abs(grad)-grad2[0],fn=fn,fs=fs,fa=fa,rot=90+abs(grad),center=false,t=[-abs(dist)/2+extrude+r1,-y/2+yRef]),  // ok   
     [[extrude-abs(dist)/2+grad2X[0],-l1]],     
     [[x0*sign(dist),-l1]]
     ): concat(//center==-1||>1
     [[x0*sign(dist),0]],[[extrude+grad2X[1],0]],
     kreis(r=-r2,rand=0,grad=abs(grad)+grad2[1],rot=-90-grad2[1],center=false,fn=fn,fs=fs,fa=fa,t=[extrude-r2,y/2-l2+yRef]), // ok
     kreis(r=-r1,rand=0,grad=-abs(grad)-grad2[0],fn=fn,fs=fs,rot=90+abs(grad),center=false,t=[extrude+r1-abs(dist),-y/2-l2+yRef]),  // ok   
     [[extrude-abs(dist)+grad2X[0],-l2-l1]],     
     [[x0*sign(dist),-l2-l1]]     
     ):
     concat(//center==0
     [[x0*sign(dist),l2+l1]],[[extrude+abs(dist)+grad2X[1],l2+l1]],
     kreis(r=-r2,rand=0,grad=abs(grad)+grad2[1],rot=-90-grad2[1],center=false,fn=fn,fs=fs,fa=fa,t=[abs(dist)+extrude-r2,y/2+l1+yRef]), // ok
     kreis(r=-r1,rand=0,grad=-abs(grad)-grad2[0],fn=fn,fs=fs,fa=fa,rot=90+abs(grad),center=false,t=[extrude+r1,-y/2+l1+yRef]),  // ok   
     [[extrude+grad2X[0],0]],     
     [[x0*sign(dist),0]]     
     );
     

     
  if(dist>0&&gradN>0)  polygon(points,convexity=5);
  if(dist<0||gradN<0)mirror([1,0])  polygon(points,convexity=5);    
  
 }
    

 if(messpunkt&&is_num(extrude)){
     Pivot(KreisCenterR1[selectKC],messpunkt=messpunkt,active=[1,0,0,1]);
     Pivot(KreisCenterR2[selectKC],messpunkt=messpunkt,active=[1,0,0,1]);
 //echo(KreisCenterR1,KreisCenterR2);
 }
 
 

    //Warnings    
  Echo(str(name," SBogen has no TwoD-Object"),color=Hexstring([1,0.5,0]),size=4,condition=!$children&&!TwoD&&!extrudeTrue);
  Echo(str(name," SBogen width is determined by var TwoD=",TwoD,"mm"),color="info",size=4,condition=TwoD==1&&!extrudeTrue&&(is_undef($idx)||!$idx)&&$info);       
   
  Echo(str(name," SBogen r1/r2 to big  middle <0"),condition=l2m<0);
  Echo(str(name," SBogen radius 1 negative"),condition=r1<0);
  Echo(str(name," SBogen radius 2 negative"),condition=r2<0);    
  Echo(str(name," SBogen r1/r2 to big or angle or dist to short"),condition=grad!=0&&r1-cos(grad)*r1+r2-cos(grad)*r2>abs(dist));
  Echo(str(name," SBogen angle to small/ l1+l2 to short =",l1-y/2+yRef,"/",l2-y/2-yRef),condition=l1-y/2+yRef<0||l2-y/2-yRef<0);
   //Help    
  HelpTxt("SBogen",["dist",dist,"r1",r1,"r2",r2,"grad",grad,"l1",l1,"l2",l2,"center",center,"fn",fn,"messpunkt",messpunkt,"TwoD",TwoD,"extrude",extrude,"grad2",grad2,"x0",x0, "lRef", lRef, "lap",lap," ,name=",name],help); 

}


/** \name Bogen \page Objects
Bogen() creates a bended cylinder or children
\param grad angle
\param rad bend radius
\param l,l1,l2 straight length l⇒ [l1,l2]
\param fn fn2 fs fraqments
\param tcenter tangent
\param center centern
\param lap,spiel  overlap
\param d diameter (if no children)
\param messpunkt show bend center
\param TwoD  make TwoD
*/
//Bogen(TwoD=1,lap=+0,fn=0);
//Bogen();

module Bogen(grad=90,rad=5,l,l1=10,l2=12,fn=$fn,center=true,tcenter=false,name,d=3,fn2=0,fs=$fs,fa=$fa,lap=minVal,spiel,help,messpunkt=messpunkt,TwoD=false)
{
    $fn=fn;
    $fs=fs;
    $fa=fa;
    $helpM=0;
    $info=0;
    $idxON=false;
    ueberlapp=is_num(spiel)?-spiel:lap;
    l1=is_undef(l)?l1+ueberlapp:is_list(l)?l[0]+ueberlapp:l+ueberlapp;
    l2=is_undef(l)?l2+ueberlapp:is_list(l)?l[1]+ueberlapp:l+ueberlapp;
    TwoD=is_parent(needs2D)&&!$children?TwoD?b(TwoD,false):
                                       1:
                                    b(TwoD,false);
    
    c=sin(abs(grad)/2)*rad*2;//  Sekante 
    w1=abs(grad)/2;          //  Schenkelwinkel
    w3=180-abs(grad);        //  Scheitelwinkel
    a=(c/sin(w3/2))/2;    
    hc=grad!=180?Kathete(a,c/2):0;  // Sekante tangenten center
    hSek=Kathete(rad,c/2); //center Sekante
    bl=PI*rad/180*grad;//Bogenlänge
    
    mirror([grad<0?1:0,0,0])rotate(center?0:tcenter?-abs(grad)/2:+0)T(tcenter?grad>180?hSek+hc:-hSek-hc:0)rotate(tcenter?abs(grad)/2:0) T(center?0:tcenter?0:-rad){
    if(!TwoD) T(rad)R(+90,+0)Tz(-l1+ueberlapp){
      $idx=0;
      $tab=is_undef($tab)?1:b($tab,false)+1;
      color("green")   linear_extrude(l1,convexity=5)
            if ($children)mirror([grad<0?1:0,0,0])children();
            else circle(d=d,$fn=fn2);
     //color("lightgreen",.5)   T(0,0,l1)if(messpunkt&&$preview)R(0,-90,-90)Dreieck(h=l1,ha=pivotSize,grad=5,n=0);//Pivot(active=[1,1,1,0]);        
        }
    else T(rad)R(0,+0)T(0,-ueberlapp)color("green")T(-d/2)square([d,l1]);
 
    if(grad)if(!TwoD) rotate_extrude(angle=-abs(grad)-0,$fa = fn?abs(grad)/fn:fa, $fs = $fs,$fn=0,convexity=5)intersection(){
      $idx=1;
      $fn=fn;
      $fa=fa;
      T(rad)
            if ($children)mirror([grad<0?1:0,0,0])children();
                else circle(d=d,$fn=fn2); 
                translate([0,-500])square(1000);
            }
     else  Kreis(rand=d,grad=abs(grad),center=false,r=rad+d/2,fn=fn,fs=fs,name=0,help=0); 
      
        
     if (!TwoD)R(z=-abs(grad)-180) T(-rad,-ueberlapp)R(-90,180,0){
       $idx=2;
         color("darkorange")linear_extrude(l2,convexity=5)
            if ($children)mirror([grad<0?1:0,0,0])children();
            else circle(d=d,$fn=fn2);
        
         //color("orange",0.5)if(messpunkt&&$preview)T(0,0,l2)R(0,-90,-90)Dreieck(h=l2,ha=pivotSize,grad=5,n=0);//Pivot(active=[1,1,1,0]);   
        }
     else R(z=-abs(grad)-180) T(-rad,-ueberlapp) color("darkorange")T(-d/2)square([d,l2]);
            
    union(){//messpunkt
       color("yellow") Pivot(active=[1,0,0,1],messpunkt=messpunkt); 
       if(grad!=180)color("blue")mirror([0,grad<0?1:0,0]) translate(RotLang(90+grad/2,hc+hSek))Pivot(active=[1,0,0,1],messpunkt=messpunkt); 
       if(grad>180)color("lightblue")mirror([0,grad<0?1:0,0]) translate(RotLang(90+grad/2,-hc-hSek))Pivot(active=[1,0,0,1],messpunkt=messpunkt);     
    }  
    }

    
  if(name&&!$children)echo(str("»»» »»» ",name," Bogen ",grad,"° Durchmesser= ",d,"mm — Innenmaß= ",2*max(rad,d/2)-d,"mm Außenmaß= ",2*max(rad,d/2)+d));
      
  if(name)echo(str(name," Bogen ",grad,"° Radius=",rad,"mm Sekantenradius= ",hSek,"mm — Tangentenschnittpunkt=",hSek+hc,"mm TsSekhöhe=",hc,"mm Kreisstücklänge=",bl," inkl l=",bl+l1+l2,"mm"));
      
  if(!$children&&name&&!TwoD)Echo("Bogen missing Object! using circle",color="warning");
  
  HelpTxt("Bogen",["grad",grad,"rad",rad,"l",l,"l1",l1,"l2",l2,"fn",fn,"center",center,"tcenter",tcenter,"name",name,"d",d,"fn2",fn2,"fs",fs,"lap",lap,"messpunkt",messpunkt,"TwoD",TwoD],help);
    
}

/** \page Polygons
Kreis() creates a circle polygon
\name Kreis
\param r radius
\param dicke rim
\param grad angle
\param grad2 optional rim angle
\param fn fragments
\param center center (angle <360)
\param sek  secant or center point (angle <360)
\param r2  y radius for oval
\param rcenter rim center
\param rot rotate circle
\param t   translate circle
\param name name for circle
\param help help
\param d diameter optional to r = d↦r
\param id optional to dicke
\param b optional to grad, L of the circular arc
\param fs,fa fragment size optional to fn fs↦fn,min fraqment angle

*/

//Kreis(d=10,id=8,grad=270);


module Kreis(r=10,dicke=0,grad=360,grad2,fn,center=true,sek=false,r2=0,rand2,rcenter=0,rot=0,t=[0,0],name,help,d,b,fs=$fs,fa=$fa,rand,id){
    r=is_undef(d)?r:d/2;
    d=2*r;
    dicke=is_undef(rand)?is_undef(id)?dicke:(d-id)/2
                        :rand;
    
    grad=is_undef(b)?grad:r==0?0:b/(2*PI*r)*360;
    b=2*r*PI*grad/360;
    
   polygon( kreis(r=r,rand=dicke,grad=grad,grad2=grad2,fn=fn,center=center,sek=sek,r2=r2,rand2=rand2,rcenter=rcenter,rot=grad==360?center?rot:rot+90:center?rot+180:rot+90,t=t,fs=fn?undef:fs,endPoint=grad==360?false:true,fa=fa),convexity=5);
   
    
    HelpTxt("Kreis",["r",r,"dicke",dicke,"grad",grad,"grad2",grad2,"fn",fn,"center",center,"sek",sek,"r2",r2,"rand2",rand2,"rcenter",rcenter,"rot",rot,"t",t,"name",name,"d",d,", b",b,"id",id,"fs",fs],help);
    

    if(!rcenter){
      if(dicke>0)InfoTxt("Kreis",["id",2*(r-abs(dicke)),"od",2*r],name);
      if(dicke<0)InfoTxt("Kreis",["id",2*r,"od",2*(r+abs(dicke))],name); 
    }
    else if(dicke)InfoTxt("Kreis",["id",2*r-abs(dicke)," od=",2*r+abs(dicke)],name);   

}

/** \page Helper
Pivot() creates a pivot gizmo
* \name Pivot
* \brief creates a pivot gizmo
* \param p0  position of the Gizmo
* \param size size of the Gizmo
* \param active activate parts (center axis rotation text 
* \param messpunkt activates
* \param txt adds text
* \param rot rotates
* \param vpr orient text
* \param help activate help
*/

module Pivot(p0=[0,0,0],size,active=[1,1,1,1,1,1],messpunkt,txt,rot=0,vpr=$vpr,help=false){
  messpunkt=is_undef(messpunkt)?is_undef($messpunkt)?true:$messpunkt:messpunkt;
    p0=is_num(p0)?[p0,0]:p0;
    size=is_undef(size)?is_bool(messpunkt)?pivotSize:messpunkt:size;
  
    size2=size/+5;
  if(messpunkt&&$preview)translate(p0)%union(){
        
      if(active[3])rotate(rot)  color("blue")cylinder(size,d1=.5*size2,d2=0,center=false,$fn=4);
      if(active[2])rotate(rot)  color("green")rotate([-90,0,0])cylinder(size,d1=.5*size2,d2=0,center=false,$fn=4);
      if(active[1])rotate(rot)  color("red")rotate([0,90,0])cylinder(size,d1=.5*size2,d2=0,center=false,$fn=4);   
       if(active[0]) color("yellow")sphere(d=size2*.6,$fn=12);
       //Text
       if(active[4]) %color("grey")rotate(vpr)
          //linear_extrude(.1,$fn=1)
       text(text=str(norm(p0)?p0:""," ",rot?str(rot,"°"):"","   "),size=size2,halign="right",valign="top",font="Bahnschrift:style=light",$fn=1);    
       
       if(txt&&active[5])%color("lightgrey")rotate(vpr)translate([0,size/15])//linear_extrude(.1,$fn=1)
         Tz(0.1) text(text=str(txt,"   "),size=size2,font="Bahnschrift:style=light",halign="right",valign="bottom",$fn=1);
  }     
  HelpTxt("Pivot",[
     "p0",p0,
    "size",size,
    "active",active,
    "messpunkt",messpunkt,
    "txt",txt,
    "rot",rot,
    "vpr",vpr]
    ,help); 

}

// short for rotate(a,v=[0,0,0])
module R(x=0,y=0,z=0,help=false)
{
    rotate([x,y,z])children();
    MO(!$children);
    HelpTxt("R",["x",x,"y",y,"z",z],help);
}
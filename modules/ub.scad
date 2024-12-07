// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad

/* Infos
 save here
 • Windows:  ..\Documents\OpenSCAD\libraries
 • Linux:    $HOME/.local/share/OpenSCAD/libraries/
 • Mac OS X: $HOME/Documents/OpenSCAD/libraries/
*/

/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)

Copy this file into your libaries directory (File » show Libraries)
[https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries]


## Use it by starting your project with including the library.
## All needed Information will be displayed in your console window, you may need to make that bigger.

Write:
include<ub.scad>;
[https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Include_Statement]

 \param name= "my project"; The name will never be rendered
 \param helpsw=true         Switch to show the information (1-5 or true)
 \param $info=true;         Switch to get feedback/info from objects
 \param helpM=true;         Switch to get help for used objects
 \param nozzle=.4;          Set your printers nozzle diameter
 \param layer=.2;           Set your layerhigh
 \param show=2;             Will show you Object n (any number) from this library
 \param anima=1;            Activate animation variables else "tset=.5" can be used
 \param vp=1;               Switch fixed Viewports
 \param bed=true            Print bed active (centers vp printPos)
 \param name="object";      Used in modules for showing name or number - if 0 no info is shown

Changelog (archive at the very bottom)

000|23 FIX Grid UPD vMult UPD Pin  
002|23 UPD Prisma UPD WStern UPD Kreis UPD Bogen FIX Rand  
004|23 UPD Cycloid Fix Roof UPD kreis Fix Quad  
006|23 UPD Arc UPD Pin FIX Linse  
008|23 UPD VorterantQ Vorterantrotor UPD Reuleaux UPD Roof FIX Gewinde  
010|23 ADD Tesselation FIX CyclGear UPD Twins UPD Linse CHG Pin UPD Halbrund
020|23 CHG Linse CHG Pin UPD Tri CHG Bitaufnahme UPD PrevPos
024|23 UPD vollwelle, UPD Vollwelle, UPD Arc UPD menu UPD Kegelmantel UPD Kegel
040|23 UPD Pin UPD Kegel UPD Welle UPD Grid UPD HexGrid
050|23 CHG Kehle CHG RotEx FIX Prisma UPD HexGrid CHG Vollwelle CHG LinEx UPD Kegel
055|23 UPD kreis UPD polyRund upd SWelle upd PolyRund CHG Coil CHG pathPoints CHG Bezier
060|23 CHG quad CHG printPos upd Schnitt chg Gewinde
070|23 ADD Connector FIX Welle
080|23 UPD Glied FIX Kehle FIX Gewinde UPD arc UPD Connector FIX Welle
090|23 ADD QuadAnschluss upd Gewinde
100|23 CHG Vollwelle UPD QuadAnschluss CHG Connector
110|23 CHG Bogen CHG QuadAncshluss CHG Cut CHG Loch CHG Kehle
120|23 UPD QuadAnschluss FIX Torus UPD Coil CHG SRing CHG kreis ADD FlatMesh
130|23 CHG FlatMesh FIX GewindeV2 UPD Gewinde chg viewportsize UPD Points
140|23 CHG Ring CHG Riemen UPD riemen CHG Tri CHG Tri90 FIX Gewinde UPD SBogen
150|23 CHG SBogen CHG Kegel FIX Bezier chg fa UPD Anschluss UPD Welle UPD M
160|23 UPD Pille UPD Connector CHG DPfeil UPD Kreis kreis
180|23 UPD kreis FIX Text FIX kreis UPD SBogen UPD RotEx FIX Pille 
190|23 CHG Points ADD sternDeg ADD SternDeg UPD Rund
200|23 UPD SternDeg UPD nut UPD Gewinde UPD octa FIX SGlied UPD KnurlTri
210|23 ADD bool UPD Knurl UPD Text ADD FlatKnurl UPD FlatMesh CHG Tesselation UPD Roof
220|23 UPD distS UPD Kehle ADD Penrose ADD RectTiling CHG Ellipse UPD Filter UPD Caliper
230|23 CHG Caliper UPD Rohr UPD Bogen UPD QuadAnschluss ADD vMin vMax vAdd UPD Torus
240|23 FIX QuadAnschluss CHG WaveEX UPD Polar CHG Isosphere UPD WKreis 
250|23 FIX GewindeV4 FIX kreis FIX vollwelle CHG Filter FIX Loch
260|23 FIX Gewinde UPD Pfeil CHG CyclGear ADD Rod UPD Ring UPD Coil UPD SWelle
270|23 FIX Pille UPD Kegel UPD Pille UPD Anschluss UPD SBogen FIX GewindeV4 ADD radiusSH
275|23 UPD QuadAnschluss ADD transition CHG $fn UPD Ccube UPD Arc UPD Involute UPD involute
280|23 UPD Torus CHG transition CHG Gardena FIX Rod CHG Gewinde Fix Text FIX WStern UPD HexGrid
285|23 UPD HexGrid UPD Text Fix kreis UPD Kreis Fix Kegel UPD VorterantQ FIX Vorterantrotor
290|23 FIX Roof FIX Kegel UPD Balg UPD RotEx UPD Involute UPD Connector UPD Kehle FIX Loch
305|23 FIX HexGrid UPD Kegel
*/

{//fold // Constants


// libraries direkt (program folder\oscad\libaries) !
/*[UB lib]*/
test=42;
designVersion=0;
/*[Global]*/

/// activates help in console window
helpsw=false; 

/// activates menu
menu=true;

/// animation switch
anima=false;

/// use print Bed as center and show boarder
bed=false;

/// switch for customizer
info=true;

debug=$preview?anima?false:info:false;
/// activates module information (name)
$info=debug;
/// viewpoint
//vp=false;
vp=$preview?false:true;
/// Project name
name=undef;
/// Düsen ∅
nozzle=0.4;
/// Area of nozzle
nozArea=(nozzle/2)^2*PI;
/// print line width
line=nozzle;

/// Layer hight
layer=0.08;// one step = 0.04 (8mm/200steps)

/// Layer line Area
lineProfile=PI*(layer/2)^2+ (line-layer)*layer;

/// Print Bed size
printBed=[220,220];
/// Printposition;
pPos=[0,0,0];
printPos=bed?concat(printBed,0)/2+v3(pPos):v3(pPos);

/// render with Hires
hires=false;
fn=$fn?$fn:$preview?36:
                          hires?144:
                                72;


fs=$preview?.75:hires?.1:.2;
fa=$preview?10:hires?.5:1;


/// demo objects
show=0;
/// animation var
tset=0;//[0:.01:1]
/// clearance
spiel=0.20;
pip=0.35;

pivotSize=$vpd/15;
/// size viewport
viewportSize=$preview?tan($vpf)*$vpd:1000; 

vpt=is_num(printPos.z)?printPos:concat(printPos,0);
vpr=bed?[55.00,0.00,25.00]:$vpr;
vpd=bed?300:$vpd;//[50:5:350]
vpf=22.5;


/// display project name
texton=name!=undef&&name!=""?$preview?true:false:false;

/// Colors (version 2019)
helpMColor="";//"#5500aa";

/*[Constant]*/
/*[Hidden]*/
Version=23.305;//                <<< ---   VERSION  VERSION VERSION ••••••••••••••••
useVersion=undef;
UB=true;
PHI=1.6180339887498948;/// golden ratio 1.618033988;
gw=360-360/PHI;/// goldener Winkel;
tw=acos(-1/3);/// tetraeder winkel;
twF=acos(1/3);/// tetraeder winkel face edge face;
inch=25.4; /// inch/Zoll
minVal=0.0000001; // minimum für nicht 0

needs2D=["Rand","WKreis","Welle","Rund","Rundrum", "LinEx", "RotEx","SBogen","Bogen","HypKehle","Roof"]; /// modules needing 2D children 
//echo(tw,twF);
//PHI=(1+sqrt(5))/2;


}//fold // end constants ΔΔ

assert(useVersion?Version>=useVersion:true,str("lib version ",Version," detected, install ",useVersion," ub.scad library‼ ⇒http://v.gd/ubaer"));
assert(version()[0]>2019,"Install current http://openscad.org version");

{//fold // \∇∇ functions ∇∇/



function l(x=1,layer=layer)=x*layer;
function layer(x=1,layer=layer)=x*layer;

function n(x=1,nozzle=nozzle)=sign(x)*(abs(x)*nozzle + 0.05*nozzle); /*(x==1?0.05*nozzle:
                                                          - layer*(1-PI/4) * (x-1)*0)); 0.05*nozzle padding for slicer */
                                                          
function line(n=1,line=line,nozzle=nozzle)=sign(n)*(abs(n)*line + 0.05*nozzle);

function testPoly(s=10)=[
[0,0],
[s,0],
[s,s],
[s/2,s/2],
[0,s]
];


function Inkreis(eck,rU)=cos(180/eck)*rU;
function inkreis(eck,rU)=cos(180/eck)*rU;
function Umkreis(eck,rI,name)=let(r=rI/cos(180/eck))is_undef(name)?r:echo(str(name," Umkreis=",r))r;
function umkreis(eck,rI,name)=let(r=rI/cos(180/eck))is_undef(name)?r:echo(str(name," Umkreis=",r))r;

function Hypotenuse(a,b)=sqrt(pow(a,2)+pow(b,2));
function hypotenuse(a,b)=sqrt(pow(a,2)+pow(b,2));
function Kathete(hyp,kat)=sqrt(pow(hyp,2)-pow(kat,2));
function kathete(hyp,kat)=sqrt(pow(hyp,2)-pow(kat,2));

/** \page Functions \name vMax
vMax gives you the max of a number and a list 
\param v vector or list
\param max max limiting value
*/

function vMax(v=[0],max=0)=[for(i=v)max(max, i) ];
/** \page Functions \name vMin
vMin gives you the min of a number and a list 
\param v vector or list
\param min min limiting value
*/

function vMin(v=[0],min=0)=[for(i=v)min(min, i) ];

/** \page Functions \name vAdd
vAdd gives you the addition of a number with a vector/list constituents 
\param v vector or list
\param add added value
*/

function vAdd(v=[0],add=0)=[for(i=v) add + i ];


/** \page Functions
Sehne() gives you the length of a chord
\param n n-gon
\param r radius
\param a,deg  degree optional to n
*/

function Sehne(n,r,a,deg)=let(a=is_num(deg)?deg:a)is_undef(a)?2*r*sin(180/n):2*r*sin(a/2);// n-eck oder a=α winkel zum r=radius
function sehne(n,r,a)=is_undef(a)?2*r*sin(180/n):2*r*sin(a/2);// n-eck oder a=α winkel zum r=radius
function t3(wert=1,grad=360,delta=0)=sin(($preview?anima?$t:tset:tset)*grad+delta)*wert;
function RotLang(rot=0,l=10,l2,z,e,lz)=let(
rot=is_undef(rot)?0:rot%360,
l=is_undef(l)?0:l,
l2=is_undef(l2)?l:l2,
lz=is_undef(lz)?l:lz
)
is_undef(z)?is_undef(e)?[sin(rot)*l,cos(rot)*l2]:
                        [sin(rot)*cos(e%360)*l,cos(rot)*cos(e%360)*l2,sin(e%360)*lz]:
            [sin(rot)*l,cos(rot)*l,z];

function Bezier(t,p0=[0,0],p1=[-20,20],p2=[20,20],p3=[0,0])=bezier(t,p0,p1,p2,p3);
function bezier(t,p0=[0,0],p1=[-20,20],p2=[20,20],p3=[0,0],p)=
let(
    omt = 1 - t,
    omt2 = omt * omt,
    t2 = t * t
)
is_list(p)?p[0]*(omt2*omt) + p[1]*(3*omt2*t) + p[2]*(3*omt*t2) + p[3]*(t2*t):
           p0*(omt2*omt) + p1*(3*omt2*t) + p2*(3*omt*t2) + p3*(t2*t);
           
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

function Kreis(r=10,rand=+5,grad=360,grad2,fn=fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0])=kreis(r,rand,grad,grad2,fn,center,sek,r2,rand2,rcenter,rot,t);




function kreis(r=10,rand=+5,grad=360,grad2,fn=fn,center=true,sek=true,r2=0,rand2,rcenter=0,rot=0,t=[0,0],z,d,endPoint=true,fs=fs,fs2,fn2,minF=1,fa=fa)=
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
[ // if 2D
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


//PolyH([for(i=[0:100])each kreis(z=i/10,r=5+sin(i*3.6)*2)],loop=fn +fn+2);

function kreisXY(r=5,grad=0)=[r*sin(grad),r*cos(grad)];//depreciated use RotLang
function KreisXY(r=5,grad=0)=kreisXY(r,grad);//depreciated use RotLang

function 5gon(b1=20,l1=15,b2=10,l2=30)=[[0,0],[b1,l1],[b2,l2],[-b2,l2],[-b1,l1]];

function ZigZag(e=5,x=50,y=5,mod=2,delta=+0,base=2,shift=0)=zigZag(e,x,y,mod,delta,base,shift);
function zigZag(e=5,x=50,y=5,mod=2,delta=+0,base=2,shift=0)=[for(i=[0:e*mod])[i%mod<mod/2+delta?i*x/(e*mod):i*x/(e*mod)+shift,i%mod<mod/2+delta?base:y],[x,0],[0,0]];

/** \page Functions
tangentenP() calculates the distance of a circle center for tangents
\param grad the center angle of the circle
\param rad the radius for the tangent
\param r  the radius of the circle 
\param deg alternative angle of the tangents
*/
function tangentenP(grad=60,rad=20,r=0,deg)=TangentenP(is_undef(deg)?grad:180-deg,rad,r);
function TangentenP(//Tangenten schnittpunkt ab Kreis mit radius rad
grad=150, // MittelpunktWinkel der Tangenten
rad=20, // Kreis radius
r=0// Kreislinien abstand von 0 (radius für Kreise)
)=
    let(
    c=sin(abs(grad)/2)*rad*2,//  Sekante 
    w1=abs(grad)/2,          //  Schenkelwinkel
    w3=180-abs(grad),        //  Scheitelwinkel
    a=(c/sin(w3/2))/2,    
    hc=grad!=180?Kathete(a,c/2):0,  // Sekante tangenten center
    hSek=Kathete(rad,c/2), //center Sekante
    tsRadius=r-rad+hc+hSek
    )
tsRadius;

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

function Hexstring(c)=str("#",Hex(c[0]*255),Hex(c[1]*255),Hex(c[2]*255));



function RotPoints(grad,points)=[for(i=[0:len(points)-1])RotLang(rot=atan2(points[i][0],points[i][1])+grad,l=norm([points[i][0],points[i][1]]),z=points[i][2])];


function negRed(num)=num<0?str("🔻",num):num==0?str("⚠",num):num; // display console text
function gradB(b,r)=360/(PI*r*2)*b; // winkel zur Bogen strecke b des Kreisradiuses r


/// angle of a chord
function gradS(s,r)=abs(s)>abs(2*r)&&(is_undef($idx)||!$idx)?echo("\t⭕ ‼ gradS s > diameter (2×r) max ❗")180*sign(s)*sign(r):abs(s)>abs(2*r)?180*sign(s)*sign(r):asin(s/(2*r))*2;// winkel zur Sehne s des Kreisradiuses r

/// radius of the circle that has chord s 
/**
\param s length of the chord
\param n for a n-polygon
\param a if you have the angle 
*/
// Radius  zur Sehne
function radiusS(s,n,a,r)=(s/2)/(sin((is_undef(n)? is_undef(a)?gradS(s,r)
                                                              :a
                                                 :360/n)/2));


/// circumcircle radius for triange s=chord h=height
/** \name radiusSH \page functions
\param s chord
\param h height
*/
function radiusSH(s,h)=((s/2)^2+h^2)/(2*h);

/// distance chord s to center
function distS(s,r,n,a)=kathete(radiusS(s,n,a,r),s/2);//cos(gradS(s,r)/2)*r;

function runden(x,dec=2)=round(x*pow(10,dec))/pow(10,dec);//auf komastelle runden

//convert angle ↦ gradC 
function grad(grad=0,min=0,sec=0,h=0,prozent=0,gon=0,rad=0)=gradC(grad,min,sec,h,prozent,gon,rad);// compatibility as renamed gradC 
function gradC(grad=0,min=0,sec=0,h=0,prozent=0,gon=0,rad=0)=grad+h/24*360+min/60+sec/3600+atan(prozent/100)+gon/400*360+rad/(2*PI)*360;

function inch(inch=1)=inch*25.4;
function kreisbogen(r,grad=360)=PI*r*2/360*grad;
/// calculationg fragment number from fraqment size
function fs2fn(r,grad=360,fs=fs,minf=3,fa=fa)=
  let(
    fs=max(is_undef(fs)?$fs:fs,0.001),
    fa=is_undef(fa)?$fa:fa
  )
  ceil(
    min(
      max(
        minf,
        PI*abs(r)*2/360*abs(grad) / fs
      ),
      1 / fa * abs(grad)
    )
  );

function clampToX0(points,interval=minVal)=is_list(points[0])?[for(e=points)[abs(e[0])>interval?e[0]:0,e[1]]]:
    [abs(points[0])>interval?points[0]:0,points[1]];
  
// angle between two points used for e.g. Bezier
  vektorWinkel= function(p1=[0,0,0],p2=[0,0,0])
  let(p1=v3(p1),p2=v3(p2))
  
     p1==p2?[0,0,0]:[ 
            -acos((p2.z-p1.z)/norm(p2-p1))+90,
            0,
            atan2(p2.y-p1.y,p2.x-p1.x)-90
            ];




function v3(v)= [
is_num(v.x)?v.x:is_num(v)?v:0,
is_num(v.y)?v.y:0,
is_num(v.z)?v.z:0,
 ];


/* org
function v3org( v ) =
       is_num(v.y)?is_num(v.z)?len(v)==3?v:  // make everything to a vector3
                                          [v.x,v.y,v.z]: // shorten if len >3
                            concat(v,[0]):
                  concat(v,[0,0]);
                  
                  
 v=[1,undef,"a",2];
 echo(v3(v),v3org(v));
// */
                



 
 

// list of parent modules [["name",id]]
function parentList(n=-1,start=1)=  is_undef($parent_modules)||$parent_modules==start?undef:[for(i=[start:$parent_modules +n])[parent_module(i),i]];

// kleinster teiler
teiler = function (n,div=2) (n%div)?div>n?n:
                                         teiler(n=n,div=div+1):
                                  div;



// generates G-Code (G1 x,y,(z),(e),(f))
gcode=function(points,f,chunksize=600,i)
let(i=is_undef(i)?len(points)-1:i,
chunk=function(pos=0,end) (pos+1)>end?str(chunk(pos=pos-1,end=end),
"\nG1 X",
points[pos].x,
" Y",points[pos].y,
len(points[pos])>2?str(" Z",points[pos].z,""):"",
len(points[pos])>3?str(" E",points[pos][3],""):"",
is_num(f)||len(points[pos])>4?str(" F",len(points[pos])==5?points[pos][4]:f):"",""):""
)
i>= 0?str(gcode(i=i-chunksize,chunksize=chunksize,points=points,f=f),chunk(i,max(0,i-chunksize))):"";


function bool(n,bool)= b(n,bool);
function b(n,bool)=  is_list(n)?[for(i=[0:len(n)-1])b(n[i],bool)]:
                               is_num(n)?bool||is_undef(bool)?n?true:
                                                                false:
                                                              n?n:
                                                                0:
                                         bool?n?true:  // n = bool
                                                false:
                                              n?1:
                                                0;

/*
echo(b(1),b(true))
echo(boolTrue=b(1,true),b(true,true));
echo(boolFalse=b(1,false),b(true,false));
// */

function scaleGrad(grad=45,h=1,r=1)=assert(grad!=0)max(0,(r-(h/tan(grad)))/r);

function is_parent(parent= needs2D, i= 0)=
is_list(parent)?is_num(search(parent,parentList())[i])?true:
                                                      i<len(parent)-1?is_parent(parent=parent,i=i+1):
                                                                      false:
                is_num(search([parent],parentList())[0]);


// multmatrix vector for point multiplications

/*
[Scale X]          [Shear X along Y]  [Shear X along Z]  [Translate X]
[Shear Y along X]  [Scale Y]          [Shear Y along Z]  [Translate Y]
[Shear Z along X]  [Shear Z along Y]  [Scale Z]          [Translate Z]
*/


m = function (r=[0,0,0], t=[0,0,0], s=[1,1,1])//t2=[0,0,0],
let(
s=is_num(s)?[s,s,s]:
            len(s)==2?concat(s,[1]):
                      s,
r=is_num(r)?[0,0,r]: is_list(r)?len(r)==3?r:v3(r) : [0,0,0],
t=is_list(t)?len(t)==2?concat(t,[0]):len(t) == 3?t:v3(t):v3(t),
//t2=len(t2)==2?concat(t2,[0]):t2,

  rx = function (x)[
  [1,     0,      0, t.x],
  [0,cos(x),-sin(x), t.y],
  [0,sin(x), cos(x), t.z],
  [0,0,0,0]
  ],

  ry = function (y) [
  [ cos(y), 0, sin(y), t.x],
  [0      , 1, 0     , t.y],
  [-sin(y), 0, cos(y), t.z],
  [0,0,0,0]
  ],

  rz = function (z) [
  [cos(z), -sin(z), 0, t.x],
  [sin(z),  cos(z), 0, t.y],
  [0     ,       0, 1, t.z],
  [0,0,0,0]
  ],
  
  
/*
  mt = function (t2=[0,0,0])[
  [1, 0, 0, t2.x],
  [0, 1, 0, t2.y],
  [0, 0, 1, t2.z],
  [0, 0, 0, 0]
  ],
 */
  ms = function (s=[ 1, 1, 1],t=t)[
  [s.x, 0, 0, t.x],
  [0, s.y, 0, t.y],
  [0, 0, s.z, t.z],
  [0, 0, 0, 0]
  ],
  out=rz(r.z)*ry(r.y)*rx(r.x)*ms(s) // *mt(t2)*
)
out;




function mPoints(points=[0,0], r=[0,0,0], t=[0,0,0], s=[1,1,1])=
let(
pointsI=is_list(points[0])?points:[points],
dimension=len(pointsI[0]),
out=
[for(i=pointsI)m(r=r,t=t,s=s)*
  concat(i,
    dimension==3?[1]:concat([for(dim=[1:3-dimension])0],[1]) // add to vector
  )
    +[for(dim=[0:dimension-1])0]] // mask vector
)is_list(points[0])?out:out[0];


//version prior β22|130
function mPointsORG(points=[0,0], r=[0,0,0], t=[0,0,0], s=[1,1,1])=
let(
pointsI=is_list(points[0])?points:[points],
dimension=len(pointsI[0]),
out=
[for(i=[0:len(pointsI)-1])m(r=r,t=t,s=s)*
  concat(pointsI[i],
    dimension==3?[1]:concat([for(dim=[1:3-dimension])0],[1]) // add to vector
  )
    +[for(dim=[0:dimension-1])0]] // mask vector
)is_list(points[0])?out:out[0];





//echo(mPoints([[0,1]],r=50) );


  /*
    rot=[+27,+28,+75];
    sc=[1.3,0.4,1.3];
    tr=[14,15,13];
p=[
   [-10,  0,  0], 
   [ 10,  0,  0], 
   [  0, 10,  0], 
   [  0,-10,  0], 
   [  0,  0, 10], 
   [  0,  0,-10]
  ];

a=[[for (i=[0:len(p)-1])i]];

T(0)Color(alpha=.5)scale(1.0001)hull()polyhedron(p2,a);
rotate(rot)translate(tr)scale(sc)hull()polyhedron(p,a);

p2=mPoints(mPoints(p,t=tr,r=rot,s=sc),t=[0,0]);

// */

function pathPoints(points=[[0,0,0],[0,10,0],[10,0,0]],path=[[0,0,0],[0,+10,10]],twist=0,scale=1,open=true,2D=false,rev=false)=
  let(
    pathLen=len(path)-1,
    scale=is_list(scale)?scale:[scale,scale],
    points=2D?[for(iPoint=points)[iPoint.x,iPoint.y]]:
              len(points[0])==3?points:[for(iPoint=points)concat(iPoint,0)]
    )
  [for (i=rev?[pathLen:-1:0] : [0:pathLen],jPoints=points)
    mPoints (  mPoints(jPoints,r=i*twist/pathLen) ,
      r=vektorWinkel( path[ open? max(0,i-1): (i==0?pathLen -1:i-1)], path[open?min(i+1,pathLen):(i+1)%pathLen])+[90,0,0],
      s=[1+i*(-1+scale.x)/pathLen,1+i*(-1+scale.y)/pathLen])
    + v3(path[i])];

//version prior β22|130

function pathPointsORG(points=[[0,0,0],[0,10,0],[10,0,0]],path=[[0,0,0],[0,+10,10]],twist=0,scale=1,open=true)=
  let(pathLen=len(path)-1,
      scale=is_list(scale)?scale:[scale,scale])
  [for (i=[0:pathLen],j=[0:len(points)-1])
    mPoints ( v3( mPoints(points[j],r=i*twist/pathLen) ) ,
      r=vektorWinkel( path[ open? max(0,i-1): (i==0?pathLen -1:i-1)], path[open?min(i+1,pathLen):(i+1)%pathLen])+[-90,0,0],
      s=[1+i*(-1+scale.x)/pathLen,1+i*(-1+scale.y)/pathLen])
    + v3(path[i])];    
    
    


function octa   (s=1) =
let(
s=is_list(s)?s:
            [s,-s,s,-s,s,-s]
)
[
  [ s[1%len(s)],  0,  0], 
  [ s[0%len(s)],  0,  0], 
  [  0, s[2%len(s)],  0], 
  [  0, s[3%len(s)],  0], 
  [  0,  0, s[4%len(s)]], 
  [  0,  0, s[5%len(s)]]
];

//hull() polyhedron(octa(),[[for(i=[0:len(octa())-1])i]]);

/** \name quad \page Functions
quad() creates points for a square with rounded edges
\param x  size x or [x,y]
\param y  size y
\param r  radius optional list
\param t  translate points
\param z  add z ↦ vector3
\param center center quad points
\param fn fragment number optional list
*/

function quad (x=10,y,r,t=[0,0], z,center=true,fn=fn) = 
 let(
 y=is_list(x)?x.y:is_undef(y)?x:y,
 x=is_list(x)?x.x:x,
 rdg=runden(min(x,y)/PHI/2,2),
 r=is_list(r)?r:is_undef(r)?[rdg,rdg,rdg,rdg]:[r,r,r,r],
 tC=t+(center?[0,0]:[x,y]/2),
 fn=is_list(fn)?fn:fn/4*[1,1,1,1]
) 
concat(
  arc(t=[-x/2 +r[0%len(r)], -y/2 +r[0%len(r)] ]+tC,r=r[0%len(r)],deg=90,rot=180,fn=fn[0%len(fn)],z=z),
  arc(t=[ x/2 -r[1%len(r)], -y/2 +r[1%len(r)] ]+tC,r=r[1%len(r)],deg=90,rot=270 ,fn=fn[1%len(fn)],z=z),  
  arc(t=[ x/2 -r[2%len(r)],  y/2 -r[2%len(r)] ]+tC,r=r[2%len(r)],deg=90,rot=0  ,fn=fn[2%len(fn)],z=z),
  arc(t=[-x/2 +r[3%len(r)],  y/2 -r[3%len(r)] ]+tC,r=r[3%len(r)],deg=90,rot=90,fn=fn[3%len(fn)],z=z)
);

function quadR (x=10,y,r,t=[0,0], z,center=true,fn=fn) = 
 let(
 y=is_list(x)?x.y:is_undef(y)?x:y,
 x=is_list(x)?x.x:x,
 rdg=runden(min(x,y)/PHI/2,2),
 r=is_list(r)?r:is_undef(r)?[rdg,rdg,rdg,rdg]:[r,r,r,r],
 tC=t+(center?[0,0]:[x,y]/2),
 fn=fn/4+0
) 
concat(
  kreis(t=[ x/2 -r[0],  y/2 -r[0] ]+tC,r=r[0],rand=0,grad=90,rot=0  , center=false,fn=fn,z=z),
  kreis(t=[ x/2 -r[1], -y/2 +r[1] ]+tC,r=r[1],rand=0,grad=90,rot=90 , center=false,fn=fn,z=z),
  kreis(t=[-x/2 +r[2], -y/2 +r[2] ]+tC,r=r[2],rand=0,grad=90,rot=180, center=false,fn=fn,z=z),
  kreis(t=[-x/2 +r[3],  y/2 -r[3] ]+tC,r=r[3],rand=0,grad=90,rot=270, center=false,fn=fn,z=z)
);

/*
polygon(quad(x=15,fn=16,t=[5,5],r=[1,2,3,4],center=false));
points=[for(i=[0:10])each quad(z=i,r=1.000+sin(i*36-90)*1,fn=36)];
PolyH(points,loop=fn +4, flip=false );
Points(points,loop=(fn+4)*3,start=(fn+4)*5,hull=0);
// */


/** \page Functions
stern() creates points for a star shape
\name stern
\param e number of tips
\param r1 tip radius
\param r2 groove radius
\param mod add points
\param delta shifts junction of r1 to r2 to next point
*/

//polygon(stern(mod=9,delta=-1));

function stern (e=5,r1=10,r2=5,mod=2,delta=+0,z)=
let(
  schritt=360/(e*mod))
  is_num(z)?
    [for(i=[0:e*mod-1])
    i%mod<mod/2+round(delta)?[sin(i*schritt%360)*r1,cos(i*schritt%360)*r1,z]:
                             [sin(i*schritt%360)*r2,cos(i*schritt%360)*r2,z]
    ]:
    [for(i=[0:e*mod -1])
      i%mod<mod/2+round(delta)?[sin(i*schritt%360)*r1,cos(i*schritt%360)*r1]:
                               [sin(i*schritt%360)*r2,cos(i*schritt%360)*r2]
    ];



//polygon(stern());

/** \page Functions
sternDeg() creates points for a star shape with angle
\name sternA
\param e number of tips
\param r tip radius
\param deg tip angle ↦ r2
\param r2 inner tip radius (optional)
\param z for 3D points
\param rot rotation
*/

function sternDeg(e=4,r=10,deg=90,r2,z,rot=0)=
let(
  step=assert(e>0,"e must be positive")360/e/2,
  a=(e-2)*180/e,
  r2=is_undef(r2)?assert(deg<a+180,str("deg for e=",e,">=",a+180))Inkreis(e,r)-Sehne(e,r)/2*tan(180-deg/2+a/2):r2,
  rot=90+rot
)
is_num(z)?[for(i=[0:e*2-1])[each([cos(i*step+rot),sin(i*step+rot)]*(i%2?r2:r)),z]]
          :[for(i=[0:e*2-1])[cos(i*step+rot),sin(i*step+rot)]*(i%2?r2:r)]
;

//Points(sternDeg(e=12,deg=120),hull=true);
//PolyH([for(z=[0:5])each sternDeg(e=12,z=z)],loop=24,flip=false);





function wStern(f=5,r=1.65,a=.25,r2,fn=fn,rot=0,z)=
let(step=360/fn,
    a=is_undef(r2)?a:(r2-r)/2,
    r=is_undef(r2)?r:r+a)
[for(i=[0:fn])let(i=i%fn)is_undef(z)?
          [(r+a*cos(f*i*step+rot))*sin(i*step),(r+a*cos(f*i*step+rot))*cos(i*step)]:
          [(r+a*cos(f*i*step+rot))*sin(i*step),(r+a*cos(f*i*step+rot))*cos(i*step),z]];

// polygon (wStern(f=5,r=1.65,a=.25,rot=180));

function tetra(r=1)=
  let(
  r=is_list(r)?r:[r,r,r,r]
  )
[
[ 0, 0, r[0]],
for(i=[0:2])[sin(120*i)*sin(tw)*r[i+1],cos(120*i)*sin(tw)*r[i+1],cos(tw)*r[i+1]]
];

//hull()polyhedron(tetra(),[[0,1,2,3]]);


function superellipse(n=2.5,r=10,z,fn=fn)=
let(
  r2=is_undef(r2)?is_list(r)?r.y:
                             r:
                  r2,
  r=is_list(r)?r.x:r,
  
    n11=is_list(n)?n[0]:n,
    n12=is_list(n)?n[1]:n,
    n13=is_list(n)?n[2]:n,
    n14=is_list(n)?n[3]:n,
    n2=is_undef(n2)?n:n2,
    n21=is_list(n2)?n2[0]:n2,
    n22=is_list(n2)?n2[1]:n2,
    n23=is_list(n2)?n2[2]:n2,
    n24=is_list(n2)?n2[3]:n2
   )
is_undef(z)?[for(f=[0:fn])let(i=f%fn*360/fn)each[
    if(i<=90)[r*pow(sin(i),2/n11),r2*pow(cos(i),2/n21)],
    if(i>90&&i<=180)[r*pow(abs(sin(i)),2/n12),-r2*pow(abs(cos(i)),2/n22)],
    if(i>180&&i<=270)[-r*pow(abs(sin(i)),2/n13),-r2*pow(abs(cos(i)),2/n23)],
    if(i>270&&i)[-r*pow(abs(sin(i)),2/n14),r2*pow(abs(cos(i)),2/n24)],
    ]
    ]:
    [for(f=[0:fn])let(i=f%fn*360/fn)each[
    if(i<=90)[r*pow(sin(i),2/n11),r2*pow(cos(i),2/n21),z],
    if(i>90&&i<=180)[r*pow(abs(sin(i)),2/n12),-r2*pow(abs(cos(i)),2/n22),z],
    if(i>180&&i<=270)[-r*pow(abs(sin(i)),2/n13),-r2*pow(abs(cos(i)),2/n23),z],
    if(i>270&&i)[-r*pow(abs(sin(i)),2/n14),r2*pow(abs(cos(i)),2/n24),z],
    ]
    ];


//polygon(superellipse(r=[5,2]));
//Coil(points=superellipse(r=[3,2],n=3.5));

// wall calculates perimeter number according to nozzle size for "soll"mm

function wall(soll=.5,min=1.25,even=false,line=line,nozzle,name)=
  let (
    line=is_num(nozzle)?nozzle:line,
    isoll=abs(soll),
    perimeterHi=ceil(isoll/line),
    perimeterLow=floor(isoll/line),
    min=isoll<line(2,line=line)?max(min,runden(isoll/line,2)):min,
    walls=max(min,even?max(2,perimeterHi%2?perimeterLow:perimeterHi) : round(isoll/line))
    )
  (is_undef($idx)||$idx==0)&&$info||name?echo(name=name,perimeterShells=walls,soll=soll,ist=line(walls,line=line),min=min)line(walls, line=line)*sign(soll) : line(walls, line=line)*sign(soll);
  
  
  
/*
function starOrg(e=5,r1=10,r2=5,grad=[0,0],grad2,radial=false,fn=0,z,angle=360,rot=0)=
let(
  grad=is_num(grad)?[grad/2,grad/2]:grad,
  grad2=is_undef(grad2)?[grad[1],grad[0]]:is_num(grad2)?[grad2/2,grad2/2]:grad2,
  fn=max(1,round(fn)),
  
  deg=angle/(e*2),
  diff=(grad[1]-grad[0])/2,
  diff2=(grad2[1]-grad2[0])/2,

  
  winkel=((radial?[1,1]*angle/4/e+ [grad.x,grad.y]:grad)+[diff,-diff])/fn,
  winkel2=((radial?[1,1]*angle/4/e - [grad.y,grad.x]:grad2)+[diff2,-diff2])/fn
  )
[for(i=[0:e*2 -1], w=[0:1], ifn=[+1:fn +0])  RotLang((deg*i+rot +(i%2?diff2:diff))%360  + ( i%2?  w? winkel2[1]*ifn : - winkel2[0]*(fn-ifn+1) :
                                                                      w?  winkel[1]*ifn: - winkel[0]*(fn-ifn+1) ),
                                                 i%2?r2:r1,z=z)];

// */




function star(e=5,r1=10,r2=5,grad=[0,0],grad2,radial=false,fn=0,z,angle=360,rot=0)=
let(
  r1=is_num(r1)?[r1]:r1,
  r2=is_num(r2)?[r2]:r2,
  grad=is_num(grad)?[grad/2,grad/2]:grad,
  grad2=is_undef(grad2)?[grad[1],grad[0]]:is_num(grad2)?[grad2/2,grad2/2]:grad2,
  centerEck=fn?0:1,
  fn=max(+1,round(fn)),
  
  deg=angle/(e*2),
  diff=(grad[1]-grad[0])/2,
  diff2=(grad2[1]-grad2[0])/2,

  
  winkel=((radial?[1,1]*angle/4/e+ [grad.x,grad.y]:grad)+[diff,-diff])/(fn ),
  winkel2=((radial?[1,1]*angle/4/e - [grad.y,grad.x]:grad2)+[diff2,-diff2])/(fn )
  )
[for(i=[0:e*2 -1], w=[0:1], ifn=[centerEck:fn ]) 
  RotLang((deg*i+rot +(i%2?diff2:diff))%360  + ( i%2?  w? winkel2[1]*ifn : - winkel2[0]*(fn-ifn +centerEck) :
                                                       w? winkel [1]*ifn : - winkel [0]*(fn-ifn+centerEck) ),
          i%2?r2[floor(i/2)%len(r2)]:r1[floor(i/2)%len(r1)],z=z)];


//polygon(concat(star(e=4,angle=250),star(angle=70,e=4,r1=4,r2=3,rot=-90)));
/*
polygon(starOrg(e=3,angle=120*3,rot=-60,radial=true,fn=10));
T(20)polygon(starOrg());
T(0,20)polygon(starOrg(angle=180,fn=3,grad=4));

Tz(.5)Color(){
polygon(star(e=3,angle=120*3,rot=-60,radial=true,fn=10));
T(20)polygon(star());
T(0,20))polygon(star(angle=180,fn=3,grad=4));
}

// */


// vector multiplication  
function vMult(v1=[1],v2=1)=
  is_num(v1)||is_num(v2)?v1*v2:
                         [for(i=[0:min(len(v1),len(v2))-1])vMult(v1[i],v2[i])];

/// sum up vector constituents
//echo( vSum([1,1,1]) );
function vSum(v,start=0,end) = 
  let(v=is_list(v)?v:[v], end = is_undef(end)?len(v)-1:min(len(v)-1,end) )
    start<end? v[start]+ vSum(v,start+1,end):
               v[start];


// NACA profile points

function naca(l = 10, naca, m=+0.00, p=0.0,t=0.12,fn=fn,dir=0,asymP,z)=
 let(
  m=is_undef(naca)?m:(naca-naca%1000)/100000,
  p=is_undef(naca)?p:(naca-(naca-naca%1000)-naca%100)/1000,
  t=is_undef(naca)?t:(naca%100)/100,
 range=dir?[0:1:fn/2-1]:[fn/2-1:-1:0],
 asymP=is_undef(asymP)?10*(1-p):asymP,// asymetric point distribution
 naca_func=function(x,t=t) +5*t*(0.2969*sqrt(x) - 0.1260*x - 0.3516*pow(x,2.0) + 0.2843*pow(x,3) - 0.1015*pow(x,+4)),
 naca_t=function(t=t,fn=fn/2,l=l,y=dir?1:-1)
  let(
   // c=l/(fn -1),
   // x=1/(fn-1)
  )
  [ for(n=range)
    let(
    x=1/((fn-1)*(asymP+1)-asymP*n)
    )
    concat([n*x*l,naca_func(x*n,t=t)*y*l],is_undef(z)?[]:z) ],

 naca_camber = function(m=m,p=p,fn=fn/2,l=l,sig=1,xScale=1)
  let(
    //c=l/(fn-1),
    //x=1/(fn-1)
    )
  [ for(n=range) 
    let(
    x=1/((fn-1)*(asymP+1)-asymP*n)
    )
    concat([n*x*l*xScale,(n*x<p?m/p^2 * (2 * p*x*n - (n*x)^2):
                                m/(1-p)^2 * ((1-2*p) + 2*p*x*n - (n*x)^2))
                          *sig*l],is_undef(z)?[]:0)
  ]
 )
//  WIP not using 4. for the realitonship http://www.aerospaceweb.org/question/airfoils/q0041.shtml
//x=x - sin(atan(dy_camber/dx) ) * naca_t.x 
//y=naca_camber.y + cos(atan(dy_camber/dx) ) * naca_t.x 
dir?naca_camber(xScale=0)+naca_t():concat(naca_camber(xScale=0)+naca_t(),naca(l=l,m=m,p=p,t=t,fn=fn,dir=1,asymP=asymP,z=z));


function pathLength(points,start=0,end=0,close=0,length=0)= let(end=end>start?end:len(points)-(close?0:1))
  start<end?pathLength(points=points,start=start+1,end=end,close=close,
  length=length+norm(points[(start+1)%len(points)]-points[start])):length;

/*
p=kreis(5,rand=0,fn=6,endPoint=1);
echo(pathLength(p,close=0),PI*10);
Points(p);
// */

/** \name string2num
\page Functions
string2num() converts charcter from a string into numbers
\param string input string
\param start start of extraction
\param length number of characters to extract
*/
function string2num(string,start=0,length)=let(start=min(len(string),max(0,start)),length=min(is_undef(length)?len(string):length,len(string)-start))length?(ord(string[start])-48)*pow(10,length-1)+string2num(string,start+1,length-1):0;



/** \name stringChunk
\page Functions
stringChunk() separates charcter from a string
\param txt input string
\param start start of extraction
\param length number of characters to extract
*/

function stringChunk(txt,start=0,length,string="")=
  let(
    start=abs(start),
    length=is_undef(length)?len(str(txt))-start:length
  )
  len(string)<length&&start<len(txt)?stringChunk(txt=txt,length=length,start=start+1,string=str(string,str(txt)[start])):string;

//echo(stringChunk(1234,start=0));
/** \name nut
\page Functions
nut() creates points for a groove dovetail or notch
\param e elements number of notches
\param es distance of notches
\param a  top length
\param b  bottom length (can be undef)
\param base base height
\param h  height of notches
\param s length of object
\param shift move a in x
\param grad  angle (can be list if b is undef)
\param z  add z value to points
\param t translate
*/
//polygon(nut(base=2));

function nut (e=2,es=10,a=6,b,base=1,h=1,s,shift=0,grad,z,t=0)=
  let(
  t=v3(t),
  s=assert(grad!=0)is_undef(s)?is_num(grad)&&is_num(b)?e*(a+b-2*h*tan(90+grad)):
                                       is_undef(es)?assert( is_num(b) && is_num(a),"define a + b")a+b:
                                                    e * es:
                s,
  
  es=is_num(grad)&&is_num(b)?a+b-2*h*tan(90+grad):
                  s/e,

  b=is_undef(grad)?is_undef(b)?(es-a)/2*[1,1]:
                               b/2*[1,1]:
                   is_list(grad)?[h*tan(90+grad[0])+(es-a)/2,h*tan(90+grad[1])+(es-a)/2]:
                                 [h*tan(90+grad)+(es-a)/2,h*tan(90+grad)+(es-a)/2]
  )
 is_num(z)?
   [[s,base,z]+t,[s,0,z]+t,[0,0,z]+t,[0,base,z]+t,
  for(i=[0:e-1])each[
      [b[0]+i*es,base,z]+t,    
      [es/2-a/2+shift+i*es,h+base,z]+t,
      [es/2+a/2+shift+i*es,h+base,z]+t,
      [(es-b[1])+i*es,base,z]+t]
      ]:

   [[s,base]+t.xy,[s,0]+t.xy,[0,0]+t.xy,[0,base]+t.xy,
  for(i=[0:e-1])each[
      [b[0]+i*es,base]+t.xy,    
      [es/2-a/2+shift+i*es,h+base]+t.xy,
      [es/2+a/2+shift+i*es,h+base]+t.xy,
      [es-b[1]+i*es,base]+t.xy]
      ];
      
      
/** \name involute
\page Functions
involute() creates points for an involute on a circle
\param r radius circle
\param h height of the involute ↦ grad
\param grad degree of the circle segment
\param fn,fs fraqments or size
\param rot rotation
\param rev reverse point order
\param delta additional change towards end
\param z  creates vector3 points with z height 
*/
//polygon(involute());


function involute(r=10,h=5,grad,fn=fn,rot=0,rev=0,delta=0,z,fs=fs)=
let(
  grad=grad?grad:360/(PI*2*r) * sqrt( 2*r*h+h^2),
  fn=is_num(fn)&&fn>0?fn:abs(ceil(PI*2*r/fs/360*grad)),
  step=grad/(fn),
  deltaStep=delta/(fn)
)
is_num(z)?
  [for(i=rev?[fn:-1:0] : [0:fn]) [sin(i*step+rot), cos(i*step+rot),0]*r + [sin(i*step-90+rot), cos(i*step-90+rot), 0] * (2*PI*r/360*i*step+i*deltaStep)+[0,0,z]]:
  [for(i=rev?[fn:-1:0] : [0:fn]) [sin(i*step+rot), cos(i*step+rot)]*r + [sin(i*step-90+rot), cos(i*step-90+rot)] * (2*PI*r/360*i*step+i*deltaStep)]
;

function riemen(r1=5,r2=10,tx=20,fn=fn,fs=fs,z,center=false)=
let(a=asin((r2-r1)/tx))
concat(kreis(r=r1,rand=0,grad=180 - 2*a,center=true,fn=fn,fs=fs,z=z,t=[center?-tx/2:0,0]),kreis(r=r2,rand=0,grad=180 + 2*a,t=[center?tx/2:tx,0],rot=180,center=true,fn=fn,fs=fs,z=z));



//polygon(kreisSek(grad=[60,81]*1,r=[+4,8],h=20,center=+0,rev=1,mitte=5));


function kreisSek(r=10,grad=90,h=0,mitte=0,fn=fn,center=true,mirror=false,rev=0,t=[0,0],z)=
let(
t=v3(t),
tL=t+[center?-mitte/2:0,0,0],
tR=t+[center?mitte/2:mitte,0,0],
fn=is_list(fn)?fn:[ceil(fn/2),ceil(fn/2)],
r=is_list(r)?r:[r,r],
grad=is_list(grad)?[grad[0]%360,grad[1]%360]:[grad/2%360,grad/2%360],

hSekL=r[0]-cos(grad[0])*r[0],
hSekR=r[1]-cos(grad[1])*r[1],
h=max(h,hSekL,hSekR),

hyL=max(hSekL,hSekR,h)-hSekL,
hyR=max(hSekL,hSekR,h)-hSekR,

yL=-cos(grad[0])*r[0] + hyL,
yR=-cos(grad[1])*r[1] + hyR,
xL=center?0:sin(grad[0])*r[0],
//xR=center?0:sin(grad[1])*r[1],
hxL=grad[0]==0||grad[0]==180?0:hyL/tan(grad[0]),
hxR=grad[1]==0||grad[1]==180?0:hyR/tan(grad[1]),
y0L=[concat((center?[-sin(grad[0])*r[0]-hxL,0]:[0,0])+tL,is_undef(z)?[]:[z])],
y0R=[concat([sin(grad[1])*r[1]+hxR+(center?0:sin(grad[0])*r[0]+hxL),0]+tR,is_undef(z)?[]:[z])],


sekL=[for(i=rev?[fn[0]:-1:0]:[0:fn[0]])
  let(stepL=(i*(grad[0]/fn[0]) - grad[0])%360)
  is_undef(z)?[sin(stepL)*r[0]+(center?0:hxL+xL),(mirror?-1:1)*(cos(stepL)*r[0]+yL)]+tL:
              [sin(stepL)*r[0]+(center?0:hxL+xL),(mirror?-1:1)*(cos(stepL)*r[0]+yL),z]+tL
     ],
sekR=[for(i=rev?[fn[1]:-1:0]:[0:fn[1]])
  let(stepR=(i*(grad[1]/fn[1]) )%360)
  is_undef(z)?[sin(stepR)*r[1]+(center?0:hxL+xL),(mirror?-1:1)*(cos(stepR)*r[1]+yR)]+tR:
              [sin(stepR)*r[1]+(center?0:hxL+xL),(mirror?-1:1)*(cos(stepR)*r[1]+yR),z]+tR
     ]
)
!rev?concat(y0L,sekL,sekR,y0R)
:concat(y0R,sekR,sekL,y0L);




function sq (size=[10,10],fn=[10,10],diff=0,t=[0,0,0],z,center=true)=
  let (
    x=is_list(size)?size[0]:size,
    y=is_list(size)?size[1]:size,
    fnx=max(1,is_list(fn)?fn[0]:fn),
    fny=max(1,is_list(fn)?fn[1]:fn),
    diff=is_list(diff)?diff:[diff,diff,diff,diff],
    t=center?t:size/2+t,
    points=is_undef(z)?[
    for(i=[0:fnx-1])[-x/2+x/fnx*i,-y/2+i%2*-diff[0]]+t,
    for(i=[0:fny-1])[x/2+i%2*diff[1],-y/2+y/fny*i]+t,
    for(i=[0:fnx-1])[x/2-x/fnx*i,y/2+i%2*diff[2]]+t,
    for(i=[0:fny-1])[-x/2-i%2*diff[3],y/2-y/fny*i]+t
    ]:
    [
    for(i=[0:fnx-1])[-x/2+x/fnx*i,    -y/2+i%2*-diff[0],z]+v3(t),
    for(i=[0:fny-1])[x/2+i%2*diff[1], -y/2+y/fny*i,     z]+v3(t),
    for(i=[0:fnx-1])[x/2-x/fnx*i,      y/2+i%2*diff[2], z]+v3(t),
    for(i=[0:fny-1])[-x/2-i%2*diff[3], y/2-y/fny*i,     z]+v3(t)
    ]
  )
  points;
  
  //polygon(sq(center=0));
  
  
function bend (points,r=0,t=[0,0,0],rev=false)= [
  for (i= [0:len(points)-1])
    let(
      x=points[i].x+t.x,
      y=points[i].y+t.y,
      z=is_undef(points[0].z)?undef:points[i].z + t.z,//
      b=2*PI*(r?r:x),
      deg=b?360/b*y:0
    )
    rev? is_undef(z)?[norm([x,y]),b/360*atan2(y,x)]:[norm(x,y),b/360*atan2(x,y),z]
    
        :is_undef(z)?[sin(deg+90),cos(deg+90)]*x-v3(t):
                    concat([sin(deg+90),cos(deg+90)]*x,z)-v3(t)
    ]
    ;

/*
polygon(
  bend(
    bend(
      sq( center=1, t=[ 10, 0 ] ),
      r=10, rev=true
    ),
    r=10
  )
);

// */


/** \name scene
scene()  creates an array of t for animation scenes
##Example
translate([ scene(2)[0]*10,0])cube();  
translate([ scene(2)[1]*10,1])cube();

\param scenes number of scenes or segments
\param t  the counter 0-1 that is divided into scenes
*/
function scene(scenes=10,t=$t)=[for(i=[0:scenes-1])min(max(t*scenes-i,0),1)];


/** \name map
\brief maps value from range to range
\param val input value
\param from maps from range [from,to]
\param to   maps to range [from,to] 
\param constrain limit range
*/

function map(val=$t,from=[0,1],to=[0,1],constrain=true)=
  let (
     from=is_num(from[2])?[from[0],from[2]]:from,
     to=  is_num(to[2])  ?[to[0]  ,to[2]]  :to,
     
    diff1=from[1]-from[0],
    diff2=to[1]-to[0]
  )
  constrain?min(max(diff2/diff1*( val - from[0] )+to[0],min(to) ),max(to) ):
             diff2/diff1*(val-from[0])+to[0];
  
/** \page Functions
polyRund() replace points with arcs and offset
\name polyRund
\param points points input
\param r radius to round (can be list)
\param ir inner radius (if r is not list)
\param ofs offset of radii
\param delta change offset without radius
\param fn fs  fragments for arcs (can be lists)
\param minF minimum fragments
\param rev  if input has reversed point order
*/

/*  // \example
p=[
[0,0],
[10,0],
[10,10],
[5,2],
[0,10]
];
T(y=15)color("pink")polygon(polyRund(revP(p),delta=+0,r=+0.5,ir=1,ofs=1.0,rev=true));
polygon(polyRund(p,delta=+0,r=+0.5,ir=1,ofs=1));
// */
  
function polyRund(points,r=0,ir,ofs=0,delta=0,fn=12,fs,minF=1,rev=0)=
[for(p=[0:len(points)-1])
let(
      delta=rev?-delta:delta,
      ofs= rev? -ofs:ofs,
      fn=is_list(fn)?fn[p%len(fn)]:fn,
      fs=is_list(fs)?fs[p%len(fs)]:fs,
      ir=is_undef(ir)?r:ir,
      lp=len(points),
      pBef=points[(p+lp-1)%lp],
      pNow=points[p],
      pNex=points[(p+1)%lp],
      grad1=atan2(pBef.x-pNow.x,pBef.y-pNow.y),
      grad2=atan2(pNex.x-pNow.x,pNex.y-pNow.y),
      gradDiff=grad1-grad2,
      grad=gradDiff<0?abs(gradDiff):360-gradDiff,
      gradSup=360-grad,
      tPgrad=grad2+gradSup/2,
      r=(is_num(r)?((rev?-grad:grad)<180? r : ir):r[p%len(r)]),
      rk=grad<180?min(-r-ofs,0):max(r-ofs,0),
      tPr=(rk==0?ofs:r),
      tP=[sin(tPgrad),cos(tPgrad)]*tangentenP(grad=gradSup-180,r=tPr,rad=tPr)*(grad<180? -1:+1),
      tPDelta=[sin(tPgrad),cos(tPgrad)]*tangentenP(grad=gradSup-180,r=delta,rad=delta)
      
   )
each kreis(r=rk,rand=0,rot=grad1+90,grad=(grad-180),t=pNow+tP+tPDelta*sign(delta),center=false,z=pNow.z,fn=fn,fs=fs,minF=minF)
];
  
/** \page Functions
revP() reverse points order
*/
function revP(points)=[for(p=[len(points)-1:-1:0])points[p]];

/** \page Functions
arc() creates points on an arc
\param r radius
\param deg angle optional [start,end]
\param r2 end radius at deg
\param rot rotate
\param t   translate
\param z   add z value ⇒vec3
\param fn fragments
\param rev reverse point order
*/

//polygon(arc(deg=45));

function arc(r=10,deg=90,r2,rot=0,t=[0,0,0],z,fn=36,rev=false)=
  let(
    deg=is_num(deg)?[0,deg]:deg,
    step=(deg[1]-deg[0])/fn
  )
  [for (i=rev?[fn:-1:0]:[0:fn])
    let(
      r=is_undef(r2)?r:r+(r2-r)/fn*i
    )
    is_undef(z)?[cos(i*step +rot +deg[0])* r,sin(i*step +rot +deg[0]) * r] + [t[0],t[1]]:
                [cos(i*step +rot +deg[0])* r,sin(i*step +rot +deg[0]) * r,z] + v3(t)
  ];

  
/** /page Functions
pt() give the typographic point size in mm
\param pt number of points  12pt ⇒ pt(12) = 1 pica = 4.2333mm
*/

function pt(pt=1)=25.4/72*pt;


/** /name parabel
/page Functions
parabel() gives points of a parabel
\param x  width
\param a  height ratio
\param fn fragments
\param exp exponent
\param bp  focal point
\param lap overlap outside points
\param t  translate points
\param rev reverse points
*/

function parabel(x=1,a=1,fn=fn,exp=2,bp=false,lap,t=[0,0],rev=false)=
let(
lap=is_num(lap)?[lap,lap]:lap,
t=is_num(t)?[t,0]:is_list(t)?len(t)>1?t.xy:[is_num(t.x)?t.x:0,0]:[0,0]
)
[
if(is_list(lap)&&!bp)[0,-lap.y]+t,
(bp&&exp==2?[0,1/(a*4)]:
            is_list(lap)?[x+lap.x,-lap.y]:
                         [0,a*x^exp])
+t,
if(is_list(lap)&&!bp)[x+lap.x,a*x^exp]+t,
  for(i=rev?[0:fn]:[fn:-1:0])let(step=x/fn)[i*step,a*(i*step)^exp]+t
];



// smooth Transition over i segements
function transition(i,fn=fn)= 0.5 + cos(min(abs(i),fn)*180/fn)/2;

//for(i=[0:fn])T(i)cube([1,1,1+transition(i)*19]);





}//fold // ΔΔ END functions ΔΔ

{ // Help –––––––––––––––––––––––––––––––––––––––––––––––––––––––

//$fn=fn;
$fs=fs;
$fa=fa;
help=$preview?anima?false:helpsw:false;

helpHelper= helpsw==1||helpsw==true?true:false;    //Helper
helpMod=  helpsw==2||helpsw==true?true:false;     // Objektmodifikatoren
help2D=   helpsw==3||helpsw==true?true:false;    // 2D Objekte
helpB=    helpsw==4||helpsw==true?true:false;   //Basis help
helpP=    helpsw==5||helpsw==true?true:false;  //Produkte help
helpFunc= helpsw==6||helpsw==true?true:false; //Funktionen
helpGen=  helpsw==7||helpsw==true?true:false;//Generator



//helpM=help;//module help old
$helpM=help;//module help

$t=$preview?anima?$t:tset:tset;
t=$t;
t0=$t*360%360;
t1=sin($t*360);
t2=sin($t*180);

$vpr=vp?is_num(vpr)?[0,0,vpr]:vpr:$vpr;    
$vpt=vp?vpt:$vpt;
$vpd=vp?vpd:$vpd;
$vpf=vp?vpf:$vpf;


messpunkt=$preview?$info:false;//1 für aktiv
$messpunkt=messpunkt;
//n=0;

} // END Help

if(menu)Menu(); // creates Menu

module Menu(){
if (texton&&$preview)%rotate($vpr)T(20,-30,25)color("slategrey")text(str(name),font="DejaVusans:style=bold",halign="left",size=is_num(texton)?texton:$vpd/75,$fn=100);
    
if (bed&&!anima)color(alpha=.1)%Rand(-5,delta=1)square(printBed);
if(version()[0]<2021)
echo(str("<p style=background-color:#ccccdd>",
"<ul>     •••••••••••••••••••••••••• UB (USER libary v2019) included! <a href=http://v.gd/ubaer> v.gd/ubaer </a> •••••••••••••••••••••••••\n",
"••• Version: β",Version," v ",version(),"  ——  Layer: ",layer," Nozzle ∅: ",nozzle," ••• fn=",fn,"••• Spiel: ",spiel," •••"));

else if(!anima) { echo(str("•••••• UB (USER library v2022) included! v.gd/ubaer  ••••••"
,"\n• Version: β",Version," v ",version()," • Design: ",designVersion,"\nLayer: ",layer,"(",runden(lineProfile/nozArea*100,2),"%)",line==nozzle?str(" Nozzle ∅: ",nozzle):str(" Line/Nozzle ",line,"/",nozzle)," • fn:",fn," fs:",fs," fa:",fa," • Spiel: ",spiel," •"));
}
Echo(str("nozzle area =",runden(nozArea,3),"mm²< print line profile",runden(lineProfile,3),"mm²"),color="redring",condition=nozArea<=lineProfile);


if (!help&&!anima) if(version()[0]<2021)echo    ("<h4 style=background-color:lightgrey>••••• Help off       use: helpsw=1;  •••••");
    else echo    ("❌••••• Help off       use: helpsw=1;  •••••");
    

if (help&&!anima||help2D||helpMod||helpFunc||helpB||helpP||helpHelper){
    echo ("••••••• Konstanten:   ••••••••");
    echo(PHI=PHI,gw=gw,tw=tw,twF=twF,inch=inch);
//echo(str("•••••••••• Help is on! (helpsw=1)•• debug=",debug," ••••••••••••••••••••••••"));
//echo();
if (show)echo(str("🟣 ••• show=",show)); 
    


if(!helpHelper)echo("❌••••• Helper List off — use» helpHelper=true; •••••");
if (helpHelper){
echo    ("•••••••••• Helper:   •••••••••••••••\n
• Schnitt(help=1) cuts children\n
• Cut(help=1) cuts children\n
• Col(help=1) colors children with palette\n
• Color(help=1) colors children with hue\n
• Pivot(help=1) marks p0\n
• Line(help=1) line p0⇔p1 \n
• SCT(help=1) output sin cos tan\n
• Caliper(help=1) measure \n
• Points(help=1) numbers points\n
• Anordnen(help=1) arranges \n
• InfoTxt(help=1) output Infotxt \n
• HelpTxt(help=1) output helptxt \n
• Echo(help=1) output txt \n
• 3Projection(help=1) projects child along axis \n
• PrevPos(help=1) moves only for preview \n
• PolyDeg(help=1) show angle in points (2D)\n
  
  ");
}

if(!helpFunc)echo("❌••••• Functions List off — use» helpFunc=true; •••••");
if (helpFunc){
echo    ("•••••••••• Funktionen:   •••••••••••••••");
echo    ("
••• l(x) Layer\n
••• n(x) Nozzledurchmesser\n
••• line(n) perimeter \n
••• inkreis(eck, rU)\n
••• umkreis(eck, rI)\n
••• hypotenuse(a, b) length\n
••• kathete(hyp, kat) length\n
••• sehne(n, r, a) length n-eck/alpha winkel •••\n
••• RotLang(rot, l, z, e, lz) [vector] (e=elevation)•••\n
••• bezier(t, p0=[0,0], p1=[-20,20],p2=[20,20],p3=[0,0]) points   •••\n
••• kreis(r=10, rand=+5, grad=360,grad2=+0,fn=fn,center=true,sek=true,r2=0,rand2=0,rcenter=0,rot=0,t=[0,0],z=undef) points •••\n
// ••• kreisXY(r=5, grad=0) [vector]•••\n
••• 5gon(b1=20, l1=15, b2=10, l2=30) points •••\n
••• ZigZag(e=5, x=50, y=5, mod=2, delta=+0, base=2, shift=0) points •••\n
••• TangentenP(grad, rad, r, deg) length •••\n
••• Hexstring(c=[r, g, b]) #hexcolor •••\n
••• RotPoints(grad, points) •••\n
••• negRed(num) negative consolen Werte in rot•••\n   
••• gradB(b, r) grad zum Bogenstück b •••\n 
••• gradS(s, r) grad zur Sehne s •••\n     
••• vollwelle() ⇒ Vollwelle(help=1) •••\n
••• runden(x, dec=2) x runden auf Dezimalstelle ••• \n
••• radiusS(s, n, a) radius zur Sehne ••• \n
••• radiusSH(sh) Radius zum Umkreis Sehne Höhe••• \n
••• distS(s,r) Distanz Sehne Mittelpunkt ••• \n
••• gradC(grad=0, min=0, sec=0, h=0, prozent=0, gon=0, rad=0) Winkelmaßumrechnung ••• \n  
••• inch(inch) Inch⇒mm •••\n 
••• kreisbogen(r, grad=360) ••• \n
••• fs2fn(r, grad=360, fs=fs,minf=3); •••\n
••• vektorWinkel(p1, p2, twist=0); •••\n
••• v3(v); makes v a vector3 •••\n
••• parentList(n=-1, start=1) list with all parent modules parent_module(“[start:n]“) •••\n
••• teiler(n, div=2) least divisior •••\n
••• gcode(points, f) generates gcode in output •••\n
••• b(n); switches bool in num and vica versa (works on vectors) •••\n
••• scaleGrad(grad=45, h=1,r=1) scale factor for extrusions •••\n
••• is_parent(needs2D) search parentlist for string or list of strings (parent module needing polygon children) \n
••• m(r=[0,0,0], t=[0,0,0], s=[1,1,1])// multmatrix vector*concat(point,[1]) for rotation and translation •••\n
••• mPoints(points,r,t,s) use with 2D&3D point / points •••\n
••• pathPoints(points,path,twist,scale) •••\n
••• tetra(r) tetrahedron points •••\n
••• octa(r,n,d)  octaheadron points (subdiv n) ••• \n
••• quad(x,y,r,t,center,fn,z)  Quad points ••• \n
••• stern(e=5,r1=10,r2=5,mod=2,delta=+0,z)  Stern points ••• \n
••• wStern(f=5,r=1.65,a=.25,r2,fn=fn,rot=0,z)  ••• \n
••• superellipse(n=2.5,r=10,z,fn=fn) ••• \n
••• star(e=5,r1=10,r2=5,grad=[0,0],grad2,radial=false,fn=0,z,angle=360,rot=0) ••• \n
••• wall(soll,min=1.75,even=false,nozzle=nozzle) adapt to line width (nozzle) ••• \n
••• vMult(v1,v2) vector multiplication ••• \n
••• vSum(v,start=0,end,val=0) ••• \n
••• naca(l,0012) NACA airfoil ••• \n
••• pathLength(points,start=0,end,close=0) ••• \n
••• stringChunk(txt,start=0,length) •••\n
••• string2num(string,start=0,length) •••\n
••• nut (e=2,es=10,a=6,b=6,base=1,h=1,s,center=true,shift=0,grad,z) •••\n
••• involute(r=10,grad=45,fn=fn,rot=0,rev=0,delta=0,z) ••• \n
••• riemen(r1=5,r2=10,tx=20,fn=fn,z,center=false) ••• \n
••• kreisSek(r=10,grad=90,h=0,mitte=0,fn=fn,center=true,mirror=false,rev=0,t=[0,0],z) ••• \n
••• sq (size=[10,10],fn=[10,10],diff=0,t=[0,0,0],z,center=true) ••• \n
••• bend (points,r=0,t=[0,0,0],rev=false) ••• \n
••• scene (scenes,t) ••• \n
••• map (val,from,to=[0,1],constrain=true) ••• \n
••• polyRund(points,r,ir,ofs,delta,fn,fs) round and offset input points••• \n
••• revP(points) reverse Point order ••• \n
••• arc(r,deg,r2,rot,t,z,fn,rev) ••• \n
••• pt(pt) typographic unit in mm••• \n
••• parabel(x,a,fn,exp,bp,lap,t,rev)••• \n
••• vMin(v=[1,2,3],min=0)••• \n
••• vMax(v=[1,2,3],max=0)••• \n
••• vAdd(v=[1,2,3],add=0)••• \n
••• transition(i,fn)••• \n

");
    
}

//Objektmodifikatoren
if(!helpMod)echo("❌••••• Objektmodifikatoren List off — use» helpMod=true; •••••");
if (helpMod){
echo    ("•••••••••• Objektmodifikatoren:   ••••••");
echo    ("•••• T(x=0,y=0,z=0)•Tz(z=0) ••• R(x=0,y=0,z=0)  ••");
echo    ("•••• M(skewzx=0,skewzy=0,skewxz=0,skewxy=0,skewyz=0,skewyx=+0,scale=1,scalexy=1,scalexz=1,scaleyz=1)••");
echo    ("•••• Rund(or=+0,ir=0,chamfer=false,fn,fs=fs)polygon••");
echo    ("•••• Linear(es=1,s=100,e=2,x=1,y=0,z=0,r=0,re=0,center=0,cx=0,cy=0,cz=0 ••");   
echo    ("•••• Polar(e=3,x=0,y=0,r=0,re=0,end=360,dr=0,mitte=false,name)dr=delta element rotation  ••");
echo    ("•••• Grid(es=[10,10,10],e=[2,2,1],center=true) ••");
echo    ("•••• HexGrid ()");   
echo    ("•••• Klon(tx=10,ty=0,tz=0,rx=0,ry=0,rz=0) Objekt ");
echo    ("•••• Halb(i=0,x=0,y=0,z=1,2D=0)Objekt      ••");
echo    ("•••• Drehpunkt(rx=0,ry=0,rz=0,x=0,y=0,z=0,messpunkt=1)Objekt      ••");
echo    ("••••  Kextrude(help=1); ••");  
echo    ("•••• LinEx2(bh=5,h=1,slices=10,s=1.00,ds=0.01,dh=0.7,fs=1,fh=1,twist=0,name,fn=fn) ••");
echo    ("•••• Rand(rand=n(1),center=false,fn=fn,delta=false,chamfer=false)  ••");
echo    ("•••• Gewinde(help=1)••");
echo    ("•••• GewindeV3(dn=5,h=10,kern=0,p=1,w=0,profil=0,gh=0.56,g=1,name,fn=36)••");
echo    ("•••• Kontaktwinkel(help=1) Objekt  ••"); 
echo    ("•••• Laser3D(h=4,layer=10,var=0.002,name,on=-1)3D-Objekt ••");

echo    ("\n
•••• MKlon() //Objekt  •• \n
•••• Row(help=1)// opt. Objekt ••\n
•••• Scale(help=1)// Objekt ••\n

");

}
if(!helpGen)echo("❌••••• ObjektGenerator List off — use» helpGen=true; •••••");
if (helpGen){
  echo("\n
  •••• Rundrum(x=+40,y=30,r=10,eck=4,twist=0,grad=0,spiel=0.005,fn=fn,name) polygon RStern(help=1)polygon ••
  •••• Bogen(help=1)// opt Polygon   ••\n
  •••• SBogen(help=1)// opt Polygon   ••\n
  •••• Bevel(help=1)// Objekt ••\n
  •••• Bezier(help=1) Objekt ••\n
  •••• Schlaufe(help=1) polygon •• \n
  •••• Elipse(x=2,y=2,z=0,fn=36)Object•• \n
  •••• RotEx(grad=360,fn=fn,center=false)  ••\n
  •••• LinEx(help=1) polygon  ••
  •••• Ttorus(r=20,twist=360,angle=360,fn=fn)3D-Objekt      ••
  
  ");
}

//  2D 

if(!help2D)echo("❌••••• Polygon List off — use» help2D=true; •••••");
if (help2D){
echo    ("•••••• Polygons ••••••\n
•• Kreis();\n 
•• Trapez(h=2.5,x1=6,x2=3.0,d=1,x2d=0,fn=36,name);\n
•• Tri(grad=60,l=20,h=0,r=0,messpunkt=0,center=+0,top=1,tang=1,fn=fn,name,help=helpM);\n
•• Tri90(grad,a,b,c,help=1);\n
•• Quad(x=20,y=20,r=3,grad=90,grad2=90,fn=36,center=true,centerX=false,n=false,messpunkt=false,help=helpM);\n
•• VorterantQ(size=20,ofs=.5);\n
•• Linse(dia=10,r=7.5,name,messpunkt=true);\n
•• Bogendreieck(rU=5,vari=-1,fn=fn,name);\n
•• Reuleaux(rU=5,name,fn=fn);\n
•• Stern(e=5,r1=10,r2=5,mod=2,delta=+0,name);\n
•• ZigZag(e=5,es=0,x=50,y=5,mod=2,delta=+0,base=2,center=true,name,help=$helpM);\n
•• WStern(help=1);\n
•• Superellipse(help=1);\n
•• Flower(help=1);\n
•• Seg7(help=1);\n
•• WKreis(help=1);\n
•• RSternFill(help=1);\n
•• Cycloid(help=1);\n
•• SQ(help=1);\n
•• Vollwelle(help=1);\n
•• SWelle(help=1);\n
•• CycloidZahn(help=1);\n
•• Nut(help=1);\n
•• DBogen(help=1);/*(opt polygon)\n*/
•• Pfeil(help=1);\n
•• DPfeil(help=1);\n
•• Rosette(help=1);\n
•• GT(help=1);\n
•• Egg(help=1);\n
•• VarioFill(help=1);\n
•• Welle(help=1);\n
•• Tdrop(help=1);\n
•• Star(help=1);\n
•• NACA(help=1);\n
•• Involute(help=1);\n
•• Riemen(help=1);\n
•• PolyRund(help=1);\n
•• Arc(help=1);\n
•• Tesselation(help=1);\n
•• Connector(help=1);\n
•• Penrose(help=1);\n
•• RectTiling(help=1);\n

");
}


  if(!helpB)echo("❌••••• Basis objects List off — use» helpB=true; •••••");   
 if(helpB){//  BASIS OBJEKTE   
 
    
echo();    
echo    ("•••••••••• BasisObjekte:   •••••••••••••\n
\n

•• [300] Kugelmantel(d=20,rand=n(2),fn=fn);\n

•• [30] Kegel (d1=12,d2=6,v=1,fn=fn,name,center=false,grad=0);\n
•• [31] MK(d1=12,d2=6,v=19.5);//v=Steigung\n
•• [301] Kegelmantel (d=10,d2=5,v=1,rand=n(2),loch=4.5,grad=0,center=false,fn=fn,name);\n
•• [32] Ring(h=5,rand=5,d=20,cd=1,center=false,fn=fn,name,2D=0);// cd=1,0,-1\n
•• [33] Torus(trx=10,d=5,a=360,fn=fn,fn2=fn,r=0,name=1,dia=0,center=true,end=0);//opt polygon \n
•• [34] Torus2(m=10,trx=10,a=1,rq=1,d=5,w=2);//m=feinheit,trx = abstand mitte,a = sin verschiebung , rq=mplitude, w wellen \n
••  WaveEx(help=1);\n   
•• [35] Pille(l=10,d=5,fn=fn,fn2=36,center=true,n=1,rad=0,rad2=0,loch=false);\n
•• [402] Strebe(skew=0,h=20,d=5,rad=4,rad2=3,sc=0,grad=0,spiel=0.1,fn=fn,center=false,name,2D=false);\n
•• WStrebe(grad=45,grad2=0,h=20,d=2,rad=3,rad2=0,sc=0,angle=360,spiel=.1,fn=fn,2D=false,center=true,help=$helpM) \n
•• [36] Twins(h=1,d=0,d11=10,d12=10,d21=10,d22=10,l=20,r=0,fn=60,center=0,sca=+0,2D=false);\n
•• [37] Kehle(rad=2.5,dia=0,l=20,angle=360,fn=fn,spiel=spiel,fn2=fn,r2=0);\n
••  REcke(help=1);\n
••  HypKehle(help=1);\n
••  HypKehleD();\n

•• [46] Text(text=\"»«\",size=5,h=0,cx=0,cy=0,cz=0,center=0,font=\"Bahnschrift:style=bold\");\n
•• [47] W5(kurv=15,arms=3,detail=.3,h=50,tz=+0,start=0.7,end=13.7,topdiameter=1,topenddiameter=1,bottomenddiameter=+2);\n

•• [50] Rohr(grad=90,rad=5,d=8,l1=10,l2=12,fn=fn,fn2=fn,rand=n(2),name=0);\n
•• [51] Dreieck(h=10,ha=10,ha2=ha,s=1,name=1,c=0,2D=0,grad=0);//  s=skaliert  c=center\n
•• [52] Freiwinkel(w=60,h=5);   \n
•• [54] Sinuskoerper(h=10,d=33,rand=2,randamp=1,randw=4,amp=1.5,w=4,detail=3,vers=0,fill=0,2D=0,twist=0,scale=1); /* amp=Amplitude, w=Wellen, vers=versatz*/\n

•• [55] Kassette(r1=2,r2=2,size=20,h=0,gon=3,fn=fn,fn2=36,r=0,grad=90,grad2=90,spiel=0.001,mitte=true,sizey=0,help=$helpM);\n
•• Surface(help=$helpM);\n
•• FlatMesh(help=true);\n
•• [58] Box(x=8,y=8,z=5,d2=0,c=3.5,s=1.5,eck=4,outer=true,fnC=36,fnS=24);\n
•• [62] Spirale(grad=400,diff=2,radius=10,rand=n(2),detail=5,exp=1,hull=true);/*opt Object*/\n
•• [63] Area(a=10,aInnen=0,rInnen=0,h=0,name);\n
•• [65] Sichel(start=55,max=270,dia=33,radius=30,delta=-1,2D=false);\n
•• [66] Prisma(x1=12,y1=12,z=6,c1=5,s=1,x2=0,y2=0,x2d=0,y2d=0,c2=0,vC=[0,0,0],cRot=0,fnC=fn,fnS=36,name);\n
•• Ccube(help=1);\n
•• [67] Disphenoid(h=15,l=25,b=20,r=1,ty=0,tz=0,fn=36);\n
•• Zylinder(help=1);\n
•• Welle(help=1); /*opt polygon*/\n
•• Anschluss(help=1);\n
•• QuadAnschluss(help=1);\n
•• RingSeg(help=1); \n
•• Buchtung(help=1);\n
•• SpiralCut(help=1);\n
•• Isosphere(help=1);\n
•• OctaH(help=1); /*Octahedron*/\n
•• PolyH(); /*Polyhedron auto faces */\n
•• Coil();\n
•• Knurl();\n
•• KnurlTri();\n
•• Loch();

");

}
 if(!helpP)echo("❌••••• Produkt List off — use» helpP=true; •••••");
 if(helpP){ // PRODUKT OBJEKTE

echo    ("•••••••••• Produkt Objekte:   ••••••••••");
//echo    ("•• [400] Pivot(p0=[0,0,0],size=pivotSize,active=[1,1,1,1]) ••••");
//echo    ("•• [401] Line(p0, p1, d=.5,center=false) ••••");
//echo    ("•• [402] SCT(a=90) sin cos tan info ••••");
echo    ("•• [42] Gardena(l=10,d=10) ••••"); 
echo    ("•• [43] Servotraeger(SON=1) ••• Servo(r,narbe) ••••");
echo    ("•• [44] Knochen(l=+15,d=3,d2=5,b=0,fn=36)   ••••");
echo    ("•• [38] Glied(l=12,spiel=0.5,la=+1.5,fn=20) •• SGlied(help=1) •• DGlied(help=1) •• [39][40]DGlied0/1(l=12,l1,l2,la=0) ••••");
echo    ("•• [41] Luer(male=1,lock=1,slip=1) ••••"); 
echo    ("•• [45] Bitaufnahme(l=10,star=true)••••");
echo    ("•• [48] Imprint(txt1=1,radius=20,abstand=7,rotz=-2,h=l(2),rotx=0,roty=0,stauchx=0,stauchy=0,txt0=›,txt2=‹,size=5,font=DejaVusans:style=bold)        ••••");
echo    ("•• [503] Achshalter(laenge=30,achse=+5,schraube=3,mutter=5.5,schraubenabstand=15,hoehe=8,fn=fn) ••••");

echo    ("•• [504] Achsenklammer(abst=10,achse=3.5,einschnitt=1,h=3,rand=n(2),achsenh=0,fn=72)••••");
echo    ("•• [56] Vorterantrotor(h=40,twist=360,scale=1,zahn=0,rU=10,achsloch=4,ripple=0,caps=2,caps2=0,capdia=6.5,capdia2=0,screw=1.40,screw2=1,screwrot=60,n=1)••••");
echo    ("•• [57] Tugel(dia=10,loch=5,scaleKugel=1,scaleTorus=1)••••");
echo    ("•• [59] ReuleauxIntersect(h=2,rU=5,2D=false) ••••••");
echo    ("•• [60] Glied3(x)  ••• [61] Gelenk(l,w) ••••••");
echo    ("•• [64] Balg(sizex=16,sizey=16,z=10.0,kerb=6.9,rand=-0.5)••••");
echo    ("•• [67] Tring(spiel=+0,angle=153,r=5.0,xd=+0.0,h=1.75,top=n(2.5),base=n(4),name=0)••••");
echo    ("•• [201] Servokopf(help=1)Objekt  ••••");
echo    ("•• [202] Halbrund(h=15,d=3+2*spiel,x=1.0,n=1)Objekt mikroGetriebemotor Wellenaufnahme  ••••");
echo    ("•• [203] Riemenscheibe(e=40,radius=25,nockendurchmesser1=2,nockendurchmesser2=2,hoehe=8,name)Objekt ••••");

echo    ("•• Cring(help=1)••••");
echo    ("\n
•• PCBcase(help=1);••••\n
•• Klammer(help=1);••••\n
•• Pin(help=1);••••\n
•• CyclGetriebe(help=1);/CyclGear();••••\n
•• SRing(help=1);••••\n
•• DRing(help=1);opt polygon••••\n
•• GewindeV4(help=1); ••••\n
•• BB(help=1); Ballbearing ••••\n
•• Abzweig(help=1) ••••\n
•• GT2Pulley(help=1) ••••\n
•• KBS(help=1) KlemmBauStein••••\n
•• Filter(help=1) Filter Sieve••••\n
");
}



}// end help


// SCHALTER
 if(version()[0]<2021)echo    (str("<h5 style=background-color:#c0bbdd><font color='darkviolet'size=4>Schalter• 
messpunkt=",messpunkt?"<font color='green'>On</font>":"<font color='red'>Off</font>",
" • vp=",vp?"<font color='green'>On</font>":"<font color='red'>Off</font>",
" • anima=",anima?"<font color='green'>On</font>":"<font color='red'>Off</font>",
" • texton=",texton?"<font color='green'>On</font>":"<font color='red'>Off</font>",
" • help=",help?"<font color='green'>On</font>":"<font color='red'>Off</font>",
" • $info=",$info?"<font color='green'>On</font>":"<font color='red'>Off</font>",
" •</font>"));
 else echo    (str("Schalter•\n 
messpunkt=",messpunkt?"🟢✔":"❌",
" • vp=",vp?"🟢✔":"❌",
" • anima=",anima?"🟢✔":"❌",
//" • texton=",texton?"🟢✔":"❌",
" • help=",help?"🟢✔":"❌",
" • $info=",$info?"🟢✔":"❌",
" • bed=",bed?"🟢✔":"❌", 
" • hires=",hires?"🟢✔":"❌", 
" •"));

if(anima||tset)echo(str("\n Zeit t0:",t0,
    "\nZeit t1:",t1,"\nZeit t2:",t2,"\n
Zeit t3:",t3(),"\n
••••  anima on! tset=",tset," t=0⇒1 || t0=0⇒360 || t1=-1⇔1 || t2=0⇔1 || t3(wert=1,grad=360,delta=0)  •••••"));    
    
if (vp)echo (str(version()[0]<2021?"\n<p style=background-color:#bbbbee;><font size=5 color=#555599>":
        "",
"\n\tViewportcontrol vpr: ",$vpr,"\n\t
Viewportcontrol vpt: ",$vpt,"\n\t
Viewportcontrol vpd: ",$vpd,"\n\t
Viewportcontrol vpf: ",$vpf,"\n\t
••••  vp=on  •••••"));
if(!$preview) echo("\n\t\t⏳ Rendering…wait! ⌛");

} // end Menu

// –––––––––––––––––––––––– Modules  –––––––––––––––––––––––––––––––––––


module Example(variable=1,name,help){
if(name=="Test"||name=="test"||is_bool(name)||name==undef||is_num(name)) { 
    if(variable==1)cube(10);
    else if (variable==2)sphere(10);
    
 InfoTxt("Example",["variable",variable,"display",variable?variable==1?"cube":
                                                                "sphere":
                                                    "none"],name);
 HelpTxt("Example",["variable",variable,"name",name],help);  
 }

// – ///////////////////////////////////// END Example /////////////////////////


module Laby(rec=8,l=10,b=1,p){
   rand=min(floor(rands(1,13,1)[0]),rec>6?7:100);
   
   T(0,l-b/2)
   if(rec){
     if(rand==1||rand==4||rand==5||rand==6)Laby(rec=rec-1,l=rands(1,5,1)[0],p=true);
     if(rand==2||rand==4||rand==6||rand==7)rotate(rands(45,90,1)[0])Laby(rec=rec-1,l=rands(5,25,1)[0],p=false);
     if(rand==3||rand==4||rand==5||rand==7)rotate(rands(-45,-90,1)[0])Laby(rec=rec-1,l=rands(1,5,1)[0],p=false);
   }
   Tz(rand/20+.1)T(0,l){
     for(i=[0:10])if(rand==i+4)Color(1/6*i%6)circle(b/2);
       if(rand<4) Color(rand/4,l=.2)circle(b/3*2,$fn=rand+3);
       }
       T(-b/2)square([b,l]);
       union(){s=rands(b,4,2);
         color("darkgrey")Quad(s,name=false);
        color("grey")Tz(.1)Rand(.25) Quad(s,name=false);
         Tz(.2)if(rec==4&&p==true)color("hotpink")T(2,-5)rotate(115)Pfeil();
         }
}
   
   
if(is_string(name)&&name!="test"&&name!="Test"){rand=rands(0,1,1)[0];n=floor(rands(2,4,1)[0]);room=floor(rands(0,10,1)[0]);$info=false;echo("\n\n");if(name=="yes"||name=="Yes"||name=="YES"){Echo(str("You are in a Cave room with ",n," doors pick “left“ ",n==3?", “right“or “middle“":"or “right“"," (name=”answer”)\n\n) "),color="black");Linear(n,es=15,center=true){R(90)Color("burlywood",l=.8)LinEx(2)Rand(-1)DBogen(x=12,base=-20);R(90)Color("goldenrod")LinEx(1)offset(-.1)DBogen(x=12,base=-20);T(3+$idx%2*-6,-1,-9)color("black")sphere(0.6);}Tz(14)cube([150,1,70],true);}else if(name=="no"||name=="NO"||name=="No")  Echo("Ok have fun with this library and oSCAD",color="info");else if(name=="right"||name=="left"||name=="middle"||name=="run"||name=="sneak"||name=="climb"||name=="jump"||name=="swim"||name=="red"||name=="green"||name=="blue"||name=="balance"){if(room==0){end=floor(rands(1,4,1)[0]);if(end==1)scale(.5){Echo("That didn't went well  you died\n\t—that was faster than expected!\n\t try again (name=“yes“)?",color="red");Linear(5,es=25,center=true)difference(){union(){color("brown") R(90)LinEx(50,2,scale=0)DBogen(x=23,rad=1);if($idx!=2)T(0,4) color("lightgrey") Prisma(12,9,5,x2=10,s=3,y2=7);}color([.2,.1,.1])if($idx==2)T(0,-24)linear_extrude(50,true)Quad(18,40,r=2);}color([.2,.1,.1])T(0,-24)linear_extrude(2,true)Quad(18,40,r=2);Tz(20)cube([2,2,40],true);Tz(30)cube([20,2,2],true);T(y=-2.5,z=30)R(50)color("darkgrey")text("The End",halign="center",size=3);color("darkgreen") square(150,true);Tz(4.1)T(0,-17){color("wheat")Scale([1,1,4,1.5,1.0,0.8])MKlon(mz=1)cylinder(4,d1=13,d2=8,$fn=6);color("black")Tz(3){square([1,9],true);T(0,+2)square([4,1],true);}}}if(end==2){Echo("You see daylight, you made it out \n\t —that was faster than expected!\n\t play again? (“yes“or“no“)",color="white");rotate($vpr)Tz(-50)R(-45,-45)color("lightblue")square(500,true);rotate($vpr) Color("gold",alpha=.35)linear_extrude(2,scale=0)Stern(50,r1=10,r2=5);rotate($vpr){Color("orange",alpha=.35)linear_extrude(2,scale=0)Stern(37,r1=10,r2=4);Tz(5)for(i=[8:.2:12])color([i/12,.95,.85,.5/i])circle(i);}T(0,-30)text("The END",halign="center",size=3);}if(end==3){Echo("…there You found a partner \n\tand You lived happily ever after! —that was faster than expected!\n\t\n\t play again? (“yes“or“no“)",color="white");R(40){Color(0.03)hull(){Halb(1,y=1)linear_extrude(.1)Rund(1)polygon( [ for (t=[0:3:360]) [13*pow(sin(t),3),16*cos(t)-7*cos(2*t)-1.3*cos(3*t)-cos(4*t)]]);T(-7,7)scale([1,1,.75]) sphere(7);T(2)R(90)cylinder(12,d1=5,d2=0);}Color(0.05)hull(){Halb(y=1)linear_extrude(.1)Rund(1)polygon([for(t=[0:3:360])[13*pow(sin(t),3), 16*cos(t) - 7*cos(2*t)-1.3*cos(3*t)-cos(4*t)]]);T(+7,7)scale([1,1,.75]) sphere(7);T(-2)R(90)cylinder(12,d1=5,d2=0);}}T(0,-30)text("Happy END ♥",halign="center",size=3);}}if(room==1){Echo(str("you coming into a big chamber with ",n," corridors pick “left“ ",n==3?", “right“or “middle“":"or “right“"),color="black");color("lightgrey")Tz(-6.6)Surface(150,150,seed=rand,freqX=10,ampX=5,rand=1,waves=0,res=0.5,randsize=1.0,exp=2,abs=0,mult=0,deltaZ=.5,zBase=5,name=false,help=0);R(110)color("lightgrey")Tz(-2.4)Surface(150,80,seed=rand,freqX=10,ampX=5,rand=1,waves=1,res=0.5,randsize=1.0,exp=2,abs=0,mult=0,deltaZ=1.5,zBase=50,name=false,help=0);Linear(n,es=14,center=true)Color($idx*0.6/(n-1),l=.8)T(y=-20)R(-90,0,20+$idx*(-60/n))linear_extrude(50,convexity=5)Rand(1.5)Quad([10,20]);}if(room==2){Echo("right in front of you is a stream of lava\n\t what now? try to ”jump” or ”run” ?",color="orange");color("gainsboro")difference(){cube([150,150,6],true);linear_extrude(50,center=true,convexity=5)rotate(90)SBogen(spiel=-.1,dist=25,r1=35,l1=150,2D=rands(15,55,1)[0],grad2=rands(-30,30,2));}color("orange")Surface(150,100,seed=rand,freqX=10,ampX=5,rand=1,waves=1,res=0.5,randsize=2,exp=2,abs=0,mult=0,deltaZ=3,name=false);color("red")Surface(150,50,seed=rand*2,freqX=10,ampX=1,rand=1,waves=1,res=.5,randsize=2,exp=1,abs=0,mult=0,deltaZ=3,name=false);}if(room==3){Echo("Now a moat with water blocking your way \n\t maybe you could “swim“ or better “climb“ the walls \n\t but who knows what is in there or if you are fast enough maybe you could “run“",color="blue");MKlon(ty=50)cube([150,50,6],true);color("blue")Surface(150,50,seed=rand,freqX=10,ampX=2,rand=1,waves=1,res=0.5,randsize=1,exp=2,abs=1,mult=0,deltaZ=1,name=false);color("darkblue")Surface(150,50,seed=rand*2,freqX=5,ampX=1,rand=1,waves=1,res=.5,randsize=1,exp=1,abs=1,mult=0,deltaZ=1,name=false);for(i=[0:3])T(rands(-20,20,2))rotate(rands(-180,180,1)[0]) color("lightgrey")R(90)difference(){cylinder(1,d=10);T(4)cylinder(10,d=10,center=true);}}if(room==4){Echo("There is a trench with a rotten rope brige \n\ttry to “jump“, “climb“ “sneak“ or “balance“ the rope ?",color="white");difference(){Tz(-75)color("brown")cube(150,true);color("maroon")R(90,0,90)linear_extrude(170,center=true)Quad(70,25,r=3,grad=35,grad2=125);}color("sienna")Tz(-1){Klon(tx=3)R(90)linear_extrude(twist=3500,height=110,center=true)circle(d=1,$fn=7);color("saddlebrown")T(-3)Linear(14,y=1,es=5,center=true)R(0,floor(rands(0,2,1)[0])?90:0)T(-1,0,-.5)cube([8,3,1],false);}}if(room==5){Echo(" Oh oh danger this looks spiky… ”jump” or ”climb”",color="warning");Tz(-45){Color("peru")Surface(80,70,seed=rand,freqX=+6.0,ampX=15,rand=1,waves=1,res=1.4,randsize=1,exp=1.2,abs=1,mult=0,deltaZ=1,zBase=+1,name=false,help=0);cube([100,100,85],true);}MKlon(ty=60)cube([100,50,15],true);for(i=[0:35])T(rands(-50,50,2))cube([5,5,13],true);}if(room==6){Echo(" Oh oh danger seems we are not alone in the dark… ”run” or ”sneak”",color="warning");Tz(-15)for (i=[0:35])T(rands(-50,40,3))rotate(rands(-15,15,3)){color("black") linear_extrude(.11)MKlon(tx=1.2)circle(0.4);linear_extrude(.1)MKlon(tx=1.2)Scale(rands(.5,1.5,4))circle(1);Tz(-.5)for(i=[5:.25:12])color([.1/i,.1/i,.5/i,4/i])linear_extrude(1/i)circle(i);}Tz(-150)color([0.075,0.075,0.15])square(1500000,true);}if(room==7){Echo(" … in this room a corpse is in the corner holding a part of a Map\n\t choose next (“red“,“blue“ or “green“)",color="black");rotate(90)T(-4)Pfeil();T(-6,-9)text("you entered here",size=2);Laby();}if(room==8){Echo(str("… Again a strange room with A Desk in the middle with ",n," Buttons and some weird mechanism that could open a passage \n\t choose next (“red“",n==3?", “blue“ or “green“)":" or “blue“)"),color="black");if(round(rand))Linear(n,es=8,center=true)Color($idx*0.6/(n-1),l=.8) Pille(l=4,d=5,rad=[0,1],center=false);else Polar(n,x=8,end=rands(120,300,1)[0])Color($idx*0.6/(n-1),l=.8) Pille(l=4,d=5,rad=[0,1],center=false);Tz(-8) Prisma(25,35,10);}if(room==9){Echo(str("You are in a Cave room with ",n," doors pick “left“ ",n==3?", “right“or “middle“":"or “right“"," (name=”answer”)\n\n) "),color="black");Linear(n,es=15,center=true){R(90)Color("burlywood",l=.8)LinEx(2)Rand(-1)DBogen(x=12,base=-20);R(90)Color($idx*0.6/(n-1),l=.8)LinEx(1)offset(-.1)DBogen(x=12,base=-20);T(3+$idx%2*-6,-1,-9)color("black")sphere(0.6);}Tz(14)color("tan")cube([150,1,70],true);}}else{Echo("Thanks for checking out UB.scad \n\t— seems you like to try things out, nice!\n\t I like that!  Wanna play a game ⇒ Example(name=”yes”);\n",color="purple");rotate($vpr)Tz(10){Color(l=.8){T(y=-15)text(str("instructions and text are on the console window"),size=1.5,halign="center");T(y=15)text(str("Hi ",name,", Wanna play a Game ?"),size=2,halign="center");T(y=-5)text(str("Example(name=“yes“);"),size=3,halign="center"); }}RotEx(cut=true)Egg(r1=20,breit=15);for(i=[0:102]) Color(i/50)intersection(){ rotate(rands(-100,70,2))cylinder(50,d=rands(.5,3,1)[0],center=true,$fn=12);RotEx(cut=true)offset(0.1+i/1000)Egg(r1=20,breit=15);}}echo("\n");}
} // end example


{//fold // \∇∇ Tools / Modifier ∇∇/ //



/// short for translate[];
module T(x=0,y=0,z=0,help=false)
{
    //translate([x,y,z])children();
if(is_list(x))
    multmatrix(m=[
    [1,0,0,x[0]],
    [0,1,0,x[1]],    
    [0,0,1,is_undef(x.z)?z:x[2]+z],
    [0,0,0,1]    
    ])children(); 
else
    multmatrix(m=[
    [1,0,0,x],
    [0,1,0,y],    
    [0,0,1,z],
    [0,0,0,1]    
    ])children(); 


    MO(!$children);
    HelpTxt("T",["x",x,"y",y,"z",z],help);
}


/** \page Modifier
 * Tz() translates children in Z
 * \name Tz
## Examples
Tz() cube();
 * \brief short for T(z=0);
 * \param z translates[0,0,z]  

*/

module Tz(z=0,help=false){
    multmatrix([
        [1,0,0,0],
        [0,1,0,0],    
        [0,0,1,z],
        [0,0,0,1],    
        ])children();    
    MO(!$children);
    HelpTxt("Tz",["z",z],help);
}

// short for rotate(a,v=[0,0,0])
module R(x=0,y=0,z=0,help=false)
{
    rotate([x,y,z])children();
    MO(!$children);
    HelpTxt("R",["x",x,"y",y,"z",z],help);
}

/** \name M
\page Modifier
M() multmatrix objects
\param skewXY skew the x axis along y
\param scaleXY scales x and y
*/

// short for multmatrix and skewing objects
module M(skewZX=0,skewZY=0,skewXZ=0,skewXY=0,skewYZ=0,skewYX=+0,scale=1,scaleXY=1,scaleXZ=1,scaleYZ=1,help=false,skewxy,skewxz,skewyx,skewyz,skewzx,skewzy,scalexy,scalexz,scaleyz){
    scale=is_list(scale)?scale:scale*[1,1,1];
    skewXY=is_undef(skewxy)?skewXY:skewxy;
    skewXZ=is_undef(skewxz)?skewXZ:skewxz;
    skewYX=is_undef(skewyx)?skewYX:skewyx;
    skewYZ=is_undef(skewyz)?skewYZ:skewyz;
    skewZX=is_undef(skewzx)?skewZX:skewzx;
    skewZY=is_undef(skewzy)?skewZY:skewzy;
    
    scaleXY=is_undef(scalexy)?scaleXY:scalexy;
    scaleXZ=is_undef(scalexz)?scaleXZ:scalexz;
    scaleYZ=is_undef(scaleyz)?scaleYZ:scaleyz;
    
    scaleX=scale.x*scaleXY*scaleXZ;
    scaleY=scale.y*scaleXY*scaleYZ;
    scaleZ=scale.z*scaleXZ*scaleYZ;
    
    multmatrix([
    [scaleX,skewYX,skewZX,0],
    [skewXY,scaleY,skewZY,0],    
    [skewXZ,skewYZ,scaleZ,0],
    [0,0,0,1.0],    
    ])children();
    
    MO(!$children);
    HelpTxt("M",["skewZX",skewZX,"skewZY",skewZY,"skewXZ",skewXZ,"skewXY",skewXY,"skewYZ",skewYZ,"skewYX",skewYX,"scale",scale,"scaleXY",scaleXY,"scaleXZ",scaleXZ,"scaleYZ",scaleYZ],help);
}

/** 
\name Polar
\page Modifier
Polar() object  multiply children polar (e=number, x/y=radial distance)
\param e number objects (cloned children)
\param x,y,z radius (distance) of objects
\param rot   rotate polar
\param rotE  rotate objects
\param end   for degree
\param dr    delta rotate objects according to position
\param mitte add center object
\param v     rotation axis
\param es    element distance
\param name, help  name help
*/

//Polar(5,[3,3],v=[0,1,1])cube();

module Polar(e=3,x=0,y=0,z=0,rot=0,rotE=0,end=360,dr=0,mitte=false,v=[0,0,1],es,name,n,help=false,r,re){
    
   e=floor(abs(e));
   y=is_list(x)?is_num(x.y)?x.y+y:y:y;
   z=is_list(x)?is_num(x.z)?x.z+z:z:z;
   x=is_list(x)?x.x:es?radiusS(s=es,n=e):x;
   rot=is_undef(r)?rot:r; // compability
   rotE=is_undef(re)?rotE:re; // compability
   name=is_undef(n)?is_undef(name)?is_undef($info)?false:
                                                   $info:
                                   name:
                    n;
  
   radius=Hypotenuse(x,y);
   end=end==0?360:end;
   winkel=abs(end)==360?360/e:end/max(1,e-1);
   
   if(norm(v)>1)%color("chartreuse",.5)rotate(vektorWinkel(p2=v)-[90,0,0])cylinder(norm([x,y,z]),d=.5);
  
  InfoTxt("Polar",["elements",str(e,
    " radius ",radius,"mm ",rotE?str("rotElements=",rotE,"°"):"",end!=360?str(" End=",end,"°"):""," Element=",winkel,"° Abstand=",2*radius*PI/360*winkel,"mm (Sekante=",2*radius*sin(winkel/2),")")],name);
  
  
   if(e>+0) rotate(rot)for(i=[0:e-1]){
        $idx=i;
        $tab=is_undef($tab)?1:b($tab,false)+1;
        $info=$idx?false:name;
        rotate(a=e==1&&end<360?winkel/2:i*winkel,v=v)translate([x,y,z])rotate(a=rotE+(i*winkel)/end*dr,v=v)children();
    }
     if(mitte){
         $idx=e;
         children(); 
     }

     
    HelpTxt("Polar",["e",e,"x",x,"y",y,"z",z,"rot",rot,"rotE",rotE,"end",end,"dr",dr,"mitte",mitte,"v",v,"es",es,"name",name],help);
MO(!$children);
           
     
}



/// multiply children linear (e=number, es=distance)
module Linear(e=2,es=1,s=0,x=0,y=0,z=0,r=0,re=0,center=0,cx=0,cy=0,cz=0,name,n,help)// ordnet das Element 20× im Abstand x Linear an.. es skaliert die vektoren . cx = center x
{
   name=is_undef(n)?is_undef(name)?is_undef($info)?false:
                                                   $info:
                                   name:
                    n;
  
$helpM=0;
e=floor(e);
s=es==1?s:0;
  x=!y&&!z?1:b(x,false);
  y=b(y,false);
  z=b(z,false);

    cx=center?1:cx;
    cy=center?1:cy;  
    cz=center?1:cz;
  
  InfoTxt("Linear",["länge",str((s?s:e*es)*norm([x,y,z]),"mm")],name);  
  
  
if(s!=0&&e>0){if(e>1)translate([cx?-x*es/2*s:0,cy?-y*es/2*s:0,cz?-z*es/2*s:0])for(i=[0:e-1])//for (i=[+0:s/(e-1):s+.00001])
         {
            $idx=i;
            $info=$idx?false:name;
            $tab=is_undef($tab)?1:b($tab,false)+1; 
            rotate([0,0, r])translate([i*x*es*(s/(e-1)),i*y*es*(s/(e-1)),i*z*es*(s/(e-1))])rotate([0,0, re])children();


         }
      else rotate([0,0, re])children();
      }

if(s==0&&e>0)for (i=[0:e-1])
         {
            $idx=i;
            $info=$idx?false:name;
            $tab=is_undef($tab)?1:b($tab,false)+1;
            rotate([0,0, r])translate(center?[(e-1)*es*x,(e-1)*es*y,(e-1)*es*z]/-2:[0,0,0])translate([i*es*x,i*es*y,i*es*z])rotate([0,0, re])children();
          
         }        
        
MO(!$children);

  
HelpTxt("Linear",["e",e,"es",es,"s",s,"x",x,"y",y,"z",z,"r",r,"re",re,"center",center,"cx",cx,"cy",cy,"cz",cz,"name",name],help);       
        
}


//Clone and mirror object
module MKlon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,mx,my,mz,help=false)
{
    mx=is_undef(mx)?sign(abs(tx)):mx;
    my=is_undef(my)?sign(abs(ty)):my;
    mz=is_undef(mz)?!mx&&!my?1:sign(abs(tz)):mz;
  
  $idx=0;  
    translate([tx,ty,tz])rotate([rx,ry,rz])children();
     
    union(){
        $helpM=0;
        $info=0; 
        $idx=1;
        $idxON=false; 
        translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])mirror([mx,my,mz]) children();
    }
    MO(!$children);
    HelpTxt("MKlon",["tx",tx,"ty",ty,"tz",tz,"rx",rx,"ry",ry,"rz",rz,"mx",mx,"my",my,"mz",mz],help);

}

// Clone and mirror (replaced by MKlon)
module Mklon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,mx=0,my=0,mz=1)
{
    mx=tx?1:mx;
    my=ty?1:my;
    mz=tz?1:mz;
  $idx=0;
    translate([tx,ty,tz])rotate([rx,ry,rz])children(); 
    union(){
        $helpM=0;
        $info=0;
        $idx=1;
        $idxON=false;
    translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])mirror([mx,my,mz]) children(); }   
   MO(!$children);
}

// Clone Object
module Klon(tx=0,ty=0,tz=0,rx=0,ry=0,rz=0,help=false){
    union(){
        $idx=0;
        translate([tx,ty,tz])rotate([rx,ry,rz])children();
    }
    union(){
         $idx=1;
        $helpM=0;
        $info=0;
        $idxON=false; 
    translate([-tx,-ty,-tz])rotate([-rx,-ry,-rz])children();  
    }   
    MO(!$children); 
    HelpTxt("Klon",["tx",tx,"ty",ty,"tz",tz,"rx",rx,"ry",ry,"rz",rz],help);   
}



/**
\page Modifier
\name Halb
Halb() Object Cuts away half of Object at [0,0,0]
\param i  inverse side 
\param x,y,z  cutting axis
\param 2D for 2D objects
\param size  cuttingblock size
*/

//Halb(x=1)sphere(5);


module Halb(i=0,x=0,y=0,z=0,2D=0,size=max(400,viewportSize*4),t=[0,0,0],help=false)
{
t=v3(t);
xChange=-x;
x=(is_num(useVersion)&&useVersion<22.250&&!2D)?y:x;
y=(is_num(useVersion)&&useVersion<22.250&&!2D)?xChange:y;

    if(!2D){
       if(i||z<0)difference()
       {
           children();
           translate(t)R(-90*sign(y),90*sign(x))  cylinder(size,d=size,$fn=6);
          
       }
      else intersection()
      {
          children();
          translate(t)R(-90*sign(y),90*sign(x))  cylinder(size,d=size,$fn=6);
      }
  }
  if(2D){
      if(i)difference()
      {
          children();
           T(y?-size/2:0,x?-size/2:0)translate(t) square(size);
      }
      if(!i) intersection()
      {
          children();
          T(y?-size/2:0,x?-size/2:0)translate(t) square(size);
      }
  } 
 MO(!$children); 
 HelpTxt("Halb",["i",i,"x",x,"y",y,"z",z,"2D",2D,"size",size,"t",t],help);
}


//short for rotate_extrude(angle,convexity=5) with options
module RotEx(grad=360,fn,fs=fs,fa=fa,center=false,cut=false,convexity=5,help=false){
  fnrotex=$fn;
    rotate(center?sign(grad)*-min(abs(grad)/2,180):grad>=360?180:0)
  rotate_extrude(angle=grad,convexity=convexity, $fa =fn?abs(grad/fn):fa,$fs=fs,$fn=is_num(fn)&&fn<5&&grad==360?fn:0)intersection(){
    $fn=fnrotex;
    $fa=fa;
    $fs=fs;
           children();
           if(cut)translate([cut==-1?-1000:0,-500])square(1000);
    }

    MO(!$children);   
    HelpTxt("RotEx",["grad",grad,"fn",fn,"center",center,"cut",cut,"convexity",convexity],help);
}

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



module Scale(v=[+1.5,+0.8,+0.8,0.6,0.7,1.3],//  scaling factors for quadrants [x-,x+,y-,y+,z-,z+]
2D,size=viewportSize/2,help){
   2D= is_undef(2D)?is_undef(v[4])?true:false:2D;
  makeV =function(v=v) [for(i=[0:5])is_undef(v[i])?1:v[i]]; 
 v=makeV();
 size=is_undef(size)?bed?printBed:100:size;
  
    
if($children)if(2D){
    scale([v[1],v[3]])intersection(){
    children();
    rotate(0)square(size);
    }
    
    scale([v[0],v[3]])intersection(){
    children();
    rotate(90)square(size);
    }
    scale([v[0],v[2]])intersection(){
    children();
    rotate(180)square(size);
    }
    
    scale([v[1],v[2]])intersection(){
    children();
    rotate(-90)square(size);
    }
}else{
    
    scale([v[0],v[2],v[5]])intersection(){
    children();
    rotate(-180)cube(size);
    }  
    scale([v[0],v[3],v[5]])intersection(){
    children();
    rotate(+90)cube(size);
    }   
    scale([v[1],v[3],v[5]])intersection(){
    children();
    rotate(0)cube(size);
    }     
    scale([v[1],v[2],v[5]])intersection(){
    children();
    rotate(-90)cube(size);
    } 
    
    scale([v[0],v[2],v[4]])intersection(){
    children();
    rotate([-90,0,-180])cube(size);
    }  
    scale([v[0],v[3],v[4]])intersection(){
    children();
    rotate([-90,0,90])cube(size);
    }   
    scale([v[1],v[3],v[4]])intersection(){
    children();
    rotate([-90,0,0])cube(size);
    }     
  
    scale([v[1],v[2],v[4]])intersection(){
    children();
    rotate([-90,0,-90])cube(size);
    }       

}
HelpTxt("Scale",["v",v,
"2D",2D,"size",size],help);
MO(!$children);
}


module Drehpunkt(x=0,rz=0,rx=0,ry=0,y=0,z=0,messpunkt=messpunkt,help)
{
    y=is_list(x)?x[1]:y;
    z=is_undef(x[2])?z:x[2];
    x=is_list(x)?x[0]:x;
    lMP=is_bool(messpunkt)?$vpd/4:messpunkt;
    
    translate([x,y,z])rotate([rx,ry,rz])translate([-x,-y,-z])children();
    if(messpunkt)
    {
        if(rz)%color("blue")translate([x,y,z])cylinder(lMP,d=.5,center=true,$fn=12);
        if(ry)%color("green")translate([x,y,z])rotate([0,0,rz])rotate([90,0,0])cylinder(lMP,d=.5,center=true,$fn=12);
        if(rx)%color("red")translate([x,y,z])rotate([rx,ry,rz])rotate([0,90,0])cylinder(lMP,d=.5,center=true,$fn=12);   
        %color("yellow")translate([x,y,z])sphere(d=1,$fn=12);
    }
    MO(!$children);
    
    HelpTxt("Drehpunkt",[
    "x",x,
    "rz",rz,
    "rx",rx,
    "ry",ry,
    "y",y,
    "z",z,
    "messpunkt",messpunkt],
    help);

}

/** \page Modifier
Rand() creates an outline on a polygon
\param rand thickness of outline + or -
\param center if outline centered
\param fn,fs fragments for outline
\param delta, chamfer  use delta (no radial extension)
\param help  help 
*/

/* 
Rand(1,center=1.0,delta=0)Star(8);
Tz(-1)Color(alpha=0.3)Star(8);
//*/

module Rand(rand=n(1),center=false,fn=0,fs=$preview?min(fs,.3):fs,delta=false,chamfer=false,help){
  $fs=fs;
  ifn=$fn;
    
if(!center){ 
    if(rand>0)difference(){
          offset(r=delta?undef:rand,delta=rand,$fn=fn,chamfer=chamfer?true:false)children($fn=ifn);
          union(){
            $helpM=0;
            $info=0;
            children();
          }
        }
    if(rand<0)difference(){
          children();
          union(){
            $helpM=0;
            $info=0;
            offset(r=delta?undef:rand,delta=rand,$fn=fn,chamfer=chamfer?true:false)children($fn=ifn);
          }
        }
    }
    
if(center&&rand)
    difference(){
       chg=sign(b(center,false))*(rand/2)*(1-abs(b(center,false)) );
       offset(r=delta?undef:abs(rand)+chg,$fn=fn,delta=abs(rand),chamfer=chamfer?true:false)offset(r=true?undef:-abs(rand/2)-chg,$fn=fn,delta=-abs(rand/2)-chg,chamfer=chamfer?true:false)children($fn=ifn);
      union(){
          $helpM=0;
          $info=0;
         offset(r=delta?undef:-abs(rand)-chg,$fn=fn,delta=-abs(rand),chamfer=chamfer?true:false) offset(r=true?undef:(abs(rand/2)+chg),$fn=fn,delta=abs(rand/2)+chg,chamfer=chamfer?true:false)children($fn=ifn);
      }
    }     

if(rand==0)children();
    MO(!$children);
    
    HelpTxt("Rand",["rand",rand,"center",center,"fn",fn,"fs",fs,"delta",delta,"chamfer",chamfer],help);
}

/** \page Polygons
Rund() polygon rounds a polygon via offset
\param or  outer radius
\param ir inner radius outer radius is used if undef
\param chamfer use chamfer
\param fn fragments (optional [or,ir])
\param fs fragmentsize (optional [or,ir])
*/
//Rund(1,2)Star();

module Rund(or=+0,ir,chamfer=false,fn,fs=$preview?min(fs,.3):fs,fa=$fa,help) {
    fs=is_list(fs)?fs:[fs,fs];
    fn=is_list(fn)?fn:[fn,fn];
    ir=is_undef(ir)?is_list(or)?or[1]:or:ir;
    or=is_list(or)?or[0]:or;
    chamfer=chamfer?true:false;
   if(!chamfer)
          offset(r = -ir,$fn=fn[1],$fs=fs[1],$fa=fa)offset(r =  ir,$fn=fn[1],$fs=fs[1],$fa=fa) 
          offset(r =  or,$fn=fn[0],$fs=fs[0],$fa=fa)offset(r = -or,$fn=fn[0],$fs=fs[0],$fa=fa)
       children();
     
   
   if(chamfer)offset(delta = or,chamfer=chamfer)offset(delta = -or,chamfer=chamfer)
              offset(delta = -ir,chamfer=chamfer)offset(delta = ir,chamfer=chamfer) 
       children();
MO(!$children);
HelpTxt("Rund",["or",or,"ir",ir,"chamfer",chamfer,"fn",fn,"fs",fs],help);
}


}//fold// /ΔΔ Modificatoren ΔΔ/ //
{//fold // \∇∇ Helper ∇∇/ // (not for creating geometry or objects)


/** \page Helper
PolyDeg(points)  shows the angle with colors in a polygon
\name PolyDeg
\param points points
\param rad radius of marker
\param poly  draw polygon from points
\param txt  anotation angle
*/
module PolyDeg(points,rad=1,poly=true,txt=true,help){

c=[
"darkOrange",
"Chartreuse",
"LightSkyBlue",
"SteelBlue",
];

HelpTxt("PolyDeg",["points",points,"rad",rad,"poly",poly,"txt",txt],help);

Echo("No Points",color="redring",condition=!is_list(points[2]));
if(is_list(points[2])&&poly)polygon(points,convexity=5);

if(is_list(points[2]))
  for(p=[0:len(points)-1])translate(points[p]) {
    let(
          offset=0,
          pBef=points[(p+len(points)-1)%len(points)],
          pNow=points[p],
          pNex=points[(p+1)%len(points)],
          grad1=atan2(pBef.x-pNow.x,pBef.y-pNow.y),
          grad2=atan2(pNex.x-pNow.x,pNex.y-pNow.y),
          gradDiff=grad1-grad2,
          grad=gradDiff<0?abs(gradDiff):360-gradDiff,
          gradSup=360-grad
       )
    %Tz(.1)union(){
      color(abs(grad)%90?abs(grad)>90?abs(grad)>180?c[3]:c[2]:c[0]:c[1])polygon(kreis(r=rad,grad=grad,rot=grad1,center=false,rand=rad/5));
      color(abs(gradSup)%90?abs(gradSup)>90?abs(gradSup)>180?c[3]:c[2]:c[0]:c[1])polygon(kreis(r=rad,grad=gradSup,rot=grad2,center=false,rand=-rad/5));

      if(txt)color(abs(gradSup)%90?abs(gradSup)>90?abs(gradSup)>180?c[3]:c[2]:c[0]:c[1])text(str(gradSup,"° "),size=b(txt,false),halign="right");
      if(txt)color(abs(grad)%90?abs(grad)>90?abs(grad)>180?c[3]:c[2]:c[0]:c[1])text(str(grad,"°"),size=b(txt,false));
    }
  }
}

/** \page Helper
PrevPos() object position Object for preview only
\name PrevPos
\param t translate preview position
\param z translate z in preview
\param rot rotates in preview
\param tP translates the print position
*/

module PrevPos(on=true,t=[0,0,0],z=0,rot=[180,0,0],tP=[0,0,0],help){
rot=is_num(rot)?[0,0,rot]:rot;
if($preview&&on||on==2)translate(v3(t)+[0,0,z])rotate(v3(rot))children();
else translate(v3(tP))children();

Echo("Render with PrevPos!",color="warning",condition=on==2);

MO(!$children);

HelpTxt("PrevPos",["on",on,"t",t,"z",z,"rot",rot,"tP",tP],help);
};


/** \page Helper
Points() show point position with numbers in preview only
\name Points
\param points points list to show
\param color optional color else rainbow is used
\param size  optional else distance is used to scale
\param hull  optional creates a convex hull around points - number will be used for transparency/alpha
\param loop  size of a loop of points 
\param start start point of that loop
\param mark  list for points to mark
\param markS markCol marking size and color
\param face  highlight marked points as face with normal and order number
\param center orientation of number label radial (true) or viewpoint
\param help help
*/

//Points(octa(5),loop=4,size=0.4);
//Points(kreis(),mark=[0,1,2,3,4,5,6,7,8],loop=13,start=10);
//Points(octa(5),mark=[3,4,2,1],hull=.5*0);
//Points(octa(5),mark=[3,0,2,1],hull=true);



module Points(points=[[0,0]],color,size,hull,loop,start=0,mark,markS,markCol,face=true,center,help){
  center=is_undef(center)?is_num(points[0].z)?true:false:center;
  lp=assert(is_list(points),"no point(s) input")len(points);
  loop=is_undef(loop)?lp>25?lp:
                            lp:
                      loop;
  cMark=is_undef(markCol)?["Magenta","Chartreuse","Aqua","LightSkyBlue"]:markCol;
  size=is_undef(size)?$vpd/100:size;
  markS=is_undef(markS)?$vpd/40:markS;// scale marks 
  lenM=is_list(mark)?len(mark):0;
  
  if($preview){

    if(face&&lenM>2){
      color("Chartreuse",alpha=.5)
      polyhedron([for(i=[0:lenM-1])points[mark[i]]],[[for(i=[0:lenM-1])i]]);
      if(len(points[0])==3)for(i=[0:lenM-1]){
        p0=points[mark[i]];
        p1=points[mark[(i+1)%lenM]]-points[mark[i]];
        p2=points[mark[(i+2)%lenM]]-points[mark[i]];
        pNormal=cross(  p2, p1  );
//echo(i,norm(pNormal));
        translate((p0+points[mark[(i+1)%lenM]]+points[mark[(i+2)%lenM]])/3){
          color("Lime",0.8)hull(){
            translate(pNormal/norm(pNormal)*markS)sphere(minVal,$fn=3);
            sphere(d=markS/3,$fn=9);
          }
          color("HotPink",0.8)sphere(d=markS/2.9,$fn=9);
          }
      }
    }
     
    for (i=[0:is_list(points[0])?lp-1:0])translate(is_list(points[0])?points[i]:points){
     if(is_num(mark)&&i==mark){
      color("Chartreuse", alpha=.6)OctaH(.6*markS);
      color("Chartreuse", alpha=1)T(0,markS)linear_extrude(.01,convexity=3)text(str(points[i]),size=markS/3,halign="center");
      }
     if(is_list(mark)) for(j=[0:len(mark)-1])if(i==mark[j]){
      color(cMark[j%len(cMark)], alpha=0.4)OctaH(0.4*markS,$fn=12);
      if(face){
       // color("DarkGrey", alpha=1)rotate($vpr)T(0,markS*0.5)linear_extrude(.01,convexity=3)text(str(j),size=markS/4,halign="center");
        color("white", alpha=1)rotate($vpr)T(0,0,markS*0.5)linear_extrude(.01,convexity=3)text(str(j),size=markS/4,halign="center",valign="center");
     }
    }

     if(i>=start&&i<start+loop){
      if(i==start          )color("red",  alpha=.4)sphere(.25*markS,$fn=24);
      if(i==start +loop-1)color("Magenta", alpha=.4)sphere(.25*markS,$fn=24);

      if(!center)
        Color(is_undef(color[0])?1/(loop*1.1)*(i-start):color,is_undef(color[3])?.5:color[3])rotate($vpr){
      translate([0,i==lp-1?size *+2.5:size*1.25])linear_extrude(.01,convexity=3)text(str(i==lp-1?"end":"p",i),size=size,halign="center");
        rotate([-90,-45,45])cylinder(i==lp-1?size*3.5:size,0,size/5,$fn=3);
        }
      else Color(is_undef(color[0])?1/(loop*1.1)*(i-start):color,is_undef(color[3])?.5:color[3])rotate(vektorWinkel(points[i],[0,0,points[i].z])+[90,0,0]){
      translate(i==lp-1?[0,size *+3.5,size*3.5]:i==start+loop-1?[0,size*2.25,size*0.65]:[0,size*1.25,size*0.65])linear_extrude(.01,convexity=3)text(str(i==lp-1?"end":"p",i),size=size,valign="center",halign="center");
       rotate([i==start+loop-1?-45:-35,0,0])rotate(30)cylinder(i==lp-1?size*3.5:i==start+loop-1?size*1.5:size,0,size/5,$fn=3);
       }
    }}

     if(hull&&lp>2) if(len(points[0])==3)
        color(alpha=is_bool(hull)?.5: hull) hull() polyhedron(points, [[for(i=[0:len(points)-1]) i ]]);
        else if(len(points[0])==2)color(alpha=is_undef(color[3])?is_bool(hull)?.2:hull:color[3])polygon(points);

  }
  
  HelpTxt("Points",["points",[[1,2,3]],"color",color,"size",size,"hull",hull,"loop",loop,"start",start,"mark",mark,"markS",markS,"markCol",markCol,"face",face,"center",center],help);
  }

 //Points(Kreis(grad=120,fn=6),start=0,loop=6,mark=[2,3,4,12]);


/// Cutaway children for preview
module Schnitt(on=$preview,r=0,x=0,y=0,z=-0.01,rx=0,ry=0,sizex,sizey,sizez,center=0,help){
  sizex=is_undef(sizex)?bed?printBed.x:max(viewportSize*5,150):sizex;
  sizey=is_undef(sizey)?bed?printBed.y:max(viewportSize*5,150):sizey;
  sizez=is_undef(sizez)?bed?100:max(viewportSize*5,150):sizez;
  
    center=is_bool(center)?center?1:0:center;
    if($children)difference()
    {
      union()children();
      if((on&&$preview)||on==2)  translate([x,y,z])rotate([rx,ry,r])color([1,0,0,1])translate([center>0?-sizex/2:0,abs(center)==1?-sizey/2:-sizey,center>1||center<0?-sizez/2:0])cube([sizex,sizey,sizez],center=false);
    }

Echo("»»»»––SCHNITT in render! ––«««« \n",color="warning",condition=on==2);

HelpTxt("Schnitt",["on",on,"r",r,"x",x,"y",y,"z",z,"rx",rx,"ry",ry,"sizex",sizex,"sizey",sizey,"sizez",sizez,"center",center],help);

MO(!$children);     
}


module Cut(on=1,cut=[+1,+1,+1],t=[+0,0,+0.01],rot=+0,z=0,size=500,color,ghost=false,help){

cut=v3(cut);
t=v3(t);
ghost=is_bool(ghost)?ghost?0.15:ghost:ghost;
size=is_list(size)?size:[1,1,1]*size;
ghostscale=.9999;
$idx=0;

intersection(){
  union()children();
  if($preview&&on||on==2)color(color)rotate(rot){
    if(cut.x)color("red")translate([(cut.x>0?-size.x:0) + t.x,- size.y/2               , - size.z/2])cube(size);
    if(cut.y)color("green")translate([-size.x/2                ,(cut.y>0?0:-size.y) + t.y, - size.z/2])cube(size);
    if(cut.z)color("blue")translate([-size.x/2                ,- size.y/2               ,(cut.z>0? -size.z:0) + t.z+z])cube(size);
  }
}

if(ghost&&on&&$preview){
 $info=false;
 $idx=1;
 
 color("lightSkyBlue",alpha=ghost)%scale(ghostscale)children();
 }
Echo("»»»»––Cut is rendered! ––«««« \n",color="warning",condition=on==2);
HelpTxt("Cut",["on",on,"cut",cut,"t",t,"rot",rot,"z",z,"size",size,"color",color,"ghost",ghost],help);
MO(!$children);     
}



/// 3 axis Projection 

module 3Projection(s=10,cut=true,active=[1,1,1],help){
    s=is_list(s)?s:[s,s];
    cut=is_list(cut)?cut:[cut,cut,cut];
    $info=false;
    $helpM=false;
   if(active.z) projection(cut=cut.z)children();
   if(active.x) translate([s.x,0,0])projection(cut=cut.x)rotate([0,90,0])children();
   if(active.y) translate([0,s.y,0])projection(cut=cut.y)rotate([-90,0,0])children();
    %children();
    MO(!$children);
    HelpTxt("3Projection",["s",s,"cut",cut,"active",active],help);
    
}


/// Arranges (and color) list of children for display
module Anordnen(es=10,e,option=1,axis=1,c=0,r,cl=.5,rot=0,loop=true,center=true,inverse=false,name,help){

option=option==3&&version()==[2021, 1, 0]?4:option;
optiE= function(e=[0,0,1])
    let (sqC=sqrt($children))
    e.x*e.y==$children?
    e:
    e.x>4?optiE([e.x-1,e.y,1])://min 4 rows else alternate  to circumvent primes
    e.y>$children?[round(sqC),ceil($children/round(sqC)),1]:
    optiE([ceil(sqC),e.y+1,1]);
    
//echo(optiE());
    e=option==3||option==4?is_undef(e)?optiE():
                                      is_list(e)?
                                          e.z?e:
                                          concat(e,1):
                                      [ceil($children/e),e,1]:
                         is_undef(e)?$children:e;

InfoTxt("Anordnen",["e",e,"children",$children],name);    


    
 if(option==1){
     r=is_undef(r)?e==1?0:(es/2)/sin(180/e):r;
     Polar(e,x=r,re=rot,name=false){
       // idx=$idx;
       // $idx=0;
       $idxON=true;
       $info=name;
       if(is_undef(c)&&(loop?true:$idx<$children))
         children((inverse?$children-$idx-1:$idx)%$children);//
     else Color(c+1/$children*$idx,l=cl)
         if(loop?true:$idx<$children)children((inverse?$children-$idx-1:$idx)%$children);
         }
     }
     
  if(option==2)
      Linear(e=e,es=es,re=rot,center=center,x=axis==1?1:0,y=axis==2?1:0,z=axis==3?1:0,name=false){
        $info=name;
        //idx=$idx;
        //$idx=0;
        $idxON=true;
        if(is_undef(c))children($idx%$children);
        else Color(c+1/$children*$idx,l=cl)children($idx%$children);
      }

 if(option==3) Grid(e=e,es=es,center=center,name=false){
     $info=name;
     childINDX=inverse?(loop?e.x*e.y*e.z:$children -1)-($idx[0]+e.x*$idx[1]):($idx[0]+e.x*$idx[1]);
     //idx=$idx;
     //$idx=0;
     $idxON=true;
     rotate(rot)
     if(is_undef(c)&&(loop?true:$idx.x+e.x*$idx.y+e.x*e.y*$idx.z<$children))children(childINDX%$children);
     else Color(([$idx.x/(e.x -1),$idx.y/(e.y -1),$idx.z/e.z]+[ 0,0,cl])){
     if(loop?true:$idx.x+e.x*$idx.y+e.x*e.y*$idx.z<$children)children(childINDX%$children);
     //text(str([$idx.x/(e.x-1), $idx.y/(e.y-1), $idx.z/e.z]+[ 0,0,cl]),size=2);
    }
 }
 
 if(option==4) Grid(e=e,es=es,center=center,name=false)IDX($idx,$children)children($idx%$children);
   
 module IDX(idx,childrn){
   $info=name;
   $idxON=true;
   $idx=inverse?(loop?e.x*e.y*e.z:childrn -1)-(idx[0]+e.x*idx[1]):(idx[0]+e.x*idx[1]);
   rotate(rot)
     if(is_undef(c)&&(loop?true:idx.x+e.x*idx.y+e.x*e.y*idx.z<childrn))children();
     else Color(([idx.x/(e.x -1),idx.y/(e.y -1),idx.z/e.z]+[ 0,0,cl])){
     if(loop?true:idx.x+e.x*idx.y+e.x*e.y*idx.z<childrn)children();
    }
  }

 
HelpTxt("Anordnen",["es",es,"e",e,"option",option,"axis",axis,"c",c,"r",r,"cl",cl,"rot=",rot,"loop",loop,"center",center,"inverse",inverse,"name",name],help);
}


co=[
["silver","lightgrey","darkgrey","grey","slategrey","red","orange","lime","cyan","lightblue","darkblue","purple",[.8,.8,.8,.3],[.8,.8,.8,.6],"cyan","magenta","yellow","black","white","red","green","blue",[0.77,0.75,0.72]],//std
["White","Yellow","Magenta","Red","Cyan","Lime","Blue","Gray","Silver","Olive","Purple","Maroon","Teal","Green","Navy","Black"],//VGA
["Gainsboro","LightGray","Silver","DarkGray","Gray","DimGray","LightSlateGray","SlateGray","DarkSlateGray","Black"],//grey
["Pink","LightPink","HotPink","DeepPink","PaleVioletRed","MediumVioletRed"],//pink
["LightSalmon","Salmon","DarkSalmon","LightCoral","IndianRed","Crimson","Firebrick","DarkRed","Red"],//red
["OrangeRed","Tomato","Coral","DarkOrange","Orange"],//orange
["Yellow","LightYellow","LemonChiffon","LightGoldenrodYellow","PapayaWhip","Moccasin","PeachPuff","PaleGoldenrod","Khaki","DarkKhaki","Gold"],//yellows
["Cornsilk","BlanchedAlmond","Bisque","NavajoWhite","Wheat","Burlywood","Tan","RosyBrown","SandyBrown","Goldenrod","DarkGoldenrod","Peru","Chocolate","SaddleBrown","Sienna","Brown","Maroon"],//browns
["DarkOliveGreen","Olive","OliveDrab","YellowGreen","LimeGreen","Lime","LawnGreen","Chartreuse","GreenYellow","SpringGreen","MediumSpringGreen","LightGreen","PaleGreen","DarkSeaGreen","MediumAquamarine","MediumSeaGreen","SeaGreen","ForestGreen","Green","DarkGreen"],//greens
["Cyan","LightCyan","PaleTurquoise","Aquamarine","Turquoise","MediumTurquoise","DarkTurquoise","LightSeaGreen","CadetBlue","DarkCyan","Teal"],//cyans
["LightSteelBlue","PowderBlue","LightBlue","SkyBlue","LightSkyBlue","DeepSkyBlue","DodgerBlue","CornflowerBlue","SteelBlue","RoyalBlue","Blue","MediumBlue","DarkBlue","Navy","MidnightBlue"],//blue
["Lavender","Thistle","Plum","Violet","Orchid","Magenta","MediumOrchid","MediumPurple","BlueViolet","DarkViolet","DarkOrchid","DarkMagenta","Purple","Indigo","DarkSlateBlue","SlateBlue","MediumSlateBlue"],//violetts
["White","Snow","Honeydew","MintCream","Azure","AliceBlue","GhostWhite","WhiteSmoke","Seashell","Beige","OldLace","FloralWhite","Ivory","AntiqueWhite","Linen","LavenderBlush","MistyRose"],//white
["Red","darkorange","Orange","Yellow","Greenyellow","lime","limegreen","turquoise","cyan","deepskyblue","dodgerblue","Blue","Purple","magenta"],//rainbow
["magenta","Purple","Blue","dodgerblue","deepskyblue","cyan","turquoise","limegreen","lime","Greenyellow","Yellow","Orange","darkorange","Red","darkorange","Orange","Yellow","Greenyellow","lime","limegreen","turquoise","cyan","deepskyblue","dodgerblue","Blue","Purple"]//rainbow2
];

// color by color lists
module Col(no=0,alpha=1,pal=0,name=0,help){
   palette=["std","VGA","grey","pink","red","orange","yellow","brown","green","cyan","blue","violett","white","rainbow"]; 
    
HelpTxt("Col",["no",no,"alpha",alpha,"pal",pal,"name",name],help);

    for(i=[0:1:$children-1]){
    $idx=i;
    color(co[pal][(no+i)%len(co[pal])],alpha)children(i);
    union(){
      $idx=0; 
    InfoTxt("Col",["Color children ($idx)",str(i," Farb№: ",no+i,"- ",co[pal][(no+i)%len(co[pal])])," von ",len(co[pal])-1,"Palette",str(pal,"/",palette[pal],(no+i>len(co[pal])-1)?" — Out of Range":"")],name);
    }
    }
    MO(!$children);
}


// object color with hue (and rgb) also color change for multiple children
module Color(hue=0,alpha=1,v=1,l=0.5,spread=1,$idxON=true,name=0,help=false){
    
    function val(delta=0,hue=-hue*360,v=v,l=l*-2+1)=
        v*max(
            min(
                (0.5+sin((hue+delta)))*(l>0?1-l:1)
                +(max(
                    .5+sin((180+hue+delta))
                ,0)*(l<=0?-l:0))
            ,1)
        ,0);
       
       start=90;// to start with red
        
     if($children) for(i=[0:$children-1]){//
            $idx=is_undef($idx)?i:$idx;
            c=is_string(hue)?hue:is_list(hue)?[(hue[0]+i*(1-hue[0]%1.001)/(spread*$children))%1.001,(hue[1]+i*(1-hue[1]%1.001)/(spread*$children))%1.001,(hue[2]+i*(1-hue[2]%1.001)/(spread*$children))%1.001]:[val(start,hue=(-hue-i/(spread*$children))*360),val(+start+120,hue=(-hue-i/(spread*$children))*360),val(start+240,hue=(-hue-i/(spread*$children))*360)];
            
       if(name)  echo(str("Color ",name," child ($idx) ",i," hex=",Hexstring(c)," ",Hex(alpha*255),//" <font color=",Hexstring(c),"> ████ </font>
          "RGB=",c));
      // $idxON=true;
       color(c,alpha)children(i); 
            
             
        }
        else MO(!$children);

    HelpTxt("Color",[
    "hue",hue,"alpha",alpha,"v",v,"l",l,"spread",spread,"name",name,
        ],help);
}

// / Echo Helper // / console texts

/// missing object text
module MO(condition=true,warn=false){
$idx=is_undef($idx)?false:$idx;
Echo(str(parent_module(2)," has no children!"),color=warn?"warning":"red",condition=condition&&$parent_modules>1&&!$idx,help=false);    
}


/// echo color differtiations
module Echo(title,color="#FF0000",size=2,condition=true,help=false){
 idx=is_undef($idx)?false:is_list($idx)?norm($idx):$idx;
 idxON=is_undef($idxON)?false:$idxON?true:false;
 if(condition&&(!idx||idxON))
     if(version()[0]<2021)echo(str("<H",size,"><font color=",color,">",title)); 
     else if (color=="#FF0000"||color=="red")echo(str("\n🔴\t»»» ",title));
     else if (color=="redring")echo(str("\n⭕\t»»» ",title));
     else if (color=="#FFA500"||color=="orange")echo(str("\n🟠\t»»» ",title));    
     else if (color=="#00FF00"||color=="green"||color=="info")echo(str("🟢\t ",title));
     else if (color=="#0000FF"||color=="blue") echo(str("🔵\t ",title));
     else if (color=="#FF00FF"||color=="purple") echo(str("🟣\t ",title));    
     else if (color=="#000000"||color=="black") echo(str("⬤\t ",title));
     else if (color=="#FFFFFF"||color=="white") echo(str("◯\t ",title));
     else if (color=="#FFFF00"||color=="yellow"||color=="warning") echo(str("⚠\t ",title));    
         else echo(str("• ",title)); 

 HelpTxt("Echo",["title",title,"color",color,"size",size,"condition",condition],help);
}

/// display variable values
module InfoTxt(name,string,info,help=false){
  $tab=is_undef($tab)?0:$tab;
  info=is_undef(info)?is_undef($info)?false:
                                $info:
  info;
  
  //  https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/User-Defined_Functions_and_Modules#Function_Literals
 noInfo=is_undef($noInfo)?false:$noInfo; 
 idx=is_undef($idx)?false:is_list($idx)?norm($idx):$idx;
 idxON=is_undef($idxON)?false:$idxON?true:false;
 joinArray= function(in,out="",pos=0) pos>=len(in)?out: // scad version > 2021
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1);   
    
 if(version()[0]<2021){   
  infoText=[for(i=[0:2:len(string)-1])str(string[i],"=",is_num(string[i+1])?negRed(string[i+1]):string[i+1],i<len(string)-2?", ":"")];
      
if(info)if(is_list(string))echo( 
 str(is_bool(info)?"":"<b>",info," ",name," ", 
infoText[0]
,infoText[1]?infoText[1]:""
,infoText[2]?infoText[2]:""
,infoText[3]?infoText[3]:""
,infoText[4]?infoText[4]:""
,infoText[5]?infoText[5]:""
,infoText[6]?infoText[6]:""
,infoText[7]?infoText[7]:""
,infoText[8]?infoText[8]:""
,infoText[9]?infoText[9]:""
));
else HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=1);
}
else { // current version info
  infoText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],i<len(string)-2?", ":"")];
      
if(info&&(!idx||idxON)&&!noInfo)if(is_list(string))echo( 
 str(is_string(info)?$tab?"⏩\t":
                          "🟩\t••":
                     "",$tab?" ╞▷   ":
                             "",b($tab,false)>1?" ┗▶   ":
                                                " ",info," ",name," ",
joinArray(infoText)));

else HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=1);
}
HelpTxt(titel="InfoTxt",string=["name",name,"string","[text,variable]","info",info],help=help);
}


// display the module variables in a copyable format
module HelpTxt(titel,string,help){ 
  help=is_undef(help)?is_undef($helpM)?false:
                                $helpM:
  help;
  idxON=is_undef($idxON)?false:$idxON?true:false;
  idx=is_undef($idx)||idxON?false:is_list($idx)?norm($idx):$idx;
  
   joinArray= function(in,out="",pos=0) pos>=len(in)?out:
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1); 

helpText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],",\n  ")];
 if(version()[0]<2021){ 
if(help)if(is_list(string))echo(
    
str("<H3> <font color=",helpMColor,"> Help ",titel, "(",
    helpText[0]
,helpText[1]?helpText[1]:""
,helpText[2]?helpText[2]:""
,helpText[3]?helpText[3]:""
,helpText[4]?helpText[4]:""
,helpText[5]?helpText[5]:""
,helpText[6]?helpText[6]:""
,helpText[7]?helpText[7]:""
,helpText[8]?helpText[8]:""
,helpText[9]?helpText[9]:""
,helpText[10]?helpText[10]:""
,helpText[11]?helpText[11]:""
,helpText[12]?helpText[12]:""
,helpText[13]?helpText[13]:""
,helpText[14]?helpText[14]:""
,helpText[15]?helpText[15]:""
,helpText[16]?helpText[16]:""
,helpText[17]?helpText[17]:""
,helpText[18]?helpText[18]:""
,helpText[19]?helpText[19]:""
,helpText[20]?helpText[20]:"" 
,helpText[21]?helpText[21]:""
,helpText[22]?helpText[22]:""
,helpText[23]?helpText[23]:""
,helpText[24]?helpText[24]:""
,helpText[25]?helpText[25]:""
,helpText[26]?helpText[26]:""
,helpText[27]?helpText[27]:""
,helpText[28]?helpText[28]:""
,helpText[29]?helpText[29]:""


// ," name=",name,
," help);"));  
else HelpTxt("Help",["titel",titel,"string",["string","data","help",help],"help",help],help=1);
}
else{ // current versions help 
if(help&&!idx)if(is_list(string))echo(
    
str("🟪\nHelp ",titel, "(\n  ",
joinArray(helpText)
,"help=",help,"\n);\n"));    
else HelpTxt("Help",["titel",titel,"string",string,"help",help],help=1);
}
}

/** \page Helper
 Caliper() shows a distance and can be used as annotation
 \brief Caliper shows a distance and can be used as annotation
 \param l length to show
 \param in direction
 \param center centered length
 \param messpunkt show / size of gizmo
 \param translate  translates the text and arrow
 \param end differnt end options [0:none,1:triangle, 2:square, 3:arrow in, 4:arrow out]
 \param h height while end=0,3,4 can be 2D if h=0 
 \param on switch on=2 if Caliper should be rendered
 \param l2 arrow width
 \param txt  l+mm is used optional text
 \param txt2  optional second text
 \param size size
*/
//Caliper(end=0,messpunkt=0,in=1,translate=[20,-5],center=+1);

//Caliper(end=3);
//Caliper(end=3,txt2="X—Length",in=+1);


module Caliper(l=40,in=1,center=true,messpunkt=true,translate=[0,0,0],end=1,h,on=$preview,l2,txt,txt2,size=$vpd/15,render,s,t,cx,cy,help=false){
    
    on=render?render:on;
    s=s?s:size;
    txt=is_undef(txt)?str(l,end==2?"":"mm"):str(txt);
    center=is_bool(center)?center?1:0:center;
    textl=in>1?s/2.5:s/4*(len(str(txt)));// end=0,3,4 use own def
    line=s/20;
    translate=t?v3(t):v3(translate);
    //l2=is_undef(l2)?s:l2;
    
    
    if(on&&$preview||on==2)translate(translate)translate(in>1?center?[0,0]:[0,l/2]:center?[0,0]:[l/2,0]){
      if(end==1)Col(5){
        h=is_undef(h)?1.1:max(minVal,h);
        rotate(in?in==2?90:in==3?-90:180:0)linear_extrude(h,center=true)Mklon(tx=l/2,mz=0)polygon([[max(-5,-l/3),0],[0,s],[0,0]]);
        rotate(in?in==2?90:in==3?-90:180:0)linear_extrude(h,center=true)Mklon(tx=-l/2,mz=0)polygon([[max(-5,-l/3),0],[0,-s],[0,0]]);
        
        Text(h=h+.1,text=txt,center=true,size=s/4,trueSize="size",cx=cx,cy=cy);
        }
     else if(end==2)Col(3)union(){
        h=is_undef(h)?1.1:max(minVal,h);
        rotate(in?in==2?90:in==3?-90:180:0)MKlon(tx=l/2)T(-(l-textl*2)/4,0)cube([max(l-textl*2,.01)/2,line,h],center=true);
        rotate(in?in==2?90:in==3?-90:180:0)MKlon(tx=l/2)cube([line,s,h],center=true);    
        translate([(l<textl+1&&in<2)?l/2+textl/2+1.5:0,
          l<s/2 +1&&in>1?l/2+s/4+1:0,0])
            Text(h=h+.1,text=txt,center=true,size=s/2,trueSize="size",cx=cx,cy=cy);
         if(l<textl+1&&in<2)translate([.25,0])square([l+.5,line],true);
         if(l<s+1&&in>=2) translate([0,.25])square([line,l+.5],true);
         
        }
        else Col(1) {
        h=is_undef(h)?.1:h;
          if(h) linear_extrude(h,convexity=5) Dimensioning();
          else Dimensioning();
        }
    }    
        
Echo("Caliper will render",color="warning",condition=on==2);  
if(h&&end&&on&&end<3)
Pivot(messpunkt=messpunkt,p0=translate,active=[1,1,1,1,norm(translate)]);
    
    HelpTxt("Caliper",[
    "l",l,
    "in",in,
    "size",size,
    "center",center,
    "messpunkt",messpunkt,
    "translate",translate,
    "end",end,
    "h",h,
    "on",on,
    "l2",l2,
    "txt",txt,
    "txt2",txt2]
    ,help);
    
    
  module Dimensioning (t=translate){
            s=s==$vpd/15?5:s;
            txt2=txt2?str(txt2):"";
            line=s/20;
            textS=len(txt2)?s/2*.72:s*.72;//text size
            l2=l2?l2:s/1.5;
            textl=in>1?(len(txt2)?3:1.5)*textS:1+textS*max(len(txt),len(txt2))*0.95;
            arrowL=min(l/6,s);
            textOut=l<textl+arrowL*2||(abs(translate.y)>l/2&& (in==2||in==3) )||(abs(translate.x)>l/2&&in!=2&&in!=3); // is text outside l
            textOffset=l<textl+arrowL*2?l/2+textl/2+1:0;
            diffT=in!=2&&in!=3? t.x:-t.y;
            
// text line
        if(l-textl>0)rotate(in?in==2?90:in==3?-90:180:0){
         if(!textOut&&l-textl - diffT*2>0) T(-l/2)T((l-textl)/4 +diffT/2,0)square([(l-textl)/2-diffT,line],center=true);
         if(!textOut&&l-textl + diffT*2>0) T( l/2)T(-(l-textl)/4 +diffT/2,0)square([(l-textl)/2+diffT,line],center=true);
        }
//End lines vertical
        translate(in!=2&&in!=3?[-translate.x,0]:[0,-translate.y])rotate(in?in==2?90:in==3?-90:180:0){
        MKlon(tx=l/2){
           T(end?end==4?-line/2:+line/2:0) square([line,s],center=true);
           if(end)rotate(end==4?180:0)Pfeil([0,arrowL],b=[line,l2],center=[-1,1],name=false);
        }
        if(textOut) square([l,line],true); // Verbindung Pfeile
// text pos
        translate(in!=2&&in!=3?[(in?1:-1) * -translate.x,0]:[(in==2?1:-1)*translate.y,0]){
          translate([textOffset,0])rotate(in>1?-90:180){
            if(len(txt2))translate([0,-textS/1.5])Text(h=0,text=txt2,center=true,size=textS,trueSize="size",name=false,cx=cx,cy=cy);
            translate([0,len(txt2)?textS/1.5:0])Text(h=0,text=txt,center=true,size=textS,trueSize="size",name=false,cx=cx,cy=cy);
          }
        }
// verbindung text ausserhalb
        tOutDist=(in!=2&&in!=3)? t.x *(in   ?-1:1) + textOffset :
                                 t.y *(in==3?-1:1) + textOffset ;                                
                                
        if(textOut&&tOutDist)rotate(tOutDist<0?180:0)translate([0,-line/2])square([abs(tOutDist)-textl/2 ,line]);
        }
        
// verlängerungen translate auf 0.5
      mkL=end?end==4?l/2-line:l/2:l/2-line/2;
       if(abs(translate.y)>(l2/2+.5)&&in!=2&&in!=3)translate([-translate.x,0])MKlon(tx=mkL) mirror([0,translate.y>0?1:0,0])square([line,abs(translate.y)-.5],false);
       if(abs(translate.x)>(l2/2+.5)&&(in==2||in==3))translate([0,-translate.y])MKlon(ty=mkL) mirror([translate.x>0?1:0,0,0])square([abs(translate.x)-.5,line],false);    
       //if(translate.x) mirror([translate.x>0?1:0,0,0])T(l/2,-line/2)square([abs(translate.x),line],false);

  }// end Dimensioning


}// end Caliper

/** \page Helper
 Rod() is a Level staff
 /brief Rod() is a Level staff
 /param on  0=off,1= on,2= on in render
 /param pos positon [x,y,z]
 /param size length
 /param s  segment length
 /param axis [x,y,z] 0=off ,1 on, -1 add negative
 /param d diameter
 /param help help
*/
//Rod(size=10.2,s=0.5);

module Rod(on=1,pos=[0,0,0],size=$vpd,s=1,axis=[1,1,-1],d=1,help){
$fn=8;
size=is_list(size)?size:[size,size,size];
if($preview&&on||on==2)translate(pos){
  if(axis.x)rotate([0,90]){Axis(size=size.x,col=colX);
  if(axis.x<0)rotate([180])Axis(size=size.x,col=colX);}
  if(axis.y)rotate([-90]){Axis(size=size.y,col=colY);
  if(axis.y<0)rotate([180])Axis(size=size.y,col=colY);}
  if(axis.z)Axis(size=size.z,col=colZ);
  if(axis.z<01)rotate([180])Axis(size=size.z,col=colZ);
}
HelpTxt("Rod",["on",on,"pos",pos,"size",size,"s",s,"axis",axis,"d",d],help);
colX=[ [0.5,0,0],[1,1,1],[1,0.5,0],[.5,0.5,0.5],"magenta" ];
colY=[ [0,0.5,0],[1,1,1],[.5,1,.5],[.5,0.5,0.5],"lime" ];
colZ=[ [0,0,0.5],[1,1,1],[0,0.5,1],[.5,0.5,0.5],"aqua" ];

 module Axis(s=s,size=max(size),col=[[0,0,0]]){for (i=[0:size/s-1])translate([0,0,s*i])
  if(i%10||!i)color(col[i%2+(i%10<5?0:2)],.75)cylinder(d1=d,d2=d/1.5,h=s);
    else color(col[4],.5)cylinder(d1=d*2,d2=d/1.5,h=s);
    if(size/s%1)color("red")cylinder(h=size,d=d/1.5-.1);
 }
}


module SCT(a=90){
    echo(str("<H3>Winkel=",a," sin=",sin(a)," cos=",cos(a)," tan=",tan(a)));
    echo(str("<H3>Winkel=",a," asin=",asin(a)," acos=",acos(a)," atan=",atan(a)));    
}


module Line(p0=[0,0,0],p1=[10,10,0],d=.5,center=false,2D=false,text=false,fn=8,h,help=false){
  p0=p0[2]==undef?concat(p0,[0]):p0;
  p1=p1[2]==undef?concat(p1,[0]):p1;
p1t=p1-p0;    
  
  h=is_undef(h)?0:h;
x= p1t[0]; y = p1t[1]; z = p1t[2]; // point coordinates of end of cylinder
 
length = norm([x,y,z]);  // radial distance
b = length?acos(z/length):0; // inclination angle
c = atan2(y,x);     // azimuthal angle

points=center?[-p1t+p0,p0,p1]:[p0,p1t/2+p0,p1]; // for d=0  1d polyhedron

if(d)
  if(2D&&length&&!h)translate(p0)rotate([0,b-90,c])translate([0,center?0:-d/2,0]) square([center?length*2:length,d],center=center?true:false);
  else if(h&&length)translate(p0)rotate([0,b-90,c])translate([0,center?0:-d/2,0]) linear_extrude(h,center=center)square([center?length*2:length,d],center=center?true:false);
  
  else if(!2D&&!h&&length)translate(p0)rotate([0, b, c])
      cylinder(h=center?length*2:length,d=d,$fn=fn,center=center?true:false);
      
if(!d) polyhedron(points,[[0,1,2]]);
//Points(points);

  if (text&&$preview)
    %color("slategrey")translate(center?p0:p0+p1t/2)rotate($vpr)
      text(str(runden(center?length*2:length,3),"mm"),size=b(text,false));
  
HelpTxt("Line",[
  "p0",p0,
  "p1",p1,
  "d",d,
  "center",center,
  "2D",2D,
  "text",text,
  "fn",fn,
  "h",h
  ],help);  
  
}

module LineORG(p0=[0,0,0], p1=[10,10,0], d=.5,center=true) { //from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Tips_and_Tricks 
  
  p0=p0[2]==undef?concat(p0,[0]):p0;
  p1=p1[2]==undef?concat(p1,[0]):p1;
    
 // Find the unitary vector with direction v. Fails if v=[0,0,0].
function unit(v) = norm(v)>0 ? v/norm(v) : undef; 
// Find the transpose of a rectangular matrix
function transpose(m) = // m is any rectangular matrix of objects
  [ for(j=[0:len(m[0])-1]) [ for(i=[0:len(m)-1]) m[i][j] ] ];
// The identity matrix with dimension n
function identity(n) = [for(i=[0:n-1]) [for(j=[0:n-1]) i==j ? 1 : 0] ];

// computes the rotation with minimum angle that brings a to b
// the code fails if a and b are opposed to each other
function rotate_from_to(a,b) = 
    let( axis = unit(cross(a,b)) )
    axis*axis >= 0.99 ? 
        transpose([unit(b), axis, cross(axis, unit(b))]) * 
            [unit(a), axis, cross(axis, unit(a))] : 
        identity(3);   

    v = p1-p0;
    translate(p0)
        // rotate the cylinder so its z axis is brought to direction v
        multmatrix(rotate_from_to([0,0,1],v))
            cylinder(d=d, h=center?norm(v)*2:norm(v), $fn=12,center=center);
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






}//fold // \ΔΔ Helper   ΔΔ\ \\
{//fold // \∇∇ Polygons ∇∇/ //


/** \page Polygons
Connector creates a connector pin
\param l length
\param l2 center length
\param d  diameter
\param d2  center diameter
\param dicke  wall thickness
\param flat length flat sections
\param latch latch height
\param collar collar height
\param deg,degC,degEnd angle of chamfers
\param end end diameter change from d
\param cut cut end length
\param half for half x side 
\param center center
\param 2D polygon or 3D connector
\param printCut overhang angle horizontal print
\param print rotate and move 3D pin up

*/

//Roof(2,[.25,.25])Connector(d=3,d2=3.5,dicke=1.2,latch=.25,end=-.5,flat=0.7);
//Connector(l=[20,15],d=5,end=-.5,d2=6,2D=false,collar=0,l2=+0,print=true,center=false);

module Connector(l=10,d=5,l2=0,d2,dicke=1.5,flat=[0.5,0.5],flatC,latch=.5,collar=0,deg=45,degC=45,degEnd=45,end=-.5,cut=undef,half=false,center=true,2D=true,printCut=50,print=false,spiel=0,help){

half=is_parent("RotEx")?spiel?half:true:half;
2D=is_parent(needs2D)?true:2D;

d=is_num(d)?[d,d]:d;
l=is_num(l)?[l,l]:l;
flat=is_num(flat)?[flat,flat]:flat;
flatC=is_undef(flatC)?flat:is_num(flatC)?[flatC,flatC]:flatC;
dicke=is_num(dicke)?[min(d[0]/2,dicke),min(d[1]/2,dicke)]:dicke;
l2=is_num(l2)?[l2,l2]:l2;
collar=is_num(collar)?[collar,collar]:collar;
cut=is_list(cut)?cut:[cut,cut];
latch=is_num(latch)?[latch,latch]:latch;
deg=is_num(deg)?[deg,deg]:deg;
degC=is_num(degC)?[degC,degC]:degC;
degEnd=is_num(degEnd)?[degEnd,degEnd]:degEnd;

d2=is_num(d2)?[d2,d2]:is_undef(d2)?d+collar*2:d2;
end=is_num(end)?[end,end]:end;
//center length 0
cnt=max(l2[0],(d2[0]==d[0]+collar[0]*2?0:tan(degC[0]*sign(d[0]-d2[0]+collar[0]*2))*((d[0]-d2[0])/2+collar[0]))+(collar[0]?l2?flatC[0]:flatC[0]/2:-flatC[0]))+(l[0]+flat[0]+tan(degEnd[0])*(-end[0]+latch[0]));

HelpTxt("Connector",["l",l,"d",d,"l2",l2,"d2",d2,"dicke",dicke,"flat",flat,"flatC",flatC,"latch",latch,"collar",collar,"deg",deg,"degC",degC,"degEnd",degEnd,"end",end,"cut",cut,"half",half,"center",center,"2D",2D,"printCut",printCut,"print",print,"spiel",spiel],help);

function latch(mirror=[1,1],latch=0.5,dicke=dicke[0],collar=2,l2=l2[0],l0=l[0],flat=flat,d=d[0],d2=d2[0],deg=+45,degC=25,degEnd=degEnd[0],end=end[0],cut=cut[0],center=center,cnt=cnt)=
let(
  fn=fs2fn(r=d/2-dicke,grad=90,fs=fs),
  icollar=collar,
  collarL=tan(degC*sign(d-d2+icollar*2))*((d-d2)/2+icollar),
  step=90/fn,
  flat0=flat[0],
  flat1=collar?flat[1]:0, // for collar 
  flat2=collar?0:flat[1]/2,// no collar
  l0=l2||collar?l0:l0-collarL-flat2,
  l2=max(l2,(d2==d+collar*2?0:collarL)+flat2+flat1),
  end=max(-dicke+.25,end),//end diameter change to d/2
  lEnd=(l0+flat0+abs( tan(degEnd)*(-end+latch) ) ), // length of head section
  cut=is_undef(cut)?lEnd-l0+min(3.5,l2+l0-.5):min(cut,max(0,lEnd+l2-.5) ),
  rad=min(cut/2.5,(d/2-dicke)/PHI),
  cnt=center||min(l)==0?[0,0]:[0,cnt]//l2+lEnd]
  )
  
[
if(half&&min(l)==0)cnt+[0,0],
if(half)cnt+[0,mirror.y * -(l2+lEnd-cut)],
if(cut&&d/2-dicke>=pip/2)for(i=[0:fn])cnt+[mirror.x * (d/2-dicke-rad+rad*sin(i*step)),mirror.y * (rad*cos(i*step)-(rad+l2+lEnd-cut))],// freiraum
cnt+[mirror.x * (d/2-dicke),mirror.y * -(lEnd+l2)],// end freiraum
cnt+[mirror.x * (d/2+end),mirror.y *-(lEnd+l2)],// start chamfer
cnt+[mirror.x * (d/2+latch),mirror.y *-(l2+l0+flat0)],// end chamfer
cnt+[mirror.x * (d/2+latch),mirror.y *-(l2+l0)],// end chamfer
cnt+[mirror.x * (d/2),mirror.y *-(l2+l0+tan(-deg)*abs(latch))],// end chamfer

cnt+[mirror.x * d/2,mirror.y * -l2], // d 
if(collar)cnt+[mirror.x * (d/2+icollar),mirror.y * -l2],// collar
if(collar)cnt+[mirror.x * (d/2+icollar),mirror.y * -(l2-flat1 )],// collar
if(d2!=d||!min(l))cnt+[mirror.x * d2/2,mirror.y * -(l2-flat1- collarL )],// l2 body
if(!min(l))cnt+[mirror.x * d2/2,0]// body
];



points=
half?concat(
      l[0]?latch([1, 1],l0=l[0],flat=[flat[0],flatC[0]],dicke=dicke[0],l2=l2[0],cut=cut[0],collar=collar[0],latch=latch[0],deg=deg[0],degC=degC[0],degEnd=degEnd[0],end=end[0],d2=d2[0],d=d[0]):[],
 l[1]?revP(latch([1,-1],l0=l[1],flat=[flat[1],flatC[1]],dicke=dicke[1],l2=l2[1],cut=cut[1],collar=collar[1],latch=latch[1],deg=deg[1],degC=degC[1],degEnd=degEnd[1],end=end[1],d2=d2[1],d=d[1]) ):[]
):
concat(
      l[0]?latch([ 1, 1],l0=l[0],flat=[flat[0],flatC[0]],dicke=dicke[0],l2=l2[0],cut=cut[0],collar=collar[0],latch=latch[0],deg=deg[0],degC=degC[0],degEnd=degEnd[0],end=end[0],d2=d2[0],d=d[0]):[],
 l[1]?revP(latch([ 1,-1],l0=l[1],flat=[flat[1],flatC[1]],dicke=dicke[1],end=end[1],l2=l2[1],cut=cut[1],collar=collar[1],latch=latch[1],deg=deg[1],degC=degC[1],degEnd=degEnd[1],d2=d2[1],d=d[1]) ):[],
     l[1]? latch([-1,-1],l0=l[1],flat=[flat[1],flatC[1]],dicke=dicke[1],l2=l2[1],cut=cut[1],collar=collar[1],latch=latch[1],deg=deg[1],degC=degC[1],degEnd=degEnd[1],end=end[1],d2=d2[1],d=d[1]):[],
 l[0]?revP(latch([-1, 1],l0=l[0],flat=[flat[0],flatC[0]],dicke=dicke[0],l2=l2[0],cut=cut[0],collar=collar[0],latch=latch[0],deg=deg[0],degC=degC[0],degEnd=degEnd[0],end=end[0],d2=d2[0],d=d[0]) ):[]
);

if(2D)offset(delta=spiel)polygon(points);
  else {
   
   h=printCut==false?max(d)*3:min(d)*sin(printCut)+spiel*2;
    Tz(print?h/2:0)R(print?-90:0)
      intersection(){
        RotEx(cut=spiel?true:false)Connector(l=l,d=d,l2=l2,d2=d2,dicke=dicke,flat=flat,flatC=flatC,latch=latch,collar=collar,deg=deg,degC=degC,degEnd=degEnd,end=end,cut=cut,center=center,spiel=spiel);
        R(90)LinEx(h,center=true)Connector(l=l,d=d,l2=l2,d2=d2,dicke=printCut==false?d/2-latch-[.5,.5]:min(d)/2*(1-cos(printCut))+.5,flat=flat,flatC=flatC,latch=latch,collar=collar,deg=deg,degC=degC,degEnd=degEnd,end=end,cut=cut,center=center,spiel=spiel);
      }
  }

}


/** \page Polygons
Tesselation creates tilings
\param size size [x,y]
\param d object diameter [x,y] for squares
\param dist spacing between objects
\param dicke line thickness
\param pat pattern 1:grid 2:hex 3:penrose
\param obj 0 none 1 circle  2 square ... 100 children 
\param rot rotation
\param ofs position offset
\param alt alterating rotation angle
\param fn  fraqment number
*/

//Tesselation(size=20,d=5,pat=1,fn=6,alt=30);
//Tesselation(size=20,d=4,pat=2,dist=0.6,fn=6);

//Tesselation(size=20,d=5,tile=3,pat=1,dist=.5,fn=6,alt=90);//alternating rectangles
//Tesselation(size=80,pat=4,d=5,tile=12);//pentaTile

/* //TriHex
difference(){
  Tesselation(size=30,pat=2,d=3,rot=60,dist=+0.5,tile=5,fn=6,center=1);//TriHex
  color("lime")Tesselation(size=30,pat=2,d=3,rot=60,dist=+0.5,dicke=.5,tile=5,fn=6,center=1);//TriHex
}//*/

//Tesselation(pat=2,rot=0,tile=5,dist=+0.1,dicke=2,fn=6);// TriHex

/*
HexGrid(es=10/(3/4)+.5)
Tesselation(tile=13,dist=0.5,pat=0);//floral
//*/

 /*//hex tri penta 
difference(){
square(50,true);
Tesselation(tile=11,pat=2,fn=6,dist=.4,dicke=.7,alt=[60,60]);
}//*/

//Tesselation(tile=9,dist=0.75,alt=60,dicke=.5,fn=6,pat=2);

//Tesselation(size=80,tile=0,pat=3,fn=5,d=2,dicke=1);

//Tesselation(pat=5,tile=0);

module Tesselation(size=[40,40],d=5,dist=1,dicke=0,pat=0,tile=1,rot=0,ofs=[0,0],alt=[0,0],fn=6,center=true,name, help,obj){

dist=is_list(dist)?dist:[dist,dist];
d=is_list(d)?d:d*[1,1];
radius=is_num(size)?size/2:0;
size=is_list(size)?size:size*[1,1];
alt=is_list(alt)?b(alt,false):b(alt,false)*[1,1];
e=[max(1,size.x/(d.x+dist.x)),max(1,size.y/(d.y+dist.y))];
tile=$children?100:is_undef(obj)?tile:obj;
$d=d;
$r=d/2;
$info=false;

HelpTxt("Tesselation",["size",size,"d",d,"dist",dist,"dicke",dicke,"pat",pat,"tile",tile,"rot",rot,"ofs",ofs,"alt",alt,"fn",fn,"center",center,"name",name],help);

if(pat==0)rotate(alt.y+alt.x+rot)Tile()children();

if(pat==1)Grid(e=e,es=d+dist,center=center)rotate(($idx.y%2?0:alt.y)+($idx.x%2?0:alt.x)+rot)
      if(radius?norm($pos)<=radius-max(d)/2
      :abs($pos.x)<=(size.x-max(d))/2&&abs($pos.y)<=(size.y-max(d))/2
      )
Tile()children();

if(pat==2)HexGrid(e=[e.x,e.y*sqrt(3)/2]*2,es=[(d.x+dist.x)*sqrt(3)/2,(d.y+dist.y)],center=center)rotate(($idx.y%2?0:alt.y)+($idx.x%2?0:alt.x)+rot)
      if(radius?norm($pos)<=radius-max(d)/2
      :abs($pos.x)<=(size.x-max(d))/2&&abs($pos.y)<=(size.y-max(d))/2
      )
      
      Tile(d=fn==6?umkreis(6,d):d)children();
//Penrose
  if(pat==3)Polar(fn)Penrose(radius=max(size)/2,dicke=dicke,fn=fn,chld=tile,case=1,d=max(d) )rotate(rot)Tile()children();

//Cairo tile diagonal
  if(pat==4){
   dist=max(dist);
  es=[max(d),max(d)*2]*1.5;
  e=[ceil(size.x/es.x),ceil(size.y/es.y)];
   
    HexGrid(e=[e.x,e.y],es=es,center=center)
       if(abs($pos.x)<=size.x/2-es.x&&abs($pos.y)<=size.y/2-es.y/2)
       Tile()children();
  }
// Rectangle Tiling
 if(pat==5)RectTiling(size=size,dicke=dicke,chld=tile,d=max(d))rotate(rot)Tile()children();


module Tile(opt=tile,ofs=ofs,dicke=dicke,fn=fn,d=d,dist=dist)T(ofs)render(){
assert(min(d)>0);
  if(opt==100)children();
  if(opt==1)circle(d=max(d),$fn=fn); // ngon
  if(opt==2)square(d,center=true); // squares
// blocks
  if(opt==3){
    MKlon(ty=d.y/4+dist.y/4)square(vMult(d,[1,.5])-[0,dist.y/2],true);
    }
//tri blocks
  if(opt==4)Polar(fn/2,d.x/4)square([d.x/2,dicke?dicke:1],center=true);//Tri
//tri Hex

  
 if(opt==5){
    f=sqrt(3)/2;
    d=max(d)/f; 
    dicke=(is_list(dicke)?1:[1,1])*(dicke?dicke:d/2);
    
    Polar(3,rot=30)hull(){circle(d=dicke.y,$fn=6);T(d/2-dicke.x/2)circle(d=dicke.x,$fn=fn);}
  //color("red")Polar(3,dicke/2,rot=30)circle(d=dicke,$fn=6);
  } 
 
//triangles Hex  
if(opt==6)difference(){
    circle(d=d.x,$fn=fn);
    Polar(fn,d.x/2,rot=0)square([d.x,dicke?dicke:dist.y],true);
  }  
  
/*//triangles Hex   
  if(opt==6){
    d=umkreis(3,max(d))/sqrt(3);
    Polar(6,max(d)/2,rot=30)offset(-max(dist)/2)rotate(60)circle(d=d,$fn=3);
    }
    //*/
    
//triangles 
  if(opt==7)MKlon((max(d)+dist.x)/sqrt(3)/2)circle(d=max(d)/sqrt(3)*2,$fn=3);
//Star
  if(opt==8)rotate(180/fn)Star(e=round(fn),d/2,d/3);// star 
 // diamonds Hex
  if(opt==9)difference(){
    circle(d=d.x,$fn=fn);
    Polar(3,d.x/2,rot=0)square([d.x,dicke?dicke:dist.y],true);
  }
  
//PentaTile
  if(opt==10)difference(){
    circle(d=d.x,$fn=fn);
    square([d.x+2,dicke?dicke:dist.y],true);
  }
  if(opt==11)difference(){
    circle(d=d.x,$fn=fn);
    Polar(fn/2,d.x/2,rot=180/fn)square([d.x,dicke?dicke:dist.y],true);
  }

//Cairo
  if(opt==12)union(){
    dist=max(dist);
    d=max(d);
    MKlon(ty=-d)offset(-dist/2)polygon(5gon(d*0.75,d*0.25,d*0.5,d));
    rotate(90)MKlon(ty=d*0.5)offset(-dist/2)polygon(5gon(d*0.75,d*0.25,d*0.5,d));
  }
//Penta floral  
  if(opt==13){ 
    d=max(d);
    p=[for(i=[0:3])[cos(i*60),sin(i*60)]*d/2/(sqrt(3)/2)+[0,d],[0,0]];
    Polar(6,rot=rot?rot:90+atan(sqrt(3)/9))offset(-max(dist)/2)polygon(p);
  }

  union(){
  dicke=dicke?dicke:1;
  //3halfcircle 
    if(opt==14){d=max(d)/sqrt(3);
      Polar(3,d/2+dist.x*0,rotE=rot*0)Kreis(d=d,grad=180,rcenter=true,rand=dicke,rot=90);}
  //6halfcircle
    if(opt==15)Polar(6,max(d)/4+dist.x/4,rot=30,rotE=rot*+1)Kreis(d=max(d)/2,grad=180,rcenter=true,rand=dicke,rot=90);
  //6Wave
    if(opt==16)Polar(6,max(d)/4,rot=30,rotE=rot*0){d=d/4;
                MKlon(max(d)/2)Kreis(d=max(d),grad=180,rcenter=true,rand=dicke,rot=$idx*180+90);}
  }


}

} // end Tesselation



/** \name Penrose Tiling
\page Polygons
Penrose() creates a penrose tiling or children arrangement
\param rec recursion limit (optional)
\param tri start triangle [p0,p1,p2] (optional)
\param radius penrose size via fn and radius ↦ tri
\param case  tiling start case
\param dicke space between triangles
\param ratio tiling ratio
\param fn symetry ↦ tri
\param d triangle size limit (recursion stop condition)
\param mirror mirror triangles for symetry ↦ tri
\param $d $pos $tri output variables - inner diameter center triangle points

*/
//Polar(10)Penrose(mirror=0,fn=10,d=5);


module Penrose(rec=20,tri,radius=50,case=1,dicke=1,ratio=1.618,color=5,seed = 42,fn=6,chld,d=5,mirror=true,help){//<- change start case 1 or 2

HelpTxt("Penrose",["rec",rec,"tri",tri,"radius",radius,"case",case,"dicke",dicke,"ratio",ratio,"fn",fn,"d",d,"mirror",mirror],help);

function GR(a,b,ratio=ratio)=a+(b-a)/ratio; 
 
chld=is_undef(chld)?$children:chld;

// we using two mirrored parts so each triangle is half and the angle from center hence only a quarter
fn=max(fn,2);
angle= mirror?360 / (fn*4):360/fn/2; 
dicke=is_undef(dicke)?0:dicke;


tri=is_undef(tri)?let(a=[0,0])[
  a, // a first point at center
  a + [sin( angle), cos( angle)]* radius,  // b the adjactant sides end point at angle and length
  a + [sin(-angle), cos(-angle)]* radius, // c
  ]
                  :tri;
  
  a=tri[0];
  b=tri[1];
  c=tri[2];
  
  //iratio=rands(1.5,2.0,5,seed);
  iratio=[1,1,1,1,1]*ratio;
  
// side length
  sA=norm(c-b);
  sB=norm(c-a);
  sC=norm(b-a);
// circumfence
  u=(sA+sB+sC);
  s=u/2;
  
// inner diameter
  $d=sqrt( ((s-sA)*(s-sB)*(s-sC))/s )*2-dicke;
    
  if ($d>(d*2)&&rec>0){
    if(case==1){
     // the smaller resulting tri will be cut in two the next time (case 1)
        Penrose(rec=rec-1, tri= [c       , GR(a, b), b], case=1,fn=fn,chld=chld,d=d, dicke=dicke, mirror=mirror, color= 0,ratio=iratio[0], seed = seed * rec + 0)children();

    // the bigger gets cut in 3 the next time
        Penrose(rec=rec-1, tri= [GR(a, b), c       , a], case=2,fn=fn,chld=chld,d=d, dicke=dicke, mirror=mirror, color= 1,ratio=iratio[1], seed = seed * rec + 1000)children();
    }
    if(case==2){
        Penrose(rec=rec-1, tri= [GR(b, a), GR(b, c), b], case= 2,fn=fn,chld=chld,d=d, dicke=dicke, mirror=mirror, color= 2,ratio=iratio[2], seed = seed * rec + 2000)children();
        Penrose(rec=rec-1, tri= [GR(b, c), GR(b, a), a], case= 1,fn=fn,chld=chld,d=d, dicke=dicke, mirror=mirror, color= 3,ratio=iratio[3], seed = seed * rec + 3000)children();
        Penrose(rec=rec-1, tri= [GR(b, c),        c, a], case= 2,fn=fn,chld=chld,d=d, dicke=dicke, mirror=mirror, color= 4,ratio=iratio[4], seed = seed * rec + 4000)children();
    }
  }

    
   else { // only draw the pattern at the last recursion
   
   iM=[ (sA*a.x+sB*b.x+sC*c.x)/u ,  (sA*a.y+sB*b.y+sC*c.y)/u ];
   $pos=iM;
   $tri=tri;
    color(color/5*[1,1,1]){
    rotate(90/fn)
      if(chld)T(iM)children();
      //T((a+(b+c)/2)/2)children();
       else {
        offset(-dicke/2)polygon(tri);
        }

    if(mirror)mirror([1,0])rotate(90/fn)
      if(chld)T(iM)children();//T((a+(b+c)/2)/2)children();
      
       else offset(-dicke/2)polygon(tri);
    }
  }
} // end Penrose



/** \page Polygons \name RectTiling
RectTiling() tiles a rectangle in random smaller rectangles
\param size size
\param ratio [min:max] dividing ratio or list or num
\param d minimal size (recursive stop condition)
\param dicke space thickness between
\param seed  seed for randomness
\param $size $seed output data
\param chld use children
\param info help info help
*/
//RectTiling(dicke=0);

//RectTiling(ratio=[2.7,2],d=5);




module RectTiling(size=[30,40],ratio=[1.25:5],d=5,dicke=1,chld,seed=13,rec=0,info,help){
chld=is_undef(chld)?$children:chld;
assert (is_undef(ratio[2])?min(ratio)>=1:min([ratio[1],ratio[2]])>=1,"ratio <= 1");
assert (d>0,"d need to be > 0");
assert (is_num(dicke),"dicke need to be a number");

ratio=is_num(ratio)?[1/(1-1/ratio),ratio]:ratio;
if(rec==0&&info)echo(ratio=ratio);
useRatio=is_list(ratio)?ratio[floor(rands(0,len(ratio),1,seed)[0])]
                       :rands(ratio[0],ratio[2],1,seed)[0];
if(info)echo(useRatio=useRatio,rec=rec);
HelpTxt("RectTiling",["size",size,"ratio",ratio,"d",d,"dicke",dicke,"seed",seed,"info",info],help);

  if(max(size)/useRatio>d+dicke*1.0&&max(size)-max(size)/useRatio>d+dicke&&rec<30){
    if(size.x>size.y){
      RectTiling(size=[size.x/useRatio,size.y],ratio=ratio,d=d,dicke=dicke,chld=chld,seed=seed+1,rec=rec+1, info=info)children();
      translate([size.x/useRatio,0])RectTiling(size=[size.x-size.x/useRatio,size.y],ratio=ratio,d=d,dicke=dicke,chld=chld,seed=seed*2,rec=rec+1, info=info)children();
    }
    else {
      RectTiling(size=[size.x,size.y/useRatio],ratio=ratio,d=d,dicke=dicke,chld=chld, seed=seed+1,rec=rec+1, info=info)children();
      translate([0,size.y/useRatio])RectTiling(size=[size.x,size.y-size.y/useRatio],ratio=ratio,d=d,dicke=dicke,chld=chld, seed=seed*2,rec=rec+1, info=info)children();
    }

  }
  else {
    if(chld) {
      $size=size;
      $seed=seed;
      translate(size/2)children();
    }
    else //color(rands(0,1,3))
    Color(rands(0,1,1)[0],l=dicke?1:0.5)
    offset(-dicke/2)square(size);

    if(info)%color("grey")scale([1,1,2])translate(size/2)text(str(rec,"/",seed),size=d/4,halign="center",valign="center");
   }

}



/** \page Polygons
Arc() creates an arc
\param r radius
\param deg angle
\param r2 end radius at deg
\param fn fragments
\param rand fringe thickness
\param center center arc rotation
\param cP center Point
\param rot rotate arc [r,rand]

*/
//Arc(r=10,deg=90,r2=8,rand=2);
//Arc(r=10,deg=90,rand=[5,1]);

module Arc(r=10,deg=90,r2,fn=36,rand,center=false,cP=true,rot=0,help){
deg=is_list(deg)?deg:[deg,deg];
rand=is_num(rand)?[rand,rand]:rand;
rot=is_num(rot)?[rot,0]:rot;

points=rand?concat(arc(r=r,deg=deg[0],r2=r2,rot=(center?-deg[0]/2:0)+rot[0],fn=fn),
                   arc(r=r+rand[0],deg=deg[1],r2=is_undef(r2)?r+rand[1]:r2+rand[1],rot=(center?-deg[1]/2:0)+rot[1],fn=fn,rev=true)
                   )
          
          : concat(cP?[[0,0]]:[],arc(r=r,deg=deg[0],r2=r2,rot=(center?-deg[0]/2:0)+rot[0],fn=fn));


polygon(points,convexity=5);

HelpTxt("Arc",["r",r,"deg",deg,"r2",r2,"fn",fn,"rand",rand,"center",center,"cP",cP,"rot",rot],help);
}


/** \page Polygons \name VorterantQ
\brief Vorterant Q creates a rotor for the Quad Vorterant pump
\param size rotor diameter
\param ofs rounding edge
\param adjusted  if size is adjusted to the edge offset
\param fs fn fraqments
\param name help  name help
\param h for 180°twist and volume calculation message
*/

/// Vorterant Q creates a rotor for the Quad Vorterant pump
//Grid(e=3,es=10*sqrt(2))rotate(($idx.x+$idx.y)%2?0:90)rotate(t0)VorterantQ();
//Polar(4,10.0,rotE=90)VorterantQ(h=10);


/*
VorterantQ(ofs=2,adjusted=true);
x=10-sqrt(2)*2;
Tz(.1)Color()offset(2)Linse(dia=x*2,r=x*sqrt(2));
//*/

/*
VorterantQ();
Kreis(10,dicke=.1);
T(10){
Kreis(10*sqrt(2),dicke=.1);
Pivot();
}
//*/


module VorterantQ(size=20,ofs=.5,adjusted,fs=fs,fa=fa,fn=0,name,help,h){
adjusted=is_undef(adjusted)?useVersion&&useVersion>23||Version>23?true:false
                           :adjusted;
s=adjusted?Umkreis(4,size/2)-ofs*2  :  Umkreis(4,size/2-ofs);

k1=kreis(s,rand=0,grad=90,rot=180,endPoint=0,fs=fs,fa=fa,fn=fn);
versch=[for(i=[0:len(k1)-1])[-Inkreis(4,s),0]]; 
offset= [for(i=[0:len(k1)-1])[ofs*sin(45+i*90/len(k1)),ofs*cos(45+i*90/len(k1))]];
function offsetvert(fn=12)= [for(i=[0:fn])[ofs*sin(-45+i*90/fn),ofs*cos(-45+i*90/fn)+Inkreis(4,s)]];

linse=concat(k1+versch+offset,-offsetvert(),-k1-versch-offset,offsetvert());
polygon(linse);

if(name)echo(str(name," VQ Size=",adjusted?size-tangentenP(grad=90,rad=ofs)*2:size," ,Radius=",s,"mm - Verschoben um",Inkreis(4,s)-ofs,"mm")); 
HelpTxt("VorterantQ",["size",size,"ofs",ofs,"adjusted",adjusted,"fn",fn,"fs",fs,"name",name],help);

function area(angle=0,r=size/2) =( r * sqrt(2) * abs( cos(angle) ) )^2;
if(h){


areaS=[for(i=[0:180])area(angle=i)*h/180];

volume=vSum(areaS);

if(is_undef($idx)?true:is_list($idx)?!max($idx):!$idx) InfoTxt("VorterantQ",["~volume",volume,"cubeside",volume^(1/3)],name);

}
}

/** \name Reuleaux
\page Polygons
Reuleaux creates a Reuleaux triangle
\param rU Edge radius 
\param fs fn  fraqments size / number
*/

//Reuleaux();

module Reuleaux(rU=5,fn=0,fs=fs,name,help){
  r=rU/(sqrt(3)/3); 
  intersection_for (i=[0,120,240])
                {
                  rotate(i)T(rU)  circle(r=r,$fn=fn,$fs=fs);

                } 
  if(name)echo(str(name," Reuleaux rU=",rU," r=",r));
  HelpTxt("Reuleaux",["rU",rU,"fn",fn,"name",name],help);
}

/** \page Polygons
PolyRund([[0,1],[10,20],[-50,50]],r=5); creates a rounded polygon
\param points the points of polygon
\param r  the rounding radius (list optional)
\param ir radius of inner corners (if r is not a list)
\param ofs offset for the polygon
\param delta delta offset (no radius change)
\param fn,fs  fragments, fragment size
\param messpunkt show points and radii
\param help help
*/

//PolyRund([[0,1],[10,20],[-50,50]],r=2,messpunkt=true,delta=+0);


module PolyRund(points,r=0,ir,ofs=0,delta=0,fn,fs=fs,minF=8,messpunkt=false,help){

Echo("No Points",color="redring",condition=!is_list(points[2]));
if(is_list(points[2]))polygon(polyRund(points,r=r,ir=ir,ofs=ofs,delta=delta,fn=fn,fs=is_undef(fn)?fs:undef,minF=minF),convexity=5);
  lenR=is_num(r)?2:len(r);
  %Tz(.1)if(messpunkt!=false){
  Tz(-0.05)color("silver",0.3)polygon(points);
  translate(points[0])Color("HotPink")text(str("№ ",0),size=1,halign="center",valign="center");
    for(p=is_num(messpunkt)?abs(messpunkt)%len(points):[0:len(points)-1]){
      //let(p=p%lenR)
      translate(points[p]){
      //Color("darkOrange")Kreis(r=r[p],rand=min(.25,r[p]/10),name=0);
      //Color("Orange")DPfeil(r[p]*2,b=min(.25,r[p]/10),name=0,txt=true);
      if(p)Color("lightGrey")text(str("№ ",p),size=1,halign="center",valign="center");
      }
      
      
        let(
        //p=is_num(r)?p:p%lenR,
        fn=is_list(fn)?fn[p%len(fn)]:fn,
        fs=is_list(fs)?fs[p%len(fs)]:fs,
        ir=is_undef(ir)?r:ir,
        lp=len(points),
        pBef=points[(p+lp-1)%lp],
        pNow=points[p],
        pNex=points[(p+1)%lp],
        grad1=atan2(pBef.x-pNow.x,pBef.y-pNow.y),
        grad2=atan2(pNex.x-pNow.x,pNex.y-pNow.y),
        gradDiff=grad1-grad2,
        grad=gradDiff<0?abs(gradDiff):360-gradDiff,
        gradSup=360-grad,
        tPgrad=grad2+gradSup/2,
        r=(is_num(r)?(grad<180?-r : ir):r[p%len(r)]*(grad<180?-1:1)),
        
        tP=[sin(tPgrad),cos(tPgrad)]*tangentenP(grad=gradSup-180,r=r,rad=r)*(grad<180? -1:+1),
        tPDelta=[sin(tPgrad),cos(tPgrad)]*tangentenP(grad=gradSup-180,r=delta,rad=delta)
        )union(){
        dia=2*(grad<180?max(abs(r)+ofs,0):max(abs(r)-ofs,0));
      Color(grad<180?"Orange":"lightSkyBlue")translate(pNow+tP+tPDelta*sign(delta))DPfeil(dia,b=min(.25,r/10),name=0,txt=true);
      if(dia)Color(grad<180?"darkOrange":"SkyBlue")polygon(kreis(d=dia*sign(r),rand=min(.25,r/10),rot=grad1+90,grad=(grad-180)*0+360*1,t=pNow+tP+tPDelta*sign(delta),center=false,fn=is_undef(fn)?undef:fn/abs(grad-180)*360,fs=fs,minF=minF));
      if(dia)Tz(.1)Color("chartreuse")polygon(kreis(d=dia*sign(r),rand=min(.25,r/10),rot=grad1+90,grad=(grad-180),t=pNow+tP+tPDelta*sign(delta),center=false,fn=fn,fs=fs,minF=minF));
      }
    }
  }

HelpTxt("PolyRund",["points",points,"r",r,"ir",ir,"ofs",ofs,"delta",delta,"fn",fn,"fs",fs,"minF",minF,"messpunkt",messpunkt],help);
}

/** \page Polygons
WStern() a sin wave star
\name WStern()
\brief creates a sin wave star
## Example
WStern();
 * \param f frequency
 * \param r radius
 * \param a amplitude
 * \param r2 optional radius to calc amplitude
 \param fv phase shift
 * \param fn fragments should be multiple of f
 
*/
//WStern(f=5,r=5,a=10);

module WStern(f=5,r=1.65,a=.25,r2,fn=0,fs=fs,fv=0,name,help){
    
    a=is_undef(r2)?a:(r2-r)/2;

    fn=fn?fn:ceil(fs2fn(fs=fs,r=abs(r)+abs(a),minf=f*2,fa=.5)/f)*f;
    r=is_undef(r2)?r:r+a;
    step=360/fn;
    
    
    points=[for(i=[0:fn])let(i=i%fn)[(r+a*cos(f*i*step+fv))*sin(i*step),(r+a*cos(f*i*step+fv))*cos(i*step)]];
       
    
    polygon(points);  
  InfoTxt("WStern",["OD",(r+a)*2,"ID",(r-a)*2,"r",r,"a",a],name);  
  HelpTxt("WStern",["f",f,"r",r,"a",a,"r2",r2,"fn",fn,"fs",fs,"fv",fv,"name",name],help);
  
}



/** \name Tri90 \page Polygons
Tri() creates a right angled triangle
\param grad angle optional
\param a seide lenght
\param b second side
\param c third side
\param r radius rounding
\param messpunkt show center
\param tang but round at origin
\param fn fs fragments
*/


module Tri90(grad,a=25,b=25,c,r=0,messpunkt=0,tang=true,fn,fs=fs,name,help){
 
  if (is_list(r)&&!tang)Echo("Tri90 Winkelfehler r is list & tang=false!",color="red");  
    
 b=is_undef(grad)?is_undef(c)?b:sqrt(pow(c,2)-pow(a,2)):tan(grad)*a;
 grad=atan(b/a);
 r1=is_list(r)?is_undef(r[0])?0:r[0]:r;   
 r2=is_list(r)?is_undef(r[1])?0:r[1]:r;
 r3=is_list(r)?is_undef(r[2])?0:r[2]:r; 
    
 gradB=90-grad;   
    
 wA=90+grad;  
 wB=90+gradB;
 wC=90; 
 a=tang?a:a+RotLang(90+grad/2,TangentenP(wB,r2))[0];
 btang=b+RotLang(+0-gradB/2,TangentenP(wA,r1))[1];
    
 tA=[0,tang?b:btang]-RotLang(+0-gradB/2,TangentenP(wA,r1,r1));   
 tB=[a,0]-RotLang(90+grad/2,TangentenP(wB,r2,r2)); 
 tC=RotLang(45,TangentenP(wC,r3,r3));
    
if(messpunkt){
            Col(6)union(){ // mittelpunkte
            Pivot(tA,active=[1,0,0,1,1],size=messpunkt);
            Pivot(tB,active=[1,0,0,1,1],size=messpunkt);   
            Pivot(tC,active=[1,0,0,1,1],size=messpunkt);
        }
            union(){ // tangentenpunkte
            Pivot([0,0],active=[1,0,0,1,1,1],txt="C",size=messpunkt);
            Pivot([0,b],active=[1,0,0,1,1],size=messpunkt);   
            Pivot([a,0],active=[1,0,0,1,1],size=messpunkt);
        }          

}

 points=concat(
    
 r3==0?[[0,0]]:kreis(rot=180,grad=wC,fn=fn,fs=fs,rand=0,r=r3,t=tC,center=false),
 r1==0?[[0,b]]:kreis(rot=270,grad=wA,fn=fn,fs=fs,rand=0,r=r1,t=tA,center=false),    
 r2==0?[[a,0]]:kreis(rot=+180-wB,grad=wB,fn=fn,fs=fs,rand=0,r=r2,t=tB,center=false) 
 
);

 polygon(points,convexity=5);  
   
InfoTxt("Tri90",["a",str(a," b=",b," c=",Hypotenuse(a,b),"mm",r?str(" true a=",tB[0]+r2," b=",tA[1]+r1," c=",norm(tA-tB)+r1+r2):""," grad α=",grad,"° grad β=",gradB,"° γ=90° Höhe c=",a*sin(gradB))],name);
HelpTxt("Tri90",["grad",grad,"a",a,"b",b,"c",c,"r",r,"messpunkt",messpunkt,"tang",tang,"fn",fn,"fs",fs,"name",name],help);     
    
}

/** \name Tri \page Polygons
Tri() creates a isosceles triangle
\param grad angle
\param l seide lenght
\param l2 optional second side
\param h height 
\param r radius rounding
\param messpunkt show center
\param center center
\param top put tip at origin
\param tang but round at origin
\param c side c
\param fn fs fragments
*/

module Tri(grad=60,l=20,l2,h=0,r=0,messpunkt=0,center=+0,top=0,tang=1,c,fn,fs=fs,name,help){
  assert(grad!=180&&grad,"Tri bad grad");
  Echo("WIP‼ c and tang=0",color="red",condition=is_num(c)&&!tang);
  h=is_num(c)?c/tan(grad/2)/2:h;
  l22=is_undef(l2)?l:l2;  //wip
  
  fn=is_undef(fn)?0:fn;
 
 w1=180-grad;  //Supplementwinkel 
 w2=(360-w1)/2;
 w3=(360-w1)/2; 
 
 rot=w2/2;   
 
 r1=is_list(r)?is_undef(r[0])?0:
                        r[0]:
            r;   
 r2=is_list(r)?is_undef(r[1])?0:
                        r[1]:
            r;
 r3=is_list(r)?is_undef(r[2])?0:
                           r[2]:
            r;    
  
 
 l2=h?1/cos(grad/2)*(!tang?h+TangentenP(w1,r1):h):l22;   
 l3=h?1/cos(grad/2)*(!tang?h+TangentenP(w1,r1):h):l; 
 
 hc=h?h:l*cos(grad/2);   
    
 t1=[TangentenP(w1,r1,r1),0];   
 t2=RotLang(90-grad/2,l2)-RotLang(90-w2/2,TangentenP(w2,r2,r2));
 t3=RotLang(90+grad/2,l3)-RotLang(90+w3/2,TangentenP(w3,r3,r3));
    
points=concat(
        kreis(rand=0,r=r1,grad=w1,t=t1,fn=fn/3,fs=fs),
        kreis(rand=0,r=r2,rot=-rot+180,grad=w2,t=t2,fn=fn/3,fs=fs),    
        kreis(rand=0,r=r3,rot=rot+180,grad=w3,t=t3,fn=fn/3,fs=fs)    
);

    rotate(top?0:180)translate([center?
                //-2*Kathete(l2,hc)/(2*sin(grad)):top? // center Umkreis
                -(tang?hc+TangentenP(w1,r1):hc+2*TangentenP(w1,r1))/2:top? // center h
                        tang?
                        0:-TangentenP(w1,r1)
                  :tang?-hc:h?-hc-TangentenP(w1,r1):-hc,0,0]){//Basis
        polygon(points,convexity=5);
        if(messpunkt){
            union(){//TangentenP
                Pivot(active=[1,1,0,1],size=messpunkt);
                translate(RotLang(90-grad/2,l2))rotate(90+w2/2)Pivot(active=[1,0,1,1],size=messpunkt);
                translate(RotLang(90+grad/2,l3))rotate(90-w3/2)Pivot(active=[1,0,1,1],size=messpunkt);
            }

            Col(6)union(){ // mittelpunkte
                Pivot(t1,active=[1,0,0,1],size=messpunkt);
                Pivot(t2,active=[1,0,0,1],size=messpunkt);   
                Pivot(t3,active=[1,0,0,1],size=messpunkt);
            }

        }
    }

 InfoTxt("Tri",["reale Höhe=",tang?hc-TangentenP(w1,r1):hc,"h",tang?hc:hc+TangentenP(w1,r1),"Basis",2*Kathete(l2,tang?hc:hc+TangentenP(w1,r1)),"Umkreis r",2*Kathete(l2,hc)/(2*sin(grad)),"c",l==l22?sin(grad/2)*l*2:"WIP"],name);
 HelpTxt("Tri",["grad",grad,"l",l,"l2",l2,"h",h,"r",r,",messpunkt",messpunkt,",center=",center,"top",top,"tang",tang,"c",c,"fn",fn,"fs",fs,"name",name],help);    
 
}


/** 
\name Welle
\page Polygons
Welle() creates multiple arcs or extrusions with children
\param e  number of arc pairs
\param r  radius arc 1
\param r2 radius arc 2
\param rand wall thickness
\param grad angle of arcs
\param ext extruded base when rand=0
\param h  height of wave
\param fn fragments
\param lap angle overlap
\param center 0-3 center at 0,1= center between arcs ,2= center arc 1,3= center arc 2
*/

/*
c1=3;
Welle(e=3,r=12,r2=7,rand=0.0,grad=200,ext=20,h=0,fn=36,center=c1);
Tz(.5)Welle(e=3,r=12,r2=7,rand=0.5,grad=200,ext=20,h=0,fn=36,center=c1);
//*/

// Welle(rand=1,h=[6,10],e=3,ext=24);
// Welle(rand=1,h=[6,10],r=4,r2=6,e=3,grad=120);

//Welle(grad=[60,40],h=5,r=[4,7],e=2);//WIP
//Welle(grad=40,h=6.8,r=[3,6],center=3,e=4);


module Welle(e=3,grad=200,r=5,r2,center=3,rand=2,h=0,ext=0,end=false,fn,fs=fs,lap=0,name,help,overlap){
    gradSUM=assert(grad)vSum(grad);
    end=is_list(end)?end:[end,end];
    e=round(e);
    lap=is_undef(overlap)?lap:overlap; // compatibility
    r2=is_undef(r2)?is_list(r)?r[1]:r
                   :r2;
    r=is_list(r)?r[0]:r;

    $x=rand;    
    grad1=(is_list(grad)?grad[0]:grad/2); //between S segments
    grad2=(is_list(grad)?grad[1]:grad/2); //in S segment
    
    w=(gradSUM-180)/2;
    y=sin(grad2)*r ; // shift r
    y2=sin(grad2)*r2;// shift r2
    yg1=sin(grad1)*r ; // shift r
    y2g1=sin(grad1)*r2;// shift r2
    
    hORG=h;
    Echo("h increased to min height",color="warning",condition=is_num(hORG)&&hORG>0&&(hORG/2<(1-cos(grad2))*r||hORG/2<(1-cos(grad2))*r2 ) );
    
    hList=is_list(h)?h:[max(h/2,(1-cos(grad2))*r),max(h/2,(1-cos(grad2))*r2)];
    h=[hList[0]-(1-cos(grad2))*r , hList[1]-(1-cos(grad2))*r2 ];
    Echo("h for 3D not implemeted",color="redring",condition=max(h)&&$children);
    hi=[-cos(grad2)*r , -cos(grad2)*r2]+h;
    
    
    Echo(str("h diff sum",h,"Σ=",vSum(h)," < 0"),color="redring",condition=vSum(h)<0);



    //delta=(h[0]*tan(90-grad1)+h[1]*tan(90-grad2))*2;

    delta2= vSum(h) *tan(90-grad2) ; // in S Segment
    delta=y+y2+yg1+y2g1 + (vSum(h))*tan(90-grad1) + delta2 ;// between S segments
    
    fn=is_undef(fn)||fn==0?[fs2fn(r=r,grad=gradSUM,fs=fs),fs2fn(r=r2,grad=gradSUM,fs=fs)]:is_list(fn)?fn:[fn,fn];
    points=[
     each for(i=[0:round(e-1)])each[
       arc(r2+rand/2,deg=grad1+grad2+(i==0&&end[0]?90-grad1:0),t=[-hi[1],-y2+delta*i],rot=180-grad2,fn=fn[1],rev=1),
       arc(r-rand/2,deg=grad1+grad2+(i==(e-1)&&end[1]?90-grad1:0),t=[hi[0],y+delta2+delta*i],rot=-grad2,fn=fn[0],rev=0)
       ] ,
       
    if (rand) each[
      if(end[1]&&hi[0]>0)[0,y+r+delta2+ delta*(e -1)-rand/2],
      if(end[1]&&hi[0]>0)[0,y+r+delta2+ delta*(e -1)+rand/2],

      each for(i=[round(e-1):-1:0])each[
       arc(r+rand/2,deg=grad1+grad2+(i==(e-1)&&end[1]?90-grad1:0),t=[hi[0],y+delta2+delta*i],rot=-grad2,fn=fn[0],rev=1),
       arc(r2-rand/2,deg=grad2+grad1+(i==0&&end[0]?90-grad1:0),t=[-hi[1],-y2+delta*i],rot=180-grad2,fn=fn[1],rev=0)
      ] ,
       
      //[0,-y2+rand/2],[0,-y2-rand/2] ,
      if(end[0]&&hi[1]>0 )[0,-y2-r2+rand/2],
      if(end[0]&&hi[1]>0 )[0,-y2-r2-rand/2],
    ],
       // extension
    if (rand==0) each[ [ext,y*2+delta2+ delta *(e -1)],[ext,-y2*2] ],
    ];
    
    //echo(points);
    
    if(!$children)T(0,center?center>1?center>2?y2- delta *(e-1)/2// c3
                                              :-delta2-y- delta*(e-1)/2// c2
                                     :0-delta2/2- delta*(e -1)/2 // c1 WIP!!
                            :end[0]?r2+y2:y2*2)
      polygon(points);
    
    
    T(0,center?center>1?center>2?y2:-y:0:y2*2)Linear(es=(y+y2)*2,e=e,x=0,y=1,center=center)
    union(){

     if(false){
         T(hi[0],y/2)  Kreis(grad=grad+lap,r=r,fn=fn[0],rand=rand,rcenter=true,sek=true);
         T(-hi[1],-y2/2)  Kreis(grad=grad+lap,fn=fn[1],r=-r2,rand=rand,rcenter=true,sek=true);   
     }

//3D
     if($children) {
         T(sin(w)*r,y)  RotEx(grad=grad+lap,fn=fn[0],center=true)T(r)children();
         union(){
             $info=0;
             $helpM=0;
         T(-sin(w)*r2,-y2)RotEx(grad=grad+lap,fn=fn[1],center=true)T(-r2)children(); 
         }  
         
     }
    }
    
 InfoTxt("Welle",["Wellenenhöhe h+r/r2=",str(h[0]+r+sin(w)*r,"/",-h[1]-r2-sin(w)*r2),"Abstand r/r2=",str(y,"/",y2),"Länge=",e*(y+y2)],name);  
 HelpTxt("Welle",[
    "e",e,
    "grad",grad, 
    "r",r, 
    "r2",r2, 
    "center",center, 
    "rand",rand,
    "h",h,
    "ext",ext,
    "fn",fn,
    "lap",lap, 
    "name",name] 
    ,help);    
}


/** \name Riemen \page Polygons
Riemen() creates a belt form  can use polygons as children for 3D
\param r1 radius pulley 1
\param r2 raduis pulley 2
\param tx pulley distance 
\param fn fs fragments
\param center center
\param lap overlap (for 3D)
\param name help name help
*/

//Rand(1)Riemen(tx=25,r1=5,r2=10,center=-1,$messpunkt=true);
//Cut()Riemen(center=+0,fn=25)rotate(90)Rund(0.2,fn=12)Nut(a=undef,b=undef,es=2,e=5,grad=70,center=false);




module Riemen(r1=5,r2=10,tx=25,fn,fs=fs,center=false,lap=0.005,spiel=0,name,help){
lapL=0;
r1=r1+spiel;
r2=r2+spiel;
a=asin((r2-r1)/tx);
lTrum=cos(a)*tx;
tx0=r2/sin(a)-tx;
U=lTrum*2+r1*PI/180*(180-a*2)+r2*PI/180*(180+a*2);

if(r1!=r2)Pivot(p0=b(center,false)<0?[0,0]:[(center?-tx/2:0)-tx0,0],rot=a);

InfoTxt("Riemen",["alpha",a,"Trum",lTrum,"Umfang",U,"tx",tx,"ratio",str("1:",r1/r2,"/",r2/r1,":1")],name);

Echo(str(name," Wellen Abstand ",tx,"mm nicht Norm gemäß! min tx=",1.4*(r1+r2)," max=",4*(r1+r2)," Winkel=",a,"°"),color="warning",condition=(1.4*(r1+r2)>tx||4*(r1+r2)<tx)&&($children||r1+r2>20)&&(is_undef($idx)||!$idx));

if(!$children){
  if(b(center,false)<0&&r1!=r2) translate([tx0,0])polygon(riemen(r1=r1,r2=r2,tx=tx,fn=fn,fs=fs,center=0));
  else polygon(riemen(r1=r1,r2=r2,tx=tx,fn=fn,fs=fs,center=center));
  } else translate([(center?b(center,false)<0&&r1!=r2?tx0:-tx/2:0),0,0]){
  $idx=1;
  
  union(){
  $idx=0;
  rotate(180)RotEx(grad=180 - a*2 +gradS(s=lap,r=r1)*2,center=true,fn=fn)T(r1)children();
  }
  
  T(tx)RotEx(grad=180 + a*2 +gradS(s=lap,r=r2)*2,center=true,fn=fn)T(r2)children();
  rotate([0, 90,-a +180])T(0,r1)rotate(-270)Tz(-lTrum+lapL)linear_extrude(lTrum-lapL*2,convexity=5)children();
  rotate([0,-90, a +180])T(0,-r1)rotate(-90)Tz(+lapL)linear_extrude(lTrum-lapL*2,convexity=5)children();
  }
  
//echo(pathLength(riemen(r1=r1,r2=r2,tx=tx,fn=fn,center=center),close=true));
HelpTxt("Riemen",["r1",r1,"r2",r2,"tx",tx,"fn",fn,"fs",fs,"center",center,"spiel",spiel,"name",name],help);

}

/** \name Involute \page Polygons
\brief Involute() creates an involute polygon
\param r radius
\param s width
\param h height
\param r2 ↦ h+r
\param grad degree circle segment (optional)
\param end -1,0,1,2 end connection termination
\param delta outside change can be list for delta2
\param  delta2  inside change optional 
\param center s center or outside
\param oppose  opposing involutes
\param centerP  creates a point at [0,0]
\param fn fs  fargment number or size
\param name name for info
\parma help help
*/
//Involute(oppose=0,h=3,grad=0,end=+2,center=+0,delta=0,s=1,centerP=true);//  Involute profile
//Involute(r=10,r2=25);

module Involute(r=10,s=1,h=5,r2,grad,end=+1,delta=0,delta2,center=true,oppose=false,centerP=false,fn,fs=fs,name,help){

//fn=ceil(grad/360)*fn;
h=max(0,is_undef(r2)?h:r2-r);
grad=grad?grad:360/(PI*2*r) * sqrt( 2*r*h+h^2);
deltaList=delta;
delta=is_list(delta)?delta[0]:delta;
deltai =is_undef(delta2)&&is_num(deltaList)? delta/2:delta ;
delta2=is_undef(delta2)&&is_num(deltaList)?-delta:is_list(deltaList)?deltaList[1]:delta2;
grads=gradS(s=s,r=r);


p1=involute(r=r,grad=grad,rot=0,rev=true,delta=delta,fn=1);
pOpp=involute(r=r,grad=grad+(end>0?grads:0),rot=0,rev=true,delta=deltai,fn=1);
ih=oppose?norm(p1[0]):norm(pOpp[0]);

winkel=(atan2(p1[0].x,p1[0].y));
rot=winkel+gradS(r=ih,s=s)/2;


points=oppose?concat(
  centerP?[[0,0]]:[],
  involute(r=r,grad=grad,rot=center?-rot:0,delta=delta,fn=fn,fs=fs),
  involute(r=r,grad=-grad,rot=center?rot:rot*2,rev=true,delta=-delta,fn=fn,fs=fs)
):
  concat(
    centerP?[[0,0]]:[],
    involute(r=r,grad=grad+(end>0? end>1?grads/2 : grads:0),rot=center?-grads/2:0,delta=deltai,fn=fn,fs=fs),
    involute(r=r,grad=grad+(end<0?-grads:end>1?-grads/2 : 0),rot=center?grads/2:grads,rev=true,delta=delta2,fn=fn,fs=fs)
  )
;


polygon(points);

InfoTxt("Involute",["h",ih],name);

HelpTxt("Involute",["r",r,"s",s,"h",h,"grad",grad,"end",end,"delta",delta,"delta2",delta2,"center",center,"oppose",oppose,"centerP",centerP,"fn",fn,"fs",fs,"name",name],help);
}




//NACA(); // 2D NACA airfoil profil

module NACA(l=10,naca=0012,fn=fn,center=false,name,help){

points=naca(l=l,naca=naca,fn=fn);
InfoTxt("NACA",["Surface length",pathLength(points),"center",center?center==2?str("30%-max Thickness=",l*0.3):str("¼-25% neutral (N)=",l*0.25):0],name);
translate([center?center==2?-l*0.3:-l*.25:0,0])polygon(points);
HelpTxt("NACA",["l",l,"naca",str(naca<1000?"00":"",naca%100),"fn",fn,"center",center,name],help);
}

//Star(od=10,id=5);

module Star(e=5,r1=10,r2=5,grad=[0,0],grad2,radial=false,fn=0,fn2,d,od,id,help){
  kfn=is_num(fn2)?round(fn2):d?max(12,fs2fn(r=abs(d/2),fs=fs)):12;
  r1=is_num(od)?od/2:r1;
  r2=is_num(id)?id/2:r2;
  od=r1*2;
  id=r2*2;
  
  points=concat(
    star(e=e,r1=r1,r2=r2,grad=grad,grad2=grad2,radial=radial,fn=fn,z=undef),
    d? kreis(d=d,rand=0,fn=kfn,endPoint=false):[]
    );

  paths=[
    [for(i=[0:len(star(e=e,fn=fn))-1])i],
   if(d) [for(i=[0:len(kreis(rand=0,fn=kfn,endPoint=false))-1])i+len(star(e=e,fn=fn))]
    ];
polygon(points,paths,convexity=5);

HelpTxt("Star",["e",e,"r1",r1,"r2",r2,"grad",grad,"grad2",grad2,"radial",radial,"fn",fn,"fn2",fn2,"d",d,"od",od,"id",id],help);

}

/** \name Tdrop
\page Polygons
Tdrop() creates a Teardrop polygon
\param r radius
\param d diameter ↦ r
\param grad  angle
\param cut   flat top cut
\param fn,fs fragments
\param name name
\param help help
*/

module Tdrop(r=1,d,grad,cut=true,fn=fn,fs,name,help){

kgrad=is_undef(grad)?atan(layer/(nozzle/1.75)):90-grad;
delta=is_bool(cut)?nozzle-layer:cut; // added cut

r=is_num(d)?d/2:r;
h=cos(kgrad)*r;
x=sin(kgrad)*r;
h2=cut==false?h+tan(kgrad)*x:min(r+delta,h+tan(kgrad)*x);
x2=cut==false? 0:x - (h2-h)/tan(kgrad);


points=[
//[-x,h],
//[ x,h],
each kreis(rand=0,r=r,grad=360-kgrad*2,center=true,rot=-90,fn=fn,fs=fs),
if(x2>minVal)[- x2,h2],
clampToX0([ x2,h2])
];

if(messpunkt)%Tz(.1)color("green",.25)circle(r=r,$fn=fn);
polygon(points);
InfoTxt("Tdrop",["grad",90-kgrad,"cut",cut],name);
HelpTxt("Tdrop",["r",r,"d",d,"grad",grad,"cut",cut,"fn",fn,"fs",fs,"name",name],help);
}

/** \name VarioFill
\page Polygons
VarioFill() creates an fillet, chamfer round or hyperbolic
\param l length [x,y]
\param exp hyperbolic exponent
\param dia,h  3D rotate or linear extrude
\param chamfer if true exp=1, false = ellipsoid 
\param deg angle if l is number
\param extrude move in x ↦ radius for RotEx()
\param grad angles of sides to create fillet
\param lap  overlap - [x,y]
*/

//VarioFill([5,2],exp=2.0,fn=3,chamfer=0);


 

module VarioFill(
l=15,
exp=+2,
dia,
h,
chamfer=true,
deg=45,
extrude=0,
grad=90,//[0,90]
spiel,
lap=.2,
fn=fn,
fs=fs,
name,
help
){

lap=is_list(lap)?lap:[lap,lap];
grad=is_list(grad)?grad:[+0,grad];
  
padding=is_undef(spiel)?lap.yx:
                        is_list(spiel)?[spiel.x,spiel.y]:
                                       [spiel,spiel]; 
  
spiel=is_undef(spiel)?lap.yx:is_list(spiel)? // spiel xy is mixed up
  [spiel.x*max(1,(1/(sin(grad.y)*cos(grad.x)))),spiel.y*max(1,(1/(cos(grad.x)*sin(grad.y))))]:
  [spiel*max(1,(1/(sin(grad.y)*cos(grad.x)))),spiel*max(1,(1/(cos(grad.x)*sin(grad.y))))];
  //[spiel*(1/sin(grad.y)),spiel*(1/cos(grad.x))];   

l=is_list(l)?l:deg?[l,tan(deg)*l]:[l,l]; 

fn=is_undef(fn)||fn==0?fs2fn(r=max(l),grad=90,fs=fs):fn;

diaw=dia; // if undef ⇒ 2D

dia=is_num(dia)?grad.x?2*Hypotenuse(dia/2,tan(grad.x)*dia/2)
                       :dia
               :0;
  
extrude=extrude*sign(l.x);
rot=-180;
p1=[
[-spiel.y*sign(l.x) +dia/2, -spiel.x*sign(l.y)],
[-spiel.y*sign(l.x) +dia/2, l.y+sin(grad.x)*spiel.y*sign(l.y)],
[+extrude+dia/2,l.y],
for(i=[fn -1:-1:+0])let(seg=90/fn*i)
  chamfer?[pow((fn-i)/fn,abs(exp))*l.x+extrude+dia/2,pow(i/fn,abs(exp))*l.y]:
          [sin(seg+rot)*l.x+extrude+l.x+dia/2, cos(seg+rot)*l.y+l.y],

[extrude+l.x+dia/2,0],
[extrude+l.x-cos(grad.y)*spiel.x*sign(l.x) +dia/2,-spiel.x*sign(l.y)],
];


m=[
[cos(grad.x),sin(grad.y-90),+0,0],// scale x, skew x, trans x
[sin(grad.x),cos(grad.y-90),0,0],       // skew y, scale y, trans y
[0,0,1,0],
];

points=grad==[0,90]?p1:
                   [for(i=[0:len(p1)-1])let(p=m*concat(p1[i],[1,0]))[p.x,p.y]];

gK=sin(grad.y)*l.y-sin(grad.x)*l.x;
aK=cos(grad.x)*l.x+cos(grad.y)*l.y;

// color("red")square([aK,gK]);
//polygon(points,convexity=5);
//p2=[for(i=[0:len(points)-1])let(p=m*concat(points[i],[1,0]))[p.x,p.y]];

InfoTxt("VarioFill",["sekantenWinkel",atan(gK/aK)],name);


cut=spiel.y>abs(dia/2)?true: 
    sign(dia*l.x)==1?false :  // both pos or neg
                           sign(dia)*l.x<=sign(l.x)*dia/2;



if(is_num(diaw) && !is_parent(needs2D)) RotEx(cut=grad.x==0&&grad.y==90?cut:true) polygon(points);
  else if(h && !is_parent(needs2D)) linear_extrude(h,convexity=2,$fn=fn)polygon(points); 
    else if( l.x>0?grad.y>90:grad.y<90 || (l.y>0?grad.x<0:grad.x>0) )
      intersection(){
        polygon(points);
        mirror([sign(l.x)==1?0:1,sign(l.y)==1?0:1])translate([-padding.y+dia/2-(extrude*sign(l.x)<0?-extrude*sign(l.x):0),grad.x<0?-l.y:-padding.x])
          square([abs(extrude)+abs(l.x)+padding.y,grad.x<0?2*l.y:abs(l.y)+padding.x]);
      }
      else polygon(points);
    
//%multmatrix(m)translate([-spiel.y,-spiel.x])square([l.x+spiel.y,l.y+spiel.x]);
HelpTxt("VarioFill",[
  "l",l,
  "exp",exp,
  "dia",dia,
  "h",h,
  "chamfer",chamfer,
  "deg",deg,
  "extrude",extrude,
  "grad",grad,//[0,90]
  "lap",lap,
  "fn",fn,
  "name",name
  ],help);

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


module Kreis(r=10,dicke=0,grad=360,grad2,fn,center=true,sek=false,r2=0,rand2,rcenter=0,rot=0,t=[0,0],name,help,d,b,fs=fs,fa=fa,rand,id){
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


module ZigZag(e=5,es=0,x=50,y=7,mod=2,delta=+0,base=2,shift=0,center=true,name,help){
   x=es?e*es:x; 
   es=es?es:x/e;
  T(center?-x/2:0)  polygon(ZigZag(e=e,x=x,y=y,mod=mod,delta=delta,base=base,shift=shift),convexity=5);
 abst=x/e;
 h=y-base;   
 InfoTxt("ZigZag",["Winkel",str(atan((abst/2+shift)/h),"°+",atan((abst/2-shift)/h),"°=",atan((abst/2+shift)/h)+atan((abst/2-shift)/h),"°"),"Spitzenabstand",abst,"Zackenhöhe",h],name);
Echo("‼ use Nut(a=0,b=0)",color="redring"); 
HelpTxt("ZigZag",["e",e,"es",es,"x",x,"y",y,"mod",mod,"delta",delta,"base",base,"shift",shift,"center",center,"name",name],help); 

}


/** \name Nut
\page Polygons
Nut() creates grooves or notches or dovetails
\param e  elements or number of notches
\param es  element spacing, distance between, will be calculated if grad is used
\param a  length top of the notch - can be undef
\param b  bottom length of notch - can be undef
\param base base thickness below
\param h  height of notches
\param s  total length ↦ es
\param center  center
\param shift   shift top sections / skew
\param grad winkel  the angle of the notches
\param name help  name and help
*/

//union()Color(){
//Nut(a=5,b=5);
//Tz(.1)Nut(a=undef,b=1,grad=40);
//}

//Nut(es=10,a=undef,b=undef,grad=60);

module Nut(e=2,es=10,a=6,b=6,base=1,h=1,s,center=true,shift=0,winkel,grad,name,help){
  grad=is_undef(winkel)?assert(grad!=0)grad:assert(winkel!=0)winkel;
  
  esA=is_undef(s)?es:s/e;
  a= is_undef(a)?is_undef(b)?(esA/2+1*h*tan(90+grad)):esA+2*h*tan(90+grad)-b:a;
  
  s=is_undef(s)?is_num(grad)&&is_num(b)?e*(a+b-2*h*tan(90+grad)):
                                       is_undef(es)?assert( is_num(b) && is_num(a),"define a + b")a+b:
                                                    e * es:
                s;
 

  es=is_num(grad)&&is_num(b)?a+b-2*h*tan(90+grad):
                  s/e;

  b=is_undef(grad)?is_undef(b)?es-a:
                               b:
                  2*(h*tan(90+grad))+es-a;
    
    
    points=assert(e>0,"Nut has no elements")[[s,base],[s,0],[0,0],[0,base],
for(i=[0:e-1])each[
    [b/2+i*es,base],    
    [es/2-a/2+shift+i*es,h+base],
    [es/2+a/2+shift+i*es,h+base],
    [(es-b/2)+i*es,base]]
    ];
    path=[[for(i=[0:len(points)-1])i]];
     //   echo (points,path);
    

 translate(center?[-s/2,-base]:[0,0])   polygon(points,path,convexity=10);
    winkel1=atan(h/(es/2-a/2-b/2+shift));
    winkel2=atan(h/(es/2-a/2-b/2-shift));
    
   InfoTxt("Nut",concat(["winkel",str(winkel1,shift?str(" /",winkel2):"","°"),
    "Länge",s,
    "Abstand",es],
    "Abstand a",negRed(es-a),
    "Abstand b",negRed(es-b),
    grad?["b",negRed(b)]:[])
    ,name); 

   HelpTxt("Nut",[
   "e",e,
   "es",es,
   "a",a,
   "b",b,
   "base",base,
   "h",h,
   "s",s,
   "center",center,
   "shift",shift,
   "grad",grad,
   "name",name],
   help);  
}



module Egg(r1=10,r2=3,breit,grad,r3=true,fs=fs,name,help){
    
    breit=is_undef(breit)?r1:breit;
    x=r1-breit/2;
    r2=is_undef(grad)?r2:r1-(Hypotenuse(x,tan(grad)*x));
  assert(breit>=r2*2,str("max r2=",breit/2,"/ breit min=",r2*2," r2=",r2,"breit=",breit));
  assert(breit<=r1*2,str("breit>r1*2 r1=",r1," breit=",breit));
    a=r1-r2;
    grad=is_undef(grad)?acos(x/a):grad;
    hM=tan(grad)*x;
    r3=r3?true:false;
    
//    %Color(){
//    Kreis(r1,grad=grad,center=false,t=[0,-r1/2]);
//    Kreis(r2,grad=180-grad*2,center=true,t=[hM,0]);
//    Kreis(r1,grad=grad,center=false,rot=180-grad,t=[0,r1/2]);
//    if(r3)Kreis(grad=180,r1/2,rot=180); }
    

    
    points=concat(
        kreis(r1,grad=grad,rot=-90,center=false,t=[x,0],rand=0,sek=true,fn=fs2fn(r1,grad,fs,5))
       , kreis(r2,grad=180-grad*2,rot=90,center=true,t=[0,hM],rand=0,sek=true,fn=fs2fn(r2,180-grad*2,fs,5))//spitze
       , kreis(r1,grad=grad,center=false,rot=90-grad,t=[-x,0],rand=0,sek=true,fn=fs2fn(r1,grad,fs,5))
    );
    
    pointsR3=Kreis(grad=180,r=breit/2,rot=-90,rand=0,sek=true,fn=fs2fn(breit/2,180,fs,10));  
        
    polygon(r3?concat(points,pointsR3):points);    

    //if(help)echo("Help Egg(r1=10,r2=3,grad,r3=1,name,help);");
    HelpTxt("Egg",["r1",r1,"r2",r2,"breit",breit,"grad",grad,"r3",r3,"fs",fs,"name",name],help);
    InfoTxt("Egg",["hM",hM,"h",str(hM+r2,r3?str("/",hM+r2+breit/2):""),"breit(r3×2)",breit,"grad",grad,"r1",r1,"r2",r2],name);
}

/*
Tz(.25)color("green")GT(spiel=0,spielO=0);
Tz(.75)color("red")GT(spielO=0.05,spiel=0);// pre β22|064
Tz(.5)GT();
// */


/// GT2 tooth
module GT2(spiel=0,fn=fn){  
        fn=max(6,fn);
        p=2; // zahnabstand 
        PLD=0.254; //  ?Mittellinie? Pitch Line distance 
        r1=.15;//kehle basis zahn
        r2=1+spiel; // zahn flanken radius im abstand [b,i]
        r3=.555+spiel;// zahn spitzen radius
        b=0.4;// abstand mitte Mittelpunkt r2
        h=1.38; //gesamt h (i+ht)
        ht=0.75+spiel; // zahnhöhe
        i=.63;  // band dicke

   l=p +0.1;

  pointsGT2= concat(
        [[-l/2,ht],[-l/2,ht+i],[l/2,ht+i],[l/2,ht]]
            , kreis(r=r2,fn=fn/16,grad=22.5,center=false,t=[-b,ht],rot=90,rand=0,sek=true)
            , kreis(r=r3,grad=180-45,rot=-90,fn=fn/4,t=[0,r3],rand=0,sek=true)            
            , kreis(r=r2,fn=fn/16,grad=22.5,center=false,t=[b,ht],rot=-90-22.5,rand=0,sek=true)
        );
   
    T(0,-ht )Rund(0,r1,fn=fn)
        polygon(pointsGT2);
    
//union(){
//%T(-p,ht)square([2*p,i]);
// }    
//    Color("lime")T(0,r3,-0.1)circle(r3,$fn=fn);
//    Color("green")T(0,ht,-.11)intersection(){
//            T(b)circle(r=r2,$fn=fn);
//            T(-b)circle(r=r2,$fn=fn);
//            square([2,0.85],true);
//        }
    //%Color("red")T(0,ht-r1)MKlon(0.736)circle(r1);
  
}

 // GT();
/// GT2 profile rack, belt or pulley
module GT(z=20,achse=3.5,spiel=.05,evolute=true,pulley=true,linear=true,fn=fn,name,help,spielO=0){
        p=2; // zahnabstand 
        PLD=0.254; //  ?Mittellinie? Pitch Line distance 
        b=0.4;// abstand mitte Mittelpunkt r2
        r1=.15;//kehle basis zahn
        r2=1; // zahn flanken radius im abstand [b,i]
        i=.63;  // band dicke
        breiteZahn=(r2-b)*2;
        umfang=z*p; 
        zahnWinkel=360/z;

   
if(pulley){
    if(evolute){
        offset(-spielO)
        Rund(r1,0,fn=fn/4)
        union(){
            r=umfang/2/PI;
            difference(){
                circle(r,$fn=z*2);
                for(i=[0:z-1])rotate(i*360/z)
                for(i=[-ceil(zahnWinkel/2):ceil(zahnWinkel/2)])rotate(-i)T(-umfang/360*i,r-PLD)GT2(spiel);
                if(achse)circle(d=achse-spielO*2,$fn=fn);
            }
            InfoTxt("GT2 Pulley evolute profile",["Dia",r*2-spiel*2-PLD*2,"z",z],name);
                //if(name)echo(str(is_bool(name)?"":"<b>",name," GT2 Pulley evolute profil Dia=",r*2-spiel*2-PLD*2," z=",z));
        }       
     }
    else{
        offset(-spielO)
        Rund(r1,0,fn=fn/4)
        union(){
            r=umfang/2/PI-PLD;
            difference(){
                circle(r,$fn=z*2);
            for(i=[0:z-1])rotate(i*360/z)T(0,r)GT2(spiel);
            if(achse)  circle(d=achse-spielO*2,$fn=fn);
            }
            InfoTxt("GT2 Pulley",["Dia",r*2-spielO*2,"z",z],name);
            //echo(str(is_bool(name)?"":"<b>",name," GT2 Pulley Dia=",r*2-spiel*2,"z=",z));
        }
    }

 }
 else offset(-spielO){
     $info=false;
     if (linear)Linear(e=z,es=2)GT2(-spiel);
     else {
         r=umfang/2/PI;
         intersection(){
             Polar(e=z,y=r-PLD)GT2(-spiel);
             circle(r+i-PLD,$fn=z*2);
         }
     }
     InfoTxt("GT2 Belt",concat(["Länge",z*p],linear?[]:["(aussen",str((umfang/2/PI+i-PLD)*2*PI,")")]),name);
    // echo(str(is_bool(name)?"":"<b>",name," GT2 Belt Länge=",z*p,linear?"":str("(aussen ",(umfang/2/PI+i-PLD)*2*PI,")")));
     
     } 
    
HelpTxt("GT",["z",z,
"achse",achse,
"spiel",spiel,
"evolute",evolute,
"pulley",pulley,
"linear",linear,
"fn",fn,
"spielO",spielO,
"name",name     
],help);

}

module Rosette(
r1=10,
r2=15,
ratio=2,
wall=0.4,
id,
od,
fn=fn,
rotations,
name,
help
){
$info=0;
$helpf=0;
$messpunkt=0;
function rotations(ratio=ratio,n=1,max=500)=ratio==0?1:n/ratio%1&&n/ratio<max?rotations(ratio,n+1):n/ratio;//ganzzahliger Wert
  
autocalcRot=rotations();
  
Echo(str(name," Rosette rotations auto calc (",autocalcRot>=500?"over500 calc stopped":autocalcRot,") > 30 ↦ clamped to 30"),color="warning",condition=autocalcRot>25);
rotations=is_undef(rotations)?min(25,autocalcRot):rotations;
points=abs(ratio)>1?abs(fn*ratio*rotations):abs(rotations*fn);
calc=is_num(id)&&is_num(od)?1:0;
mr=calc? abs(id)<abs(od)?(od-id)/4:(id-od)/4:
         0;

r1=calc? mr - wall/2 * (sign(id)==sign(od)?sign(id):0) :
         r1;
  
r2=calc? mr+ (abs(id)<abs(od)?id/2:od/2) +wall/2 * (sign(id)!=sign(od)?sign(abs(id)<abs(od)?id:od):0):
         r2;

for (i=[0:points-1]){ 
     $idx=i;
     hull(){
     rotate(i*360*rotations/points)translate([r1,0])rotate(i*360*rotations*ratio/points)translate([r2,0])if($children)children(0);else circle(d=wall,$fn=12);
     
     rotate((i+1)*360*rotations/points)translate([r1,0])rotate((i+1)*360*rotations*ratio/points)translate([r2,0])if($children)children($children>1?1:0);else circle(d=wall,$fn=12);
     }
 }
InfoTxt("Rosette",["Rotations",rotations,"Punkte",points,"id",-wall+abs((abs(r2)-abs(r1))*2),"od",wall+abs((abs(r1)+abs(r2))*2)],name); 
HelpTxt("Rosette",[ 
  "r1",r1,
  "r2",r2,
  "ratio",ratio,
  "wall",wall,
  "id",id,
  "od",od,
  "fn",fn,
  "rotations",rotations,
  "name",name
  ], help);
}

/** \page Polygons
Pfeil() creates an arrow
\brief creates an arrow
\name Pfeil
\param l length [tail,head] or total length
\param b width  [tail,head] or teil and head is calculated by angle(grad)
\param shift shifting center and end points
\param grad arrow head angle
\param d form circular arrow
\param angle angle of circular arrow (optional)
\param center centers arrow
\param name  names arrow
\param help activate help
*/

//Pfeil(d=20,angle=-70,shift=-1);


module Pfeil(l=[+2,+3.5],b=+2,shift=0,grad=60,d=0,angle=0,center=true,name,help){
 shift=is_list(shift)?shift:[shift,-shift];
 l=is_list(l)?l:[l/2,l/2];
 b=is_list(b)?b:[b,2*(l[1]-(d?0:shift[0]))*tan(grad/2)];
 center=is_bool(center)?center?[1,1]:[0,0]:is_list(center)?center:[center,center];
 dir=sign(d)*(angle?sign(angle):1);
 d=d?max(abs(d),abs(b[1])):0;
 
 lD=[angle?min(abs(d)*PI/360*abs(angle),PI*abs(d)-l[1]-shift[0]-.01 ) :l[0],l[1]];// lenght circular arrow
 angle=angle?angle:gradB(r=d/2,b=l[0])*dir;
 
 gradB=d?gradB(b=lD[1]+ shift[1],r=d/2)  :0; // länge Pfeilspitze auf Kreis
 
 fnD=max(8,ceil(norm([b[1]/2,lD[1]])/$fs)); // fraqments gebogene Spitze
 fnDend=max(10,ceil(abs(lD[0])/$fs));
 
 spitze=false; // gebogene Spitze = false
 
 points=[
     [l[1],0],//spitze
     [shift[0],b[1]/2],
     [0,b[0]/2],   
  if(!d)[-l[0],b[0]/2],//End oben
  if(!d)[-l[0]+shift[1],0],//End mitte
  if(!d)[-l[0],-b[0]/2],//End unten
     [0,-b[0]/2],   
     [shift[0],-b[1]/2],   
    ];   


  pointsD=[
    [0,d/2-b[0]/2],
    each kreis(rand=0,grad=dir*gradB(r=d/2+b[0]/2*0,b=-lD[0]),d=d+b[0],center=0,fn=fnDend),
    [sin(dir*-gradB(r=d/2,b=lD[0] +shift[0]))*d/2,cos(dir*-gradB(r=d/2,b=lD[0] +shift[0]))*d/2],//shift End
    
    each kreis(rand=0,grad=dir*-gradB(r=d/2-b[0]/2*0,b=-lD[0]),d=d-b[0],center=0,rot=dir*gradB(r=d/2-b[0]/2*0,b=-lD[0]),fn=fnDend),
    
    [0,d/2+b[0]/2],
    for(i=[0:fnD ])    let(deg= dir * (i*gradB/fnD - gradB(shift[1],r=d/2) ), r=d/2 +(b[1]/2/fnD)*(fnD-i))
      [sin(deg)*r,cos(deg)*r],
    for(i=[fnD :-1:0]) let(deg= dir * (i*gradB/fnD - gradB(shift[1],r=d/2) ), r=d/2 -(b[1]/2/fnD)*(fnD-i))
      [sin(deg)*r,cos(deg)*r],
      
    ];

  if(d)translate(center.y?center.y<0?[0,d/2]:
                                  [0,0]:
                  [0,-d/2]){
      if(spitze)union(){
      Kreis(d=d,rand=b[0],b=-l[0],center=false,rcenter=true,rot=-90); 
      T(y=d/2)polygon(points);
      }
      else polygon(pointsD);

  }
  else translate([center.x?center.x>0?0:-l[1]:l[0],center.y?center.y>0?0:-b[1]/2:b[1]/2]) polygon(points);  
    
InfoTxt("Pfeil",["Winkel",2*atan((b[1]/2)/(l[1]-shift[0]))],name);    
HelpTxt("Pfeil",[   
    "l",l,
    "b",b,
    "shift",shift,
    "grad",grad,
    "d",d,
    "angle",angle,
    "center",center,
    "name",name],help);
}

/** \page Polygons
DPfeil() creates a double head arrow
\brief creates a double head arrow
\name DPfeil
\param l total length
\param b width  [tail,head] or teil and head is calculated by angle(grad)
\param shift shifting center and end points
\param grad arrow head angle
\param d form circular arrow
\param txt add text
\param rot rotate text
\param center centers arrow
\param name  names arrow
\param help activate help

##Example
DPfeil(l=[60,10],grad=30,txt="ABC");  
T(0,10)DPfeil();  
T(0,-10)DPfeil(shift=-1,txt=true);
*/

//for(l=[3:5:30])T(y=l/1)DPfeil([l,4],txt=true,rot=0);

module DPfeil(l=40,b=undef,shift=0,grad=35,d=0,txt,rot,center=true,name,help){
 
 l=is_list(l)?l:[l,l/8];
 shift=is_list(shift)?shift:[shift,txt?-shift:0];
 lP=[l[0]/2-l[1],l[1]]; 
 b=is_list(b)?b:[is_undef(b)?l[0]/20:b,2*(lP[1]-(d?0:shift[0]))*tan(grad/2)];
 //center=is_bool(center)?center?[1,1]:[0,0]:is_list(center)?center:[center,center];
 d=d?max(abs(d),abs(b[1]))*sign(d) : 0;
 txt=txt==true?str(l[0],"mm") : txt;
 txtL=txt?len(str(txt)) * b[1] *0.675 +.25 : 0;
 rot=is_num(rot)?rot:rot?90:0;

if(!d)T(center?0:l[0]/2)MKlon(max(0.1,(l[0]-lP[1]*2)/2 ))Pfeil(l=[lP[0]-(rot&&abs(rot)!=180?b[1]/2:lP[0]>txtL/2?txtL/2:0) ,lP[1]],b=b,shift=shift,grad=grad,d=d,center=true,name=name,help=false);

if(d)T(y=center?0:d/2)MKlon(mx=1)rotate(-gradB(b=min(lP[0],PI*d/2-lP[1]),r=d/2))Pfeil(l=[min(lP[0]-txtL/2,PI*d/2-lP[1]-txtL/2),lP[1]],b=b,shift=shift,grad=grad,d=d,center=true,name=name,help=false);

if(txt)T(center?0:d?[0,d/2]:l[0]/2,!rot&&lP[0]<txtL/2?b[1]:0)rotate(rot)Text(h=0,text=txt,size=b[1],center=true,cy=d?false:true,radius=d?d/2-b[1]/2:0,viewPos=false,name=false,trueSize="body");

//InfoTxt("DPfeil",["Winkel",2*atan((b[1]/2)/(l[1]-shift[0]))],name);    
HelpTxt("DPfeil",[   
    "l",l,
    "b",b,
    "shift",shift,
    "grad",grad,
    "d",d,
    "txt",txt,
    "rot",rot,
    "center",center,
    "name",name],help);

}





/*
CycloidZahn(z=2.0,f=2,d=1,linear=true,spiel=0.04);
//CycloidZahn(z=4.4,f=5,d=10,kreisDivisor=4);
// */
//CycloidZahn(modul=4,z=4.4,f=5,d=10,kreisDivisor=5);


module CycloidZahn(modul=1,z=10,d=0,linear=false,center=false,spiel=+0.05,fn=fn,fs=0.075,kreisDivisor=3.50,f=2,name,help){
  //if(is_undef(UB)) echo(str("<H1><font color=red> include ub.scad> "));
      
  z1=z%1?floor(z)+0.4999999:z;
  //z=z%1?floor(z)+.5:z;
  z=floor(z*f)/f;
  
  l=modul*PI*z-spiel*2;
  r=modul*z/2;//Wälzkreis
  spielwinkel=spiel/(r*2*PI)*360;
  rund=[modul/5/f,modul/2/f];
  //rund=[0,0];
  //rot=90/z;
  rot=180/z-180/z/f; // for radial
  //tra=modul*PI/4;  // for linear
  tra=modul/2*PI - modul/2*PI/f;  // for linear
  
    kreis=Umkreis(z*f,z*modul/2+modul/kreisDivisor+(d>r*2?spiel:-spiel));
    $info=false;

//current
  if(!linear)
  Rund(rund[0],rund[1],fs=fs)
   intersection(){
    Polar(z*f,rot=d<r*2?0:180/z/f)//rot=z%1?45/z:90/z)
     intersection (){
       rotate(-rot/2-spielwinkel)    Cycloid(modul=modul,z=z,d=d<r*2?d-1:d+1,fn=fn,option=2);
       rotate(rot/2+spielwinkel) Cycloid(modul=modul,z=z,d=d<r*2?d-1:d+1,fn=fn,option=2);
       }
    if(d)Kreis(d=d,rand=d<r*2?-r*2:0); // achsloch
    if(d<r*2)rotate(180/(z*f))  circle(r=kreis,$fn=z*f); // cut teeth
      else  Kreis(d=d+10,rand=(d/2+5-kreis)+Umkreis(z*2,modul/kreisDivisor*2),rot=0 ,fn=z*f);
    }
  

  lambda=modul*PI;
  //T(0,0.3)square([lambda/f,.1]);
  if(b(linear,bool=false)>0){
  T(center?-l/2:0)Rund(rund[0],rund[1],fs=fs)intersection(){
    T(-tra/2+ lambda/f/4) Linear(e=f,es=lambda/f) intersection(){
        T(+tra/2+spiel-lambda) Cycloid(modul=modul,z=z+2,d=d,linear=linear,fn=fn);
        T(-tra/2-spiel-lambda) Cycloid(modul=modul,z=z+2,d=d,linear=linear,fn=fn);
    }
   T(0,-(linear==true?modul:linear)) square([l,(linear==true?modul:linear)+modul/kreisDivisor]);
  }
  
  
//old ∇
  if(b(linear,bool=false)<0)Polar(z%1?2:1,end=z%1?180+rot:360,r=z%1?0:180/(z*4))
  Rund(modul/10,fs=fs){
    intersection (){
     rotate(-spielwinkel)    Cycloid(modul=modul,z=z1,d=d,fn=fn);
     rotate(rot+spielwinkel) Cycloid(modul=modul,z=z1,d=d,fn=fn);
      if(d<r*2)rotate(-rot/2)  circle(r=kreis,$fn=z*2);
         else  Kreis(d=d+10,rand=(d/2+5-kreis)+Umkreis(z*2,modul/3.5*2),rot=rot/2,fn=z*2);
    }
    rotate(180/z)intersection (){
     rotate(-spielwinkel)   Cycloid(modul=modul,z=z1,d=d,fn=fn);
     rotate(rot+spielwinkel)   Cycloid(modul=modul,z=z1,d=d,fn=fn);
      if(d<r*2) rotate(-rot/2)circle(r=kreis,$fn=z*2);
       else  Kreis(d=d+10,rand=(d/2+5-kreis)+Umkreis(z*2,modul/3.5*2),rot=rot/2,fn=z*2);
    } 
  }  
  
//old Δ

  }
  
InfoTxt("CycloidZahn",["Zähne=",z*f,linear?str(" Länge=",l):str(" Wälzkreis r=",r)," spiel",spiel],name);  
HelpTxt("CycloidZahnrad",["modul",modul,"z",z," d",d," linear",linear,"center",center,"spiel",spiel,"fn",fn,"fs",fs,"kreisDivisor",kreisDivisor,"f",f,"name",name],help);
}


//union(){
//r=1;
// r2=1;   
//    grad=70;
//    h=undef;
//    mitte=2;
//    extrude=+9.34;
//    xCenter=-1;
//polygon([for(i=[0:27])vollwelle(fn=5,l=18,grad=grad,h=h,r=r,r2=r2,mitte=mitte,xCenter=xCenter,grad2=50,extrude=extrude)[i]]);
//T(0,0,-0.1)color("green")Vollwelle(fn=5,l=18,grad=grad,h=h,r=r,mitte=mitte,r2=r2,xCenter=xCenter,grad2=+50,extrude=extrude);  
//T(0,2.4)color("red")square([8.68,1],center=0);
// *T(extrude-h,1)color("red")square([h,1],center=0);    
// *T(5,4)square([r2-sin(90-grad)*r2,1]);
// *T(5+6.5,1)square([r-sin(90-grad)*r,1]);
//    
//}

/// creates points for vollwelle
/*
p=vollwelle(grad2=-100,minF=12);
polygon(p);
echo(len(p));
//*/

function vollwelle(r=1,r2,grad=+60,grad2=+0,h=0,l,extrude=+5,center=true,xCenter=1,fn=12,x0=0,mitte=0,tMitte,g2End=[1,1],minF)=
let(
    fn=is_list(fn)?fn:[fn,fn],
    grad=is_list(grad)?grad:[grad,grad],
    grad2=is_list(grad2)?[max(grad2[0],-grad[0]),max(grad2[1],-grad[1])]:[max(grad2,-grad[0]),max(grad2,-grad[0])],
    sc=1,// scaling r center
    r2=is_num(r2)?r2:is_list(r)?r[1]:r,
    r=is_list(r)?r[0]:r,

 //r mittelpunkt verschiebung für tangenten Kontakt
/* tangY=[r*sin(grad[0])-tan(90-grad[0])*(r-cos(grad[0])*r), 
           r*sin(grad[1])-tan(90-grad[1])*(r-cos(grad[1])*r)],// */
           
    mitte=max(0,is_undef(tMitte)?mitte:tMitte - tan(grad[0]/2)*r - tan(grad[1]/2)*r),
    w=grad[0]-90,//del=echo(w,grad[0]-90),
    wOben=(grad[1]-90),
    hR=r-sin(90-grad[0])*r,
    hRO=r-sin(90-grad[1])*r,
    hR2=r2-sin(90-grad[0])*r2,
    hR2O=r2-sin(90-grad[1])*r2,
    h=max(hR+hR2,hRO+hR2O,h),
    hDiv=h-(hR+hR2),
    hDivOben=h-(hRO+hR2O),
    //hDiv=is_undef(h)?0:w>0?h-(sin(w)*r+sin(w)*r2):h-((sin(w)*r+sin(w)*r2))*0,
    y=2*cos(w)*r*sc+(hDiv*-tan(w)*2),
    yOben=2*cos(wOben)*r*sc+(hDivOben*-tan(wOben)*2),// kreis r2 oben incl. l1
    y2Oben=2*cos(wOben)*r2,// kreis r2 oben ohne l1
    y2=2*cos(w)*r2,
    
    x=  sin(w)*r+hDiv*1,
    x2= sin(w)*r2 ,
//    l0 länge unterhalb (-y) l1 länge oberhalb (+y)
    l0=is_undef(l)?y/2+y2/2+sin(grad2[0])*r2+mitte/2:is_list(l)?is_undef(l[0])?y/2+y2/2+sin(grad2[0])*r2+mitte/2:l[0]:l/2,
    l1=is_undef(l)?yOben/2+y2Oben/2+sin(grad2[1])*r2+mitte/2:is_list(l)?is_undef(l[1])?yOben/2+y2Oben/2+sin(grad2[1])*r2+mitte/2:l[1]:l/2,
    extrude=xCenter==0?extrude-hDiv/2
                       :xCenter>0?extrude-x-r
                                   :xCenter<-1?xCenter<-2?extrude+x2+cos(grad2[1])*r2
                                                          :extrude+x2+cos(grad2[0])*r2
                                               :extrude+x2+r2,
   
    trans=[+0,center?0:l0],// all points translation
    g2End=is_list(g2End)?g2End:[g2End,g2End],
    yKL1=l1-(yOben/2+y2Oben/2+mitte/2+sin(grad2[1])*r2),   // Abstand Kreisende bis l1
    yKL0=l0+(-y/2-y2/2-mitte/2-sin(grad2[0])*r2),         // Abstand Kreisende bis l0
    g2EndX0=grad2[0]!=90? g2End[0]? yKL0*tan(grad2[0]):  // End Punkt unten winkel verlängerung
                                    0:
                          0,
    g2EndX1=grad2[1]!=90? g2End[1]? yKL1*tan(grad2[1]):  // End Punkt oben winkel verlängerung
                                    0:
                          0
    )
concat(

    [[extrude-x2-cos(grad2[1])*r2+g2EndX1,l1]]+[trans]//oben Kreis verl.
    , kreis(r=r2,rand=0,rot=-90+grad2[1],center=false,grad=-grad[1]-grad2[1],t=[extrude-x2,yOben/2+y2Oben/2+mitte/2]+trans,fn=fn[0],minF=minF)//oben
    , kreis(r=r,r2=r*sc,rand=0,rot=90-grad[1],grad=grad[1],t=[extrude+x,mitte/2]+trans,fn=fn[1],center=false,minF=minF)//mitte oben
    , kreis(r=r,r2=r*sc,rand=0,rot=90,grad=grad[0],t=[extrude+x,-mitte/2]+trans,fn=fn[1],center=false,minF=minF)//mitte unten
    , kreis(r=r2,rand=0,rot=grad[0]-90,center=false,grad=-grad[0]-grad2[0],t=[extrude-x2,-y/2-y2/2-mitte/2]+trans,fn=fn[0],minF=minF)  //unten 
   
    ,[[extrude-x2-cos(grad2[0])*r2+g2EndX0,-l0]]+[trans]//unten Kreis verl.
    ,[[x0,-l0]]+[trans]//unten
    ,[[x0,l1]]+[trans]//oben

    );

    
/** \name SWelle
\page Polygons
SWelle() creates 2 attached arcsegments to form a wave (or S shape)
/param r,r2  radii
/param h y height 
/param deg contact angle
/param ext  x extension
/param lap  [-x,-y] overlap
/param center center y -1,0,1
/param fs  fragment Size
/param name help name help
*/

//SWelle(center=+1,h=7,deg=45);
  
module SWelle(r=2,r2,h=0,deg=90,ext=0,lap=[0,0.25],center=0,fs=fs,name,help){

r2=is_undef(r2)?is_list(r)?r.y:r:r2;
r=is_list(r)?r.x:r;
lap=is_list(lap)?lap:[lap,lap];
rH=(1-cos(deg))*r2 - cos(deg)*r ;
ty=max(h-r, rH );

deltaY=ty-rH;

tx=deg%180?sin(deg)*r2+sin(deg)*r +tan(90-deg)*deltaY+ext:ext;

points=[
[-lap.x,-lap.y],
[tx,-lap.y],
each arc(rot=270-deg,deg=deg,r=r2,t=[tx,r2],rev=true,fn=fs2fn(r=r2,fs=fs,grad=deg)), // base r
each arc(r=r,t=[ext,ty],deg=-deg,rot=(90-deg)*0+90,fn=fs2fn(r=r,fs=fs,grad=deg),rev=true), // top r
[-lap.x,ty+r]
];

translate([0,center==0?0:center==-1?-(ty+r):-(ty+r)/2
])
polygon(points);

HelpTxt("SWelle",["r",r,"r2",r2,"h",h,"deg",deg,"ext",ext,"lap",lap,"center",center,"fs",fs,"name",name],help);

}  
    
    
    
/** \name Vollwelle
\page Polygons
Vollwelle() creates 4 attached arcsegments to form a wave

\param r,r2  radii
\param grad  angle between
\param grad2 angle outside end
\param h     height of the wave (x amplitude)
\param l     length (y) of the polygon
\param extrude  move wave part on x (base stays at x0)
\param center  center end or center
\parame xCenter  center x on base(-1) mid(0) or top (1) of the wave
\parame x0    move the base of the polygon on x
\param mitte   elongate y center
\param tMitte  tangential center part length ↦ mitte
\param g2End  extensions of grad2 on or of [bottom, top]
\param fn     fragments for arcs [fn r2, fn r]
\param fs     fragmentsize for arcs [fs r2, fs r] ,↦ fn
\param help name   help name
*/

//Vollwelle();

module Vollwelle(r=1,r2,grad=+60,grad2=+0,h,l,extrude=+5,center=true,xCenter=0,fn,x0=0,mitte=0,tMitte,g2End=[1,1],fs=fs,help,name){
    
    // calc for geometry is done by function -- values here are only for console
    
    //ifn=is_list(fn)?fn:[fn,fn];
    //grad=is_list(grad)?is_undef(h)?echo(str("<h2><font color=red>Vollwelle define h"))[grad[0],grad[0]]:grad:[grad,grad];
    
    grad=is_list(grad)?grad:[grad,grad];
    grad2=is_list(grad2)?grad2:[grad2,grad2];
    sc=1;// scaling r center
    r2=is_undef(r2)?is_list(r)?r[1]:r:r2;
    r=is_list(r)?r[0]:r;
    w=(2*grad[0]-180)/2;
    wOben=(2*grad[1]-180)/2;
    fs=is_list(fs)?fs:[fs,fs];
    fn=is_undef(fn)||!fn?[fs2fn(r=r2,fs=fs[0],grad=max(grad)+max(grad2),minf=5 ),fs2fn(r=r,fs=fs[1],grad=max(grad),minf=5 )]:fn;
  
   //r mittelpunkt verschiebung für tangenten Kontakt
    tangY=[tan(grad[0]/2)*r,tan(grad[1]/2)*r];
   /*[r*sin(grad[0])-tan(90-grad[0])*(r-cos(grad[0])*r), 
           r*sin(grad[1])-tan(90-grad[1])*(r-cos(grad[1])*r)];// */
  
           
    mitte=is_undef(tMitte)?mitte:tMitte- tangY[0] -tangY[1];
  
//    echo(w);
 //   hDiv=is_undef(h)?0:w>0?h-(sin(w)*r+sin(w)*r2):h+(sin(w)*r-sin(w)*r2);
    hR=r-sin(90-grad[0])*r;
    hR2=r2-sin(90-grad[0])*r2;
    hRO=r-sin(90-grad[1])*r;
    hR2O=r2-sin(90-grad[1])*r2;    
    h=is_undef(h)?max(hR+hR2,hRO+hR2O):h;
    hDiv=h-(hR+hR2);
    
    y=2*cos(w)*r*sc+(hDiv*-tan(w)*2);
    yOben=2*cos(wOben)*r*sc+(hDiv*-tan(wOben)*2);
    y2=2*cos(w)*r2; 
    
    x=  sin(w)*r+hDiv ; 
    x2= sin(w)*r2 +0; 
    l1=is_undef(l)?y/2+y2/2+sin(grad2[0])*r2+mitte/2:is_list(l)?is_undef(l[0])?y/2+y2/2+sin(grad2[0])*r2+mitte/2:l[0]:l/2;
    l2=is_undef(l)?yOben/2+y2/2+sin(grad2[1])*r2+mitte/2:is_list(l)?is_undef(l[1])?yOben/2+y2/2+sin(grad2[1])*r2+mitte/2:l[1]:l/2;
    
    Echo(str(name," Vollwelle h ist minimal= ",h),color="green",condition=name&&h==(hR+hR2));
    
    Echo(str(name," Vollwelle h zu klein! min=",(hR+hR2)),color="red",condition=h<(hR+hR2));
    Echo(str(name," Vollwelle tMitte zu klein! min=",(tangY[0]+tangY[1])),color="red",condition=mitte<0);
    
    
    Echo("Vollwelle use Number for xCenter",color="red",condition=is_bool(xCenter));
    //xCenter=is_bool(xCenter)?0:xCenter;
    extrudeUnchanged=extrude;
    extrude=xCenter==0?extrude-hDiv/2:xCenter>0?extrude-x-r:xCenter<-1?xCenter<-2?extrude+x2+cos(grad2[1])*r2:extrude+x2+cos(grad2[0])*r2:extrude+x2+r2;
    
/*  replaced with function vollwelle
    points=concat(
    
    //[[x0,-y/2-y2/2-sin(grad2[0])*r2-mitte/2+0]],//unten
    [[extrude-x2-cos(grad2[0])*r2,-l1]],//unten Kreis verl.
    [[x0,-l1]],//unten
    //[[x0,y/2+y2/2+sin(grad2[1])*r2+mitte/2]],//oben
    [[x0,l2]],//oben
    [[extrude-x2-cos(grad2[1])*r2,l2]],//oben Kreis verl.
    
    Kreis(r=r2,rand=0,rot=-90+grad2[1],center=false,grad=-grad[1]-grad2[1],t=[extrude-x2,yOben/2+y2/2+mitte/2],fn=fn[0]),//oben
    Kreis(r=r,r2=r*sc,rand=0,rot=90-grad[1],grad=grad[1],t=[extrude+x,mitte/2],fn=fn[1],center=false),//mitte oben
    Kreis(r=r,r2=r*sc,rand=0,rot=90,grad=grad[0]*1,t=[extrude+x,-mitte/2],fn=fn[1],center=false),//mitte unten
    Kreis(r=r2,rand=0,rot=grad[0]-90,center=false,grad=-grad[0]-grad2[0],t=[extrude-x2,-y/2-y2/2-mitte/2],fn=fn[0])  //unten  
    );
    
    translate([0,center?0:l1])//(y2+y)/2+sin(grad2[0])*r2+mitte/2])
    polygon(points,convexity=5);
*/
    polygon(vollwelle(r=r,r2=r2,grad=grad,grad2=grad2,h=h,l=l,extrude=extrudeUnchanged,center=center,xCenter=xCenter,fn=fn,x0=x0,mitte=mitte,tMitte=tMitte,g2End=g2End));
    
    minimum=[extrude-x2-r2*(grad2[0]<0?cos(grad2[0]):1),extrude-x2-r2*(grad2[1]<0?cos(grad2[1]):1)];
    maximum=[extrude+x+r,extrude+x+r];
    
    InfoTxt("Vollwelle",[str("min=",grad2[0]==grad2[1]?
        grad2[0]<0?extrude-x2-r2*cos(grad2[0]):extrude-x2-r2
    :str(extrude-x2-r2*(grad2[0]<0?cos(grad2[0]):1),"/",extrude-x2-r2*(grad2[1]<0?cos(grad2[1]):1)),
   "(×2∅=",grad2[0]==grad2[1]?
        grad2[0]<0?2*(extrude-x2-r2*cos(grad2[0])):2*(extrude-x2-r2)
    :str(2*(extrude-x2-r2*(grad2[0]<0?cos(grad2[0]):1)),"/",2*(extrude-x2-r2*(grad2[1]<0?cos(grad2[1]):1))),
    "mm) — max=",extrude+x+r," (×2∅=",(extrude+x+r)*2,"mm)- Y länge=",l1+l2,"(",l1,"/",l2,")",//,y+y2+sin(grad2[0])*r2+sin(grad2[1])*r2+mitte,
    "mm Wellenhöhe="),grad2[0]==grad2[1]?maximum[0]-minimum[0]:maximum-minimum],info=name);
    
    HelpTxt("Vollwelle",[
    "r",r,
    "r2",r2,
    "grad",grad,
    "grad2",grad2,
    "h",h,
    "l",l,
    "extrude",extrudeUnchanged,
    "center",center,
    "xCenter",xCenter,
    "fn",fn,
    "x0",x0,
    "mitte",is_undef(tMitte)?mitte:str(mitte,"/*(calc)*/"),
    "tMitte",tMitte,
    "g2End",g2End,
    "fs",fs,
    "name",name]
    ,help); 
    
}



module SQ(size=[10,10],fn=[10,2],diff=[0.0001,0.0001,0.0001,0.0001],center=true,help){
    
    x=is_list(size)?size[0]:size;
    y=is_list(size)?size[1]:size;
    fnx=is_list(fn)?fn[0]:fn;
    fny=is_list(fn)?fn[1]:fn;
    diff=is_list(diff)?diff:[diff,diff,diff,diff];
    center=b(is_list(center)?center:[center,center],false);
    
    points=[
    for(i=[0:fnx])[-x/2+x/fnx*i,-y/2+i%2*-diff[0]],
    for(i=[0:fny])[x/2+i%2*diff[1],-y/2+y/fny*i],    
    for(i=[0:fnx])[x/2-x/fnx*i,y/2+i%2*diff[2]],
    for(i=[0:fny])[-x/2-i%2*diff[3],y/2-y/fny*i],

    ] ;
    
   // echo(points);
    path=[[for(i=[0:len(points)-1])i]];
    //echo (path);
   translate([-x/2*center.x,-y/2*center.y]+[x/2,y/2]) polygon(points,path);
    
   
 if($info) echo(" in twisted extrusions use linear_extrude(segments=20)");
HelpTxt("SQ",["size",[x,y],"fn",[fnx,fny],"diff",diff,"center",center] ,help);   
}

/*
union(){ // Gear TEST
    z=6;
rot=+0.5;

Cycloid(linear=+2,option=+0);
T(rot*PI*z-PI/4,z/2)rotate(-rot*360-90)Cycloid(option=+0,z=z,l=+0.00,d=1);
}
// */
/**
\name Cycloid
\page Polygon
Cycloid() creates a cycloid

\param modul cycloid circle size
\param z number of teeth (×2 revolutions)
\param fn fragments per teeth
\param option  -1,0,1  hyp hybrid epi 
\param l reduce height without changing base radius
\param delta contracted or extended cycloid  
\param d  circle for cener hole or generate inside teeth
\param linear  rack
\param name help name help
*/

//Cycloid(delta=0,linear=false);
//Cycloid(delta=-0.15,option=-1,linear=true);

module Cycloid(modul=1,z=5,fn=36,option=+0,l=0,delta=0,d=0,linear=false,name,help,zahn){
    z=is_undef(zahn)?z:zahn;
    r=modul*z/2;
    rCav=r;
    rVex=r;
    e=z*2;

    linear=is_bool(linear)?linear==true?modul:false:linear;
    //r=modul*e;
    fn2=fn*abs(e);
    r2=modul/4-l;//r/(e)-l;
    r2Vex=r2+delta;
    r2Cav=r2+delta;   
    step1=360/fn2;
    step2=step1*e; 
    step2Cav=-step1*(e-1);   
   // delta=+180;


if(linear){
    if(name) echo(str(is_string(name)?"<H3>":"",name," Zahnstangenlänge=",r*PI*2," Zahnabschnitt=",r*PI*2/z));
    box=[[PI*2*r,-linear],[0,-linear]];
    pointsEpi=[for(i=[0:fn2])[PI*2*r*i/fn2+r2Vex*-sin(i*step2),r2-r2Vex*cos(i*step2)]];
    pointsHyp=[for(i=[0:fn2])[PI*2*r*i/fn2+r2Cav*-sin(i*step2),-r2-r2Cav*-cos(i*step2)]];    
    if(option==1)color("pink")polygon(concat(box,pointsEpi));
    if(option==-1)color("cyan")polygon(concat(box,pointsHyp)); 
    points=[for(z=[0:2:e-2])each[for(i=[fn*z:fn*(z+1)])pointsEpi[i]
,for(i=[fn*(z+1):fn*(z+2)])pointsHyp[i]]];     
    if(!option)color("orange")polygon(concat(box,points));   
}

  
if(!linear){
    
  if(d) InfoTxt("Cycloid",["ZahnkreisRadius",str(r,"mm"),"fn Kreis rot",str(180/e,"°"),"d",d,"fn",max(d*3,fn)],name);
     else InfoTxt("Cycloid",["ZahnkreisRadius",str(r,"mm")],name);
 
   
 pointsEX=[for(i=[0:fn2])
    let(iw=i%fn2)
    [
    (rVex+r2)*cos(iw*step1)-r2Vex*cos(iw*(step2+step1)),
    (rVex+r2)*sin(iw*step1)-r2Vex*sin(iw*(step2+step1))
    ]
 ];
 pointsCAV=[for(i=[0:fn2])
    let(iw=i%fn2)
    [
    (rCav-r2)*cos(iw*step1)+r2Cav*cos(iw*step2Cav),
    (rCav-r2)*sin(iw*step1)+r2Cav*sin(iw*step2Cav)
    ]
 ]; 
 
 
pointsRand=kreis(r=d/2,rand=0,fn=max(d*3,fn));
 
if(option==1)color("pink")polygon(
    d?concat(pointsRand,pointsEX):pointsEX
   ,paths=
    d?[[for(i=[0:len(pointsRand)-1])i],
    [for(i=[len(pointsRand):len(pointsEX)-1+len(pointsRand)])i]]:
    [[for(i=[0:len(pointsEX)-1])i]]
    ,convexity=5

);
if(option==-1)color("cyan")polygon(
  d?concat(pointsRand,pointsCAV):pointsCAV
   ,paths=
    d?[[for(i=[0:len(pointsRand)-1])i],
    [for(i=[len(pointsRand):len(pointsCAV)-1+len(pointsRand)])i]]:
    [[for(i=[0:len(pointsCAV)-1])i]]
    ,convexity=5);    

points=[for(z=[0:2:e -2])each[
          for(i=[fn*z:fn*(z+1)])pointsEX[i],
          for(i=[fn*(z+1):fn*(z+2)])pointsCAV[i]
       ] ];

pointsSingle=d<r*2?[
                //for(i=[0:fn -1])pointsCAV[i+fn*(z*2-1)],
                each mPoints([for(i=[floor(fn/2):fn -1])pointsCAV[i]],r=-180/z),
                for(i=[+0:fn-1])pointsEX[i],
                each mPoints([for(i=[0:ceil(fn/2) -1])pointsCAV[i]],r=180/z),
                //for(i=[0:fn -1])pointsCAV[i+fn],
                if(!d) [0,0]
             ]:
             [
                each mPoints([for(i=[floor(fn/2):fn -1])pointsEX[i]],r=-180/z),
                for(i=[0:fn -1])pointsCAV[i],
                each mPoints([for(i=[0:ceil(fn/2) -1])pointsEX[i]],r=180/z)
             ]
             ;


if(!option)color("orange")rotate(-180/e)
    polygon(d?concat(pointsRand,points):points
   ,paths=
    d?[[for(i=[0:len(pointsRand)-1])i],
    [for(i=[len(pointsRand):len(points)-1+len(pointsRand)])i]]:
    [[for(i=[0:len(points)-1])i]]
    ,convexity=5);
    
  if(option==2){ 
    points2=d?concat(kreis(r=-d/2,rand=0,grad=360/z ,center=true,rot=-90/z,fn=max(d*3,fn)),pointsSingle):pointsSingle;
    rotate(-180/e) polygon(points=points2,paths=[[for(i=[0:len(points2)-1])i]]);
  }
}
HelpTxt("Cycloid",["modul",modul,"z",z,"fn",fn,"option",option,"l",l,"delta",delta,"d",d,"linear",linear,"name",name],help);
}


/// circle of circles

module WKreis(e=12,d1=1,d2,grad=180,r,diff,fn,fs=fs,r1,r2,name,help){
    
    d1=is_undef(r1)?d1:2*r1;
    d2=is_undef(d2)&&is_undef(r2)?d1:is_undef(r2)?d2:2*r2;
    r1=d1/2;
    r2=d2/2;
    winkel=360/(e*2);
    
    grad1=grad+winkel; // konvex
    grad2=grad-winkel; // konkav
    
    diff=is_undef(diff)?0:diff;
    

    sek1=sin(grad1/2)*d1;
    sek2=sin(grad2/2)*d2;
        
    r=is_undef(r)?Umkreis(e*2,((sek1+sek2)/4)/tan(winkel/2))+(d2>d1?pow(abs(d1/d2-1),+7):0):r; //WIP
    diff1=-d1/2*cos(grad1/2)+diff;
    diff2=d2/2*cos(grad2/2)-diff;    
    
    rEck=Umkreis(e*2,r);
    rK1=Kathete(r,sin(grad1/2)*d1/2)+diff1;
    rK2=Kathete(r,sin(grad2/2)*d2/2)+diff2;
    umfang=PI*r*2;
    umfang1=PI*(rK1)*2;
    umfang2=PI*(rK2)*2;
    umfangEck=e*(d1+d2);
    
    
    wk=[for(i=[0:e-1])each concat(
    kreis(r=-d2/2,rot=90-winkel/2+i*winkel*2,rand=0,grad=-grad2,sek=true,t=RotLang(-winkel/2+i*winkel*2,rK2),fn=fn,fs=fs)
    , kreis(r=d1/2,rot=90+winkel/2+i*winkel*2,rand=0,grad=grad1,sek=true,t=RotLang(winkel/2+i*winkel*2,rK1),fn=fn,fs=fs)
    )];

   rotate(winkel/2-90) polygon(wk,convexity=5);

    InfoTxt("Wkreis",["länge",str(umfangEck,"mm - Umfang(r=",r,")=",umfang,"mm Grad=",grad1,"°/",grad2,"°"),"\n\tAußen r",str(rK1+d1/2," OD=",2*rK1+d1," — Umfang=",umfang1,"mm Kreismitte=",rK1),"\n\tInnen  r",str(rK2-d2/2," ID =",2*rK2-d2," — Umfang=",umfang2,"mm Kreismitte=",rK2)],name);

HelpTxt("Wkreis",[
    "e",e,
    "d1",d1,
    "d2",d2,
    "grad",grad,
    "r",r,
    "diff",diff,
    "fn",fn,
    "fs",fs,
    "r1",r1,
    "r2",r2,
    "name",name],
help);
    
}

//Seg7(n="2-899",ratio=0.7,center=0,deg=45,spiel=+0.0);
//Seg7(n=[[1,1,1,1,0,1,0],[1,1,1,1,1],[1,1,1,1,0,1,0]],ratio=0.7,center=0,deg=35,spiel=+0.5);
//Seg7(88,spacing=-1,ratio=.5);



module Seg7(n=8,h=10,b=1,spiel=n(1),l,center=false,rund,ratio=1,deg=45,spacing=1,fs=fs,name,help){
    spielADJ=spiel/sqrt(2);
    l=is_undef(h)?l:h/2-b/2-spielADJ*2;
    deg=deg%180;
    y=l/2;
    x=b/2;
    y2=deg?y-x *(tan(90-deg)):y;
    assert(l!=0,"change b");
    /*
    num=[for(n)each
    if(n==0)[1,1,1,1,1,0,1]
    else if(n==1) [0,1,0,1,0,0,0]
    else if(n==2) [1,0,0,1,1,1,1]
    else if(n==3) [0,1,0,1,1,1,1]
    else if(n==4) [0,1,1,1,0,1,0]
    else if(n==5) [0,1,1,0,1,1,1]
    else if(n==6) [1,1,1,0,1,1,1]  
    else if(n==7) [0,1,0,1,0,0,1]
    else if(n==8) [1,1,1,1,1,1,1]
    else if(n==9) [0,1,1,1,1,1,1]
    else if(is_list(n))n   
    ];
    */
    codetable=[
     [1,1,1,1,1,0,1]
    ,[0,1,0,1,0,0,0]
    ,[1,0,0,1,1,1,1]
    ,[0,1,0,1,1,1,1]
    ,[0,1,1,1,0,1,0]
    ,[0,1,1,0,1,1,1]
    ,[1,1,1,0,1,1,1]  
    ,[0,1,0,1,0,0,1]
    ,[1,1,1,1,1,1,1]
    ,[0,1,1,1,1,1,1]
    ];
    num=is_list(n)?n:codetable[n];
    
    function points(x=x,y=y,y2=y2)=[[0,y],[x,y2],[x,-y2],[0,-y],[-x,-y2],[-x,y2]];
    
  if ( (is_list(n)&&is_num(n[0]) ) || (is_num(n)&&n<10) )
  T(center?0:l/2*ratio+b/2+spielADJ,b(center,false)==1?0:(b(center,false)>2?-1:1)*(l+b/2+spielADJ*2))
    Rund(is_undef(rund)?0:
          is_list(rund)?[min(rund[0],b/2-0.00001),min(rund[1],(l*min(ratio,1)+spielADJ*2-b)/2-.00001)]:
           [min(is_bool(rund)?b(rund,false)*b/2-0.00001:rund,b/2-0.00001),0],fs=fs){
    //Verticals
      Grid(es=[l*ratio+spielADJ*2,l+spielADJ*2],name=0)if(num[$idx[0]+$idx[1]*2])polygon(points(x=x,y=y,y2=y2));
    // Horizontals
      Grid(es=[l*ratio+spielADJ*2,l+spielADJ*2],e=[1,3,1],name=0)rotate(90)if(num[4+$idx[1]])polygon(points(x,y*ratio,y*ratio-(deg?x*tan(90-deg):0)));
  }
  else { // multi character 

   if(is_list(n[0]))for (i=[0:len(n)-1])T((l*ratio+b+spielADJ*2+b*spacing)*i-(center?(l*ratio+b+spielADJ*2+b)*(len(string)-1)/2:0)) Seg7(n=n[i],h=h,b=b,spiel=spiel,l=l,center=center,rund=rund,ratio=ratio,deg=deg,name=false); // binary lists
   
   else {
    Echo("number too big format n as string",color="red",condition=is_num(n)&&n>10^10);
    string=is_string(n)?n:log(n)<6?str(n):str(str(floor(n/10000)),str(n-floor(n/10000)*10000) );
  //echo(string);
    for (i=[0:len(string)-1])T((l*ratio+b+spielADJ*2+b*spacing)*i-(center?(l*ratio+b+spielADJ*2+b)*(len(string)-1)/2:0)){
      if(ord(string[i])>47&&ord(string[i])<58)Seg7(n=ord(string[i])-48,h=h,b=b,spiel=spiel,l=l,center=center,rund=rund,ratio=ratio,deg=deg,name=false); // numbers
      else if(string[i]=="-"||string[i]=="−"||string[i]=="—")Seg7(n=[0,0,0,0,0,1,0],h=h,b=b,spiel=spiel,l=l,center=center,rund=rund,ratio=ratio,deg=deg,name=false);// mitte
      else if(string[i]=="_")Seg7(n=[0,0,0,0,1,0,0],h=h,b=b,spiel=spiel,l=l,center=center,rund=rund,ratio=ratio,deg=deg,name=false);// under
      else if(string[i]==".")T(center?0:l/2*ratio+b/2+spielADJ,b(center,false)==1?-(l+b/2+spielADJ*2):(b(center,false)>2?-2:0)*(l+b/2+spielADJ*2))Seg7(n=[0,0,0,0,1,0,0],h=undef,b=b,spiel=spiel,l=l,center=2,rund=rund,ratio=b/l,deg=deg,name=false);// dot
      else if(string[i]==":")T(center?0:l/2*ratio+b/2+spielADJ,b(center,false)==1?-(l+ b + spielADJ*2)/2:(b(center,false)>2?-3:1)*(l+spielADJ*2)/2)Seg7(n=[0,0,0,0,1,1,0],h=h,b=b,spiel=spiel,l=b,center=2,rund=rund,ratio=b/l,deg=deg,name=false);// colon
      else if(string[i]!=" ")Seg7(n=[1,1,0,0,1,1,0],h=h,b=b,spiel=spiel,l=l,center=center,rund=rund,ratio=ratio,deg=deg,name=false);// other
    }
   }
  }
  
  
  InfoTxt("Seg7",["Höhe",str(l*2+b+spielADJ*4,"mm"),"Breite",str(l*ratio+b+spielADJ*2,"mm")],name);
      
  HelpTxt("Seg7",["n",n,"h",h,"b",b,"spiel",spiel,"l",l,"center",center,"rund",rund,"ratio",ratio,"deg",deg,"spacing",spacing,"fs",fs,"name",name],help);
}

module Flower(e=8,n=15,r=10,r2=0,min=5,fn=720,name,help){
points=[for(f=[+0:fn])let(i=f*360/fn)RotLang(i,r2+max(min-r2,(r-r2)*pow(abs(sin(e*.5*i)),2/n)))];

polygon(points,convexity=5);

HelpTxt("Flower",["e",e,"n",n,"r",r,"r2",r2,"min",min,"fn",fn,"name",name],help);
}


module Superellipse(n=4,r=10,n2,r2,n3,n31,n32,r3,fn=fn,fnz,name,help){
    
  
  r2=is_undef(r2)?is_list(r)?r.y:
                             r:
                  r2;
  r3=is_num(r.z)?r.z:r3;
  r=is_list(r)?r.x:r;
  
    n11=is_list(n)?n[0]:n;
    n12=is_list(n)?n[1]:n;
    n13=is_list(n)?n[2]:n;
    n14=is_list(n)?n[3]:n;
    n2=is_undef(n2)?n:n2;
    n21=is_list(n2)?n2[0]:n2;
    n22=is_list(n2)?n2[1]:n2;
    n23=is_list(n2)?n2[2]:n2;
    n24=is_list(n2)?n2[3]:n2;    
   
    //n3i=is_undef(n3)?is_list(n)?n[0]:n:n3;
    n3=is_undef(n3)?is_list(n)?[n[0],n[0]]:[n,n]:is_list(n3)?n3:[n3,n3];
    n31=is_undef(n31)?n3:is_list(n31)?n31:[n31,n31];
    n32=is_undef(n32)?n3:is_list(n32)?n32:[n32,n32];
    
    
    fnz=is_undef(fnz)?fn:fnz;
  InfoTxt("Superellipse",["n",str(n,is_undef(r3)?" is 2D":" is elipsoid 3D")],name);  
  
  if(is_undef(r3))  
    polygon([for(f=[0:fn])let(i=f%fn*360/fn)each[
    if(i<=90)[r*pow(sin(i),2/n11),r2*pow(cos(i),2/n21)],
    if(i>90&&i<=180)[r*pow(abs(sin(i)),2/n12),-r2*pow(abs(cos(i)),2/n22)],
    if(i>180&&i<=270)[-r*pow(abs(sin(i)),2/n13),-r2*pow(abs(cos(i)),2/n23)],
    if(i>270&&i)[-r*pow(abs(sin(i)),2/n14),r2*pow(abs(cos(i)),2/n24)],
    ]
    ]);
  else{
   points=[for(fz=[0:fnz],f=[0:fn])
       let(i=f%fn*360/fn,j=fz*180/fnz)
    each[
    
    if(i<=90&&j<=90)        [r*pow(sin(i),2/n11)*pow(sin(j),2/n31[1]),r2*pow(cos(i),2/n21)*pow(sin(j),2/n32[1]),r3*pow(cos(j),2/n3[1])],
    if(i>90&&i<=180&&j<=90) [r*pow(abs(sin(i)),2/n12)*pow(sin(j),2/n31[1]),-r2*pow(abs(cos(i)),2/n22)*pow(sin(j),2/n32[1]),r3*pow(cos(j),2/n3[1])],
    if(i>180&&i<=270&&j<=90)[-r*pow(abs(sin(i)),2/n13)*pow(sin(j),2/n31[1]),-r2*pow(abs(cos(i)),2/n23)*pow(sin(j),2/n32[1]),r3*pow(cos(j),2/n3[1])],
    if(i>270&&i&&j<=90)     [-r*pow(abs(sin(i)),2/n14)*pow(sin(j),2/n31[1]),r2*pow(abs(cos(i)),2/n24)*pow(sin(j),2/n32[1]),r3*pow(cos(j),2/n3[1])],
       
    if(i<=90&&j>90)         [r*pow(sin(i),2/n11)*pow(sin(j),2/n31[0]),r2*pow(cos(i),2/n21)*pow(sin(j),2/n32[0]),-r3*pow(abs(cos(j)),2/n3[0])],
    if(i>90&&i<=180&&j>90)  [r*pow(abs(sin(i)),2/n12)*pow(sin(j),2/n31[0]),-r2*pow(abs(cos(i)),2/n22)*pow(sin(j),2/n32[0]),-r3*pow(abs(cos(j)),2/n3[0])],
    if(i>180&&i<=270&&j>90) [-r*pow(abs(sin(i)),2/n13)*pow(sin(j),2/n31[0]),-r2*pow(abs(cos(i)),2/n23)*pow(sin(j),2/n32[0]),-r3*pow(abs(cos(j)),2/n3[0])],
    if(i>270&&i&&j>90)      [-r*pow(abs(sin(i)),2/n14)*pow(sin(j),2/n31[0]),r2*pow(abs(cos(i)),2/n24)*pow(sin(j),2/n32[0]),-r3*pow(abs(cos(j)),2/n3[0])],
    
      
    ]
    ];   
      
  
    faces=[for(i=[0:len(points)-fn -3])[i+1,i,i+fn+1,i+2+fn]];
    //faces2=[[for(i=[0:fn-1])i],[for(i=[len(points)-fn:len(points)-1])i]];  
    
   polyhedron(points,faces,convexity=5);   
      
  }
    
 
 HelpTxt("Superellipse",["n",n,"r",r,"n2",n2,"r2",r2,"n3",n3,"n31",n31,"n32",n32,"r3",r3,"fn",fn,"fnz",fnz,"name",name],help); 
}




module Quad(x=20,y,r,r1,r2,r3,r4,grad=90,grad2=90,fn,center=true,messpunkt=false,basisX=0,trueX=false,centerX,tangent=true,rad,fs=fs,name,help){
    assert(grad!=0&&grad2!=0);
    basisX=is_bool(basisX)?basisX?1:0:is_undef(centerX)?basisX:is_bool(centerX)?centerX?1:0:centerX;
    
    r=is_undef(rad)?r:rad;
    
    
    y=is_num(y)?y:
                is_list(x)?x[1]:
                           x;
    xNum=is_list(x)?x[0]:x;
    rundung=runden(min(xNum,y)/PHI/2,2);
    //r=is_undef(r)?[rundung,rundung,rundung,rundung]:is_list(r)?r:[r,r,r,r];

    r1=is_num(r1)?r1:is_undef(r[0])?is_num(r)?r:rundung:r[0];
    r2=is_num(r2)?r2:is_undef(r[1])?is_num(r)?r:rundung:r[1];
    r3=is_num(r3)?r3:is_undef(r[2])?is_num(r)?r:rundung:r[2];
    r4=is_num(r4)?r4:is_undef(r[3])?is_num(r)?r:rundung:r[3];
    
    radList=[r1,r2,r3,r4];
    fs=is_list(fs)?fs:[fs];
    //fn=is_undef(fn)?[for(i=[0:3])fs2fn(fs=$fs,r=radList[i],minf=12)]:is_list(fn)?fn:[fn];
    fn=is_list(fn)?fn:[fn];
       
    rf1=1/sin(grad);
    rf2=1/sin(grad2);
    shiftX1=tan(grad-90)*y-r1*2*tan(grad-90);
    shiftX2=tan(grad2-90)*y-r2*2*tan(grad2-90);
    shiftX3=tan(grad-90)*y-r3*2*tan(grad-90);
    shiftX4=tan(grad2-90)*y-r4*2*tan(grad2-90);
    


    // konstante x basis mit Rundung (tangetial punkte) / trueX= reale breite
    bx1L=r3-r3*rf1+shiftX3/2;
    bx1R=r4-r4*rf2-shiftX4/2; 
    bx2L=r1-r1*rf1-shiftX1/2;
    bx2R=r2-r2*rf2+shiftX4/2;
 
    bxL=sign(basisX)*tan(90-grad2)*(y/2);
    bxR=-sign(basisX)*tan(90-grad)*(y/2);    
    x=is_list(x)?trueX?basisX==-1?x[0]-bx2L-bx2R:x[0]-bx1L-bx1R:x[0]-bxL-bxR:trueX?basisX==-1?x-bx2L-bx2R:x-bx1L-bx1R:x-bxL-bxR; 
    trueX1=x+bx1L+bx1R; // real x1 breite
    trueX2=x+bx2L+bx2R; // real x2 breite
    
    p1=-x/2+shiftX1/2-r1*1/tan(grad);
    p2=x/2+shiftX2/2-r2*1/tan(grad2);
    p3=-x/2-shiftX3/2+r3*1/tan(grad);
    p4=x/2-shiftX4/2+r4*1/tan(grad2);
    x1=abs(p3)+abs(p4);   
    x2=abs(p1)+abs(p2);
    
    
  
    cTrans=is_list(center)?([center.x?b(center.x,false)<0?-x:
                                                           0:
                                      x,center.y?b(center.y,false)<0?-y:
                                                                      0:
                                                 y]
                           /2):
    
    
    
           (center?[basisX==1?tangent?-p3+(p3-p4)/2:
                                     (bx1L-bx1R)/2:
                            basisX==-1?tangent?-p1+(p1-p2)/2:
                                               (bx2L-bx2R)/2:
                                      0,sign(basisX)*y/2]:
                  tangent?basisX==1?[x/2+shiftX3/2-r3*1/tan(grad),y/2]:// center= false
                                    [x/2-shiftX1/2+r1*1/tan(grad),y/2]:
                          basisX==1?[bx1L+x/2,y/2]:
                                    basisX==-1?[bx2L+x/2,y/2]:
                                    [x/2,y/2]);
   
        
    k1=kreis(rand=0,r=r1,t=[-x/2+r1*rf1+shiftX1/2,y/2-r1]+cTrans,grad=180-grad,rot=grad-180,fn=is_undef(fn[0%len(fn)])?undef:fn[0%len(fn)]/360*(180-grad),fs=fs[0%len(fs)],center=false);
    k2=kreis(rand=0,r=r2,t=[x/2-r2*rf2+shiftX2/2,y/2-r2]+cTrans,grad=grad2,rot=-45+45,fn=is_undef(fn[1%len(fn)])?undef:fn[1%len(fn)]/360*grad2,fs=fs[1%len(fs)],center=false);
    k3=kreis(rand=0,r=r3,t=[-x/2+r3*rf1-shiftX3/2,-y/2+r3]+cTrans,grad=grad,rot=-225+45,fn=is_undef(fn[2%len(fn)])?undef:fn[2%len(fn)]/360*grad,fs=fs[2%len(fs)],center=false);
    k4=kreis(rand=0,r=r4,t=[x/2-r4*rf2-shiftX4/2,-y/2+r4]+cTrans,grad=180-grad2,rot=grad2 ,fn=is_undef(fn[3%len(fn)])?undef:fn[3%len(fn)]/360*(180-grad2),fs=fs[3%len(fs)],center=false);
 
 union(){
     polygon(concat(k1,k2,k4,k3),convexity=5);
     if(messpunkt){
         Pivot([p1,y/2]+cTrans,active=[1,0,0,1,1],messpunkt=messpunkt);
         Pivot([p2,y/2]+cTrans,active=[1,0,0,1,1],messpunkt=messpunkt);
         Pivot([p3,-y/2]+cTrans,active=[1,0,0,1,1],messpunkt=messpunkt);
         Pivot([p4,-y/2]+cTrans,active=[1,0,0,1,1],messpunkt=messpunkt);
     }
     
 }
    
  if(r1+r2>abs(trueX2)||r3+r4>abs(trueX1))Echo("Quad x too small or r too big",color="red");  
  if(r1+r1*sin(90-grad)+r3+r3*sin(grad-90)>abs(y)||r2+r2*sin(grad2-90)+r4+r4*sin(90-grad2)>abs(y))Echo("Quad y too small or r too big",color="red");
      
  InfoTxt("Quad",["TangentsizeX1",x1,"sizeX2",x2,"real",str(trueX1,"/",trueX2),"r",r],name);
      
  HelpTxt("Quad",["x",x,"y",y,"rad",r,"grad",grad,"grad2",grad2,"fn",fn,"center",center,"name",name,"messpunkt",messpunkt,"trueX",trueX,"centerX",centerX,"tangent",tangent,"fs",fs],help);
}

/** \name Linse \page polygons
Linse() creates a convex lens shape
\param dia length of the lens
\param r radii of the lense arcs
\param dicke thickness [left,right]
\param deg edge angle [45,45]
\param messpunkt show center points
\param fn fragments (optional)
*/

//Linse();


module Linse(dia=10,r,dicke,deg=45,name,messpunkt=$messpunkt,fn,help){

InfoTxt("Linse",["Dicke",idicke,"Kreisgrad",str(grad/2+grad2/2,"°/",[grad,grad2]/2,"°"),"r",r],name);

deg=is_list(deg)?deg:[1,1]*deg;

dicke=is_num(dicke)?dicke/2*[1,1]:dicke;

r=is_undef(r)?is_undef(dicke)?[dia/2/sin(deg[0]),dia/2/sin(deg[1])]:
                              [(dicke[0]^2 + (dia/2)^2)/dicke[0]/2,(dicke[1]^2 + (dia/2)^2)/dicke[1]/2] 
             :is_list(r)?r:[r,r];

tx=Kathete(r[0],dia/2);
tx2=Kathete(r[1],dia/2);

grad=2*asin((dia/2)/r[0]);    
grad2=2*asin((dia/2)/r[1]);    
idicke=(r[0]-tx) + (r[1]-tx2);
ifn=is_undef(fn)?fs2fn(r=r[0],fs=fs,grad=grad):fn;
ifn2=is_undef(fn)?fs2fn(r=r[1],fs=fs,grad=grad2):fn;

Echo("Linse r too small or dia too big",color="red",condition=!is_num(tx+tx2));

if(is_num(tx+tx2)){polygon(concat(
    kreis(rand=0,r=r[0],grad=grad,t=[tx*sign(r[0]),0],fn=ifn,endPoint=0),
    kreis(rand=0,r=r[1],grad=grad2,rot=-180,t=[-tx2*sign(r[1]),0],fn=ifn2,endPoint=0)
    )
   ); 
  if(messpunkt){
      Pivot([tx,0],active=[1,0,0,1,0],messpunkt=messpunkt);
      Pivot([0,dia/2],active=[1,0,0,1,1],messpunkt=messpunkt);
      Pivot([-tx2,0],active=[1,0,0,1,1],messpunkt=messpunkt);
      
  }
  
}

 HelpTxt("Linse",[
 "dia",dia,
 "r",r,
 "dicke",dicke,
 "deg",deg,
 "name",name,
 "messpunkt=",messpunkt,
 "fn",fn],
  help);
}

/** \name SternDeg
SternDeg() creates a polygon star with defined angle
\param e number tips
\param r radius tip
\param deg tip angle ↦ r2
\param r2 optional radius 2
\param d circle wall (optional)
\param fn,fs,fa fragments for d circle
\param help help
*/
module SternDeg(e=5,r=10,deg=36,r2,d=0,fn,fs=fs,fa=fa,help){
fn=fn?fn:fs2fn(r=d/2,fs=fs,fa=fa);
points=d?[each sternDeg(e,r,deg,r2),
          for(i=[0:fn-1])[cos(i*360/fn),sin(i*360/fn)]*d/2
           ]:sternDeg(e,r,deg,r2);

path=[
  [for(i=[0:e*2-1])i],
  if(d)[for(i=[0:fn-1])i+e*2]
  ];

polygon(points,path);


HelpTxt("SternDeg",["e",e,"r",r,"deg",deg,"r2",r2,"d",d,"fn",fn,"fs",fs,"fa",fa],help);
}

//SternDeg(d=25);


module Stern(e=5,r1=10,r2=5,mod=2,delta=+0,center=1,name,help){
    name=is_undef(name)?is_undef($info)?false:$info:name;
  
    star=
    let(schritt=360/(e*mod))
    [for(i=[0:e*mod])i%mod<mod/2+round(delta)?[sin(i*schritt)*r1,cos(i*schritt)*r1]:[sin(i*schritt)*r2,cos(i*schritt)*r2]];
    
    
    abstandR1=2*r1*sin(360/(e*mod));
    abstandR2=2*r2*sin(360/(e*mod));
    hoeheR1=r1-Kathete(r2,abstandR2/2);
    hypR1=Hypotenuse(abstandR2/2,hoeheR1);
    gradR1=2*acos(hoeheR1/hypR1);
    gradR2=2*asin((abstandR1/2)/hypR1);
    sWinkel=360/(e*mod);
    deltaSoll=(floor((mod-1)/2));
    $idx=is_undef($idx)?0:$idx;
    
    rotate((center==-1?180/e:0)-90+(center?sWinkel/4*(mod-(mod%2?1:2))+delta*sWinkel/2:+0))polygon(points=star,convexity=5);
    
    if(name&&delta!=-deltaSoll&&!$idx)Echo(str("Delta für Spitze r1=",-deltaSoll),color="green");
    
    if(mod==2&&delta==0)InfoTxt("Stern",["Spitzenabstand r1",abstandR1,"Abstand r2",abstandR2,"Flanke",hypR1,"Winkel r1",str(delta==-deltaSoll?gradR1:gradR1-(sWinkel*(deltaSoll+delta)),"°"),"Winkel r2",str(mod==2?gradR2:undef,"°"),"Schrittwinkel",str(sWinkel,"°")],name);   
    
    else InfoTxt("Stern",["Flanke",hypR1,"Winkel r1",str(delta==-deltaSoll?gradR1:gradR1-(sWinkel*(deltaSoll+delta)),"°"),"Schrittwinkel=",str(sWinkel,"°")],name);
      
    HelpTxt("Stern",["e",e,"r1",r1,"r2",r2,"mod",mod,"delta",delta,"center",center,"name",name],help);
  
}


module Sichel(h=1,start=55,max=270,dia=33,radius=30,delta=-1,step=5,2D=false,fn=36,help){
  if(!2D&&h) for (i=[start:step:max]){
       j=i+step;
       Color(i/max)hull(){
           rotate(i) T(radius+delta*i/max*dia/2)cylinder(h,d=i/max*dia,$fn=fn);
           rotate(j) T(radius+delta*j/max*dia/2)cylinder(h,d=j/max*dia,$fn=fn);
       }
    }
  if(2D||!h) for (i=[start:step:max]){
       j=i+step;
       Color(i/max)hull(){
           rotate(i) T(radius+delta*i/max*dia/2)circle(d=i/max*dia,$fn=fn);
           rotate(j) T(radius+delta*j/max*dia/2)circle(d=j/max*dia,$fn=fn);
       }
    }   
  
 HelpTxt("Sichel",[
"h",h,
"start",start,
"max",max,
"dia",dia,
"radius",radius,
"delta",delta,
"step",step,
"2D",2D,
"fn",fn], help); 

}

module Trapez (h=2.5,x1=6,x2=3.0,d=1,x2d=0,fn=36,rad,name,help){
  d=is_undef(rad)?d:rad*2;
    
  punkte=[
    [-x2/2+d/2+x2d,h-d/2],
    [x2/2-d/2+x2d,h-d/2],
    [x1/2-d/2,d/2],
    [-x1/2+d/2,d/2],    
  ];  
  if(d) minkowski(){
       polygon(punkte);
      circle(d=d,$fn=fn);
   }
  if(!d)polygon(punkte);
      //v=((x1+d)-(x2-d))/2/h;
      v=((x1+d)-(x2+d))/2/(h-d);
   if(name)echo(str(name," Trapez Steigung= ",v*100,"%-",atan(v),"°")); 
   HelpTxt("Trapez",["h",h,"x1",x1,"x2",x2,"d",d,"x2d",x2d,"fn",fn,"rad",rad],help);    
}

module Bogendreieck(rU=5,vari=-1,fn=fn,name){//-1  vari minus mehr bauch weniger ecken
    rU=rU;
teilradius=rU/(sqrt(3)/3);
rI=teilradius-rU; 
segment=sqrt(pow(rU,2)-pow(rU/2,2)); 
hoheh= sqrt(pow(teilradius+vari,2)-pow(segment,2));
verschieb= hoheh-rU/2;
    
if(name)echo(str(name," Bogendreieck Teilradius Abweichung von Reuleauxoptimum= ",vari));

     intersection_for(i = [0,120,240]){
         rotate(i)T(verschieb)circle (r=teilradius+vari,$fn=fn);  
    }
}

module Area(a=10,aInnen=0,rInnen=0,h=0,name,help){
    
   //a=PI*pow(r,2);
   rInnen=aInnen?sqrt(aInnen/PI):rInnen;
    aInnen=aInnen?aInnen:PI*pow(rInnen,2);
   rAussen=sqrt((aInnen+a)/PI); 
    
   if(!h) difference(){
        circle(rAussen);
        circle(rInnen);
    }
   if(h) linear_extrude (h,convexity=5)difference(){
        circle(rAussen);
        circle(rInnen);
    }    
    
    
    InfoTxt("Area",["Durchmesseraussen",2*rAussen,"Innen",rInnen*2,"Fläche",a,"Innen",aInnen],name);
    HelpTxt("Area",["a",a,"aInnen",aInnen,"rInnen",rInnen,"h",h,"name",name],help);
    
}


}//fold // /ΔΔ Polygons  ΔΔ\ \\
{//fold // \∇∇ Generator ∇∇/ //

/** \page Generator
Schlaufe()circle() creates a 3D loop with the child polygon
\name Schlaufe
\param grad  angle at the connection of both arcs
\param r radius [r1,r2]
\param r2  optional r2
\param mitte  straight center piece
\param grad2  angle  between end pieces
\param l length of linear extension end
\param h height of loop 
\param lap overlap
\param center center ends end or -1 loop r2
\param edge move loop to fit an edge of a n-gon
\param $messpunkt show arc center
*/

//Schlaufe($messpunkt=true,center=-1)circle();

//Schlaufe(end=1,grad2=[80,-5],l=[+0,5],r=20,h=61,edge=false,center=+1)circle($fn=6,r=2);


module Schlaufe(grad=120,r=10,r2,mitte=0,grad2=0,l=0,h,lap=.001,center=true,edge=true,end=false,$messpunkt=false,name,help,$fn=0){

end=is_list(end)?end:[end,end];

grad20=is_list(grad2)?grad2[0]:grad2/2;
grad21=is_list(grad2)?grad2[1]:grad2/2;

grad2=is_list(grad2)?grad2[0]+grad2[1]:grad2;

r2=is_undef(r2)?is_list(r)?r[1]:
                           r:
                r2;

r1=is_list(r)?r[0]:
              r;

grad=max(grad2/2,grad);

r10=r1;
r20=r2;
r11=r1;
r21=r2;

gradR1=grad;
gradR10=grad;
gradR11=grad;

gradR2=grad;

x1=r10*cos(grad20);
x12=r11*cos(grad21);
y1=r10*sin(grad)+r20*sin(grad)+mitte/2;

minH=x1-r10*cos(gradR10)-cos(gradR2)*r20+r20;

h=is_undef(h)?minH:h; // höhe
hDelta=h-(x1-r10*cos(gradR10)-cos(gradR2)*r20+r20); // hight diff for r2 to be at h

l2=grad!=180?norm([hDelta,hDelta/tan(grad)]):hDelta;// h extension

yh=cos(grad)*l2;// h y delta


//xMitte=x1-r1*cos(gradR1)-cos(gradR2)*r2+r2+hx;// center extrude x distance

//endDist=(-r1*sin(grad20)+y1+yh);// halber enden abstand
endDist2=[(-r10*sin(grad20)+y1+yh),(-r11*sin(grad21)+y1+yh)];//  enden abstand

edge=grad2%180==0?0:edge;

//centerDist=norm([endDist,endDist*tan(grad2/2)]);
centerDist=[norm([endDist2[0],endDist2[0]*tan(grad20)]),norm([endDist2[1],endDist2[1]*tan(grad21)])];

cDl=grad2>=180?[0,0]:centerDist;

l=(is_list(l)?l:[l,l]) - (edge?cDl:[0,0]);

if(h<minH)echo(str("h min",minH));
if(grad-grad2/2==0)echo("r1  angle 0!");



pos=center?center==-1?[-h+r2,0]:
                      [edge?-(endDist2[0])*tan(grad2/2)+(is_bool(edge)?0:
                                                                 edge):
                            0,
                              0]:
           [0,endDist2[0]];

InfoTxt("Schlaufe",["endDist",str(endDist2,"/",[l[0]/tan(grad20),l[1]/tan(grad21)]+(endDist2)),"centerDist",centerDist+pos.x*[1,1],"height",h,"r2center",h-r2+pos.x,"l",l],name);

grad3=180-(grad20+grad21);// winkel gamma
//echo(grad3,grad20,grad21,vSum(endDist2));
centerDistB=(vSum(endDist2)/sin(grad3)) * sin(grad21); // end0↦pC
pC=RotLang(grad20,centerDistB)-[0,endDist2[0]];




translate(pos){
Pivot(p0=[h-r2,0],active=[1,0,0,1,0,1],txt="M2");
Pivot(p0=[x1,y1],active=[1,0,0,1,0,1],txt="M1");

if(grad2%180!=0&&(endDist2[0]!=endDist2[1]||grad20!=grad21)){
  color("green")Pivot(p0=[endDist2[1]*tan(grad21),0],active=[1,0,0,1]);
  color("orange")Pivot(p0=[endDist2[0]*tan(grad20),0],active=[1,0,0,1]);
  Pivot(p0=pC,active=[1,0,0,1,0,1],txt="C");
  } 
  else if(grad2%180!=0)Pivot(p0=[endDist2[0]*tan(grad20),0],active=[1,0,0,1]);

$idx=true;
$tab=is_undef($tab)?1:b($tab,false)+1;
$info=false;

if(end[0])T(0,-endDist2[0])rotate(-grad20)T(0,-max(0,l[0]))rotate(-90)RotEx(cut=true,center=true,grad=180+lap*2,fn=fn/4)children();
if(end[1])T(x1-x12,endDist2[1])rotate(+grad21)T(0,max(0,l[1]))rotate(90)RotEx(cut=true,center=true,grad=180+lap*2,fn=fn/4)children();

  translate([x1,y1]){
    translate([0,yh])rotate(grad21){
      rotate_extrude(angle=gradR11-grad21)translate([-r11,0])children();// r1
      if(l[1]>0)color("green")translate([-r11,l[1]])rotate([90])linear_extrude(l[1]+lap,center=false,convexity=5)children();//l[1]
      if(l2)color("green")rotate(gradR11-grad21)translate([-r11,lap])rotate([90])linear_extrude(l2+lap*2,center=false,convexity=5)children();//l2
    }
    translate([hDelta,0])rotate(gradR11)translate([-r11-r21,0])rotate((l2?0:lap))rotate_extrude(angle=-gradR2-(l2?0:lap)-(mitte?0:lap/2))translate([r21,0]){
    $idx=false;
    $info=name;
    children();
    }
  }

  if(mitte)translate([h,0])rotate([90])linear_extrude(mitte+lap*2,center=true,convexity=5)children();

  translate([x1,-y1]){
    translate([0,-yh])rotate(-grad20){
      rotate_extrude(angle=-gradR10+grad20)translate([-r10,0])children();//r1
      if(l[0]>0)color("orange")translate([-r1,+lap])rotate([90])linear_extrude(l[0]+lap,center=false,convexity=5)children();//l[0]
      if(l2)color("orange")rotate(-gradR10+grad20)translate([-r10,l2+lap])rotate([90])linear_extrude(l2+lap*2,center=false,convexity=5)children();//l2
    }
    translate([hDelta,0])rotate(-gradR10)translate([-r10-r20,0])rotate(l2?0:-lap)rotate_extrude(angle=gradR2+(l2?0:lap)+(mitte?0:lap/2))translate([r20,0])children();
  }
}

MO(!$children);
HelpTxt("Schlaufe",["grad",grad,"r",r,"r2",r2,"mitte",mitte,"grad2",grad2,"l",l,"h",h,"lap",lap,"center",center,"edge",edge,"name",name],help);
}


module Bevel(z=0,r=.5,on=!$preview,grad=45,fillet=0,fn=12,messpunkt=messpunkt,help){
  
    diff=fillet?sin(grad)*r:tan(grad)*r;
 

    if(on)difference(){
    children(index=0);
    minkowski(convexity=5){
        difference(){
          $info=false;
          $idx=1;
            Tz(z>0?500+z-diff:-500+z+diff) cube(1000,true);
            children(index=0);
        }
        if($children==2) Tz(z>0?diff:-diff)R(z>0?180:0)children (1);
        else if(!fillet)R(z>0?0:180)Kegel(d1=0,d2=r*2,fn=fn,grad=grad,name=false);
        else Tz(z>0?r:-r)R(z>0?180:0)RotEx(cut=1,fn=fn)Kehle(2D=true,rad=r,fn2=fn);    
    }
}else
children(index=0);

if (messpunkt&&$children<2){       
%Grid(e=[2,2,1],es=is_bool(messpunkt)?10:messpunkt,name=false)Tz(z)if(!fillet)color("orange",alpha=.75){
    R(z>0?180:0)Kegel(d2=0,d1=r*2,fn=fn,grad=grad,name=false);
    R(z>0?0:180)cylinder(.5,r=r*1,$fn=fn);
}
        else color("green",alpha=.75)R(z>0?180:0)Tz(-r+diff)RotEx(cut=1,fn=fn)Kehle(2D=true,rad=r,fn2=fn,spiel=.5);

%Tz(z)if(!fillet)color("orange",alpha=.75){
    R(z>0?180:0)Kegel(d2=0,d1=r*2,fn=fn,grad=grad,name=false);
    R(z>0?0:180)cylinder(.5,r=r*1,$fn=fn);
}
        else color("green",alpha=.75)R(z>0?180:0)Tz(-r+diff)RotEx(cut=1,fn=fn)Kehle(2D=true,rad=r,fn2=fn,spiel=0.5);             
}
if($children==2)%Tz(z){Grid(e=[2,2,1],es=is_bool(messpunkt)?10:messpunkt,name=false)
  R(z>0?180:0)color("chartreuse",alpha=.75)children(index=1);
  R(z>0?180:0)color("chartreuse",alpha=.75)children(index=1);
  
  }
  
HelpTxt("Bevel",[     
     "z",z, 
     "r",r,
     "on",on,
     "grad",grad,
     "fillet",fillet,
     "fn",fn,
     "messpunkt",messpunkt]
    ,help); 
 
}




module LinEx2(bh=5,h=1,slices=10,s=1,ds=+0.010,dh=+0,fs=1,fh=0.780,twist=0,ft=1,dt=0,hsum=0,lap=0.001,fn=fn,name,help,startSlices,basetwist,rot=0){
    basetwist=is_undef(basetwist)?(bh+lap)*twist:basetwist;
    startSlices=is_undef(startSlices)?slices:startSlices;
    $helpM=0;
    $info=0;
    s=is_list(s)?s:[s,s];
  hsum=hsum?hsum:h;
    
    if(slices-1)rotate(-twist*h)Tz(h)scale([s[0],s[1],1])LinEx2(bh=bh,slices=slices-1,s=s*fs-[ds,ds],h=h*fh-dh,ds=ds,dh=dh,hsum=hsum+h*fh-dh,fs=fs,fh=fh,name=name,startSlices=startSlices,twist=twist*ft-dt,ft=ft,dt=dt,fn=fn,help=help,rot=rot+twist*h,basetwist=basetwist,lap=lap)children();
  
    Color(1/startSlices*slices)rotate(-basetwist)Tz(bh)linear_extrude(h+lap,twist=twist*(h+lap),scale=s,convexity=5,$fn=fn)children();
  if(slices==startSlices){
      linear_extrude(bh+lap,twist=basetwist,convexity=5,$fn=fn)children();
  MO(!$children);

  }
 
 if(!(slices-1)){
     InfoTxt("LinEx2",["Höhe",hsum+lap+bh,"Twist",basetwist+rot+twist*h],name);
     HelpTxt("LinEx2",["bh",bh,"h",h,"slices",slices,"s",s,"ds",ds,"dh",dh,"fs",fs,"fh",fh,"twist",twist,"ft",ft,"dt",dt,"lap",lap,"fn",fn,"name",name],help);
 }

}

/** Row()
 * \page Generator
 * \name module Row()
 * \brief Row will recursivly create a Row of objects with changing size (d+e*step) by keeping the gap equal
 * \param e number of objects
 * \param dist distance of objects
 * \param step Change of object size
 * \param d    Start diameter  
 * \param cut  create cuts of cut size
*/

module Row(e=15,dist=2,step=.1,d=+1,cut=.25,dir=+1,center=true,name,help,child){
    
    /*  Row will recursivly create a Row of objects with changing size (d+e*step) 
   /    by keeping the gap equal
 */
    child=is_undef(child)?$children:child;
    $d=d;
    $r=d/2;
    $info=is_undef(name)?is_undef($info)?true:$info:name;
    $helpM=is_undef(help)?is_undef($helpM)?false:$helpM:help;
    $idx=e-1;
    cut=is_num(cut)?cut:cut==true?0.02:false;
    if(e>1)T(d+dist+step/2) 
    if($children)Row(e=e-1,d=d+step,dist=dist,step=step,cut=cut,dir=dir<2?sign(dir*-1):dir,center=center,name=$info,help=$helpM,child=child)children();
     else Row(e=e-1,d=d?d+step:0,dist=dist,step=step,cut=cut,dir=dir<2?sign(dir*-1):dir,center=center,name=$info,help=$helpM,child=child);  
    
    if(!$children&&d)cylinder(100,d=$d,$fn=24,center=center);
    if($children)children();
    if(cut&&!child) T(-cut/2,dir>0?dir>1?0:0:-viewportSize,center?-viewportSize/2:0)color(alpha=0.0)cube([cut,viewportSize,viewportSize]);
    if(e==1)InfoTxt("Row",["last d",str($d,cut?str(" Cut is ",cut):"")],name); 

        
    HelpTxt("Row",[
    "e",e, 
    "dist",dist, 
    "step",step, 
    "d",d, 
    "cut",cut, 
    "dir",dir, 
    "center",center, 
    "name",$info], 
    $helpM);
    
    if($helpM&&!$idx)echo("Row will recursivly create a Row of objects with changing size $d=(d+e*step) by keeping the gap (dist) equal");
}

/** \page Generator
Rundrum() extrudes a shape around
\name Rundrum
\brief Rundrum uses rotate_extrude and linear_extrude to suround a Quad or circle
## Examples
  Rundrum() circle();
  
  Rundrum(eck=3,r=[10,20,30])Star(e=5);
  
  
 * @param x,y size
 * @param r the edge radius vector for n-gon possible
 * @param twist twist the linear sections
 * @param grad angle for square to match Quad
 * @param grad2 second angle for square to match Quad
 * @param lap   overlap
 * @param fn number of fragments for edges ¼ for squares
 * @param name name
 * @param help help=true

*/



module Rundrum(x=+40,y,r=10,eck=4,twist=0,grad=90,grad2=90,lap=0.005,fn=fn,name,help){
    
$info=name;
$idxON=false;

$fa=fa;
$fs=fs;
$fn=fn;
  // WIP
  Echo("Angle with different radii not implemeted yet",condition=(r1!=r2||r2!=r3||r3!=r4)&&(grad2!=90||grad!=90));
  
    r1=is_list(r)?r[0]:r;
    r2=is_list(r)?r[1]:r;
    r3=is_list(r)?r[2]:r;
    r4=is_list(r)?r[3]:r;
    rI=r;
    r=is_list(r)?r[0]:r;
    y=is_list(x)?x[1]:is_undef(y)?x:y;
    x=is_list(x)?x[0]:x;
        
    //grad2=grad-20;// WIP
    shift=tan(grad-90)*y;
    grad=grad?grad:shift>0?atan(shift/y):-atan(-shift/y);
    shiftx=shift-r*2*tan(grad-90);
    shiftx2=tan(grad2-90)*y-r*2*tan(grad2-90);
    shiftYLang=Hypotenuse(shiftx,y-2*r);
    shiftYLang2=Hypotenuse(shiftx2,y-2*r);
    if(eck==4&&grad!=90&&name)echo(str(name," Rundrum grad=",grad,"° ShiftX=",shiftx,"mm (+-",shiftx/2,"mm) Lot(x)=",x*sin(grad),"mm"));
    //rx=r?r*(r/(sin(grad)*r)):0;
    function rx(r=r,grad=grad)=r*1/sin(grad);
    

if(eck==4&&twist==0)
    if(grad==90&&grad2==90){
        $info=is_undef(name)?$info:name;
        $tab=is_undef($tab)?1:b($tab,false)+1;
        //Ecken
        T(-x/2+r1,y/2-r1)rotate(90)RotEx(90,fn=fn/4,cut=true)T(r1)children();// R1
        union(){
        $info=false;
        $helpM=false;
        $idx=true; // disable help
        T(x/2-r2,y/2-r2)RotEx(90,fn=fn/4,cut=true)T(r2)children();// R2
        T(-x/2+r3,-y/2+r3)rotate(180)RotEx(90,fn=fn/4,cut=true)T(r3)children();// R3
        T(x/2-r4,-y/2+r4)rotate(-90)RotEx(90,fn=fn/4,cut=true)T(r4)children();// R4
        //Graden
        //X
        T((r1-r2)/2,y/2)R(90,0,90)linear_extrude(x-r1-r2+lap,center=true,convexity=5)children();
        T((r3-r4)/2,-y/2)R(90,0,-90)linear_extrude(x-r3-r4+lap,center=true,convexity=5)children();
        //Y
        T(-x/2,(r3-r1)/2)R(90,0,180)linear_extrude(y-r1-r3+lap,center=true,convexity=5)children();
        T(x/2,(r4-r2)/2)R(90,0,+0)linear_extrude(y-r2-r4+lap,center=true,convexity=5)children();        
        }
        
    }
else T(-shiftx/2*0){
      $info=is_undef(name)?$info:name;
      $tab=is_undef($tab)?1:b($tab,false)+1;
    //plus x    
    T(x/2-rx(r2,grad2)+shiftx2/2,y/2-r2)rotate(90-grad2)rotate_extrude(angle=grad2,convexity=5,$fn=0,$fa = grad2/(fn/4), $fs = 0.1)Ecke(r2)children();
    union(){
      $idx=true; // disable help
      $helpM=0;
      $info=0;
    T(x/2-rx(r4,grad2)-shiftx2/2,-y/2+r4)rotate(-90)rotate_extrude(angle=180-grad2,convexity=5,$fn=0,$fa = (180-grad2)/(fn/4), $fs = 0.1)Ecke(r4)children(); 
    //minus x   
    T(-x/2+rx(r1)+shiftx/2,y/2-r1)rotate(90)rotate_extrude(angle=180-grad,convexity=5,$fn=0,$fa = (180-grad)/(fn/4), $fs = 0.1)Ecke(r1)children();
    T(-x/2+rx(r3)-shiftx/2,-y/2+r3)rotate(-90)rotate_extrude(angle=-grad,convexity=5,$fn=0,$fa = grad/(fn/4), $fs = 0.1)Ecke(r3)children();  


    //linear x -+   
    T(+x/2-rx((r2+r4)/2,grad2)+shiftx2/2,y/2-r)rotate(90-grad2)T(+r)R(90,0,0)Tz(-lap/2)linear_extrude(shiftYLang2+lap,convexity=5,center=false,$fn=fn)children();
    T(-x/2+rx(r1/2+r3/2)-shiftx/2,-y/2+r)rotate(90-grad)T(-r)R(90,0,180)Tz(-lap/2)linear_extrude(shiftYLang+lap,convexity=5,center=false,$fn=fn)children();
 
    //linear y -+    
    T(-x/2+rx()+shiftx/2-lap/2,y/2+0)R(90,0,90)linear_extrude(x-rx(r1)-rx(r2,grad=grad2)+lap+shiftx2/2-shiftx/2,convexity=5,center=false,$fn=fn)children();
    T(+x/2-rx(grad=grad2)+lap/2-shiftx2/2,-y/2)R(90,0,-90)linear_extrude(x-rx()-rx(grad=grad2)+lap-shiftx2/2+shiftx/2,convexity=5,center=false,$fn=fn)children(); 
    }   
    if(2*r>x||2*r>y){
        echo();
            Echo(str("››»!!!«‹‹ ",name," Rundrum WARNUNG !!! Radius zu groß !!!"),color="red");
        echo();
        
    }

    if(name) if((2*r==x||2*r==y)&&x!=y)echo(str(name," Rundrum Halbkreis"));
    if(name)  if(2*r==x&&2*r==y)echo(str(name," Rundrum Vollkreis"));
       
    }
  else{
    for(i=[0:eck-1]){
        r=is_list(rI)?rI[i%len(rI)]:r;
        rNext=is_list(rI)?rI[(i+1)%len(rI)]:r;
        l=[Kathete(Umkreis(eck,x-rNext),x-rNext),Kathete(Umkreis(eck,x-r),x-r)];
        
        $tab=is_undef($tab)?1:b($tab,false)+1;
        $info=is_undef(name)?$info:name;
        $idx=i*2;
        stepDeg=360/eck;
        rotate(i*stepDeg)T(Umkreis(eck,x-r))rotate(-180/eck)rotate_extrude(angle=stepDeg,$fn=fn,convexity=5)intersection(){
            T(r)rotate(i*(twist/eck))children();
            translate([0,-150])square(300);
        }
        union(){
            $helpM=0;
            $info=0;
            $idx=i*2+1;
            //rotate(i*stepDeg+180/eck)T(x) R(-90)linear_extrude(l[0]+lap,center=false,twist=twist/eck,$fn=fn,convexity=5)rotate(+twist/eck+i*(twist/eck))children();
            rotate(i*stepDeg+180/eck)T(x,l[0]+lap) R(90)linear_extrude(vSum(l)+lap*2,center=false,twist=twist/eck,$fn=fn,convexity=5)rotate(+twist/eck+i*(twist/eck))children();
        }
    }
    
  }
MO(!$children);

    module Ecke(r=r){
        //render()
        intersection(){
            T(r)children();
            translate([0,-150])square(300);
        }
    }
  
HelpTxt("Rundrum",["x",x,"y",y,"r",r,"eck",eck,"twist",twist,"grad",grad,"lap",lap,"fn",fn,"name",name],help);    
}

/** \page Objects
Torus() creates a torus with optional child();

\param trx radius torus
\param d,r   diameter or radius rim (use $d,$r in children)
\param rot rotate 2D children
\param a,grad   angle torus
\param fn,fn2 fragments
\param fs,fs2 fragmentsize
\param dia  outer diameter torus optional to trx
\param id   inner diameter torus optional to trx
\param end  add Ends
\param trxEnd,gradEnd  end Torus radius and angle
\param lap  overlap of extrusions 
*/

//Torus(grad=180,end=+2,trxEnd=-3,fn=0,lap=.1);



module Torus(trx=+6,d=4,a=360,fn=fn,fn2=0,r,rot=0,grad=0,dia,id,center=true,end=0,gradEnd=90,trxEnd=0,endRot=0,endspiel=+0,lap=0,fs=fs,fs2=fs,name,help)
    rotate(grad?0:-a/2){

    end=is_undef(spheres)?is_bool(end)?end?-1:0:end:spheres;//compatibility
    d=is_undef(r)?d:r*2;
    $d=d;
    $r=d/2;
    fn2=fn2==0?ceil(fs2fn(r=$r,fs=fs2,minf=12)/2)*2:fn2;
    endRot=is_list(endRot)?endRot:[endRot,endRot];
    trx=dia?dia/2-d/2
           :id?id/2+d/2:trx;
    grad=grad?grad:a;
    a=end==-1&&!trxEnd? grad-(asin(abs($r)/trx)*2)*sign(grad):
                                 grad;
         //   end==-1&&!$children? a-(asin($r/trx)*2)*sign(a):
         //                        a;
    
    $idxON=false;
    
    InfoTxt("Torus",["Innen∅",2*trx-d,"Mitten∅",2*trx,"Aussen∅",2*trx+d,"∅d",d],info=name);
    HelpTxt("Torus",["trx",trx,"d",d,"a",a,"fn",fn,"fn2",fn2,"r",r,"rot",rot,"grad",grad,"dia",dia,"id",id,"center",center,"end",end,"gradEnd",gradEnd,"trxEnd",trxEnd,"endRot",endRot,"name",name,"$d",$d,"lap",lap,"fs",fs,"fs2",fs2,"name",name],help);
    
        
  rotate(end==-1? (asin(abs($r)/trx))*sign(grad):
                  0){
     $idx=true;
     $info=is_undef(name)?is_undef($info)?false:$info:name;
      translate([0,0,center?0:d/2])rotate(end||trxEnd?-lap:0) RotEx(grad=end||trxEnd?a+lap*2:a,fn=fn,$fs=fs,cut=1,help=false,center=0){
        $idx=0;
        $tab=is_undef($tab)?1:b($tab,false)+1;
        if($children)T(x=trx)R(0,0,rot)children();
        else T(x=trx)R(0,0,rot)circle(d=abs(d),$fn=fn2);
      }

      if(end&&a!=360&&!trxEnd){
          if($children){
              rotate(a)translate([trx,0,center?0:d/2])scale([1,abs(end),1])R(0,endRot[1])RotEx(cut=sign(end*grad),grad=180*sign(end),fn=max(fn/2,6),help=false)rotate(endRot[1])children();
              rotate(+0)translate([trx,0,center?0:d/2])rotate(180)scale([1,abs(end),1])R(0,-endRot[0])RotEx(cut=sign(end*grad),grad=180*sign(end),fn=max(6,fn/2),$fs=fs,help=false)rotate(endRot[0])children();  
          }
          else{
          rotate(a-sign(grad)*minVal)translate([trx,0,center?0:d/2])scale([1,abs(end),1])R(90)Halb(sign(grad)>0?1:0)sphere(d=abs(d),$fn=fn2);
          rotate(sign(grad)*minVal)translate([trx,0,center?0:d/2])scale([1,abs(end),1])R(90)Halb(sign(grad)>0?0:1)sphere(d=abs(d),$fn=fn2);
          }
      }
      
      if(trxEnd)translate([0,0,center?0:d/2]){ // End Ringstück
          if($children){
          T(trx-trxEnd)rotate(gradEnd*sign(-trxEnd)){
              rotate(end?-lap*sign(trxEnd):0)RotEx(grad=(gradEnd+(end?lap:0))*sign(trxEnd),cut=+0,fn=fn/360*gradEnd,$fs=fs)T(trxEnd)rotate(rot)children();
              if(end)translate([trxEnd,0,0])rotate(180)scale([1,abs(end),1])R(0,-endRot[0])RotEx(cut=sign(end*gradEnd),grad=180*sign(gradEnd*end),fn=max(6,fn/2),$fs=fs,help=false)rotate(endRot[0])children();
              }
         rotate(180+grad)T(-trx+trxEnd)rotate(180){
              RotEx(grad=(gradEnd+(end?lap:0))*sign(trxEnd),cut=+0,fn=fn/360*gradEnd,$fs=fs)T(trxEnd)rotate(rot)children();
              if(end)rotate((gradEnd)*sign(trxEnd))translate([trxEnd,0,0])scale([1,abs(end),1])R(0,endRot[1])RotEx(cut=sign(end*gradEnd),grad=180*sign(gradEnd*end),fn=max(6,fn/2),$fs=fs,help=false)rotate(endRot[1])children();
              } 
          }
          else{
              T(trx-trxEnd)rotate((gradEnd)*sign(-trxEnd)){
              rotate(end?-lap*sign(trxEnd):0)RotEx(grad=(gradEnd+(end?lap:0))*sign(trxEnd),fn=fn/360*gradEnd,$fs=fs,cut=+0)T(trxEnd)rotate(rot)circle(d=d,$fn=fn2);
              if(end)translate([trxEnd,0,0])rotate(180)scale([1,abs(end),1])RotEx(cut=sign(end*gradEnd),grad=180*sign(gradEnd*end),fn=fn/8,$fs=fs,help=false)rotate(rot)circle(d=d,$fn=fn2);
              }
         rotate(180+grad)T(-trx+trxEnd)rotate(180){
              RotEx(grad=(gradEnd+(end?lap:0))*sign(trxEnd),cut=+0,fn=fn/360*gradEnd,$fs=fs)T(trxEnd)rotate(rot)circle(d=d,$fn=fn2);
              if(end)rotate((gradEnd)*sign(trxEnd))translate([trxEnd,0,0])scale([1,abs(end),1])RotEx(cut=sign(end*gradEnd),grad=180*sign(gradEnd*end),fn=fn/8,$fs=fs,help=false)rotate(rot)circle(d=d,$fn=fn2);
              }  
          }    
      }
  }
}


/* Roof
// opt = straight / voronoi


//Roof(10,h=1,base=5,floor=true,twist=50,scale=[0.3,1])circle(5,$fn=3);

//Roof(25,[1,1],deg=-60,fn=60)circle(10,$fn=50);
Roof(25,[1,1],deg=-45)offset(1,$fs=.2,$fn=0)polygon([
[0,0],
[10,0],
[10,10],
[5,5],
[0,10]
]);
//*/

//Roof(10,[1,1],fn=10,deg=-45)Quad(50,grad=45,grad2=45,r=8,fs=1.5);


module Roof(height,h,base=0,deg=45,opt=1,floor=false,center=false,twist=0,scale=1,fn=0,convexity=5,lap=0.0001,on=true,name,help,slices,segments,fs=fs){


deg=is_list(deg)?deg:[deg,deg];
s=[deg[0]%90?tan(deg[0]):1,deg[1]%90?tan(deg[1]):1];
iopt=is_list(opt)?opt:[opt,opt];
opt=iopt;//[ s[0]<0?0:iopt[0], s[1]<0?0:iopt[1] ];
floor=is_list(h)?true:floor;
h=is_list(h)?h:[floor?h:0,h];
lap=is_list(lap)?lap:[h[0]?lap:0,lap];
iSize=max(viewportSize,max(printBed)*2);
ifn=$fn;
base=height&&is_num(h[1])&&is_num(h[0])?height-h[0]-h[1]:base;
ofs=[s[0]<0?-h[0]*tan(90-deg[0]):0,s[1]<0?-tan(90-deg[1])*h[1]:0];

on=version()[0]>2021?on:0;
$idxON=false;

InfoTxt("Roof",["h",h,"deg",str(deg,"° (",s,")")],name);
if(twist)InfoTxt("Roof",["twist",str(twist/base,"°/mm")],name);


Echo("Roof is experimental - use Dev Snapshot version and activate",color="warning",condition=version()[0]<2022);
  Tz(on?(center?0:h[0]?h[0]:0):0){
  $tab=is_undef($tab)?1:b($tab,false)+1;
  $idx=is_undef($idx)?0:$idx;
  if(base)Tz(center?0:-lap[0])rotate(twist/base*lap[0])linear_extrude(base+(on?vSum(lap):h[0]+h[1]),center=b(center,true),twist=twist/base*(base+(on?vSum(lap):h[0]+h[1])),scale=scale,convexity=convexity,$fn=fn,slices=slices,segments=segments,$fs=fs){
  $fn=ifn;
  children();
  }
  }
 if(on){ 
 $idx=is_undef($idx)?1:$idx;
 $noInfo=true;
 $info=false;
 //top
  if(scale&&(h[1]||is_undef(h[1])))Tz( (center?base/2:base+(h[0]?h[0]:0))+(s[1]<0?h[1]:0) )difference(){
  scale([1,1,s[1]])roof(method=opt[1]?"voronoi":"straight",$fn=fn,$fs=fs,convexity=convexity)offset(delta=ofs[1]){
  $fn=ifn;
  scale(scale)rotate(-twist)children(); // experimental feature comment out if not activated in preferences
  }
  //*if(h[1])translate([0,0,(h[1]+iSize/2)*sign(s[1])])cube([iSize,iSize,iSize],true);// if using difference
  if(h[1])translate([0,0,(h[1]+iSize/2)*sign(s[1])])linear_extrude(iSize,center=true,convexity=convexity)offset(delta=1)children();// if using difference
  //if(h[1])cube([iSize,iSize,h[1]*2],true); // for intersection
  }
  
 //bottom
  if(floor&&(h[0]||is_undef(h[0])))Tz((center?-base/2:(h[0]?h[0]:0))+(s[0]<0?-h[0]:0))difference(){
    scale([1,1,-s[0]])roof(method=opt[0]?"voronoi":"straight",$fn=fn,$fs=fs,convexity=convexity)offset(delta=ofs[0]){
    $fn=ifn;
    children(); // experimental feature comment out if not activated in preferences
    }
    //if(h[0])cube([iSize,iSize,h[0]*2],true);//for intersection
    //if(h[0])translate([-iSize/2,-iSize/2,-h[0]])mirror([0,0,1])cube(iSize);//for difference 
    //*if(h[0])translate([0,0,(-h[0]-iSize/2)]*sign(s[0]))cube(iSize,true);//for difference
    if(h[0])translate([0,0,(-h[0]-iSize/2)]*sign(s[0]))linear_extrude(iSize,center=true,convexity=convexity)offset(delta=1)children();//for difference
    }
  }
  
  
  

HelpTxt("Roof",["height",height,"h",h,"base",base,"deg",deg,"opt",opt,"floor",floor,"center",center,"twist",twist,"scale",scale,"fn",fn,"convexity",convexity,"lap",lap,"on",on,"name",name],help);
}



/** \page Generator
 \name LinEx
 LinEx()  linear extrudes child  polygon
 \param h height
 \param h2 height bottom
 \param h22 heigt top
 \param scale scale bottom
 \param scale2 scale top
 \param twist twist center
 \param twistcap twist top/bottom
 \param slices slices
 \param $d $r polygon size for angle calculation
 \param grad  calculate scale from $d/$r for angle
 \param grad2 angle (optional) for top
 \param center center result
 \param end   rotate extrude ends
 \param fn   number of fragments
 \param lap overlap with center
 \param scaleCenter scale center
 \param gradC angle center ↦ scaleCenter
 \param convexity convexity
 \param name  name to identify
 \param help activate help
*/

 //LinEx(25,2,end=true,gradC=88,$d=5)circle($r);
 //LinEx(25,2,end=true,scaleCenter=[0.8,0.7],scale=[.8,1],$d=[7,9])square($r);




module LinEx(h=5,h2=0,h22,scale=0.85,scale2,twist,twistcap=1,slices,$d,$r=5,grad,grad2,mantelwinkel=0,center=false,rotCenter=false,end=0,fn=12,name,help,n,convexity=5,lap=0.0001,scaleCenter=1,gradC){


$info=is_undef(name)?is_undef($info)?false:$info:name;
$helpM=0;
$idxON=false;

lap=is_list(lap)?lap:[lap,lap];
ifn=$fn;
end=is_bool(end)?end?[1,1]:[0,0]:is_list(end)?end:[end,end];   
name=is_undef(n)?name:n;

$r=is_undef($d)?$r:$d/2;
$d=2*$r;
h=max(0,h);
h22=abs(is_undef(h22)?is_list(h2)?h2[1]:h2:h22);
h2=abs(is_list(h2)?h2[0]:h2);    
hc=max(0,h-h2-h22);
twistcap=hc>0?is_list(twistcap)?twistcap:[twistcap,twistcap]:
[0,0];
gradC=is_undef(gradC)?gradC:is_list(gradC)?gradC:[gradC,gradC];
scaleCenter=is_undef(gradC)?scaleCenter:
                            is_list($r)?[($r.x-(hc/tan(gradC.x)))/$r.x,($r.y-(hc/tan(gradC.y)))/$r.y]:
                                        [($r-(hc/tan(gradC.x)))/$r,($r-(hc/tan(gradC.y)))/$r];

scale2=is_undef(grad2)?
    is_undef(grad)?
    is_undef(scale2)?h22?scale:1:scale2
    :is_list(grad)?is_list($r)?[($r[0]-(h22/tan(grad[0])))/($r[0]),($r[1]-(h22/tan(grad[1])))/($r[1])]:
                               [($r-(h22/tan(grad[0])))/($r),($r-(h22/tan(grad[1])))/($r)]:
                   is_list($r)?[($r.x-(h22/tan(grad)))/($r.x),($r.y-(h22/tan(grad)))/($r.y)]:
                                ($r-(h22/tan(grad)))/($r):
    is_list(grad2)?
        is_list($r)?[($r[0]-(h22/tan(grad2[0])))/($r[0]),($r[1]-(h22/tan(grad2[1])))/($r[1])]:[($r-(h22/tan(grad2[0])))/($r),($r-(h22/tan(grad2[1])))/($r)]:($r-(h22/tan(grad2)))/($r);
scale=h2?is_undef(grad)?scale:
    is_list(grad)?
        is_list($r)?[($r[0]-(h2/tan(grad[0])))/($r[0]),($r[1]-(h2/tan(grad[1])))/($r[1])]:
                    [($r-(h2/tan(grad[0])))/($r),($r-(h2/tan(grad[1])))/($r)]:
        is_list($r)?[($r.x-(h2/tan(grad)))/($r.x),($r.y-(h2/tan(grad)))/($r.y)]:
        ($r-(h2/tan(grad)))/($r):
     1;    
    


grad=h2?is_list(scale)?
          is_list($r)?[atan(h2/($r[0]-$r[0]*scale[0])),atan(h2/($r[1]-$r[1]*scale[1]))]:
                      [atan(h2/($r-$r*scale[0])),atan(h2/($r-$r*scale[1]))]:
          is_list($r)?[atan(h2/($r.x-$r.x*scale)),atan(h2/($r.y-$r.y*scale))]:
                      atan(h2/($r-$r*scale)):
    0;
    
grad2=h22?is_list(scale2)?
            is_list($r)?[atan(h22/($r[0]-$r[0]*scale2[0])),atan(h22/($r[1]-$r[1]*scale2[1]))]:
                        [atan(h22/($r-$r*scale2[0])),atan(h22/($r-$r*scale2[1]))]:
            is_list($r)?[atan(h22/($r.x-$r.x*scale2)),atan(h22/($r.y-$r.y*scale2))]:
                        atan(h22/($r-$r*scale2)):
         0;

mantelwinkel=is_undef(twist)?mantelwinkel:atan(twist*PI*$d/360/hc);    
twist=is_undef(twist)?mantelwinkel?360*tan(mantelwinkel)*hc/(2*PI*$r):0:twist;
segments=is_undef(slices)?0:slices*8;

/*
slices=is_undef(slices)?$preview?twist?fn:
                                       1:
                                 max(1,round(min(abs(twist)/hc*10,hc/l(2))) ):
                        slices;
    
*/
    
  InfoTxt("LinEx",
  [ "core h",str(hc,"mm - twist per mm= ",twist/(hc),"°, Fase für $d= ",$d,"mm ist ",grad,"°/",grad2,"° d=",vMult($d,scale),"/",vMult(vMult($d,scale2),scaleCenter),"mm - r= ",vMult($r,scale),"/",vMult(vMult($r,scale2),scaleCenter),"mm \n Mantelwinkel für $d/$r=",$d,"/",$r,"mm⇒ ",mantelwinkel,"° twist=",twist,"°")
  , scaleCenter!=1?str("\n scaled center $d/$r= ",vMult($d*scaleCenter),"/",vMult($r*scaleCenter)," base angle= ",
  is_list($r)&&is_list(scaleCenter)?[atan(hc/($r.x-scaleCenter.x*$r.x)),atan(hc/($r.y-scaleCenter.y*$r.y))]:
  is_list($r)?[atan(hc/($r.x-scaleCenter*$r.x)),atan(hc/($r.y-scaleCenter*$r.y))]:
  is_list(scaleCenter)?[atan(hc/($r-scaleCenter.x*$r)),atan(hc/($r-scaleCenter.y*$r))]:
  atan(hc/($r-vMult(scaleCenter,$r))),"°",", slices" ) : "slices",slices ],name); 
    

    
  Echo(str(name," LinEx Höhe center=",hc,"mm"),color="red",condition=hc<0);
    
    if(is_list(grad2)?$r*tan(min(grad2[0],grad2[1]))<(is_list($r)?[h22,h22]:h22)&&min(grad2[0],grad2[1])<90&&min(grad2[0],grad2[1])>0:$r*tan(grad2)<(is_list($r)?[h22,h22]:h22)&&grad2<90&&grad2>0)Echo(str(name," LinEx Höhe h22=",h22," mm zu groß oder winkel/$r zu klein min=",atan(h22/$r),"° max=",is_list(grad2)?$r*tan(min(grad2[0],grad2[1])):$r*tan(grad2),"mm"),color="red");
        
    if(is_list(grad)?min($r)*tan(min(grad))<h2&&min(grad)<90&&min(grad)>0:
                     min($r)*tan(grad)<h2&&grad<90&&grad>0)Echo(str(name," LinEx Höhe h2=",h2," mm zu groß oder winkel/$r zu klein min=",atan(h2/$r),"° max=",$r*tan(grad),"mm"),color="red");    
    
    HelpTxt("LinEx",["h",h,"h2",h2,"h22",h22,"scale",scale,"scale2",scale2,"twist",twist,"twistcap",twistcap,"slices",slices,"$d",$d,"grad",grad,"grad2",grad2,", mantelwinkel",mantelwinkel,"center",center,"rotCenter",rotCenter,"end",end,"fn",fn,"name",name,"convexity",convexity,"lap",lap,"scaleCenter",scaleCenter],help);  
    


  rotate(center?0:rotCenter?-twist/2:-twist/2+(twistcap[0]&&hc?-twist/hc*h2:0))
    T(z=center?-h/2:0){
    
if(version()[0]>2021){
    union(){
    $info=false;
    $idx=is_undef($idx)?true:$idx;
    $noInfo=true;
    //capoben
    if(h22)T(z=h-h22)rotate(-twist/2)linear_extrude(h22+(end[1]?lap[1]:0),scale=scale2,twist=twistcap[1]?twist/(hc)*h22:0,convexity=convexity,slices=is_undef(slices)?slices:max(1,slices/hc*h22),$fn=0,segments=segments)scale(scaleCenter){
      $fn=ifn;
      children();
      }
    
    //capunten
    if(h2)Tz(h2)rotate(twist/2)mirror([0,0,1])linear_extrude(h2+(end[0]?lap[0]:0),scale=scale,twist=twistcap[0]?-twist/(hc)*h2:0,convexity=convexity,slices=is_undef(slices)?slices:max(1,slices/hc*h2),$fn=0,segments=segments){
      $fn=ifn;
      children();
      }
    }

    //center
    Tz(h2-lap[0]){
      //$idx=is_undef($idx)?0:$idx;
      $tab=is_undef($tab)?1:b($tab,false)+1;
      rotate(twist/2)linear_extrude(hc+lap[0]+lap[1],scale=scaleCenter,convexity=convexity,twist=twist,slices=slices,center=false,segments=segments)children();
    }
  } else {
      union(){
    $idx=true;
    //capoben
    if(h22)T(z=h-h22)rotate(-twist/2)linear_extrude(h22+(end[1]?lap[1]:0),scale=scale2,twist=twistcap[1]?twist/(hc)*h22:0,convexity=convexity,slices=max(1,slices/hc*h22),$fn=0)scale(scaleCenter){
      $fn=ifn;
      children();
      }
    
    //capunten
    if(h2)Tz(h2)rotate(twist/2)mirror([0,0,1])linear_extrude(h2+(end[0]?lap[0]:0),scale=scale,twist=twistcap[0]?-twist/(hc)*h2:0,convexity=convexity,slices=max(1,slices/hc*h2),$fn=0){
      $fn=ifn;
      children();
      }
    }

    //center
    Tz(h2-lap[0]){
      //$idx=is_undef($idx)?0:$idx;
      $tab=is_undef($tab)?1:b($tab,false)+1;
      rotate(twist/2)linear_extrude(hc+lap[0]+lap[1],scale=scaleCenter,convexity=convexity,twist=twist,slices=slices,center=false)children();
    }
  
  }
    
    
    if(end[0]){ // Ende Unten
    $idx=true;
     rotate(twist/2+(twistcap[0]?twist/(hc)*h2:0))rotate(sign(end[0])>+0?[-90,0,-90]:[-90,0,0]) RotEx(cut=true,grad=180,fn=fn)scale(scale)rotate(sign(end[0])>0?90:0)children();
        }
     if(end[1]){ // Ende Oben
    $idx=true;
         Tz(h)rotate(-twist/2-(twistcap[1]?twist/(hc)*h22:0))rotate(sign(end[1])>+0?[-90,0,-90]:[-90,0,0])RotEx(cut=true,grad=-180,fn=fn)
        scale(scale2*scaleCenter)rotate(sign(end[1])>0?90:0)children();
     }

    }
    MO(!$children);

}








}//fold // // ΔΔ Generator ΔΔ \ \\
{//fold // \∇∇ Basic Objects ∇∇/ //


/*
points=[[0,0,-2],for(i=[0:35])[sin(i*10),cos(i*10),0],for(i=[0:35])[sin(i*10),cos(i*10),5],[0,0,7]];
points1=[for(i=[0:36])[sin(i*10),cos(i*10),0]*1.5,for(i=[0:36])[sin(i*10),cos(i*10),5],for(i=[0:36])[sin(i*10)*0.75,cos(i*10)*1.5,10]];
pointsE1=[[0,0,-2],for(i=[0:35])[sin(i*10),cos(i*10),0],for(i=[0:35])[sin(i*10),cos(i*10),5]];
pointsE2=[for(i=[0:35])[sin(i*10),cos(i*10),0],for(i=[0:35])[sin(i*10),cos(i*10),5],[0,0,7]];

  
//Points(points1,loop=36,start=36*2);
//echo(points1[36]);
union(){
PolyH(points,loop=36,pointEnd=true,end=true,name="pointy");
T(10)PolyH(pointsE1,loop=36,pointEnd=1,end=true,name="point∇");
T(-10)PolyH(pointsE2,loop=36,pointEnd=2,end=true,name="pointΔ");//WIP
T(0,-10)PolyH(points1,loop=37,pointEnd=0,end=true);
T(0,10)PolyH(octa(5));
}
// */

// PolyH(concat([[0,0,-10]],kreis(rand=0,z=0,endPoint=false),[[0,0,10]]),fn,pointEnd=true);


/** \page Generator
module PolyH() creates a polyhedron
\name PolyH
\brief creates a polyhedron
 ## Example
points=[[0,0,-2],for(i=[0:35])[sin(i*10),cos(i*10),0],for(i=[0:35])[sin(i*10),cos(i*10),5],[0,0,7]];
PolyH(points,loop=36,pointEnd=true,end=true);
 * \param points points for polyhedron
 \param loop number of points per loop (hull if undef)
 \param end top bottom faces
 \param pointEnd if single point start, end or both (1,2,true)
 \param convexity convexity
 \param faceOpt  Quad or Tri faces
 \param flip  flip normals

*/

module PolyH(points,loop,end=true,pointEnd=false,convexity=5,faceOpt=+0,flip=true,name,help){
loop=is_undef(loop)||loop<3?1:loop;
points=assert(!is_undef(points))points;
lp=len(points);
loops=pointEnd?pointEnd==1||pointEnd==2?(lp-1)/loop:
                                        (lp-2)/loop:
               lp/loop;
  
fBottom=pointEnd==2||b(pointEnd,bool=true)==false?[[for(i=flip?[loop -1:-1:0]:[0:loop-1])i]]:[];
fTop=   pointEnd==1||b(pointEnd,bool=true)==false?[[for(i=flip?[0:loop -1]:[loop-1:-1:0])i+lp-(loop)]]:[];

fBodyFlip=loops>1?[for(lev=[0:loops -2],i=[0:loop -1])[
  i          +loop*lev,
  (i +1)%loop+loop*lev,
  (i +1)%loop+loop*(lev+1),
  i          +loop*(lev+1)
]]:[];

fBody=loops>1?[for(lev=[0:loops -2],i=[0:loop -1])[
  i          +loop*(lev+1),
  (i +1)%loop+loop*(lev+1),
  (i +1)%loop+loop*lev,
  i          +loop*lev
]]:[];


fBody1=loops>1?[for(lev=[0:loops -2],i=[0:loop -1])each[[
  
  i          +loop*lev,
  (i +1)%loop+loop*lev,
  //(i +1)%loop+loop*(lev+1),
  i          +loop*(lev+1)
],
[
  //i          +loop*lev,
  (i +1)%loop+loop*lev,
  (i +1)%loop+loop*(lev+1),
  i          +loop*(lev+1)
]]
]:[];

fBody2=loops>1?[for(lev=[0:loops -2],i=[0:loop -1])each[[
  
  //i          +loop*(lev+1),
  i          +loop*lev,
  (i +1)%loop+loop*lev,
  (i +1)%loop+loop*(lev+1),
  
],
[
  i          +loop*lev,
  //(i +1)%loop+loop*lev,
  (i +1)%loop+loop*(lev+1),
  i          +loop*(lev+1)
]]
]:[];



faces=loop>1?end?concat(
                  fBottom,
                  pointEnd==2?[for(i=[0:loop -1])[lp-i -2,lp-1,lp-(i+1)%loop -2]]:fTop,
                  faceOpt?faceOpt==-1||faceOpt==2?fBody2:fBody1:flip?fBodyFlip:fBody
                ):
                faceOpt?faceOpt==-1||faceOpt==2?fBody2:fBody1:flip?fBodyFlip:fBody:
            [[for(i=[0:lp-1])i]]
;

pointyFaces=(pointEnd==true||pointEnd==1)&&loops>=1?[ 
if(pointEnd==true||pointEnd==1) for(i=[0:loop -1])[(i + 1)%loop + 1,i +1,0],//bottom
if(pointEnd==true||pointEnd==2) for(i=[0:loop -1])[lp-i -2,lp-1,lp-(i+1)%loop -2],//top  
if(loops>1)for(lev=[0:loops -2],i=[0:loop -1])let(pE=1)[
  pE + i          +loop*lev,
  pE + (i +1)%loop+loop*lev,
  pE + (i +1)%loop+loop*(lev+1),
  pE + i          +loop*(lev+1)
]
]:[];


if(loop>1)polyhedron(points,(pointEnd==true||pointEnd==1)&&loop>1?pointEnd==1?concat(pointyFaces,fTop):
                                                                              pointyFaces:
                                                                 faces,convexity=convexity);
  else hull()polyhedron(points,faces,convexity=convexity);
    
InfoTxt("PolyH",["loops",loops,"points",lp],loop>1?name:false);
InfoTxt("PolyH using hull—",["points",lp],loop==1?name:false);
  

HelpTxt("PolyH",["points",[[0,0,0],[1,2,3]],"loop",loop,"end",end,"pointEnd",pointEnd,"convexity",convexity,"faceOpt",faceOpt,"flip",flip,"name",name],help);
  
}

/** \page Objects \name Isosphere
Isoshpere creates an isosphere
\param r radius
\param d  diameter (optional)
\param q  resoluton
\param help help
*/
//Isosphere(10);

module Isosphere(r=1,d,q=70,help){
  r=is_undef(d)?r:d/2;
/* Kogan, Jonathan (2017) "A New Computationally Efficient Method for Spacing n Points on a Sphere," Rose-Hulman Undergraduate Mathematics Journal: Vol. 18 : Iss. 2 , Article 5.
    Available at: https://scholar.rose-hulman.edu/rhumj/vol18/iss2/5 */
    function sphericalcoordinate(x,y)=  [cos(x  )*cos(y  ), sin(x  )*cos(y  ), sin(y  )];
    function NX(n=70,x)= 
    let(toDeg=57.2958,PI=acos(-1)/toDeg,
    start=(-1.+1./(n-1.)),increment=(2.-2./(n-1.))/(n-1.) )
    [ for (j= [0:n-1])let (s=start+j*increment )
    sphericalcoordinate(   s*x*toDeg,  PI/2.* sign(s)*(1.-sqrt(1.-abs(s)))*toDeg)];
    function generatepoints(n=70)= NX(n,0.1+1.2*n);
    
    a= generatepoints(q);
    //scale(r)hull()polyhedron(a,[[for(i=[0:len(a)-1])i]]);
    scale(r)hull()polyhedron(a,[for(i=[0:len(a)-1])[0,1,i]]);
      
HelpTxt("Isosphere",["r",r,"q",q],help);
}

// Was KreisSeg( Was TorusSeg(
module RingSeg(
grad=90,
size=4,
h,
rad=1.0,
r=10,
spiel=.5,
fn=fn,
fn2,
name,
help
){
  HelpTxt("RingSeg",["grad",grad,"size",size,"h",h,"rad",rad,"r",r,"spiel",spiel,"fn",fn,"fn2",fn2,"name",name],help);  
  $info=name;  
    rad2=rad+spiel;//spiel

h=assert(is_num(size))is_undef(h)?size:h;
   winkel2=asin(rad2/(r+size/2-rad));
   winkel1=asin(rad2/(r-size/2+rad));

fn2=is_undef(fn2)?fn:fn2;
fnS=fn2;
  
union(){
  $helpM=false;
difference(){
   Torus(grad=grad,end=+0,trx=r,d=size,fn=fn)Quad(size,h,r=rad,fn=fn2);
  //base part
   linear_extrude(h+5,center=true,convexity=5)polygon([
     [0,0],
     (r-size/2 +rad) *[sin(90-winkel1), cos(90-winkel1)],// mittelpunkt sphere1
     (r+size/2 -rad) *[sin(90-winkel2), cos(90-winkel2)],// mittelpunkt sphere2
     (r+size/2 +5)   *[sin(90-winkel2), cos(90-winkel2)],
     [r+size/2 +5,-rad],
   ]);

// angeled part
   linear_extrude(h+5,center=true,convexity=5)polygon([
     [0,0],
     (r-size/2 +rad) *[sin(-grad +90 +winkel1), cos(-grad +90 +winkel1)],// mittelpunkt sphere1
     (r+size/2 -rad) *[sin(-grad +90 +winkel2), cos(-grad +90 +winkel2)],// mittelpunkt sphere2
     (r+size/2 +5)   *[sin(-grad +90 +winkel2), cos(-grad +90 +winkel2)],
     (r+size/2 +5)   *[sin(90-grad-5),cos(90-grad-5)],
   ]); 
}

//End cabs
    hull(){
       rotate(asin(rad2/(r+size/2-rad))) T(r+size/2-rad)MKlon(tz=h/2-rad)OctaH(rad,n=fnS);
       rotate(asin(rad2/(r-size/2+rad))) T(r-size/2+rad)MKlon(tz=h/2-rad)OctaH(rad,n=fnS);
    }

    hull(){
       rotate(grad-asin(rad2/(r+size/2-rad))) T(r+size/2-rad)MKlon(tz=h/2-rad)OctaH(rad,n=fnS);
       rotate(grad-asin(rad2/(r-size/2+rad))) T(r-size/2+rad)MKlon(tz=h/2-rad)OctaH(rad,n=fnS);
    }
  }
}


/** \name Ring \page Objects
Ring() creates a ring
\param h height 0 for 2D
\param dicke rim thickness
\param d,r diameter radius
\param id ir inner diameter/radius
\param grad  angle
\param rcenter center rim on d/r
\param center center h
\param fn,fs fraqment number, size
\param name name
\param 2D makes a 2D ring
\param help help
\param cd  if false d or r (old - use rcenter instead)
*/
//Ring(r=10,ir=5,rcenter=0);


module Ring(h=5,dicke,d=10,r,id=6,ir,grad=360,rcenter,center=false,fn,fs=fs,name,2D=0,help,cd=1,rand){
    
    dicke=is_undef(dicke)?rand:dicke;
    id=is_undef(id)?d-dicke*2:id;
    r=is_undef(r)?d/2:r;
    ir=is_undef(ir)?id/2:ir;
    rcenter=is_undef(rcenter)?!abs(cd):rcenter;
    rand=is_undef(dicke)?rcenter?(r-ir)*2:r-ir:dicke*sign(cd==0?1:cd);
    2D=is_parent(parent= needs2D)?true:2D;
    if(2D||!h)Kreis(rand=rand,rcenter=rcenter,r=r,grad=grad,fn=fn?fn:undef,fs=fs,rot=0,center=center,name=0,help=0);
        else rotate([h>0?0:180])linear_extrude(abs(h),center=center,convexity=5)Kreis(rand=rand,rcenter=rcenter,r=r,grad=grad,center=center,fn=fn?fn:undef,fs=fs,rot=0,name=0,help=0);
    
InfoTxt("Ring",[str("Aussen∅= ",rcenter?d+abs(rand):rand>0?d:d-rand*2,"mm — Mitte∅= ",rcenter?d:d-rand,"mm — Innen∅"),str(rcenter?d-abs(rand):rand>0?d-(rand*2):d,"mm groß — Rand=",rand,"mm und ",2D||!h?"2D":str(h," hoch") )],name);    
 
HelpTxt("Ring",[
    "h",h,
    "dicke",dicke,
    "d",d,
    "r",r,
    "id",id,
    "ir",ir,
    "grad",grad,
    "rcenter",rcenter,
    "center",center,
    "fn",fn,
    "fs",fs,
    "name",name,
    "2D",2D,
    "cd",cd,
    ],help);

}

module HypKehleD(grad=40,steps=15,l=10,l2,l3,d=2.5,d2,fill=false,exp=1,fn=24,name,help){
    exp=is_num(exp)?[exp,exp]:is_bool(exp)?[1,1]:exp;
    d3=is_undef(d3)?d:d3;
    l= is_list(l)?len(l)==3?l:
                            concat(l,l[0]):
                  [l,l,l];

    l3=is_undef(l3)?l[2]:l3;
    l2=is_undef(l2)?l[1]:l2;
    HypKehle(grad=90-grad,l=l2,l2=l3,steps=steps,d1=d,d2=d2,exp=exp[1],fill=fill,fn=fn);
    R(0,180)HypKehle(grad=90+grad,l=l[0],l2=l3,d1=d,d2=d2,steps=steps,exp=exp[0],fill=fill,fn=fn);
  
  HelpTxt("HypKehleD",["grad",grad,"steps",steps,"l",l,"l2",l2,"l3",l3,"d",d,"d2",d2,"fn",fn,"fill",fill,"exp",exp,"name",name],help);
}



module HypKehle(l=15,grad=90,d1=3,d2,l2,steps=20,fn=24,fill=false,exp=1,center=false,name,help){
   
  rot=1;
    d2=is_undef(d2)?d1:d2;
  $d=d1;
  $r=d1/2;
    l2=is_undef(l2)?l:l2;
    $info=false;
    $idxON=false;
  $tab=is_undef($tab)?1:b($tab,false)+1;
  
R(center?-grad/2:0)
for(i=[0:steps-1]){
  Color(1/(steps*1.5)*i,$idxON=false)hull()
  union(){
    $idx=i;
    Tz(pow(i,exp)*l/pow(steps-1,exp))R((grad +(180-grad)/(steps-1)*i)*rot +(rot?0:180))
       if($children)linear_extrude(.1,scale=0)children(0);
       else rotate(180/fn)cylinder(.1,d1=d1,d2=0,$fn=fn);
    
    if(fill){
      $info=false;
      if($children)R(0,90)RotEx(cut=true,fn=fn)rotate(90)children();
       else Isosphere(d=is_num(fill)?fill:max(d1,d2),$fn=fn);
    }
      
   Color($idxON=false) R(grad)Tz(pow((steps-1)-i,exp)*l2/pow(steps-1,exp)) R( (180-grad)/(steps-1)*i*rot +180)
    if($children){
      $info=$children>1?1:0;
      linear_extrude(.1,scale=0)mirror([0,1])children($children>1?1:0);
    }
    else rotate(180/fn)cylinder(.1,d1=d2,d2=0,$fn=fn);
  }
}
if(!fill&&!$children)R(0,0,90)Isosphere(d=is_num(fill)?fill:max(d1,d2),$fn=fn);
HelpTxt("HypKehle",["l",l,"grad",grad,"d1",d1,"d2",d2,"l2",l2,"steps",steps,"fn",fn,"fill",fill,"exp",exp,"center",center,"name",name],help);
}

/** \name Rohr \page Objects
Bogen() creates a bended pipe or children
\param grad angle
\param rad bend radius
\param l,l1,l2 straight length l⇒ [l1,l2]
\param fn fn2 fraqments
\param tcenter tangent
\param center centern
\param lap  overlap
\param d diameter (if no children)
\param messpunkt show bend center

*/

//Rohr()Quad();

module Rohr(grad=90,rad=5,d=8,l,l1=10,l2=12,fn=fn,fn2=fn,fs=fs,dicke=+1,rand,name,center=true,messpunkt=messpunkt,lap=minVal,spiel,help)
{
dicke=is_num(rand)?rand:dicke;
lap=is_num(spiel)?-spiel:lap;

    Bogen(grad=grad,rad=rad,l=l,l1=l1,l2=l2,fn=fn,name=name,help=0,center=center,messpunkt=messpunkt,lap=lap,fs=fs){
    if($children)Rand(dicke)children();
    else polygon( kreis(r=d/2,rand=rand,fn=fn2));
    }
    
    HelpTxt(titel="Rohr",string=["grad",grad,"rad",rad,"d",d,"l",l,"l1",l1,"l2",l2,"fn",fn,"fn2",fn2,"fs",fs,"dicke",dicke,"name",name,"center",center,"messpunkt",messpunkt,"spiel",spiel],help=help);
    InfoTxt(name="Rohr",string=concat(dicke>0?["ID",d-dicke*2]:["OD",d-dicke*2],["d",d]),info=name);

}


module Kugelmantel(d=20,rand=n(2),fn=fn,help)
{
    difference()
    {
        sphere(d=d,$fn=fn);
        sphere(d=d-2*rand,$fn=fn);
        
    }
    
HelpTxt("Kugelmantel",["d",d,
    "rand",rand, 
    "fn",fn,
],help);
}

/** \page Objects
\name Kegelmantel
Kegelmantel() creates a cone blanket 
\param d,d2  diameter
\param v, grad  ratio or angle 
\param h  height optional to d2
\param rand wallthickness horizontal
\param loch center hole
\param center center
\param fn fragments
\param name,help  name,help
*/
 //Kegelmantel(h=3,rand=-1);
 //Kegelmantel(rand=1);


module Kegelmantel(d=10,d2=5,v=1,rand=n(2),loch=4.5,grad=0,h=0,center=false,fn=0,fs=fs,name,help)
{
    v=grad?tan(grad):v;
  translate([0,0,center?d>d2?(d2-d)/4*v:(d-d2)/4*v:0])  difference()
    {
       if(rand>0) Kegel(d1=d,d2=d2,v=v,h=h,name=name,fn=fn,fs=fs);
       if(rand<0) Kegel(d1=d-rand*2,d2=d2-rand*2,v=v,h=h,name=name,fn=fn,fs=fs);
       //T(z=-.001) Kegel(d1=d-2*rand,d2=0,v=v,n=0);
       if(d2<d)T(z=-abs(rand)*v) Kegel(d1=rand>0?d:d-rand*2,d2=0,v=v,name=0,fn=fn,fs=fs);
       if(d<d2)T(z=-d2/2*v+((d2-d)/2*v)+abs(rand)*v) Kegel(d1=0,d2=rand>0?d2:d2-rand*2,v=v,name=0,fn=fn,fs=fs); 
       if(loch>0)cylinder(1000,d=loch,center=true,$fn=fn,$fs=fs);
    }
   InfoTxt("Kegelmantel",["wandstärke", sin(atan(v))*rand],name);
   HelpTxt("Kegelmantel",[
    "d",d,
    "d2",d2,
    "v",v,
   "rand",rand,
   "loch",loch,
   "grad",grad,
   "h",h,
   "center",center,
   "fn",fn,
   "fs",fs,
   "name",name],
   help);
    
}


module Freiwinkel(w=60,h=1)
 T(0,+1.0){
  R(z=w/2-90) T(-6,+0,2.0)minkowski()
            {
                cube([20,5,h],false);
                sphere(0.8,$fn=fn);
            }    
   R(z=-w/2+90) T(-14,+0,2.0)minkowski()
            {
                cube([20,5,h],false);
                sphere(0.8,$fn=fn);
            }      

 }

 

module Twins(h=1,d,d11=10,d12,d21=10,d22,l=20,r=0,fn=fn,center=0,sca=+0,2D=false,help)
{
    d11=d?d:d11;
    d12=d?d:is_undef(d12)?d11:d12;
    d21=d?d:d21;
    d22=d?d:is_undef(d22)?d21:d22;
    
    2D=h?2D:true;
    
 if(!2D)   rotate([0,0,center?r:0])translate([center?-l/2:0,0,0]){
    rotate([0,-sca,0])cylinder(h,d11*.5,d12*.5,$fn=fn);
    rotate([0,0,center?0:r])translate([l,0,0])rotate([0,sca,0])cylinder(h,d21*.5,d22*.5,$fn=fn); }
 
 if(2D)   rotate([0,0,center?r:0])translate([center?-l/2:0,0,0]){
    rotate([0,-sca,0])circle(d=d11,$fn=fn);
    rotate([0,0,center?0:r])translate([l,0,0])rotate([0,sca,0])circle(d=d21,$fn=fn); } 
    
HelpTxt("Twins",["h",h,"d",d,"d11",d11,"d12",d12,"d21",d21,"d22",d22,"l",l,"r",r,"fn",fn,"sca",sca,"2D",2D],help);
}



module Torus2(m=5,trx=10,a=1,rq=1,d=5,w=2,name,new=true,help)//m=feinheit,trx = abstand mitte,rq = sin verschiebung , a=amplitude, w wellen
{

//if(new&&w==2)rotate(90/w)WaveEx(grad=360,trx=trx-a/2*1,try=trx+a/2*1,f=w,tf=w,fv=0,tfv=0,r=d/2,ta=a/2,a=-rq/2);
if(new)rotate(-90/w)WaveEx(grad=360,trx=trx,try=trx,f=w,tf=-w,fv=0,tfv=180,r=d/2,ta=a,a=rq/2,fn=360/m);    

if(!new)echo("<H3> <font color=red> For Torus2 use 'new=true' (WaveEx)");
Echo("obsolete Torus2 use WaveEx()",color="red",useVersion>23);
if(new)echo("<H4> <font color=green>Torus2 is using WaveEx");    
if(!new)rotate ([0,0,0])for (i=[0:m:360])
    { 

        hull()
        {
        rotate ([0,0,i])translate([trx+(sin(w*i)*a),0,0])rotate([90,0,0])cylinder(.01,d1=sin(w*i)*rq+d,d2=0,$fn=200/m,center=false);
            
        rotate ([0,0,i-m])translate([trx+(sin(w*(i-m))*a),0,0])rotate([90,0,0])cylinder(.01,d1=sin(w*(i-m))*rq+d,$fn=200/m,d2=0,center=false);
        } 
    }
 

 InfoTxt("Torus2",["Wellen",w,"amplitude",a,"Radius",trx],name);
 HelpTxt("Torus2",["m",m,"trx",trx,"a",a,"rq",rq,"d",d,"w",w,"name",name],help);
}


/** \name Kegel
\page Objects
Kegel() creates a cone
\param d or d1  base diameter
\param d2 top diameter
\param v  slope
\param grad  slope in degree
\param h height (optional)
\param r1,r2  optional ⇒ d1,d2
\param rad edge radius
\param x0  center can move outside for negative form
\param lap overlap extrusion
\param fn,fs fragments, fragment size
\param center center
\param name,help  name help
*/

//Kegel(rad=[.5,1],d=8,grad=53,d2=0.1,center=+0);

//Kegel(rad=0.2*[1,1,1,1],x0=2,d=10,d2=5);

//Kegel(5,2,rad=-[.5,.25],lap=[1,1]);

//Kegel(5,2,rad=[.5,-.25],lap=[0,+1],2D=1);


module Kegel(d,d2=0,d1,v=1,grad=0,h=0,r1,r2,rad=0,x0=0,lap=0,fn=0,fs=fs,center=false,2D=false,name,help)
{

2D=is_parent(needs2D)?true:2D;
lap=is_list(lap)?lap:[lap,lap];
dHelp=d?d:d1?d1:r1?2*r1:0;
r2=r2?r2:d2?d2/2:0;
v=grad?min(1000,tan(grad)):h&&r2?h/(dHelp/2-r2):v;
d2=h&&(is_num(d)||is_num(d1)||is_num(r1))?h/-v*2+(is_num(r1)?2*r1:is_num(d)?d:d1):is_num(r2)?2*r2:d2;
d1=is_undef(d1)&&is_undef(d)&&is_undef(r1)&&h?h/v*2+(is_num(r2)?2*r2:d2):is_num(r1)?r1*2:is_undef(d1)?is_num(d)?d:0:d1;
height=abs((d1-d2)/2*v);

rList=is_list(rad)?concat(rad[0],rad[1],rad[2]?min(height,rad[2]):0,rad[3]?min(height,rad[3]):0)
                  :[rad,rad,0,0];
Echo(str("rad[2]+rad[3]>height ",rad[2],"+",rad[3],"=",rad[2]+rad[3],">",height),color="redring",condition=rad[2]+rad[3]>height);

x0=is_num(x0)?(x0<min(d1,d2)/2||x0>max(d1,d2)/2)&&x0>0?[x0,x0]:[0,0]:x0;

deg=grad?grad:atan(v);

c=abs(max(d1,d2)-(max(x0)+rList[d1>d2?2:3])*2);
hc=abs(c/2*v);
ri=c*hc/(2*Hypotenuse(c/2,hc)+c);


rLim=[ min(ri, height) , min(height, abs(min(d1,d2)/2-max(x0)-rList[d1>d2?3:2])*(1+tan(abs(90-deg))) ) ];


rad=[min( rList[0],rLim[d1>d2?0:1] ), min( rList[1],rLim[d1>d2?1:0] ), rList[2], rList[3] ];


pointsEdge=[
[x0[0],0],[d1/2,0],
[d2/2,height],[x0[1],height]
]-[for([0:3])[0,1]*(center?height/2:0)];


// with lap
pointsEdgeLap=[
[x0[0],-lap[0]],if(lap[0])[d1/2,-lap[0]], [d1/2,0],
[d2/2,height],if(lap[1])[d2/2,height+lap[1]], [x0[1],height+lap[1]]
]-[for([0:5])[0,1]*(center?height/2:0)];

// for negative r  (TODO calc x1 and x2 )
pointsEdge2=
let(r1=rad[0],r2=rad[1], x1=r1<0?max(d2,d1)/2+abs(r1):d1/2, x2=r2<0?max(d1,d2)/2+abs(r2):d2/2 )
[
[x0[0],-lap[0]],if(lap[0])[x1,-lap[0]],if(r1<0)[x1,0],[d1/2,0],
[d2/2,height],if(r2<0)[x2,height],if(lap[1])[x2,height+lap[1]],[x0[1],height+lap[1]]
]-[for([0:7])[0,1]*(center?height/2:0)];


points=min(rad)<0?polyRund(pointsEdge2,r=[rad[2],if(lap[0])0,if(rad[0]<0)0, abs(rad[0]), abs(rad[1]),if(rad[1]<0)0,if(lap[1])0, rad[3]],fs=fs,minF=5,fn=fn)
        :max(lap)>0&&max(rad)>0?polyRund(pointsEdgeLap,r=[rad[2],if(lap[0])0, abs(rad[0]), abs(rad[1]),if(lap[1])0, rad[3]],fs=fs,minF=5,fn=fn)
        :max(rad)>0?polyRund(pointsEdge,r=[rad[2], rad[0], rad[1], rad[3]],fs=fs,minF=5,fn=fn)
        :max(lap)?pointsEdgeLap:pointsEdge;

/*
ideg=[deg+90,deg];
points2=[ WIP
[0,0],
each arc(r=rad[0],deg=ideg[0],t=[d1/2-(rad[0]*cos(ideg[0])),rad[0] ],rot=-90,fn=fs2fn(rad[0],grad=ideg[0],fs=fs,minf=5)),
each arc(r=rad[1],deg=ideg[1],t=[d2/2,height-rad[1] ],rot=90-deg,fn=fs2fn(rad[1],grad=ideg[0],fs=fs,minf=5)),
[0,height]
];
*/


if(2D&&(d1||d2))polygon(points);
 else {
  if((max(rad)||min(rad)||max(lap))&&(d1||d2) || (d1||d2)&&max(x0)){
    RotEx(fn=fn?fn:fs2fn(r=max(d1,d2)/2,fs=fs),fs=fs)polygon(points);
  }else {

  if(d1-d2&&!(d2<0))cylinder (abs((d1-d2)/2*v),d1=d1,d2=d2,$fn=fn,$fs=fs,center=center);
  //if(d2>d1)cylinder (abs((d2-d1)/2*v),d1=d1,d2=d2,$fn=fn,center=center);
  if(d1==d2&&d2!=0)cylinder (h?h:10,d1=d1,d2=d2,$fn=fn,$fs=fs,center=center);
  }
  if(!d1&&!d2&&is_undef(r1))color("magenta")%cylinder(5,5,0,$fn=fn,$fs=fs,center=center);
}

 if(d2<0||d1<0)Echo(str("‼ negativ ∅",name,"  Kegel d1=",negRed(d1)," d2=",negRed(d2)),color="red");    
 InfoTxt("Kegel",["höhe",height,"Steigung",str(v*100,"/",1/v*100,"% ",atan(v),"° /",90-atan(v),"°"),"Spitzenwinkel",str(2*(90-atan(v)),"°"),"d1",negRed(d1),"d2",negRed(d2)],name);
     
 HelpTxt("Kegel",["d",d,"d2",d2,"d1",d1,"v",v,"grad",grad,"h",h,"r1",r1,"r2",r2,"rad",rad,"x0",x0,"fn",fn,"center",center,"2D",2D,"name=",name],help);
}


module MK(d1=12,d2=6,v=19.5,fn=fn)
{
//Basis
// Obererdurchmesser
//kegelverjüngung
cylinder ((d1-d2)/2*v,d1=d1,d2=d2,$fn=fn);
 echo(str("»»»››› Konushöhe=",(d1-d2)/2*v));
}

/// Fillet
//Kehle(dia=-20,rad=1);

//Kehle(rad=5);



module Kehle(rad=2.5,dia,r,l=20,angle=360,grad=0,a=90,ax=90,fn=0,fn2,fs=fs,fa=fa,r2=0,spiel,lap=spiel,center=false,2D=false,end=false,fase=false,fillet,help)
{
  2D=is_parent(needs2D)?true:2D;
    fillet=is_list(fillet)?fillet:[fillet,fillet];
    fase=is_bool(fase)?fase?1:0:fase;
    end=is_bool(end)?end?1:0:end;
    angle=grad?grad:angle;
    spiel=is_undef(spiel)?is_list(lap)?lap
                                      :[lap,lap]
                         :is_list(spiel)?spiel
                                        :[spiel,spiel];
    center=center?true:false;
    dia=is_undef(r)?dia:2*r;
  $info=false;
    
    if(is_undef(dia)&&l&&!2D&&rad>0){
        difference(){
            Tz(fase&&$preview?.05:0)scale([1,1,sign(l)])linear_extrude(height=abs(l) -(fase&&$preview?.1:0),$fn=fn,convexity=5,center=center)
            {
                difference()
                {
                   translate([-spiel[0],-spiel[1]]) square([sin(-90+ax)*rad+rad+spiel[0],sin(a-90)*rad+rad+spiel[1]]);
                    T(rad,rad)rotate(r2)circle(rad,$fn=is_undef(fn2)?round(fs2fn(r=rad,minf=16,fs=fs,grad=360,fa=fa)/4)*4:fn2);
                }
            }
        if(fase)T(x=rad,y=rad)Tz(center?-l/2:0)Kegel(d2=0,d1=Hypotenuse(rad+spiel[0],rad+spiel[1])*2,fn=fn2,fs=fs);
        if(fase>1)T(x=rad,y=rad)Tz(center?l/2:l)R(180)Kegel(d2=0,d1=Hypotenuse(rad+spiel[0],rad+spiel[1])*2,fn=fn2,fs=fs);
        }
        
    if(is_num(fillet[0]))intersection(){
        Tz(center?-l/2:0)R(45,90)T(0,-fillet[0])RotEx(90,cut=true,fn=fn/360*90,fs=fs)T(fillet[0])rotate(-45)Kehle(2D=true,a=ax,ax=a,fn2=fn2,fs=fs,rad=rad,spiel=spiel); 
        T(-spiel[0],-spiel[1],-500)cube([rad+spiel[0],rad+spiel[1],600]);
    }
    if(is_num(fillet[1]))intersection(){
       Tz(center?l/2:l)R(-45,-90)T(0,-fillet[1])RotEx(90,cut=true,fn=fn/360*90,fs=fs)T(fillet[1])rotate(-45)Kehle(2D=true,a=a,ax=ax,fn2=fn2,fs=fs,rad=rad,spiel=spiel); 
        T(-spiel[0],-spiel[1],l-100)cube([rad+spiel[0],rad+spiel[1],600]);
    }
    
        
        
        
       if(end==2)R(x=-90)T(y=center?0:-l/2) MKlon(ty=l/2)RotEx(grad=90,cut=1,fn=fn,fs=fs)Kehle(a=a,ax=ax,rad=rad,spiel=spiel,2D=true,fn2=fn2,fs=fs,help=false);
       if(end==-2)R(x=-90)T(y=center?0:-l/2) MKlon(ty=l/2)R(90,0,90)RotEx(grad=90,cut=1,fn=fn,fs=fs)Kehle(a=ax,ax=a,rad=rad,spiel=spiel,2D=true,fn2=fn2,fs=fs);    
       if(end==1)Tz(center?-l/2:0)R(-90)RotEx(grad=90,cut=1,fn=fn,fs=fs)Kehle(a=a,ax=ax,rad=rad,spiel=spiel,2D=true,fn2=fn2,fs=fs);     
    }
    
    if(2D&&rad>0)translate([dia/2,0])difference(){
           translate([-spiel[0],-spiel[1]]) square([sin(-90+ax)*rad+rad+spiel[0],sin(a-90)*rad+rad+spiel[1]]);
            T(rad,rad)rotate(r2)circle(rad,$fn=is_undef(fn2)?round(fs2fn(r=rad,minf=16,fs=fs,grad=360)/4)*4:fn2,$fs=fs);
        }
// dia   
    if(!is_undef(dia)&&!2D&&rad>0){
      rotate(center?-180-angle/2:0)difference(){
        rotate(fase&&$preview?.05:0)rotate_extrude(angle=angle-(fase&&$preview?.1:0),$fn=fn?fn:dia?fs2fn(minf=24,r=dia/2,fs=fs,fa=fa):0,convexity=5,$fs=fs,$fa=fa)
            difference()
            {
                T(dia/2)translate([-spiel[0],-spiel[1]])square([sin(-90+ax)*rad+rad+spiel[0],sin(a-90)*rad+rad+spiel[1]]);
                T(dia/2)T(rad,rad)rotate(r2)circle(rad,$fn=is_undef(fn2)?round(fs2fn(r=rad,minf=16,fs=fs,grad=360,fa=fa)/4)*4:fn2,$fs=fs);
                if(dia>-rad*2)T(-200,-100)square(200);
            }
          if(fase&&angle)T(dia/2+rad,z=rad)R(-90*sign(dia))Kegel(d2=0,d1=Hypotenuse(rad+spiel[0],rad+spiel[1])*2,fn=fn2,fs=fs);
          if(fase>1&&angle)rotate(angle)T(dia/2+rad,z=rad)R(90*sign(dia))Kegel(d2=0,d1=Hypotenuse(rad+spiel[0],rad+spiel[1])*2,fn=fn2,fs=fs);    
        }


    
    if(angle)rotate(center?-180-angle/2:0){
         if(is_num(fillet[0]))intersection(){// fillet[0]
            T(dia/2,minVal*sign(dia))R(45,0,-90)T(0,-fillet[0])rotate(dia<0?[0,0,90]:[0])RotEx(90,cut=true,fn=fn/360*90,fs=fs)T(fillet[0])rotate(-45)Kehle(2D=true,a=a,ax=ax,fn2=fn2,rad=rad,spiel=spiel,fs=fs); 
            RotEx(fn=fn,fs=fs)T(dia/2)translate([-spiel[0],-spiel[1]])square([rad+spiel[0],rad+spiel[1]]);
    }
        if(is_num(fillet[1]))intersection(){// fillet[1]
            rotate(angle)T(dia/2,-minVal*sign(dia))rotate([135,0,90])T(0,-fillet[1])R(z=dia<0?90:0)RotEx(90,cut=true,fn=fn/360*90,fs=fs)T(fillet[1])rotate(-45)Kehle(2D=true,a=ax,ax=a,fn2=fn2,rad=rad,spiel=spiel,fs=fs); 
            RotEx(fn=fn,fs=fs)T(dia/2)translate([-spiel[0],-spiel[1]])square([rad+spiel[0],rad+spiel[1]]);       
    }   
        
     if(end>0) T(dia/2,+minVal*sign(dia)) rotate(dia<0?0:-90) RotEx(grad=90,cut=1,fn=fn)Kehle(a=a,ax=ax,rad=rad,spiel=spiel,2D=true,fn2=fn2,fs=fs);
      if(end==2) rotate(angle)T(dia/2,-minVal*sign(dia))rotate(dia<0?-90:0) RotEx(grad=90,cut=1,fn=fn)Kehle(a=a,ax=ax,rad=rad,spiel=spiel,2D=true,fn2=fn2,fs=fs); 
     if(end<0) T(dia/2,minVal*sign(dia)) rotate(-90) R(-90,dia<0?-180:-90)RotEx(grad=90,cut=1,fn=fn)Kehle(a=ax,ax=a,rad=rad,spiel=[spiel.y,spiel.x],2D=true,fn2=fn2,fs=fs);
      if(end==-2) rotate(angle)T(dia/2,-minVal*sign(dia))R(dia<0?-180:90)R(y=90) RotEx(grad=90,cut=1,fn=fn)Kehle(a=ax,ax=a,rad=rad,spiel=[spiel.y,spiel.x],2D=true,fn2=fn2,fs=fs);          
    
        
    }
    }
HelpTxt("Kehle",["rad",rad,"dia",dia,"l",l,"angle",angle,"grad",grad,"a",a,",ax=",ax,"fn",fn,"fn2",fn2,"fs",fs,"fa",fa,"r2",r2,"spiel",spiel,"center",center, "2D",2D,"end",end,"fase",fase,"fillet",fillet],help);

}



module Sinuskoerper
(
h=10,
d=33,
rand=2,
randamp=1,
amp=1.5,
w=4,
randw=4,
detail=3,
vers=0,
fill=0,
2D=0,
twist=0,
scale=1
)
{
 if(!2D)linear_extrude(h,convexity=5,twist=twist,scale=scale)for (i=[0:detail:359.9])
        
    {
        j=i+detail;
        hull()
        {
            rotate(i) T(d/2+amp*sin(i*w))circle(d=rand+randamp*sin((i+vers)*randw),$fn=36);
            rotate(j) T(d/2+amp*sin(j*w))circle(d=rand+randamp*sin((j+vers)*randw),$fn=36);
            if(fill)circle(d=d/2,$fn=36);
            
        }
        
    }
 if(2D)for (i=[0:detail:359.9])
        
    {
        j=i+detail;
        hull()
        {
           rotate(i) T(d/2+amp*sin(i*w))circle(d=rand+randamp*sin((i+vers)*randw),$fn=36);
           rotate(j) T(d/2+amp*sin(j*w))circle(d=rand+randamp*sin((j+vers)*randw),$fn=36);
            if(fill)circle(d=d/2,$fn=36);
        }
        
    }    
}




module Dreieck(h=10,ha=10,ha2=0,s=1,name,c=0,2D=0,grad=0)
{
   s=grad?tan(grad/2)*2*(sqrt(3)/2):s;  
  //echo(*2);atan(((ha/(sqrt(3)/2)*s)/2)/ha)
    
    
  r=(sqrt(3)/3)*ha/(sqrt(3)/2);
  r2=(sqrt(3)/3)*(ha2?ha2:ha)/(sqrt(3)/2);
 if(!2D)T(c?h/2:0,z=c?ha/2-r:ha-r) R(0,-90) scale([1,s,1])cylinder(h=h,r1=r,r2=r2,$fn=3); 
 if(2D)T(x=c?ha/2-r:ha-r) R(0,0) scale([1,s,1])circle(r=r,$fn=3);    
    
    
   if(name)echo(str("»»» »»» ",name," Dreieck Höhe= ", ha," Breite= ",ha/(sqrt(3)/2)*s," Winkel= ",2*atan(s/2/(sqrt(3)/2))            )); 
}




module GewindeV1(d=20,s=1.5,w=5,g=1,fn=3,r=0,gd=1.75,detail=5,tz=0,name)//depreciated
{
  
    
    difference()
    {
        children();
        color("orange")translate([0,0,tz])for (i=[0:detail:w*360])
            {
                j=i+detail;
                hull()
                {
                    R(z=i)Polar(g,(d-gd)/2,n=0)T(z=i/(360/s))R(90)R(z=r)cylinder(.1,d=gd,$fn=fn);
                    R(z=j)Polar(g,(d-gd)/2,n=0)T(z=j/(360/s))R(90)R(z=r)cylinder(.1,d=gd,$fn=fn);
                }
      
            }
    }
   
    if(name)echo(str("»»» »»» ",name," Gewinde aussen∅= ",d,"mm — Center∅= ",d-gd,"mm"));
    if(r||(fn!=3&&fn!=6)) Echo ("!!! Check Aussendurchmesser !!!",color="red");   
    
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
\param 2D  make 2D
*/
//Bogen(2D=1,lap=+0,fn=0);
//Bogen();

module Bogen(grad=90,rad=5,l,l1=10,l2=12,fn=fn,center=true,tcenter=false,name,d=3,fn2=0,fs=fs,lap=minVal,spiel,help,messpunkt=messpunkt,2D=false)
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
    2D=is_parent(needs2D)&&!$children?2D?b(2D,false):
                                       1:
                                    b(2D,false);
    
    c=sin(abs(grad)/2)*rad*2;//  Sekante 
    w1=abs(grad)/2;          //  Schenkelwinkel
    w3=180-abs(grad);        //  Scheitelwinkel
    a=(c/sin(w3/2))/2;    
    hc=grad!=180?Kathete(a,c/2):0;  // Sekante tangenten center
    hSek=Kathete(rad,c/2); //center Sekante
    bl=PI*rad/180*grad;//Bogenlänge
    
    mirror([grad<0?1:0,0,0])rotate(center?0:tcenter?-abs(grad)/2:+0)T(tcenter?grad>180?hSek+hc:-hSek-hc:0)rotate(tcenter?abs(grad)/2:0) T(center?0:tcenter?0:-rad){
    if(!2D) T(rad)R(+90,+0)Tz(-l1+ueberlapp){
      $idx=0;
      $tab=is_undef($tab)?1:b($tab,false)+1;
      color("green")   linear_extrude(l1,convexity=5)
            if ($children)mirror([grad<0?1:0,0,0])children();
            else circle(d=d,$fn=fn2);
     //color("lightgreen",.5)   T(0,0,l1)if(messpunkt&&$preview)R(0,-90,-90)Dreieck(h=l1,ha=pivotSize,grad=5,n=0);//Pivot(active=[1,1,1,0]);        
        }
    else T(rad)R(0,+0)T(0,-ueberlapp)color("green")T(-d/2)square([d,l1]);
 
    if(grad)if(!2D) rotate_extrude(angle=-abs(grad)-0,$fa = fn?abs(grad)/fn:fa, $fs = $fs,$fn=0,convexity=5)intersection(){
      $idx=1;
      $fn=fn;
      $fa=fa;
      T(rad)
            if ($children)mirror([grad<0?1:0,0,0])children();
                else circle(d=d,$fn=fn2); 
                translate([0,-500])square(1000);
            }
     else  Kreis(rand=d,grad=abs(grad),center=false,r=rad+d/2,fn=fn,fs=fs,name=0,help=0); 
      
        
     if (!2D)R(z=-abs(grad)-180) T(-rad,-ueberlapp)R(-90,180,0){
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
      
  if(!$children&&name&&!2D)Echo("Bogen missing Object! using circle",color="warning");
  
  HelpTxt("Bogen",["grad",grad,"rad",rad,"l",l,"l1",l1,"l2",l2,"fn",fn,"center",center,"tcenter",tcenter,"name",name,"d",d,"fn2",fn2,"fs",fs,"lap",lap,"messpunkt",messpunkt,"2D",2D],help);
    
}




module W5(kurv=15,arms=3,detail=.3,h=50,tz=+0,start=0.7,end=13.7,topdiameter=1,topenddiameter=1,bottomenddiameter=+2,inv=0)
{

    Polar(e=arms)for (i=[start:detail:end])
    {
        
        
        j=i+detail;
        hull()
        {
            R(z=i*kurv)T(i,0,tz*-2*h/(2*PI*(i)))R(inv*180)cylinder(h/(2*PI*(i)),d1=n(topenddiameter)+i/end*n(bottomenddiameter),d2=n(topdiameter),$fn=fn);
            R(z=j*kurv)T(j,0,tz*-2*h/(2*PI*(j)))R(inv*180)cylinder(h/(2*PI*(j)),d1=n(topenddiameter)+j/end*n(bottomenddiameter),d2=n(topdiameter),$fn=fn);
        }
    }
 

}

fonts=[
"Bahnschrift",
"Alef",
"Amiri",
"Arial",
"Caladea",
"Calibri",
"David CLM",
"David libre",
"Deja Vu Sans",
"Ebrima",
"Echolon",
"Forelle",
"Frank Ruehl CLM",
"Frank Ruhl Hofshi",
"Franklin Gothic Medium",
"Gabrielle",
"Gabriola",
"Gadugi",
"Gentium Basic",
"Gentium Book Basic",
"Georgia",
"Impact",
"Ink Free",
"Liberation Mono",
"Liberation Sans",
"Liberation Sans Narrow",
"Liberation Serif",
"Linux Biolinum G",
"Linux Libertine Display G",
"Linux Libertine G",
"Lucida Console",
"Noto Sans",
"OpenSymbol",
"Palatino Linotype",
"Politics Head",
"Reem Kufi",
"Rubik",
"SamsungImagination",
"Segoe Print",
"Segoe Script",
"Segoe UI",
"SimSun",
"Sitka Banner",
"Sitka Display",
"Sitka Heading",
"Sitka Small",
"Sitka Subheading",
"Sitka Subheading",
"Sitka Text",
"Source Code Pro",
"Source Sans Pro",
"Source Serif Pro",
"Tahoma",
"Times New Roman",
"Trebuchet MS",
"Unispace",
"Verdana",
"Yu Gothic",
"Yu Gothic UI",
"cinnamon cake",
"gotische",
"Webdings","Wingdings","EmojiOne Color",
];

styles=[

"Condensed",
"Condensed Oblique",
"Condensed Bold",
"Condensed Bold Oblique",
"Condensed Bold Italic",
"SemiCondensed",
"SemiLight Condensed",
"SemiLight SemiCondensed",
"SemiBold SemiCondensed",
"SemiBold Condensed",
"Light Condensed",
"Light SemiCondensed",
"SemiLight",
"Light",
"ExtraLight",
"Light Italic",
"Bold",
"Bold SemiCondensed",
"Semibold",
"Semibold Italic",
"Bold Italic",
"Bold Oblique",
"Black",
"Black Italic",
"Book",
"Regular",
"Italic",
"Medium",
"Oblique",
];


/*
Text("123ABCiiII",spacing=.9,radius=20,textmetrics=1,center=+1,cy=false,viewPos=true);
%circle(20);
// */
//Cring(txt="iiiAAA",tSpacing=1.0);

/** \name Text
\page Objects
Text() creates text

##Example
Text(123,h=0);  
Text(text="WWiiABCiiXX",radius=10);

\param text textstring or number
\param size text size
\param h  text height Z for 2D h=0
\param cx,cy,cz center  center modes
\param spacing text spacing
\param fn,fs text resolution
\param radius  polar text arrangement
\param rot     rotation vector for text
\param font    text font (name or number) echo(fonts)
\param style   text style ( name or number) echo(styles)
\param help show help
\param name text name
\param textmetrics  use textmetrics
\param viewPos  show letter positions
\param trueSize="body" text size = body height allow the use of pt() point, hp=size of letters "hp",cap=cap height, text=current text, font=current font


*/
//echo(textmetrics("hp",size=1));



//Text("fhpbdlqQPXMALTfF",size=10,trueSize="cap",cy=+0);
//%square([100,10]);

//Text("HTAMpqf",radius=20,rot=0);
//Text("HTAMMMMMM",trueSize="textl",size=20,textmetrics=0,spacing=1);


module Text(text="»«",size=5,h,cx,cy,cz,center=0,spacing=1,fn,fs=fs,radius=0,rot=[0,0,0],font="Bahnschrift:style=bold",style,help,name,textmetrics=true,viewPos=false,trueSize="body")
{

text=str(text);
lenT=len(text);
textmetrics=version()[0]<2022?false:textmetrics;

Echo(str("Sizing inactive trueSize=",trueSizeSW),color="warning",condition=trueSize!="size"&&( (!textmetrics&&trueSize!="body")||(is_num(useVersion)&&useVersion<22.208) ) );

trueSizeSW=is_num(useVersion)&&useVersion<22.208?"size":trueSize;
inputSize=size;

style=is_string(style)?style:styles[style];
font=is_num(font)?fonts[font]:font;
fontstr=is_undef(style)?font:str(font,":style=",style);

hp=textmetrics?textmetrics(text="hpbdlq",font=fontstr,size=1,spacing=spacing).size.y:1;
cap=textmetrics?textmetrics(text="HTAME",font=fontstr,size=1,spacing=spacing).size.y:1;
textSize=textmetrics?textmetrics(text=text,font=fontstr,size=1,spacing=spacing).size:[lenT*spacing,1];
fontS=textmetrics?fontmetrics(font=fontstr,size=1).nominal:1;


size=trueSizeSW=="body"?size*.72:
     trueSizeSW=="hp"?size/hp:
     trueSizeSW=="cap"?size/cap:
     trueSizeSW=="text"?size/textSize.y:
     trueSizeSW=="textl"?size/textSize.x:
     trueSizeSW=="font"?size/(fontS.ascent-fontS.descent):
     size;

    h=is_parent(needs2D)?0:is_undef(h)?size:h;
    cx=center?is_undef(cx)?1:cx:is_undef(cx)?0:cx;
    cy=center?is_undef(cy)?1:cy:is_undef(cy)?0:cy;
    cz=center?is_undef(cz)?1:cz:is_undef(cz)?0:cz;

    
    
    txtSizeX=textmetrics?textmetrics(text=text,font=fontstr,size=size,spacing=spacing).size.x:size*spacing*lenT;
    txtSizeY=textmetrics?textmetrics(text=text,font=fontstr,size=size,spacing=spacing).size.y:size;
    fontSize=[for(i=[0:max(lenT-1,0)])textmetrics?
      textmetrics(text=stringChunk(txt=text,length=i),font=fontstr,size=size,spacing=spacing).advance.x + textmetrics(text=text[i],font=fontstr,size=size,spacing=1).advance.x/2*(cx?1:1)
      :
      (size*spacing)*i];
      

 valign=cy?b(cy,false)<0?"bottom":
                         b(cy,false)>1?"top":
                                       "center":
           "baseline";
           
 halign=bool(cx,false)>0?"center"
                        :bool(cx,false)<0?"right"
                                         :"left";
                 
 if(text)
  if(!radius){   
    if(h)    
    rotate(rot)translate([0,0,cz?-abs(h)/2:h<0?h:0]) linear_extrude(abs(h),convexity=10){
    text(str(text),size=size,halign=halign,valign=valign,font=fontstr,spacing=spacing,$fn=fn,$fs=fs);
    }
    else rotate(rot)translate([0,0,cz?-h/2:0])text(text,size=size,halign=halign,valign=valign,spacing=spacing,font=fontstr,$fn=fn,$fs=fs); 
  }
  else if (lenT){
   iRadius=radius+(cy?-txtSizeY/2:0);
    rotate(center?textmetrics?gradB(txtSizeX/2,iRadius):gradB(max(fontSize),iRadius)/2:0)
    for(i=[0:lenT-1])rotate(-gradB(fontSize[i],iRadius))
    if(h)    
    translate([0,radius,0])rotate(rot)Tz(cz?-abs(h)/2:h<0?h:0){
    %color("Chartreuse")if(viewPos&&$preview)translate([0,-1])rotate(-30)circle($fn=3);// pos Marker
    linear_extrude(abs(h),convexity=10)text(text[i],size=size,halign=true?"center":"left",valign=valign,font=fontstr,$fn=fn,$fs=fs);
    }
    else  translate([0,radius,cz?-h/2:0])rotate(rot)text(text[i],size=size,halign=true?"center":"left",valign=valign,font=fontstr,$fn=fn,$fs=fs); 
  }
    
 InfoTxt("Text",["font",font,"style",style,"trueSize",trueSizeSW,"size",str(inputSize," ⇒ ",size)],name);   
        
 HelpTxt("Text",[
"text",str("\"",text,"\""),
"size",inputSize,
"h",str(h," /*0 for 2D*/"),
"cx",cx,
"cy",cy,
"cz",cz,
"center",center,
"spacing",spacing,
"fn",fn,
"fs",fs,
"radius",radius, 
"rot",rot,
"font",str("\"",font,"\""),
"style",str("\"",style,"\""),
"name",name,
"textmetrics",textmetrics,
"viewPos",viewPos,
"trueSize",str("\"",trueSize,"\""," /* body,size,hp,cap,text,textl,font */")
],help);

 
}



/** \name Pille
\page Objects
Pille() creates a capsule
\param l length
\param d diameter
\param rad rad2  edge radius
\param r radius ↦ d
\param center center
\param fn, fn2  fragments
\param loch  leave center hole
\param grad  degree 
\param deg  edge angle
\param chamfer chamfer adjactant if deg <90 or move round
\param 2D   polygon
\param x0 center x dist
\param name, help  name, help
*/

//Pille(d=13,rad=5,l=30,deg=90,chamfer=1);


module Pille(
l=10,
d,//+5,
rad,
rad2,
r,
center=true,
fn,
fn2,
fs=fs,
fa=fa,
fs2,
loch=false,
grad=360,
deg=90,
chamfer=true,
2D=false,
x0=0,
name,
help
){
2D=is_parent(needs2D)&&!$children?2D?b(2D,false):
                                 1:
                              b(2D,false);
  
deg=is_list(deg)?deg:[deg,deg];

r=is_undef(r)?is_undef(d)?l/2:d/2:r;
rad=is_undef(rad)?2*r<l?r*[1,1]:l/2*[1,1]:(is_list(rad)?is_undef(rad[0])?[abs(r),rad[1]]:rad:[rad,rad?rad:undef])*sign(r);

rad2=is_undef(rad2)?is_num(rad[1])?rad[1]:
                                   r<l?r:
                                       l-rad[0]:
                    rad2*sign(r);
d=is_undef(r)?abs(d):abs(r*2);

x0=is_list(x0)?x0:[x0,x0];

deltaRx=max(0,rad[0]-d/2);
deltaRy=Kathete(rad[0],deltaRx);
ausgleich=rad[0]-deltaRy;

rgrad=min(abs(deg[0]),asin(deltaRy/abs(rad[0])) )*sign(rad[0]);

deltaRx2=max(0,rad2-d/2);
deltaRy2=Kathete(rad2,deltaRx2);
ausgleich2=rad2-deltaRy2;
rgrad2=min(abs(deg[1]),asin(deltaRy2/abs(rad2)) )*sign(rad2);

chamfer=is_list(chamfer)?[chamfer[0],chamfer[1]]:[chamfer,chamfer];
fs=is_list(fs)?fs:[fs,fs];
fnO=fn;
fn=is_undef(fn)?fs2fn(r=d/2,fs=fs[0],grad=grad,minf=8,fa=fa):fn;

ifs2=is_undef(fs2)?fs[1]:fs2;
fs2=is_list(ifs2)?ifs2:[ifs2,ifs2];
fn2FS=[fs2fn(r=rad[0],fs=fs2[0],grad=rgrad,fa=fa),fs2fn(r=rad2,fs=fs2[1],grad=rgrad2,fa=fa)];
fn2=is_num(fn2)?[fn2,fn2]:
                is_list(fn2)?[is_undef(fn2[0])?fn2FS[0]:
                                               fn2[0]
                             ,is_undef(fn2[1])?fn2FS[1]:
                                               fn2[1]]:
                fn2FS;

Echo(str("Pille zu kurz! ",l-rad[0]+ausgleich-rad2+ausgleich2),color="red",condition=l+ausgleich+ausgleich2-rad[0]-rad2<0);


points=concat(
  chamfer[0]&&deg[0]<90&&deg[0]>-90?[[max(0,abs(r)-(1-cos(rgrad))*rad[0]-(1-sin(abs(rgrad)))*abs(rad[0])*( rgrad==90?0:tan(rgrad) )),0]]:[],
  [
  if(!loch)[x0[0],0],
  if(!loch)[x0[1],l]
  ],
  chamfer[1]&&deg[1]<90&&deg[1]>-90?[[max(0,abs(r)-(1-cos(rgrad2))*rad2-(1-sin(abs(rgrad2)))*abs(rad2)*( deg[1]==90?0:tan(rgrad2) )),l]]:[],

  rad2==0?[[d/2,l]]:Kreis(r=rad2,rand=0,grad=rgrad2,t=[d/2-rad2,(chamfer[1]?l-rad2+ausgleich2:l-sin(rgrad2)*rad2)],fn=fn2[1],center=false,rot=90-rgrad2),
  rad[0]==0?[[d/2,0]]:Kreis(r=rad[0],rand=0,grad=rgrad,t=[d/2-rad[0],(chamfer[0]?rad[0]-ausgleich:sin(rgrad)*rad[0])],fn=fn2[0],center=false,rot=90)
);

if(!2D)if(rgrad==90&&rgrad2==90)Tz(center?-l/2:0)//RotEx(grad=grad,fn=fn)
  rotate_extrude(angle=grad,$fn=fnO,$fs=fs[0],$fa=fa)polygon(points);
    else Tz(center?-l/2:0)//RotEx(grad=grad,fn=fn)
      rotate_extrude(angle=grad,$fn=fnO,$fs=fs[0],$fa=fa)polygon(clampToX0(points));
if(2D)T(0,center?-l/2:0)polygon(points);    

  InfoTxt("Pille",["Länge",l,"Rundung",str(rad[0],"/",rad2,str(rad[0]>d/2?" Spitz":rad[0]==d/2?" Rund":" Flach","/",rad2>d/2?"Spitz":rad2==d/2?"Rund":"Flach")),"Durchmesser",d,"Radius",d/2,"Grad",str(grad,"°")],name);    
     
  HelpTxt("Pille",["l",l,"d",d,"fn",fn,"fn2",fn2,"fs",fs,"fs2",fs2,"center",center,"name",name,"rad",rad,"rad2",rad2,"loch",loch,"grad",grad,"deg",deg,"chamfer",chamfer,"2D",2D,],help);
}



/** \page Objects
  \name Disphenoid
  Disphenoid() creates a disphenoid
  \param h height 
  \param l length
  \param b width
  \param r edge radius
  \param ty,tz,delta distortion
  \param fn fragments
  \param help activate help
*/

module Disphenoid(h=15,l=25,b=20,r=1,ty=0,tz=0,delta=[0,0],fn=36,help){
    delta=is_list(delta)?delta:[delta,delta];
    
   points=[
    [-l/2+r+delta[0],b/2-r+ty,0],
    [-l/2+r-delta[0],-b/2+r+ty,0],
    [l/2-r+delta[1],0,h/2-r+tz],
    [l/2-r-delta[1],0,-h/2+r+tz],
    ];
    
    
    faces=[
    [1,0,2],
    [0,1,3],
    [2,3,1],
    [3,2,0],
    ];



    minkowski(){
        polyhedron(points,faces,convexity=5);
        sphere(r,$fn=fn);
    }
    
  HelpTxt("Disphenoid",["h",h,"l",l,"b",b,"r",r,"ty",ty,"tz",tz,"delta",delta,"fn",fn],help);
}





module GewindeV2(dn=10,s,w=0,g=1,winkel=+60,rot2=0,r1=0,kern,fn=1,detail=fn,spiel=spiel,name,tz=0,preset=0,h=10,translate=[0,0,0],rotate=[0,0,0],d=0,gd=0,r=0,center=true,help,p=1.5,endMod=true){

s=is_undef(s)?p:s;//Steigung
p=s;    

 r1=r1?r1:p/sin(winkel/2)/2-0.01;   //overlap preventing
  rh=Kathete(r1,p/2);  //Gangtiefe

  
spiel=rot2==0?spiel:0;                  // spiel only for symetrische 
dn=$children?dn+spiel*2:dn;
kern=!is_undef(kern)?kern:dn-2*rh+spiel;

     
function profil(rot=0)=
 0?    vollwelle(fn=1,extrude=-1,x0=+0,h=1,xCenter=1,r=0.2,r2=0.5,l=p-.1) // test vollwelle
   : kreis(r=r1,rand=+0,fn=fn,grad=winkel,sek=winkel==360?1:0,rot=rot2);


function RotEx(rot=0,punkte=profil(rot=60),verschieb=dn/2,steigung=1,detail=detail)=[for(rotation=[0:detail*rot/360])for(i=[0:len(punkte)-1])
    concat((punkte[i][0]+verschieb)*sin(rotation*360/detail),punkte[i][1]+rotation/detail*steigung,(punkte[i][0]+verschieb)*cos(rotation*360/detail))
];


function faces(punkte=RotEx(),fn=len(profil())-1)=[
for(i=[0:fn-2])[0,i+1,i+2],
for(i=[0:len(punkte)-2-fn])[fn+1+i,1+i,+i],
for(i=[0:len(punkte)-2-fn])[fn+i,fn+1+i,+i],
for(i=[1:fn])[len(punkte)-i+0,len(punkte)-i-1,len(punkte)-1]    
];
Echo("‼ using old GewindeV2 ‼",color="warning");
 if(d||gd||r){GewindeV1(d=d,s=s,w=w?w:5,g=g,tz=tz,gd=gd?gd:1.75,fn=fn==1?3:fn,r=r)children();//Kompatibilität
     Echo("‼ using old GewindeV1 ‼",color="warning");
 }
 else if(false)R(90)polyhedron(RotEx(rot=100,steigung=p),faces(punkte=RotEx(rot=100)),convexity=15);   //test for polyhedron only   
 else if(preset==0){
    w=w?w:h/p*360;
     add=center?p/2:0;
    difference(){
        if($children)children();
        translate(translate)rotate(rotate)Tz(-add+tz)intersection(){
           union(){
              Col(6) Polar(g,n=0) difference(){
              R(90)polyhedron(RotEx(rot=w,steigung=p),faces(punkte=RotEx(rot=w)),convexity=15);
                  if(endMod&&is_num(rh))Tz(h)rotate(-90+w%360-w%(360/detail))T(dn/2)cylinder(p,d=rh*2-spiel,center=true,$fn=4);
                  if(endMod&&is_num(rh))rotate(-90)T(dn/2)cylinder(p,d=rh*2-spiel,center=true,$fn=4);    
              }
          if(rot2==0)Col(9) Tz(-p/2) rotate(-90)cylinder(w/360*p+p,d=kern,center=false,$fn=detail);   
           }
          if(rot2==0)Col(8) rotate(-90)cylinder(2*w/360*p+p,d=dn-spiel,center=true,$fn=detail);
       }
    } 
    
HelpTxt("GewindeV2",["dn",dn,"s",s,"w",w,"g",g,"winkel",winkel,"rot2",rot2,", r1",r1,",kern",kern,"fn",fn,"detail",detail,"spiel",spiel,"name",name,"tz",tz,"preset",preset,"h",h,"translate",translate,"rotate",rotate,"d",d,"gd",gd,"r",r,"center",center,"p",p,"endMod",endMod],help&&!preset);
    
 
    
if(name)echo(str("Gangtiefe=",rh,"mm - Gangflanke(r1)=",r1,"mm - Steigung=",p,"mm - Höhe=",w/360*p,"mm+",p)); 
if(name)echo(str(name,rot2==0?$children?" Innen": " Aussen":" Undefiniertes","gewinde ∅=",dn-spiel," (",dn,") Kern=",kern));
 if(winkel==360)Echo(str(" ∅ Diameter Warning!"),color="warning");
 }

else if(preset==1){// ½ Zoll Gewinde
  if($children)  GewindeV2(dn=20.95,w=w,h=h,kern=19,winkel=55,p=1.814286,preset=0,fn=1,translate=translate,rotate=rotate)children();
   if(!$children)  GewindeV2(dn=20.95,w=w,h=h,winkel=55,p=1.814286,preset=0,fn=1,translate=translate,rotate=rotate,help=help);  
    
    echo(str(" ½ Zoll Gewinde "));
}

else if(preset==2){// ¾ Zoll Gewinde
  if($children)  GewindeV2(dn=26.44,w=w,h=h,kern=24.5,winkel=55,p=1.814286,preset=0,fn=1,translate=translate,rotate=rotate)children();
   if(!$children)  GewindeV2(dn=26.44,w=w,h=h,winkel=55,p=1.814286,preset=0,fn=1,translate=translate,rotate=rotate);  
    
    echo(str(" ¾ Zoll Gewinde "));
}

else if(preset=="M3"){// M3 Gewinde
  if($children)  GewindeV2(dn=3,w=w,h=h,p=.5,preset=0,fn=1,translate=translate,rotate=rotate)children();
   if(!$children)  GewindeV2(dn=3,w=w,h=h,p=.5,preset=0,fn=1,translate=translate,rotate=rotate);  
    
    echo(str(" M3 Gewinde "));
}
else if(preset=="M6"){// M6 Gewinde
  if($children)  GewindeV2(dn=6,w=w,h=h,p=1,preset=0,fn=1,translate=translate,rotate=rotate)children();
   if(!$children)  GewindeV2(dn=6,w=w,h=h,p=1,preset=0,fn=1,translate=translate,rotate=rotate);  
    
    echo(str(" M6 Gewinde "));
}

}




module Laser3D(h=4,layer=10,var=0.002,name,on=-1){

  if(on==1)for (i=[0:h/layer:h]){
        c=i/h;
  T(z=i/h*var) color([c,c,c]) projection(cut=true)T(z=-i)children();
    }
   
   if(on==-1) for(i=[+0.0:h/layer:h]){
       
        color([i/h,i/h,i/h])T(z=i*+0.01) intersection(){
          T(-500,-500,i) cube([1000,1000,layer]);
          T(z=-i*0.000)  children();
          }
      } 
      
    if(on==0) children();     
    
    T(z=-.48)color([0,0,0])cube([1000,1000,1],true);
    
    MO(!$children);
    InfoTxt("Laser3D",["color resolution=",str(h/layer,"mm")],name);  
    
}

/** \name Elllipse
Ellipse creates an ellipse with optional children
\param x first semi axis can be [x,x] (absolute values)
\param y second semi axis can be [y,y]
\param z optional 
\param rand thickness for 2D 
\param fn fs fa fraqment resolution
*/

module Ellipse(x=2,y=2,z=0,rand=1,fn,fs=fs,fa=fa,help){
  
  
  x=is_list(x)?x:[x,x];
  y=is_list(y)?y:[y,y];
  z=is_list(z)?z:[z,z];
  //ToDo z rot;
  fn=fn?fn:fs2fn(r=max(max(x),max(y),max(z)),fs=fs,fa=fa);
  //function rota(i)=-atan2(sin(i)*y,cos(i)*x)+90;
  function rot(i)=
    let(i=i%360)
    atan2(cos(i)*(i>=180?x[0]:x[1]),sin(i)*(i>=90&&i<270?y[0]:y[1]));
    
   for (n=[0:fn-1]){
     $idx=n;
     step=360/fn;
     i=step*n;
    j=step*(n+1);
     
     if($children)  Color(1/fn*n)hull(){
           T(sin(i)*(i>=180?x[0]:x[1]),cos(i)*(i>=90&&i<270?y[0]:y[1]),cos(i)*(i>=90&&i<270?z[0]:z[1]))rotate(rot(i))children();   
           union(){
             $idx=$idx+1;
             T(sin(j)*(i>=180?x[0]:x[1]),cos(j)*(i>=90&&i<270?y[0]:y[1]),cos(j)*(i>=90&&i<270?z[0]:z[1]))rotate(rot(j))children();   
           }
       }
     if(!$children)hull(){
           T(sin(i)*(i>=180?x[0]:x[1]),cos(i)*(i>=90&&i<270?y[0]:y[1]))rotate(rot(i))circle(rand/2,$fn=36);   
           T(sin(j)*(i>=180?x[0]:x[1]),cos(j)*(i>=90&&i<270?y[0]:y[1]))rotate(rot(j))circle(rand/2,$fn=36);   
       }  
       
   }
  MO(!$children,warn=true);
  HelpTxt("Ellipse",["x",x,"y",y,"z",z,"rand",rand,"fn",fn,"fs",fs,"fa",fa],help);
}



module WStrebe(grad=45,grad2,h=20,d=2,d2=0,rad=3,rad2=0,sc=0,angle=360,spiel=spiel,fn=fn,2D=false,center=true,rot=0,help){
    
    rad2=rad2?rad2:rad;
    d2=d2?d2:d;
    grad2=is_undef(grad2)?grad:grad2;
    
  if(!2D)R(0,center?0:grad)Tz(center?0:h/2){
      
  rotate(rot)R(180)Halb(1)Tz(-h/2)R(0,-grad2) Strebe(rad=rad2,rad2=rad,d=d2,d2=d,h=h,grad=grad2,single=false,name=0,help=0,2D=0,sc=sc,angle=angle,spiel=spiel,fn=fn); //oben
  Tz(.1)Halb(1)Tz(-h/2-.1)R(0,-grad) Strebe(rad=rad,rad2=rad2,d=d,d2=d2,h=h,grad=grad,single=false,name=0,help=0,2D=0,sc=sc,angle=angle,spiel=spiel,fn=fn);//unten 
  }
  
  
  
  if(2D)R(0,0,center?0:-grad)T(0,center?0:h/2){
  mirror([0,1,0])Halb(1,y=1,2D=true)T(0,-h/2)R(0,0,grad2) Strebe(rad=rad2,d=d2,d2=d,h=h,grad=grad2,single=false,n=0,help=0,2D=2D,sc=sc,angle=angle,spiel=spiel,fn=fn);    
  Halb(1,y=1,2D=true)T(0,-h/2)R(0,0,grad) Strebe(rad=rad,d=d,d2=d2,h=h,grad=grad,single=false,n=0,help=0,2D=2D,sc=sc,angle=angle,spiel=spiel,fn=fn);//unten
  }
HelpTxt("WStrebe",["grad",grad,"grad2",grad2,"h",h,"d",d,"d2",d2,"rad",rad,"rad2",rad2,"sc",sc,"angle",angle,"spiel",spiel,"fn",fn,"2D",2D,"center",center,"rot",rot],help); 
      
}



module Strebe(h=20,d=5,d2,rad=4,rad2,sc=0,grad=0,skew=0,single=false,angle=360,spiel=spiel,fn=fn,fn2=fn/4,center=false,name,2D=false,help){
    
    fn2=is_list(fn2)?fn2:[fn2,fn2];
    rad2=is_undef(rad2)?is_list(rad)?rad[1]:
                            rad:
                   rad2;
    rad=is_list(rad)?rad[0]:rad;
    d2=is_undef(d2)?d:d2;
    skew=skew?skew:tan(grad);
    grad=atan(skew);
    sc=sc?sc:d/(d*cos(grad));
    winkel=h==rad+rad2?90:
                       atan((single?(h-rad):
                                    (h-rad-rad2))/(d2/2-d/2));

    grad1=winkel>0?180-winkel:abs(winkel);//90;//VerbindugsWinkel unten
    grad2=180-grad1;//VerbindugsWinkel oben    
    //assert(h>=(rad+rad2),str("Strebe too short h=",h,"<",rad,"+",rad2," for rad")); 


  if (!2D && !is_parent(needs2D))//search(["Rundrum"], parentList())[0] )
    M(skewzx=skew) Tz(center ? -h/2 : 0) scale([sc, 1, 1])
      rotate(-angle/2) rotate_extrude(angle=angle, convexity=5, $fn=fn)
        Strebe(skew=0, h=h, d=d, d2=d2, rad=rad, rad2=rad2, sc=1, grad=0, single=single, spiel=spiel, fn2=fn2, name=0, 2D=2, help=false);


  InfoTxt("Strebe",[
    "Neigungs ∡",str(atan(skew),"°"),
    "center ∡",str(single||rad!=rad2?"~":"=",winkel,"°"),
    "Scale",sc,
    " dSkew",str(d,"/",d*sc*cos(grad),"-",d2,"/",d2*sc*cos(grad),"mm"),
    "Parent",parentList()
  ],name); 


if (2D || is_parent(needs2D))//search(["Rundrum"], parentList())[0] )
  M(skewyx=skew)T(0,center?-h/2:0){
    if(grad1>90) Echo(str("Strebe ∅",d,"mm is d=",(d/2-rad+sin(grad1)*rad)*2),color="warning");
    if(grad2>90) Echo(str("Strebe ∅",d2,"mm is d2=",(d2/2-rad2+sin(grad2)*rad2)*2),color="warning");
    Echo(str("Strebe too short h=",h,"<",rad,"+",rad2," for rad"),color="warning",condition=h<(rad+rad2));
   points= concat(
    2D==2?[[0,h+spiel]]:single?[[-d2/2,h]]: kreis(fn=fn2[1],rand=0,r=rad2,grad=-grad2,rot=+grad2,center=false,sek=true,t=[-d2/2-abs(sin(winkel))*rad2,h-rad2]), // open L
    
    2D==2?[[+0,h+spiel]]:[[single?-d2/2:-d2/2-rad2,h+spiel]],
    
    [[single?d2/2:d2/2+rad2,h+spiel]],
    
    single?[[d2/2,h]]: kreis(fn=fn2[1],rand=0,r=rad2,grad=-grad2,rot=0,center=false,sek=true,t=[d2/2+abs(sin(winkel))*rad2,h-rad2]),// open R
    
    kreis(fn=fn2[0],rand=0,r=rad,grad=-grad1,rot=grad1-180,center=false,sek=true,t=[d/2+abs(sin(winkel))*rad,rad]), // unten R
    
    [[d/2+rad,0-spiel]],
    
    2D==2?[[0,-spiel]]:[[-d/2-rad,0-spiel]],
    
    2D==2?[[+0,0]]:kreis(fn=fn2[0],rand=0,r=rad,grad=-grad1,rot=180,center=false,sek=true,t=[-d/2-abs(sin(winkel))*rad,rad]));// unten L
    
    scale([sc,1])polygon(points,convexity=5); 

}

HelpTxt("Strebe",["h",h,"d",d,"d2",d2,"rad",rad,"rad2",rad2,"sc",sc,"grad",grad,"skew",skew,"single",single,"angle",angle,"spiel",spiel,"fn",fn,"fn2",fn2,"name",name,"2D",str(2D,"/*2 for halb*/")],help); 

}

/// Bezier() creates a Bezier shape polygon or 3D

//RotEx(cut=true)Bezier(mpRot=true);

module Bezier(
p0=[+0,+10,0],
p1=[15,-10,0],
p2,
p3=[0,-10,0],
w=1,//weighting
max=1.0,
min=+0.0,
fn=50,
fn2=fn,
ex,//extrude X
pabs=false, //p1/p2 absolut/relativ p0/p3
messpunkt=true,
mpRot,
twist=0,
scale=1,
hull=true,
points,
d,
name,
help

){
   mpRot=is_undef(mpRot)?search(["RotEx"],parentList())[0]?true:
                            mpRot:
                    mpRot;
    //echo(search(["RotEx"],parentList())[0],parentList());
  
  messpunkt=is_bool(messpunkt)?messpunkt?pivotSize:0:messpunkt;//$info?messpunkt:0;
  3D=is_list(points)||d&&!$children?true:false;
  p0=v3(p0);
  p3=v3(p3);  
  p1=v3(pabs?p1*w:v3(p1)*w+p0);  
  p2=is_undef(p2)?p1:v3(pabs?p2*w:v3(p2)*w+p3);
  
 $fn=hull?fn:$fn;
 $fa=fa;
 $fs=fs; 


    if($children){
        twist=v3(twist);
        $helpM=0;
        $info=is_undef(name)?is_undef($info)?false:$info:name; 
        step=((max-min)/fn);
        for (t=[min:step:max-step]){
            
            $rot=vektorWinkel(Bezier(t,p0,p1,p2,p3),Bezier(t+step,p0,p1,p2,p3))+twist/(max-step)*t;
            $tab=true;
            $idx=t;
            if (hull) Color(1/(max-step)*t,$idxON=false)hull(){
                translate(Bezier(t,p0,p1,p2,p3))rotate($rot)scale(1-(1-scale)/(max-step)*t)children();
                 union(){
                    $idx=t+step;
                    $rot=t>=max-step?vektorWinkel(p2,p3)+twist: // last segment
                                     vektorWinkel(Bezier(t+step,p0,p1,p2,p3),Bezier(t+step*2,p0,p1,p2,p3))+twist/(max-step)*(t+step);
                    translate(Bezier(t+step,p0,p1,p2,p3))rotate($rot)scale(1-(1-scale)/(max-step)*(t+step))children();
                }
             }
            else Color(1/(max-step)*t,$idxON=false)
              translate(Bezier(t,p0,p1,p2,p3))rotate($rot)scale(1-(1-scale)/(max-step)*t)children();
            
        }
    
}
    if(!$children&&3D==false){
    if (is_undef(ex)) polygon([for (t=[min:((max-min)/fn):(max+(max-min)/fn)-((max-min)/fn)])Bezier(t,
            [p0[0],p0[1]],
            [p1[0],p1[1]],        
            [p2[0],p2[1]],       
            [p3[0],p3[1]]        
        )]);
        
    else polygon(concat(
      [[0,p0[1]]],
      [for (t=[min:((max-min)/fn):(max+(max-min)/fn)-((max-min)/fn)])Bezier(t,
        [p0[0]+ex,p0[1]],
        [p1[0]+ex,p1[1]],        
        [p2[0]+ex,p2[1]], 
        [p3[0]+ex,p3[1]] )],
      [[0,p3[1]]]
      ));        
        
 
    }
    
    if(3D){
      points=is_undef(points)?arc(r=d/2,deg=360,fn=fn2,z=0):
                              len(points[0])==3?points:
                                                [for(iPoint=points)concat(iPoint,0)];

      loop=len(points);
      path=[for (t=[min:((max-min)/fn):(max+(max-min)/fn)-((max-min)/fn)])Bezier(t,p0,p1,p2,p3)];
    if(name&&!$children)Echo(str(name," No Bezier object using polygon! path length=",pathLength(path)),color="green");
     PolyH(pathPoints(points=points,path=path,scale=scale,twist=twist),loop=loop,name=false);

    }
    
    
    
    %if(messpunkt){
        ex=is_undef(ex)?0:ex;
         vpr=mpRot?[90,0,0]:$vpr;
        Pivot(mpRot?[p0[0]+ex,0,p0[1]]:p0+[ex,0,0],messpunkt,txt="p0",vpr=vpr);
        Pivot(mpRot?[p1[0]+ex,0,p1[1]]:p1+[ex,0,0],messpunkt/2,txt=str("p1",p1==p2?"     ":""),vpr=vpr);
        Pivot(mpRot?[p2[0]+ex,0,p2[1]]:p2+[ex,0,0],messpunkt/2,txt="p2",vpr=vpr);
        Pivot(mpRot?[p3[0]+ex,0,p3[1]]:p3+[ex,0,0],messpunkt,txt="p3",vpr=vpr);
      d=b(messpunkt,false)/20;
        %Line(mpRot?[p0[0]+ex,0,p0[1]]:p0+[ex,0,0],mpRot?[p1[0]+ex,0,p1[1]]:p1+[ex,0,0],d=d,center=true);
        %Line(mpRot?[p3[0]+ex,0,p3[1]]:p3+[ex,0,0],mpRot?[p2[0]+ex,0,p2[1]]:p2+[ex,0,0],d=d,center=true);
        
        }
    
    if(name&&!$children&&!3D)Echo(str("No Bezier object using polygon!"),color="green");

HelpTxt("Bezier",[   
  "p0",p0,
  "p1",p1,
  "p2",p2,
  "p3",p3,
  "w/*weighting*/",w,
  "max",max,
  "min",min,
  "fn",fn,
  "fn2",fn2,
  "ex/*extrude X*/",ex,
  "pabs/*p1/p2 absolut/relativ */",pabs, 
  "messpunkt",messpunkt,
  "mpRot",mpRot,
  "twist",twist,
  "hull",hull,
  "points",points?"points":undef,
  "d/*for 3D*/",d,
  "name",name]
  ,help);
}




module Ttorus(r=20,twist=360,angle=360,pitch=0,scale=1,r2,fn=fn,help){
    
    scale=is_list(scale)?scale:[scale,scale,scale];
    r2=is_undef(r2)?r:r2;
    diff=r2-r;
    
   for (i=[0:fn-1]){//(i=[0:360/fn:angle-.005]){
    step=angle/fn;
    rdiff=diff/fn;
    j=i+1;//j=i+360/fn;
    //$info=i?0:$info;
    //$helpM=i?0:$helpM; 
    $idx=i;  
   Color(i/fn,$idxON=false) hull(){
        rotate(i*step)translate([r+rdiff*i,0,i*pitch/360*abs(step)]) rotate([0,i*twist/360*step,0])scale([1,1,1]+(scale-[1,1,1])/fn*(i))children();
        rotate(j*step)translate([r+rdiff*j,0,j*pitch/360*abs(step)]) rotate([0,j*twist/360*step,0])union(){
            $info=false;
            $helpM=false;
            $idx=j;
            scale([1,1,1]+(scale-[1,1,1])/fn*(j))children();
        }
    }  
   } 
    
MO(!$children);
Echo("use Coil()",color="info",condition=!$children);
    
HelpTxt("Ttorus",[
  "r",r,
  "twist",twist,
  "angle",angle,
  "pitch",pitch,
  "scale",scale,
   "r2",r2,
  "fn=",fn],help);    
}

/** \page Modifier
\name Kontaktwinkel
Kontaktwinkel(d=1)Torus(d=$d,winkel=60); cuts children at contact angle 

\param winkel contact angle
\param d r   diameter/radius of children
\param baseD calculates d for desired base diameter
\param center cut both sides if true
\param 2D     cuts 2D 
\param inv    inverts cut
\param centerBase move Object so cut is at center if true
*/

module Kontaktwinkel(winkel=50,d,baseD,r,center=false,2D=0,inv=false,centerBase=0,name,help){
grad=-winkel+90;
d=is_num(baseD)?(baseD/2)/sin(winkel)*2:is_undef(r)?is_undef(d)?0:d:2*r;

h=assert(d,"baseD or d or r not set!")sin(grad)*d/2;
b=sqrt(pow(d/2,2)-pow(h,2));    
viewportSize=is_undef(viewportSize)?1000:max(d*2,100,viewportSize);


centerBase=b(centerBase,false);
$d=d;
$r=d/2;
 if(!2D){
      if(!inv) Tz(centerBase==1?h:
                             centerBase==-1?-h:
                                            0)intersection(){
            children();
            T(z=center?0:-h)cylinder(center?h*2:viewportSize,d=viewportSize,center=b(center,true),$fn=6);
            }
      if(inv)Tz(centerBase==1?-h:centerBase==-1?h:0) intersection(){
            children();
            difference(){
               cube(viewportSize,center=true);
               T(z=center?0:h-viewportSize)cylinder(center?h*2:viewportSize,d=viewportSize,center=b(center,true),$fn=6);
            }
        } 
    }
  if(2D){
      if(!inv)T(y=centerBase==1?h:centerBase==-1?-h:0)intersection(){
          children();
          T(center?0:-viewportSize/2,center?0:-h)square([viewportSize,center?h*2:viewportSize],center=b(center,true));
          }
      if(inv)T(y=centerBase==1?-h:centerBase==-1?h:0) intersection(){
          children();
          difference(){
              square(viewportSize,center=true);
              T(center?0:-viewportSize/2,center?0:h-viewportSize)square([viewportSize,center?h*2:viewportSize],center=b(center,true));
          }
      }         
          
    }   
    
MO(!$children);
InfoTxt("Kontaktwinkel",["∅",d,"radius",r,"winkel",str(winkel,"°"),"Höhe",h,"Kontakt Radius",b,"2×",b*2],name);
HelpTxt("Kontaktwinkel",["winkel",winkel,"d",d,"baseD",baseD,"r",r,"center",center,"2D",2D,"inv",inv,"centerBase",centerBase,"name",name],help);
}



/// creates Octahedron with n spherical subdivision

module OctaH(r=1,n=0,d,help){
  
HelpTxt("OctaH",["r",r,"n",n,"d",d],help);
  
  scaling=is_list(r)||is_list(d)?true:false; // if subdiv needs sep scaling
  r=is_list(r)?[for(i=[0:5]) i%2? -abs(r[i%len(r)]):   // neg quadrant
                                   abs(r[i%len(r)])]:  //pos quadrants
              is_undef(d)?[r, -r, r, -r, r, -r]:
                          is_list(d)?[for(i=[0:2]) each[d[i%len(d)] , -d[i%len(d)] ]] /2:
                                //       d.y /2, -d.y /2,
                                //       d.z /2, -d.z /2]:
                                     [d /2, -d /2, d /2, -d /2, d /2, -d /2];
  
  faces=[
  [0,2,4],
  [2,1,4],
  [1,3,4],
  [3,0,4],
  [2,0,5],
  [1,2,5],
  [3,1,5],
  [0,3,5],
  
  ];
  if(n==0)polyhedron(octa(r),faces);
  
  else OctaSphere(r,n,d);
  module OctaSphere(r=10,n=10,d){   
    // based on Hans Loeblich alternative spheres
    // https://github.com/thehans/FunctionalOpenSCAD
    // MIT license
    

  data=sphere_subdiv(divs=max(1,floor(n/4)), poly=OCTAHEDRON(1));
  polyhedron(data[0],data[1]);


  // sum a vector of vectors.  vsum([]) == undef
  function vsum(v,i=0) = len(v)-1 > i ? v[i] + vsum(v, i+1) : v[i];
  // angle between two vectors (2D or 3D)
  function anglev(v1,v2) = acos( (v1*v2) / (norm(v1)*norm(v2) ) );
  function flatten(l) = [ for (a = l) for (b = a) b ];
  //function unit(v) = v / norm(v); // convert vector to unit vector
  // spherical linear interpolation
  function slerp(p0,p1,t) = let(a = anglev(p0,p1)) (sin((1-t)*a)*p0 + sin(t*a)*p1) / sin(a);

  function OCTAHEDRON(r) = [octa(r),faces];
  
  
//  [ [[0,0,r[5]],[r[0],0,0],[0,r[2],0],[r[1],0,0],[0,r[3],0],[0,0,r[4]]],
//    [ [0,3,4],[0,1,2],[0,2,3],[0,4,1],
//      [5,2,1],[5,3,2],[5,4,3],[5,1,4] ] ];


  // subdivide faces, splitting edges into integer number of divisions
  // input faces must be triangles with vertices on the unit sphere
  function sphere_subdiv(divs=1, poly) = 
    let(
      R = r[0],//d == undef ? r : d/2, // optional radius or diameter
      d = divs, // shorthand
      pv = poly[0], // points vector
      tv = poly[1], // triangle index vector
      newpoints = [for (t = tv) let(p = [pv[t[0]], pv[t[1]], pv[t[2]]])
        for (i=[0:1:d], j=[0:1:d-i]) if (i+j!=0 && i!=d && j!=d) // skip original corner points
          let(subv=[for (vi=[0:2]) let(k=d-i-j, ii=[i,j,k],
              j1=ii[(vi+1)%3], n=ii[vi]+j1,
              p0=p[vi], p1=p[(vi+1)%3], p2=p[(vi+2)%3],
              p_i=slerp(p0,p1,n/d), p_j=slerp(p0,p2,n/d)
            ) slerp(p_i,p_j,j1/n)
          ])
          vsum(subv)
      ],
      Tn = function(n) n*(n+1)/2, // triangular numbers
      Td = Tn(d+1), // total points for subdivided face
      np = Td - 3, // new points per original face
      lp = len(pv),
      allpoints = concat(pv, newpoints/3),
      // Given original triangle point indices t, 
      // and indices i,j for subdivided basis vectors, { i => (tri[0],tri[1]), j => (tri[0],tri[2]) }
      // convert to absolute point index of resulting full point set.
      pij = function(n,t,i,j) i+j==0 ? t[0] : i==d ? t[1] : j==d ? t[2] :
        lp + n*np + Td - Tn(d+1-i) + j - (i==0 ? 1 : 2),
      faces = flatten([for (n = [0:1:len(tv)-1]) let(t = tv[n]) [
        for (i=[0:1:d-1], j=[0:1:d-1-i]) [ pij(n,t,i,j), pij(n,t,i+1,j), pij(n,t,i  ,j+1) ],
        for (i=[1:1:d-1], j=[0:1:d-1-i]) [ pij(n,t,i,j), pij(n,t,i,j+1), pij(n,t,i-1,j+1) ] 
      ] ])
    )[scaling?[for(i=[0:len(allpoints)-1])[
      allpoints[i].x>0?allpoints[i].x*r[0]:allpoints[i].x*-r[1],
      allpoints[i].y>0?allpoints[i].y*r[2]:allpoints[i].y*-r[3],
      allpoints[i].z>0?allpoints[i].z*r[4]:allpoints[i].z*-r[5],
    ]]
      :R*allpoints
        , faces];
   }
}




/** \page Objects
Prisma() rounded cube (square prism)
 \name Prisma
 * \brief creates a prism with optional round edges
 \param x1 size x bottom (can be list)
 \param y1 size y bottom
 \param z size z
 \param c1 vertical corner diameter can be bigger then s
 \param s  edge diameter
 \param rad edge radius (only for simple)
 \param x2,y2 optional size top
 \param x2d,y2d delta to shift top
 \param c2 for tapered vertical corner
 \param fnC fragments vertical corner
 \param fnS fragments corner
 \param fs fragment size
 \param center center [x,y,z]
 \param r corner radius (simple only)
 \param deg edge contact angle [bottom,top]
 \param optimize uses Pill like for simple, allows deg and rad but takes longer
*/

//Prisma(r=[1,2,3,4]);



module Prisma(x1=12,y1,z,c1=5,s=1,x2,y2,x2d=0,y2d=0,rad,c2=0,vC=[0,0,1],cRot=0,fnC=fn,fnS=36,fs=fs,center=false,r,deg=[50,90],optimize=false,name,help){


     
    helpX1=x1;
    helpY1=y1;
    helpX2=x2;
    helpY2=y2;    
    helpZ=z;
    helpS=s;
    helpC1=c1;
    
    simple=(x1==x2||is_undef(x2))&&(y1==y2||is_undef(y2))&&!x2d&&!y2d&&!c2&&vC==[0,0,1]&&!optimize?true:false;
    
    center=is_list(center)?v3(center):[1,1,center];
    rad=is_undef(rad)?[s,s]/2:is_list(rad)?rad:[rad,rad];
    r=is_undef(r)?c1/2*[1,1,1,1]:is_list(r)?r:[r,r,r,r];
    
    x=is_list(x1)?x1[0]:x1;
    y=is_list(x1)?x1[1]:is_undef(y1)?x1:y1;
    
    hErr=optimize?0:s/2-cos(90/ceil((is_num(fnS)?fnS:fs2fn(r=s/2,fs=fs,grad=360))/2))*s/2; // missing sphere piece
    z=(is_undef(x1[2])?is_undef(z)?x:z:x1[2])+ (simple?0:hErr*2);
    s=min(x,y,is_undef(z)?0:z,max(vSum(rad),0));
    c1=min(max(r[0]*2,0),x,y);
    
    cylinderh=c1?minVal:0;
    
    x1=c1-s>0?vC[1]?max(x-cylinderh-s,minVal):max(x-c1,minVal):max(x-s,minVal);
    y1=c1-s>0?vC[0]?max(y-cylinderh-s,minVal):max(y-c1,minVal):max(y-s,minVal);
    
    h=vC[0]||vC[1]?c1?max(z-c1,minVal):max(z-s,minVal):c2?minVal:z-s-cylinderh;
    //h=z-s-cylinderh;
    
    cylinderd2=c2?c2:c1;
    
    y2=is_list(x2)?c1-s>0?vC[0]?max(x2[1]-cylinderh-s,minVal):max(x2[1]-c1,minVal):max(x2[1]-s,minVal)
                  :is_undef(y2)?y1:c1-s>0?vC[0]?max(y2-cylinderh-s,minVal):max(y2-c1,minVal):max(y2-s,minVal);    
    x2=is_undef(x2)?x1
                   :is_list(x2)?c1-s>0?vC[1]?max(x2[0]-cylinderh-s,minVal):max(x2[0]-c1,minVal):max(x2[0]-s,minVal):c1-s>0?vC[1]?max(x2-cylinderh-s,minVal):max(x2-c1,minVal):max(x2-s,minVal);
        
    

CubePoints = [
  [-x1/2,-y1/2,  0 ],  //0
  [ x1/2,-y1/2,  0 ],  //1
  [ x1/2, y1/2,  0 ],  //2
  [-x1/2, y1/2,  0 ],  //3
  [-x2/2+x2d,-y2/2+y2d,  h ],  //4
  [ x2/2+x2d,-y2/2+y2d,  h ],  //5
  [ x2/2+x2d, y2/2+y2d,  h ],  //6
  [-x2/2+x2d, y2/2+y2d,  h ]]; //7
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
 if(simple) T(center.x?0:x/2,center.y?0:y/2)hull() {
 $info=false;

  if(r[0]==r[1]&&r[2]==r[3]&&r[1]==r[2])for(px=[-1,1]*(x-c1)/2,py=[-1,1]*(y-c1)/2)translate([px,py,0])Pille(l=z,d=max(minVal*4,c1),rad=rad,deg=deg,fs=fs,fn2=is_num(fnS)?fnS/4:undef,fn=fnC,center=center.z);

  else{
  translate([-x/2+r[0],-y/2+r[0],0])Pille(l=z,r=max(minVal,r[0]),rad=rad,deg=deg,fs=fs,fn2=is_num(fnS)?fnS/4:undef,fn=fnC,center=center.z);
  translate([ x/2-r[1],-y/2+r[1],0])Pille(l=z,r=max(minVal,r[1]),rad=rad,deg=deg,fs=fs,fn2=is_num(fnS)?fnS/4:undef,fn=fnC,center=center.z);
  translate([ x/2-r[2], y/2-r[2],0])Pille(l=z,r=max(minVal,r[2]),rad=rad,deg=deg,fs=fs,fn2=is_num(fnS)?fnS/4:undef,fn=fnC,center=center.z);
  translate([-x/2+r[3], y/2-r[3],0])Pille(l=z,r=max(minVal,r[3]),rad=rad,deg=deg,fs=fs,fn2=is_num(fnS)?fnS/4:undef,fn=fnC,center=center.z);
  
  }
  }

 else
  T(center.x?0:x/2,center.y?0:y/2)translate([0,0,vC[0]||vC[1]?c1?c1/2:s/2:s/2+minVal/2-(center.z?z/2:hErr)])minkowski(){
        polyhedron( CubePoints, CubeFaces,convexity=5 );
        if(c1-s>0&&!optimize)rotate(a=90,v=vC)rotate(cRot)cylinder(c2?max(z-s-minVal,minVal):minVal,d1=c1-s,d2=cylinderd2-s,center=c2?false:true,$fn=fnC,$fs=fs);
        if(s){
          if(!optimize)sphere(d=s,$fn=fnS,$fs=fs);//OctaH(d=s,n=fnS);//
          else Pille(vSum(rad),deg=deg,rad=rad,d=c1,fs=fs,fn2=is_num(fnS)?fnS/4:undef,fn=fnC);
          }
    }
   vx=((x1+s)-(x2+s))/2/(z-s);
   vy=((y1+s)-(y2+s))/2/(z-s); 
   InfoTxt("Prisma",["SteigungX/Y",str(vx*100,"/",vy*100,"%"),"grad",str(atan(vx),"/",atan(vy),"°")],name); 
    if(vSum(rad)>z)Echo(str(name," Prisma Σrad>z ! ",vSum(rad)," ⇒ ",s),color="red");
    if(max(rad)*2>x)Echo(str(name," Prisma rad*2>x ! ",max(rad)*2," ⇒ ",s),color="red");
    if(max(r)*2>x)Echo(str(name," Prisma 2r>x ! ",max(r)*2," ⇒ ",c1),color="red");
    if(max(rad)*2>y)Echo(str(name," Prisma rad*2>y ! ",max(rad)*2," ⇒ ",s),color="red");
    if(max(r)*2>y)Echo(str(name," Prisma 2r>y ! ",max(r)*2," ⇒ ",c1),color="red");

    if(s>c1&&c1)Echo(str(name," Prisma s>c1 ! ⇒ C-Rundung = s "),color="warning");

HelpTxt("Prisma",["x1",helpX1,",y1",helpY1,",z",helpZ,"c1",helpC1,"s",helpS,"x2",helpX2,"y2",helpY2,"x2d",x2d,"y2d",y2d,"rad",rad,"c2",c2,"vC",vC,"cRot",cRot,"fnC",fnC,",fnS",fnS,"fs",fs,"center",center,"deg",deg,"optimize",optimize,"name",name],help);
}


/** \name Spirale
\page Polygons
 module Spirale()
 * \brief creates a spiral polygon
 * ## Examples:
 * Spirale();  
 * Spirale(center=0,end=false,diff=5,grad=360);  
 * Spirale(center=0,end=false,diff=-10,scale=0.5,hull=false,grad=360)circle(1);
 * \param grad angle of rotation for the spiral
 * \param diff difference for 360°
 * \param radius,r1 start radius
 * \param r2 if given calculates diff for grad
 * \param rand the width of the spiral
 * \param fn fraqments for the spiral path
 * \param exp exponential change
 * \param center centers diff around radius
 * \param end if end circles applied false, true, 1 or 2
 * \param scale scale the end of the spiral
 * \param name name
 * \param help=true for help
*/

/*
Spirale(exp=1.0,diff=4,radius=10,grad=360,r2=undef,fn=200);
Tz(-.1)Color()circle(10);
Tz(-0.09)Color(.1)circle(6);
// */


module Spirale(grad=400*1,diff=2,radius=10,r1,r2,rand=n(2),$d,detail,fn=fn,exp=1,center=false,hull=true,end=2,old=false,scale=1,name,help){
   detail=fn;//compatibility
   advance=grad/detail; 
    rand=is_undef($d)?rand:$d;
    $d=rand;
    radius=is_undef(r1)?radius:center&&is_num(r2)?r1-r2/2:r1;
    iDiff=is_undef(r2)?diff:center?(radius-r2)/grad*360*2:(radius-r2)/grad*360;
    //diff=is_undef(r2)?diff:center?(radius-r2)/grad*360*2:(radius-r2)/grad*360;
    
    
       
    // * // recursive calculation
    function expDiff(diff=iDiff)=assert(exp>0)pow( (abs(diff/360*grad)), exp )*sign(diff);
    
    function diffAdj(f=1)=
    let(ratio=expDiff(iDiff*f)/(iDiff/360*grad))
    exp>1?ratio<=1+0.00000001?f:
                   diffAdj(f-f/100):
          ratio>=1-0.00000001?f:
                   diffAdj(f+ f/100)
    ;

    //echo(expDiff(iDiff*diffAdj())/(iDiff/360*grad),diffAdj());
    diff=is_undef(r2)?pow(iDiff,1/exp):
                      iDiff*(exp==1?1:diffAdj());
    // */
    
 /*
    diff=is_undef(r2)?pow(iDiff,1/exp):
                      pow(iDiff/360*grad,1/exp);
// */

 //center=is_undef(r2)?center:false;
 
 
/*
pointsOld=!$children?center?[
    for(i=[0:fn])RotLang(i*-grad/fn,diff/2/360*grad+radius-rand/2-pow(i*(diff/360*grad)/(fn),exp)),
    for(i=[fn:-1:0])RotLang(i*-grad/fn,diff/2/360*grad+radius+rand/2-pow(i*(diff/360*grad)/(fn),exp))]
    :[// center=false
for(i=[0:fn])RotLang(i*-grad/fn,radius-rand/2-pow(i*(diff/360*grad)/(fn),exp)),
for(i=[fn:-1:0])RotLang(i*-grad/fn,radius+rand/2-pow(i*(diff/360*grad)/(fn),exp))]
    :[0];// $children=true ⇒ deactivate point calculation
*/

path=[
  for(i=[0:fn])RotLang(
    i*-grad/fn, (center?diff/2/360*grad:0) + radius- pow( abs(diff/360*grad)*i/fn,exp)*sign(diff) )
];

points=concat(
  pathPoints(points=[[ rand/2,0]], path=path, 2D=true, scale=scale),
  pathPoints(points=[[-rand/2,0]], path=path, 2D=true, scale=scale, rev=true)
  );


if(!$children&&!old)rotate(center?-grad/2:0)union(){
    rotate(-90) polygon(points);
   if(b(end,false)>0) rotate(0)T((center?diff/2/360*grad:0)+radius)circle(d=rand,$fn=36);
   if(b(end,false)<0||end==2) rotate(grad)T((center?diff/2/360*grad:0)+radius-pow(grad/360*abs(diff),exp)*sign(diff))circle(d=rand*scale,$fn=36);
    
}

if(!$children&&old)// compatibility old version
    for(i=[center?-grad/2:0:advance:(center?grad/2:grad)-minVal]){
    j=i+advance;    
        Color(i/((center?grad/2:grad)-minVal))hull(){
        rotate(i)T(radius-pow(i/360*diff,exp))circle(d=rand,$fn=36);
        rotate(j)T(radius-pow(j/360*diff,exp))circle(d=rand,$fn=36); 
        }           
    }
    
if ($children)    for(i=[center?-grad/2:0:advance:(center?grad/2:grad)-minVal]){
    j=i+advance;
    $idx=i;
      if(hull) Color(i/((center?grad/2:grad)-minVal),$idxON=false) hull(){
        
        rotate(i)T(radius-pow(i/360*diff,exp))children();
        rotate(j)T(radius-pow(j/360*diff,exp))union(){$idx=j;children();} 
        } 
      else {
        if(i==0||i==-grad/2)rotate(i)T(radius-pow(i/360*diff,exp))children();
        rotate(j)T(radius-pow(j/360*diff,exp))children();
        
      }
            
            
    }
 
    //langold=( 2*radius-diff )* PI/360*grad;echo(langold);
    lang=pathLength(path);
    randEnd=end==true||b(end,false)>0?rand/2 + (end==2?rand/2*scale :0) : 0;
 InfoTxt("Spirale", ["Länge ",lang+randEnd ],name);
     
 HelpTxt("Spirale",[
   "grad",grad,
   "diff",diff,
   "radius",radius,
   "r1",r1,
   "r2",r2,
   "rand",rand,
   "$d",$d,
   //detail=",detail,"
   "fn",fn,
   "exp",exp,
   "center",center,
   "hull",hull,
   "end",end,
   "old",old,
   "scale",scale,
   "name",name],
   help);
}




module Box(x=8,y,z=5,d2,c=3.5,s=1.5,eck=4,outer=true,fnC=36,fnS=24,help){
  red=c>s?c:s;
  
  x=is_num(y)||outer?x:
                    Umkreis(eck,x-red)+red;
  d2=is_undef(d2)?x:
                  outer?d2:
                        Umkreis(eck,d2-red)+red;

  hErr=s/2-cos(90/ceil(fnS/2))*s/2+.00001; // missing sphere piece
  z=z+hErr*2;

  T(z=z/2-hErr)  minkowski(){
    if(is_num(y))cube([x -red, y -red, z-s-minVal],center=true);
        else cylinder(h=z -s -minVal, d1=x -red, d2=d2 -red, $fn=eck, center=true);
    if(c>s)cylinder(minVal,d=c-s,center=true,$fn=fnC);
    //OctaH(d=s,n=fnS);
    sphere(d=s,$fn=fnS);
    }
    
HelpTxt("Box",["x",x,"y",y,"z",z,"d2",d2,"c",c,"s",s,"eck",eck,"outer",outer,"fnC",fnC,"fnS",fnS],help);
}





module Kassette(r1=2,r2,size=20,h=0,gon=3,fn=fn,fn2=36,r=+0,grad=90,grad2=90,spiel=0.003,mitte=true,sizey=0,basis=1,2D=false,name,help)
{
  r2=is_undef(r2)?r1:r2;  
HelpTxt("Kassette",["r1",r1,"r2",r2,"size",size,"h",h,"gon",gon,"fn",fn,",fn2=",fn2,"r",r,"grad",grad,"grad2",grad2,"spiel",spiel,"mitte",mitte,"sizey",sizey,"basis",basis,"2D",2D,"name",name],help);
    if(help){
      echo("r1 r2 size — radius unten, oben und durchmesser");
      echo("h gon fn fn2 r — höhenzusatz, ecken, fn, fn2 des profils und eckradius"); 
      echo(" spiel mitten sizey name— , spielüberlappung Innenpolygon, mitten loch bei gon=2 und y-weite bei gon=4, name=name für Info"); 
    }

sizey=sizey?sizey:is_list(size)?size.y:size;
size=is_list(size)?size.x:size;

    r1I=min(r1,size/2-2*r2);//unten innen radius when mitte=1
    points=concat(
        kreis(r=r1,grad=-90,fn=fn2/4,rand=0,rot=-90,center=false,t=[size/2+r1,r1]), //r1 unten
        [[r1+size/2,-basis]], //unten aussen
        [[0,-basis]],//unten mitte
        [mitte?[0,r1+r2+h]:[0,0]],  //oben mitte
        mitte?[[size/2-r2,r1+r2+h]]:Kreis(r=r1I,grad=-90,fn=fn2/4,rand=0,rot=+180,center=false,t=[size/2-r2*2-r1I,r1I]),
        kreis(r=r2,rot=mitte?0:-90,grad=mitte?90:180,fn=mitte?fn2/4:fn2/2,rand=0,center=false,t=[size/2-r2,h+r1])// r2 oben
        );
 

    if(2D)polygon(points,convexity=5);
    else{
    
    if(gon>2)
      Rundrum(eck=gon,r=r,x=(size-r2*2)/(gon==4?1:2),y=(sizey-r2*2),fn=fn,grad=grad,grad2=grad2,help=0,name=name)intersection(){
        T(-size/2+r2)polygon(points,convexity=5);
         if(mitte) translate([-r,-250])square(500);
      }
    
    if(gon<3)RotEx(help=0,fn=fn)polygon(points,convexity=5);

    if(mitte&&gon>2){
          if(gon!=4)translate([0,0,-basis])rotate(gon==4?45:0)linear_extrude(basis+h+r2+r1,convexity=5)
            Rund(r,fn=fn)circle(r=Umkreis(gon,(size-r2*2))/2+spiel,$fn=gon);
       if(gon==4)translate([0,0,-basis])linear_extrude(basis+h+r2+r1,convexity=5)offset(spiel)Quad(x=size-r2*2,y=sizey-r2*2,grad=grad,grad2=grad2,r=r,help=0,name=0,fn=fn);
      }
    }
if(name)echo(str(is_bool(name)?"":"<H3>",name," Kassette - Höhe=",h+r1+r2,"mm (+",basis," basis)"));
    if(h<0)echo(str("<H2><font color=red>",name," Kassette h=",h,"mm ⇒ NEGATIV!"));

}

/**
\name Gewinde()
Gewinde is a preloader for GewindeV4 and presets
\param presets e.g. "M2" or "M6" - metric ISO, "BSW1" for ½", "BSW2" for ¾" - "Flasche" for PCO28 Flasche2 with p=4 
*/

module Gewinde(
dn=6,
p=1,
kern,
breite,
rad1,
rad2,
winkel=60,
wand,
dicke=1,
mantel,
h,
gb,
innen=false,
grad=180*7,
start,// Einfädelstrecke
end,
korrektur=true,// verbreiterung durch gangwinkel
profil=false,
fn2=4,
fn,
fs=fs,
fa=fa,
cyl=true,
tz=0,
konisch=0,
center=true,
rund=false,
ratio,
spiel=.1,
name,
help,

s,w=0,g=1,rot2=0,r1=0,detail=fn,name,preset=0,translate=[0,0,0],rotate=[0,0,0],d=0,gd=0,r=0,help,endMod=true,new
){
dicke=is_undef(wand)?dicke:wand; // backward compatibility

  $info=is_undef($info)?false:$info;
 iso_Gewinde=[ //name,pSteigung,dn
  ["M1",0.25,1],
  ["M1.2",0.25,1.2],
  ["M1.6",0.35,1.5],
  ["M2",0.4,2],
  ["M2.5",0.45,2.5],
  ["M3",0.5,3],
  ["M3.5",0.6,3.5],
  ["M4",0.7,4],
  ["M4.5",0.75,4.5],
  ["M5",0.8,5],
  ["M6",1,6],
  ["M7",1,7],
  ["M8",1.25,8],
  ["M9",1.25,9],
  ["M10",1.5,10],
  ["M12",1.75,12],
  ["M14",2,14],
  ["M16",2,16],
  ["M20",2.5,20],
  ["M24",3,24],
  ["M30",3.5,30]
] ;


other_Gewinde=[//search0, pSteigung,dn,winkel,name
["search","p-Steigung[1]","dn[2]","kern[3]","breite[4]","rad1[5]","rad2[6]","winkel[7]","name[8]","grad[9]"], // Spalten
["BSW1",1.814,20.955,20.955-0.640327*1.814*2,undef,0.13732908*1.814,0.13732908*1.814,55,"½-Zoll"],//halb Zoll
["BSW2",1.814,26.441,26.441-0.640327*1.814*2,undef,0.13732908*1.814,0.13732908*1.814,55,"¾-Zoll"],// 3/4 Zoll
["Flasche"    ,3.18, 27.43,24.95, 1, 0.4, 0.4, 40,"PCO-28 TPI8",810],// Flasche 28mmHalsring TPI=8
["Flasche2"   ,4.23, 27.43,24.95, 1, 0.4, 0.4, 40,"PCO-28 TPI6"],// Flasche Badeschaum TPI=6
];


 // Zeilennr für Suchbegriff [preset]   
 zeile=preset[0]=="M"?search([preset],iso_Gewinde)[0]:
        search([preset],other_Gewinde)[0];
  
    
   if(is_num(useVersion) && useVersion<19.88 && is_undef(new) || new==false){// old Version
       Echo(str("Using GewindeV2,useVersion=",useVersion),color="warning");
       if($children)GewindeV2(dn=dn,s=s,w=w,g=g,winkel=winkel,rot2=rot2,r1=r1,kern=kern,fn=fn<20?fn:1,detail=detail,spiel=spiel,name=name,tz=tz,preset=preset,h=is_undef(h)?grad/360*p:h,translate=translate,rotate=rotate,d=d,gd=gd,r=r,center=center,help=help,p=p,endMod=endMod)children();
       else  GewindeV2(dn=dn,s=s,w=w,g=g,winkel=winkel,rot2=rot2,r1=r1,kern=kern,fn=fn<20?fn:1,detail=detail,spiel=spiel,name=name,tz=tz,preset=preset,h=is_undef(h)?grad/360*p:h,translate=translate,rotate=rotate,d=d,gd=gd,r=r,center=center,help=help,p=p,endMod=endMod);
    }
  else if(is_num(zeile)){ // presets
      
      //metric
    if(preset[0]=="M"){
      GewindeV4(
        p=iso_Gewinde [zeile][1],
        dn=iso_Gewinde[zeile][2]+(innen?spiel*2:0),
        grad=grad,h=h,winkel=60,name=iso_Gewinde[zeile][0],
        innen=innen,dicke=dicke,mantel=mantel,cyl=cyl,tz=tz,start=start,
        end=end,fn=fn,fs=fs,fa=fa,fn2=fn2,center=center,rund=rund,ratio=ratio,spiel=spiel,profil=profil,help=help);
    if($children)difference(){
      children();
        if(innen)Tz(center?tz-iso_Gewinde[zeile][1]/2:
                           tz)cylinder(is_undef(h)?(grad+360)*iso_Gewinde[zeile][1]/360:
                                                   h,d=iso_Gewinde[zeile][2]+spiel*4,$fn=fn);
    }
     // other
    }else if(preset){
        if(preset=="search")echo(zeile=zeile,Txt=other_Gewinde[zeile]);
        else {
            GewindeV4(
            p=other_Gewinde [zeile][1],
            dn=other_Gewinde[zeile][2]+(innen?spiel*2:0),
            kern=is_undef(other_Gewinde[zeile][3])?undef:other_Gewinde[zeile][3]+(innen?spiel*2:0),
            breite=is_undef(breite)?other_Gewinde [zeile][4]:breite,
            rad1=is_undef(rad1)?other_Gewinde [zeile][5]:rad1,
            rad2=is_undef(rad1)?other_Gewinde [zeile][6]:rad2,
            winkel=other_Gewinde [zeile][7],
            dicke=dicke,mantel=mantel,innen=innen,
            grad=is_undef(grad)?other_Gewinde [zeile][9]:grad,
            h=h,
            start=start,end=end,center=center,profil=profil,fn2=fn2,
            fn=fn,fs=fs,fa=fa,cyl=cyl,tz=tz,rund=rund,ratio=ratio,spiel=spiel,
            name=other_Gewinde[zeile][8],
            help=help);
            
        }
    }
    
  
    
  }
  
      else{ info=$info;
        Polar(g,r=innen?g%2?0:180/g:0,name=false){
        $tab=is_undef($tab)?0:$tab-1;
        $info=info;
        GewindeV4(p=p,
                dn=dn,
                kern=kern,
                breite=breite,
                rad1=rad1,
                rad2=rad2,
                winkel=winkel,
                dicke=dicke,
                mantel=mantel,
                h=h,
                gb=gb,
                innen=innen,
                grad=grad,
                start=start,// Einfädelstrecke
                end=end,
                korrektur=korrektur,// verbreiterung durch gangwinkel
                profil=profil,
                fn2=fn2,
                fn=fn,
                fa=fa,
                fs=fs,
                cyl=cyl,
                tz=tz,
                konisch=konisch,
                center=center,
                rund=rund,
                ratio=ratio,
                spiel=spiel,
                name=name,
                g=g,
                help=help); 
       }
               Echo(str("Gewinde preset=",preset," Not found! \n BSW1 BSW2 \n Flasche Flasche2 M1-M30 "),color="red",condition=preset);
               if($children)difference(){
                  children();
                    if(innen)Tz(center?tz-p/2:tz-0)cylinder(is_undef(h)?grad*p/360+p:h,d=dn+spiel*2,$fn=fn);
                }      
               
            }
    
}


//GewindeV4(cyl=0,konisch=10);
//Gewinde(cyl=0,winkel=120,g=3);



module GewindeV4(
dn=6,// Diameter nominal
p=1,// Pitch per revolution
kern,//  Core diameter (⇐ dn)
breite,// thickness of end rounding
rad1, // rounding radius 1 (⇐ p g rund breite)
rad2,//  rounding radius 2 (⇐ p g rund breite)
winkel=60,// inclusive thread angle e.g 29 for ACME or 55 for BSW can be list [10,40] for buttress
wand,// wall thickness (⇐ mantel)
dicke=1,
mantel,// inner or outer shell diameter (↦ wand)
h, // height (↦ grad)
gb, // thread path height (⇐ p)
innen=false, // inner or outer thread
grad=180*7,// degres (⇐ h)
start,// Einfädelstrecke//  primed start angle
end, // angle for primed End
korrektur=true,// verbreiterung durch gangwinkel// correction of profil angle according to pitch
profil=false, // show profile polygon used
fn2=4, // profile roundingfragments
fn,//  thread fragments per revolution
fs=fs,
fa=fa,
cyl=true,// add cylinder (h,d=Kern);
tz=0, //  move thread z
konisch=0,// tapered thread angle
center=true,// center thread
rund=false, // round thread (↦ rad1 rad2)
ratio,// ratio between threads and space (↦ breite)
spiel=.1,//unused used at Gewinde innen=true// clearance only for presets inner threads
g=1,// number thread starts only for  autosizing
name,
help
){
  konisch=innen?konisch:-konisch;
  halbWinkel=is_list(winkel)?winkel:[winkel/2,winkel/2];
  Kwinkel=[90-halbWinkel[0],90-halbWinkel[1]];// Komplement winkel
    //winkel=is_list(winkel)?[90-winkel[0],90-winkel[1]]:[90-winkel/2,90-winkel/2];
    
    gver=pow(g,1.5);//autocalc for g

    center=is_num(center)?center:center==true?1:0;


    kern=is_undef(kern)?
          winkel==60?innen?round((dn-p*1.08/gver)*100)/100:round((dn-p*1.225/gver*+1)*100)/100
                    :runden(innen?dn-p/g/1.6/tan(max(halbWinkel)):dn-p/g/1.42/tan(max(halbWinkel)),2)
                      :kern;
    dn=is_undef(dn)?innen?round((kern+p*1.08/gver)*100)/100:round((kern+p*1.225/gver)*100)/100:dn;
    fn=is_undef(fn)||fn==0?fs2fn(r=max(kern,dn)/2,fs=fs,minf=36,fa=fa):ceil(fn);
    start=ceil(is_undef(start)?fn/3:fn/360*start);
    end=is_undef(end)?start:ceil(fn/360*end);    
    dicke=is_undef(wand)?dicke:wand;
    wand=is_undef(mantel)?innen?dicke:dicke>kern/2?0:dicke:abs(mantel-kern)/2;
    d1=innen?-kern:dn;//Gewindespitzen
    d2=innen?-dn:kern;//Gewindetäler
    grad=max(//windungen
      is_undef(h)?grad-(grad%(360/fn)):(h-p)/p*360-(((h-p)/p*360)%(360/fn)-360/fn),
    360/fn*(start+end))
    ;
  
  
    winkelP=atan(p/((d1+d2)/2*PI));//Steigungswinkel
    profilkorrekturY=korrektur?1/sin(90+winkelP):1;
    gb=is_undef(gb)?p/profilkorrekturY:gb; // gangBreite axial
  
    mantel=(is_undef(mantel)?innen?d2-wand*2
                                 :wand?kern-wand*2
                                      :kern/2+0.0001
                          :innen?-max(mantel,0.0001)
                                :max(mantel,0.0001)) + ( 2*p*tan(abs(konisch)) ) ;//innenloch /aussenmantel

    gangH=(d1-d2)/2; // gang Höhe radial (H)
    h=grad*p/360+p;
    flankenBreite=[tan(halbWinkel[0])*gangH,tan(halbWinkel[1])*gangH];
    gi=grad<360/g?1:g;
    breite=is_undef(ratio)||!ratio?is_undef(breite)?gb/gi/8:
                                                    breite:
                                   (gb/gi-flankenBreite[0]-flankenBreite[1])/2*(b(ratio,false));


    breite2=gb/gi -breite -flankenBreite[0] -flankenBreite[1];

    rad1Max=min(breite /2/tan(Kwinkel[0]/2),breite /2/tan(Kwinkel[1]/2));
    rad2Max=min(breite2/2/tan(Kwinkel[0]/2),breite2/2/tan(Kwinkel[1]/2))-.05;
    
    Echo(str(name," Gewinde rad1 zu groß ",rad1,">",rad1Max),color="red",
      condition=is_num(rad1)&&rad1>rad1Max);
    Echo(str(name," Gewinde rad2 zu groß ",rad2,">",rad2Max),color="red",
      condition=is_num(rad2)&&rad2>rad2Max);                

    rad1=min(rad1Max,b(rund,false)==1||b(rund,false)==2?rad1Max:
              is_undef(rad1)?p/20/gi:
                             rad1);

    rad2=min(rad2Max,b(rund,false)==1||b(rund,false)==3?rad2Max:
              is_undef(rad2)?p/10/gi:
                             rad2);

    step=180/max(start,end,1);


InfoTxt(innen?" Innengewinde ":" Außengewinde ",[
"dn",dn,//"(",innen?d2:d1,")
 "Steigung",p,
 "Kern",kern,
 "Mantel",mantel,
 "Winkel",winkel[0]==winkel[1]?halbWinkel[0]*2:halbWinkel,
 "Gangwinkel",winkelP,
 "h",h,
str(grad/360," Windungen ("),str(grad,"°)"),
"Ganghöhe",gangH]
,name);

 /*tangYold=[rad1*sin(winkel[0])-tan(90-winkel[0])*(rad1-cos(winkel[0])*rad1), 
           rad1*sin(winkel[1])-tan(90-winkel[1])*(rad1-cos(winkel[1])*rad1)];// */
  tangY=[tan(Kwinkel[0]/2)*rad1,tan(Kwinkel[1]/2)*rad1];


Echo(str(name," Gewinde Überlappung! breite2=",negRed(breite2)),color=breite==0?"warning":"red",condition=0>=breite2);
//Echo(str(name," Gewinde Zero breite2",negRed(breite2)),color="red",condition=0==breite2);

Echo(str(name," Gewinde breite=",breite," is bigger (",(tangY[0]+tangY[1]),
  ") rad1(",rad1,"),rad1 max=",rad1Max,
  " p/16= ",p/16),condition=tangY[0]+tangY[1]>breite);
  
//,if (breite==0&&rad1>p/16)echo(str("<b><font color=red>",name," Gewinde breite=0 rad1>p/16= ",p/16));

HelpTxt("Gewinde",
["p",p
,"dn",dn
,"kern",kern
,"breite",breite
,"rad1",rad1
,"rad2",rad2
,"winkel",halbWinkel[0]==halbWinkel[1]?halbWinkel[0]*2:halbWinkel
,"dicke",dicke
,"mantel",abs(mantel)
,"h",h
,"gb",gb // gang breite gesamt
,"innen",innen
,"grad",grad
,"start",start// Einfädelstrecke in grad
,"end",end
,"korrektur",korrektur// verbreiterung durch gangwinkel
,"profil",profil // 2D Ansicht
,"fn2",fn2
,"fn",fn
,"fs",fs
,"fa",fa
,"cyl",cyl
,"tz",tz
,"konisch",konisch
,"center",center
,"rund",rund
,"ratio",ratio
,"spiel",spiel
,"g",g
,"name",name   
],help);

points=[
    for(i=[0:max(start +1,end +1,5)])vollwelle(fn=fn2,l=gb,h=start?gangH*(0.5+sin(i*step-90)/2):gangH,r=rad1,r2=rad2,tMitte=breite,
      grad=start?[max(Kwinkel[0]*sin(i*.5*step+0),1),max(Kwinkel[1]*sin(i*.5*step+0),1)]:
                 Kwinkel,
      grad2=[-konisch,konisch],extrude=d2/2,x0=mantel/2,xCenter=-1,minF=fn2)   
    ];
 
profilnr=max(start,end);
pointskorr=[for(i=[0:len(points[profilnr])-1])[points[profilnr][i][0],points[profilnr][i][1]*profilkorrekturY]];

detail=fn*grad/360;


function faces1(points,start=0)=[[for(i=[0:len(points)-1])i+start]];//bottom
function faces0(points,start=0)=[[for(i=[len(points)-1:-1:0])i+start]];//Top
function faces2(points,start=0)=[for(i=[+0:len(points)-1])each[ //start/end Gang komplett
    [i+start,i+start+1,i+len(points)+start],//skin tri 1
    [i+start,i+len(points)+start,i+len(points)-1+start]//skin tri 2
]];
function faces3(points,start=+0)=[for(i=[2:len(points)-2])       //outer Wall
    [i+start,i+1+start,i+start+len(points)+1,i+start+len(points)]//skin quad
];
function faces31(points,start=+0)=[for(i=[len(points)-2])       //outer Wall (Innengew)
    [start+i,1+start+i,start+len(points)+1+i,start+len(points)+i]//skin quad
];
function faces4(points,start=+0)=[for(i=[0])                    //inner Wall
    [start+i,1+start+i,start+len(points)+1+i,start+len(points)+i]//skin quad
];
function faces41(points,start=+0)=[for(i=[0:len(points)-4])       //inner Wall(Innengew)
    [i+start,i+1+start,i+start+len(points)+1,i+start+len(points)]//skin quad
];
function faces5(points,start=+0)=[for(i=innen?[len(points)-3]:[1])                   //floor 
    [i+start,i+1+start,i+start+len(points)+1,i+start+len(points)]//skin quad
];
function faces6(points,start=+0)=[for(i=innen?[len(points)-1]:[-1])                   // ceil 
    [1+start+i,start+len(points)+1+i,start+len(points)*2+i,start+len(points)+i]//skin quad
];

function RotEx(rot=0,points=points,verschieb=tan(konisch),steigung=p,detail=fn,start=start,end=end)=
[for(rotation=[0:detail*rot/360])for(i=innen?[0:len(points[0])-1]:[len(points[0])-1:-1:0])
[ // Punkt
if(rotation<detail*rot/360-end)(points[min(rotation,max(start,end))][i][0]+verschieb*rotation/detail*steigung)*sin(rotation*360/detail) //⇐ normal
    else (points[detail*rot/360-rotation][i][0]+verschieb*rotation/detail*steigung)*sin(rotation*360/detail),
if(rotation<detail*rot/360-end)profilkorrekturY*points[min(rotation,max(start,end))][i][1]+rotation/detail*steigung //⇐ normal
    else profilkorrekturY*points[detail*rot/360-rotation][i][1]+rotation/detail*steigung,
if(rotation<detail*rot/360-end)(points[min(rotation,max(start,end))][i][0]+verschieb*rotation/detail*steigung)*cos(rotation*360/detail) //⇐ normal
    else (points[detail*rot/360-rotation][i][0]+verschieb*rotation/detail*steigung)*cos(rotation*360/detail) 
] // Punkt end
];

facesALL=concat(
faces0(points=RotEx(+0))//floor endcap
,faces1(points=RotEx(0),start=len(RotEx(grad))-len(RotEx(0)))//top endcap

//Outer wall
,[if(innen)for(level=[0:detail-1])each faces31(points=RotEx(0),start=(len(RotEx(0)))*level)
    else for(level=[0:detail-1])each faces3(points=RotEx(0),start=(len(RotEx(0)))*level)]
//inner wall
,[if(innen)for(level=[0:detail-1])each faces41(points=RotEx(0),start=(len(RotEx(0)))*level)
   else for(level=[0:detail-1])each faces4(points=RotEx(0),start=(len(RotEx(0)))*level)]
// bottom wall
,[if(konisch==0)for(level=[0:(fn*min(1,grad/360))- 1])each faces5(points=RotEx(0),start=(len(RotEx(0)))*level)
   else for(level=[0:detail- 1])each faces5(points=RotEx(0),start=(len(RotEx(0)))*level)]
//upper wall
,[if(konisch==0)for(level=[detail-(fn*min(1,grad/360)):detail- 1])each faces6(points=RotEx(0),start=(len(RotEx(0)))*(level-(innen?1:+0)))
   else for(level=[0:detail- 1])each faces6(points=RotEx(0),start=(len(RotEx(0)))*(level-(innen?1:+0)))]
);

pointsALL=RotEx(grad);//3D
if(profil)!Linear(x=0,y=1,es=p)polygon(points=pointskorr); 
  else Tz(center?center<0?-p/2+tz:tz:tz+p/2)color(innen?"slategrey":"gold"){
        R(90,0,90) polyhedron(points=pointsALL,faces=facesALL,convexity=5);
//cylinder body    
        if(cyl)Tz(-p/2){
          if(!konisch)linear_extrude(h,convexity=5,scale=1+h*tan(konisch)/(d2/2))Kreis(r=d2/2-.000001,rand=innen?max(wand,+0.0001):mantel<0.01?0:wand,fn=fn,name=0);

// konisch
         else {
          d2=abs(d2)+p*tan(konisch)* (innen?1:-1);//korrecktur da d2 Gewindespitze
         if(innen) difference(){
              cylinder(h=h,d1=d2+wand*2,d2=(d2+wand*2)*scaleGrad(grad=90-konisch,h=h,r=d2/2+wand),$fn=fn,$fs=fs,$fa=fa);
              Tz(-.01)cylinder(h=h+.02,d1=d2,d2=d2*scaleGrad(grad=90-konisch,h=h+.02,r=d2/2),$fn=fn,$fs=fs,$fa=fa);
         } else difference(){
              cylinder(h=h,d1=d2,d2=d2*scaleGrad(grad=90+konisch,h=h,r=d2/2),$fn=fn,$fs=fs,$fa=fa);
              if(d2-wand*2>0) Tz(-.01)cylinder(h=h+.02,d1=d2-wand*2,d2=(d2-wand*2)*scaleGrad(grad=90+konisch,h=h+.02,r=d2/2-wand),$fn=fn,$fs=fs,$fa=fa);
         }
       }
    //Ring(h=h,rand=wand,d=abs(d2),cd=innen?-1:1);
    }
  }

}




/** \name Coil \page Objects
Coil() creates a coil
\param r radius of the coil
\param d diameter of the coil wire
\param r2 end radius for conical coils
\param od id optional outer inner diameter ↦ r and d
\param grad windings
\param p pitch
\param h height ↦ p or grad
\param points  allows other profiles as points
\param twist  twist profile towards end
\param scale profile towards end
\param fn fs fs fraqment number size angle
\param fn2 fragmentsize for d (if undef then fs fa is used)
\param center centers coil
\param open  creates end surfaces
\param convexity convexity of polyhedron
\param name name
\param help help
*/

//Coil(h=20,scale=.5,center=-1);


module Coil(
r=20,
d=5,
r2,
od,
id,
grad=3*360,
p,
pitch=10,
h,
points,
twist=0,
scale=1,
fn,fn2,fs=fs,fa,
center=true,
open=true,//open Path
convexity=15,
name,
help){

d=is_num(od)&&is_num(id)?(od-id)/2 : d;
r=is_undef(points)?is_num(od)?(od-d)/2:is_num(id)?(id+d)/2:r:r;
r2=is_undef(r2)?r:r2;
fn=is_undef(fn)||fn<1?fs2fn(fs=fs,r=max(abs(r),abs(r2)),fa=fa,minf=36):fn;
fn2=is_undef(fn2)||fn<4?fs2fn(fs=fs,r=d/2,minf=12):fn2;
p=is_undef(p)?pitch:p;
$d=d;
Echo("Coil using points - od, id, h or d can't compute",color="warning",condition=points&&od||points&&id);
Echo("Coil intersecting",color="warning",condition=!points&&norm([(r-r2)/grad*360,pitch])<d);
scale=is_list(scale)?scale:[scale,scale];

ipoints=is_undef(points)?arc(r=d/2,fn=fn2,deg=360,z=0):points;
grad=is_undef(grad)?(h-d/2-d/2*scale.y)/p*360
                   :grad;

pitch=is_undef(h)?p:(h-d/2-d/2*scale.y)/grad*360;
h=abs(pitch*grad/360+d/2+d/2*scale.y);
Echo("Coil h < d",color="warning",condition=h<d);

iFN=ceil(fn*abs(grad)/360*max(1,twist/360/3));

path=[for(i=[iFN:-1:0])
let(deg=grad/iFN,
p=is_undef(p)?pitch/360*abs(deg):p/360*abs(deg),
rDiff=(r2-r)/iFN
)
[sin(i*deg)*(r+rDiff*i),cos(i*deg)*(r+rDiff*i),p*i]];

translate([0,0,center?b(center,false)<0?-h/2+d/2
                               :0
                      :d/2])
  PolyH(
          pathPoints(ipoints,path,twist=twist,scale=scale,open=open),
        loop=len(ipoints),name=false,convexity=convexity);
      
InfoTxt("Coil",concat(["length",pathLength(path),"heigth(h)",h,"grad",grad,"turns",grad/360],pitch?["pitch",pitch]:[],r==r2?[]:["endRadius r2",r2] ),name);
HelpTxt("Coil",["r",r,"d",d,"r2",r2,"od",od,"id",id,"grad",grad,"pitch",is_undef(p)?pitch:p,"h",h,"points","kreis(d=d)","twist",twist,"scale",scale,"fn",fn,"fn2",fn2,"fs",fs,"fa",fa,"center",center,"open",open,"convexity",convexity],help);
}



module DBogen(
grad=25,
x=50,
rad2=3,
rad,
base=+0,
fn,
fs=fs,
messpunkt=false, 
spiel=.001,
name,
help
){
 
l=x;

a=is_undef(grad)?2*asin((rad2-l/2)/(rad2-rad))
    :grad;

r2=rad2*sign(180-a);    //vorzeichen mod für große winkel
a2=90-a/2; //(180-a)/2;

r2x=r2-r2*sin(a/2);//cos(a2);
r=is_undef(grad)?rad:(l-r2x*2)/(2*sin(a/2));
    
h=r*cos(a/2);
r2h=r2*sin(a2);

if($parent_modules<2&&$messpunkt||messpunkt){
Caliper(abs(l),s=7,center=1,messpunkt=0,end=2,translate=[00,-2,0]);//color("red")cube([l,1,1],true);
Caliper(Sehne(r=r,a=a),s=7,center=1,messpunkt=0,end=2,translate=[00,-h+r2h+r+2,0]);
Caliper(-h+r2h+r,s=7,in=+2,center=0,messpunkt=0,end=2,translate=[00,+0,0]);
//color("yellow")cube([1,h,1],false);
//color("green")T(-l/2,r2h)cube([r2x,.1,2]);
    Pivot([0,-h+r2h],active=[1,0,0,1,1],messpunkt=messpunkt);
}
InfoTxt("DBogen",["radius",str(r,"mm"),"center r",-h+r2h,"∅",str(2*r,"mm"), "r2",r2,"h",str(-h+r2h+r,"mm")],name);//
    
if(!$children&&name)Echo("DBogen has no 2D-Object, ⇒ polygon",color="black");
HelpTxt("DBogen",[
"grad",grad,
"x",x,
"rad2",rad2,
"rad",str(rad,"/*(",r,")*/"),
"base",base,
"fn",fn,
"fs",fs,
"messpunkt",messpunkt,
"spiel",spiel,
"name",name
],help);

   // echo($parent_modules);
 if($children){ 
   $tab=is_undef($tab)?1:b($tab,false)+1;
   $info=name;
   $messpunkt=false;
   $helpM=false;
   $idxON=false;
/*MKlon(my=1)if($idx<+1){
Col(1)T(y=-h+r2h)rotate(90)Kreis(r=r,rand=1,rcenter=true,grad=a);
MKlon(-l/2+r2,mx=1)rotate(90)Kreis(r=r2,center=false,rand=+1,rcenter=true,grad=a2);
}*/
T(y=-h+r2h)rotate(90)RotEx(grad=a+spiel,center=true,cut=sign(r),fn=max(12,is_undef(fn)?abs(kreisbogen(r,a+spiel)/fs):fn*2))T(r)children();
   union(){$idx=1;
    if(grad!=180)MKlon(l/2-r2,mx=1)RotEx(grad=a2+spiel,center=false,cut=sign(r2),fn=max(12,is_undef(fn)?abs(kreisbogen(r2,a2+spiel)/fs):fn))T(r2)children();
    if(base)R(90)linear_extrude(abs(base),convexity=5)MKlon(l/2,mx=1)children();    
  }
}
    else{
        rand=0;
        points=concat(
        [[l/2,base]]
        ,[[-l/2,base]]
        , kreis(r2,grad=a2,rand=rand,t=[-l/2+r2,0],rot=-90,center=false,fn=max(12,is_undef(fn)?kreisbogen(r2,a2)/fs:fn),sek=true)
        , kreis(r,grad=a,rand=rand,t=[0,-h+r2h],rot=90,fn=max(12,is_undef(fn)?kreisbogen(r,a)/fs:fn*2),sek=true)// Scheitelbogen
        , kreis(r2,grad=a2,rand=rand,t=[l/2-r2,0],rot=90-a2,center=false,fn=max(12,is_undef(fn)?kreisbogen(r2,a2)/fs:fn),sek=true)
        );
        polygon(points);
    }
}


//SpiralCut(radial=false,ir=2.5,or=10,nozzle=.2)cylinder(10,d=10);
//SpiralCut(axial=true,ir=15,or=10);

module SpiralCut(h=20,ir=1,or=50,width=.03,x,t=0,grad,cuts,radial=true,line,layer,axial,name,help){
 
 t=is_num(t)?[0,0,t]:t;
 x=abs(is_undef(x)?width:x);
 radial=is_undef(axial)?radial:!axial;
 
 layer=is_undef(layer)?l(1):layer;
 line=is_undef(line)?n(1):
                     max(line,.1);
 
 r=min(ir,or);
 sizeY=abs(or-ir);
 
 cuts=is_undef(cuts)?radial?ceil(h/layer):
                            floor(360/gradB(b=line*2+x,r=r + line/2)):
                     floor(cuts);
                     
 winkel=is_undef(grad)? radial? gw:
                                  360/cuts:
                          grad;

Echo("outer diametern <= inner!",color="warning",condition=ir>=or);


 if(radial)
  if($children)difference(){
    children();
    translate(t)for(i=[0:cuts-1])rotate(i*winkel)T(-x/2,r,i*layer)cube([x,sizeY,layer]);
  }
  else translate(t)for(i=[0:cuts-1])rotate(i*winkel)T(-x/2,r,i*layer)cube([x,sizeY,layer]);
 else   if($children)difference(){ // axial cuts
    children();
    translate(t)for(i=[0:cuts-1])rotate(i*winkel)T(-x/2,r+line*sign(or-ir),0){
      if(h)cube([x,sizeY-line,h]);
      else square([x,sizeY-line]);
      }
  }
  else translate(t)for(i=[0:cuts-1])rotate(i*winkel)T(-x/2,r+line*sign(or-ir),0){
      if(h)cube([x,sizeY-line,h]);
      else square([x,sizeY-line]);
      }
  
  if($preview)if(!radial){
    if(or>ir)color("chartreuse",alpha=.3)translate(t) rotate(90)%cylinder(h,r=r,$fn=cuts);
    else color("skyblue",alpha=.3)translate(t) rotate(90)%Ring(h,r=r-line,rand=-(sizeY-line),fn=cuts,name=false,help=false);
  }

if(radial)InfoTxt("SpiralCut — Radial",["Winkel",winkel,"Layer",layer,"Cuts",cuts,"width",x,"ir",ir,"or",or],name);
else InfoTxt("SpiralCut — Axial",["Winkel",winkel,"line",line,"Cuts",cuts,"width",x,"ir",ir,"or",or],name);

HelpTxt("SpiralCut",[
   "h",h,
   "ir",ir,
   "or",or,
   "width",x,
   "t",t,
   "grad",winkel,
   "cuts",cuts,
   "radial",radial,
   "line",line,
   "layer",layer,
   "name",name],
    help);

}


module Zylinder(h=20,r=10,d,fn,fnh,grad=360,grad2=89,f=10,f2=5,f3=0,a=.5,a3=0,fz=0,az=0,deltaFz=0,deltaF=0,deltaF2=0,deltaF3=0,twist=0,winkelF3=0,scale=+1,sphere=0,lz,altFaces=1,center=false,lambda,fnE,name,help){
    a=is_undef(a)?0:a;
    r=is_undef(d)?is_undef(r)?0:
                            r:
                d/2;
    lambda=is_list(lambda)?lambda:[lambda,lambda];
    f=is_undef(lambda[0])?is_undef(f)?0:
                          f:
        round(PI*2*abs(r)/lambda[0]);
    f2=is_undef(lambda[1])?is_undef(f2)?0:
                            f2:
        round(abs(h)/lambda[1]*2)/2;    
    fn =max(is_undef(fn)  && is_undef(fnE)?f  *2 : is_undef(fnE)?fn  :fnE*f ,3);
    fnh=max(is_undef(fnh) && is_undef(fnE)?f2 *2 : is_undef(fnE)?fnh :fnE*f2,1);

    stepRot=grad/fn;
    stepH=h/fnh;
InfoTxt("Zylinder",["f",f,"f2",f2,"a",a,"lamda f",(2*PI*r)/f,"λ-f2",h/f2,"λ-f3",(2*PI*r)/f3,"λ-fz",h/fz,"r",str(r+a+a3+az,"/",r-a-a3-az),"d",str((r+a+a3+az)*2,"/",(r-a-a3-az)*2)],name);    
points=[for(z=[0:fnh],rot=[0:fn])RotLang(
    rot=rot*stepRot+twist*z/fnh+winkelF3*sin(rot*stepRot*f3+deltaF3),
    l=(1+(scale-1)*z/fnh)*(a*cos(rot*stepRot*f+deltaF)*cos(z*f2*360/fnh+deltaF2)+az*sin(z*fz*360/fnh+deltaFz)),
    lz=lz,
    z=sphere?undef:z*stepH,
    e=z*grad2/fnh
    )+
RotLang(
    rot=rot*stepRot+twist*z/fnh,
    l=(1+(scale-1)*z/fnh)*(r+a3*cos(rot*stepRot*f3)),
    lz=h,
    z=sphere?undef:0,//z*stepH,
    e=z*grad2/fnh
    )

];
//echo(points);

faces=[
if(altFaces==0)each[for(i=[-1:len(points)-fn-2])[i,i+1,i+2+fn,i+fn+1]],//0
if(altFaces==1)each[for(i=[0:1:len(points)-fn-3])each[                 //1
        if(i%2)[i,i+fn+2,i+fn+1]else [i,i+1,i+fn+1] ,
        if(i%2)[i+0,i+1,i+fn+2] else [i+1,i+fn+2,i+fn+1] ,
        //if(i<len(points)-fn-4)[i+1,i+fn+3,i+fn+2],
        //if(i<len(points)-fn-4)[i+1,i+2,i+fn+3]
    ]],
if(altFaces==2)each[for(j=[0:fnh-1])for(i=[0:fn+0])[j*(fn+1)+i,j*(fn+1)+i+1,(j+1)*(fn+1)+i+1,(j+1)*(fn+1)+i]],// fn fnh  2
if(altFaces==3)each[for(i=[0:len(points)-fn-3])each[[i,i+1,i+fn+1],[i+1+fn,i+1,i+fn+2]]],//3
if(altFaces==4)each[for(i=[-1:len(points)-fn-1])[i+fn-1,i,i+fn,i+fn+0]],// nur für 360grad 4
if(altFaces==5)each[for(i=[0:1:len(points)-fn-1])each[// nur für 360grad 5
        [i,i+fn+0,i+fn-1], [i,i+1,i+fn+0,i+fn-1] ,
        //[i+0,i+1,i+fn+1], [i+1,i+fn+1,i+fn+0]
        ]],
];

faces2=[[for(i=[fn+0:-1:+0])i],[for(i=[len(points)-fn-1:len(points)-1])i]];//top bottom

translate([0,0,center?-h/2:0])polyhedron(points,concat(faces2,faces),convexity=15);

HelpTxt("Zylinder",["h",h,"r",r,"d",d,"fn",fn,"fnh",fnh,"grad",grad,"grad2",grad2,"f",f,"f2",f2,"f3",f3,"a",a,"a3",a3,"fz",fz,"az",az,"deltaFz",deltaFz,"deltaF",deltaF,"deltaF2",deltaF2,"deltaF3",deltaF3,"twist",twist,"winkelF3",winkelF3,"scale",scale,"sphere",sphere,"lz",lz,"altFaces",altFaces,"center",center,"lambda",lambda,"fnE",fnE,"name",name],help);

}

/** \page Objects
Knurl() creates a knurled cylinder or cone
\param r radius
\param h height
\param size  size of knurl ↦ e  size.z can be list
\param e  optional numbers of knurls (size.z is needed)
\param scale  scale top
\param scaleZ scale knurl in Z (changes height)
\param twist twist
\param grad  full cylinder = 360
\param delta move knurl center
\param alt alternate depth axially if size.z is list
\param lambda ⇒ size
\param name
\param help
*/

//Knurl(size=[2.1,2,[1,-1]]);
//Knurl(size=[2.1,2,[1,-1]],alt=1);



module Knurl(r=10,h=20,size=[5,5,.7],depth,e,scale=1,scaleZ=1,twist=0,grad=360,delta=[0,0],alt=0,lambda,convexity,name,help){

sizeI=is_undef(lambda)?size:lambda;
size=is_num(sizeI)?[sizeI,sizeI,is_undef(depth)?sizeI/2:depth]:
                  concat(sizeI.xy,is_undef(depth)?[is_undef(sizeI.z)?min(sizeI)/2:sizeI.z]:[depth]);


e=is_undef(e)?[
    max(3,round( grad/(asin( (max(0.1,size.x/2))/r  )*2) ) ),
    max(1,round(h/size.y))
  ]:
             is_list(e)?e:[e,e];
             
delta=is_list(delta[0])?delta:[delta];
sizeZ=is_list(size.z)?size.z:[size.z];

convexity=is_undef(convexity)?round(map(e.x,[1,500],[5:30])):convexity;
             
realSize=[sin(grad/(e.x)/2)*r*2,h/e.y,size.z];
depthCord=r-Kathete(r,realSize.x/2);// height over cord⇔radius

lenZ=is_list(size.z)?len(size.z):1;
Echo(str("Irregular Knurl! e.x=",e.x," but len size.z=",lenZ,"↦  ↦",floor(e.x/lenZ)*lenZ,"⇐e.x⇒",ceil(e.x/lenZ)*lenZ),color="warning",condition=e.x%lenZ&&is_list(size.z));

loopX=grad==360?e.x-1:e.x;


InfoTxt("Knurl",["knurls",e,"size",realSize,"deg",[for (i=[0:len(sizeZ)-1])str("\n",atan2(-sizeZ[i],realSize.x/2+delta[i%len(delta)].x),"° | ",atan2(-sizeZ[i],(realSize.y/2+delta[i%len(delta)].y)),"°")],"edge",str((180-360/e.x),"°"),"CordDist",depthCord],name);

function KnurlP(r=10,h=20,depth=1,e=[10,10],scale=1,scaleZ=1,twist=0,grad=360,delta=[0,0],alt=0,depthCord=depthCord)=[
let(
  //alt=is_list(alt)?alt:[1],
  depth=is_list(depth)?depth:[depth],
  delta=is_list(delta[0])?delta:[delta],
  step=grad/e.x,
  stepZ=h/e.y/2,
  scaleRot=scaleZ,
  rot=grad/e.x/2
  )
 for(z=[0:e.y*2])
 let(
 r=scale==1?r:r-r*(1-scale)/e.y/2*z,

 stepZ=scaleZ==1?stepZ:stepZ-stepZ*(1-scaleZ)/e.y/2*z/2,
 depth=scaleZ==1?depth:depth-depth*(1-scaleZ)/e.y/2*z/2,
 delta=scaleZ==1?delta:delta-delta*(1-scaleZ)/e.y/2*z/2,
 stepRot=scaleRot==1?twist/e.y/2*z:twist/e.y/2*z-twist/e.y/2*(1-scaleRot)/e.y/2*z/2
 )
  if(z%2) for(i=[0:grad==360?(e.x -1):e.x])
    let(
      rot=(i<e.x?rot:0),
      depth=i<e.x?depth:[0],
      delta=delta[ (i+alt*floor(z/2))%len(delta) ],
      deltaRot=gradS(delta.x,r=r+depth[ (i+alt*floor(z/2))%len(depth) ] -depthCord)
      
    )
    [cos(i*step+stepRot+rot+deltaRot)*(r+depth[(i+alt*floor(z/2))%len(depth)]-depthCord),sin(i*step+stepRot+rot+deltaRot)*(r+depth[(i+alt*floor(z/2))%len(depth)]-depthCord),z*stepZ+delta.y]
  else    for(i=[0:grad==360?(e.x -1):e.x])[cos(i*step+stepRot)*r,sin(i*step+stepRot)*r,z*stepZ]


];


points=KnurlP(r=r,h=h,depth=size.z,e=e,scale=scale,scaleZ=scaleZ,twist=twist,grad=grad,delta=delta,alt=alt);

fBottom=[[for(i=[0:loopX])i]];
fTop=[[for(i=[loopX:-1:0])e.y*2*(loopX +1)+i]];

fBody=[for(z=[0:e.y-1],i=[0:loopX])each[
[(1+i)%(loopX+1), 0+i, (loopX+1)+i]+[1,1,1]*(loopX+1)*2*z,// bottom
[0+i, (loopX+1)*2+i, (loopX+1)+i]+[1,1,1]*(loopX+1)*2*z,// left
[(loopX+1)*2+(1+i)%(loopX+1), (1+i)%(loopX+1), (loopX+1)+i]+[1,1,1]*(loopX+1)*2*z,// right
[(1+i)%(loopX+1)+(loopX+1)*2, (loopX+1)+i, (loopX+1)*2+i]+[1,1,1]*(loopX+1)*2*z//top
]
];

faces=concat(
  fBottom,
  fTop,
  fBody
);

polyhedron(points,faces,convexity=convexity);
HelpTxt("Knurl",["r",r,"h",h,"size",size,"depth",depth,"e",e,"scale",scale,"scaleZ",scaleZ,"twist",twist,"grad",grad,"delta",delta,"alt",alt,"convexity",convexity,"name",name],help);
}

/** \name KnurlTri
\page Objects
KnurlTri() creates a triangle knurled cylinder or cone

\param e  number of sides of the base polygon and levels
\param r radius of base polygon
\param h height of knurl
\param depth height of surface tetrahedrons
\param deltaH  move center in Z
\param scale scales
\param lambda size tetrahedron
*/

//KnurlTri();



module KnurlTri(e=[16,9],r=10,h=30,depth=[1,+1],deltaH=[0,0],scale=1,lambda,name,help){
lambda=is_num(lambda)?[lambda,lambda*(sqrt(3)/2)]:lambda;
e=is_undef(lambda)?is_list(e)?e:[e,round(h/sqrt((sehne(r=r,n=e)*sqrt(3)/2)^2 - (r-Inkreis(e,r))^2  ) )]
                  : [round(360/gradS(s=lambda.x,r=r)),round(h/lambda.y)];
s=sehne(r=r,n=e[0]);
depth=is_list(depth)?depth:is_undef(depth)?s*sqrt(6)/3*[1,1]:[depth,depth];
deltaH=is_list(deltaH)?deltaH:[deltaH,deltaH];
winkel1=360/e[0];
levelH=h/e[1];


ir=Inkreis(e[0],r);
InfoTxt("KnurlTri",["Sehne",s,"winkel",2*atan2(s/2,norm([r-ir,levelH])),"Triangle Radius",str(norm([r-ir,levelH])/1.5,"/",s*sqrt(3)/3),"depth",depth,"e",e,"levelH",levelH],name);
HelpTxt("KnurlTri",["e",e,"r",r,"h",h,"depth",depth,"deltaH",deltaH,"scale",scale,],help);

points=[
for(level=[0:e[1]])
let(
ri=r+r*(scale-1)/e[1]*level,
hCell=norm([ri - Inkreis(e[0],r+r*(scale-1)/e[1]*(level+1)) , levelH] ),
//hCell2=norm([Inkreis(e[0],ri) - r+r*(scale-1)/e[1]*(level+1) , levelH] ),
depth=depth+depth*(scale-1)/e[1]*level,
tilt1=atan2( Inkreis(e[0],ri)-(r+r*(scale-1)/e[1]*(level+1)),   levelH ),
tilt2=atan2( ri - Inkreis(e[0],(r+r*(scale-1)/e[1]*(level+1))), levelH ),
zero1=[-sin(tilt1)*(hCell/3+deltaH[0]),cos(tilt1)*(hCell/3+deltaH[0])],
zero2=[-sin(tilt2)*(hCell/1.5+deltaH[1]),cos(tilt2)*(hCell/1.5+deltaH[1])],
extr1=[cos(tilt1)*depth[0],sin(tilt1)*depth[0]],
extr2=[cos(tilt2)*depth[1],sin(tilt2)*depth[1]]
)

each[
  each arc(r=ri,fn=e[0]-1,deg=360-winkel1,z=level*levelH,rot=level%2?+0:winkel1/2),
 if(level<e[1]) each arc(r=Inkreis(e[0],ri)+extr1[0]+zero1[0],fn=e[0]-1,deg=360-winkel1,z=level*levelH+zero1[1]+extr1[1],rot=(level%2?+0:winkel1/2)+winkel1/2),
 if(level<e[1]) each arc(r=ri+extr2[0]+zero2[0],fn=e[0]-1,deg=360-winkel1,z=level*levelH+zero2[1]+extr2[1],rot=(level%2?+0:winkel1/2))
]
];

facesFloor=[for(i=[0:e[0]-1])i];
facesTop=[for(i=[-1:-1:-e[0]+0])i+len(points)];

facesTri1=[
 for(lev=[0:e[1]-1],i=[0:e[0]-1])
  each[
   [(i +1)%e[0],i,i+e[0]]+[1,1,1]*lev*e[0]*3,
   [i,(i+ (lev%2?+0:1))%e[0]+e[0]*3,i+e[0]]+[1,1,1]*lev*e[0]*3,
   [(i +(lev%2?+0:1))%e[0]+e[0]*3,(i+1)%e[0],i+e[0]] +[1,1,1]*lev*e[0]*3
  ]
];

facesTri2=[
 for(lev=[0:e[1]-1],i=[0:e[0]-1])
  each[
  [(i+ (lev%2?+1:+0))%e[0],i+e[0]*3,(i+ (lev%2?+1:+0))%e[0]+e[0]*2]+[1,1,1]*lev*e[0]*3,
  [(i+ (lev%2?+0:1))%e[0]+e[0]*3,i,i+e[0]*2]+[1,1,1]*lev*e[0]*3,
  [(i+1)%e[0]+e[0]*3,(i+ (lev%2?+1:0))%e[0]+e[0]*2,i+e[0]*3]+[1,1,1]*lev*e[0]*3,
  ]
];

faces=[
facesFloor,
facesTop,
each facesTri1,
each facesTri2
];

polyhedron(points=points,faces=faces,convexity=15);

}
/**
\name FlatKnurl
\page Objects
FlatKnurl() creates a knurled surface
\param s size [x,y,z]
\param lambda knurl size
\param base  base
\param opt  knulr pattern straight or diag and positive or negative single or cross knurl
\param center center
\param help help

*/

//FlatKnurl(opt=7,h=2,lambda=4);

module FlatKnurl(size=[20,30,1],h,lambda=2,base=.2,opt=0,center=[+0,0,1],help){
center=is_bool(center)?center?[1,1,1]:[0,0,1]:center;
lambda=is_num(lambda)?[lambda,lambda]:lambda;
s=is_undef(h)?is_list(size)?size:[size,size,lambda/2]:[each size.xy,h];
res=[round(s.x/lambda.x),round(s.y/lambda.y)]*2;


  if(opt==1){ // cross in
    FlatMesh(s,res=res,base=base,fz=function(x,y) x%2?0:s.z,center=center);
    FlatMesh(s,res=res,base=base,fz=function(x,y) y%2?0:s.z,center=center);
  }

  if(opt==0)intersection(){ //cross out
    FlatMesh(s,res=res,base=base,fz=function(x,y) x%2?s.z:0,center=center);
    FlatMesh(s,res=res,base=base,fz=function(x,y) y%2?s.z:0,center=center);
  }
  if(opt==2){ // straight x
    FlatMesh(s,res=res,base=base,fz=function(x,y) x%2?s.z:0,center=center);
  }
  if(opt==3){ // straight y
    FlatMesh(s,res=res,base=base,fz=function(x,y) y%2?s.z:0,center=center);
  }  
  if(opt==4)intersection(){ // diagonal
    FlatMesh(s,res=res,base=base,fz=function(x,y) (x+y)%2?s.z:0,faceOpt=0,center=center);
    FlatMesh(s,res=res,base=base,fz=function(x,y) (x+y)%2?s.z:0,faceOpt=1,center=center);
  }
  if(opt==5){ // diagonal out
    FlatMesh(s,res=res,base=base,fz=function(x,y) (x+y)%2?s.z:0,faceOpt=0,center=center);
    FlatMesh(s,res=res,base=base,fz=function(x,y) (x+y)%2?s.z:0,faceOpt=1,center=center);
  }
  if(opt==6||opt==7)FlatMesh(s,res=res,base=base,fz=function(x,y) (x+y)%2?s.z:0,faceOpt=opt==6?0:1,center=center);
  
HelpTxt("FlatKnurl",["size",size,"h",h,"lambda",lambda,"base",base,"opt",opt,"center",center],help);
}





/**
\name Loch
\page Objects
Loch() creates the Volume of a slot or elongated hole
\param h height 
\param h2 chamfer height [bottom,top]
\param d  diameter
\param l elongation
\param d2  [bottom/top] ↦ h2
\param deg chamfer degree [bottom,top]
\param rad  [bottom/top] is max if undef
\param extrude  ends cylindrical extruded
\param center  [x,y,z] center options
\param fn fragments
\param cuts Add cuts to create reinforcements
\param name,help  name help
*/

/*
 Loch(h=5,h2=0.75,rad=[1,2.5]*0,deg=[-45,45],2D=1);
 T(8) Loch(h=5,h2=.75,rad=[1,2.5],deg=[45,-45],2D=true);
   //*/
 
 //LinEx(end=[-1,1])Rund(0,1)Loch();

//Loch(rad=4,d=7,h=14,h2=3,deg=-30,2D=0,cuts=0,fs=0.4);


module Loch(h=5,h2=1,d=3.5,l=0,d2,deg=[45,45],rad,extrude=spiel,center=[1,1,0],fn=0,fs=fs,cuts=0,2D=false,name,help){



d2=is_num(d2)?[d2,d2]:d2;
ly=is_list(l)?max(0,l.y):0;
lx=is_list(l)?max(0,l.x):l?l:0;
cuts=ly?0:cuts;
l=max(is_list(l)?l.x:l,0);
r=max(0,d/2);
ih2=is_list(h2)?[h2[0],h2[1]]:[h2,h2];

conDeg=is_list(deg)?[deg[0],deg[1]]:[deg,deg];
deg=[is_undef(d2[0])?conDeg[0]: d<d2[0]?abs(conDeg[0]):-abs(conDeg[0]),
     is_undef(d2[1])?conDeg[1]: d<d2[1]?abs(conDeg[1]):-abs(conDeg[1]) 
     ];

h2=[
is_undef(d2[0])?max(deg[0]<0?min(ih2[0],r/tan(-deg[0])):ih2[0],0):abs((d2[0]-d)/2/tan(deg[0])),
is_undef(d2[1])?max(deg[1]<0?min(ih2[1],r/tan(-deg[1])):ih2[1],0):abs((d2[1]-d)/2/tan(deg[1]))];

rad=is_list(rad)?rad:[rad,rad];

maxRad=[
abs(deg[0])==90?rad[0]:abs(  h2[0]*tan(deg[0])/(1-cos(deg[0]))  ),
abs(deg[1])==90?rad[1]:abs(  h2[1]*tan(deg[1])/(1-cos(deg[1]))  )
];

hc=max(h-vSum(h2),0);

irad=[
is_undef(rad[0])?min(maxRad[0],abs(hc/2/tan(deg[0]/2)) ):min(max(0,rad[0]),maxRad[0]),
is_undef(rad[1])?min(maxRad[1],abs(hc/2/tan(deg[1]/2)) ):min(max(0,rad[1]),maxRad[1])
];

center=is_list(center)?center:[1,1,1]*b(center,false);


r2=[
 abs(deg[0])==90?r+irad[0]*sign(deg[0]):
                 r+h2[0]*tan(deg[0]),
 abs(deg[1])==90?r+irad[1]*sign(deg[1]):
                 r+h2[1]*tan(deg[1])
];
iext=is_list(extrude)?extrude:is_num(extrude)?[extrude,extrude]:extrude?[500,500]:[0,0];
extrude=[r2[0]>0?iext[0]:0,r2[1]>0?iext[1]:0];
ifn360=fn?fn:fs2fn(fs=fs,r=max(r2[0],r2[1],r) );
ifn=fn?ceil(fn/2)-1:fs2fn(fs=fs,r=max(r2[0],r2[1],r),grad=ly?90:180)-1;

radFn=[fs2fn(fs=fs,r=irad[0],grad=deg[0]),fs2fn(fs=fs,r=irad[1],grad=deg[1])];
radDeltaH=[tan(deg[0]/2)*irad[0],tan(deg[1]/2)*irad[1]];

Echo(str(name," Loch h2=",h2," to big for h=",h," min h=",vSum(h2)),condition=h-vSum(h2)<0);

Echo(str(name," Loch h2=",ih2," to big for deg=",deg," with r=",r," ⇒ limited to h2=",h2),color="warning",condition=min(deg)<0&&(r<ih2[0]*tan(-deg[0])||r<ih2[1]*tan(-deg[1])));

Echo(str(name," Loch rad ",rad," to big for h2(",h2,") ⇒ limited to max rad=",irad),color="warning",condition=(rad[0]&&maxRad[0]<rad[0])||(rad[1]&&maxRad[1]<rad[1]));
Echo(str(name," Loch h too small for rad"),condition=abs(radDeltaH[0])>hc+1e-16-abs(radDeltaH[1])||vSum(radDeltaH)>hc+1e-16);


InfoTxt("Loch",["d",[r2[0],r,r2[1]]*2,"length",[r2[0]*2+l,r*2+l,r2[1]*2+l]],name);
HelpTxt("Loch",["h",h,"h2",h2,"d",d,"l",l,"d2",d2,"deg",deg,"rad",rad,"extrude",extrude,"center",center,"fn",fn,"fs",fs,"cuts",cuts,"2D",2D,"name",name],help);

function langL(r=5,l=0,z=undef,fn=ifn,fs=0)=l&&!ly?concat(
  arc(r=r,deg=180,fn=fs?fs2fn(r=r,grad=180):fn,t=[0,0],rot=90,z=z),
  arc(r=r,deg=180,fn=fs?fs2fn(r=r,grad=180):fn,t=[l,0],rot=-90,z=z)
  )
  :ly?concat(
  arc(r=r,deg=90,fn=fs?fs2fn(r=r,grad=90):fn,t=[l,ly],rot=0,z=z),
  arc(r=r,deg=90,fn=fs?fs2fn(r=r,grad=90):fn,t=[0,ly],rot=90,z=z),
  arc(r=r,deg=90,fn=fs?fs2fn(r=r,grad=90):fn,t=[0,0],rot=180,z=z),
  arc(r=r,deg=90,fn=fs?fs2fn(r=r,grad=90):fn,t=[l,0],rot=-90,z=z)
  )
      :arc(r=r,deg=360-360/(ifn360),fn=ifn360-1,z=z);

stepRad=[deg[0]/radFn[0],deg[1]/radFn[0]];
 points=concat(
 extrude[0]?langL(r2[0],l,-extrude[0]):[], // ext
 langL(r2[0],l,0),                         // base
                                           // center round bottom
 irad[0]?
  [for(i=[radFn[0]:-1:0]) each langL(r+(irad[0]-irad[0]*cos(i*stepRad[0]))*sign(deg[0]),l,z=h2[0]+(radDeltaH[0]-irad[0]*sin(i*stepRad[0]))*sign(deg[0]) )]:
 langL(r,l,h2[0]),                            // else center bottom
                                           // center round top 
 irad[1]?
  [for(i=[0:radFn[0]]) each langL(r+(irad[1]-irad[1]*cos(i*stepRad[1]))*sign(deg[1]),l,z=h2[0]+hc-(radDeltaH[1]-irad[1]*sin(i*stepRad[1]))*sign(deg[1]) )]:
 langL(r,l,h2[0]+hc),                         // else center top
 langL(r2[1],l,h),                         // top
 extrude[1]?langL(r2[1],l,h+extrude[1]):[] // ext
 );
 


 points2D=[
   if(extrude[0])[-r2[0],0-extrude[0]],
   if(extrude[0])[ r2[0],0-extrude[0]],
   [ r2[0],0],
   if(!irad[0]||!deg[0])[ r,h2[0]],
   if(irad[0]&&deg[0])each arc(r=-irad[0],deg=-deg[0],t=[r,h2[0]]+sign(deg[0])*[irad[0],radDeltaH[0]],rot=deg[0]>0?deg[0]:180+deg[0],rev=false,fn=radFn[0]),
   if(!irad[1]||!deg[1])[ r,h2[0]+hc],
   
   if(irad[1]&&deg[1])each arc(r=-irad[1],deg=-deg[1],t=[r,h2[0]+hc]+sign(deg[1])*[irad[1],-radDeltaH[1] ],rot=deg[1]>0?0:180,rev=false,fn=radFn[1]),

   [ r2[1],vSum(h2)+hc],
   if(extrude[1])[ r2[1],vSum(h2)+hc+extrude[1]],
   if(extrude[1])[-r2[1],vSum(h2)+hc+extrude[1]],
   [-r2[1],vSum(h2)+hc],
   if(!irad[1]||!deg[1])[-r,h2[0]+hc],
   if(irad[1]&&deg[1])each arc(r=-irad[1],deg=-deg[1],t=[-r,h2[0]+hc]-sign(deg[1])*[irad[1],radDeltaH[1] ],rot=deg[1]>0?180+deg[1]:deg[1],rev=false,fn=radFn[1]),
   if(!irad[0]||!deg[1])[-r,h2[0]],
   if(irad[0]&&deg[0])each arc(r=-irad[0],deg=-deg[0],t=[-r,h2[0]]-sign(deg[0])*[irad[0],-radDeltaH[0]],rot=deg[0]>0?180:0,rev=false,fn=radFn[0]),
   [-r2[0],0]
 ];
 
// Points(points,help=1);
if(is_parent(needs2D)||2D)T(center.x?0:r,center.y?-h/2:0)polygon(points2D);
else
T(center.x?center.x==2?0:
                       center.x==3?-l:
                                   -l/2:
          d/2,
          center.y?-ly/2:d/2,
          center.z?-h/2:0){
          $info=false;
            PolyH(points=points,loop=ly?4*ifn+4:lx?ifn*2+2:ifn360,flip=0);
            if(cuts&&max(r2)-r>=1&&max(deg)>=5&&h>1)difference(){
            gapH=[deg[0]==0?0:1/sin(deg[0]),deg[1]==0?0:1/sin(deg[1])]*.5;
            cutWidth=0.03;
            
              if(l)T(l/2){
                Linear(e=round(cuts==2?l-d/2:l+d/2),es=1,center=true)Tz(h/2)cube([cutWidth,abs(max(r2*2)),abs(h)-1],true);
                if(cuts==2){
                  //Tz(h/2)cube([abs(max(r2*2))+l,cutWidth,abs(h)-1],true);
                  MKlon(tx=-l/2)Polar(floor((r+line(2))*PI),-cutWidth/2,end=180)Tz(.5)cube([cutWidth,abs(max(r2)),abs(h)-1]);
                }
              }
              else Polar(floor((r+line(2))*PI*2),-cutWidth/2)Tz(.5)cube([cutWidth,abs(max(r2)),abs(h)-1]);
              Tz(+gapH[0] -(deg[0]?line(2)/tan(deg[0]):0))Loch(h=h -vSum(gapH) +(deg[0]?line(2)/tan(deg[0]):0)+(deg[1]?line(2)/tan(deg[1]):0),h2=h2,d=d +line(2)*2,l=l,d2=undef,deg=deg,rad=rad-[1,1]*line(2),center=[2,1,0],fn=24,cuts=false,extrude=true);
            }
          }

}



/// chamfer cube

module Ccube(size=20,c=2,c2,center=true,sphere=false,grad=0,help){
    c2=is_undef(c2)?0.5773*c:c2;//Eulerkonst?
    s=is_list(size)?size:[size,size,size];
    scaleS=max(s[0]-c,s[1]-c,s[2]-c);
    maxVal=max(size)*2;
    
    //sc=[Hypotenuse(s[0],s[2])-c,Hypotenuse(s[0],s[0])-c,Hypotenuse(s[2],s[0])-c];
   sc1=[Hypotenuse(s[0]-c,s[0]-c)/2+Hypotenuse(s[1]-c,s[1]-c)/2,Hypotenuse(s[0]-c,s[0]-c)/2+Hypotenuse(s[1]-c,s[1]-c)/2,maxVal];
   sc2=[Hypotenuse(s[2]-c,s[2]-c)/2+Hypotenuse(s[0]-c,s[0]-c)/2,maxVal,Hypotenuse(s[0]-c,s[0]-c)/2+Hypotenuse(s[2]-c,s[2]-c)/2];    
   sc3=[maxVal,Hypotenuse(s[2]-c,s[2]-c)/2+Hypotenuse(s[1]-c,s[1]-c)/2,Hypotenuse(s[1]-c,s[1]-c)/2+Hypotenuse(s[2]-c,s[2]-c)/2];     
    
    
    sce=[2*norm(s-[c,c,c])-c2,1*norm(s-[c,c,c])-c2,2*norm(s-[c,c,c])-c2
    ];
    
    
    
  translate(center?[0,0,0]:s/2)intersection(){
      cube(s,center=true);
      rotate([0,0,45])cube(sc1,center=true);
      rotate([0,45,0])cube(sc2,center=true);
      rotate([45,0,0])cube(sc3,center=true);
      

     Color()rotate([0,0,45])R(grad+90-54.74)cube(sce,center=true);
     Color()rotate([0,0,-45])R(grad+90-54.74)cube(sce,center=true);
     Color()rotate([0,0,135])R(grad+90-54.74)cube(sce,center=true);
     Color()rotate([0,0,-135])R(grad+90-54.74)cube(sce,center=true);
     if(sphere)Color(0.1) scale([1/scaleS*s[0],1/scaleS*s[1],1/scaleS*s[2]])sphere(norm(s/2)-c-sphere);
 
  } 
 HelpTxt("Ccube",[
  "size",size,
  "c",c,
  "c2",c2,
  "center",center,
  "sphere",sphere,
  "grad",grad],help);
}


/**
\name WaveEx
\page Objects
WaveEx is a wavey extrusion
\param grad degree 0 straight 360 torus
\param h height if straight
\param r ry radius
\param f fy frequency
\param a ay amplitude
\param fv,fvy frequency shift
\param trx try torus radius
\param tf tfy torus frequency
\param tfv,tfvy torus frequency shift 
\param ta tay torus amplitude
\param fn fn2  fragments
\param rot rotation
\param scale scaley  scale
\param close  close ends
\param p pitch
\param name help name help
*/

module WaveEx(grad=0,h=50,r=5,ry,f=0,fy,a=1,ay,fv=0,fvy,trx=20,try,tf=0,tfy=0,tfv=0,tfvy=0,ta=1,tay,fn=fn,fn2=fn,rot=0,scale=1,scaley,close=true,p=0,name,help){
    ay=is_undef(ay)?a:ay;
    fy=is_undef(fy)?f:fy;
    ry=is_undef(ry)?r:ry;
    scaley=is_undef(scaley)?scale:scaley;
    fvy=is_undef(fvy)?fv:fvy;
    try=is_undef(try)?trx:try;
    tay=is_undef(tay)?ta:tay;
    close=grad>=360?p?true:false:close;
    
    
    twist=0;
    rotate=rot;
    
    pointsLin=!grad?[for(i=[0:fn],j=[0:fn2])concat( kreis(rot=rotate+twist/fn*i,fn=fn2,rand=0,r=(1+(scale-1)/fn*i)*(r+sin(i*f*360/fn+fv)*a),r2=(1+(scaley-1)/fn*i)*(ry+sin(i*fy*360/fn+fvy)*ay),t=[trx+ta*sin(i*tf*360/fn+tfv),try+tay*cos(i*tfy*360/fn+tfvy)])[j],[i*h/fn])]:0;
    
    
    function RotEx(rot=grad,punkte=Kreis(rot=rotate+twist/fn,fn=fn2,rand=0,r=(1+(scale-1)/fn)*(r+sin(0*f*360/fn+fv)*a),r2=(1+(scaley-1)/fn)*(ry+sin(0*fy*360/fn+fvy)*ay),t=[0,0]),verschieb=trx,verschiebY=try,p=-p,detail=fn*grad/360)=[for(rotation=[detail:-1:0])for(i=[0:len(punkte)-1])
    concat(
    (punkte[i][0]+cos(f*rotation*grad/detail+fv)*a*cos(i*360/fn2)+verschieb)*sin(rotation*grad/detail)+sin(tfv+rotation*grad/detail*(tf+1))*ta,
    punkte[i][1]+cos(fy*rotation*grad/detail+fvy)*-ay*sin(i*360/fn2)+rotation/detail*p*grad/360+sin(tfvy+rotation*grad/detail*(tfy+0))*tay,
    (punkte[i][0]+cos(f*rotation*grad/detail+fv)*a*cos(i*360/fn2)+verschiebY)*cos(rotation*grad/detail)+cos(tfv+rotation*grad/detail*(tf+1))*ta
    )
    ];
    pointsRot=RotEx(rot=grad);
 
    points=grad?pointsRot:pointsLin;

    //pointsMod=[for(i=[0:len(points)-1])[points[i][0]*1.0,points[i][1]*1,points[i][2]*1]];

   //faces1=[for(i=[0:len(points)-fn2-3])each[[i,i+1,i+fn2+1],[i+1,i+fn2+2,i+fn2+1]]];// Triangle faces×2
   bottom=[[for(i=[0:fn2-1])(fn2-1)-i]];
   top =[[for(i=[len(points)-fn2:len(points)-1])i]];
   faces2=[for(i=[0:len(points)-fn2-3])[i,i+1,i+fn2+2,i+fn2+1]];// Quad face version
   
   rotate(grad?[-90,0,-90-(360-grad)/2]:[0,0,0])polyhedron(points=points,faces=close?concat(
   faces2,
   bottom,
   top
   ):faces2,convexity=5); 
  
  HelpTxt("WaveEx",["grad",grad,"h",h,"r",r,"ry",ry,"f",f,"fy",fy,"a",a,"ay",ay,"fv",fv,"fvy",fvy,"trx",trx,"try",try,"tf",tf,"tfy",tfy,"tfv",tfv,"tfvy",tfvy,"ta",ta,"tay",tay,"fn",fn,"fn2",fn2,",rot",rot,"scale",scale,"scaley",scaley,"close",close,"p",p,"name",name],help);
      
    if(help)echo(str("r=radius, f=frequenz, fv=freqverschiebung, a=amplitude, trx=translatetRadiusX, p=steigung")); 
  

}




module REcke(h=5,r=5,rad=.5,rad2,single=0,grad=90,center=false,fn=fn,help){
rad2=is_undef(rad2)?rad:rad2;
   radius=TangentenP(180-grad,r,r); 
   radius2=TangentenP(180-grad,r+Hypotenuse(rad,rad),r-rad);
    
 translate([0,0,center?-h/2:0])difference(){
  if(grad==90)T(-rad,-rad)cube([r+rad,rad+r,h]);
      else translate([-rad*tan(90-grad/2),-rad]) rotate_extrude(angle=grad,convexity=5)square([radius2,h]);
  translate(RotLang(90-grad/2,radius))rotate(grad/2+180)Strebe(angle=200-grad,h=h,single=single,2D=0,rad=rad,rad2=rad2,d=2*r,help=0,name=0,fn=fn);
 }   
HelpTxt("REcke",["h",h,"r",r,"rad",rad,"rad2",rad2,"single",single,"grad",grad,"center",center,"fn",fn],help); 
 if(grad!=90)Echo("WIP grad!=90",color="warning");   
}


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
\param 2D make 2D
\param extrude extrude in 2D from x=0
\param grad2 angle endsection
\param x0 set x axis origin=0
\param lRef reference for l1 l2 0=center -1/1 lower/upper tangentP -2/2 tangent+grad2 -3/3 radius center
\param name help name help
\param lap overlap for 3D
*/

//SBogen(2D=true);
//SBogen(extrude=10, grad2=[26,-40]*1,r1=2,l1=20,lRef=+3,messpunkt=true);

module SBogen(dist=10,r1=10,r2,grad=45,l1=15,l2,center=1,fn,fs=fs,fa=fa,messpunkt=false,2D=0,extrude=false,grad2=0,x0=0,lRef=0,name,help,spiel,lap=0){
    lap=is_undef(spiel)?lap:spiel;
    center=is_bool(center)?center?1:0:sign(center);
    r2=is_undef(r2)?r1:r2;
    l2=is_undef(l2)?l1:l2;
    2D=is_parent(needs2D)&&!$children?2D?b(2D,false):
                                         1:
                                      b(2D,false);
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
    translate([dist/2,y/2,0])T(-r2)rotate(grad2[1])T(r2)Bogen(rad=r2,grad=grad+grad2[1],center=false,l1=l2-y/2,l2=l2m,help=0,name=0,messpunkt=messpunkt,2D=2D,fn=fn,fs=fs,d=2D,lap=lap)
    if($children){

      $idx=is_undef($idx)?0:$idx;
      $tab=is_undef($tab)?1:b($tab,false)+1;
      children();
    }
    else circle($fn=fn,$fs=fs);
  T(-dist/2,-y/2) mirror([1,0,0])rotate(180)T(r1)rotate(-grad2[0])T(-r1)Bogen(rad=r1,grad=-grad-grad2[0],center=false,l1=l1-y/2,l2=l2m,help=0,name=0,messpunkt=messpunkt,2D=2D,fn=fn,fs=fs,d=2D,lap=lap)
    if($children){
      $idx=1;
      children();
    }
    else circle($fn=fn,$fs=fs);
 }
 
 if(!grad&&!extrudeTrue) //0 grad Grade
     if(!2D)T(0,center?0:l1+l2)R(90)linear_extrude(l1+l2,convexity=5,center=center?true:false)
         if($children)children();
         else circle($fn=fn);
 else T(center?0:-2D/2) square([2D,l1+l2],center?true:false);
     

 
 
 
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
  Echo(str(name," SBogen has no 2D-Object"),color=Hexstring([1,0.5,0]),size=4,condition=!$children&&!2D&&!extrudeTrue);
  Echo(str(name," SBogen width is determined by var 2D=",2D,"mm"),color="info",size=4,condition=2D==1&&!extrudeTrue&&(is_undef($idx)||!$idx)&&$info);       
   
  Echo(str(name," SBogen r1/r2 to big  middle <0"),condition=l2m<0);
  Echo(str(name," SBogen radius 1 negative"),condition=r1<0);
  Echo(str(name," SBogen radius 2 negative"),condition=r2<0);    
  Echo(str(name," SBogen r1/r2 to big or angle or dist to short"),condition=grad!=0&&r1-cos(grad)*r1+r2-cos(grad)*r2>abs(dist));
  Echo(str(name," SBogen angle to small/ l1+l2 to short =",l1-y/2+yRef,"/",l2-y/2-yRef),condition=l1-y/2+yRef<0||l2-y/2-yRef<0);
   //Help    
  HelpTxt("SBogen",["dist",dist,"r1",r1,"r2",r2,"grad",grad,"l1",l1,"l2",l2,"center",center,"fn",fn,"messpunkt",messpunkt,"2D",2D,"extrude",extrude,"grad2",grad2,"x0",x0, "lRef", lRef, "lap",lap," ,name=",name],help); 

}


module Buchtung(size=[10,5],l=10,r=2.5,rmin=0,center=true,fn=fn,fn2=fn,phase=360,deltaPhi=-90,help){
    
    size=is_list(size)?size:[size,size];
    rmin=is_list(rmin)?rmin:[rmin,rmin,rmin,rmin];
    r=is_list(r)?r:[r,r,r,r];
  loop=len(quad(fn=fn2));
  points=[
      for (i=[0:fn])
        let(
          zscale=l/(fn),
          rscale=r-rmin,
          ir=(1+sin((i*phase/fn+deltaPhi)%360))/2*rscale+rmin
          )
        each quad(size,r=ir,z=i*zscale,fn=fn2)
        ];
  
/*
    for (i=[0:fn-1]){
      
        j=i+1;
        zscale=l/fn;
        rscale=r-rmin;
        $info=0;
        $helpM=false;
        translate(center?[0,0,-l/2]:[0,0,0]+size/2)Color(i/((fn-1)*1.1))hull(){
          $idx=i;
        Tz(i*zscale)linear_extrude(minVal,scale=0)Quad(size,r=(1+sin(i*phase/fn+deltaPhi))*rscale/2+rmin,fn=fn2);
        Tz(j*zscale+minVal){
          $idx=j;
          linear_extrude(minVal,scale=0)Quad(size,r=(1+sin(j*phase/fn+deltaPhi))*rscale/2+rmin,fn=fn2);
          }
        }
    }
// */

//translate(center?[0,0,-l/2]:[0,0.0,0]+size/2)PolyH(points,loop=floor(fn2/4)*4+4,name=false);
translate(center?[0,0,-l/2]:[0,0.0,0]+size/2)PolyH(points,loop=loop,name=false);

    
HelpTxt("Buchtung",[
    "size",size,
    "l",l,
    "r",r,
    "rmin",rmin,
    "fn",fn,
    "fn2=",fn2,
    "phase",phase,
    "deltaPhi",deltaPhi],
     help);
}

/** \name QuadAnschluss \page Objects
QuadAnschluss() creates a transision between two rounded rectangles (wall)

\param rad rad2  bottom top radius can be list of 4
\param size, size2 bottom top size
\param h height of transition between bottom top values
\param l l2 straight profile start and end [bottom,top] or l l2 this is also used to make a chamfer
\param dicke dicke2 wall thickness bottom top (dicke2 optional)
\param t translate top quad
\param chamfer chamfer bevel (in l) num or [bottom,top] or [[bot out,bot in],[top out,top in]]
\param chamferDeg angle of chamfer num or list [bottom,top] or [[bot out,in],[top out,in]]
\param fn,fs  fraqment number, size
\param name,help name, help
*/

//QuadAnschluss(1,5,5,12);

//QuadAnschluss(1,5,5,12,dicke=2,chamfer=0.5);
//QuadAnschluss(dicke=2,chamfer=[[0,1],[1,0]],l=1.5);

//QuadAnschluss(dicke=2,chamfer=[[0,1],[1,0]],size=0,rad=[1,2,3,4],l=3,chamferDeg=60);

//Cut()QuadAnschluss(5,8,25,20,h=20,dicke=4,dicke2=1.5,chamferDeg=[[25,70],[45,40]],chamfer=.5);



module QuadAnschluss(rad=5,rad2=5,size=[0,0],size2=[0,0],h=10,l=1,l2,dicke=0,dicke2,t=[0,0],chamfer=0,chamferDeg=45,fn,fs=fs,r,r2,name,help){

r=is_undef(r)? is_list(rad)?rad:rad*[1,1,1,1]:is_list(r)?r:r*[1,1,1,1];
r2=is_undef(r2)? is_list(rad2)?rad2:rad2*[1,1,1,1]:is_list(r2)?r2:r2*[1,1,1,1];

fnH=is_num(fn)&&fn?fn:ceil(h/fs);
dicke2=is_undef(dicke2)?dicke:dicke2;
l2=is_undef(l2)?l:l2;

ichamferDeg=is_list(chamferDeg)?[is_list(chamferDeg[0])?chamferDeg[0]
                                                      :chamferDeg[0]*[1,1],
                                is_list(chamferDeg[1])?chamferDeg[1]
                                                      :chamferDeg[1]*[1,1]
                               ]
                              :chamferDeg*[[1,1], [1,1]];

l=is_num(l)?[l,l2]:l;

chamfer=is_list(chamfer)?chamfer
                        :dicke?[min(chamfer,l[0],abs(dicke/2)), min(chamfer , l[1], abs(dicke2/2))]
                              :[ min(chamfer,l[0]), min(chamfer,l[1]) ];
                              
chamferBot=is_list(chamfer[0])?chamfer[0]:chamfer[0]*[1,1];
chamferTop=is_list(chamfer[1])?chamfer[1]:chamfer[1]*[1,1];


//height [out, in] for bottom
chamferBotH=[abs(chamferBot[0])*tan(ichamferDeg[0][0]), abs(chamferBot[1])*tan(ichamferDeg[0][1])];
//height [out, in]for top
chamferTopH=[abs(chamferTop[0])*tan(ichamferDeg[1][0]), abs(chamferTop[1])*tan(ichamferDeg[1][1])];

Echo(str(name," chamfer Deg too big ",chamferDeg," limited by l=",l),color="warning",condition=
l[0]<max(chamferBotH)||l[1]<max(chamferTopH));

chamferBotHmin=vMin(chamferBotH,l[0]);
chamferTopHmin=vMin(chamferTopH,l[1]);


function delta(i,fn=fnH,angle=180)=
let(step=angle/fn)
.5 - cos( i*step ) /2;// S übergang i = [0:fnH] ↦ 0⇒1


size=is_list(size)?[max(r[0]+r[1],r[2]+r[3],size.x), max(r[0]+r[3],r[1]+r[2],size.y)]
                  :[max(r[0]+r[1],r[2]+r[3], size ), max(r[0]+r[3],r[1]+r[2], size )];
size2=is_list(size2)?[max(r2[0]+r2[1],r2[2]+r2[3],size2.x), max(r2[0]+r2[3],r2[1]+r2[2],size2.y)]
                  :[max(r2[0]+r2[1],r2[2]+r2[3], size2 ), max(r2[0]+r2[3],r2[1]+r2[2], size2 )];


ifn=is_num(fn)&&fn?ceil(fn/4)*4:ceil(fs2fn(r=max(max(r),max(r2)),fs=fs,minf=36)/4)*4;

HelpTxt("QuadAnschluss",["rad",rad,"rad2",rad2,"size",size2,"h",h,"l",l,"l2",l2,"dicke",dicke,"dicke2",dicke2,"t",t,"chamfer",chamfer,"chamferDeg",chamferDeg,"fn",fn,"fs",fs],help);

function points(ofs=[0,0],h=h,l=l,fn=ifn,chamfer=[0,0],chamferH=[0,0],r=is_list(r)?r:[r,r,r,r],r2=is_list(r2)?r2:[r2,r2,r2,r2])=[

if(l[0]&&chamfer[0])each quad(size+[2,2]*(ofs[0]-chamfer[0]),r=vMax(vAdd(r,ofs[0]-chamfer[0]),0),z=0,fn=fn), // l[0] base
if(l[0])each quad(size+[2,2]*ofs[0],r=vMax(vAdd(r,ofs[0]), 0 ),z=chamfer[0]?abs(chamferH[0]):0,fn=fn), // l[0] base

for(i=[0:fnH])each quad(
    size.x+ofs[0]*2 + (size2.x-size.x + (ofs[1]-ofs[0])*2) * delta(i),
    size.y+ofs[0]*2 + (size2.y-size.y + (ofs[1]-ofs[0])*2) * delta(i),
    r=vMax(v=vAdd(r+(r2-r)*delta(i),ofs[0]+(ofs[1]-ofs[0])*delta(i) ), 0),
    t=t*delta(i),
    z=i*h/fnH+l[0],fn=fn),
if(l[1])each quad(size2+ofs[1]*[2,2],r=vMax(v=vAdd(v=r2,ofs[1]),0),t=t,z=h+vSum(l)-(chamfer[1]?abs(chamferH[1]):0),fn=fn), // l[1] top
if(l[1]&&chamfer[1])each quad(size2+(ofs[1]-chamfer[1])*[2,2],r=vMax(v=r2+[1,1,1,1]*(ofs[1]-chamfer[1]) ),t=t,z=h+vSum(l),fn=fn) // l[1] top

];

 if(dicke>=0)difference(){
  
   PolyH( points(h=h, l=l, chamfer=[chamferBot[0],chamferTop[0]],
                 chamferH=[chamferBotHmin[0],chamferTopHmin[0]]),
          loop=ifn +4,flip=0,name=false);
          
  if(dicke>0)Tz(-.01)
    PolyH(points(ofs=-[dicke,dicke2], h=h, l=l+[.01,.01],
                 chamfer=-[chamferBot[1],chamferTop[1]],
                 chamferH=[chamferBotHmin[1],chamferTopHmin[1]]),
          loop=ifn+4,flip=0,name=false);
  }

 if(dicke<0)difference(){
   PolyH(points(ofs=-[dicke,dicke2], h=h, l=l,
                chamfer=[chamferBot[0],chamferTop[0]],
                chamferH=[chamferBotHmin[0],chamferTopHmin[0]]),
         loop=ifn+4,flip=0,name=false);
         
   Tz(-.01)PolyH(points(h=h, l=l+[.01,.01],
                        chamfer=-[chamferBot[1],chamferTop[1]],
                        chamferH=[chamferBotHmin[1],chamferTopHmin[1]]),
                 loop=ifn+4,flip=0,name=false);
  }
  
  
}
/** \name Anschluss \page Objects
Anschluss() creates a transision between diameter or thickness
\param h height 
\param d1 d2  in out diameter
\param rad rad2  radius of the bend
\param grad  degree of the transition
\param r1 r2  optional to d1 d2
\param center center height -1 1 0
\param grad2 end section angle
\param wand thickness 
\param 2D  make 2D
\param x0  move x start
\param hRef reference for h 0=center, -1/1 lower\upper tangential, -2/2 tang+grad2 , -3/3 rad center
\param fn,fs,fa fragments
*/


//Anschluss(wand=1);


module Anschluss(h=10,d1=10,d2=15,rad=5,rad2,grad=30,r1,r2,center=true,fn=0,fs=fs,fa=fa,fn2=0,grad2=0,x0=0,wand,2D=false,name,help,old=false,dicke,hRef=0){
     
    wand=is_undef(dicke)?wand:dicke; 
    center=is_bool(center)?center?1:0:center;
    rad2=is_undef(rad2)?is_list(rad)?rad[1]:rad:rad2;
    rad=is_list(rad)?rad[0]:rad;
    r1=is_undef(r1)?d1/2:r1;
    r2=is_undef(r2)?d2/2:r2;
    l1=is_list(h)?h[0]:h/2;
    l2=is_list(h)?h[1]:h/2;
    grad2=is_list(grad2)?grad2:[grad2,grad2];
    2D=is_parent(needs2D)?true:2D;
    $helpM=false;
   
   if (!wand){ 
    if(2D)SBogen(extrude=(center?center>0?(r1+r2)/2:r2:r1),grad=abs(grad),dist=r2-r1,l1=l1,l2=l2,r1=rad,r2=rad2,center=center,fn=fn2,fs=fs,fa=fa,grad2=grad2,name=name,x0=x0,lRef=hRef,messpunkt=false);
    else
    RotEx(fn=fn,fs=fs,fa=fa,cut=x0<0?true:false)
        SBogen(extrude=(center?center>0?(r1+r2)/2:r2:r1),grad=abs(grad),dist=r2-r1,l1=l1,l2=l2,r1=rad,r2=rad2,center=center,fn=fn2,fs=fs,fa=fa,grad2=grad2,name=name,x0=x0,lRef=hRef,messpunkt=false);
       

   } else if(old)difference(){
        if (wand<0)Anschluss(h=h,r1=r1-wand,r2=r2-wand,rad=rad+(r2>r1?wand:-wand),rad2=rad2+(r2>r1?-wand:wand),grad=grad,center=center,fn=fn,fn2=fn2,grad2=grad2,x0=x0,2D=2D,name=0,help=0);  

       Tz($preview&&!center&&wand<0?-0.05:0) Anschluss(h=wand<0&&$preview?h*1.01:h,r1=r1,r2=r2,rad=rad,rad2=rad2,grad=grad,center=center,fn=fn,fn2=fn2,grad2=grad2,x0=wand>0?x0:x0-0.1,2D=2D,name=name,help=0);

        if (wand>0)Tz($preview&&!center?-0.05:0)  Anschluss(h=wand>0&&$preview?h*1.01:h,r1=r1-wand,r2=r2-wand,rad=rad+(r2>r1?wand:-wand),rad2=rad2+(r2>r1?-wand:wand),grad=grad,center=center,fn=fn,fn2=fn2,grad2=grad2,x0=x0-0.1,2D=2D,name=0,help=0);  
      
   }  
   
   if(!old&&wand)
    if(!2D)RotEx(fn=fn,fs=fs,fa=fa)Ansch();
    else Ansch();
   
   module Ansch()difference(){ // new generation 
   if(wand<0)SBogen(extrude=(center?center>0?(r1+r2)/2:r2:r1)-wand,grad=abs(grad),dist=r2-r1,l1=l1,l2=l2,r1=rad+(r2>r1?wand:-wand),2D=0,r2=rad2+(r2>r1?-wand:wand),center=center,fn=fn2,fs=fs,fa=fa,grad2=grad2,name=name,x0=x0,lRef=hRef,messpunkt=false);
   
   SBogen(extrude=(center?center>0?(r1+r2)/2:r2:r1),grad=abs(grad),dist=r2-r1,l1=l1,l2=l2,r1=rad,2D=0,r2=rad2,center=center,fn=fn2,fs=fs,fa=fa,grad2=grad2,name=name,x0=wand>0?x0:x0-.1,lRef=hRef,messpunkt=false);
   
   if(wand>0)SBogen(extrude=(center?center>0?(r1+r2)/2:r2:r1)-wand,grad=abs(grad),dist=r2-r1,l1=l1,l2=l2,r1=rad+(r2>r1?wand:-wand),2D=0,r2=rad2+(r2>r1?-wand:wand),center=center,fn=fn2,fs=fs,fa=fa,grad2=grad2,name=name,x0=x0-0.1,lRef=hRef,messpunkt=false);
   }
    

  HelpTxt("Anschluss",[
   "h",h,
   "d1",d1,
   "d2",d2,
   "rad",rad,
   "rad2",rad2,
   "grad",grad,
   "r1",r1,
   "r2",r2,
   "center",center,
   "fn",fn,
   "fn2",fn2,
   "grad2",grad2,
   "x0",x0,
   "hRef",hRef,
   "dicke",dicke,
   "2D",2D,
   "name",name]
   ,help);
}


// WIP!!
module Kextrude (r1=10,r2,grad=60,rad=1,breit=5,center=1,fn=fn,help)rotate(center?-grad/2:0){
   $fn=fn;
    r2=is_undef(r2)?r1+breit:r2;
    breit=r2-r1;
    
    rad=is_list(rad)?rad:[rad,rad,rad,rad];
        
    if (rad[0]>breit/2)Echo(color="red","Kextrude Eckradius zu groß für Breite!");
    MO(!$children);
    
   rotate_extrude(angle=grad)T(r1)mirror([1,0])children();

    
union(){  
    $helpM=0;
    $info=0;  
   rotate_extrude(angle=grad)T(r2)children();
    
   T(r1+rad[2])rotate(180)rotate_extrude(angle=90)T(rad[2])children();
   T(r2-rad[3])rotate_extrude(angle=-90)T(rad[3])children(); 
   T(r2-rad[3],-rad[2])R(90,0,-90)linear_extrude (r2-r1-rad[2]-rad[3])children(); 
    
 rotate(grad){
   T(r1+rad[0])rotate(90)rotate_extrude(angle=90)T(rad[0])children();
   T(r2-rad[1])rotate(90)rotate_extrude(angle=-90)T(rad[1])children();
   T(r1+rad[0],+rad[0])R(90,0,90)linear_extrude (r2-r1-rad[0]-rad[1])children();
     
 }
} 

HelpTxt("Kextrude",["r1",r1,"r2",r2,"grad",grad,"rad",rad,"breit",breit,"center",center,"fn",fn],help);

}



module GewindeV3(
dn=5,
h=10,
kern=0,//Kerndurchmesser
p=1,//Steigung
w=0,//Windungen
profil=+0.00, //varianz gangbreite
gh=0.56,//Ganghöhe
g=1,//Gänge
scale=1,
name,
fn=36,
help
){
    //http://www.iso-gewinde.at
r=dn/2;
gh=gh?gh:(dn-kern)/2;
kern=gh?2*(r-gh):kern;    

p=p?p:(w/360)/h;
h=h?h:w/360*p;
w=w?w:(h/p)*360;
winkel=atan2((p/2),gh)*2;

InfoTxt("GewindeV3",["dn∅",dn,"Steigung",str(p,"mm/U"),"Kern",kern,"Gangtiefe",gh,"Winkel~",str(winkel -22.5,"°(",winkel,"°)")],name);

    difference(){
       if($children) children();
        Col(6)linear_extrude(height=h,twist=-w,convexity=10,scale=scale,$fn=fn){
   if(g>1) Rund((r-gh/2)*+0.5)Polar(g)T(gh/2)scale([1,1.00+profil])circle(r-gh/2,$fn=fn);
   if(g==1)T(gh/2)scale([1,1.00+profil])circle(r-gh/2,$fn=fn);
            
        }
    }
 HelpTxt("GewindeV3",["dn",dn,"h",h,",kern",kern,"p",p,"w",w,"profil",profil,"gh",gh,"g",g,"scale",scale,"name",name,"fn",fn],help);
}

/** \page Objects
\name FlatMesh
\param  size size
\param  fz  optional function(x,y)
\param  base bottom 
\param  res  resolution num or list 
\param  randSize to add noise
\param  amp list for amplitudes [crossx, - ,x,y,diagonal,diagonal,radial,circular,randomX,randomY(opt)]
\param  freq frequency list [crossx,crossy,x,y,diagonal,diagonal,radial,circular]
\param  delta list for moving pattern [crossx, - ,x,y,diagonal,diagonal,radial,circular,randomX,randomY(opt)]
\param  seed seed for noise
\param  center v3
\param  fs  size if resolution is number
\param  bricks interlock y rand blocks
*/


//FlatMesh(size=[15.5,12.123],res=10,f=[0,0,50,0,0,0,0],randSize=5,amp=[0.2,0,0.1,0,0,0,0.2],delta=[0,0,0,0,0,0],center=[1,1]);
/*
FlatMesh(amp=[1,0,1,1,0,0,0,0,0]);
T(20)color("red")  FlatMesh(amp=[0,0,1,1,0.5,0.5,0,0,0],delta=[0,0,0,90,0,0,0,0,0,0,0]);
T(40)color("green")FlatMesh(amp=[0,0,0,0,0,0,1,0,0,0],delta=[0,0,0,0,0,0,0,0,0],res=1,center=[0,1,1]);
T(70)color("blue") FlatMesh(amp=[0,0,0,0,0,0,0,1,0,0],freq=[4],delta=[0,0, 0,0, 0,0, 0,90, 0,0],center=[1,1,1],res=2);

//*/


module FlatMesh(size=[20,30],fz,base=5,res=1,randSize=0,amp=[1],freq=[2],delta=[0],seed=42,faceOpt,center=[0,0,1],fs=1,bricks=false,help){
center=v3(center);
size=is_num(size)?[size,size]:size;

res=is_num(res)?[round(res*size.x/fs),round(res*size.y/fs)]:res;
f=freq/max(res)*360;
delta=delta;
step=[size.x/res.x, size.y/res.y];

HelpTxt("FlatMesh",["size",size,"fz",fz,"base",base,"res",res,"randSize",randSize,"amp",amp,"freq",freq,"delta",delta,"seed",seed,"faceOpt",faceOpt,"center",center,"fs",fs,"bricks",bricks],help);

//amp=[0.08,.15,.5,.5,.5,.5,.5];//[0,0,0,1,1,0,0];//
//f=[15,20,10,5,6,2];
//delta=[1,1.5,2,1.75,.5,.3,.1]*3600*$t;

randSize=is_num(randSize)?[1,1]*randSize:randSize;
//delta=[1,1.5,2,1.75,.5,.3,0,randSize.x,randSize.y];//*$t*1000;
deltaRand=[delta[8%len(delta)],delta[9%len(delta)]];

// random
function rand(x,y,amp=amp[8%len(amp)],randSize=randSize,delta=deltaRand,seed=seed)=
  rands(-1,1,1,
    seed+(round((delta.x+x+randSize.x/2)/randSize.x)*round((delta.y+y+randSize.y/2)/randSize.y)) )[0] * amp*sign(max(randSize));

fz=is_function(fz)?fz:function(x,y) 
  (amp[0%len(amp)]?sin(x*f[0%len(f)]+delta[0%len(delta)])*sin(y*f[1%len(f)]+delta[1%len(delta)]) *amp[0%len(amp)]:0)//cross
  +(amp[2%len(amp)]?sin(x*f[2%len(f)]+delta[2%len(delta)]) *amp[2%len(amp)]:0)//x
  +(amp[3%len(amp)]?sin(y*f[3%len(f)]+delta[3%len(delta)]) *amp[3%len(amp)]:0)//y 
  +(amp[4%len(amp)]?sin((x-y)*f[4%len(f)]+delta[4%len(delta)]) *amp[4%len(amp)]:0)// diagonal
  +(amp[5%len(amp)]?sin((x+y)*f[5%len(f)]+delta[5%len(delta)]) *amp[5%len(amp)]:0)// diagonal
  

  +(amp[6%len(amp)]?sin(norm([x-center.x*res.x/2,y-center.y*res.y/2])*f[6%len(f)]+delta[6%len(delta)]) *amp[6%len(amp)]:0)//radial
  +(amp[7%len(amp)]?sin(atan2(x-center.x*res.x/2,y-center.y*res.y/2)*(freq[7%len(freq)])+delta[7%len(delta)]) *amp[7%len(amp)]*norm([x-center.x*res.x/2,y-center.y*res.y/2])/(max(res)/2):0)//circular

  //+rands(-1,1,1,x*y+delta[6])[0]*amp[6]// noise
 ;
 
 
if(min(size)>0){
points0=[
for(y=[0:res.y],x=[0:res.x])[x*step.x,y*step.y,base+fz(x,y)
// +rand(x,y)
//Bricks
+(bricks?
rand(x,y,delta=[(round((y+randSize.y/2)/randSize.y)%2?1:-1)*randSize.x/4
+rands(-1,1,1,round((y+randSize.y/2)/randSize.y+seed))[0]*randSize.x/10,0])
:rand(x,y))


//+rand(x,y,randSize=randSize*2,amp=amp[6]*1.5,delta=[1,0]*delta[7],seed=seed+12345)
//+rand(x,y,amp=amp[6]*2,randSize=randSize*3,delta=[0,1]*delta[8],seed=seed+5000)
],
];

pointsBox=[
for(i=[ [ 0, 0, 1], [ 1, 0, 1], [ 1, 1, 1], [ 0, 1, 1] ]) [i.x*size.x, i.y*size.y, 0]
];

l0=len(points0);
faces0=[
for(y=[0:res.y-1],x=[0:res.x -1])[x+1, x, x+res.x+1, x+res.x+2]+[1,1,1,1]*y*(res.x+1)
];
faces0Tri1=[
for(y=[0:res.y-1],x=[0:res.x -1])[x+1, x, x+res.x+1]+[1,1,1]*y*(res.x+1),
for(y=[0:res.y-1],x=[0:res.x -1])[x+1, x+res.x+1, x+res.x+2]+[1,1,1]*y*(res.x+1)
];
faces0Tri2=[
for(y=[0:res.y-1],x=[0:res.x -1])[x+1, x, x+res.x+2]+[1,1,1]*y*(res.x+1),
for(y=[0:res.y-1],x=[0:res.x -1])[x, x+res.x+1, x+res.x+2]+[1,1,1]*y*(res.x+1)
];
facesBox=[

//for(i=[0:l0-res.x -3])[i+1,i ,i+res.x +1,i+res.x +2],

[for(i=[0:3])i+l0],// bottom
[for(i=[0:res.x])i,l0+1,l0], // side y0
[for(i=[0:res.x])l0-i-1,l0+3,l0+2],// side y
[for(i=[res.y:-1:0])i*(res.x +1),l0,l0+3],// side x0
[for(i=[0:res.y])res.x+i*(res.x +1),l0+2,l0+1],// side x
];

//faces=concat(faces0,facesBox);
faces=concat( (is_undef(faceOpt)?faces0:faceOpt?faces0Tri1:faces0Tri2),facesBox);
points=concat(points0,pointsBox);

translate([center.x?-size.x/2:0,center.y?-size.y/2:0,center.z?-base:0])polyhedron(points,faces,convexity=5);
}
}



module Surface(x=20,y,zBase=5,deltaZ=.25,res=6,waves=false,
rand=true,seed=42,randsize=1,randSizeY,freqX=1,freqY,ampX=1,waveSkewX=+0,ampY,waveSkewY,ampRoundX=0,rfX=+1,ampRoundY,rfY,versch=[0,0],abs=false,exp=1,expY,sinDelta=0,sinDeltaY,mult=false,name,help){


HelpTxt("Surface",[
  "x",x,
  "y",y,
  "zBase",zBase,
  "deltaZ",deltaZ,
  "res",res,
  "waves", waves,
  "rand",rand,
  "seed",seed,
  "randsize",randsize,
  "randSizeY",randSizeY,
  "freqX",freqX,
  "freqY",freqY,
  "ampX",ampX,
  "waveSkewX",waveSkewX,
  "ampY",ampY,
  "waveSkewY",waveSkewY,
  "ampRoundX",ampRoundX,
  "rfX",rfX,
  "ampRoundY",ampRoundY,
  "rfY",rfY,
  "versch",versch,
  "abs",abs,
  "exp",exp,
  "expY",expY,
  "sinDelta",sinDelta,
  "sinDeltaY",sinDeltaY,
  "mult",mult,
  "name",name
  
  ],help);
/*
if(help){
    echo(str("<font color='",helpMColor,"', size=3><b>Help Surface"));
    echo(str("<font color='",helpMColor,"', size=2> Surface(x=",x,",y=",y,", zBase=",zBase," // mm size "));
    echo(str("<font color='",helpMColor,"', size=2> deltaZ=",deltaZ,", res=",res," // random change +− and resolution points/mm "));
    echo(str("<font color='#5500aa', size=2> waves=",waves,", rand=",rand,", // pattern waves and/or random"));
    echo(str("<font color='#5500aa', size=2> seed=",seed,", randsize=",randsize,",randSizeY=",randSizeY,", //random seed, random size y strech"));
    echo(str("<font color='#5500aa', size=2> freqX=",freqX,", freqY=",freqY,", ampX=",ampX,",waveSkewX=",waveSkewX,", ampY=",ampY,", waveSkewY=",waveSkewY,", // wave frequenz and amplitude XY"));
    echo(str("<font color='#5500aa', size=2> ampRoundX=",ampRoundX,", rfX=",rfX,",ampRoundY=",ampRoundY,",rfY=",rfY,", // rounded Waveform ⇒ coarse, roundig factor"));
    echo(str("<font color='#5500aa', size=2> versch=",versch,", name=",name,", abs=",abs,", exp=",exp,", expY=",expY,", sinDelta=",sinDelta,", sinDeltaY=",sinDeltaY,"mult=",mult,",); // move wave pattern  show info and abs values, exponent, move sin center waves only"));
}// */

y=is_undef(y)?x:y;//assert(x!=0&&y!=0)
randSizeY=assert(randsize!=0&&randSizeY!=0)is_undef(randSizeY)?1/randsize:1/randSizeY;
freqY=is_undef(freqY)?freqX:freqY;
ampY=is_undef(ampY)?ampX:ampY;
waveSkewY=is_undef(waveSkewY)?waveSkewX:waveSkewY;
ampRoundY=is_undef(ampRoundY)?ampRoundX:ampRoundY;
rfY=is_undef(rfY)?rfX:rfY;
expY=is_undef(expY)?exp:expY;
sinDeltaY=is_undef(sinDeltaY)?sinDelta:sinDeltaY;

    

if(waves)InfoTxt("Surface",["λ X/Y",str(10/freqX,"/",10/freqY," mm - λ¼=",10/freqX/4,"/",10/freqY/4," mm")],name);
    
rowl=assert(x>0)x; //frame x values
rowly=assert(y>0)y;//frame y values

resolution=1/res;//[10,5,2.5,1,0.5,0.25,0.125]
//randSizeY=1/randSizeY;


random=rands(-deltaZ,deltaZ,((rowl+1)*(rowly+1)*randSizeY)/min(randsize,1),seed);

/*
z1=0;
z2=0.5; 
alternate=[for(h=[0:y+1])for(i=[0:x+0])h%2?i%2?deltaZ:deltaZ/2:i%2?deltaZ/2:deltaZ];
alternate3=[for(h=[0:y+1])for(i=[0:x+0])h%4?i%3?z1:z2:i%2?z2:z1];   
function alternate2(x,y,z1=0.0,z2=0.5)=x%2?y%2?z1:z2:z2;
//
points0alternativ=[
for(x=[-rowl/2+versch[0]:resolution:rowl/2+versch[0]])
    for(y=[-rowly/2+versch[1]:resolution:rowly/2+versch[1]])
        [x,y,
    //alternate2((x+(rowl/2)),(y+(rowly/2)))]
    //alternate[(x+rowl/2)+(rowl+0.5)*(y+rowly/2)]] 
    alternate3[(x+rowl/2)+(rowl+0)*(y+rowly/2)]] 
    ];
    
*/
    
points0=[
for(x=[-rowl/2+versch[0]:resolution:rowl/2+versch[0]])
    for(y=[-rowly/2+versch[1]:resolution:rowly/2+versch[1]])
        [x,y,
    (rand?random[randSizeY*(round((y+rowly/2-versch[1])/randsize)+round((x+rowl/2-versch[0])/randsize)*rowly)]:0)
    +(waves?abs?
    pow(ampY*abs(sinDeltaY+sin(y*36*freqY+x*36*freqX*waveSkewY)),expY)
    *(mult?pow(ampX*abs(sinDelta+sin(x*36*freqX+y*36*waveSkewX*freqY)),exp):1)
    +(mult?0:pow(ampX*abs(sinDelta+sin(x*36*freqX+y*36*waveSkewX*freqY)),exp))
    +ampRoundX*round(rfX*abs(sin(x*36*freqX+y*36*waveSkewX*freqY)))
    +ampRoundY*round(rfY*abs(sin(y*36*freqY+x*36*freqX*waveSkewY)))
    :
    pow(ampY*(sinDeltaY+sin(y*36*freqY+x*36*freqX*waveSkewY)),expY)
    *(mult?pow(ampX*(sinDelta+sin(x*36*freqX+y*36*waveSkewX*freqY)),exp):1)
    +(mult?0:pow(ampX*(sinDelta+sin(x*36*freqX+y*36*waveSkewX*freqY)),exp))
    +ampRoundX*round(rfX*sin(x*36*freqX+y*36*waveSkewX*freqY))
    +ampRoundY*round(rfY*sin(y*36*freqY+x*36*freqX*waveSkewY))
    //+amplitude4*sin((y*0+x*1)*freqY)
    //+amplitude3*cos((y-x)*freqY)
    :0)]
    ];


resx=rowl*res;// /resolution;
resy=rowly*res;// /resolution;

faces0=[
    for(row=[+0:resx-1])
        for(i=[row*resy-1:(row+1)*resy-2])
            [i+1+row,i+row+2,i+row+3+resy,i+row+2+resy]
        ];
        

points1=[
[-rowl/2+versch[0],-rowly/2+versch[1],-zBase],
[-rowl/2+versch[0],rowly/2+versch[1],-zBase],
[rowl/2+versch[0],-rowly/2+versch[1],-zBase],
[rowl/2+versch[0],rowly/2+versch[1],-zBase],
];
        
end0=len(points0);
faces1=[[end0+3,end0+1,end0+0,end0+2]];
fpointssideA=[for(i=[resy:-1:0])i];
fpointssideB=[for(i=[0:resy+1:resx*(resy+1)])i];
fpointssideC=[for(i=[(resy+1)*(resx+1)-1:-resy-1:resy])i]; 
fpointssideD=[for(i=[len(points0)-resy-1:len(points0)-1])i];    

    
faces2=[concat(fpointssideA,[end0+0,end0+1])];    
faces3=[concat(fpointssideB,[end0+2,end0+0])];
faces4=[concat(fpointssideC,[end0+1,end0+3])];
faces5=[concat(fpointssideD,[end0+3,end0+2])];



points=concat(points0,points1);
faces=concat(faces0,faces1,faces2,faces3,faces4,faces5);


 translate(-versch)Col(6)polyhedron(points,faces,convexity=5);
    
}





module RStern(e=3,r1=30,r2=10,rad1=5,rad2=+30,l,grad=0,rand=0,os=0,randh=2,r=0,fn=fn,messpunkt=messpunkt,infillh,spiel=.005,name,help){
    $helpM=0;
    $info=0;
    r1=r?TangentenP(grad,rad1,r):r1;

    winkel1=180-grad;
    spitzenabstand=2*r1*sin(180/e);
    winkel3=180-(2*((180-360/e)/2-winkel1/2));
    schenkelA= spitzenabstand/2/sin(winkel3/2);
    winkel3h=Kathete(schenkelA,spitzenabstand/2);
    spitzenabsth=Kathete(r1,spitzenabstand/2);
    r2=r?spitzenabsth-winkel3h:r2;

    //infillh=$children?infillh:infillh?infillh:1;
    infillh=$children?infillh:is_undef(infillh)?0:infillh;
    //rand=$children?rand:grad<180?rand:rand?rand:1;
    
    // Winkelberechnung ZackenStern
    abstandR1=2*r1*sin(180/e);
    abstandR2=2*r2*sin(180/e);
    hoeheR1=r1-Kathete(r2,abstandR2/2);
    hypR1=Hypotenuse(abstandR2/2,hoeheR1);
    gradR1=2*acos(hoeheR1/hypR1);
    gradR2=2*asin((abstandR1/2)/hypR1);
  
        // RStern variablen
    grad=grad?grad:180-gradR1;
    g2=(grad-360/e);
    
    // Abstand Rundungen Zacken
    
    c1=sin(abs(grad)/2)*rad1*2;//  Sekante 1
    w11=abs(grad)/2;          //  Schenkelwinkel1
    w31=180-abs(grad);        //  Scheitelwinkel1
    a1=(c1/sin(w31/2))/2;    
    hc1=grad!=180?Kathete(a1,c1/2):0;  // Sekante1 tangenten center
    hSek1=Kathete(rad1,c1/2); //center Sekante1
    
    c2=sin(abs(g2)/2)*rad2*2;//  Sekante 2
    w12=abs(g2)/2;          //  Schenkelwinkel2
    w32=180-abs(g2);        //  Scheitelwinkel2
    a2=(c2/sin(w32/2))/2;    
    hc2=g2!=180?Kathete(a2,c2/2):0;  // Sekante2 tangenten center
    hSek2=Kathete(rad2,c2/2); //center Sekante2    
    
 
    
    // RStern l variable

    lCalcA=[r1-TangentenP(grad,rad1,rad1),0]+RotLang(90+grad/2,rad1);
    lCalcB=g2<0?
    RotLang(-90+180/e,-r2+TangentenP(g2,rad2,rad2))-RotLang(-90+180/e-abs(g2)/2,rad2):
    RotLang(-90+180/e,-r2-TangentenP(g2,rad2,rad2))+RotLang(-90+180/e+abs(g2)/2,rad2)
    ;

    l=is_undef(l)?norm(lCalcA-lCalcB)/2+spiel/2:l;
    //color("cyan")translate(lCalcA)Pivot();//Ende Bogen 1
    //color("magenta")translate(lCalcB)Pivot();//Ende Bogen 2
    
    
  if($children||!(grad<180))union(){
    Polar(e,r1,name=0)Bogen(grad=grad,rad=rad1,l=l,help=0,name=0,tcenter=1,fn=fn,messpunkt=messpunkt,lap=spiel)T(os){
        children();
        if(grad>=180)T(rand/2,randh/2)square([abs(rand),randh],true);
      }
      
    Polar(e,-r2,r=e%2?0:180/e,re=0,name=0)Bogen(grad=g2,rad=rad2,l=l,help=0,name=0,tcenter=true,fn=fn,messpunkt=messpunkt,lap=spiel)T(-os){
        R(0,180)children();
        if(grad>=180)T(-rand/2,randh/2)square([abs(rand),randh],true);
        }

  }
/*  old Sternfill
   if(grad<180){
   if(infillh)linear_extrude(infillh,convexity=5)offset(os,$fn=fn)Rund(rad1,rad2,fn=fn)Stern(e,r1,r2);
   if(rand)linear_extrude(randh,convexity=5)Rand(rand)offset(os,$fn=fn)Rund(rad1,rad2,fn=fn)Stern(e,r1,r2); 
   }
*/
  if(grad<=180){
   if(infillh)linear_extrude(infillh,convexity=5)offset(os,$fn=fn)RSternFill(e=e,r1=r1-TangentenP(grad,-rad1,-rad1),r2=TangentenP(g2,rad2,r2+rad2),d1=rad1*2,d2=rad2*2,fn=fn,grad1=grad,grad2=g2,help=false);
       
   if(rand)linear_extrude(randh,convexity=5)Rand(rand)offset(os,$fn=fn)RSternFill(e=e,r1=r1-TangentenP(grad,-rad1,-rad1),r2=TangentenP(g2,rad2,r2+rad2),d1=rad1*2,d2=rad2*2,fn=fn,grad1=grad,grad2=g2,help=false);
       
   if(infillh==0)offset(os,$fn=fn)RSternFill(e=e,r1=r1-TangentenP(grad,-rad1,-rad1),r2=TangentenP(g2,rad2,r2+rad2),d1=rad1*2,d2=rad2*2,fn=fn,grad1=grad,grad2=g2,help=false);   
   }
   
  if(grad>180){
   if(infillh)linear_extrude(infillh,convexity=5)offset(os,$fn=fn)RSternFill(e=e,r1=r1+TangentenP(grad,-rad1,-rad1),r2=TangentenP(g2,rad2,r2+rad2),d1=rad1*2,d2=rad2*2,fn=fn,grad1=grad,grad2=g2,help=false);
       
   if(rand)linear_extrude(randh,convexity=5)Rand(rand)offset(os,$fn=fn)RSternFill(e=e,r1=r1+TangentenP(grad,-rad1,-rad1),r2=TangentenP(g2,rad2,r2+rad2),d1=rad1*2,d2=rad2*2,fn=fn,grad1=grad,grad2=g2,help=false);
       
   if(infillh==0)offset(os,$fn=fn)RSternFill(e=e,r1=r1+TangentenP(grad,-rad1,-rad1),r2=TangentenP(g2,rad2,r2+rad2),d1=rad1*2,d2=rad2*2,fn=fn,grad1=grad,grad2=g2,help=false);   
   }   
 
  MO(!$children,warn=true);
   
  HelpTxt("RStern",["e",e,"r1",r1,"r2",r2,"rad1",rad1,"rad2",rad2,"l",l,"grad",grad,"rand",rand,"os",os,"randh",randh,"fn",fn,"messpunkt",messpunkt,"infillh",infillh,"spiel",spiel,"name",name],help);
   
  InfoTxt("RStern",["Grad",str(grad,"°"),"Grad2",str(g2,"°"),"Spitzenwinkel",str(gradR1,"°/",gradR2,"°"),"r1 bis Rundung",
      //  r1-hc1-hSek1+rad1
    r1-TangentenP(grad,-rad1,0)+2*rad1
    ,"r2 bis Rundung",
    //r2+hc2+hSek2-rad2
    str(TangentenP(g2,rad2,r2)
    ,"mm")],name);       
      
}

module RSternFill( // needs checking
  
e=8,  //elements
d1=2,  // diameter nipples(convex) 
d2,  // diameter nipples(concave)
r1=5,  // radius 1
r2,  //radius 2
grad1=180, // angle nipples 1
grad2, // angle nipples 2
fn=fn,
messpunkt=false,
help
){
winkel=360/(e*2);



    //grad1=is_undef(grad)?grad1:grad; // konvex
    grad2=is_undef(grad2)?grad1-winkel*2:grad2; // konkav
    d2=is_undef(d2)?d1:d2;
        

    sekD1X=sin(grad1/2)*d1/2;
    sekD1Y=cos(grad1/2)*d1/2;     
    sekD2X=sin(grad2/2)*d2/2;
    sekD2Y=-cos(grad2/2)*d2/2;
    r=norm([sekD1X,r1+sekD1Y]);//connectionpoint radius
    r2=is_undef(r2)?Kathete(r,sekD2X)-sekD2Y:r2;
  if(messpunkt)rotate(-90){
      Pivot(p0=[sekD1X,r1+sekD1Y],txt="D1",active=[0,0,0,1,0,1]);    
      rotate(-winkel) Pivot(p0=[-sekD2X,r2+sekD2Y],txt="D2",active=[0,0,0,1,0,1]);
      //Tz(.1)Color()circle(r,$fn=200);
  }
    

    
    wk=[for(i=[0:e-1]) each concat(
    kreis(r=-d2/2,rot=90-winkel/2+i*winkel*2,rand=0,grad=-grad2,sek=true,t=RotLang(-winkel/2+i*winkel*2,r2),fn=fn)
    , kreis(r=d1/2,rot=90+winkel/2+i*winkel*2,rand=0,grad=grad1,sek=true,t=RotLang(winkel/2+i*winkel*2,r1),fn=fn)
    )];

  rotate(winkel/2-90)polygon(wk,convexity=5);
    
if(help)echo(str("<H3> <font color=",helpMColor,">Help RSternFill(e=",e,",r1=",r1,", r2=",r2," ,d1=",d1," ,d2=",d2, ",grad1=",grad1," ,grad2=",grad2," ,fn=",fn,", messpunkt=",messpunkt," help);"));
}





}//fold // Basic Objects ΔΔ
{//fold // \∇∇ Products ∇∇/ //


/** \page Products \name Filter
Filter() creates a fine mesh to filter (only FDM prints)
\param size [x,y]filter size
\param dist  filter holes
\param h     filter height
\param form  0 square 1 circle
\param rand  rim  (± outer inner)
\param rad   corner radius for form 0
\param randH height rim
\param stack interlace grid levels if false
\param layer layer
\param name help name help
*/

//Filter(rand=0,layer=.15,form=0,dist=.5,nozzle=.2);
//Filter(size=[10,10],h=1.0,rand=+0,form=1,stack=0,line=.5);


module Filter(size=10,dist=.25,h=5,form=1,rand=-.5,rad=1,randH=0,stack=false,layer=layer,line=line,name,help){
//lines Size
ls=line;//n(2+min(.85,dist/nozzle),nozzle=nozzle); // gap max .85 nozzle width
2ls=line;//n(2,nozzle=nozzle); // End lines
//filter size [x,y]
size=is_num(size)?[size,size]:size;
//distance incl. line
es=dist+ls ;

interlace=[1,-1]*es/4;//[-(dist>nozzle*3?es/4:es/8),(dist>nozzle*3?es/4:es/8)];
level=rand?floor((h-layer*2)/layer/2):floor(h/layer/2);

InfoTxt("Filter",["line",ls,"outside",size+(rand>0?[2,2]*rand:[0,0]),"inside",rand>0?size:size+rand*[2,2],"level",level,"filterTop",(rand?layer:0)+level*layer*2],name);
HelpTxt("Filter",["size",size,"dist",dist,"h",h,"form",form,"rand",rand,"rad",rad,"randH",randH,"stack",stack,"layer",layer,"line",line,"name",name],help);



if(rand)
  LinEx(max(h,randH),$info=false)Rand(rand){
    if(form==0)Quad(size,rad=rad);
    if(form==1)scale(size)circle(d=1);
  }



  intersection(){
  $info=false;
    Tz(rand?layer*1.5:layer/2){
      Linear(level,es=layer*2,z=1){
      $idx2=$idx%2;
      if(rand==0&&form==1){
        color("lightgrey")linear_extrude(layer-.001,center=true)difference(){
          Kreis(d=size.x,r2=size.y/2,rand=2ls);
          T(level==1||stack?0:interlace[$idx2] )Linear(e=(size.x/es),es=es,center=true,x=1)T(y=(($idx%2+$idx2)%2?1:-1)*size.y/2)square([dist,size.y],true);
          
          }
       color("darkgrey")Tz(layer) linear_extrude(layer-0.001,center=true)difference(){
          Kreis(d=size.x,r2=size.y/2,rand=2ls);
          T(y=level==1||stack?0:interlace[$idx2] )Linear(e=(size.y/es),es=es,center=true,y=1)T(( ($idx%2+$idx2)%2?1:-1)*size.x/2)square([size.x,dist],true);
          }
        }
      
      
    // X
       color("lightgrey")T(level==1||stack?0:interlace[$idx%2] ) Linear(e=(size.x)/es+1,es=es,center=true){
        cube([ls ,size.y,layer-.001],true);
        if(rand==0&&form==0) if($idx%2)T(-es/2,size.y/2- 2ls /2)cube([es+ls ,2ls ,layer-.001],true);
        else T(es*1.5,-size.y/2+ 2ls /2)cube([es+ls ,2ls ,layer-.001],true);
       }
    // Y
       color("darkgrey")Tz(layer)T(y=level==1||stack?0:interlace[$idx%2]) Linear(e=(size.y)/es+1,es=es,y=1,center=true){
        cube([size.x,ls ,layer-.001],true);
        if(rand==0&&form==0)if($idx%2)T(size.x/2- 2ls /2,-es/2)cube([2ls ,es+ls,layer-.001],true);
        else T(-size.x/2+ 2ls /2,es*1.5)cube([2ls ,es+ls ,layer-.001],true);
       }
      }
    }
  if(form==1)linear_extrude(h*3,center=true)offset(rand/2)scale(size)circle(d=1);
  if(form==0)linear_extrude(h*3,center=true)offset(rand/2)Quad(size,rad=rad);


  }
}


/// Klemmbaustein  construction block Lego compatible
module KBS(e=2,grad=2,center=true,male=true,female=false,rot=0,n=4,top=false,knob,knobH,fKnob,fKnobH,dist,bh,name,help){
male=female?false:male;
d=is_undef(knob)?4.8:knob;//knobs on top of blocks
fd=is_undef(fKnob)?d:fKnob;//fknobs on bottom of blocks  
h=is_undef(knobH)?2:knobH;// knob height

    
ks=is_undef(dist)?8.0:dist; // spacing
rand=1.5;
bh=is_undef(bh)?9.6:bh;// block height
roof_thickness=1;//1.05
pin_diameter=3;        //pin for bottom blocks with width or length of 1
post_diameter=6.5;
reinforcing_width=1.5;
axle_spline_width=2.0;
axle_diameter=5;
  
fh=is_undef(fKnobH)?bh/3-roof_thickness:fKnobH;  
  
e=is_list(e)?e:[e,e];    

 if(e.z)linear_extrude(e.z*bh,scale=1,convexity=5)hull()Grid(e=e,es=[ks,ks,0],center=center,name=false)square(d+rand*2,center=center);
 if(male||female)Grid(e=e,es=[ks,ks,0],center=center,name=false){
    
   if(male)translate([0,0,e.z?e.z*bh+h:h])rotate(180,[1,0])linear_extrude(h,scale=(d/2-h/tan(90-grad))/(d/2),convexity=5) circle(d=d);
        // for holes on bottom
    else {
      h=fh;
      d=fd;

        translate([0,0,(e.z?e.z*bh:0)-.001]){
          linear_extrude(h,scale=(d/2-(h)/tan(90+grad))/(d/2),convexity=5)rotate(180/n+rot)Rund(d/3)circle(d=Umkreis(n,d),$fn=n);//;square(d,center=center);
      if(top)Tz(h-.001)linear_extrude(is_bool(top)?1:top,scale=0,convexity=5)scale((d/2-(h)/tan(90+grad))/(d/2))rotate(180/n+rot)Rund(d/3)circle(d=Umkreis(n,d),$fn=n);
      }
    }
 }
InfoTxt("KBS",["size",str(
    str(d+rand*2+ks*(e.x-1),"×",d+rand*2+ks*(e.y-1),e.z?str("×",e.z*bh):"")
    ,grad?str(" diff ",grad,"° bei h=2mm ",tan(grad)*2):
       ""
    )],name);
 
HelpTxt("KBS",["e",e,"grad",grad,"center",center,"male",male,"female",female,"rot",rot,"n",n,"top",top,"knob",knob,"knobH",knobH,"fKnob",fKnob,"fKnobH",fKnobH,"dist",dist,"bh",bh,"name",name],help);    
}


/** \page Products \name GT2Pulley
GT2Pulley() creates a Pulley for GT2 Belts
\param h belt height
\param z number tooth
\param achse  center hole diameter
\param center  center pulley -1=outside 0 || false=inside 1 || true=center
\param fn  fragments 
\param name help name help
*/

// GT2Pulley(h=6.5,z=16,achse=5,center=-1);

module GT2Pulley(
h=6,// Belt h
z=16,// teeth
achse=6.6,//hole
center=true,
fn=fn,
name,
help){
d=2*z/PI+(0.63-0.254)*2+0.2;
    

center=is_bool(center)?center?1:0:center;
T(center?center<0?[0,0,h/2+1.1]:
            [0,0,0]:
        [z/PI,z/PI,h/2]){
if($info)%Ring(h,d=2*z/PI,rand=-.63,center=true);            
$info=false;            
LinEx(h+1,center=true)GT(z=z,achse=achse,fn=fn);
  difference(){
    MKlon(tz=-h/2-1.1){
      Pille(.5,d=d,rad2=0,center=false,fn=fn);//cylinder(.5,d=12);
      Tz(0.499)Kegel(d1=d,d2=d-2.5,grad=25,fn=fn);
    }
    Loch(h=h+2.2,h2=.5,deg=45,rad=.25,center=true,d=achse,l=0,cuts=false,fn=fn);
    *cylinder(h*3,d=achse,center=true);
    *MKlon(tz=-h/2-1.3)Kegel(achse+0.75);
  }
//%Ring(h,d=d,rand=1.38,center=true);

}

InfoTxt("GT2Pulley",["aussenH",h+2.2,"d",d,"radius Riemenmitte",z/PI],name);
HelpTxt("GT2Pulley",["h",h,"z",z,"achse",achse,"center",center,"fn",fn,"name",name],help);
}



module Abzweig(r1=5,r2=20,rad=2,inside=false,d1,d2,spiel=spiel,fn=fn,help){
  
  r1=is_undef(d1)?r1:d1/2;
  r2=is_undef(d2)?r2:d2/2;
  assert(r1<=r2,"r2>r1");
  fn2=fn/2;
  //$fn=fn;
  
function h(i)=Kathete(r2+rad,cos(i*360/fn)*(r1+rad))-rad; 
function hIn(i)=Kathete(r2+rad,cos(i*360/fn)*(r1+rad*1.50))+rad;     
sc=(r1+rad-rad*sin(asin((r1+rad)/(r2+rad))))/(r1+rad); 
    
rotate(inside?180:0,v=[0,1])intersection(){
    difference(){
        if(!inside)cylinder(r2+rad,r=r1+rad);
        if(inside)scale([1+(1-sc),1])Tz(-r2*2+rad)cylinder(r2+rad,r=r1+rad);
        cylinder((r2+rad)*3,r=r1-spiel,center=true);
        if(!inside)R(90)cylinder((r1+rad)*3,r=r2-spiel,center=true,$fa=+1,$fn=undef);   
        Tz(inside?rad*3:rad)for(i=[0:fn]){
         step=360/fn;  
            hull(){
              Tz(inside?-hIn(i):h(i))rotate(i*step)T(r1+rad,z=-rad)Pille(l=.1+r2+(inside?rad*3:rad)-h(i),r=rad,rad=rad,rad2=0,center=false,name=false,fn=fn,fn2=fn2);  
              Tz(inside?-hIn(i+1):h(i+1))rotate((i+1)*step)T(r1+rad,z=-rad)Pille(l=.1+r2+(inside?rad*3:rad)-h(i+1),r=rad,rad=rad,rad2=0,center=false,name=false,fn=fn,fn2=fn2);  
            }
   /*hull(){  hull(){
                    Tz(inside?-hIn(i):h(i))rotate(i*step)T(r1+rad)R(90)sphere(r=rad);
                    Tz((inside?-1:1)*r2)rotate(i*step)T(r1+rad)R(90)cylinder(.5,r1=rad,r2=0);
                }
                hull(){
                    Tz(inside?-hIn(i+1):h(i+1))rotate((i+1)*step)T(r1+rad)R(90)sphere(rad);//cylinder(.5,r1=rad,r2=0);
                    Tz((inside?-1:1)*r2)rotate((i+1)*step)T(r1+rad)R(90)cylinder(.5,r1=rad,r2=0);
                }
        }   // end hull */
        }
    }
if(!inside)scale([sc,1.00])cylinder(500,r=r1+rad,center=true);
if(inside)R(90) cylinder(500,r=r2+spiel,center=true);  
}

HelpTxt("Abzweig",["r1",r1,"r2",r2,"rad",rad,"inside",inside,"d1",d1,"d2",d2,"spiel",spiel,"fn",fn],help);
}


/** \name BB
\page Products
BB() creates a Ball bearing

\param achse center hole axle (calculated)
\param od  outer diameter (calculated)
\param h height (calculated)
\param r radius or roller distance from center (calculated)
\param ball ball or roller diameter (calculated)
\param rand wall thickness
\param e number roller (calculated)
\param spiel clearance
\param support added support ring and support distance
\param top top&bottorm thickness (calculated)
\param cage roller cage
\param cyl support base form ring or cylinder
\param rad  radius of rounding
\param pip  print in place distance
\param wFase,cFase roller with chamfer / center chamfer
\param center center
\param name help name help
*/



module BB(
achse=5,
od=20,
h,
r,
ball,
rand=1,
e,
spiel=0.125,
support=0.15,
top,
cage=false,
cyl=true,
rad=[.75,.75],
pip=pip,
wFase,
cFase,
center=true,
name,
help

){
    
rand=is_list(rand)?rand:[rand,rand]; 
top=is_undef(top)?rand[0]/2:top;
ball=max(is_undef(ball)?is_undef(h)?od/2-vSum(rand)-achse/2-spiel*2:
                             h-top*2-spiel*2:
                    ball
                    ,2); // min ball size 2
h=is_undef(h)?ball+top*2+spiel*2:h;
r=max(is_undef(r)?is_undef(od)?achse/2+ball/2+rand[1]:
                          is_undef(achse)?od-ball/2-rand[0]:
                                          od/4+achse/4:
             r
      ,ball/2+rand[1]);

walzen=wFase?true:false;
wFase=is_undef(wFase)?ball/4:wFase;
cFase=is_undef(cFase)?0:is_bool(cFase)&&cFase?wFase:cFase; // center

if(h<ball) Echo("BB h kleiner Kugel",color="red");
if(h>ball+top*2||walzen) Echo("BB Kugel = Walze!",color="green");    
achseDia=is_undef(achse)?r*2-ball-2*rand[1]-2*spiel:min(r*2-ball-2*rand[1]-2*spiel,achse);
oDia=is_undef(od)? r*2+ball+2*rand[0]+2*spiel:max(od,r*2+ball+2*rand[0]+2*spiel);  
e=is_undef(e)?floor(360/gradS(r=r,s=ball+spiel)):min(e,floor(360/gradS(r=r,s=ball+spiel)));    
if(achse&&achse>r*2-ball-2*rand[1]-2*spiel)Echo(str("BB Achse (",achse,") zu groß - limited↦ ",achseDia),color="red"); 
if(od&&od<r*2+ball+2*rand[0]+2*spiel)Echo(str("BB OD (",od,") zu klein - limited↦ ",oDia),color="red");

  InfoTxt("BB",["Achse",achseDia,"Hoch",h,"OD",oDia,"Kugel∅",h>ball+top*2?str(ball,"×",h-top*2):ball,"Anzahl",e],name);


 
 Tz(center?0:h/2){
  $info=false;
  $helpM=false; 
// Roller
    Polar(e,r)if(h>ball+top*2||walzen)
      if(cFase){
        MKlon(tz=-.001)Pille(h/2-top,d=ball,rad=[cFase,wFase],fn2=walzen?1:0,center=false);
        cylinder(h=cFase*2,r=ball/2-cFase+.2,center=true);
      }
      else Pille(h-top*2,d=ball,rad=walzen?wFase:undef,fn2=walzen?1:0);
      else sphere(d=ball);
// Rings
    difference(){
        union(){
            //Pille(h,d=oDia,rad=rad[0]);//Body
            Loch(h=h,l=0,d=oDia,h2=rad[0]*0.4,deg=-45,center=true,cuts=0,extrude=0);//Body
            Tz(center?0:-h/2)children();
        }
      if(achseDia) Loch(h=h,l=0,d=achseDia,h2=rad[1]*.4,deg=45,center=true,cuts=0);
      //Strebe(h,d=achseDia,rad=rad[1],center=true);// Achse    
        
        if(h>ball+top*2||walzen)Torus(trx=r,d=ball+spiel*2)
          if(!walzen)MKlon(mx=1)Pille(h-top*2+spiel*2,d=$d,2D=+1);
          else if(cFase){
            MKlon(ty=-.001)Quad(ball+spiel*2,h/2-(top-spiel),rad=[wFase,wFase,cFase,cFase]+spiel*[1,1,0,0],fn=1,center=[1,0]);
            square([ball-cFase*2+.4+spiel*4,cFase*2],center=true);
            }
            else Quad(ball+spiel*2,h-(top-spiel)*2,rad=wFase+spiel,fn=1);
          
         else Torus(trx=r,d=ball+spiel*2);////Rille
        
        Mklon(tz=h/2+1.25)Torus(trx=r,d=ball,fn2=6);//innenfase
        if(walzen)Mklon(tz=h/2+sqrt(3)/2*(ball-wFase*2)-top-.001)Torus(trx=r,r=ball-wFase*2,fn2=6);//innenfase
        MKlon(tz=h/2-top-.1)Ring(h+1,d=r*2,rand=walzen?ball-wFase*2+spiel*2:ball/2,rcenter=true,center=false);//Trennspalt
    }
    
 if (cage) difference(){
    union(){
        if(h>ball+top*2||walzen)Torus(trx=r,d=ball+spiel*2-pip*2)
          if(!walzen)MKlon(mx=1)Pille(h-top*2+spiel*2-pip*2,d=$d,2D=+1);
          else if(cFase){
            MKlon(ty=-.001)Quad(ball+(spiel-pip)*2,h/2-(top-spiel),rad=[wFase,wFase,cFase,cFase]+(spiel)*[1,1,0,0],fn=1,center=[1,0]);
            square([ball-cFase*2+.4+spiel*4-pip*2,cFase*2],center=true);
            }
          else Quad(ball+(spiel-pip)*2,h-(top-spiel-pip)*2,rad=(ball/2+spiel-pip)/2,fn=1);
          
         else Torus(trx=r,d=ball+spiel*2-pip*2);
        Ring(h=h,d=r*2,rand=ball/2,rcenter=true,center=true);
    }
    Polar(e,r){
      if(h>ball+top*2||walzen)Pille(h-top*2+pip*2,d=ball+pip*2,rad=walzen?wFase+pip:undef,fn2=walzen?1:0); else sphere(d=ball+pip*2);
      Tz(-h/2)cylinder(h=h,d=ball/2-.5+pip*2,center=true);
    }
   if(support) Tz(-h/2) Ring(h=top,d=r*2,rand=ball,rcenter=true,center=false);
 }  

//supportbrim
 if(support&&!cyl)difference(){
     Tz(-h/2)union(){
      Ring(h=walzen?top-support:top+.2,d=r*2,rand=ball/2-.5,rcenter=true,center=false);
      if(walzen)Polar(e,r)Kegel(d2=ball-wFase*2-support*2,d1=ball-wFase*2-top*2);
      }
     
     if(!walzen)if (h>ball+top*2) Tz(-h/2+top+ball/2)Polar(e,r)sphere(r=ball/2+support);
         else Polar(e,r)sphere(r=ball/2+support);
 }
 if(cyl)Tz(-h/2){
     Polar(e,r){
      cylinder(h=h/2,d=ball/2-.5);
      if(walzen)Tz(top+0.001)R(180)Kegel(d1=ball-wFase*2,d2=ball-wFase*2-top*2);
     }
     if(support)Ring(l(2),r=r,rand=n(2),rcenter=true);
 }
 }
HelpTxt("BB",["achse",achse,"od",od,"h",h,"r",r,"ball",ball,"rand",rand,"e",e,"spiel",spiel,"support",support,"top",top,"cage",cage,"cyl",cyl,"rad",rad,"pip",pip,"wFase",wFase,"center",center,"name",name],help); 
}

/** \page Product
* \name Pin
Pin() creates a pin or Peg to fix or swivel with 45°(deg) lip
\param l length ↦ [bottom,top]
\param d diameter of core body
\param cut number incisions [bottom,top]
\param cutDepth  depth of the cuts
\param cutDeg   angle of cuts
\param mitte middle lip
\param lippe lip size (od=d+2×lip)
\param spiel lip height and clearance between connected parts
\param center center pin
\param deg   lip angle
\param flat  flat sides (true or num for thickness)
\param print orient for printing
\param fn fs  fraqments number size

*/

//Pin(l=[3,7],deg=[60,30]);
//Pin(10,flat=true,cut=4,grad=85);

/*
difference(){
  cube(20);
  Pin(spiel=0.2,cut=false);
  }
Cut()Pin();
//*/


module Pin(l=10,d=5,cut=true,cutDepth=1,cutDeg,mitte=true,grad=60,lippe=0.25,spiel=0,center=true,deg=45,flat=false,print=false,fn=0,fs=fs,name,help){
spiel2=0.1;
$info=false;
d=d;
id=d+spiel*2;
nib=is_num(lippe)?[lippe,lippe]:lippe;
rdiff=nib+[1,1]*(spiel+spiel2);

rdiffCenter=(is_bool(mitte)?min(lippe):mitte)+spiel+spiel2;

cut=is_list(cut)?cut:[cut,cut];
deg=is_list(deg)?deg:[deg,deg];
grad=is_list(grad)?grad:[grad,grad];
pol=[is_bool(cut[0])?flat?round(d/2)*2
                         :round(d)
                    :cut[0],
     is_bool(cut[1])?flat?round(d/2)*2
                         :round(d)
                    :cut[1]];

flat=is_bool(flat)?flat?cos(45)*id/2*2:0
                  :flat;

il=is_list(l)?l:[l/2,l/2];// input l
l=is_num(l)?[l/2+spiel2*tan(deg[0]),l/2+spiel2*tan(deg[1])]:l+spiel2*[tan(deg[0]),tan(deg[1])];    
hkomplett=[
  l[0]+(grad[0]<90?tan(grad[0])*rdiff[0]:10),
  l[1]+(grad[1]<90?tan(grad[1])*rdiff[1]:10)
  ];

cutDepth=is_num(cutDepth)?cutDepth*[1,1]:cutDepth;

// cut width for flat 
flatCut=[
max(nib[0]*2+.2,Kathete(id/2,flat/2)*2-2 ),
max(nib[1]*2+.2,Kathete(id/2,flat/2)*2-2 )
];

// notches cut Length
cutH=[
  min(hkomplett[0]-nib[0],rdiff[0]*(tan(grad[0])+tan(deg[0]) )+3-spiel+cutDepth[0]),
  min(hkomplett[1]-nib[1],rdiff[1]*(tan(grad[1])+tan(deg[1]) )+3-spiel+cutDepth[0])
  ];
  

cutH2=[min(cutH[0]/2,cutDepth[0]),min(cutH[1]/2,cutDepth[1])];

// wedge angle
cutDeg=is_num(cutDeg)?cutDeg*[1,1]:cutDeg;
degCut=is_undef(cutDeg)?[min(flat?90:120,360/pol[0]),min(flat?90:120,360/pol[1])]:cutDeg;

Tz(print?flat?flat/2:id/2+max(nib):0)rotate(print?[0,90]:[0,0])
 translate([0,0,center?0:l[0]+tan(grad[0])*rdiff[0]]){
//bottom
  if(il[0])mirror([0,0,1])difference(){
      union(){
          cylinder(l[0]+.001,d=id,$fn=fn,$fs=fs);
          Tz(l[0]-.001)Kegel(id+rdiff[0]*2,id,h=grad[0]==90?10:0,grad=grad[0],fn=fn,fs=fs);
          if(deg[0])Tz(l[0])R(180)Kegel(id+rdiff[0]*2,id-1,grad=deg[0],fn=fn,fs=fs);
          if(mitte) difference(){
            Kegel(id+rdiffCenter*2,id-1,grad=45,fn=fn,fs=fs);
            linear_extrude(height=rdiffCenter*2,center=true,convexity=3)Kreis(r=id,rand=id/2-rdiffCenter+spiel+spiel2,fn=fn,fs=fs);
          }
      }
    if(cut[0])  Tz(hkomplett[0]-cutH[0]+.01)Polar(pol[0],d-cutDepth[0])
      LinEx(cutH[0],cutH2[1],0,grad=45,$d=d,center=0)
        offset(-spiel)T(-d/2)Tri(h=$d,top=+1,tang=0,center=0,grad=degCut[0],r=0.3,fn=12);
        
    Tz(rdiffCenter) linear_extrude(hkomplett[0],center=false,convexity=3)Kreis(r=id,rand=id/2-rdiff[0]+spiel+spiel2,fn=fn,fs=fs);
    if(flat){
      MKlon(flat/2+d/2)cube([d-spiel*2,d*2,vSum(hkomplett)*3],true);
      if(cut[0])Tz(l[0]-min(l[0]-0.5,3))R(0,-90)linear_extrude(id*2,center=true)Quad(hkomplett[0],flatCut[0],center=[0,1]);
    }
  }
//top
  if(il[1])difference(){
      union(){
          cylinder(l[1]+.001,d=id,$fn=fn,$fs=fs);
          Tz(l[1]-.001)Kegel(id+rdiff[1]*2,id,grad=grad[1],h=grad[1]==90?10:0,fn=fn,fs=fs);
          if(deg[1])Tz(l[1])R(180)Kegel(id+rdiff[1]*2,id-1,grad=deg[1],fn=fn,fs=fs);
          if(mitte)difference(){
            Kegel(id+rdiffCenter*2,id-1,grad=45,fn=fn,fs=fs);
            linear_extrude(height=rdiffCenter*2,center=true,convexity=3)Kreis(r=id,rand=id/2-rdiffCenter+spiel+spiel2,fn=fn,fs=fs);
          }
      }
    if(cut[1]) Tz(hkomplett[1]-cutH[1]+.01)Polar(pol[1],d-cutDepth[1])
      LinEx(cutH[1],cutH2[1],0,grad=45,$d=d,center=false)
        offset(-spiel)T(-$d/2)Tri(h=$d,top=+1,center=+0,tang=0,grad=degCut[1],r=0.3,fn=12);
        
    Tz(rdiffCenter) linear_extrude(hkomplett[1],center=false,convexity=3)Kreis(r=id,rand=id/2-rdiff[1]+spiel+spiel2,fn=fn,fs=fs);
    if(flat){
      MKlon(flat/2+d/2)cube([d-spiel*2,d*2,vSum(hkomplett)*2],true);
      if(cut[1])Tz(l[1]-min(l[1]-0.5,3))R(0,-90)linear_extrude(id*2,center=true)Quad(hkomplett[1],flatCut[1],center=[0,1]);
    }
  }
}
//if(achse)cylinder(h=achse,d=d+rdiff*2,center=true);

InfoTxt("Pin",["l",l[0]+l[1],"reale höhe",vSum(hkomplett),"halb",str(l,"/",hkomplett),"plusCap",str((tan(grad[0])+tan(grad[1]))*rdiff," (",tan(grad[0])*rdiff,"/",tan(grad[1])*rdiff,")"),"Lippe",lippe],name);

HelpTxt("Pin",["l",l,"d",d,"cut",cut,"cutDepth",cutDepth,"cutDeg",cutDeg,"mitte",mitte,"grad",grad,"lippe",lippe,"spiel",spiel,"center",center,"deg",deg,"flat",flat,"print",print,"fn",fn,"fs",fs,"name",name],help);

}


module Klammer(l=10,grad=250,d=4,rad2=5,offen=+25,breite=2.5,fn=fn,help){
    $x=breite;
    w2=offen/2-90+grad/2;
    l=is_list(l)?l:[l,l];
    
 if($children){   
  RotEx(grad,center=true,fn=fn)T(d/2)children();  //centerring
  union(){ //arme
    $helpM=0;
    $info=0;
    MKlon(mz=0,my=1){
        rotate((grad-180.01)/2)T(0,rad2+breite+d/2)rotate(270-w2){
            RotEx(w2,fn=fn/2)T(rad2+breite)mirror([1,0])children();//Bogen
            T(rad2)union(){
                R(90)linear_extrude(height=$idx?l[0]:l[1])T(breite)mirror([1,0])children(); // Arm grade
                T(+breite/2,$idx?-l[0]:-l[1])rotate(180) RotEx(cut=true,grad=180,fn=fn/4)T(-breite/2)children(); //Endstück
            }
        }
    }
  }
  }else union(){
      $info=0;
      $helpM=0;
     Kreis(grad=grad,center=true,r=d/2,rand=-breite,fn=fn); 
     MKlon(mz=0,my=1){
         rotate((grad-180.01)/2)T(0,rad2+breite+d/2)rotate(180){
             Kreis(grad=w2,fn=fn/2,center=false,r=rad2,rot=-90,rand=-breite);
            rotate(-w2)T(0,rad2){ square([$idx?l[0]:l[1],breite]);
             T($idx?l[0]:l[1],breite/2)Kreis(grad=180,fn=fn/4,center=false,rot=-90,r=breite/2,rand=0);
            }
         }
         
     } 
      
  } 
  
  
  
HelpTxt("Klammer",[
  "l",l,
  "grad",grad,
  "d",d,
  "rad2",rad2,
  "offen",offen,
  "breite",breite,
  "fn",fn]
  ,help);

}

/// cycloid gear

module CyclGear(z=20,modul=2,w=45,h=4,h2=.5,grad=45,achse=3.5,achsegrad=45,light=false,lock=false,center=true,lRand=wall(0.8,$info=false),lRandBase,d=0,rot,rotZahn=1,linear=false,preview=true,spiel=0.075,f=3,fn=24,lap=0,name,help){
CyclGetriebe(z=z,modul=modul,w=w,h=h,h2=h2,grad=grad,achse=achse,achsegrad=achsegrad,light=light,lock=lock,center=center,lRand=lRand,lRandBase=lRandBase,d=d,rot=rot,rotZahn=rotZahn,linear=linear,preview=preview,spiel=spiel,f=f,fn=fn,lap=lap,name,help);
}


module CyclGetriebe(z=20,modul=1.5,w=45,h=4,h2=.5,grad=45,achse=3.5,achsegrad=45,light=false,lock=false,center=true,lRand=wall(.5,$info=false),lRandBase,d=0,rot,rotZahn=1,linear=false,preview=true,spiel=0.075,f=2,fn=24,name,help,lap=0){
    //$info=false;
    z=abs(round(z));
    rot=is_undef(rot)?90/z*rotZahn:rot;
    center=is_bool(center)?center?1:0:center;
    preview=$preview?preview:true;
    linear=linear==true?1:linear;
    r=z/f*modul/2;
    mitteR=(r-modul/2)/2+achse/4;
    rand=r-achse/2-modul/2-lRand*2;
    lRandBase=is_undef(lRandBase)?lRand*1.85:lRandBase;
    
  if(!linear){
    T(center?0:-z/f/2*modul)T(y=center>1?z/f/2*modul:0)rotate(rot - (center>1?90:0))difference(){
        $info=false;
        LinEx(h=h,h2=h2,$d=z/f*modul,mantelwinkel=w,slices=preview?(h-1)*2:2,grad=d>r*2?-grad:grad,lap=lap)
          if($preview&&!preview) Kreis(d=d>r*2?d:$d,rand=d>r*2?d/2-r:r-d/2);
          else CycloidZahn(modul=modul,z=z/f,f=f,d=d,spiel=spiel,fn=fn);
  //center hole
        if(achse) Tz(-.01)LinEx(h=h+.02,h2=h2,$d=achse,grad=-achsegrad)circle(d=$d,$fs=fs,$fn=0,$fa=2);
        
        if(light) Tz(-0.01)Polar(light)T(light>1?mitteR:0)LinEx(h=h+.02,h2=h2,$r=rand,grad=-60)T(light>1?-mitteR:0)Rund(min(rand/light,rand/2-0.1),fn=fn)Kreis(r=mitteR,rand=rand,
        grad=min(360/light - gradS(s=lRand,r=mitteR+rand/2),320),
        grad2=max(360/light - gradS(s=wall(lRandBase),r=mitteR-rand/2),2)
        ,rcenter=true,fn=fn/light*2);
        
        if(lock)rotate(90)Tz(-0.01)LinEx(h=h+.02,h2=h2,$r=achse/2,grad=-60)WStern(f=is_num(lock)?lock:5,help=0,r=$r,fn=(is_num(lock)?lock:5)*15);
    }
    InfoTxt("CyclGetriebe",["Wälzradius",z/f*modul/2],name);
  }
    
 
  if (linear){
    $info=false;
    M(skewzx=-tan(w))T(0,-linear)LinEx(h,.5,$r=linear,grad=[90,grad],grad2=[90,grad])T(0,linear)CycloidZahn(z=z/f,f=f,modul=modul,fn=fn,linear=linear,center=center,spiel=spiel);
    }
    //Color()T(mitteR,0,4)circle(d=rand);

HelpTxt("CyclGetriebe",[
    "z",z,
"modul",modul,
"w",w,
"h",h,
"h2",h2,
"grad",grad,
"achse",achse,
"achsegrad",achsegrad,
"light",light,
"lock",lock,
"center",center,
"lRand",lRand,
"lRandBase",lRandBase,
"d",d,
"rot",rot,
"rotZahn",rotZahn,
"linear",linear,
"preview",preview,
"spiel",spiel,
"f",f,
"fn",fn,
"name",$info]
,help);

}


//DRing(d=5);


module DRing(d=4,id=20,r=.5,l=0,grad=180,fn=fn,center=true,name,help){
    $info=false;
    $d=d;
    r=is_list(r)?r:[r,d/2];
  
  
   translate(center?[0,0]:[0,d/2+r[0]+l])union(){
    if($children){
        DBogen(fn=fn/2,grad=grad,x=(id+d)+r[0]*2,rad2=max(r[1],.0001))children();
      union(){
        $info=false;
        //RotEx(180,fn=fn/2)T((id+d)/2+r)children();
        T(y=-l)MKlon(tx=id/2)rotate(-90)RotEx(90,fn=fn/4)T(d/2+r[0])children();
        T(y=-d/2-r[0]-l)R(90,0,-90)linear_extrude(id,center=true)children();
        if(l)MKlon((id+d)/2+r[0])R(90)linear_extrude(l,center=false)children(); 
      }
    }
    else{
    //RotEx(180,fn=fn/2)T((id+d)/2+r[0]) circle(d=d,$fn=fn);
     DBogen(fn=fn/2,grad=grad,x=(id+d)+r[0]*2,rad2=max(r[1],.0001))circle(d=d,$fn=fn);   
    T(y=-l)MKlon(tx=id/2)rotate(-90)RotEx(90,fn=fn/4)T(d/2+r[0])circle(d=d,$fn=fn);
    if(l)MKlon((id+d)/2+r[0])R(90)linear_extrude(l,center=false) circle(d=d,$fn=fn);
    T(y=-d/2-r[0]-l)R(90,0,-90) linear_extrude(id,center=true) circle(d=d,$fn=fn);
        
    }
  if(name)%T(y=-d-r[0]-l-$vpd/100)Caliper(id,messpunkt=0);
  }    
InfoTxt("DRing",["dist",id+r[0]*2+d,"mm innen h=",str(l+2*r[0]+id/2,"mm")],name);
HelpTxt("DRing",[
  "d",d,
  "id",id,
  "r",r,
  "l",l,
  "grad",grad,
  "fn",fn,
  "centre",center,
  "name",name]
   ,help);    
}

/** \page Products
\name SRing
SRing() creates a self locking retaining ring
\param e number of arms
\param id target arbor diameter
\param od outer diameter
\param h thickness
\param rand rim
\param reduction  smaller id/2
\param schlitz ratio  land/groove
*/


// SicherungsRing
module SRing(e=4,id=3.5,od=10,h=.8,rand=1.5,reduction=.5,schlitz=-17,help){
$info=false;
intersection(){
    LinEx(h,.2,scale=1.05)Rund(0.3)difference(){
       Kreis(od/2);
       Rund(0.5) Stern(e,od/2-rand,id/2-reduction-1,mod=100,delta=schlitz);
       rotate(180+180/e)intersection_for(i=[0:e-1])rotate(i*360/e)T(reduction)Kreis(id/2,fn=e*15);
    }
    Tz(-.005)Pille(h+.01,d=od,rad=min(.3,h/3),center=false);
}
HelpTxt("SRing",[
"e",e,
"id",id,
"od",od,
"h",h,
"rand",rand,
"reduction",reduction,
"schlitz",schlitz,]
,help);
}

/*
Bevel(5){
cube(5);
R(180)VarioFill(dia=0,spiel=[.5,0],l=.5,fn=7);
}// */


module PCBcase(
pcb=[20,40,1],/*breite×länge×höhe*/
h=20,/*höhe*/
wand,/*Wandstärke */
r2=3,/*Innenradius*/
rC=2,/*Eckradius*/
rS=2,/*Kantenradius*/
spiel=0.2,
kabel,/*Kabelloch[b,h]*/
kanal,
kpos=[0,0],
tasche=5,
deckel=false,
dummy=1,
name,
clip=true,
help
){
  deckel=is_bool(deckel)?b(deckel):deckel;
  $info=false; 
  rS=abs(rS);
  rC=max(rS,abs(rC));  
  wand=max(rC-rC/sqrt(2)+rS/sqrt(2),rS,is_undef(wand)?0:wand-spiel); 
  kabel=is_num(kabel)?[kabel,kabel/1.618]:kabel;
  spiel=abs(spiel);
  $helpM=0; 
  size=[pcb[0]+(wand+spiel)*2,pcb[1]+(wand+spiel)*2,h];
  kabelrundung=1; // rundungsradius Kabellochecken  
  //  %translate([0,0,h/2])cube(size,true);
  //if(name&&!$children)echo(str("<H2>Case size=",size));
  if(!deckel)InfoTxt("Case",[$children?"Inside":"size",$children?pcb+[0,0,h-tasche-wand]:size,"pcb headroom",str(h-tasche-wand,"mm")],name);
  else InfoTxt("Case",["Deckeldicke",str(tasche-pcb[2]-spiel,"mm")],name);    
  assert(is_list(pcb),"No pcb size");




if(deckel&&!(deckel<0)){ // for render

        
    difference(){
    linear_extrude(tasche-pcb[2]-spiel,convexity=5)offset(.5,$fn=24)square([pcb[0]-1,pcb[1]-1],true);
    translate([0,0,+1.5])linear_extrude(50,convexity=5)square([pcb[0]-2,pcb[1]-2],true);
}

if(clip)Tz((tasche-pcb[2])/2){//clip positiv
    MKlon(pcb[0]/2)R(90)LinEx(pcb.y*.75-spiel*2,center=true,end=true)Vollwelle(r=.5-spiel,extrude=0,xCenter=-1,fn=4,x0=-.1);
    MKlon(tx=0,ty=pcb[1]/2)R(90,0,90)LinEx(pcb.x*.75-spiel*2,center=true,end=true)Vollwelle(r=.5-spiel,extrude=0,xCenter=-1,fn=4,x0=-.1);
    }
   


if(kanal)intersection(){
    if($children)children();
        else minkowski(){
          translate([0,0,h/2])cube([pcb[0]-rS*2-(rC-rS)*2+wand*2+spiel*2,pcb[1]-rS*2-(rC-rS)*2+wand*2+spiel*2,h-rS*2],true);
          sphere(rS,$fn=36);
          cylinder(minVal,r=rC-rS,$fn=72);
        }
    union(){
        translate([pcb[0]/2,kpos[0]-kanal/2+spiel,0])
        cube([wand+150,kanal-spiel*2,tasche-spiel-(deckel<2?kpos[1]<0?-kpos[1]:0:pcb[2])],center=false);
    }
    
}



}

//PCB dummy
if(dummy&&$preview)color([0.6,0.6,0.2,0.5])translate([0,0,tasche-pcb[2]])linear_extrude(pcb[2],convexity=5)square([pcb[0],pcb[1]],true);
    
if(!deckel||($preview&&deckel!=3)||deckel==2||deckel<0)color(alpha=deckel==1?0.5:1){
    difference(){
     if(!$children)   minkowski(){
          translate([0,0,h/2])cube([pcb[0]-rS*2-(rC-rS)*2+wand*2+spiel*2,pcb[1]-rS*2-(rC-rS)*2+wand*2+spiel*2,h-rS*2],true);
          sphere(rS,$fn=36);
          cylinder(minVal,r=rC-rS,$fn=72);
        }
     else children();   
       translate([0,0,h/2-wand-2.5])minkowski(){
           cube([pcb[0]-r2*2-1,pcb[1]-r2*2-1,h-r2*2+5],true);
           sphere(r2,$fn=36);
           
       }
    if(kabel)color([0.7,0.7,0.8])translate([pcb[0]/2-.5-r2,kpos[0],kpos[1]+tasche+kabel[1]/2])rotate([90,0,90])linear_extrude(500,convexity=5)offset(kabelrundung,$fn=24)square(kabel-[kabelrundung*2,kabelrundung*2],true); //Kabelloch
    if(kanal)translate([50,kpos[0],0])cube([100,kanal,tasche*2],true);    

    
    linear_extrude(tasche*2,center=true,convexity=5)offset(.5+spiel,$fn=24)square([pcb[0]-1,pcb[1]-1],true);
    
    if($children)color([.5,0.4,0.5])rotate([180])cylinder(100,d=500,$fn=6);
        
    if(clip)Tz((tasche-pcb[2])/2){ //clip negativ
        MKlon(pcb.x/2+spiel)R(90)LinEx(pcb.y*.75,center=true,end=true)Vollwelle(r=.5,extrude=0,xCenter=-1,fn=4,x0=-1);
        MKlon(tx=0,ty=pcb.y/2+spiel)R(90,0,90)LinEx(pcb.x*.75,center=true,end=true)Vollwelle(r=.5,extrude=0,xCenter=-1,fn=4,x0=-1);
    }

   }

}
if(!deckel&&$preview)color(alpha=0.5){ // only view deckel in preview if deckel=0
    difference(){
    linear_extrude(tasche-pcb[2]-spiel,convexity=5)offset(.5,$fn=24)square([pcb[0]-1,pcb[1]-1],true);
    translate([0,0,+1.5])linear_extrude(50,convexity=5)square([pcb[0]-2,pcb[1]-2],true);
    }

    if(clip) Tz((tasche-pcb[2])/2){//clip positiv
        MKlon(pcb[0]/2)R(90)LinEx(pcb.y*.75-spiel*2,center=true,end=true)Vollwelle(r=.5-spiel,extrude=0,xCenter=-1,fn=4,x0=-.1);
        //Pille(pcb[1]*.75-spiel*2,d=1-spiel*2,fn=12,fn2=12,name=0);
        MKlon(tx=0,ty=pcb[1]/2)R(90,0,90)LinEx(pcb.x*.75-spiel*2,center=true,end=true)Vollwelle(r=.5-spiel,extrude=0,xCenter=-1,fn=4,x0=-.1);
        //Pille(pcb[0]*.75-spiel*2,d=1-spiel*2,fn=12,fn2=12,name=0);
    }

    if(kanal)intersection(){
        if($children)children();
            else minkowski(){
              translate([0,0,h/2])cube([pcb[0]-rS*2-(rC-rS)*2+wand*2+spiel*2,pcb[1]-rS*2-(rC-rS)*2+wand*2+spiel*2,h-rS*2],true);
              sphere(rS,$fn=36);
              cylinder(minVal,r=rC-rS,$fn=72);
            }
            
        union(){
            translate([pcb[0]/2,kpos[0]-kanal/2+spiel,0])
            cube([wand+150,kanal-spiel*2,tasche-spiel-(deckel<2?kpos[1]<0?-kpos[1]:0:pcb[2])],center=false);
        }    
        
    }
}
HelpTxt("PCBcase",[
  
"pcb",str(pcb,"/*Platine[Breite×Länge×Höhe]*/")," 
h",str(h,"/*Höhe*/"),"
wand",str(wand,"/*Wandstärke */")," 
r2",str(r2,"/*Innenradius*/")," 
rC",str(rC,"/*Eckradius*/")," 
rS",str(rS,"/*Kantenradius*/")," 
spiel",str(spiel,"/*Deckelspiel*/")," 
kabel",str(kabel,"/*Kabelloch[b,h]*/"),"
kanal",str(kanal,"/*Kabelkanal breite*/"),"
kpos",str(kpos,"/*Kabelposition[y,z]*/"),"
tasche",str(tasche,"/*Taschen h für Platine*/"),"
deckel",str(deckel,"/*render Deckel option 0-2*/"),"
dummy",str(dummy,"/*show PCB */"),"
name",name,"
clip",clip
],help);

}




/** \name CRing
\page Products
CRing() creates a C-shaped Ring with given inner diameter
\param id inner diameter
\param grad  angle of the C
\param h height 
\param rand thickness
\param rad corner radius
\param end end corner option 0:no 1:round 2:flat
\param txt surface text embossed
\param tSize text size
\param tPos text position [rot angle,h]
\param center center height and angle
*/


/*
Cring(txt="|-test-|",id=20,h=6,tSize=5,center=0 ,end=2,rad=0.6);
T(0,14)R(90,0,180)Text("test",h=1,size=5);
// */
module Cring(id=20,grad=230,h=15,rand=3,rad=1,end=1,txt=undef,spacing=1,tSize=5,tPos=[0,0],tDepth=.35,center=true,fn=fn,fn2=36,help)
CRing(id,grad,h,rand,rad,end,txt,spacing,tSize,tPos,tDepth,center,fn,fn2,help);

module CRing(
id=20,
grad=230,
h=15,
rand=3,
rad=1,
end=1,
txt=undef,
//tWeite,
spacing=1,
tSize=5,
tPos=[0,0],
tDepth=.35,
center=true,
fn=fn,
fn2=36,
help
){
center=center==true?1:center==false?0:center;    
//tWeite=is_undef(tWeite)?tSize*0.9:tWeite;
    
Tz(center>0?-h/2:0)rotate(center?-grad/2:0){
  rad=min(rad,h/2,rand/2);  
    
  difference(){
    rotate_extrude(angle=grad,$fn=fn,convexity=5)T(id/2)Quad(rand,h,r=rad,center=false,fn=fn2,help=0,name=0);
    if(txt!=undef)Tz(h/2-tSize/2+tPos.y)difference(){
     rotate(grad/2-90+tPos.x)mirror([1,0])Text(text=txt,h=1,size=tSize,radius=id/2+rand,rot=[90],spacing=spacing,center=true,cy=+0,trueSize="size");
     //%union()for(i=[0:len(txt)-1])rotate(grad/2+i*atan(tWeite/(id/2+rand))-(len(txt)-1)/2*atan(tWeite/(id/2+rand)))T(id/2+rand)R(90,0,90)Text(text=txt[i],h=1,cx=true,cz=true,size=tSize);
      Col(4)  cylinder(100,d=id+rand*2-tDepth*2,center=true,$fn=fn);
    }
  }
  if(end==1){    
    T(id/2+rand/2)Pille(l=h,d=rand,rad=rad,center=false,fn=fn2,fn2=fn2/4,name=0);
    rotate(grad)T(id/2+rand/2)Pille(l=h,d=rand,rad=rad,center=false,fn=fn2,fn2=fn2/4,name=0);
  }
  if(end==2){    
    T(id/2+rand/2,0,h/2)R(90)Tz(-rad)Prisma(c1=0,x1=rand,z=rad*2,y1=h,s=rad*2,fnS=fn2,name=0,help=0);
    rotate(grad)T(id/2+rand/2,0,h/2)R(90)Tz(-rad)Prisma(c1=0,x1=rand,z=rad*2,y1=h,s=rad*2,fnS=fn2,name=0,help=0);
  }
}
HelpTxt("Cring",[
 "id", id,
"grad",grad,
 "h",h,
 "rand",rand ,
 "rad",rad ,
 "end", end ,
 "txt",txt ,
 //"tWeite",tWeite ,
 "spacing",spacing,
 "tSize", tSize,
 "tPos",tPos,
 "tDepth",tDepth,
 "center", center ,
 "fn", fn,
 "fn2",fn2],
 help);

}




module Achsenklammer(abst=10,achse=3.5,einschnitt=1,h=3,rand=n(2),achsenh=0,fn=fn,help){
    
    achse=is_list(achse)?achse:[achse,achse];
    achsenh=is_list(achsenh)?achsenh:[achsenh,achsenh];
    if (achsenh[0])T(-abst/2)LinEx(achsenh[0]+h,[0,achsenh[0]>+.5?.5:0],grad=45,$d=achse[0])circle(d=$d+(achsenh[0]<0?.1:0),$fn=fn);
    if (achsenh[1])T(abst/2)LinEx(achsenh[1]+h,[0,achsenh[1]>+.5?.5:0],grad=45,$d=achse[1])circle(d=$d+(achsenh[1]<0?0.1:0),$fn=fn);
    
    if(h)linear_extrude(h,convexity=5)
    difference(){
        union(){
            //if(achse[0]==achse[1])T((achse[1]-achse[0])/4)Halb(2D=1,y=1)Ring(0,(achse[0]+achse[1])/2+rand*2,abst,cd=0,2D=1,name=0,fn=fn,help=0); else
            T((achse[1]-achse[0])/4)Kreis(d=(achse[0]+achse[1])/2+rand*2+abst,grad=180,rand=0,help=0,name=0,rot=-90);
            T(abst/2)circle(d=achse[1]+rand*2,$fn=fn);
            T(-abst/2)circle(d=achse[0]+rand*2,$fn=fn);
        }
        T(-(achse[1]-achse[0])/4)hull(){
            T(y=-einschnitt*(achse[0]+achse[1])/2)circle(d=abst-((achse[0]+achse[1])/2+rand*2),$fn=fn);
            T(y=einschnitt*(achse[0]+achse[1])/2)circle(d=abst-((achse[0]+achse[1])/2+rand*2),$fn=fn);
        }
        if(achsenh[0]<=0) T(-abst/2)circle(d=achse[0],$fn=fn);
        if(achsenh[1]<=0) T( abst/2)circle(d=achse[1],$fn=fn);
    }
    else difference(){
        union(){
            //if(achse[0]==achse[1])T((achse[1]-achse[0])/4)Halb(2D=1,y=1)Ring(0,(achse[0]+achse[1])/2+rand*2,abst,cd=0,2D=1,name=0,fn=fn,help=0); else
            T((achse[1]-achse[0])/4)Kreis(d=(achse[0]+achse[1])/2+rand*2+abst,grad=180,rand=0,help=0,name=0,rot=-90);
            T(abst/2)circle(d=achse[1]+rand*2,$fn=fn);
            T(-abst/2)circle(d=achse[0]+rand*2,$fn=fn);
        }
        T(-(achse[1]-achse[0])/4)hull(){
            T(y=-einschnitt*(achse[0]+achse[1])/2)circle(d=abst-((achse[0]+achse[1])/2+rand*2),$fn=fn);
            T(y=einschnitt*(achse[0]+achse[1])/2)circle(d=abst-((achse[0]+achse[1])/2+rand*2),$fn=fn);
        }
        if(achsenh[0]<=0) T(-abst/2)circle(d=achse[0],$fn=fn);
        if(achsenh[1]<=0) T( abst/2)circle(d=achse[1],$fn=fn);
    }
    
    HelpTxt("Achsenklammer",["abst",abst,"achse",achse,"einschnitt",einschnitt,"h",h,"rand",rand,"achsenh",achsenh,"fn",fn],help);
}

module Tring(spiel=+0,angle=153,r=5.0,xd=+0.0,h=1.75,top=n(2.5),base=n(4),name=0,help){
  
  HelpTxt("Tring",["spiel",spiel,"angle",angle,"r",r,"xd",xd,"h",h,"top",top,"base",base,"name",name],help);
    
   T(0,0,-spiel/2) scale([1.005,1,1]){rotate(-angle/2-180)rotate_extrude(angle=angle)T(r)Trapez(h=h+spiel,x1=base+spiel,x2=top+spiel,x2d=xd,d=+1+spiel,name=name);
   T(0,0,1.25)rotate((360-angle)/2)T(r)R(90)linear_extrude(1,scale=0.7)T(0,-1.25)Trapez(h=h+spiel,x1=base+spiel,x2=top+spiel,x2d=xd,d=+1+spiel,name=name);
   T(0,0,1.25)rotate((360-angle)/-2)T(r)R(90)mirror([0,0,1])linear_extrude(1,scale=0.7)T(0,-1.25)Trapez(h=h+spiel,x1=base+spiel,x2=top+spiel,x2d=xd,d=+1+spiel,name=name);    
   }
}

//Balg();

module Balg(sizex=16,sizey=16,z=10.0,kerb=6.9,rand=-0.5,help){
  minVal=0.001;
  sizey=is_list(sizex)?sizex.y:sizey;
  sizex=is_list(sizex)?sizex.x:sizex;
  HelpTxt("Balg",["sizex",sizex,"sizey",sizey,"z",z,"kerb",kerb,"rand",rand],help);
   //Y Falz
   T(z=z+z/2)difference(){
       cube([sizex,sizey,z],true);
       Klon(tx=(50-kerb/2+sizex/2))rotate(45)MKlon(tz=-minVal)Kegel(fn=4,d1=hypotenuse(100,100),d2=hypotenuse(100-kerb,100-kerb),name=0);
       MKlon(ty=sizey/2+50-kerb/2,mz=0)difference(){
           rotate(45)MKlon(tz=-minVal)Kegel(fn=4,d1=hypotenuse(100,100),d2=hypotenuse(100-kerb,100-kerb),name=0);
           MKlon(tx=sizex/2+59.0+rand,mz=0)T(0,-54.4)  MKlon(tz=-minVal,rz=+0)rotate(+0)Kegel(fn=4,d1=hypotenuse(100,100),d2=hypotenuse(100-kerb,100-kerb),v=1.4,name=0);
       }
    }
    
   //X falz 
 T(z=z/2)difference(){
     cube([sizex,sizey,z],true);
     MKlon(ty=sizey/2+50-kerb/2,mz=0)rotate(45)Mklon(tz=-minVal)Kegel(fn=4,d1=hypotenuse(100,100),d2=hypotenuse(100-kerb,100-kerb),name=0);      
     MKlon(tx=50-kerb/2+sizex/2,mz=0) difference(){
         rotate(45) MKlon(tz=-minVal)Kegel(fn=4,d1=hypotenuse(100,100),d2=hypotenuse(100-kerb,100-kerb),name=0);
         MKlon(ty=(sizey/2+59+rand)/1+0,mz=0) T(-54.4)  MKlon(tz=-minVal,rz=+0)rotate(+0)Kegel(fn=4,d1=hypotenuse(100,100),d2=hypotenuse(100-kerb,100-kerb),v=1.4,name=0);
     }
 }
}

module ReuleauxIntersect(h=2,rU=5,2D=false,help){
  
  HelpTxt("ReuleauxIntersect",["h",h,"rU",rU,"2D",2D],help);
        
teilradius=rU/(sqrt(3)/3);
rI=teilradius-rU;
if(2D)union()
        {
            Polar(3,n=0)intersection(){
                T(rU)circle(r=rU);
                rotate(120)T(rU)circle(r=rU);        
                }
                
            difference(){        
                circle(r=rU*0.521);    
                Polar(3,rU,n=0)circle(r=rI);
            }
        }        
if(!2D)linear_extrude(height=h,convexity=10,center=true){
    union()
        {
            Polar(3,n=0)intersection(){
                T(rU)circle(r=rU);
                rotate(120)T(rU)circle(r=rU);        
                }
                
            difference(){        
                circle(r=rU*0.521);    
                Polar(3,rU,n=0)circle(r=rI);
            }
        }
    }    
}


module Tugel(
dia=40,
loch=+24.72,
scaleKugel=1,
scaleTorus=1,
rand,
name,
help
){
    
    
    Halb()scale([1,1,scaleTorus])Torus(dia=dia,d=rand?rand:dia/2-loch/2,name=name);
    Halb(1)scale([1,1,scaleKugel])Kugelmantel(d=dia,rand=rand?rand:dia/2-loch/2);
    
    HelpTxt("Tugel",[
    "dia",dia,
    "loch",loch,
    "scaleKugel",scaleKugel,
    "scaleTorus",scaleTorus,
    "rand",rand,
    "name",name,],help);
}


/// Vorterantrotor creates a rotor for the Vorterant pump
//Polar(6,10*tan(60),mitte=true,rotE=t0,rot=-t0,dr=-360)Vorterantrotor(caps=1,rund=+1);


module Vorterantrotor(h=40,twist=360,scale=1,zahn=0,rU=10,achsloch=4,ripple=0,caps=2,caps2=0,capdia=6.5,capdia2=0,screw=1.40,screw2=0,screwrot=60,rund=0.5,name,help)
{
 $fn=0;
 capdia2=capdia2?capdia2:capdia;
 caps2=caps2?caps2:caps;
 rU=rU-rund;//*sqrt(3)/1.5;
 r=rU/(sqrt(3)/3);  
s= h/(rU*PI*2*(twist/360));
    rI=r-rU;
 InfoTxt("Vorterantrotor",["Umkreis ∅",2*rU,"Teilradius",r,"Innen∅",rI*2,"Steigung",str(s*100,"%")," Winkel",str(atan(s),"°")],name);  
  HelpTxt("Vorterantrotor",["h","40,twist=360,scale=1,zahn=0,rU=10,achsloch=4,ripple=0,caps=2,caps2=0,capdia=6.5,capdia2=0,screw=1.40,screw2=0,screwrot=60"],help);
  
 if(zahn)
 {
     Col(3)T(z=h+2*caps)stirnrad(modul=1.5, zahnzahl=zahn, hoehe=1.5, bohrung=achsloch, eingriffswinkel = 20, schraegungswinkel = 0);
 }
 difference()
 {   
        T(z=caps)union()
        {
           if (caps){T(z=h)rotate(-twist) hull()//Endcap oben
            { 
                linear_extrude(.001)offset(rund)intersection_for (i=[0,120,240])
                {
                  rotate(i)T(rU)  circle(r=r);

                }
                T(z=caps2){
                    if(!screw2)cylinder(0.001,d=capdia2);
                    if(screw2)rotate(screwrot)linear_extrude(.001)offset(rund)intersection_for (i=[0,120,240])
                {
                  rotate(i)T(rU*screw2)  circle(r=r);

                }}
            }
                      T(z=0) hull()//Endcap unten
            { 
               T(z=-0.01)linear_extrude(.001)offset(rund)intersection_for (i=[0,120,240])
                {
                  rotate(i)T(rU)  circle(r=r);

                }
                T(z=-caps){
                    if(!screw)cylinder(0.01,d=capdia);
                    if(screw)rotate(screwrot)linear_extrude(.001)offset(rund)intersection_for (i=[0,120,240])
                {
                  rotate(i)T(rU*screw)  circle(r=r);

                }}
            } 
         }
            
            
         linear_extrude(h,twist=twist,scale=scale,convexity=5)//Läufer
                offset(rund)intersection_for (i=[0,120,240])
                {
                  rotate(i)T(rU)  circle(r=r);

                }
            
        }
     if(ripple)cylinder(200,d=6,center=true);//center
     if(ripple) Linear(e=50,s=73,x=0,z=1)Torus(+2,2.8,fn2=6,fn=50);//center ripple
     cylinder(200,d=achsloch,center=true);//center   
       
    }
    
    
} 

/** \name Gardena
\page Products
Gardena() creates a Gardena hose coupling
\param l base height
\param r base hole radius
\param ir top hole
\param or base outside radius
\center -1,0,1
\param help help
*/

//Cut(z=-10)Gardena(l=+5);

module Gardena(l=+10,r=8.5,ir=4.5,or=15,center=0,help)
{
r=min(r,9);
or=max(r +2,or);
 HelpTxt("Gardena",["l",l,"r",r,"ir",ir,"or",or,"center",center],help);
 $info=0;
 Tz(center==0||center==true?0:center==1?l:center==-1?-25:0){
    if(l)T(z=1)Kehle(rad=1,dia=19.8,fn2=24);
    rotate_extrude(convexity=5)
    Rund(.5,fn=24)
    {
        
        //T(8-1.5,23.5)circle(r=1.5);//16 mm rund ende
        T(ir,22.5)Quad(8-ir,2.5,r=[1,2,0,0],center=false,fn=24);//Top
        difference()//Dichtungsnut
        {
        T(ir,15)square([8-ir,7.5]);
        //T(8.0,20.5)circle(d=3.2);  //Dichtnut
        T(8.0,20.5)rotate(90)Quad(3.2,4.5,help=0,grad=101,grad2=79,r=1.40,fn=24);   
        }
        
        difference()//Kehle
        {
            T(ir)square([9.9-ir,15]);
            
            //%T(5)square([4.9,15]);
            T(17.5,11.50)circle(r=10,$fn=72);
            polygon([[+0,0],[+0,30],[r,0]]);
            
        }
        
        T(6.20,15.0)Halb(2D=true,x=1)rotate(45/2)circle(2.5,$fn=8);//Fase Dichtung
        
       //T(5,15)square([8.5-5,1]);//17mmDichtrand
        
        
        T(r,l?-.5:0)square([15-r,l?1.5:1]);//30mmRand
        difference(){
          T(r)square([9.9-r,5]);//20mmRand
          if(r<ir)T(y=5)mirror([0,1])Kegel(d1=ir*2);
        }
        if(l>0)polygon([
        [r,0],[or,0],[or,-l+tan(60)*2],[or-2,-l],
        [r+1,-l],[r,-l+1]
        ]);
    }
  }
}



module Achshalter
(
laenge=30,
achse=+5,
schraube=3,
mutter=5.5,
schraubenabstand=15,
hoehe=8,
fn=fn,
help
){
HelpTxt("Achshalter",["laenge",laenge,"achse",achse,"schraube",schraube,"mutter",mutter,"schraubenabstand",schraubenabstand,"hoehe",hoehe,"fn",fn],help);
difference()
{
    union()
    {
        minkowski()
        {
        T(-8+laenge/2-achse/2)cube([laenge+16+achse-schraube,achse+0,hoehe-1],center=true);
            cylinder(1,d=schraube,$fn=fn,center=true);
        }
        cylinder(hoehe,d=achse+10,$fn=fn,center=true);
    }
    T(0)cube([15+achse+schraubenabstand,2,hoehe+1],center=true);//Schlitz
    cylinder(50,d=achse,center=true,$fn=fn);//Motorachse
    R(90)T(z=-10)Twins(20,l=schraubenabstand+achse,d=schraube+2*spiel,center=1);//Schraubenlöcher
    T(-(schraubenabstand+achse)/2,-achse/2)Linear(s=schraubenabstand+achse)R(90)cylinder(5,d=Umkreis(6,mutter+spiel*2),$fn=6);
    //Inkreis(d=mutter+spiel*2);} depreciated
}
}


module Imprint(txt1=1,radius=20,abstand=7,rotz=-2,h=l(2),rotx=0,roty=0,stauchx=0,stauchy=0,txt0=" ",txt2=" ",size=5,font="Bahnschrift:style=bold",name)
{
    str1=str(txt0,txt1,txt2);
    InfoTxt("Imprint",["string",str1],name);
difference(){
    if($children)children();
    for (i=[0:1:len(str1)-1])
    {
       // if(name)echo(str1[i]);
        rotate([0,0,i*abstand])
        translate([0,-radius,0])
        rotate([rotx,roty,rotz])
        linear_extrude(h*2,center=true,convexity=10){
          rotate([stauchx,stauchy,0])
            translate([+0,-0.2])
            mirror([0,1,0])
            text(str1[i],size=size,$fn=45,halign="center",valign="baseline",font=font);
        }
    }
}
}

/// ¼" Hex Shank
// cylinder(20,d=Umkreis(6,inch(0.25)),$fn=6);
// Bitaufnahme(star=2);


module Bitaufnahme(l=10,star=2,help)
{
//¼" Hex Shank = umkreis 7.33235 / inkreis 6.35
 if(star){
    LinEx(l+1,h2=[.5,1],scaleCenter=0.97,scale=1.1,scale2=star>1?0.55:0.45){
        if(star==true||star==1)Rund(1,fn=36)Polar(2)circle(4.6,$fn=3);
        if(star>1)WStern(6,r=3.63,fn=6*10,help=0,r2=3.1);
        }
    if(star>1)T(z=l){
     Tz(-0.30)scale([1,1,0.60]) sphere(d=5.8,$fn=36);
     *linear_extrude(1.00,scale=0.56,convexity=5)scale(.95)WStern(6,r=3.5,fn=6*10,help=0,r2=3.1);
        }
   else T(z=l){
     Tz(-0.29)scale([1,1,0.6]) sphere(d=5.3,$fn=36);
    *linear_extrude(0.80,scale=0.56,convexity=5)scale(.95)Rund(1,fn=36)Polar(2)circle(4.6,$fn=3);
        
        
    }
 }
 /* old
 %T(6)union(){
    linear_extrude(l,scale=.95,convexity=5){
        if(star==true||star==1)Rund(1,fn=36)Polar(2)circle(4.6,$fn=3);
        if(star>1)WStern(6,r=3.5,fn=6*10,help=0,r2=3.1);
        }
    if(star>1)T(z=l){
     Tz(-0.30)scale([1,1,0.60]) sphere(d=5.8,$fn=36);
     linear_extrude(1.00,scale=0.56,convexity=5)scale(.95)WStern(6,r=3.5,fn=6*10,help=0,r2=3.1);
        }
   else T(z=l){
     Tz(-0.29)scale([1,1,0.6]) sphere(d=5.3,$fn=36);
    linear_extrude(0.80,scale=0.56,convexity=5)scale(.95)Rund(1,fn=36)Polar(2)circle(4.6,$fn=3);
        
        
    }
 } 
 */
 
 if(!star){hull()
        {
            cylinder(l,d1=Umkreis(6,6.3),d2=Umkreis(6,6.1),$fn=6);
            T(z=l)R(0)sphere(d=Umkreis(6,5.5),$fn=36);
        }
        
       T(z=-.01)color("red")Kegel(d1=Umkreis(6,6.5),d2=Umkreis(6,6.1),v=+43.31,fn=6,name=0); 
    }
    
  HelpTxt("Bitaufnahme",["l",l,"star",star],help);  
}


/// Luer connector
//Luer(male=false);

module Luer(male=true,lock=true,slip=true,rand=n(2),help,name)
{
    HelpTxt("Luer",["male",male,"lock",lock,"slip",slip,"rand",rand,"name",name],help);
    
    /* show=41; 6% nach DIN
     R(180)T(z=-73.5)color("red")cylinder(100,d1=0,d2=6.0,$fn=fn); //Eichzylinder 6%
     T(z=+1.0)color("green")cylinder(5.8,d1=4.35,d2=4.0,$fn=fn); //referenz gemessen
    // */
    
    d=4.5;
    
    v=33+1/3;
    
    if (male)
    {
        if(slip)
        {
            translate([0,0,lock?0:-1])difference()
            {
                Kegel(d1=lock?d:d +0.06,d2=4,v=v,name=0);
                translate([0,0,-0.01])Kegel(d1=-rand*2+(lock?d:d +0.06),d2=0,v=v,name=0);
                echo(str("»»»  »»» Luer uses Kegel(d1=",d,",d2=4,v=",v,");"));
            }
            intersection()
            {
                Ring(1,0.75,5.7,name=0);
                Kegel(d2=4,d1=6.0);
            }
        }
        
        
        if (lock)
        {

         intersection(){
            Gewinde(tz=-1.75,dn=8,kern=6.75,innen=true,breite=0.5,winkel=75,g=2,p=5.5,wand=0.75,h=10,new=true,center=+0,cyl=1,name=0,fn=60); 
            cylinder(6,d=20);
         }  
            difference()
            {
                Ring(0.5,2.5,9.5,name=0);
                translate([0,0,-0.15]) Kegel(d2=4,d1=6.0,name=0);
            }
        }
    }
    
    if (!lock&&!slip)color("magenta")cylinder(10,d=10.5,$fn=fn);
    
    if (!male)
    {
      
        //T(z=0)rotate(360/5.5*0.5)
        difference(){
          union(){
               if(lock)Halb()Gewinde(dn=7.8,p=5.5,g=2,winkel=75,kern=6,grad=200,start=fn/6,name=0,new=true,center=1,tz=+0);// 
               if(slip) cylinder(10,d=6);
          }
          translate([0,0,-0.01])Kegel(d1=d,d2=2.0,v=v,name=0);
            //mirror([0,0,1])cylinder(5,d=12);
        
        }
        
    }
InfoTxt("Luer",male?["h",v*(d-4)/2]:["h",10,"d",6],name);
}



module Knochen(l=+15,d=3,d2=5,b=0,fn=fn,help)

{
  HelpTxt("Knochen",["l",l,"d",d,"d2",d2,"b",b,"fn",fn],help);
    f=50/fn*0.3;
    function mf(x)=d+pow(1.5,x);
    for(i=[-l:f:+5])
    {
        hull()
        {
        R(i*b)T(z=i)scale([d2/mf(i),1,1])R(i*b)cylinder(.01,d=mf(i),$fn=fn);
        R((i+f)*b)T(z=i+f)scale([d2/mf(i+f),1,1])R((i+f)*b)cylinder(.01,d=mf(i+f),$fn=fn);
        }
    }

}

/// dual glied

module DGlied(sym,l=12,l1,l2,la=+0.0,d=3,h=5,spiel=0.4,spielZ=nozzle/2,rand=.6,freiwinkel=20,fn=36,help){
if (sym) DGlied1(l=l,l1=l1,l2=l2,la=la,spiel=spiel,d=d,h=h,rand=rand,spielZ=spielZ,freiwinkel=freiwinkel,fn=fn);
else DGlied0(l=l,l1=l1,l2=l2,la=la,spiel=spiel,d=d,h=h,rand=rand,spielZ=spielZ,freiwinkel=freiwinkel,fn=fn);

HelpTxt("DGlied",["sym",sym,"l",l,"l1",l1,"l2",l2,"spiel",spiel,"spielZ",spielZ,"la",la,"fn",fn,"d",d,"h",h,"rand",rand,"freiwinkel",freiwinkel],help);
}

module DGlied0(l=12,l1,l2,la=+0.0,d=3,h=5,spiel=0.4,spielZ=nozzle/2,rand=.6,freiwinkel=20,fn=36)
{
l1=is_undef(l1)?is_list(l)?l[0]:l:l1;
l2=is_undef(l2)?is_list(l)?l[1]:l:l2;
    Glied(l1,la=la,spiel=spiel,spielZ=spielZ,d=d,h=h,rand=rand,freiwinkel=freiwinkel,fn=fn);
    rotate(180)Glied(l2,la=la,spiel=spiel,spielZ=spielZ,d=d,h=h,rand=rand,freiwinkel=freiwinkel,fn=fn);
}

module DGlied1(l=12,l1,l2,la=0,d=3,h=5,spiel=0.4,spielZ=nozzle/2,rand=.6,freiwinkel=20,fn=fn)
{
l1=is_undef(l1)?is_list(l)?l[0]:l:l1;
l2=is_undef(l2)?is_list(l)?l[1]:l:l2;
    mirror([+0,1,0])T(0,-l1)Glied(l1,la=la,spiel=spiel,spielZ=spielZ,d=d,h=h,rand=rand,freiwinkel=freiwinkel,fn=fn);
    T(0,-l2)Glied(l2,la=la,d=d,h=h,spiel=spiel,spielZ=spielZ,rand=rand,freiwinkel=freiwinkel,fn=fn);
}

/// symetric Glied  male or female
// SGlied(sym=+0);


module SGlied(sym=0,l=12,la=-.5,d=3,h=5,spiel=0.4,spielZ=nozzle/2,rand=.6,freiwinkel=30,help,messpunkt=messpunkt,fn=36){

  T(0,l/2){
  Halb(sym,y=1)T(0,-l/2)Glied(l,la=la,spiel=spiel,d=d,h=h,rand=rand,fn=fn,freiwinkel=sym?freiwinkel:90,messpunkt=false);
  Halb(!sym,y=1)rotate(180)T(0,-l/2)Glied(l,la=la,spiel=spiel,d=d,h=h,rand=rand,fn=fn,messpunkt=false,freiwinkel=sym?freiwinkel:90);
  }
  HelpTxt("SGlied",["sym",sym,"l",l,"spiel",spiel,"spielZ",spielZ,"la",la,"fn",fn,"d",d,"h",h,"rand",rand,"freiwinkel",freiwinkel],help);

  if (messpunkt)
  {
      %color (sym?"red":"blue")translate([0,l,0.1])R(z=180/12)cylinder(5, d1=1,d2=1,$fn=12,center=true);//messachse1
      %color(sym?"red":"blue")cylinder(5, d1=1,d2=1,$fn=12,center=true);//messachse2
  }
}
/*
Schnitt(0,center=true,z=3){
Glied(l=31,d=3,la=-1,spielZ=0);
rotate(30+180)T(0,-31)Glied(l=31,d=3,la=-1,spielZ=0);
}
// */

/// joint



module Glied(l=12,spiel=0.4,spielZ=nozzle/2,la=-0.5,d=3,h=5,rand=.6,freiwinkel=30,fn=36,name=0,help,messpunkt=messpunkt)

{
  freiwinkel= is_num(freiwinkel)?[freiwinkel,freiwinkel]:freiwinkel;
    hFreiraum=h/2 + spielZ;
    hSteg=h/2 - spielZ;
    sphereR=.8;
    hErr=sphereR-cos(90/ceil(fn/2))*sphereR+.0001; // sphere fn error minkowski
    
    $info=false;
    $helpM=false;
    
    HelpTxt("Glied",[
        "l",l,
    "spiel",spiel,
    "spielZ",spielZ,
    "la",la,
    "fn",fn,
    "d",d,
    "h",h,
    "rand",rand,
    "freiwinkel",freiwinkel,
    "name",name,"messpunkt",messpunkt],help);
    
    T(y=l,z=h/2)Pille(l=hSteg,d=d+1,rad=min(hSteg/2,.8),fn=fn);//Torus(1.2,1.7,fn=fn,n=name);
        if (messpunkt)
        {
            %color ("blue")translate([0,l,0.1])R(z=180/12)cylinder(5, d1=1,d2=1,$fn=12,center=true);//messachse1
            %color("red")cylinder(5, d1=1,d2=1,$fn=12,center=true);//messachse2
        }
        
        
        T(0,l)//kopfstück
        {
            lkopf=l-(d-.5)/tan(min(freiwinkel[0],freiwinkel[1]))+la -1;
            
            T(0,-lkopf/2,h/2) minkowski()
            {
                cube([d-2*sphereR +0.25,lkopf-2*0.8,max(minVal,hSteg-2*.8)],true);
                sphere(sphereR,$fn=fn);
            } 
            cylinder(h,d=d,$fs=0.2,$fa=5,$fn=0);//Achse!
        }
   T(0,0,h/2)difference()
   {
     hull(){//Ringanker
       T(0,l/2+la/2-d/2) minkowski()
        {
          cube([max(d-2*sphereR-.5,.1),l+la-2*.8-d,max(minVal,h-sphereR*2 + hErr*2)],true);
          sphere(sphereR,$fn=fn);
        } 
       T(0,l -d/2 -rand-spiel+la) minkowski()// spitze
        {
          cube([max(d-2*sphereR-.5,.1),0.1,+0.01],true);
          sphere(sphereR,$fn=fn);
        } 

      } 
       
        
        
        translate([0,l])cylinder(h*2,d=d+rand*2+spiel*4,$fn=0,$fs=0.5,center=true);// space for ring of other
        cylinder(h*2,d=d+2*spiel,$fn=fn,center=true);
        Freiwinkel();
        Pille(l=hFreiraum,d=d+1+2*spiel,rad=min(hFreiraum/2,1),fn=fn); 
    }
    
    T(0,0,h/2)union()//B ring
    {
        difference()
        { 
            union()
            {
              linear_extrude(h,center=true,convexity=5)Rund(0,d/2+spiel -.1)
              {
                Ring(h=0,rand,d+2*spiel,cd=-1,name=name,center=true);
                T(0,d/2+spiel)Quad([max(d -0.5,sphereR*2+.1),sphereR*2],r=sphereR*[1,1,0,0],centerX=true);
              }
                //T(0,3.2)R(z=33)cylinder(5,d=3,$fn=3);
            }
            cylinder(hFreiraum,d=d+rand*2+2*spiel,center=true);//Pille(l=hSteg+n(1),d=d+rand*2+2*spiel +1,rad=1,fn=fn); 
            color("red")Freiwinkel(); 
                         /*     * T(+2.9,-1.40,2.5)R(z=46)minkowski()
                            {
                                cube([5,+5,1.0],true);
                                sphere(1.0,$fn=fn);
                            }
                                
                            *mirror([1,0,0])  T(+2.9,-1.40,2.5)R(z=46)minkowski()
                            {
                                cube([5,+5,1.0],true);
                                sphere(1.0,$fn=fn);
                            }
           */
            
        }
        
        /*T(0,+5.2,2.50)minkowski()
        {
            cube([0.6,+6.0,4],true);
            sphere(.5,$fn=fn);
        }  */
        
    }



 module Freiwinkel(w=freiwinkel+[90,90])//Glied only
 T(0,+0.5){
  R(z=+w[0]) T(+0,+25-d/2)minkowski()
            {
                cube([200,+50-.8*2,max(minVal,hFreiraum-2*0.8)],true);
                sphere(0.8,$fn=fn);
            }    
  R(z=-w[1]) T(+0,+25-d/2)minkowski()
            {
                cube([200,+50-.8*2,max(minVal,hFreiraum-2*0.8)],true);
                sphere(0.8,$fn=fn);
            }      

 }   
    
    
}



module Stabhalter (l=10,d=3.5)// Replaced with Ring(cd=-1,rand(n(1.5)),durchmesser=In6eck(3.1),fn=6)
{
    
    
    
    translate([+0.0,0,2.165])difference()
    {
        rotate ([0,90,0])rotate ([0,0,30]) cylinder(l,d=d+n(3),$fn=6);
        translate([+0.5,0,0])rotate ([0,90,0])rotate ([0,0,30]) cylinder(l+5,d=d,$fn=6);
    }
    
    echo("Removed!  Verschoben wegen nozzle∅! Use T(z=3.1/2)R(0,90)Inkreis(d=3.1) or Ring(cd=-1,rand(n(1.5)),durchmesser=In6eck(3.1),fn=6)");
}


/** \name Halbrund \page Products
Halbrund() removes a flat circle from a children
\param h height (h=0 ↦ 2D polygon)
\param d diameter
\param d2 flat diameter (x can be used instead)
\param x the flat reduction optional to calc ↦ d2
\param doppel makes it doubble side flat
*/

//Halbrund(help=1);

module Halbrund(h=10,d=3+2*spiel,d2,x=1.0-spiel,doppel=false,name,help)
{
h=is_parent(needs2D)?0:h;
   d2=is_undef(d2)?doppel?d-x*2:d-x:d2;
   x=is_undef(d2)?x:doppel?(d-d2)/2:d-d2;    
if(h){difference()
{
  if($children)children();   
  if(!doppel)difference()
    {
        cylinder(d=d,h=h*2,center=true,$fn=36);
        translate([d/2-x, -d, -h*2])cube([d*2,d*2,h*4],center=false);
    }
  else intersection()
    {
        cylinder(d=d,h=h*2,center=true,$fn=36);
        cube([d2,d+1,h*3],center=true);
        //translate([-d/2+x-50, -25, -50])cube([50,50,100],center=false);
    } 
    
}
}
else difference(){
 if($children)children(); 
 if(!doppel) difference()
    {
        circle(d=d,$fn=36);
        translate([d/2-x, -25])square([50,50],center=false);
    }
    else intersection(){
        circle(d=d,$fn=36);
        square([d2,d+1],center=true);
    }
}
  if (name)echo(str(is_string(name)?"<H3>":"",name," Halbrund",h?str(" l= ",h): " h=0↦2D"," ∅= ",(d)," Abgeflacht um= ",x," ↦",d2));  
     
 HelpTxt("Halbrund",[
 "h",h,
"d",d,
"d2",d2,
"x",x,
"doppel",doppel,
"name",name],
help); 
    
}




module Riemenscheibe(e=40,radius=25,nockendurchmesser1=2,nockendurchmesser2=2,hoehe=8,name)

{
   if(name)echo(str("Riemenscheibe ",name," Nockenabstand= ",2*PI*radius/e," Nockespitzen= ",(2*PI*(nockendurchmesser1/2+radius))/e));
     
   difference()
   {
        children();
    
      Polar(x=radius,e=e,name=0)translate([00,0,-.005])cylinder(.01+hoehe,d=nockendurchmesser2,center=false,$fn=36);
   }  
    
   Polar(x=radius,e=e,r=180/e,name=0)cylinder(hoehe,d=nockendurchmesser1,center=false,$fn=36);   
     
}



//Schnitt()Servokopf(schraube=1)Pille(5,d=8,center=false,rad=.5);


module Servokopf(rot,spiel=0.1,schraube=true,T=21,d=4.9,h=3.25,name,help)
{
    // 21 Zacken!

    tdepth=.25;
    r1=d/2+spiel;
    r2=d/2-tdepth+spiel;
    
    preset=[
    ["name","T","d"],
    ["A15T",15,3.9],// A1
    ["B25T",25,4.9],// B1
    ["C24T",24,5.6],// C1
    ["H25T",25,5.9],// 3F
    ["D15T",15,7.6],// D1
    [" 21T",21,4.9] // this
    ];
    
    if(help)for(i=[0:len(preset)-1])echo(preset[i]);
    %if(is_num(rot))Tz(+0){//direction
      Col(5,0.5) rotate(rot+90)   scale([1,0.5])circle(3.5,$fn=3); 
      Col(6,0.7) rotate(90) scale([1,0.5])circle(4,$fn=3);
    }
    
    difference(){
    
      if($children)children();
      translate([0,0,-0.01])union(){
        linear_extrude(h,convexity=5,scale=scaleGrad(grad=88,h=h,r=r1))Rund(+0,0.1,fn=12)Star(T,r1,r2,grad=3,grad2=gradS(wall(0.199,.8,even=0),r2),fn=0);
        Kegel(d1=d+spiel*2+.2,h=.5,name=false);
      }

      if(schraube&&$children){
         cylinder(h+10,d=2,$fn=36); //SchraubenlochNarbe 
         translate([0,0,h-.011])cylinder(.2,d1=r2*2,d2=2,$fn=36); //Decke 
         translate([0,0,h])Polar(teiler(T,5),rot=-90,name=false)R(0,-90)cylinder(d/2-tdepth*.8,d=.5,$fn=3); //Decke Support Struktur 
         
         translate([0,0,h + 1.15])cylinder(100,d=4.5,$fn=36); //SchraubenKopflochNarbe 
      }
      translate([0,0,-30.01])cylinder(30,d=50,$fn=36); //Servo
    }

 InfoTxt("Servokopf",["T",T,"d",d+spiel*2,"dTop",(d+spiel*2)*scaleGrad(grad=88,h=h,r=d/2+spiel)],name);
 HelpTxt("Servokopf",[
    "rot",rot, 
    "spiel",spiel,
    "schraube",schraube,
    "T",T,
    "d",d,
    "h",h,
    "name",name
    ],help);

}

module ServokopfT15(rot=0,spiel=0,schraube=true,help) // .6 nozzle
{
    // 15 Zacken!
    d2=6+spiel;
    d1=6.1+spiel;
    fn=3;
    
    %Tz(+0){//direction
      Col(5,0.5) rotate(rot)   scale([1,0.5])circle(3.5,$fn=3); 
      Col(6,0.7)  scale([1,0.5])circle(4,$fn=3);
    
    }
    
    difference()
    {
        if($children)union()
        {
            children();
            
        }
       rotate(rot) for (i=[0:360/5:359])
        {
         rotate([0,0,i]) translate([0,0,-.1])cylinder(3.25,d1=d1,d2=d2,$fn=fn,center=false);   
            
        }
        
        
    if($children)  translate([0,0,-0.01])cylinder(.5,d1=d1-0.1,d2=d1-2,$fn=36,center=false);//basekone
       // *cylinder(6,d1=d1,d2=d2,$fn=fn,center=true);
      //  *rotate([0,0,360/2*fn])cylinder(6,d1=d1,d2=d2,$fn=fn,center=true);
     if(schraube){
         cylinder(10,d=2,$fn=36); //SchraubenlochNarbe 
         translate([0,0,3.4+1])cylinder(100,d=4.5,$fn=36); //SchraubenKopflochNarbe 
     }
          translate([0,0,-30.01])cylinder(30,d=50,$fn=36); //Servo
      
    }
    
    if(!$children)     translate([0,0,-0.01])cylinder(.5,d1=d1-0.1,d2=d1-2,$fn=36,center=false);//basekone
    
    
 HelpTxt("ServokopfT15",[
    "rot",rot, 
    "spiel",spiel,
    "schraube",schraube],
    help);
    
    
}

    
module Servo(r=0,narbe=1,help)
 {

     cube([12.5,22.5+1.5,23],true);
     translate([+0,0,(-23/2+2.5/2)+16])cube([12.5,32.5,2.5],true);
     color([.8,0.4,.6,1])translate([+0,-5,2.8])cylinder(26.0,d1=12,d2=12,$fn=36,center=true);
       color([.8,0.3,.6,1])translate([+0,+0.7,2.7])cylinder(26.0,d=5.5,$fn=36,center=true);  
     color([.8,0.3,.6,1])translate([+0,+1.4,2.7])cylinder(26.0,d=5.5,$fn=36,center=true);
     color([.8,.8,.6,1])translate([+0,-5,3.5])cylinder(30.0,d=5,$fn=12,center=true);
     if (narbe==1)
         { translate([+0,-5,17.3])rotate([+0,0,r])scale([0.2,1.0,1])cylinder(3,d=35,center=true); // servoarm Oval
             translate([+0,-5,17.3])rotate([+0,0,r])cube([18,4.1,3.0],true);//servoarm
         }
        if (narbe==2)
         { translate([+0,-5,18.2])rotate([+0,0,r])scale([1,1,1])color([.8,.8,.8,0.5])cylinder(6,d=35,center=true); // servoarm Rund        
     
         }
     if (narbe==3)
         {
             color([.8,.8,.8,1])translate([+0,-5,49])cylinder(70,d1=4,d2=4,$fn=36,center=true);//Mitte Drehachse 
         }
     color([.8,0.5,.2,1])translate([+0,-11.8,-3.4])scale([1,0.15,1])cylinder(16,d=12.5,$fn=36,center=true);//cut für kabel
        translate([+0,14,6]) cylinder(10.0,d=1.8,$fn=6,center=true);    //Schraubenlöcher 
         translate([+0,-14,6]) cylinder(10.0,d=1.8,$fn=6,center=true);    //Schraubenlöcher     
         
  HelpTxt("Servo",["r",r,"narbe",narbe],help);
 } 


module Glied3(x=15,layer=.15,help)

{
  HelpTxt("Glied3",["x",x,"layer",layer],help);
   function l(x)=layer*x; 
   echo(Glied3_uses_layer=l(1)); 
    difference()
    {
        union()
        {
        
            color("blue")translate([x,0,l(1)]) cylinder(l(13),d1=1.9,d2=1.9,$fn=69,center=false);//Achse
            translate([x,0,l(1)])cylinder(l(5), d1=3.5,d2=2.0,$fn=69,center=false);//unten Sockel
            translate([x,0,l(11)])cylinder(l(3), d1=2,d2=3.5,$fn=69,center=false);//oben Sockel 
        }
         translate([x,+0,0])rotate([0,0,0])cylinder(l(40),d=+0.75,$fn=96,center=true);//achslochloch
    }
    if (messpunkt)
        {
            %color ("blue")translate([x,0,0.1])cylinder(l(40), d1=1,d2=1,$fn=12,center=true);//messachse1
            %color("red")cylinder(l(40), d1=1,d2=1,$fn=12,center=true);//messachse2
        }
   difference()
    {
           hull()
           {
            translate([0,0,0.0])cylinder(l(14),d=4.5,$fn=69,center=false); 
            translate([x,0,0])cylinder(l(+18), d1=+3.5,d2=+3.5,$fn=69,center=false);   
           }

       translate([+0.0,0,l(+1)])rotate([0,6,0])cylinder(l(9),d1=6.1,d2=2.2,$fn=69,center=false);//Kegel ausschnitt unten
       translate([0,0,l(+0)-0.05])rotate([0,0,0])scale([1,1,0.47])sphere(d=5.9,$fn=69);//Kegel ausschnitt untendrunter grade
       color("red")translate([0,0,-0.01])cylinder(5,d=3.00,$fn=69,center=false);//achsloch
      * color("green")translate([0,0,l(11)+.01])cylinder(l(7),d1=+2.0,d2=8.0,$fn=69,center=false);//lagerfläche oben
        translate([0,0,l(+19)-0.05])rotate([0,0,0])scale([1,1,0.47])sphere(d=5.9,$fn=69);//oben Frei
       mirror([0,0,0])translate([x,+0,l(3)])rotate([0,0,0])cylinder(l(5),d1=+6.0,d2=7.0,$fn=96,center=false);//lagerfläche innen unten
       translate([x,+0,l(+8)-0.01])rotate([0,0,0])cylinder(l(6),d1=+7.0,d2=6.0,$fn=96,center=false);//lagerfläche innnen oben
           
       translate([x,+0,0])rotate([0,0,0])cylinder(l(45),d=+0.60,$fn=96,center=true);//achslochloch
   }
   
} 

module Gelenk(l=20,w=0,help)//ausschnittlänge, winkel
{
  HelpTxt("Gelenk",["l",l,"w",w],help);
    
    scale([1.2,1.2,1.3])rotate([0,0,180])intersection()
    {
        union()
        {
            translate([-l,0,0])Glied3(l);
            translate([ 0,0,0])rotate([0,0,w])Glied3(l+10);
        }
        union()
        {
        translate([0,0,0])rotate([0,0,w])translate([l/2,0,0])resize([l,6,10])cylinder(10,d=5,$fn=3,center=true);
         translate([+0,0,0])cube ([14,11,30],center=true);
        }
       
    }    
}



module Servotraeger(SON=1,top=0,help)
 {
   HelpTxt("Servotraeger",["SON",SON,"top",top],help);
    if(!top)translate([0,+0,+35.4]) difference()
     {
         minkowski()
         {
             translate([-11,+0,-33.9]) cube([29,20,3],center=true);
             cylinder(1,d=5,$fn=36);
         }
        if(SON) #translate([-11,0,-40]) rotate([0,0,-90])Servo(0);
            else translate([-11,0,-40]) rotate([0,0,-90])Servo(0);
          * mirror([0,1,0])translate([-11,-30,-40]) rotate([0,0,-90])Servo();
     }
                              
                *minkowski()//Sockel
                 {
                     translate([+2,+0,-27.4]) cube([15,9,16],center=true);
                     cylinder(1,d=5,$fn=36);
                 }

if (top) difference(){
    if($children)children();
        else cylinder(4,d=20);
    linear_extrude(9,center=true,convexity=5)Rund(1){
        circle(d=11.5+spiel);
        T(6)circle(d=5.5+spiel);
        }
    T(23/2-(11.5+spiel)/2){
        R(180)Prisma(23,11.5+spiel,5,c1=1,s=.5);  //Servo
        R(180)Tz(4.0)Prisma(33,11.5+spiel,100,c1=1,s=.5);  //Servobody unten
     R(180)  Mklon(tx=28/2,mz=0)linear_extrude(5,center=false,convexity=5)Rund(.35)Stern(5,5.9,0.5);//Schraubenlöcher
        
        }
        cylinder(8,d=9);//Servoachse
    }   
        
   }
   
}//fold  // Products ΔΔ
{ // OLD and Replaced modules


   
   module ZylinderOLD(h=10,r=10,fn=150,fnh=150,grad=360,grad2=84,f=10,f2=10,f3=0,a=.5,a3=0,fz=0,az=0,deltaFz=0,deltaF=90,deltaF2=0,deltaF3=0,twist=0,scale=+1,sphere=0,lz,help){
    stepRot=grad/fn;
    stepH=h/fnh;
points=[for(z=[0:fnh],rot=[0:fn])RotLang(
    rot=rot*stepRot+twist*z/fnh,
    l=(1+(scale-1)*z/fnh)*(r+a3*sin(rot*stepRot*f3+deltaF3)+a*sin(rot*stepRot*f+deltaF)*cos(z*f2*360/fnh+deltaF2)+az*sin(z*fz*360/fnh+deltaFz)),
    lz=lz,
    z=sphere?undef:z*stepH,
    e=z*grad2/fnh
    )];


faces=[for(i=[0:len(points)-fn-2])[i,i+1,i+2+fn,i+fn+1]];
    faces2=[[for(i=[fn-1:-1:+0])i],[for(i=[len(points)-fn:len(points)-1])i]];
  
//faces=[for(i=[0:len(points)-fn-2])each[[i,i+1,i+fn],[i+1,i+1+fn,i+fn]]];    
polyhedron(points,concat(faces2,faces),convexity=15);
HelpTxt("Zylinder",["h=",h,",r=",r,",fn=",fn,",fnh=",fnh,", grad=",grad,",grad2=",grad2,",f=",f,",f2=",f2,", f3=",f3, ",a=",a," a3=",a3," ,fz=",fz,",az=",az,",deltaFz=",deltaFz," ,deltaF=",deltaF," ,deltaF2=",deltaF2," ,deltaF3=",deltaF3,", twist=",twist,",scale=",scale,",sphere=",sphere,",lz=",lz],help); 
}

module FlowerOLD(e=8,n=15,r=10,r2=5,fn=720,name,help){
points=[for(f=[+0:fn])let(i=f*360/fn)RotLang(i,max(r2,r*pow(abs(sin(e*.5*i)),2/n)))];

polygon(points,convexity=5);

if(help)echo(str("<H3><font color=",helpMColor,">Help Flower(e=",e,",n=",n,",r=",r,",r2=",r2,", fn=",fn,",name=",name,",help);"));
}



module PilleOLD(l=10,d=5,fn=fn,fn2=36,center=true,name,s=0,rad,rad2,loch=false,help)
{
 //rotate_extrude()Halb(2D=true)Strebe(h=10,rad=+2,d=-4,2D=true);
    
   // if(rad>d/2-.001||rad2>d/2-.001)echo("<font color=red> Radius limited to d/2");
 rad=is_undef(rad)?d/2:d>0?min(rad,d/2):max(rad,d/2); 
 rad2=is_undef(rad2)?rad:min(rad2,d/2);    
  d=s?s:d>0?max(d,rad*2):min(rad*2,d); //abwärts compabilät
    
 if(!loch)Tz(center?-l/2:0)rotate_extrude(convexity=5,$fn=fn)polygon(concat(
     
    kreis(rand=0,grad=90,r=rad2,center=false,rot=0,t=[d/2-rad2,l-rad2],fn=fn2/4),
    kreis(rand=0,grad=90,r=rad,rot=+90,center=false,t=[d/2-rad,rad],fn=fn2/4),     
    [[0,0]],
    [[0,l]]
    
    ),
    //paths=[[for(i=[0:floor(fn/4)])i,for(i=[floor(fn/2)+1:-1:floor(fn/4)+1])i,floor(fn/2)+2,floor(fn/2)+3]],
    convexity=5
    );
 
 //if(fn%4)echo("<font size=7 color=red>FN nicht teilbar durch 4");
 
 if(loch)Tz(center?-l/2:0)rotate_extrude(convexity=5,$fn=fn)polygon(concat(
    kreis(rand=0,grad=90,r=rad,rot=+90,center=false,t=[d/2-rad,rad],fn=fn2/4),//unten 
    kreis(rand=0,grad=90,r=rad2,center=false,rot=0,t=[d/2-rad2,l-rad2],fn=fn2/4)//oben
    
    ),
    //paths=[[for(i=[0:floor(fn/4)])i,for(i=[floor(fn/2)+1:-1:floor(fn/4)+1])i]],
    convexity=5 
    );    

    if(name)echo(str("»»» »»» ",name," Pille Länge= ",l," sphere r= ",rad,"/",rad2," Durchmesser=",d));
    if(2*rad>l)echo(str("<H1><font color=red>∅>l ",n," Pille Länge= ",l," sphere∅= ",d)); 
     
  if(help)echo(str("<H3><font color=",helpMColor,">Help Pille(l=",l,", d=",d,", fn=",fn,", fn2=",fn2,", center=",center,",n=",n,", s=",s,", rad=",rad,",rad2=",rad2,", loch=",loch,", help);"));
    
}

module BogenOrg(grad=90,rad=5,d=3,l1=10,l2=12,name,fn=fn,fn2=fn,ueberlapp=-0.001,help)//depreciated
{
      color("green")T(rad,ueberlapp)R(-90)cylinder(l1+0.0,d=d,$fn=fn); 
      rotate(-grad/2)Torus(rad,d,a=-grad,n=0,fn=fn2,fn2=fn);
      color("orange")R(z=-grad-180) T(-rad,ueberlapp)R(-90,180,0)cylinder(l2+0.0,d=d,$fn=fn);
  if(name)echo(str("»»» »»» ",name," Bogen ",grad,"° Durchmesser= ",d,"mm — Innenmaß= ",2*max(rad,d/2)-d,"mm Außenmaß= ",2*max(rad,d/2)+d));
      
  if(!$children)Echo("Bogen missing Object! using circle",color="warning");
  
  if(help)echo(str("<font color=",helpMColor," size=3><b>Help Bogen(grad=90,rad=5,d=3,l1=10,l2=12,name,fn=fn,fn2=fn,ueberlapp=-0.001,help)"));
}
   
   
}
/* // Depreciated // // // // // // // // // // // // //
    Depreciated / for Deletion

module Aussenkreis(h=5,d=5.5,eck=6,kreis=0,fn=150,n=1)//misleading depreciated
{
    echo("!!!!!!!!!!!!!!!!!! Renamed Inkreis");
    Inkreis(h=h,d=d,eck=eck,kreis=kreis,fn=fn,n=n);
    echo("!!!!!!!!!!!!!!!!!! Renamed USE Inkreis");
}



module Inkreis(h=5,d=5.5,eck=6,kreis=0,fn=fn,name)//depreciated
{
     echo("<font color='red'size=10>!!!!!!!!!!!!!!!!!! Don't use — depreciated!!<font color='blue'size=7> - use functions Inkreis or Umkreis </font></font>");
    if(eck==8){
        a=d*(sqrt(2)-1);

        R(z=180/8)cylinder(h,r=a*sqrt(1+(1/sqrt(2))),$fn=kreis?fn:eck);  
    }  
    
    if(eck==6)cylinder(h,d=Umkreis(6,d),$fn=kreis?fn:eck);
    
    if(eck==4)R(z=45)cylinder(h,r=sqrt(2*pow(d/2,2)),$fn=kreis?fn:eck);
    if(eck==3)R(z=0)cylinder(h,r=d,$fn=kreis?fn:eck);
    
    if(name)echo(str("»»» »»» ",name," ",eck,"-eck Inkreis∅= ",d));
}


   
DEL module RingOLD(h=5,rand=2,d=10,cd=1,center=false,fn=fn,name,2D=0)// marked for deletion
{
if (!2D){
     if(cd==1){difference()//Aussendurchmesser
        {
            cylinder(h,d=d,$fn=fn,center=center);
            cylinder(2*h+1,d=d-2*rand,$fn=fn,center=true);
        }
        if(name)echo(str("»»»  »»» ",name," Ring Aussen∅= ",d,"mm — Mitte∅= ",d-rand,"mm — Innen∅= ",d-(rand*2),"mm groß und ",h," hoch ««« «««"));}
            
     if(cd==0){difference()//Center durchmesser
        {
            cylinder(h,d=d+rand,$fn=fn,center=center);
            cylinder(2*h+1,d=d-rand,$fn=fn,center=true);
        }
        if(name)echo(str("»»»  »»» ",name," Ring Aussen∅= ",d+rand,"mm — Mitte∅= ",d,"mm — Innen∅= ",d-rand,"mm groß und ",h," hoch ««« «««"));}        
            
         
     if(cd==-1){difference()//innen durchmesser
        {
            cylinder(h,d=d+2*rand,$fn=fn,center=center);
            cylinder(2*h+1,d=d,$fn=fn,center=true);
        }
        if(name)echo(str("»»»  »»» ",name," Ring Aussen∅= ",d+2*rand,"mm — Mitte∅= ",d+rand,"mm — Innen∅= ",d,"mm groß und ",h," hoch ««« «««"));}
    }


if (2D){
     if(cd==1){difference()//Aussendurchmesser
        {
            circle(d=d,$fn=fn);
            circle(d=d-2*rand,$fn=fn);
        }
        if(name)echo(str("»»»  »»» ",name," Ring Aussen∅= ",d,"mm — Mitte∅= ",d-rand,"mm — Innen∅= ",d-(rand*2),"mm groß und 2D ««« «««"));}
            
     if(cd==0){difference()//Center durchmesser
        {
            circle(d=d+rand,$fn=fn);
            circle(d=d-rand,$fn=fn);
        }
        if(name)echo(str("»»»  »»» ",name," Ring Aussen∅= ",d+rand,"mm — Mitte∅= ",d,"mm — Innen∅= ",d-rand,"mm groß und 2D ««« «««"));}        
            
         
     if(cd==-1){difference()//innen durchmesser
        {
            circle(d=d+2*rand,$fn=fn);
            circle(d=d,$fn=fn);
        }
        if(name)echo(str("»»»  »»» ",name," Ring Aussen∅= ",d+2*rand,"mm — Mitte∅= ",d+rand,"mm — Innen∅= ",d,"mm groß und 2D ««« «««"));}
    }

         
}

DEL module RingX(layer,rand,durchmesser)//old don't use! 
{
     
  echo("<font color='red'size=10>WARNING - DONT USE , REMOVED -- USE: 'Ring(hoehe=l(layer);'</font>");  
    difference()
        {
            cylinder(l(layer),d=durchmesser,$fn=250,center=false);
            translate([+0,0,-l(.5)])cylinder(l(layer+1),d=durchmesser-rand,$fn=250,center=false);
        }
}

//function negRedOLD(num)=num<0?str("<font color=red ><b>",num,"</font>"):num; // display console text
   
   
   
   
   
   
   
// */
   

echo("\n---————————————————————————————————————————---\n");
 
 // for demo Objects (incomplete)
if (show) %color([0.6,+0.0,0.9,0.8]){
  if (show==402)Strebe();    
  if (show==400)Pivot();    
  if (show==100)Trapez();
  if (show==67)Tring();    
  if (show==66)Prisma();    
  if (show==65)Sichel();    
  if (show==64)Balg();    
  if (show==63)Area();    
  if (show==62)Spirale();     
  if (show==61)Gelenk();      
  if (show==60)Glied();
  if (show==59)ReuleauxIntersect(); 
  if (show==58)Box();    
  if (show==57)Tugel();
  if (show==56)Vorterantrotor();
  if (show==55)Kassette();   
  if (show==54) Sinuskoerper();
  if (show==504) Achsenklammer();   
  if (show==503) Achshalter();
  if (show==52) Freiwinkel();
  if (show==51) Dreieck();    
  if (show==50) Rohr();
  if (show==49)Bogen(grad=90,rad=5,d=3,l1=10,l2=12);
  if (show==48)Imprint(txt1="››»»Rundherrummmm»»››",abstand=17.8,radius=20,rotz=-27,h=l(2),rotx=0,roty=0,stauchx=0,stauchy=0,txt0=" ",txt2=" ");
  if (show==47)W5(kurv=15,arms=3,detail=.3,h=50,tz=+0,start=0.7,end=13.7,topdiameter=1,bottomenddiameter=+2);//Spiralarm   
  if (show==46)Text(text="»DEMO«",size=5,h=0,cx=0,cy=0,cz=0,center=0,radius=0);    
  if (show==45)Bitaufnahme();
  if (show==44)Knochen();    
  if (show==43)Servotraeger(SON=1);
  if (show==42)Gardena();    
  if (show==41)Luer();
  if (show==40)DGlied1();    
  if (show==39)DGlied0();
  if (show==38)Glied(); 
  if (show==37)Kehle(); 
  if (show==36)Twins(); 
  if (show==35)Pille();
  if (show==34)Torus2();    
  if (show==33)Torus();
  if (show==32)Ring();
  if (show==31)MK();
  if (show==301)Kegelmantel();
  if (show==30)Kegel();
  if (show==300)Kugelmantel();    
  if (show==202)Halbrund();
  if (show==29)Bezier()sphere(2,$fn=12);   
  if (show==28)Kontaktwinkel()sphere(d=10);     
  if (show==27)Gewinde(); 
  if (show==26)Rundrum()circle(5);
  if (show==261)Ttorus()scale([2,1,1])sphere(5,$fn=12);    
  if (show==25)Drehpunkt(x=15,y=2,z=-8,rx=20,ry=20,rz=20,messpunkt=1)cube(5);
  if (show==24)Halb()sphere(20);   
  if (show==23)Klon(tx=10,rx=+25)cube(10,true);     
  if (show==22)Polar(x=10,y=10)cube(5);    
  if (show==21)Linear(es=0.5,s=1.0,e=4,x=90,y=0,z=0,r=0,re=0,center=+1,cx=+0)cube(5);

  if (show==4){cube(50,true);Echo("50mm Cube",color="purple");}
  if (show==3){cube(20,true);echo("20mm Cube",color="purple");}   
  if (show==2){cylinder(10,d=n(1),$fn=36,center=true);echo(str(n(1)," mm ∅ =n(1) cylinder×10mm"),color="purple");}
  if (show==1){cube(10,true);echo("10mm Cube",color="purple");}

}
 
 
/** \name Archive
##  •••• Archive ••••  
   
   
140|17 Changelog - beta 4.7
140|17 ADD Text - beta 4.7
141|17 ADD show 
164|17 ADD Bogen CHG Schnitt rotation default - beta 4.9
165|17 ADD Gewinde - beta 5
169|17 CHG Polar - beta 5.01
171|17 ADD Dreieck - beta5.1
179|17 CHG t0↦-t0  - beta5.11
180|17 CHG ADD Freiwinkel  - beta 5.2
182|17 CHG Polar ADD dr - beta 5.21
183|17 CHG Halbrund ADD parameter - beta 5.22
184|17 ADD Achshalter -beta 5.3
185|17 CHG Luer ADD lock ADD !male beta 5.41
187|17 CHG Ring ID OD CD - CHG Pille l corrected! DEL Stabhalter beta 5.5
189|17 CHG Achshalter ADD MutterSpiel - β5.51
202|17 ADD Sinuskoerpe, ADD color - β5.6
208|17 CHG Bogen fn=  -β5.7
211|17 CHG Kegel ADD center - β5.8
213|17 ADD Col for color  - β5.9
216|17 ADD $fn=fn, CHG Dreieck ADD Winkel -β6.0
226|17 ADD Kehle β6.1
232|17 ADD Gardena β6.2
237|17 ADD Kegelmantel β6.3
238|17 ADD Kugelmantel ADD Halb β6.4
240|17 ADD Klon β6.5
241|17 ADD Rohr ADD Drehpunkt β6.6
247|17 CHG Rohr CHG Bogen  β6.7
276|17 CHG Dreieck ADD ha2 β6.8
338|17 CHG Glied - ring dicke auf 1.5n  β6.9


029|18 CHG TEXT ADD font 
058|18 CHG Kehle ADD fn2,r2 β7
060|18 ADD Kassette β7.1
062|18 CHG Linear center β7.2
104|18 ADD Vorterantrotor β7.3
113|18 CHG Vorterantrotor ADD Mklon β7.38
121|18 CHG Torus ADD dia CHG min β7.39
123|18 ADD Tiegel β7.4
135|18 ADD Reuleaux β7.5
138|18 ADD Box ADD ReuleauxIntersectβ7.6
143|18 ADD Bogendreieck
149|18 CHG Schnitt add center ADD Spirale β7.7
161|18 CHG Glied, DGlied  β7.8
173|18 CHG Gardena β7.9
176|18 CHG Ring hoehe=h β8
183|18 CHG Kehle add convexity
191|18 ADD function Hypertenuse β8.1
194|18 ADD Area ADD Balg β8.2
200|18 CHG Box Add d2 β8.3
207|18 CHG Pille CHG Torus Add center β8.4
209|18 ADD Sichel β8.5
212|18 ADD Prisma β8.6
213|18 CHG Kugelmantel rand β8.6
214|18 ADD t3 β8.7
230|18 CHG Ring Add 2D β8.8
235|18 ADD Trapez β8.9
237|18 CHG Trapez x1/x2 β9.0
241|18 ADD Tring add Trapez&Prisma winkelinfo β9.1
244|18 CHG Sinuskoerper Add 2D, linextr Add fill β9.21
245|18 CHG Polar Chg END β9.3
246|18 CHG Halb Add 2D ADD Rundrum β9.4
254|18 CHG Spirale Add children β9.5
267|18 CHG Rundrum Add spiel ADD Kontaktwinkelβ9.6
273|18 CHG Text Add str CHG Gewinde warning β9.7 
278|18 ADD Kathete ADD func Inkreis ADD func Umkreis β9.8
279|18 CHG Rundrum Add eck β9.9
288|18 ADD Ttorus ADD instructions ADD colors/size CHG Col Add $children β10
289|18 CHG Col Add trans β10.1
308|18 CHG Torus Add spheres ADD M β10.3
313|18 ADD Rund β10.4
324|18 ADD Achsenklammer CHG Schnitt debug on β10.5
327|18 ADD LinEx β10.6
331|18 CHG Spirale Add hull switch β10.7
332|18 ADD Bezier CHG add $children CHG Kassette add r CHG Rundrum chg r add intersect β10.9
333|18 CHG Bezier add funct/polygon Pivot ADD Pivot β11
334|18 CHG Bezier add pabs,ex,w β11.1 (chg to v.2018)
335|18 ADD Strebe β11.2
341|18 CHG Bogen fix β11.3
346|18 ADD Elipse β11.4
349|18 CHG LinEx Add twist β11.5
352|18 CHG Kontaktwinkel Add inv CHG ReuleauxIntersect Add 2D β11.6
357|18 ADD Laser3D β11.7 Chg β11.8
360|18 ADD function Kreis() β11.9


001|19 CHG Kreis Add r2 rand2 β12
002|19 Add Kegel/Kegelmantel/Dreieck grad β12.2
006|19 CHG Kegelmantel zversch CHG Kegel d2>d1 β12.3
010|19 CHG Col Add palette β12.4
011|19 CHG Kreis Add center β12.5
012|19 CHG Add switch for basis/prod objects β12.6
025|19 CHG LinEx Add slices β12.7
032|19 ADD KreisXY CHG Bezier detail/fn β12.8
059|19 ADD RotLang β12.9
060|19 CHG Linear chg e/s β13
073|19 CHG Imprint β13.1
075|19 ADD 5gon CHG RotLang β13.2
077|19 CHG Glied3 Gelenk CHG Linear s=0 β13.3
080|19 CHG Kassette add fn2,h chg size, β13.4
080|19 CHG Strebe add fn β13.5
093|19 CHG Col CHG Kassette β13.6
111|19 CHG LinEx ADD Grid CHG Prisma Add warning β13.7
113|19 CHG Bitaufnahme Add Star ADD Rand β13.8
117|19 CHG Ring CHG Achshalter CHG Achsklammer Add fn CHG commented depreciated functions β13.9
124|19 CHG Pille
127|19 CHG Grid
130|19 CHG Kreis Add rot ADD Gewinde2 ADD Tz() β14
132|19 CHG Gewinde2 Ren Gewinde ⇔ GewindeV1 (old version)β14.1
134|19 chg fn=$preview?-render chg vp - CHG Pivot chg size β14.2
135|19 CHG Linear Add n, chg fn, Schnitt warning
138|19 ADD VorterantQ β14.3
141|19 CHG Gewinde Add preset ½zoll chg r1,rh calc β14.4
147|19 CHG Prisma c1=c1-s
148|19 ADD Linse β14.5
150|19 CHG Strebe Add 2D CHG Kreis Add t=[0,0] CHG Kreis⇒KreisOrginal CHG Gewinde fn β14.6
151|19 CHG Kassette Add sizey
152|19 ADD Quad β14.7
157|19 CHG Sichel Add 2D β14.8
159|19 CHG Text font 
168|19 CHG Pille ADD Disphenoid β14.9
169|19 CHG Gewinde β15.0
170|19 CHG Kassette
v2019.5
170|19 CHG Kreis() CHG Linse() β15.1
171|19 ADD Stern()  - cleaned  β15.2
172|19 CHG Kegelmantel
173|19 CHG Pille()
175|19 CHG Servokopf CHG Stern CHG Linse β15.3
176|19 CHG Pille add rad2
180|19 CHG Quad add r CHG Pille ADD Cring β15.4
181|19 CHG Quad CHG Cring
182|19 ADD Surface β15.5
185|19 CHG Kegel Add spitzenwinkel info
187|19 CHG Cring Add fn2
188|19 CHG Twins Add 2D
190|19 CHG Cring 
194|19 CHG Polar Add mitte
203|19 CHG Gewinde ADD LinEx2 CHG Stern β15.6
205|19 CHG Gewinde ADD GewindeV3 chg spiel↦0.2 β15.7
207|19 CHG Surface Add abs
209|19 CHG n() chg nozzle
210|19 CHG Grid β15.8
211|19 CHG Grid Add element Nr CHG Polar
212|19 CHG Gewinde Add translate rotate
219|19 CHG Kassette Add help CHG Surfale Add help ADD helpM β15.9
222|19 CHG Kassette Add n
227|19 CHG Bogen Add Child ADD RStern CHG Pivot Add active ADD SCT β16
228|19 CHG Bogen CHG Rohr CHG RStern
229|19 CHG Stern rot90 CHG RStern ADD TangentenP
230|19 CHG Bogen chg green arm CHG RStern β16.1
236|19 CHG Cring rotate end2
240|19 ADD ZigZag β16.2
241|19 ADD module ZigZag,module Kreis
243|19 CHG Linse CHG Strebe Add grad help β16.4
244|19 CHG ADD WStrebe β16.5
245|19 CHG Kehle CHG Servotraeger CHG Servokopf Add Spiel
247|19 CHG Kehle Add a ax angle CHG Strebe Add center
248|19 CHG Bogen center rot
252|19 CHG Rundrum Add shift help CHG Kassette β16.6
254|19 CHG Quad Add grad, r vector CHG Pivot ADD Caliper β16.7
256|19 CHG Kehle Add 2D
258|19 ADD Tri
259|19 CHG Rundrum CHG Box‼ β16.8
261|19 CHG Kassette grad2, CHG Rundrum fn ADD RotEx β16.9
263|19 CHG T CHG Line CHG Col Add rainbow β17.0
264|19 CHG Line Add 2D  CHG Col Add rainbow2 ADD Color β17.1
265|19 CHG Bogen Add SBogen β17.2
266|19 CHG Bogen fix fn FIX SBogen FIX Luer CHG Kegel Add h CHG Tri Chg center β17.3
267|19 CHG Rand Add delta chamfer
274|19 CHG SBogen CHG LinEx Add scale2 FIX Prisma CHG Caliperβ17.4
278|19 FIX Balg
279|19 FIX Gewinde
280|19 FIX LinEx CHG Color β17.5
283|19 ADD REcke
284|19 CHG Cring
285|19 ADD WStern ADD WaveEx ADD Superellipse ADD Flower CHG RotLang β17.6
291|19 CHG Kassette ADD Ccube
293|19 CHG Polar/Linear/Grid/Col/Color Add $idx CHG RotLang Add lz β17.7
296|19 ADD RotPoints CHG RotLang 
299|19 CHG Stern Add help CHG LinEx CHG WStern
301|19 ADD Seg7 
302|19 CHG Torus Add End β17.8
303|19 CHG CHG Superellipse Add $fn CHG Prisma Fix CHG Kassette Add 2D - cleanups β17.9
305|19 CHG Kassette Add base
308|19 CHG Superellipse Add Superllipsoid β18
309|19 CHG t-t3 tset for render
310|19 CHG LinEx Add $d $r
313|19 CHG helpM↦$helpM FIX RStern l calc FIX RotEx -grad calc fn
314|19 CHG Prisma Add list option CHG WStern ADD name Fix LinEx
315|19 FIX Quad basisX
316|19 CHG Quad add centerX=-1 trueX β18.1
319|19 FIX Prisma help
320|19 ADD PCBcase β18.2
321|19 CHG PCBcase Chg and Add clip 
325|19 CHG TRI ADD Tri90
326|19 CHG Zylinder Add f3
330|19 CHG Flower CHG LinEx Add Mantelwinkel
333|19 CHG LinEx rotate
334|19 CHG Box Add help CHG debug β18.4
336|19 Fix Pille CHG PCBcase
342|19 CHG Zylinder Add altFaces
349|19 ADD Row β18.5
350|19 ADD new Pille2 
351|19 CHG Spirale polygon generation
353|19 CHG Pille Add grad CHG Servokopf
359|19 CHG Rundrum Fix child help/info
360|19 ADD Welle
361|19 ADD Klammer FIX LinEx


008|20 ADD Kextrude
009|20 FIX LinEx scale list info
013|20 FIX Color $idx
017|20 CHG Text h=0↦2D 
018|20 ADD Pin β18.6
023|20 FIX Bezier messpunkt CHG Pivot add txt/vec
024|20 CHG Pin add Achse
026|20 CHG Strebe 
031|20 CHG Welle add overlap CHG Kehle add spiel vektor
053|20 CHG Bitaufnahme β18.7
055|20 CHG Kreis Add d, ADD Wkreis CHG Row β18.8
056|20 FIX Wkreis calc OD/ID CHG Stern Add center 
057|20 ADD RSternFill CHG RStern
058|20 FIX WKreis,RSternFill
060|20 ADD Cycloid
062|20 ADD SQ CHG Cycloid Add linear β18.9
065|20 CHG LinEx Add rotCenter chg name CHG SBogen Add extrude β19.0
068|20 ADD Vollwelle
070|20 CHG Quad
073|20 CHG LinEx slices 
076|20 CHG diverse name info
078|20 ADD Anschluss
080|20 CHG SBogen/Anschluss Add grad2 CHG Vollwelle Add mitte⇒β19.1
083|20 CHG Pin CHG LinEx
088|20 CHG SBogen Add info CHG Grid
101|20 CHG SBogen
112|20 CHG Prisma Add center
113|20 CHG Anschluss Add x0 CHG SBogen Add x0 ⇒β19.2
119|20 ADD Anordnung
123|20 CHG LinEx add grad vector x/y CHG Kreis CHG Cycloid
124|20 ADD CyclGetriebe ⇒ β19.3
131|20 ADD Sekante⇒ β19.31
132|20 CHG Torus ⇒β19.32
134|20 CHG Ttorus
135|20 CHG Achsenklamer Achshöhe CycloidZahn/Getriebe fn
139|20 CHG Prisma nama
140|20 ADD Buchtung CHG Kehle Add end β19.34
148|20 CHG Halbrund Add 2D help CHG Ttorus Add scale β19.35
155|20 ADD Bevel CHG Kassette name CHG Anordnung CHG Schnitt
156|20 CHG CycloidZahn/Gear β19.36
157|20 CHG Bevel Add -z CHG Konus β19.37
163|20 CHG CyclGetriebe d !preview add rot
181|20 CHG Anordnen CHG Kugelmantel Add help
190|20 ADD SRing β19.38
191|20 CHG Bogen Add Info
195|20 CHG Linse Add help CHG CyclGetriebe Chg spiel=.075
209|20 Fix Cring
211|20 CHG Kreis Add b β19.39
215|20 CHG Gardena Dichtungsring
220|20 CHG SBogen Add spiel
221|20 CHG Pille d<h ⇒rad
232|20 CHG Sichel Add help β19.4
236|20 CHG Text Add help
237|20 CHG Kehle fix end ↦ β19.5
237|20 CHG Kehle Add fase
244|20 CHG Quad n⇒name CHG Gewinde kern↦undef↦ β19.51
254|20 FIX n() for negatives β19.52
276|20 FIX Rund ir=0 β19.53
281|20 FIX Kegel name FIX Luer name β19.54
290|20 CHG Schnitt on=2 β19.55
317|20 CHG Anschluss Add Wand CHG SBogen Add neg radius warning β19.61
318|20 CHG REcke Add fn
321|20 CHG Torus end Add gradEnd β19.63
322|20 CHG Bezier ex CHG Text Add 2D
325|20 CHG Text chg center β19.65
328|20 CHG Gewinde Add center Add endMod ADD gw tw twF constβ19.66
330|20 FIX Linear chg for s
338|20 FIX Rand center
343|20 ADD Nut β19.7
344|20 FIX Nut β19.72
346|20 CHG Surface Add exp β19.73
347|20 CHG Surface Add mult
349|20 ADD DRing β19.75 CHG Anordnen c=undef CHG Rundrum CHG MKlon Add $idx
350|20 CHG Caliper Add end=2  β19.76
351|20 ADD DBogen β19.77 CHG RotEx+funcKreis abs(fn)
355|20 CHG Linear s⇒$idx
357|20 CHG Color
361|20 CHG Anordnen

2021

000|21 CHG Klammer l vector CHG Quad r=undef β19.78
005|21 CHG Glied FIX LinEx FIX Schnitt β19.79
007|21 CHG Vollwelle Add h β19.8
011|21 CHG Vollwelle Add l CHG LinEx Add End ADD inch β19.81
013|21 CHG Pille chg rad list FIX Kegelmantel FIX LinEx hc=0 CHG Klon Add $idx CHG LinEx end FIX Kassette name β19.82
016|21 FIX Grid CHG Vollwelle list fn CHG Nut Add grad β19.821
017|21 FIX CycloidZahn β19.822
018|21 FIX Pille β19.83
019|21 FIX SBogen/Bogen
022|21 ADD gradB CHG Quad warning CHG Text help radius β19.84
023|21 ADD funct vollwelle CHG Gewinde test vollwelle
025|21 ADD fonts styles lists CHG Text β19.85
026|21 CHG Text Add rot fix -h CHG Vollwellen grad list FIX Anschluss r1/2 β19.86
027|21 CHG Linear  e first CHG Grid e first Add s
028|21 CHG Vollwelle fix h replaced w. vollwelle() β19.88
029|21 ADD GewindeV4 CHG Gewinde β19.89
030|21 CHG GewindeV4 autocalc warning variables ADD useVersion ADD func gradS CHG Ring method FIX Prisma FIX LinEx β19.90
031|21 CHG Pille Rad2 CHG Sichel Add step CHG DBogen Add spiel CHG Text fn FIX Kegel
040|21 CHG Kegelmantel CHG Gewinde Add konisch β19.94
042|21 CHG vollwelle g2 end Fix grad list,CHG GewindeV4 konisch grad2, FIX Caliper help β19.95
043|21 FIX Bogen n CHG Gewinde Add ISO presets β19.951
045|21 FIX Quad x=list CHG Drehpunkt Add vector help β19.952
046|21 CHG Quad r gerunded CHG LinEx max slices Fix Luer β19.953
051|21 FIX Pille rad2
055|21 CHG Bogen Add l[] CHG Rundrum x[] β19.955
056|21 CHG Gewinde
057|21 FIX Nut console Add Pfeil CHG console colors β19.957
058|21 FIX Linear e=1/0 β19.958  CHG Anordnen es⇔e es=Sehne
059|21 CHG Rund Add vector ADD func radiusS
060|21 ADD func radiusS+grad FIX Quad rundung CHG LinEx warning+h2=0 β19.960
β21.60
062|21 CHG Gewinde add tz in preset chg spiel CHG DRing Add center FIX Kehle bool
063|21 FIX DBogen FIX Gewinde wand
064|21 FIX Gewinde children old Version CHG DRing Add grad
068|21 CHG Ring Add Id CHG Torus Add endRot ADD func Inch FIX Kehle end
069|21 CHG Kehle Add Fillet
070|21 CHG Kehle Add  dia/Fillet CHG Ring Add grad CHG help CHG Bevel Add messpunkt CHG Anordnen Add rot

078|21 CHG Schnitt center bool CHG Color Add color names CHG Pfeil Add d
079|21 CHG Gewinde Add gb
081|21 FIX RStern n
082|21 ADD Rosette
083|21 ADD Scale CHG Rosette Add children Del round
085|21 ADD GT
087|21 FIX LinEx warning CHG WStrebe grad2 undef
089|21 FIX LinEx grad list  CHG GT Add fn FIX SRing h
091|21 ADD Egg ADD HelpTxt ADD InfoTxt CHG GT2 CHG Torus end fn2
092|21 ADD BB FIX DBogen CHG Egg Add breit CHG Anordnen
093|21 ADD $fs CHG DBogen CHG Egg ADD func fs2fn
096|21 CHG BB Add achse center fixes FIX Polar e=0 
098|21 FIX GewindeV3
100|21 CHG Strebe Add fn2
105|21 FIX Infotxt
108|21 ADD Echo FIX HelpTxt InfoTxt for v[2021] CHG Achsenklammer CHG Ring help
111|21 CHG Gewinde helptxt Fix SBogen -grad
118|21 CHG Color Add spread
119|21 FIX LinEx
127|21 CHG Zylinder faces
130|21 CHG Zylinder var
138|21 ADD HexGrid
139|21 CHG Zylinder Add center
142|21 FIX Vollwelle 
148|21 CHG Text add spacing
149|21 ADD HypKehle
151|21 CHG HexGrid es vector ADD PrintBed
164|21 CHG Text spacing
166|21 CHG Text not empty CHG vpt printBed/2
176|21 CHG Pin 
178|21 CHG Rohr
181|21 CHG Cring
194|21 ADD Abzweig FIX Anschluss
215|21 ADD printPos FIX Abzweig
216|21 ADD assert Version
217|21 CHG Zylinder Add lambda
218|21 CHG Pille Add r CHG Abzweig CHG T Add vector
224|21 FIX printPos vpt
235|21 FIX Luer 33.3
237|21 CHG Zylinder lambda
245|21 CHG menue layer nozzle var
260|21 FIX LinEx list $r
268|21 FIX Gewinde Mantel
272|21 FIX removed ,, (test with [2021,9]) some formating regarding version
273|21 FIX formating for v21
276|21 FIX GewindeV4 faces error grad<360
277|21 FIX LinEx vector, del Schnitt convexity, cCube
280|21 FIX Polar 1 with end<360
281|21 FIX Cring bool
283|21 FIX Gewinde winkel
284|21 FIX Kreis ceil(fn) CHG Bevel messpunkt FIX Trapez help
285|21 FIX Ring rot 90
286|21 FIX Anordnen;
287|21 CHG Torus Add endspiel FIX Kreis r=0 b
288|21 FIX Halb
289|21 FIX Pille accuracy issue ADD minVal
290|21 ADD clampToX0 FIX Pille help info FIX Torus grad end
291|21 ADD KreisSeg
292|21 FIX Cycloid points, Cyclgetriebe bool center + info CHG Kreis r=0 rand=0
295|21 FIX HelpTxt,InfoTxt ↦ scad version > 2021
296|21 CHG Vollwelle/ECHO
297|21 CHG Gewindev4 calc dn=undef
298|21 CHG Echo add color characters
299|21 CHG Gewinde g rot CHG GewindeV4 add g autocalc
301|21 CHG Tugel Add rand,help fix name,CHG help info DBogen
305|21 CHG Bezier Add $idx for children ADD vektorWinkel ADD v3
306|21 CHG Echo Add colors CHG Pfeil CHG Anordnen CHG Halbrund CHG Imprint 
307|21 CHG helptext changes CHG Glied ADD GT2Pulley FIX Superellipse FIX LinEx2
208|21 FIX help Diverse 
309|21 CHG Gewinde Add other FIX Zylinder fix ub CHG SBogen ADD parentList
310|21 FIX Anschluss
311|21 FIX Grid ub FIX v3() CHG Bezier CHG parentList CHG SBogen 
312|21 FIX Strebe

313|21  Reordering modules ADD teiler FIX Help txt ADD MO fix missing obj warnings
314|21  ADD Example Fix Linear infotxt
315|21  CHG Anordnen Add center CHG Pfeil  add center add inv CHG Calliper CHG Pivot
316|21  ADD 3Projection CHG Scale CHG Halb CHG Rand add help
317|21  CHG WStern help CHG Caliper CHG GT2Pull ADD gcode CHG Tri, Quad, Kreis
318|21  CHG Tri90, Linse, Pivot, Star, 7Seg, DBogen
319|21  ADD b() CHG PCBcase
320|21  CHG view to viewportSize
321|21  CHG Kehle ADD KBS REN KreisSeg↦TorusSeg
324|21  ADD scaleGrad CHG RotEx $fa
325|21 !CHG Kreis rotate 180 for center==true ⇒ CHG Quad ⇒ Egg ⇒ WKreis ⇒ GT ⇒ RSternFill ⇒ Tri CHG LinEx CHG Bezier CHG Ttorus CHG Torus CHG Rundrum CHG Pivot CHG Bogen
326|21  CHG CyclGetriebe CHG Pivot CHG Kreis CHG Klammer CHG KBS add top
327|21  CHG HypKehle/HypKehleD ADD Isopshere Add pPos
3272|21 FIX  Issue  #2
328|21  CHG $helpM use  CHG HelpTxt CHG Quad CHG Rundrum  CHG n↦name
3281|21 CHG KBS CHG CHG $info
3282|21 CHG Quad Add tangent + Fixes
329|21  CHG Polar Prisma help info CHG Anordnen FIX Bogen(2D) SBogen CHG Kontaktwinkel CHG b(add bool) Add $tab
330|21  FIX HypKehle ADD VarioFill CHG Color CHG InfoTxt CHG Flower CHG Cycloid FIX DBogen FIX Kegel info/help Kegelmantel
331|21  CHG Abzweig CHG Kontaktwinkel
332|21  CHG Linear CHG Surface help Scale 2D
333|21  ADD easterEgg
334|21  FIX Bezier FIX Line
335|21  FIX Strebe FIX Rundrum ADD is_parent( needs2D )CHG VarioFill
336|21  FIX Vollwelle grad2=90 FIX Strebe assert CHG Nut CHG negRed CHG Quad CHG Tri add c
337|21  FIX SBogen 2D CHG Anschluss FIX Bogen CHG Bezier CHG gcode CHG Ttorus
338|21  CHG Color $idxON  CHG Bezier hull=false
339|21  FIX Ttorus  diverse $tab / $info fixes HypKehle Polar Linear Grid DBogen CHG SBogen
340|21  ADD m CHG div tab info CHG InfoTxt FIX WaveEx
341|21  FIX Pfeil d FIX Quad
346|21  ADD mPoints CHG m add s
349|21  CHG Bezier
350|21  ADD function Quad ADD function octa ADD OctaH
351|21  ADD function Stern CHG Torus End true for children CHG Sichel CHG Spirale
354|21  CHG HexGrid info FIX Strebe
355|21  CHG Bogen CHG Pille CHG GewindeV3 help
356|21  FIX Servokopf FIX Glied CHG HypKehleD CHG TorusSeg
357|21  CHG Rohr/Bogen  CHG OctaH CHG TorusSeg REN ⇒ RingSeg CHG Gewinde version undef⇒ new FIX V2
358|21  CHG Box help CHG Gewinde CHG OctaH
359|21  ADD Points Add Helper help CHG help menu
360|21  CHG Anordnen
361|21  CHG Vollwelle CHG fVollwelle Add tMitte  CHG multiple (help) Menu HelpTxt Buchtung KreisSeg
362|21  CHG RotEx fn CHG Halbrund help
363|21  CHG func stern quad bezier kreis CHG Kehle help fix end spiel CHG Buchtung help 
364|21  FIX Ring REP Kreis kreis

2022

000|22 prepare release CHG VarioFill
001|22 CHG MKlon
002|22 CHG Line 
004|22 FIX Gewinde CHG Vollwelle CHG Caliper CHG GewindeV3
005|22 CHG Gewinde
006|22 CHG Anschluss FIX Zylinder
007|22 FIX Ellipse CHG Points ADD PolyH
008|22 FIX Ttorus CHG PolyH CHG RotLang
009|22 CHG Points add center CHG kreis add z CHG quad add z
011|22 FIX Box Prisma FIX Gewinde
012|22 CHG Rosette Add id od FIX spelling help CHG Anorden (fix for 2021.1)
0121|22 FIX Anordnen FIX SRing FIX Knochen
013|22 CHG Rosette autocalc
015|22 FIX Gewinde
016|22 CHG RingSeg FIX Kassette help CHG Superellipse
019|22 CHG Schnitt size
020|22 CHG KBS CHG Prisma CHG Box CHG Pille
021|22 CHG Pille FIX m chg v3 chg stern CHG Buchtung CHG Schnitt size
022|22 CHG Kassette ADD pathPoints CHG kreis ADD Coil ADD wStern CHG vektorWinkel CHG Halb CHG Superellipse CHG Glied ADD SGlied CHG Prisma ADD Tdrop CHG Bezier
Release
033|22 CHG DRing CHG DBogen CHG Strebe CHG Ttorus CHG Glied CHG Kreis ADD wall CHG n()
036|22 ADD star CHG SpiralCut CHG Gewinde CHG Bevel
037|22 CHG star ADD Star
038|22 CHG star CHG SpiralCut CHG Anordnen FIX DGlied Glied SGLied
040|22 FIX SGLied CHG wall
042|22 FIX CycloidZahn CHG Cycloid CHG Polar FIX star
044|22 CHG Kegel FIX star
045|22 CHG CycloidZahn CHG CyclGetriebe add f CHG Cycloid 
046|22 CHG CyclGetriebe CHG CycloidZahn CHG LinEx CHG REcke
047|22 FIX CyclGtriebe
048|22 Add CyclGear FIX Bezier CHG v3 CHG vektorWinkel CHG Points ADD vMult
050|22 CHG vMult CHG Gewinde
052|22 CHG Buchtung CHG SpiralCut Add 2D
054|22 CHG inch CHG Pille ADD Roof
056|22 CHG PolyH CHG kreis CyclGetriebe CHG gradS CHG LinEx CHG Echo
058|22 CHG PolyH
060|22 CHG nametext CHG Egg CHG Stern CHG Star CHG star CHG Roof CHG Linse add fn
062|22 CHG Pfeil
064|22 CHG Pfeil CHG Star add fn2 CHG Roof CHG GT
066|22 ADD naca ADD NACA CHG Roof CHG WStern CHG wall CHG Points
068|22 FIX Polar CHG Umkreis
070|22 FIX star ADD pathLength
072|22 CHG NACA CHG Roof chg LinEx CHG Linse
074|22 CHG Points
076|22 CHG Points FIX Cring CHG Text ADD stringChunk
078|22 CHG Servokopf CHG wall CHG Roof CHG title menue ADD line line() CHG wall chg l() n()
080|22 CHG Star CHG kreis chg Roof
082|22 CHG Seg7 Prisma ADD Cut 
084|22 FIX Seg7 fix Cut
086|22 FIX Cut CHG Achsenklammer ADD nut FIX stringChunk
088|22 CHG bezier add p CHG Seg7 CHG wall CHG nut
090|22 ADD Involute involute
092|22 CHG gcode 
094|22 ADD riemen, Riemen
096|22 CHG Seg7
098|22 CHG Coil CHG T
100|22 UPD ZigZag FIX Riemen  
101|22 reordered  
102|22 CHG Glied CHG Riemen UPD Welle CHG Nut  
104|22 CHG Riemen UPD Zylinder CHG Bogen SBogen  
106|22 ADD kreisSek CHG Points  
108|22 CHG Pivot FIX/UPD kreisSek  
110|22 UPD Cut CHG GewindeV4  
112|22 UPD HexGrid UPD Grid FIX vollwelle  
114|22 CHG RotEx CHG DGlied0  
116|22 FIX SGlied,DGlied upd Seg7  
118|22 ADD vSum CHG Rund CHG CycloidZahn  
120|22 CHG Roof FIX gradS UPD Coil CHG quad chg pPos  
130|22 ADD bend ADD sq upd needs2D UPD mPoints UPD m UPD Bezier UPD Coil chg pathPoints  
132|22 CHG Spirale UPD pathPoints  
134|22 UPD Rundrum UPD Spirale CHG Row  
135|22 Doxygen comments  
137|22 FIX Spirale  
140|22 FIX Caliper  
142|22 CHG Quad fn  Add DPfeil FIX Text  
144|22 ADD scene ADD map  
146|22 CHG Disphenoid UPD vSum  
148|22 FIX Prisma UPD LinEx UPD map
150|22 CHG Torus UPD Ellipse
152|22 ADD Schlaufe
156|22 CHG Menu FIX Torus help FIX Torus2 help
158|22 CHG Pin CHG RStern CHG Schlaufe
160|22 CHG Schlaufe UPD Ellipse UPD MO
162|22 UPD Involute
164|22 UPD Schlaufe
166|22 FIX Schlaufe
168|22 ADD PrevPos
170|22 FIX Torus FIX Rundrum
172|22 UPD Rund FIX Spirale
174|22 UPD kreis ADD polyRund PolyRund PolyDeg
176|22 CHG stern
178|22 FIX polyRund UPD PolyRund FIX DPfeil
180|22 ADD revP UPD polyRund PolyRund CHG sq
181|22 FIX polyRund
182|22 FIX polyRund FIX PolyRund
184|22 CHG PolyRund
185|22 CHG PolyRund
188|22 UPD map UPD Rand ADD sehne,UPD Roof
190|22 CHG Quad ADD arc Arc UPD LinEx CHG vMult
202|22 UPD tangentenP
204|22 UPD PolyH
206|22 ADD Knurl
208|22 CHG Text add trueSize add cy=-1/2
210|22 CHG Text Fix Knurl
212|22 upd fold
214|22 ADD parabel
216|22 UPD Tdrop UPD Line UPD Rand
218|22 FIX Schlaufe FIX Knurl
220|22 FIX Kegel ADD designVersion
222|22 FIX LinEx FIX Cut UPD M FIX Rand FIX Knurl FIX Text FIX Roof UPD vSum UPD Quad
230|22 CHG Kreis FIX Cut CHG Pin CHG Roof FIX LinEx FIX Prisma
232|22 UPD Sehne FIX Roof
234|22 FIX Prisma FIX Caliper
236|22 FIX LinEx
240|22 UPD Polar UPD Roof
242|22 FIX Anschluss UPD SQ
250|22 FIX Halb UPD PrevPos
270|22 ADD KnurlTri
272|22 UPD Cring FIX DPfeil CHG radiusS ADD distS UPD Ring CHG Torus UPD Drehpunkt
274|22 FIX LinEx() FIX KnurlTri
276|22 FIX LinEx() UPD Halb()
278|22 CHG Points UPD arc ADD LangL UPD line FIX fs2fn CHG Roof Fix Seg7
280|22 UPD Seg7 UPD name CHG LangL↦Loch
282|22 UPD Vollwelle UPD Nut
283|22 UPD nut
292|22 UPD Echo UPD BB CHG Loch FIX Gardena UPD Pille FIX fs2fn FIX Halb UPD GewindeV1
294|22 UPD Prisma FIX Linear
303|22 UPD Roof FIX Loch
306|22 FIX Pille chg Quad CHG kreis CHG fs
308|22 UPD Welle CHG PrevPos FIX Prisma CHG RotEx
310|22 ADD string2num
312|22 UPD Prisma FIX Roof
316|22 UPD LinEx2 UPD Text FIX DPfeil FIX LinEx FIX Roof FIX radiusS
322|22 FIX Kreis FIX map FIX Line UPD Ring UPD kreis FIX Prisma
333|22 UPD GT2Pulley UPD GT UPD Ring UPD Grid CHG Loch
336|22 UPD Coil FIX LinEx ADD SWelle
338|22 Fix Roof UPD InfoTxt Fix LinEx UPD Ring UPD Bezier UPD Arc CHG SWelle
340|22 CHG VarioFill UPD fs2fn
342|22 ADD layerProfile FIX Linear FIX Kegelmantel
344|22 CHG Luer UPD Kegel FIX VarioFill ADD Filter
352|22 CHG Filter UPD star FIX VarioFill CHG Kegel
354|22 CHG Anschluss UPD Coil UPD Pin UPD vpr
356|22 CHG SBogen CHG Anschluss
358|22 UPD Torus UPD Coil CHG kreis
360|22 FIX Rund UPD fs2fn UPD Luer
362|22 FIX fs2fn UPD BB CHG Torus
364|22 UPD Rand UPD Loch UPD CyclGetriebe



*/

// */

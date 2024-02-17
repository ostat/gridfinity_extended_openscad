use <modules/gridfinity_cup_modules.scad>
use <gridfinity_baseplate.scad>
include <modules/gridfinity_constants.scad>
//From https://www.printables.com/pl/model/363389-gridfinity-drawer-chest-remix

width = 4;
depth = 3;
height = 4;
count = 3;
//heightsRaw = "4 4 4";
clearance = 0.25;
wallthicknessInner = 2;
wallthicknessOuter = 2;
handlewidth = 40;
handleheight = 4;
handlelength = 7;
ridgedepth = 5;
ridgethickness = 1;
bottomgrid = true;
topgrid = true;
mode = "everything"; //["everything", "drawers", "holder", "onedrawer"]
drawergrid = true;

//heights = str_split(heightsRaw, " ");
InnerDrawerW = (width*42) + clearance - 0.25;
InnerDrawerD = (depth*42) + clearance - 0.25;
InnerDrawerH = (height*7) + clearance + 4.25;
OuterDrawerW = InnerDrawerW + (wallthicknessInner * 2);
OuterDrawerD = InnerDrawerD + (wallthicknessInner * 2);
OuterDrawerH = InnerDrawerH + wallthicknessInner;
InnerBoxW = OuterDrawerW + (clearance * 2);
InnerBoxD = OuterDrawerD + (clearance * 2);
InnerBoxH = OuterDrawerH + (clearance * 2);
OuterBoxW = InnerBoxW + (wallthicknessOuter * 2);
OuterBoxD = InnerBoxD + (wallthicknessOuter);
BottomGridOffset = wallthicknessInner + wallthicknessOuter + clearance*2;
TopGridOffset = BottomGridOffset - 0.25;

HoleH = OuterDrawerH + (clearance * 2);
TotalH = (HoleH * count) + (ridgethickness * (count - 1)) + (wallthicknessOuter * 2);
IncrementH = HoleH + ridgethickness;
StartH = wallthicknessOuter;
OffsetW = wallthicknessOuter + clearance;


//DRAWER STUFF
module rounddrawerbox(w, d, h, r=6){
    D = r * 2;
    linear_extrude(height = h)
    minkowski(){
        translate([r, r]) square([w-D, d-D]);
        circle(r);
    }
}
module drawer(h){
    InnerH = (h*7) + clearance + 4.25;
    OuterH = InnerH + wallthicknessInner;
    union(){
        difference(){
            rounddrawerbox(OuterDrawerW, OuterDrawerD, OuterH);
            drawerCutout(h);
        };
        translate([OuterDrawerW / 2, 0, OuterH / 2]) handle();
    }
    
}
module handle(){
    translate(-[handlewidth / 2, handlelength, handleheight/2]) cube([handlewidth, handlelength, handleheight]);
}
module drawerCutout(h){
    translate([wallthicknessInner, wallthicknessInner, wallthicknessInner]) difference(){
        rounddrawerbox(InnerDrawerW, InnerDrawerD, 99999, 4);
        if(drawergrid){
          translate([gf_pitch/2,gf_pitch/2, -0.01]) 
            frame_plain(width, depth);
        }
    }
}
module drawers(){
    for(i = [0 : count-1]){
        vpos = clearance + StartH + IncrementH * i;
        color("red") translate([0, OffsetW, vpos]) drawer(height);
    }
}

//HOLDER STUFF
module baseUnit(){
    import("Bin Base - Printables model 417152.stl");
}
module baseRaw(){
    for(i = [0:width-1]) for(j = [0:depth - 1])
    translate([i * 42, j * 42, 0.15]) baseUnit();
}
module base(){
    translate([BottomGridOffset, BottomGridOffset, 0]) baseRaw();
}
module baseplate(){
    translate([TopGridOffset + 21, TopGridOffset + 21, TotalH]) frame_plain(width, depth);
}
module holder(){
    color("green") difference(){
        union(){
            cube([OuterBoxW, OuterBoxD, TotalH]);
            if(bottomgrid) base();
            if(topgrid) baseplate();
        }
        holderCutouts();
    }
    echo("Bottom offset: ", BottomGridOffset);
    
}
module holderCutouts(){
    for(i = [0 : count-1]){
        vpos = StartH + IncrementH * i;
        translate([wallthicknessOuter, -fudgeFactor, vpos]) 
        holderCutout(InnerBoxW, InnerBoxD+fudgeFactor, InnerBoxH);
    }
}
module holderCutout(InnerBoxW, InnerBoxD, InnerBoxH){
    cube([InnerBoxW, InnerBoxD, InnerBoxH]);
}

//THE END
module everything(){
    holder();
    drawers();
}

if(mode == "everything") everything();
if(mode == "holder") holder();
if(mode == "drawers") drawers();
if(mode == "onedrawer") drawer(height);
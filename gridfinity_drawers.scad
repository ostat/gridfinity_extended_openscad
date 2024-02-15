use <modules/gridfinity_cup_modules.scad>
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
mode = "everything"; //["everything", "drawers", "holder", "onedrawer"]

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

HoleH = OuterDrawerH + (clearance * 2);
TotalH = (HoleH * count) + (ridgethickness * (count - 1)) + (wallthicknessOuter * 2);
IncrementH = HoleH + ridgethickness;
StartH = wallthicknessOuter;
OffsetW = wallthicknessOuter + clearance;


//DRAWER STUFF
module rounddrawerbox(w, d, h){
    r = 6;
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
    minkowski(){
        translate([wallthicknessInner, wallthicknessInner, wallthicknessInner]) basic_cup(width, depth, h+2, position = "zero", filled_in = true, magnet_diameter = 0, screw_depth=0);
        sphere(r = clearance);
    }
}
module drawers(){
    for(i = [0 : count-1]){
        vpos = clearance + StartH + IncrementH * i;
        color("red") translate([0, OffsetW, vpos]) drawer(height);
    }
}

//HOLDER STUFF
module holder(){
    color("green") difference(){
        cube([OuterBoxW, OuterBoxD, TotalH]);
        holderCutouts();
    }
}
module holderCutouts(){
    for(i = [0 : count-1]){
        vpos = StartH + IncrementH * i;
        translate([wallthicknessOuter, 0, vpos]) holderCutout();
    }
}
module holderCutout(){
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
use <modules/gridfinity_cup_modules.scad>

width = 4;
depth = 3;
heights = "4 4 4";
clearance = 0.25;
wallthicknessInner = 2;
wallthicknessOuter = 2;
handlewidth = 40;
handleheight = 4;
handlelength = 7;
ridgedepth = 5;
ridgethickness = 1;

module drawer(w, d, h){
    realInnerW = (w*42) + clearance - 0.25;
    realInnerD = (d*42) + clearance - 0.25;
    realInnerH = (h*7) + clearance + 4.25;
    realOuterW = realInnerW + (wallthicknessInner * 2);
    realOuterD = realInnerD + (wallthicknessInner * 2);
    realOuterH = realInnerH + (wallthicknessInner);
    union(){
        difference(){
            cube([realOuterW, realOuterD, realOuterH]);
            drawerCutout(w, d, h);
        };
        translate([realOuterW / 2, 0, realOuterH / 2]) handle();
    }
    
}
module handle(){
    translate(-[handlewidth / 2, handlelength, handleheight/2]) cube([handlewidth, handlelength, handleheight]);
}
module drawerCutout(w, d, h){
    minkowski(){
        translate([wallthicknessInner, wallthicknessInner, wallthicknessInner]) basic_cup(w, d, h+2, position = "zero", filled_in = true, magnet_diameter = 0, screw_depth=0);
        sphere(r = clearance);
    }
}
module holder(w, d, hs){
    
}

drawer(width, depth, 4);
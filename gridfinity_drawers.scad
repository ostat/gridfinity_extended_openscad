use <modules/gridfinity_cup_modules.scad>

width = 4;
depth = 3;
heightsRaw = "4 4 4";
clearance = 0.25;
wallthicknessInner = 2;
wallthicknessOuter = 2;
handlewidth = 40;
handleheight = 4;
handlelength = 7;
ridgedepth = 5;
ridgethickness = 1;

heights = split(heights, " ");
InnerDrawerW = (width*42) + clearance - 0.25;
InnerDrawerD = (depth*42) + clearance - 0.25;
OuterDrawerW = InnerDrawerW + (wallthicknessInner * 2);
OuterDrawerD = InnerDrawerD + (wallthicknessInner * 2);
InnerBoxW = OuterDrawerW + (clearance * 2);
InnerBoxD = OuterDrawerD + (clearance * 2);

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
    yoffset = wallthicknessInner;
    for(drawerheight = heights){
        
    }
}

//HOLDER STUFF
module holder(){
    
}

module everything(){
    holder();
    drawers();
}

drawer(4);
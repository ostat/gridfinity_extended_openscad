include <ub.scad>
include <gridfinity_constants.scad>
include <functions_general.scad>
include <functions_gridfinity.scad>

module ShowCalipers(
  cutx, cuty, 
  size, 
  lip_style, 
  magnet_depth, 
  screw_depth, 
  floor_thickness, 
  filled_in,
  wall_thickness,
  efficient_floor,
  flat_base){
  
  if(cuty > 0 && $preview)
  {
    color(color_text)
    translate([0,gf_pitch*cuty,0]) 
    rotate([90,0,0])
    showCalipersForSide("width", size.x, size.z, lip_style, magnet_depth, screw_depth, floor_thickness, filled_in,wall_thickness,efficient_floor,flat_base);
  }  
  
  if(cutx > 0 && $preview)
  {
    color(color_text)
    translate([gf_pitch*cutx,gf_pitch*size.y,0]) 
    rotate([90,0,270])
    showCalipersForSide("depth", size.y, size.z, lip_style, magnet_depth, screw_depth, floor_thickness, filled_in,wall_thickness,efficient_floor,flat_base);
  }
}

module showCalipersForSide(description, gf_num, num_z, lip_style, magnet_depth, screw_depth, floor_thickness, filled_in,wall_thickness,efficient_floor,flat_base){
    fontSize = 5;  
    gridHeight= gfBaseHeight();
    baseClearanceHeight = cupBaseClearanceHeight(magnet_depth, screw_depth,flat_base);
    minFloorHeight  = calculateMinFloorHeight(magnet_depth, screw_depth);
    floorHeight = calculateFloorHeight(
          magnet_depth=magnet_depth, 
          screw_depth=screw_depth, 
          floor_thickness=floor_thickness, 
          num_z=num_z, 
          filledin=filled_in,
          efficient_floor=efficient_floor,
          flat_base=flat_base);
    floorDepth = efficient_floor != "off"
      ? floor_thickness :
      floorHeight - baseClearanceHeight;

      if(IsHelpEnabled("info")) echo("showClippersForSide", description=description, gf_num=gf_num,num_z=num_z,lip_style=lip_style,magnet_depth=magnet_depth,screw_depth=screw_depth,floor_thickness=floor_thickness,filled_in=filled_in,wall_thickness=wall_thickness,efficient_floor=efficient_floor,flat_base=flat_base);
      if(IsHelpEnabled("info")) echo("showClippersForSide", floorHeight=floorHeight, floorDepth=floorDepth, baseClearanceHeight=baseClearanceHeight, minFloorHeight=minFloorHeight);
  wallTop = calculateWallTop(num_z, lip_style);
      
  isCutX = description == "depth";
  translate([gf_tolerance/2,wallTop,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize,
        end=0, in=1,
        translate=[0,5,0],
        l=gf_num*gf_pitch-gf_tolerance, 
        txt2 = str("total ", description, " ", gf_num));
    
    translate([gf_tolerance/2+wall_thickness,(1+(num_z-1)/2)*gf_zpitch,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize,
        end=0, in=1,
        l=gf_num*gf_pitch-gf_tolerance-wall_thickness*2, 
        txt2 = str("inner ", description)); 
        
    translate(isCutX
      ?[(gf_num)*gf_pitch,0,0]
      :[0,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, size = fontSize,
        cx=isCutX ? 0: -1, 
        end=0, in=2,
        l=num_z*gf_zpitch, 
        translate=isCutX ? [1,0,0] : [-1,0,0],
        txt2 = str("height ", num_z));
    
    if(lip_style != "none")
    translate(isCutX
      ?[(gf_num)*gf_pitch,num_z*gf_zpitch,0]
      :[0,num_z*gf_zpitch,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, size = fontSize,
        cx=isCutX ? 0: -1, 
        end=0, in=2,
        l=wallTop - (num_z*gf_zpitch),//gf_Lip_Height, 
        translate=isCutX ? [1,0,0] : [-1,0,0],
        txt2 = str("lip height"));
        
     if(lip_style != "none")
     translate(isCutX 
      ?[(gf_num)*gf_pitch,0,0]
      :[0,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, size = fontSize,
        cx=isCutX ? 0: -1,
        end=0, in=2,
        translate=isCutX ? [fontSize*3,0,0] : [fontSize*-3,0,0],
        l=wallTop, 
        txt2 = str("total height"));
    
    if(!flat_base)
    translate(isCutX 
      ? gf_num < 1 ? [gf_num*gf_pitch-1,0,0] : [(floor(gf_num)-1)*gf_pitch-1,0,0]
      : gf_num < 1 ? [1,0,0] : [gf_pitch,0,0])
      Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.75,
        cx=isCutX ? 0 : -1, 
        end=0, in=2,
        translate=isCutX ?[3,0,0]:[-3,0,0],
        l=gridHeight, 
        txt2 = "grid height");

    if(baseClearanceHeight > 0)
    translate(isCutX 
      ? gf_num < 1 ? [1,0,0] : [+gf_pitch*(gf_num-1),0,0]
      : gf_num < 1 ? [gf_num*gf_pitch-1,0,0] : [gf_pitch-1,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.7,
        cx=isCutX ? -1 : 0, 
        end=0, in=2,
        translate=isCutX ?[-2,0,0]:[2,0,0],
        l=baseClearanceHeight, 
        txt2 = "clearance height");

    if(efficient_floor == "off")
    translate(isCutX 
      ? gf_num < 1 ? [1,baseClearanceHeight,0] : [gf_pitch*(gf_num-1),baseClearanceHeight,0]
      : gf_num < 1 ? [gf_num*gf_pitch-1,baseClearanceHeight,0] : [gf_pitch-1,baseClearanceHeight,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.75,
        cx=isCutX ? -1 : 0, 
        end=0, in=2,
        translate=isCutX ?[-2,0,0]:[2,0,0],
        l=floorDepth, 
        txt2 = "floor thickness");

    translate(isCutX
      ? gf_num < 1 ? [gf_pitch*gf_num/2,0,0] : [gf_pitch*(gf_num-1/2),0,0]
      : gf_num < 1 ? [gf_pitch*gf_num/2,0,0] : [gf_pitch/2,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*0.8,
        cx=1, end=0, in=2,
        translate=[0,-floorHeight/2+2,0],
        l=floorHeight, 
        txt2 = "floor height");

    if(screw_depth > 0)
    translate(isCutX
      ? [+gf_pitch*(gf_num)-6,0,0]
      : [10,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.75,
        cx=1, end=0, in=2,
        l=screw_depth, 
        txt2 = "screw");

    if(magnet_depth > 0)
    translate(isCutX 
      ? [+gf_pitch*(gf_num)-10,0,0]
      : [6,0,0])
     Caliper(messpunkt = false, center=false,
        h = 0.1, s = fontSize*.75,
        //translate=[-2,0,0],
        cx=1, end=0, in=2,
        l=magnet_depth, 
        txt2 = "magnet");
}

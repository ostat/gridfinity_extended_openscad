// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
include <module_gridfinity.scad>

iAllowConnectorsFront = 0;
iAllowConnectorsBack = 1;
iAllowConnectorsLeft = 2;
iAllowConnectorsRight = 3;

show_frame_connector_demo = false;
if(show_frame_connector_demo){
  $fn = 64;
  translate([0,0,0]) {
    ClippedWall(fullIntersection = true);
    translate([15,0,0])
    ClipConnector(fullIntersection=true);
    translate([30,0,0])
    ClipCutter(fullIntersection=true);
   }

  translate([0,15,0]) {
    ClippedWall(straightIntersection = true);
    translate([15,0,0])
    ClipConnector(straightIntersection = true);
    translate([30,0,0])
    ClipCutter(straightIntersection = true);
   }

  translate([0,30,0]) {
    ClippedWall(cornerIntersection = true);
    //translate([15,0,0])
    //ClipConnector(cornerIntersection = true);
    translate([30,0,0])
    ClipCutter(cornerIntersection = true);
  }

  translate([0,45,0]) {
    ClippedWall(straightWall = true);
    translate([15,0,0])
    ClipConnector(straightWall = true);
    translate([30,0,0])
    ClipCutter(straightWall = true);
   }
  
  translate([0,-15,0])
  ButterFlyConnector();
  
  translate([0,-30,0])
  wall_snaps_cavity();
  
  translate([10,-30,0])
  wall_snaps_additive();
  
  translate([20,-30,0])
  sample(size = [10,10,4]){
    wall_snaps_cavity(lock_height = 2, style = ConnectorSnapsStyle_larger);
    wall_snaps_additive(lock_height = 2, style = ConnectorSnapsStyle_larger);
  }
  
  translate([20,-50,0])
  sample(size = [10,10,4]){
    wall_snaps_cavity(lock_height = 2, style = ConnectorSnapsStyle_smaller);
    wall_snaps_additive(lock_height = 2, style = ConnectorSnapsStyle_smaller);
  }
  
  translate([20,-70,0])
  sample(size = [15,2,4]){
    wall_snaps_cavity(lock_height = 2, style = ConnectorSnapsStyle_wall);
    wall_snaps_additive(lock_height = 2, style = ConnectorSnapsStyle_wall);
  }
  
  difference(){
    union(){
    
      translate([-5,0,0])
      cube([10,10,2]);
      
      rotate([0,0,180])
      wall_snaps_additive();
    }
    
    wall_snaps_cavity();
  }
 
}

module sample(
  size = [10,10,2]){
  
  difference(){
    union(){
    
      translate([-size.x/2,0,0])
      cube(size);
      
      if($children >=2) {
        rotate([0,0,180])
        children(1);
      }
    }
  
    if($children >=1) children(0); 
  }
}

iFrameConnectors_ConnectorOnly=0;
iFrameConnectors_Position=1;

iFrameConnectors_ClipEnabled=2;
iFrameConnectors_ClipSize=3;
iFrameConnectors_ClipTolerance=4;

iFrameConnectors_ButterflyEnabled=5;
iFrameConnectors_ButterflySize=6;
iFrameConnectors_ButterflyRadius=7;
iFrameConnectors_ButterflyTolerance=8;

iFrameConnectors_FilamentEnabled=9;
iFrameConnectors_FilamentDiameter=10;
iFrameConnectors_FilamentLength=11;

iFrameConnectors_SnapsStyle=12;
iFrameConnectors_SnapsClearance=13;

FrameConnectorsPosition_centerwall = "center_wall";
FrameConnectorsPosition_intersection = "intersection";
FrameConnectorsPosition_both = "both";

FrameConnectorsPosition_values = [FrameConnectorsPosition_centerwall, FrameConnectorsPosition_intersection, FrameConnectorsPosition_both];
function validateFrameConnectorsPosition(value) = 
  assert(list_contains(FrameConnectorsPosition_values, value), typeerror("FrameConnectorsPosition", value))
  value;

ConnectorSnapsStyle_disabled = "disabled";
ConnectorSnapsStyle_larger = "larger";
ConnectorSnapsStyle_smaller = "smaller";
ConnectorSnapsStyle_wall = "wall";
ConnectorSnapsStyle_values = [ConnectorSnapsStyle_disabled,ConnectorSnapsStyle_larger,ConnectorSnapsStyle_smaller, ConnectorSnapsStyle_wall];
function validateConnectorSnapsStyle(value) = 
  assert(list_contains(ConnectorSnapsStyle_values, value), typeerror("ConnectorSnapsStyle", value))
  value;

function FrameConnectorSettings(
  connectorOnly = false, 
  connectorPosition = FrameConnectorsPosition_centerwall, 
  
  connectorClipEnabled = false,
  connectorClipSize = 10,
  connectorClipTolerance = 0.1, 
  
  connectorButterflyEnabled = false,
  connectorButterflySize = [5,4,1.5],
  connectorButterflyRadius = 0.1,
  connectorButterflyTolerance = 0.1,

  connectorFilamentEnabled = false,
  connectorFilamentDiameter = 2,
  connectorFilamentLength = 8,

  connectorSnapsStyle = ConnectorSnapsStyle_disabled,
  connectorSnapsClearance = 0.5) =  
  let(
    result = [
      connectorOnly,
      connectorPosition,
      connectorClipEnabled,
      connectorClipSize,
      connectorClipTolerance,
      connectorButterflyEnabled,
      connectorButterflySize,
      connectorButterflyRadius,
      connectorButterflyTolerance,
      connectorFilamentEnabled,
      connectorFilamentDiameter,
      connectorFilamentLength,
      connectorSnapsStyle,
      connectorSnapsClearance
      ],
    validatedResult = ValidateFrameConnectorSettings(result)
  ) validatedResult;

function ValidateFrameConnectorSettings(settings) =
  assert(is_list(settings), "FrameConnector Settings must be a list")
  assert(len(settings)==14, "FrameConnector Settings must length 14")
  
    [settings[iFrameConnectors_ConnectorOnly],
      validateFrameConnectorsPosition(settings[iFrameConnectors_Position]),
      settings[iFrameConnectors_ClipEnabled],
      settings[iFrameConnectors_ClipSize],
      settings[iFrameConnectors_ClipTolerance],
      settings[iFrameConnectors_ButterflyEnabled],
      settings[iFrameConnectors_ButterflySize],
      settings[iFrameConnectors_ButterflyRadius],
      settings[iFrameConnectors_ButterflyTolerance],
      settings[iFrameConnectors_FilamentEnabled],
      settings[iFrameConnectors_FilamentDiameter],
      settings[iFrameConnectors_FilamentLength],
      validateConnectorSnapsStyle(settings[iFrameConnectors_SnapsStyle]),
      settings[iFrameConnectors_SnapsClearance]];
      

module wall_snaps_additive(
lock_height = 2,
clearance = 0,
hollow = 0.75,
style = ConnectorSnapsStyle_larger) {
  linear_extrude(height=lock_height+clearance*2)
  difference(){
    wall_snaps(lock_height = lock_height, style = style);
    
    offset(r=-hollow)
    wall_snaps(lock_height = lock_height, style = style);
  }
}


module wall_snaps_cavity(
  lock_height = 2,
  clearance = 0.2,
  style = ConnectorSnapsStyle_larger) {
  fudge_factor = 0.01;
  translate([0,0,-clearance])
  linear_extrude(height=lock_height+clearance*2)
  union(){
    wall_snaps(
      lock_height = lock_height,
      clearance = clearance,
      style = style);

    translate([1.25,0])
    rotate(45)
    square([1.5,1.5], center=true);
  }
}


module wall_snaps(
lock_height = 2,
clearance = 0,
style = ConnectorSnapsStyle_larger) {
  fudge_factor = 0.01;
 
  if(style == ConnectorSnapsStyle_larger){
    base_width = 1.5;
    long_nub_size = 2;
    long_nub_position = [-0.5,2.5]; 
    short_nub = 1;
    short_nub_position = [1.1,1.5];
    base_size = [base_width, 0.1];

    hull(){
      translate([0, -fudge_factor])
      square(base_size);
      
      translate(long_nub_position)
      circle(d=long_nub_size+clearance);
      
      translate(short_nub_position)
      circle(d=short_nub);
    }
  } else if (style == ConnectorSnapsStyle_smaller) {
    base_width = 1.5;
    long_nub_size = 2;
    long_nub_position = [0.5,1.5]; 
    short_nub = 1;
    short_nub_position = [1.1,1.5];
    base_size = [base_width, 0.1];
    
    hull(){
      translate([0, -fudge_factor])
      square(base_size);
      
      translate(long_nub_position)
      circle(d=long_nub_size+clearance);
      
      translate(short_nub_position)
      circle(d=short_nub);
    }
  } else if (style == ConnectorSnapsStyle_wall) {
    base_width = 1.5;
    long_nub_size = 2;
    long_nub_position = [0.5,1]; 
    short_nub = 1.5;
    short_nub_position = [0.95,1];
    base_size = [base_width, 0.1];
    
    hull(){
      translate([0, -fudge_factor])
      square(base_size);
      
      translate(long_nub_position)
      circle(d=long_nub_size+clearance);
      
      translate(short_nub_position)
      circle(d=short_nub);
    }
  }
}

module frame_connector_cavities(
  width = 1, 
  depth = 1,
  frameConnectorSettings = []) {

  assert(is_list(frameConnectorSettings), "frameConnectorSettings must be a list");
  
  connectorPosition = frameConnectorSettings[iFrameConnectors_Position];
  connectorClipEnabled = frameConnectorSettings[iFrameConnectors_ClipEnabled];
  connectorClipSize = frameConnectorSettings[iFrameConnectors_ClipSize];
  connectorClipTolerance = frameConnectorSettings[iFrameConnectors_ClipTolerance];
  connectorButterflyEnabled = frameConnectorSettings[iFrameConnectors_ButterflyEnabled];
  connectorButterflySize = frameConnectorSettings[iFrameConnectors_ButterflySize];
  connectorButterflyRadius = frameConnectorSettings[iFrameConnectors_ButterflyRadius];
  connectorButterflyTolerance = frameConnectorSettings[iFrameConnectors_ButterflyTolerance];
  connectorSnapsStyle = frameConnectorSettings[iFrameConnectors_SnapsStyle];
  connectorSnapsClearance = frameConnectorSettings[iFrameConnectors_SnapsClearance];
  connectorFilamentEnabled = frameConnectorSettings[iFrameConnectors_FilamentEnabled];
  connectorFilamentLength = frameConnectorSettings[iFrameConnectors_FilamentLength];
  connectorFilamentDiameter = frameConnectorSettings[iFrameConnectors_FilamentDiameter];

  if(connectorButterflyEnabled || connectorFilamentEnabled || connectorClipEnabled || connectorSnapsStyle != ConnectorSnapsStyle_disabled){
    union(){
      if(env_help_enabled("debug")) echo("frame_connector_cavities", gci=$gci, gc_size=$gc_size, gc_is_corner=$gc_is_corner, gc_position=$gc_position, width=width, depth=depth, connectorButterflyEnabled  = connectorButterflyEnabled, connectorFilamentEnabled = connectorFilamentEnabled, connectorClipEnabled = connectorClipEnabled, connectorSnapsStyle = connectorSnapsStyle);
        
      if(connectorPosition == "center_wall" || connectorPosition == "both")
      PositionCellCenterConnector(
        left=$gci.x==0&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsLeft],
        right=$gci.x>=$gc_count.x-1&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsRight],
        front=$gci.y==0&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsFront],
        back=$gci.y>=$gc_count.y-1&&$gc_size.x==1&&$gc_size.y==1&& $allowConnectors[iAllowConnectorsBack]) {
          if($preview)
            *rotate([0,0,90])
            cylinder_printable(h=10,r=1);

          if(connectorClipEnabled)
            ClipCutter(size=connectorClipSize, 
              height= 0.8, //height of bevel1_top
              frameHeight = 4,
              clearance = connectorClipTolerance,
              cornerRadius = env_corner_radius(),
              straightWall=true);
        
          if(connectorButterflyEnabled)
            translate([0,0,-$frameBaseHeight])
            rotate([0,0,90])
            ButterFlyConnector(
              size=connectorButterflySize,
              r=connectorButterflyRadius,
              clearance = connectorButterflyTolerance,
              taper=false,half=false);

          if(connectorFilamentEnabled)
            translate([0,0,-$frameBaseHeight/2])
            FilamentCutter(
              l=connectorFilamentLength,
              d=connectorFilamentDiameter);
          
          if(connectorSnapsStyle != ConnectorSnapsStyle_disabled)
            translate([0,0,-$frameBaseHeight])
            rotate([0,0,270])
            wall_snaps_cavity(
              lock_height = 2,
              clearance = connectorSnapsClearance,
              style = ConnectorSnapsStyle_wall);
          }

        if(connectorPosition == "intersection" || connectorPosition == "both")
        PositionCellCornerConnector(
        left=$gci.x==0&&$gc_size.x==1&&$gc_size.y==1,
        right=$gci.x>=$gc_count.x-1 && $gc_size.x==1&&$gc_size.y==1,
        front=$gci.y==0&&$gc_size.x==1&&$gc_size.y==1,
        back=$gci.y>=$gc_count.y-1&&$gc_size.x==1&&$gc_size.y==1) {
       
          if($preview)
            *rotate([0,0,90])
            cylinder_printable(h=$corner ? 20 : 15,r=2);

          if(connectorClipEnabled)
            rotate([0,0,270])
            ClipCutter(size=connectorClipSize, 
              height= 0.8, //height of bevel1_top
              frameHeight = 4,
              clearance = connectorButterflyTolerance,
              cornerRadius = env_corner_radius(),
              straightIntersection = !$corner,
              cornerIntersection = $corner);
        
          if(connectorButterflyEnabled && !$corner)
            translate([0,0,-$frameBaseHeight])
            rotate([0,0,90])
            ButterFlyConnector(
              size=connectorButterflySize,
              r=connectorButterflyRadius,
              clearance = connectorButterflyTolerance,
              taper=false,half=false);

         if(connectorSnapsStyle != ConnectorSnapsStyle_disabled && !$corner)
            translate([0,0,-$frameBaseHeight])
            rotate([0,0,270])
            wall_snaps_cavity(
              lock_height = 2,
              clearance = connectorSnapsClearance,
              style = connectorSnapsStyle);
  
          if(connectorFilamentEnabled && !$corner)
            translate([0,0,-$frameBaseHeight/2])
            FilamentCutter(
              l=connectorFilamentLength,
              d=connectorFilamentDiameter);
        }
    }
  }
}

module frame_connectors_additives(
  width = 1, 
  depth = 1,
  frameConnectorSettings = []) {

  assert(is_list(frameConnectorSettings), "frameConnectorSettings must be a list");
  
  connectorPosition = frameConnectorSettings[iFrameConnectors_Position];
  connectorClipEnabled = frameConnectorSettings[iFrameConnectors_ClipEnabled];
  connectorClipSize = frameConnectorSettings[iFrameConnectors_ClipSize];
  connectorClipTolerance = frameConnectorSettings[iFrameConnectors_ClipTolerance];
  connectorButterflyEnabled = frameConnectorSettings[iFrameConnectors_ButterflyEnabled];
  connectorButterflySize = frameConnectorSettings[iFrameConnectors_ButterflySize];
  connectorButterflyRadius = frameConnectorSettings[iFrameConnectors_ButterflyRadius];
  connectorButterflyTolerance = frameConnectorSettings[iFrameConnectors_ButterflyTolerance];
  connectorSnapsStyle = frameConnectorSettings[iFrameConnectors_SnapsStyle];
  connectorSnapsClearance = frameConnectorSettings[iFrameConnectors_SnapsClearance];
  connectorFilamentEnabled = frameConnectorSettings[iFrameConnectors_FilamentEnabled];
  connectorFilamentLength = frameConnectorSettings[iFrameConnectors_FilamentLength];
  connectorFilamentDiameter = frameConnectorSettings[iFrameConnectors_FilamentDiameter];

  if(connectorButterflyEnabled || connectorFilamentEnabled || connectorClipEnabled || connectorSnapsStyle != ConnectorSnapsStyle_disabled){
    union(){
      if(env_help_enabled("debug")) echo("frame_connectors_additives", gci=$gci, gc_size=$gc_size, gc_is_corner=$gc_is_corner, gc_position=$gc_position, width=width, depth=depth, connectorButterflyEnabled  = connectorButterflyEnabled, connectorFilamentEnabled = connectorFilamentEnabled, connectorClipEnabled = connectorClipEnabled, connectorSnapsStyle = connectorSnapsStyle);

      if(connectorPosition == "center_wall" || connectorPosition == "both")
      PositionCellCenterConnector(
      left=$gci.x==0&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsLeft],
      right=$gci.x>=$gc_count.x-1&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsRight],
      front=$gci.y==0&&$gc_size.x==1&&$gc_size.y==1 && $allowConnectors[iAllowConnectorsFront],
      back=$gci.y>=$gc_count.y-1&&$gc_size.x==1&&$gc_size.y==1&& $allowConnectors[iAllowConnectorsBack]) {
        
        if(connectorSnapsStyle != ConnectorSnapsStyle_disabled)
          #translate([0,0,-$frameBaseHeight])
          rotate([0,0,90])
          wall_snaps_additive(
            lock_height = 2,
            clearance = connectorSnapsClearance,
            style = ConnectorSnapsStyle_wall);
      }

          
      if(connectorPosition == "intersection" || connectorPosition == "both")
      PositionCellCornerConnector(
      left=$gci.x==0&&$gc_size.x==1&&$gc_size.y==1,
      right=$gci.x>=$gc_count.x-1 && $gc_size.x==1&&$gc_size.y==1,
      front=$gci.y==0&&$gc_size.x==1&&$gc_size.y==1,
      back=$gci.y>=$gc_count.y-1&&$gc_size.x==1&&$gc_size.y==1) {
   
       if(connectorSnapsStyle != ConnectorSnapsStyle_disabled && !$corner)
          translate([0,0,-$frameBaseHeight])
          rotate([0,0,90])
          wall_snaps_additive(
            lock_height = 2,
            style = connectorSnapsStyle);
      }
    }
  }
}

module PositionCellCenterConnector(left, right,front,back){
    if(left)
      translate([0,env_pitch().y/2,0])
      children();
    if(right)
      translate([env_pitch().x,env_pitch().y/2,0])
      rotate([0,0,180])
      children();
    if(front)
      translate([env_pitch().x/2,0,0])
      rotate([0,0,90])
      children();
    if(back)
      translate([env_pitch().x/2,env_pitch().y,0])
      rotate([0,0,270])
      children();
}

module PositionCellCornerConnector(left, right, front, back){
  if(left || right || front || back)
  {
    if(left && front) {
      if($allowConnectors[iAllowConnectorsLeft] && $allowConnectors[iAllowConnectorsFront])
        let($corner = true)
        rotate([0,0,90])
        children();

      let($corner = false){
        if($allowConnectors[iAllowConnectorsFront])
        translate([env_pitch().x,0,0])
        rotate([0,0,90])
        children();
        
        if($allowConnectors[iAllowConnectorsLeft])
        translate([0,env_pitch().y,0])
        children();
      }
    }

    if(left && back) {
      if($allowConnectors[iAllowConnectorsLeft] && $allowConnectors[iAllowConnectorsBack])
        let($corner = true)
        translate([0,env_pitch().y,0])
        children();

      let($corner = false) {
        if($allowConnectors[iAllowConnectorsLeft])
        children();
        
        if($allowConnectors[iAllowConnectorsBack])
        translate([env_pitch().x,env_pitch().y,0])
        rotate([0,0,270])
        children();
      }
    }

    if(right && front){
      if($allowConnectors[iAllowConnectorsRight] && $allowConnectors[iAllowConnectorsFront])
        let($corner = true)
        translate([env_pitch().x,0,0])
        rotate([0,0,180])
        children();

      let($corner = false) {
        if($allowConnectors[iAllowConnectorsFront])
        rotate([0,0,90])
        children();
        
        if($allowConnectors[iAllowConnectorsRight])
        translate([env_pitch().x,env_pitch().y,0])
        rotate([0,0,180])
        children();
      }
    }

    if(right && back){
      if($allowConnectors[iAllowConnectorsRight] && $allowConnectors[iAllowConnectorsBack])
        let($corner = true)
        translate([env_pitch().x,env_pitch().y,0])
        rotate([0,0,270])
        children();

      let($corner = false) {
        if($allowConnectors[iAllowConnectorsRight])
        translate([env_pitch().x,0,0])
        rotate([0,0,180])
        children();

        if($allowConnectors[iAllowConnectorsBack])
        translate([0,env_pitch().y,0])
        rotate([0,0,270])
        children();
      }
    }

    if(left && !back && !front && !front && $gci.y<=$gc_count.y-3 && $allowConnectors[iAllowConnectorsLeft]){
      $corner = false;
      translate([0,env_pitch().y,0])
      children();
    }
    if(front && !left && !right && $gci.x<=$gc_count.x-3 && $allowConnectors[iAllowConnectorsFront]){
      $corner = false;
      translate([env_pitch().x,0,0])
      rotate([0,0,90])
      children();
    }
    if(right && !back && !front && $gci.y<=$gc_count.y-3 && $allowConnectors[iAllowConnectorsRight]){
      $corner = false;
      translate([env_pitch().x,env_pitch().y,0])
      rotate([0,0,180])
      children();
    }

    if(back && !left && !right && $gci.x<=$gc_count.x-3 && $allowConnectors[iAllowConnectorsBack]){
      $corner = false;
      translate([env_pitch().x,env_pitch().y,0])
      rotate([0,0,270])
      children();
    }
  }
}

module FilamentCutter(
    l = 5, 
    d = 1.75){
  translate([-fudgeFactor, 0,0])
  rotate([90,0,90])
  cylinder_printable(h=l,d=d);
}

module cylinder_printable(h=10,r=1,d,center=false){
  r = is_num(d) ? d/2 : r;
  d=2*r;

  flat_top_width = d/2.5;
  flat_top_height = d/2+0.5;

  translate(center ? [0,0,0] : [0,0,h/2])
  hull(){
    //Printable Cylinder
    cylinder(h=h,d=d, center=true);
    translate([-flat_top_width/2,d/2-flat_top_height,-h/2])
      cube([flat_top_width,flat_top_height,h]); 
  }
}

//What is to be removed from the baseplate, to make room for the corner clip
module ClipCutter(
  size=10, 
  height= 0.8, //height of bevel1_top
  frameHeight = 4,
  clippedWallThickness = 2,
  clippedWallHeight = 1.6,
  clearance = 0.1,
  cornerRadius = gf_cup_corner_radius,
  straightWall = false,
  straightIntersection = false,
  cornerIntersection = false,
  fullIntersection = false){

  height = height-clearance/2;
  translate([0,0,height+fudgeFactor])
  difference(){
    if(straightIntersection) {
      translate([-size/2-clearance,-fudgeFactor,0])
        cube(size=[size+clearance*2,size/2+clearance+fudgeFactor,frameHeight-height+fudgeFactor]);
    } else if(cornerIntersection) {
      translate([-fudgeFactor,-fudgeFactor,0])
        cube(size=[size/2+fudgeFactor+clearance,size/2+clearance+fudgeFactor,frameHeight-height+fudgeFactor]);
    } else {
      translate([-size/2-clearance,-size/2-clearance,0])
        cube(size=[size+clearance*2,size+clearance*2,frameHeight-height+fudgeFactor]);
    }
    //clipped inner wall
    translate([0,0,-fudgeFactor])
    ClippedWall(
      clipSize=size+clearance*2, 
      cornerRadius = cornerRadius,
      clippedWallThickness = clippedWallThickness,
      clippedWallHeight = clippedWallHeight-clearance,
      straightWall = straightWall,
      straightIntersection = straightIntersection,
      cornerIntersection = cornerIntersection,
      fullIntersection = fullIntersection);
  }
}

module ClipConnector(
  size=10, 
  height= 0.8, //height of bevel1_top
  frameHeight = 4,
  clippedWallThickness = 2,
  clippedWallHeight = 1.6,
  clearance = 0.1,
  cornerRadius = gf_cup_corner_radius,
  straightWall = false,
  straightIntersection = false,
  fullIntersection = false){
 
  render()
  difference(){
    translate([
        -size/2,
        straightIntersection ? 0 : -size/2,
        0])
      cube(size=[size,
          straightIntersection ? size/2 : size,
          frameHeight-height]);

    if(!straightWall) {
      translate([-env_pitch().x,-env_pitch().y,-height])
        frame_cavity(
          num_x=2, 
          num_y=2);
    } else {
      translate([-env_pitch().x,-env_pitch().y/2,-height])
        frame_cavity(
          num_x=2, 
          num_y=1);
    }

    //clipped inner wall
    translate([0,0,-fudgeFactor])
    ClippedWall(
      clipSize=size, 
      cornerRadius = cornerRadius,
      clippedWallThickness = clippedWallThickness+clearance,
      clippedWallHeight = clippedWallHeight+clearance,
      straightWall = straightWall,
      straightIntersection = straightIntersection,
      fullIntersection = fullIntersection);
  }
}

//The wall that is ls left once the clip shape is removed
module ClippedWall(
  clipSize=10, 
  cornerRadius = gf_cup_corner_radius,
  clippedWallHeight = 2,
  clippedWallThickness = 1,
  frameWallHeight = 1.6,
  straightWall = false,
  straightIntersection = false,
  cornerIntersection = false,
  fullIntersection = false){
  corners = straightWall ? 0 
    : cornerIntersection ? 1 
    : straightIntersection ? 2 
    : 4;
  
    height = clippedWallHeight+fudgeFactor;
    clipRadius = cornerRadius - clippedWallThickness/2;

    xlength = straightWall ? 0
      : cornerIntersection ? clipSize/2+fudgeFactor
      : clipSize+fudgeFactor*2;

    ylength = cornerIntersection  || straightIntersection? clipSize/2+fudgeFactor
      : clipSize+fudgeFactor*2;

    union(){
      rotate([0,0,180])
      translate([-clippedWallThickness/2,-clipSize/2-fudgeFactor,0])
        cube(size=[clippedWallThickness,ylength,height]);
      rotate([0,0,180])
      translate([-clipSize/2-fudgeFactor,-clippedWallThickness/2,0])
        cube(size=[xlength,clippedWallThickness,height]);
    }

    if(corners > 0)
    difference(){
      if(cornerIntersection){
        translate([-(+clippedWallThickness)/2,-(clippedWallThickness)/2,0])
          cube(size=[clipRadius+clippedWallThickness,clipRadius+clippedWallThickness,height]);
      } else if (straightIntersection){
        translate([-(clipRadius*2+clippedWallThickness)/2,-(clippedWallThickness)/2,0])
          cube(size=[clipRadius*2+clippedWallThickness,clipRadius+clippedWallThickness,height]);
      } else {
        translate([-(clipRadius*2+clippedWallThickness)/2,-(clipRadius*2+clippedWallThickness)/2,0])
          cube(size=[clipRadius*2+clippedWallThickness,clipRadius*2+clippedWallThickness,height]);
      }
      for(i=[0:1:corners-1]){
        rotate([0,0,i*90])
        translate([clippedWallThickness/2+clipRadius,clippedWallThickness/2+clipRadius,-fudgeFactor])
          cylinder(r=clipRadius,h=height+fudgeFactor*2);
      }
  }
}


module ButterFlyConnector(
  size = [5,3,2],
  r = 0.5,
  clearance = 0,
  taper=false,
  half=false)
  {
  h = taper ? size.y/2+size.z : size.z;
  //render()
  intersection(){
    positions = [
      [-(size.x/2-r), size.y/2-r, h/2],
      [size.x/2-r, size.y/2-r, h/2],
      [0, -(size.y/2-r), h/2]];
    
    union()
    for(ri = [0:half?0:1]){
      mirror([0,1,0]*ri)
      hull(){
        for(pi = [0:len(positions)-1]){
          translate(positions[pi])
            cylinder(h=h,r=r,center=true);
        }
      }
    }
    
    if(taper)
    rotate([0,90,0])
    cylinder(h=size.x,r=size.y/2+size.z,$fn=4,center=true);
  }
}
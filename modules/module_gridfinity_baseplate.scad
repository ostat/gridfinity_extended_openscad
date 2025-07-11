// include instead of use, so we get the pitch
include <gridfinity_constants.scad>
use <module_gridfinity_block.scad>
use <module_gridfinity_baseplate_common.scad>
use <module_gridfinity_baseplate_regular.scad>
use <module_gridfinity_baseplate_cnclaser.scad>
use <module_gridfinity_frame_connectors.scad>

/* [BasePlate] */
// Plate Style
Default_Base_Plate_Options = "default";//[default:Default, cnc:CNC or Laser]
Default_Oversize_method = "fill"; //[crop, fill]

// Magnet
// Enable magnets
Default_Enable_Magnets = true;
//size of magnet, diameter and height. Zacks original used 6.5 and 2.4 
Default_Magnet_Size = [6.5, 2.4];  // .1

/* [Base Plate Clips - POC dont use yet]*/
Default_Connector_Position = "center_wall";
Default_Connector_Clip_Enabled = false;
Default_Connector_Clip_Size = 10;
Default_Connector_Clip_Tolerance = 0.1;

//This feature is not yet finalised, or working properly. 
Default_Connector_Butterfly_Enabled = false;
Default_Connector_Butterfly_Size = [6,6,1.5];
Default_Connector_Butterfly_Radius = 0.1;
Default_Connector_Butterfly_Tolerance = 0.1;

//This feature is not yet finalised, or working properly. 
Default_Connector_Filament_Enabled = false;
Default_Connector_Filament_Diameter = 2;
Default_Connector_Filament_Length = 8;

module gridfinity_baseplate(
  num_x = 2,
  num_y = 3,
  outer_num_x = 0,
  outer_num_y = 0,
  outer_height = 0,
  position_fill_grid_x = "near",
  position_fill_grid_y = "near",
  position_grid_in_outer_x = "center",
  position_grid_in_outer_y = "center",
  plate_corner_radius=gf_cup_corner_radius,
  magnetSize = Default_Magnet_Size,
  magnetZOffset=0,
  magnetTopCover=0,
  reducedWallHeight = -1,
  reduceWallTaper = false,
  cornerScrewEnabled  = false,
  centerScrewEnabled = false,
  weightedEnable = false,
  oversizeMethod = Default_Oversize_method,
  plateOptions = Default_Base_Plate_Options,
  customGridEnabled = false,
  gridPositions = [[1]],
  connectorPosition = Default_Connector_Position,
  connectorClipEnabled  = Default_Connector_Clip_Enabled,
  connectorClipSize = Default_Connector_Clip_Size,
  connectorClipTolerance = Default_Connector_Clip_Tolerance,
  connectorButterflyEnabled  = Default_Connector_Butterfly_Enabled,
  connectorButterflySize = Default_Connector_Butterfly_Size,
  connectorButterflyRadius = Default_Connector_Butterfly_Radius,
  connectorButterflyTolerance = Default_Connector_Butterfly_Tolerance,
  connectorFilamentEnabled = Default_Connector_Filament_Enabled,
  connectorFilamentDiameter = Default_Connector_Filament_Diameter,
  connectorFilamentLength = Default_Connector_Filament_Length)
{
  _gridPositions = customGridEnabled ? gridPositions : [[1]];
  
  outer_width = oversizeMethod == "outer" ? max(num_x, outer_num_x) : outer_num_x;
  outer_depth = oversizeMethod == "outer" ? max(num_y, outer_num_y) : outer_num_y;
  
  width = 
    oversizeMethod == "crop" ? ceil(num_x)
    : oversizeMethod == "outer" ? floor(num_x)
    : num_x ;
  depth = 
    oversizeMethod == "crop" ? ceil(num_y)
    : oversizeMethod == "outer" ? floor(num_y)
    : num_y;

    debug_cut()
    intersection(){
      union() {
        for(xi = [0:len(_gridPositions)-1])
          for(yi = [0:len(_gridPositions[xi])-1])
          {
            if(is_list(_gridPositions[xi][yi])){
              assert(is_num(_gridPositions[xi][yi][0]));
              assert(is_list(_gridPositions[xi][yi][1]));
            }
            gridPosCorners = is_list(_gridPositions[xi][yi]) ? _gridPositions[xi][yi][0] : _gridPositions[xi][yi];
            gridPosx = is_list(_gridPositions[xi][yi]) ? _gridPositions[xi][yi][1].x : 1;
            gridPosy = is_list(_gridPositions[xi][yi]) ? _gridPositions[xi][yi][1].y : 1;
              
            if(_gridPositions[xi][yi])
            {
              let($pitch = [env_pitch().x*gridPosx, env_pitch().y*gridPosy, env_pitch().y])
              translate([env_pitch().x*xi/gridPosx,env_pitch().y*yi/gridPosy,0])
              baseplate(
                width = customGridEnabled ? 1 : width,
                depth = customGridEnabled ? 1 : depth,
                outer_width = outer_width,
                outer_depth = outer_depth,
                outer_height = outer_height,
                position_fill_grid_x = position_fill_grid_x,
                position_fill_grid_y = position_fill_grid_y,
                position_grid_in_outer_x = position_grid_in_outer_x,
                position_grid_in_outer_y = position_grid_in_outer_y,
                magnetSize = magnetSize,
                magnetZOffset=magnetZOffset,
                magnetTopCover=magnetTopCover,
                reducedWallHeight = reducedWallHeight,
                reduceWallTaper = reduceWallTaper,
                cornerScrewEnabled = cornerScrewEnabled,
                centerScrewEnabled = centerScrewEnabled,
                weightedEnable = weightedEnable,
                plateOptions= plateOptions,
                connectorPosition = connectorPosition,
                connectorClipEnabled = connectorClipEnabled,
                connectorClipSize = connectorClipSize,
                connectorClipTolerance = connectorClipTolerance,
                connectorButterflyEnabled = connectorButterflyEnabled,
                connectorButterflySize = connectorButterflySize,
                connectorButterflyRadius = connectorButterflyRadius,
                connectorButterflyTolerance = connectorButterflyTolerance,
                connectorFilamentEnabled = connectorFilamentEnabled,
                connectorFilamentDiameter = connectorFilamentDiameter,
                connectorFilamentLength = connectorFilamentLength,
                plate_corner_radius = plate_corner_radius,
                roundedCorners = gridPosCorners == 1 ? 15 : gridPosCorners - 2);
            }
          }
        }
        if(oversizeMethod == "crop")
          cube([num_x*env_pitch().x, num_y*env_pitch().y,20]);
    }
}

module baseplate(
  width = 2,
  depth = 1,
  outer_width = 0,
  outer_depth = 0,
  outer_height = 0,
  position_fill_grid_x = "near",
  position_fill_grid_y = "near",
  position_grid_in_outer_x = "center",
  position_grid_in_outer_y = "center",
  magnetSize = [gf_baseplate_magnet_od,gf_baseplate_magnet_thickness],
  magnetZOffset=0,
  magnetTopCover=0,
  reducedWallHeight = -1,
  reduceWallTaper = false,
  cornerScrewEnabled = false,
  centerScrewEnabled = false,
  weightedEnable = false,
  plateOptions = "default",
  plate_corner_radius = gf_cup_corner_radius,
  roundedCorners = 15,
  connectorPosition = Default_Connector_Position,
  connectorClipEnabled  = Default_Connector_Clip_Enabled,
  connectorClipSize = Default_Connector_Clip_Size,
  connectorClipTolerance = Default_Connector_Clip_Tolerance,
  connectorButterflyEnabled  = Default_Connector_Butterfly_Enabled,
  connectorButterflySize = Default_Connector_Butterfly_Size,
  connectorButterflyRadius = Default_Connector_Butterfly_Radius,
  connectorButterflyTolerance = Default_Connector_Butterfly_Tolerance,
  connectorFilamentEnabled = Default_Connector_Filament_Enabled,
  connectorFilamentDiameter = Default_Connector_Filament_Diameter,
  connectorFilamentLength = Default_Connector_Filament_Length)
{
  assert_openscad_version();
  
  difference(){
    union(){
      if (plateOptions == "cnclaser"){
        baseplate_cnclaser(
          num_x=width, 
          num_y=depth,
          magnetSize=magnetSize, 
          magnetZOffset=magnetZOffset,
          roundedCorners=roundedCorners);
      }      
      else {
        baseplate_regular(
          grid_num_x = width, 
          grid_num_y = depth,
          outer_num_x = outer_width,
          outer_num_y = outer_depth,
          outer_height = outer_height,
          position_fill_grid_x = position_fill_grid_x,
          position_fill_grid_y = position_fill_grid_y,
          position_grid_in_outer_x = position_grid_in_outer_x,
          position_grid_in_outer_y = position_grid_in_outer_y,
          magnetSize = magnetSize,
          magnetZOffset=magnetZOffset,
          magnetTopCover=magnetTopCover,
          reducedWallHeight=reducedWallHeight,
          reduceWallTaper=reduceWallTaper,
          centerScrewEnabled = centerScrewEnabled,
          cornerScrewEnabled = cornerScrewEnabled,
          weightHolder = weightedEnable,
          cornerRadius = plate_corner_radius,
          roundedCorners=roundedCorners)
          frame_connectors(
            width = width, 
            depth = depth,
            connectorPosition = connectorPosition,
            connectorClipEnabled = connectorClipEnabled,
            connectorClipSize = connectorClipSize,
            connectorClipTolerance = connectorClipTolerance,
            connectorButterflyEnabled = connectorButterflyEnabled,
            connectorButterflySize = connectorButterflySize,
            connectorButterflyRadius = connectorButterflyRadius,
            connectorButterflyTolerance = connectorButterflyTolerance,
            connectorFilamentEnabled = connectorFilamentEnabled,
            connectorFilamentLength = connectorFilamentLength,
            connectorFilamentDiameter = connectorFilamentDiameter);
      }
    }
  }
}
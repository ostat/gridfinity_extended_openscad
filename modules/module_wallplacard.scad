iwallplacardconfig_walls = 0;
iwallplacardconfig_style = 1;
iwallplacardconfig_size = 2;
iwallplacardconfig_offset = 3;
iwallplacardconfig_slot_frame = 4;
iwallplacardconfig_corner_radius = 5;

iwallplacardconfig_size_width = 0;
iwallplacardconfig_size_height = 1;
iwallplacardconfig_size_depth = 2;

iwallplacardconfig_offset_horiz = 0;
iwallplacardconfig_offset_vert = 1;
iwallplacardconfig_offset_depth = 2;

iwallplacardconfig_slot_frame_reveal = 0;
iwallplacardconfig_slot_frame_coverage = 1;
iwallplacardconfig_slot_frame_width = 2;
iwallplacardconfig_slot_frame_depth = 3;

function WallplacardSettings(
    walls,
    style, 
    size, 
    offset,
    slot_frame,
    corner_radius) = 
  let(
    result = [
      walls,
      style,
      size,
      offset,
      slot_frame,
      corner_radius],
    validatedResult = ValidateWallplacardSettings(result)
  ) validatedResult;

function ValidateWallplacardSettings(settings) =
  assert(is_list(settings), "Wall placard settings must be a list")
  assert(len(settings)==6, "Wall placard settings must have length 6")
  assert(is_string(settings[iwallplacardconfig_style]), "Wall placard style must be a string")
  assert(is_list(settings[iwallplacardconfig_walls]), "Wall placard walls must be a list")
  assert(is_list(settings[iwallplacardconfig_size]), "Wall placard size must be a list")
  assert(is_list(settings[iwallplacardconfig_offset]), "Wall placard offset must be a list")
  assert(is_list(settings[iwallplacardconfig_slot_frame]), "Wall placard slot frame must be a list")
  assert(is_num(settings[iwallplacardconfig_corner_radius]), "Wall placard corner radius must be a number")
  [
    settings[iwallplacardconfig_walls],
    settings[iwallplacardconfig_style],
    settings[iwallplacardconfig_size],
    settings[iwallplacardconfig_offset],
    settings[iwallplacardconfig_slot_frame],
    settings[iwallplacardconfig_corner_radius]
  ];

function calculateWallplacards(
  wall_width_fb,
  wall_width_lr,
  wall_height,
  wall_thickness,
  wallplacard_settings) =
    let(wallplacard_walls = wallplacard_settings[iwallplacardconfig_walls],
        wallplacard_style = wallplacard_settings[iwallplacardconfig_style])
    [for (i = [0:len(wallplacard_walls)-1])
      calculateWallplacard(
        wall_width = (i==0 || i==1) ? wall_width_fb : wall_width_lr,
        wall_height = wall_height,
        wall_thickness = wall_thickness,
        wall_wall = wallplacard_walls[i],
        wallplacard_settings = wallplacard_settings)];

function calculateWallplacard(
  wall_width,
  wall_height,
  wall_thickness,
  wall_wall,
  wallplacard_settings) =
     let(
        wp_style = wallplacard_settings[iwallplacardconfig_style],

        wp_width  = wallplacard_settings[iwallplacardconfig_size][iwallplacardconfig_size_width],
        wp_height = wallplacard_settings[iwallplacardconfig_size][iwallplacardconfig_size_height],
        wp_depth  = wallplacard_settings[iwallplacardconfig_size][iwallplacardconfig_size_depth],

        raw_off_horiz = wallplacard_settings[iwallplacardconfig_offset][iwallplacardconfig_offset_horiz],
        raw_off_vert  = wallplacard_settings[iwallplacardconfig_offset][iwallplacardconfig_offset_vert],
        raw_off_depth = wallplacard_settings[iwallplacardconfig_offset][iwallplacardconfig_offset_depth],

        off_horiz = raw_off_horiz + (wall_width / 2),
        off_vert  = raw_off_vert  + (wall_height / 2),
        off_depth = raw_off_depth +
            ((wp_style == "slot") ? 0 : -wall_thickness),

        wp_corner_radius = wallplacard_settings[iwallplacardconfig_corner_radius],
        is_enabled = (wall_wall != 0),

        height = min(wp_height, wall_height),
        width = min(wp_width, wall_width),
        depth = wp_depth==0 ? wall_thickness : wp_depth,
        )
      [is_enabled, wp_style, width, height, depth, wp_corner_radius, off_horiz, off_vert, off_depth];

module Wallplacard(
  style,
  width,
  height,
  depth,
  corner_radius,
  off_horiz,
  off_vert,
  off_depth,
  slot_frame) {
 
  echo("PITCH", env_pitch());
  echo("CLEAR", env_clearance());
  rotate([90,0,0])
  translate([off_horiz, off_vert, off_depth])
    if (style == "rectangle") {
      roundedCube(centerxy=true, x=width, y=height, z=depth, sideRadius=corner_radius);

    } else if (style == "ellipse") {
      linear_extrude(height=depth)
        resize([width, height])
          circle(r=1);

    } else if (style == "slot") {
      sf_reveal   = slot_frame[iwallplacardconfig_slot_frame_reveal];
      sf_coverage = slot_frame[iwallplacardconfig_slot_frame_coverage];
      sf_width    = slot_frame[iwallplacardconfig_slot_frame_width];
      sf_depth    = slot_frame[iwallplacardconfig_slot_frame_depth];
      ls_wider = max(sf_width, corner_radius);
      ls_taller = max(sf_width, corner_radius);
      ls_deeper = sf_depth;

      // the backer for the slot (blended into the wall)
      translate([0,0,-depth])
          roundedCube(centerxy=true, x=width+ls_wider, y=height+ls_taller, z=depth, sideRadius=corner_radius);
      difference() {
        intersection() {  // flatten the top edge
          // roundedCube is centered on X and Y but not on Z; cube is centered on all 3
          roundedCube(centerxy=true,
            x=width+ls_wider, y=height+ls_taller, z=depth+ls_deeper,
            sideRadius=corner_radius, topRadius=corner_radius);
          translate([0, -sf_reveal, (depth+ls_deeper)/2])
            cube(size=[width+ls_wider, height+ls_taller, depth+ls_deeper], true);
        }
        translate([0,0,depth/2])
          cube(size=[width, height, depth], true);  // the slot
        translate([0,0,(depth+ls_deeper)/2])
          cube(size=[width-sf_coverage, height-sf_coverage, depth+ls_deeper], true);  // framed slot
      }
    }
}

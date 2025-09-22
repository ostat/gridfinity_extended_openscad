iFingerSlideType=0;
iFingerSlideRadius=1;
iFingerSlideWalls=2;
iFingerSlideLipAligned=3;

function FingerSlideSettings(
    type, 
    radius, 
    walls,
    lip_aligned,
    ) = 
  let(
    result = [
      type,
      radius,
      walls,
      lip_aligned
      ],
    validatedResult = ValidateFingerSlideSettings(result)
  ) validatedResult;

function ValidateFingerSlideSettings(settings) =
  assert(is_list(settings), "Settings must be a list")
  assert(len(settings)==4, "Settings must length 4")
  assert(is_string(settings[iFingerSlideType]), "Type must be a string")
  assert(is_num(settings[iFingerSlideRadius]), "Radius must be a number")
  assert(is_list(settings[iFingerSlideWalls]) && len(settings[iFingerSlideWalls])==4, "Walls must be a list of four numbers")
  assert(is_bool(settings[iFingerSlideLipAligned]), "Lip Aligned must be a boolean")
    [settings[iFingerSlideType],
      settings[iFingerSlideRadius],
      settings[iFingerSlideWalls],
      settings[iFingerSlideLipAligned]
      ];

///Creates the finger slide that will be subtracted from the cavity  
module FingerSlide(
        num_x = num_x, 
        num_y = num_y,
        num_z = num_z,
        fingerslide_walls=fingerslide_walls,
        fingerslide=fingerslide,
        fingerslide_radius=fingerslide_radius,
        reducedlipstyle=reducedlipstyle,
        wall_thickness=wall_thickness,
        floorht=floorht,
        lipAligned = true,
        inner_corner_center=inner_corner_center) {
  assert(is_num(num_x), "num_x must be a number");
  assert(is_num(num_y), "num_y must be a number");
  assert(is_num(num_z), "num_z must be a number");
  assert(is_list(fingerslide_walls), "fingerslide_walls must be a list");
  assert(is_string(fingerslide), "fingerslide must be a string");
  assert(is_num(fingerslide_radius), "fingerslide_radius must be a number");
  assert(is_string(reducedlipstyle), "reducedlipstyle must be a string");
  assert(is_num(wall_thickness), "wall_thickness must be a number");
  assert(is_num(floorht), "floorht must be a number");
  assert(is_bool(lipAligned), "lipAligned must be a bool");
  assert(is_list(inner_corner_center), "inner_corner_center must be a number");
  
  echo("fingerslide", fingerslide_walls=fingerslide_walls, fingerslide=fingerslide);
  front = [
    //width
    num_x*env_pitch().x,
    //Position
    [0, 0, 0],
    //rotation
    [0,0,0],
    //cup width for finger slide (opposide dimention)
    num_y*env_pitch().y,
    //cup height
    num_z*env_pitch().z];
  back = [
    //width
    num_x*env_pitch().x,
    //Position
    [num_x*env_pitch().x, num_y*env_pitch().y, 0],
    //rotation
    [0,0,180],
    //cup width for finger slide (opposide dimention)
    num_y*env_pitch().y,
    //cup height
    num_z*env_pitch().z];
  left = [
    //width
    num_y*env_pitch().y,
    //Position
    [0, num_y*env_pitch().y, 0],
    //rotation
    [0,0,270],
    //cup width for finger slide (opposide dimention)
    num_x*env_pitch().x,
    //cup height
    num_z*env_pitch().z];
  right = [
    //width
    num_y*env_pitch().y,
    //Position
    [num_x*env_pitch().x, 0, 0],
    //rotation
    [0,0,90],
    //cup width for finger slide (opposide dimention)
    num_x*env_pitch().x,
    //cup height
    num_z*env_pitch().z];
    
  locations = [front, back, left, right];
  function get_fingerslide_radius(wall, cup_size, cup_height, fingerslide_radius) = 
  let(radius_start = wall == 1 ? fingerslide_radius : wall,
      calculated_radius = radius_start < 0 ? min(cup_height, cup_size)/abs(radius_start) : radius_start,
      limited_radius = min(calculated_radius,cup_height,cup_size/2))
    limited_radius;
      
  for(i = [0:1:len(locations)-1])
    union()
      if(fingerslide_walls[i] != 0)
        //patterns in the outer walls
        translate(locations[i][1])
        rotate(locations[i][2])                  
      translate([0, 
        lipAligned && reducedlipstyle =="normal" ? -inner_corner_center.x-1.15+env_pitch().x/2
        : lipAligned && reducedlipstyle == "reduced" ? -inner_corner_center.x-1.15+env_pitch().x/2-gf_lip_lower_taper_height
        : lipAligned && reducedlipstyle == "reduced_double" ? -inner_corner_center.x-1.15+env_pitch().x/2-gf_lip_lower_taper_height
        : 0.25+wall_thickness, floorht]) //todo:pitch issue here?
    //translate([0,-inner_corner_center-1.15+env_pitch().x/2, floorht])
      union(){
        if(fingerslide == "rounded"){
          roundedCorner(
            radius = get_fingerslide_radius(fingerslide_walls[i], locations[i][3], locations[i][4], fingerslide_radius), 
            length=locations[i][0], 
            height = env_pitch().z*num_z-floorht+fudgeFactor);
        }
        else if(fingerslide == "chamfered"){
          chamferedCorner(
            chamferLength = get_fingerslide_radius(fingerslide_walls[i], locations[i][3], locations[i][4], fingerslide_radius), 
            length=locations[i][0],
            height = env_pitch().z*num_z-floorht+fudgeFactor);
      }
    }
}

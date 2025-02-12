
include <functions_gridfinity.scad>

//Set up the Environment, if not run object should still render using defaults
module set_environment(
  width,
  depth,
  height = 0,
  setColour = "preview",
  help = false,
  render_position = "center", //[default,center,zero]
  cut = [0,0,0],
  pitch = [gf_pitch, gf_pitch, gf_zpitch],
  randomSeed = 0,
  force_render = true){
  
  //Set special variables, that child modules can use
  $setColour = setColour;
  $showHelp = help;
  $cutx = cut.x;
  $cuty = cut.y;
  $cutz = cut.z;
  $pitch = pitch;
  $randomSeed = randomSeed;
  $forceRender = force_render;

  $user_width = width;
  $user_depth = depth;
  $user_height = height;

  num_x = calcDimensionWidth(width, true); 
  num_y = calcDimensionDepth(depth, true); 
  num_z = calcDimensionHeight(height, true); 
  $num_x = num_x; 
  $num_y = num_y; 
  $num_z = num_z; 

  echo("🟩set_environment", fs=$fs, fa=$fa, fn=$fn, pitch=pitch);

  //Position the object
  translate(gridfinityRenderPosition(render_position,num_x,num_y))
  union(){
    difference(){
      //Render the object
      children(0);
      
      //Render the cut, used for debugging
      /*
      if(cutx > 0 && cutz > 0 && $preview){
        color(color_cut)
        translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
          cube([env_pitch().x*cutx,num_y*env_pitch().y+fudgeFactor*2,(cutz+1)*env_pitch().z]);
      }
      if(cuty > 0 && cutz > 0 && $preview){
        color(color_cut)
        translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
          cube([num_x*env_pitch().x+fudgeFactor*2,env_pitch().y*cuty,(cutz+1)*env_pitch().z]);
      }*/
    }

    //children(1);
  }
}

function env_numx() = is_undef($num_x) || !is_num($num_x) ? 0 : $num_x;
function env_numy() = is_undef($num_y) || !is_num($num_y) ? 0 : $num_y;
function env_numz() = is_undef($num_z) || !is_num($num_z) ? 0 : $num_z;

function env_pitch() =  is_undef($pitch) || !is_list($pitch) ? [gf_pitch, gf_pitch, gf_zpitch] : $pitch; 

function env_cutx() = is_undef($cutx) || !is_num($cutx) ? 0 : $cutx;
function env_cuty() = is_undef($cuty) || !is_num($cuty) ? 0 : $cuty;
function env_cutz() = is_undef($cutz) || !is_num($cutz) ? 0 : $cutz;
function env_random_seed() = is_undef($randomSeed) || !is_num($randomSeed) || $randomSeed == 0 ? undef : $randomSeed;
function env_force_render() = is_undef($forceRender) ? true : $forceRender;

//set_colour = "preview"; //[disabled, preview, lip]
function env_colour(colour, isLip = false, fallBack = color_cup) = 
    is_undef($setColour) 
      ? $preview ? colour : fallBack
      : is_string($setColour) 
        ? $setColour == "enable" ? colour
        : $setColour == "preview" && $preview ? colour
          : $setColour == "lip" && isLip ? colour
            : fallBack
          : fallBack;
          
function env_help_enabled(level) = 
  is_string(level) && level == "force" ? true
    : is_undef($showHelp) ? false
      : is_bool($showHelp) ? $showHelp
        : is_string($showHelp) 
          ? $showHelp == "info" && level == "info" ? true
            : $showHelp == "debug" && (level == "info" || level == "debug") ? true
            : $showHelp == "trace" && (level == "info" || level == "debug" || level == "trace") ? true
            : false
          : false;
          
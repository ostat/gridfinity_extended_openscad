include <functions_string.scad>

//round a number to a decimal with a defined number of significant figures
function roundtoDecimal(value, sigFigs = 0) = 
  assert(is_num(value), "value must be a number")
  assert(is_num(sigFigs) && sigFigs >= 0, "sigFigs must be a number")
  let(
    sigFigs = round(sigFigs),
    factor = 10^round(sigFigs))
    sigFigs == 0 
      ? round(value) 
      : round(value*factor)/factor;

function DictGet(list, key, alert=false) = 
  let(matchResults = search([key],list,1),
    matchIndex = is_list(matchResults) && len(matchResults)==1 && is_num(matchResults[0]) ? matchResults[0]: undef,
    alertMessage = str("count not find key in list key:'", key, "' matchResults:'", matchResults, "' matchIndex:'", matchIndex),
    matchValue = is_num(matchIndex) ? list[matchIndex] : undef,
    x = !alert && is_undef(matchValue) ? echo(alertMessage) : 1)
    assert(!alert || !is_undef(matchValue), alertMessage)
      matchValue[1];

function DictSetRange(list, keyValueArray) = !(len(keyValueArray)>0) ? list : 
  assert(is_list(list), str("DictSetRange(keyValueArray, arr) - arr is not a list. list:",list))
  assert(is_list(keyValueArray), str("DictSetRange(keyValueArray, arr) - keyValueArray is not a list. keyValueArray:", keyValueArray))
  let(currentKeyValue = keyValueArray[0])
  assert(is_list(currentKeyValue), str("DictSetRange(keyValueArray, arr) - currentKeyValue is not a list. currentKeyValue:",currentKeyValue))
  assert(len(currentKeyValue)==2, str("DictSetRange(keyValueArray, arr) - currentKeyValue is not length of 2. currentKeyValue:",currentKeyValue))
  assert(is_string(currentKeyValue[0]), str("DictSetRange(keyValueArray, arr) - currentKeyValue[0] is not a string, currentKeyValue:",currentKeyValue))
  let(keyValueArrayNext = remove_item(keyValueArray,0),
    updatedList = DictSet(list, currentKeyValue)
  ) concat(DictSetRange(updatedList, keyValueArrayNext));

function DictSet(list, keyValue) = 
  assert(is_list(list), str("DictSet(keyValueArray, arr) - arr is not a list list:", list))
  assert(is_list(keyValue), str("DictSet(keyValueArray, arr) - keyValueArray is not a list. keyValue:",keyValue))
  assert(len(keyValue)==2, str("DictSet(keyValueArray, arr) - keyValueArray is not a list. keyValue:",keyValue))
  let(matchResults = search([keyValue[0]],list,1),
    matchIndex = is_list(matchResults) && len(matchResults)==1 && is_num(matchResults[0]) ? matchResults[0] : undef)
  assert(!is_undef(matchIndex), str("count not find key in list key:'", keyValue[0], "'", DictToString(list)))
    replace(list, matchIndex, keyValue);

module DictDisplay(list, name = ""){
  echo(DictToString(list=list,name=name));
}
function DictToString(list, name = "") =
  let(infoText=[for(i=[0:len(list)-1])str(list[i][0],"=",list[i][1])])
  str("🟧", name, concatstringarray(infoText));

function concatstringarray(in, out="",pos=0, sep="\r\n  ") = pos>=len(in)?out:
  concatstringarray(in=in,out=str(out,sep,in[pos]),pos=pos +1); 
      
//Replace multiple values in an array
function replace_Items(keyValueArray, arr) = !(len(keyValueArray)>0) ? arr : 
  assert(is_list(arr), "replace_Items(keyValueArray, arr) - arr is not a list")
  assert(is_list(keyValueArray), "replace_Items(keyValueArray, arr) - keyValueArray is not a list")
  let(currentKeyValue = keyValueArray[0])
  assert(is_list(currentKeyValue), "replace_Items(keyValueArray, arr) - currentKeyValue is not a list")
  assert(is_num(currentKeyValue[0]), "replace_Items(keyValueArray, arr) - currentKeyValue[0] is not a number")
  let(keyValueArrayNext = remove_item(keyValueArray,0),
    updatedList = replace(arr, currentKeyValue[0],currentKeyValue[1])
) concat(replace_Items(keyValueArrayNext, updatedList));

//Replace a value in an array
function replace(list,position,value) = 
  assert(is_list(list), "replace(list,position,value) - list is not a list")
  assert(is_num(position), "replace(list,position,value) - position is not a number")
  let (
    l1 = position > 0 ? partial(list,start=0,end=position-1) : [], 
    l2 = position < len(list)-1 ? partial(list,start=position+1,end=len(list)-1) :[]
  ) concat(l1,[value],l2);

// takes part of an array
function partial(list,start,end) = [for (i = [start:end]) list[i]];

//Removes item from an array
function remove_item(list,position) = [for (i = [0:len(list)-1]) if (i != position) list[i]];

//Takes a string and converts it in to an array of arrays.
//I.E.  "0, 0, 0.5, 3, 2, 6|0.5, 0, 0.5, 3,2, 6|1, 0, 3, 1.5|1, 1.5, 3, 1.5";
//becomes  [[0, 0, 0.5, 3, 2, 6], [0.5, 0, 0.5, 3, 2, 6], [1, 0, 3, 1.5], [1, 1.5, 3, 1.5]]
function splitCustomConfig(customConfig) = let(
  compartments = split(customConfig, "|")
) [for (x =[0:1:len(compartments)-1]) csv_parse(compartments[x])];

/*
U+1F7E5 🟥 LARGE RED SQUARE
U+1F7E6 🟦 LARGE BLUE SQUARE
U+1F7E7 🟧 LARGE ORANGE SQUARE
U+1F7E8 🟨 LARGE YELLOW SQUARE
U+1F7E9 🟩 LARGE GREEN SQUARE
U+1F7EA 🟪 LARGE PURPLE SQUARE
U+1F7EB 🟫 LARGE BROWN SQUARE
U+2B1B ⬛ BLACK LARGE SQUARE
U+2B1C ⬜ WHITE LARGE SQUARE
*/
  
function outputCustomConfig(typecode, arr) = let(
  config = createCustomConfig(arr),
  dynamicConfig = str("\"", typecode,"\"", ",", config)
) str("🟦 Generating 'tray' config, to be used in custom config.\r\nLocal Config\r\n\t", config, "\r\nDynamic Config\r\n\t", dynamicConfig,"\r\n");

function createCustomConfig(arr, pos=0, sep = ",") = pos >= len(arr) ? "" :
  let(
    current = is_list(arr[pos]) ? createCustomConfig(arr[pos], sep=";") 
      : is_string(arr[pos]) ? str("\"",arr[pos],"\"")
      : arr[pos],
    strNext = createCustomConfig(arr, pos+1, sep)
  ) str(current, strNext!=""?str(sep, strNext):"");

//Set up the Environment, if not run object should still render
module SetGridfinityEnvironment(
  width,
  depth,
  height = 0,
  setColour = "preview",
  help = false,
  render_position = "center", //[default,center,zero]
  cutx = 0, 
  cuty = 0,
  cutz = 0){
  
  //Set special variables, that child modules can use
  $setColour = setColour;
  $showHelp = help;
  $cutx = cutx;
  $cuty = cuty;
  $cutz = cutz;

  $user_width = width;
  $user_depth = depth;
  $user_height = height;
  num_x = calcDimensionWidth(width); 
  num_y = calcDimensionDepth(depth); 
  num_z = calcDimensionHeight(height); 
  $num_x = num_x; 
  $num_y = num_y; 
  $num_z = num_z; 

  //Position the object
  translate(gridfinityRenderPosition(render_position,num_x,num_y))
  union(){
    difference(){
      //Render the object
      children(0);
      
      //Render the cut, used for debugging
      if(cutx > 0 && cutz > 0 && $preview){
        color(color_cut)
        translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
          cube([gf_pitch*cutx,num_y*gf_pitch+fudgeFactor*2,(cutz+1)*gf_zpitch]);
      }
      if(cuty > 0 && cutz > 0 && $preview){
        color(color_cut)
        translate([-fudgeFactor,-fudgeFactor,-fudgeFactor])
          cube([num_x*gf_pitch+fudgeFactor*2,gf_pitch*cuty,(cutz+1)*gf_zpitch]);
      }
    }

    //Render the calipers
    //children(1);
  }
}

function getCutx() = is_undef($cutx) || !is_num($cutx) ? 0 : $cutx;
function getCuty() = is_undef($cuty) || !is_num($cuty) ? 0 : $cuty;
          
//set_colour = "preview"; //[disabled, preview, lip]
function getColour(colour, isLip = false, fallBack = color_cup) = 
    is_undef($setColour) 
      ? $preview ? colour : fallBack
      : is_string($setColour) 
        ? $setColour == "enable" ? colour
        : $setColour == "preview" && $preview ? colour
          : $setColour == "lip" && isLip ? colour
            : fallBack
          : fallBack;
          
function IsHelpEnabled(level) = 
  is_string(level) && level == "force" ? true
    : is_undef($showHelp) ? false
      : is_bool($showHelp) ? $showHelp
        : is_string($showHelp) 
          ? $showHelp == "info" && level == "info" ? true
            : $showHelp == "debug" && (level == "info" || level == "debug") ? true
            : $showHelp == "trace" && (level == "info" || level == "debug" || level == "trace") ? true
            : false
          : false;

module assert_openscad_version(){
  assert(version()[0]>2022,"Gridfinity Extended requires an OpenSCAD version greater than 2022 https://openscad.org/downloads. Use Development Snapshots if the release version is still 2021.01 https://openscad.org/downloads.html#snapshots.");
}
include <functions_string.scad>

function sum(list, c = 0, end) = 
  let(end = is_undef(end) ? len(list) : end)
  c < 0 || end < 0 ? 0 : 
  c < len(list) - 1 && c < end
    ? list[c] + sum(list, c + 1, end=end) 
    : list[c];

function vector_sum(v, start=0, end, itemIndex) = 
  let(v=is_list(v)?v:[v], end = is_undef(end)?len(v)-1:min(len(v)-1,end))
  is_num(itemIndex) 
    ? start<end ? v[start][itemIndex] + vector_sum(v, start+1, end, itemIndex) : v[start][itemIndex]
    : start<end ? v[start] + vector_sum(v, start+1, end, itemIndex) : v[start];    
    
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
  assert(!is_undef(matchIndex), str("count not find key in list, key:'", keyValue[0], "'", DictToString(list)))
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

module assert_openscad_version(){
  assert(version()[0]>2022,"Gridfinity Extended requires an OpenSCAD version greater than 2022 https://openscad.org/downloads. Use Development Snapshots if the release version is still 2021.01 https://openscad.org/downloads.html#snapshots.");
}

// Gets one value base on another.
// if user_value = 0 use the base value
// user_value > 0 use that value
// user_value < 0 base_value/abs(user_value) (i.e. -3 is 1/3 the base_value)
function get_related_value(user_value, base_value, default_value, max_value) = 
  let(
      max_value = is_undef(max_value) ? base_value : max_value,
      default = is_undef(default_value) ? base_value : default_value,
      calculated = user_value == 0 ? default :
      user_value < 0 ? base_value/abs(user_value) : user_value)
      min(calculated, max_value);

module highlight_conditional(enable=false){
  if(enable)
    #children();
  else
    children();
}

function color_from_list(index) = 
let(
  colours = ["white","red","blue","Green","pink","orange","purple","black", "Coral", "Gray", "Teal"],
  mod_index = index%len(colours)
) colours[mod_index];

module color_conditional(enable=true, c, alpha = 1){
  if(enable)
  color(c, alpha)
    children();
  else
    children();
}

module exclusive_conditional(enable=true){
  if(enable)
    !children();
  else
    children();
}


module render_conditional(enable=true){
  if(enable)
    render()
      children();
  else
    union()
      children();
}



module hull_conditional(enabled = true)
{
  if(enabled){
    hull(){
      children();
    }
  }
  else{
    union(){
      children();
    }
  }
}
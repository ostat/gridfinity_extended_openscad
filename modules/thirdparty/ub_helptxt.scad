// works from OpenSCAD version 2021 or higher   maintained at https://github.com/UBaer21/UB.scad

/** \mainpage
 * ##Open SCAD library www.openscad.org 
 * **Author:** ulrich.baer+UBscad@gmail.com (mail me if you need help - i am happy to assist)
*/

include <ub_common.scad>

// display the module variables in a copyable format
module HelpTxt(titel,string,help){ 
  help=is_undef(help)?is_undef($helpM)?false:
                                $helpM:
  help;
  idxON=is_undef($idxON)?false:$idxON?true:false;
  idx=is_undef($idx)||idxON?false:is_list($idx)?norm($idx):$idx;
  
   joinArray= function(in,out="",pos=0) pos>=len(in)?out:
        joinArray(in=in,out=str(out,in[pos]),pos=pos +1); 

helpText=[for(i=[0:2:len(string)-1])str(string[i],"=",string[i+1],",\n  ")];
 if(version()[0]<2021){ 
if(help)if(is_list(string))echo(
    
str("<H3> <font color=",helpMColor,"> Help ",titel, "(",
    helpText[0]
,helpText[1]?helpText[1]:""
,helpText[2]?helpText[2]:""
,helpText[3]?helpText[3]:""
,helpText[4]?helpText[4]:""
,helpText[5]?helpText[5]:""
,helpText[6]?helpText[6]:""
,helpText[7]?helpText[7]:""
,helpText[8]?helpText[8]:""
,helpText[9]?helpText[9]:""
,helpText[10]?helpText[10]:""
,helpText[11]?helpText[11]:""
,helpText[12]?helpText[12]:""
,helpText[13]?helpText[13]:""
,helpText[14]?helpText[14]:""
,helpText[15]?helpText[15]:""
,helpText[16]?helpText[16]:""
,helpText[17]?helpText[17]:""
,helpText[18]?helpText[18]:""
,helpText[19]?helpText[19]:""
,helpText[20]?helpText[20]:"" 
,helpText[21]?helpText[21]:""
,helpText[22]?helpText[22]:""
,helpText[23]?helpText[23]:""
,helpText[24]?helpText[24]:""
,helpText[25]?helpText[25]:""
,helpText[26]?helpText[26]:""
,helpText[27]?helpText[27]:""
,helpText[28]?helpText[28]:""
,helpText[29]?helpText[29]:""


// ," name=",name,
," help);"));  
else HelpTxt("Help",["titel",titel,"string",["string","data","help",help],"help",help],help=1);
}
else{ // current versions help 
if(help&&!idx)if(is_list(string))echo(
    
str("🟪\nHelp ",titel, "(\n  ",
joinArray(helpText)
,"help=",help,"\n);\n"));    
else HelpTxt("Help",["titel",titel,"string",string,"help",help],help=1);
}
}
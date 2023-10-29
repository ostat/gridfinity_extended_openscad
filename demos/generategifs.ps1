$workingFolder = (Split-Path -Parent $PSCommandPath)
$outputFolder = Join-Path $workingFolder 'output\gridfinity-extended'
$script:ScadExePath = 'C:\Program Files\OpenSCAD\openscad.exe'
$script:ImageMagickPath = 'C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\magick.exe'
  
function Create-Gifs($ParentFolderPath){ 
    Get-ChildItem -LiteralPath $ParentFolderPath -Directory | ForEach-Object{
        $folder = $_
        Create-Gif $folder.FullName "$($folder.Parent.Name)-$($folder.Name)"
    }
}

function Create-Gif($FolderPath, $Name) 
{
    cd $FolderPath
    & $script:ImageMagickPath convert '*.png' -set delay 100 "$($Name).gif"
    #convert 'frame_*.png' -set delay 1x15 animation.gif 
}

Function AddArgs($cmdArgs, $value, $argValue) {
    if (![string]::IsNullOrEmpty($value)) { 
        $cmdArgs += $argValue
    }
    return $cmdArgs
}

Function IIF{
[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline)]
    [bool]$If,
    $Right, 
    $Wrong)
    if ($If) { return $Right } else { return $Wrong }
}

Function AppendIfTrue{
[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline)]
    [string]$string = '', 
    [bool]$condition = $true,
    [string]$value, 
    [string]$seperater = '_')

    if([string]::IsNullOrEmpty($string)){
        return $value
    }
    if (![string]::IsNullOrEmpty($value)) { 
        return "$string$seperater$value"
    }
    return $string
}

function CreateFolderIfNeeded([string] $path) {

    if(!(Test-Path -LiteralPath $path))
    {
        New-Item $path -ItemType Directory
    }
}


Class Scenario{
    [string]$ScenarioName
    [string]$ScenarioNameFriendly
    [int]$Count
}


function Create-ImageForDemo(
    [string]$ScadScriptPath,
    [string]$outputFolder,
    [bool]$SetFilePath = $true
    ){
    $Scenarios = New-Object System.Collections.ArrayList

    $scriptFile =  Get-Item -LiteralPath $scadScriptPath
    
    $demoName = $scriptFile.BaseName.Replace('_demo','')
    $demoOutputFolder = Join-Path $outputFolder "$($demoName)"

    foreach($line in Get-Content $scadScriptPath) {
        if($line -match 'scenario\s?==\s?"(?<secenario>.*?)"\s?\?\s?\[\["(?<secenariofriendly>.*?)"\,\s?(?<count>\d*)'){
        
            $scenario = New-Object Scenario
            $scenario.ScenarioName = $Matches['secenario']
            $scenario.ScenarioNameFriendly = $Matches['secenariofriendly']
            $scenario.Count = $Matches['count']/1 #hack to convert to int

            $Scenarios.Add($scenario) | Out-Null
        }
    }

    $options = @($false, $true);
    $Scenarios | ForEach-Object {
      $scenario = $_
      $options | ForEach-Object {
        $showtext  = $_
        $scenarioName =  (IIF -If $showtext -Right "$($scenario.ScenarioName)_text" -Wrong $scenario.ScenarioName)
        $scenarioOutputFolder = Join-Path $demoOutputFolder $scenarioName 
        
        CreateFolderIfNeeded $scenarioOutputFolder

        #invoke openscad
        $cmdArgs = ""
        $target = Join-Path $scenarioOutputFolder "$($scenario.ScenarioName).png"
        if($SetFilePath)
        {
            $cmdArgs = "-o `"$($target)`""
            #--camera=translatex,y,z,rotx,y,z,dist
        }

        $cmdArgs = $cmdArgs += " -D `"scenario=`"`"$($scenario.ScenarioName)`"`"`""
        $cmdArgs = $cmdArgs += " -D `"showtext=$($showtext.ToString().tolower())`""
        $cmdArgs = $cmdArgs += " --colorscheme BeforeDawn"
        $cmdArgs = $cmdArgs += " --imgsize 1024,768"
        $cmdArgs = $cmdArgs += " --animate $($scenario.Count)"
        
        $cmdArgs += " $($scadScriptPath)"
        Write-Host  $cmdArgs
        $executionTime =  $cmdArgs | Measure-Command { Start-Process $script:ScadExePath -ArgumentList $_ -wait }
        
        Create-Gif -FolderPath $scenarioOutputFolder -Name "$($demoName)-$($scenarioName)"
      }
    }
}

Create-ImageForDemo -ScadScriptPath  (Join-Path $workingFolder 'gridfinity_basic_cup_demo.scad') -outputFolder $outputFolder
Create-ImageForDemo -ScadScriptPath  (Join-Path $workingFolder 'gridfinity_baseplate_demo.scad') -outputFolder $outputFolder
Create-ImageForDemo -ScadScriptPath  (Join-Path $workingFolder 'gridfinity_item_holder_demo.scad') -outputFolder $outputFolder
Create-ImageForDemo -ScadScriptPath  (Join-Path $workingFolder 'gridfinity_tray_demo.scad') -outputFolder $outputFolder
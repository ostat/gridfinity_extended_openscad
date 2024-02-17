$scriptFolder = (Split-Path -Parent $PSCommandPath)
$outputFolder = Join-Path $scriptFolder '..\generated\demos'
$demoFolder = Join-Path $scriptFolder '..\demos\'
$script:ScadExePath = 'C:\Program Files\OpenSCAD\openscad.exe'
$script:ImageMagickPath = 'C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\magick.exe'
# used to only run a single scenario
$script:ScenarioFilter = ''

function Create-Gifs($ParentFolderPath){ 
    Write-Host "Create Gifs for $ParentFolderPath"
    Get-ChildItem -LiteralPath $ParentFolderPath -Directory | ForEach-Object{
        $folder = $_
        Create-Gif $folder.FullName "$($folder.Parent.Name)-$($folder.Name)"
    }
}

function Create-Gif($FolderPath, $Name) 
{
    Write-Host "Createing Gif for folder $($FolderPath)"
    cd $FolderPath
    & $script:ImageMagickPath convert '*.png' -set delay 100 "$($Name).gif"
    #convert 'frame_*.png' -set delay 1x15 animation.gif 
    Write-Host "Gif creating done"
    
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
    [string]$ScenarioFilter = '',
    [bool]$SetFilePath = $true,
    [bool]$CleanFolder = $true,
    $renderOptions = @('png','text','stl')
    ) {
    $Scenarios = New-Object System.Collections.ArrayList

    $scriptFile =  Get-Item -LiteralPath $scadScriptPath

    $demoName = $scriptFile.BaseName.Replace('_demo','')
    $demoOutputFolder = Join-Path $outputFolder "$($demoName)"

    Write-Host "$($demoName ) - generating demos`r`n`ttarget folder $($demoOutputFolder)" -ForegroundColor Green
    foreach($line in Get-Content $scadScriptPath) {
        if($line -match 'scenario\s?==\s?"(?<secenario>.*?)"\s?\?\s?\[\["(?<secenariofriendly>.*?)"\,\s?(?<count>\d*)'){
        
            $scenario = New-Object Scenario
            $scenario.ScenarioName = $Matches['secenario']
            $scenario.ScenarioNameFriendly = $Matches['secenariofriendly']
            $scenario.Count = $Matches['count']/1 #hack to convert to int

            $Scenarios.Add($scenario) | Out-Null
        }
    }
    
    Write-Host "$($demoName) - Found $($Scenarios.Count) Scenarios" -ForegroundColor Green

    $Scenarios | Where-Object{[string]::IsNullOrEmpty($ScenarioFilter) -or $_.ScenarioName -match $ScenarioFilter} | ForEach-Object {
        $scenario = $_
        $renderOptions | ForEach-Object {
            $option = $_
            $showtext = ($option -eq 'text')
            $scenarioName =  "$($scenario.ScenarioName)_$($option)"
            $scenarioOutputFolder = Join-Path $demoOutputFolder "$($option)\$($scenarioName)"
        
            CreateFolderIfNeeded $scenarioOutputFolder
            $ext = IIF -If ($option -eq 'stl')  -Right 'stl' -Wrong 'png'
            write-host "Processing $scenarioName option:$($option)" -ForegroundColor Yellow
            if($CleanFolder){
                Remove-Item (join-path $scenarioOutputFolder "\*.$($ext)")
            }

            #invoke openscad
            $cmdArgs = "" 
        
            $target = Join-Path $scenarioOutputFolder "$($scenario.ScenarioName).$($ext)"
            if($SetFilePath)
            {
                $cmdArgs = "-o `"$($target)`""
                #--camera=translatex,y,z,rotx,y,z,dist
                $cmdArgs = $cmdArgs += " --imgsize 4096,3072"#" --imgsize 1024,768"4096,3072
                $cmdArgs = $cmdArgs += " --animate $($scenario.Count)"
                #--csglimit arg               =n -stop rendering at n CSG elements when exporting png
                $cmdArgs = $cmdArgs += " --csglimit 1000000"#" --imgsize 1024,768"4096,3072
            }

            $cmdArgs = $cmdArgs += " -D `"scenario=`"`"$($scenario.ScenarioName)`"`"`""
            $cmdArgs = $cmdArgs += " -D `"showtext=$($showtext.ToString().tolower())`""
            $cmdArgs = $cmdArgs += " --colorscheme Tomorrow" #BeforeDawn
        
            $cmdArgs += " $($scadScriptPath)"
            Write-Host  $cmdArgs
            $executionTime =  $cmdArgs | Measure-Command { Start-Process $script:ScadExePath -ArgumentList $_ -wait }
            Write-host "done $executionTime"

            if($option -ne 'stl' -and $scenario.Count -gt 1)
            {
                Create-Gif -FolderPath $scenarioOutputFolder -Name "$($demoName)-$($scenarioName)"
            }
        }
    }
}
$renderOptions = @('png','text') #@('png','text','stl')
Create-ImageForDemo -ScadScriptPath  (Join-Path $demoFolder 'gridfinity_basic_cup_demo.scad') -outputFolder $outputFolder -ScenarioFilter $script:ScenarioFilter -renderOptions $renderOptions
Create-ImageForDemo -ScadScriptPath  (Join-Path $demoFolder 'gridfinity_baseplate_demo.scad') -outputFolder $outputFolder -ScenarioFilter $script:ScenarioFilter -renderOptions $renderOptions
Create-ImageForDemo -ScadScriptPath  (Join-Path $demoFolder 'gridfinity_item_holder_demo.scad') -outputFolder $outputFolder -ScenarioFilter $script:ScenarioFilter -renderOptions $renderOptions
Create-ImageForDemo -ScadScriptPath  (Join-Path $demoFolder 'gridfinity_tray_demo.scad') -outputFolder $outputFolder -ScenarioFilter $script:ScenarioFilter -renderOptions $renderOptions
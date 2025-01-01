Param(
    [string]$ScenarioFilter = 'demo', 
    $renderOptions = @('text'),#@('png','text','stl')
    [int]$scenarioCount = -1,
    [string]$ScadExePath = 'C:\Program Files\OpenSCAD\openscad.exe',
    [string]$ImageMagickPath = 'C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\magick.exe',
    [string]$ScadScriptPath = (Join-Path ((Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName) '\demos\gridfinity_item_holder_demo.scad'),
    [string]$outputFolder = (Join-Path ((Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName) 'generated\demos')
)

function Create-Gifs($ParentFolderPath){ 
    Write-Host "Create Gifs for $ParentFolderPath"
    Get-ChildItem -LiteralPath $ParentFolderPath -Directory | ForEach-Object{
        $folder = $_
        Create-Gif $folder.FullName "$($folder.Parent.Name)-$($folder.Name)"
    }
}

function Create-Gif($FolderPath, $Name) 
{
    Write-Host "Createing Gif '$($Name)' for folder $($FolderPath)"
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

function Start-ProcessWithOutputs
{
    param (
        [Parameter(Mandatory=$false)] [string]$commandTitle,
        [Parameter(Mandatory=$true)] [string]$commandPath,
        [Parameter(Mandatory=$false)] [string[]]$ArgumentList
    )

    $StandardOutputSourceIdentifier = "StandardOutput$([Guid]::NewGuid())"
    $StandardErrorSourceIdentifier = "StandardError$([Guid]::NewGuid())"
    $messagedata = new-object psobject -property @{
       StandardOutput= New-Object -TypeName System.Text.StringBuilder
       StandardError = New-Object -TypeName System.Text.StringBuilder}

    $pinfo = New-object System.Diagnostics.ProcessStartInfo 
    $pinfo.FileName = $commandPath
    $pinfo.CreateNoWindow = $true 
    $pinfo.UseShellExecute = $false 
    $pinfo.RedirectStandardOutput = $true 
    $pinfo.RedirectStandardError = $true 
    $pinfo.Arguments = $ArgumentList

    $Process = New-Object System.Diagnostics.Process 
    $Process.StartInfo = $pinfo 

    $ProcessOutputEventAction = { 
        if (![string]::IsNullOrEmpty($EventArgs.Data)){
            $Event.MessageData.StandardOutput.AppendLine($EventArgs.Data)
        }
    }

    $ProcessErrorEventAction = { 
        if (![string]::IsNullOrEmpty($EventArgs.Data)){
            $Event.MessageData.StandardError.AppendLine($EventArgs.Data)
        }
    }

    $OutputDataReceivedEvent = Register-ObjectEvent -SourceIdentifier $StandardOutputSourceIdentifier -InputObject $Process -EventName "OutputDataReceived" -Action $ProcessOutputEventAction -messagedata $messagedata 
    $ErrorDataReceivedEvent = Register-ObjectEvent -SourceIdentifier $StandardErrorSourceIdentifier -InputObject $Process -EventName "ErrorDataReceived" -Action $ProcessErrorEventAction -messagedata $messagedata 

    $executionTime = Measure-Command {
        $Process.Start() | Out-Null
        $Process.BeginErrorReadLine()
        $Process.BeginOutputReadLine()
        $Process.WaitForExit()
    }
    
    Start-Sleep -Milliseconds 200 

    Unregister-Event -SourceIdentifier $StandardOutputSourceIdentifier
    Unregister-Event -SourceIdentifier $StandardErrorSourceIdentifier

    return [pscustomobject]@{
        commandTitle = $commandTitle
        ExitCode = $Process.ExitCode; 
        stdout = $messagedata.StandardOutput.ToString(); 
        stderr = $messagedata.StandardError.ToString(); 
        ExitTime = $Process.ExitTime;
        StartTime = $Process.StartTime;
        executionTime = $executionTime
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

    $Scenarios | Where-Object{[string]::IsNullOrEmpty($ScenarioFilter) -or $_.ScenarioName -match $ScenarioFilter -or $demoName -eq $ScenarioFilter} | ForEach-Object {
        $scenario = $_
        $renderOptions | ForEach-Object {
            $option = $_
            $showtext = ($option -eq 'text')
            $scenarioName =  iif ($option -eq 'png') "$($scenario.ScenarioName)" "$($scenario.ScenarioName)_$($option)"
            $scenarioOutputFolder = Join-Path $demoOutputFolder "$($option)\$($scenarioName)"
        
            CreateFolderIfNeeded $scenarioOutputFolder
            $ext = IIF -If ($option -eq 'stl')  -Right 'stl' -Wrong 'png'
            write-host "Processing $scenarioName option:$($option)" -ForegroundColor Yellow
            if($CleanFolder){
                Remove-Item (join-path $scenarioOutputFolder "\*.$($ext)")
            }

            #invoke openscad
            $cmdArgs = "" 
            $animateCount = (($scenarioCount -eq -1) | IIF -Right ($scenario.Count) -Wrong ([Math]::Min($scenario.Count, $scenarioCount)))
    
            $target = Join-Path $scenarioOutputFolder "$($scenario.ScenarioName).$($ext)"
            if($SetFilePath)
            {
                $cmdArgs = "-o `"$($target)`""
                #--camera=translatex,y,z,rotx,y,z,dist
                $cmdArgs = $cmdArgs += " --imgsize 4096,3072"#" --imgsize 1024,768"4096,3072
                if($scenario.Count -gt 1)
                {
                    $cmdArgs = $cmdArgs += " --animate $($animateCount)"
                }
                #--csglimit arg               =n -stop rendering at n CSG elements when exporting png
                $cmdArgs = $cmdArgs += " --csglimit 2000000"
            }

            $cmdArgs = $cmdArgs += " -D `"scenario=`"`"$($scenario.ScenarioName)`"`"`""
            $cmdArgs = $cmdArgs += " -D `"showtext=$($showtext.ToString().tolower())`""
            $cmdArgs = $cmdArgs += " --colorscheme Tomorrow" #BeforeDawn
        
            $cmdArgs += " $($scadScriptPath)"
            Write-Host  $cmdArgs
            $executionResult = (Start-ProcessWithOutputs -commandTitle $scenarioName -commandPath $script:ScadExePath -ArgumentList $cmdArgs)
                            write-warning  "stderr: $($executionResult.stderr)"
            write-host "openscad executionTime: $($executionResult.executionTime)"

            if($executionResult.stderr -cmatch 'ERROR\:\s' -or $executionResult.ExitCode -ne 0){
                write-warning "found error"
                write-warning  "stderr: $($executionResult.stderr)"
            }
            else {
                if($option -ne 'stl' -and $scenarioCount -eq -1)
                {
                    Create-Gif -FolderPath $scenarioOutputFolder -Name "$($demoName)-$($scenarioName)"
                }
            }
        }
    }
}

Create-ImageForDemo -ScadScriptPath $ScadScriptPath -outputFolder $outputFolder  -ScenarioFilter $ScenarioFilter -renderOptions $renderOptions
#Create-ImageForDemo -ScadScriptPath  (Join-Path $demoFolder 'gridfinity_drawer_demo.scad') -outputFolder $outputFolder -ScenarioFilter $script:ScenarioFilter -renderOptions $renderOptions
#Create-ImageForDemo -ScadScriptPath  (Join-Path $demoFolder 'gridfinity_basic_cup_demo.scad') -outputFolder $outputFolder -ScenarioFilter $script:ScenarioFilter -renderOptions $renderOptions
#Create-ImageForDemo -ScadScriptPath  (Join-Path $demoFolder 'gridfinity_baseplate_demo.scad') -outputFolder $outputFolder -ScenarioFilter $script:ScenarioFilter -renderOptions $renderOptions
#Create-ImageForDemo -ScadScriptPath  (Join-Path $demoFolder 'gridfinity_item_holder_demo.scad') -outputFolder $outputFolder -ScenarioFilter $script:ScenarioFilter -renderOptions $renderOptions
#Create-ImageForDemo -ScadScriptPath  (Join-Path $demoFolder 'gridfinity_tray_demo.scad') -outputFolder $outputFolder -ScenarioFilter $script:ScenarioFilter -renderOptions $renderOptions

#Create-Gif '\\10.0.0.11\general\projects\3d_printing\gridfinity\generated\temp' 'floor_demo'
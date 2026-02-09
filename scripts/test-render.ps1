Param(
    [string]$OpenScadPath,
    $ScadScriptFolders = @(
            (Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName
            ),
    [switch]$saveResults,
    [string]$outputScriptFolder = 'test_results'
)

if (-not $OpenScadPath) {

    # Try PATH first
    $cmd = Get-Command 'openscad.exe' -ErrorAction SilentlyContinue

    if ($cmd) {
        $OpenScadPath = $cmd.Source
    }
    else {
        # Common Windows install paths
        $candidates = @(
            $OpenScadPath,
            $env:OPENSCAD_PATH,
            "C:\tools\OpenSCAD\openscad.exe",
            "C:\Program Files\OpenSCAD\openscad.exe",
            "C:\Program Files (x86)\OpenSCAD\openscad.exe"
        )

        foreach ($path in $candidates) {
            if (![string]::IsNullOrEmpty($path) -and (Test-Path -Path $path)) {
                $OpenScadPath = $path
                break
            }
        }
    }
}

if (-not $OpenScadPath) {
    throw "OpenSCAD not found. Set OPENSCAD_PATH or pass -OpenScadPath"
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

$ErrorActionPreference = "Stop"

$failed = $false
$ScadScriptFolders |ForEach-Object {
    $ScadScriptFolder = $_
    write-host "path: $ScadScriptFolder"
    $outputScriptFolderPath = Join-Path $ScadScriptFolder $outputScriptFolder
    if($saveResults) {
        if(!(Test-Path -Path $outputScriptFolderPath)) {
            New-Item -ItemType Directory -Path $outputScriptFolderPath -Force
        }
    }

    Get-ChildItem -LiteralPath $ScadScriptFolder -Filter *.scad | ForEach-Object {
    $scadScriptPath = $_.FullName

    Write-Host "`r`nTesting $($_.FullName)"
    
    $cmdArgs = ""
    $cmdArgs += " --export-format binstl"
    $cmdArgs += " --enable textmetrics"
    $cmdArgs += " --backend Manifold"

    if($saveResults) {
        $cmdArgs += " -o `"$(Join-Path $outputScriptFolderPath $_.BaseName).stl`""
    }
    else {
        $cmdArgs += " -o NUL"
    }
    $cmdArgs += " $($scadScriptPath)"

    $executionResult = (Start-ProcessWithOutputs -commandPath $script:OpenScadPath -ArgumentList $cmdArgs)

    write-host "openscad executionTime: $($executionResult.executionTime)"

    # Check for warnings/errors
    if ($executionResult.stderr -match '(?im)^(warning|error):' -or $executionResult.ExitCode -ne 0) {
        Write-Warning "OpenSCAD warnings/errors in $($_.Name)"
        write-warning "stderr: $($executionResult.stderr)"
        $failed = $true
    } else {
        write-Host "ExitCode: $($executionResult.ExitCode)"
        #write-Host "stderr: $($executionResult.stderr)"
    }
}}

if ($failed) {
    throw "OpenSCAD validation failed"
}

Write-Host "All OpenSCAD files passed."
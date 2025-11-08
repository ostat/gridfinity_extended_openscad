#Combine an Openscad scripts and its included/use files in to a single script
#
#Considerations, by pulling in all files to a single file, we are converting all use statements to includes.
#It also breaks the order of loading functions. Scripts need to be update to make it work.
#
#From the OpenSCAD doco.
#    include <filename> acts as if the contents of the included file were written in the including file, and
#    use <filename> imports modules and functions, but does not execute any commands other than those definitions.
#
#For use imports, if there is a function call, it would now get called so we need a way to prevent that:
#Manually add a comment to imported fileso we know what lines to to remove to prevent the execution
#i.e. basic_cup();//execution point
#
#The injected files need to go after the config block. To detect this we look for a module call.
#recommended to add this at the end of the config block
# module end_of_customizer_opts() {}

$script:SourceFolder = (Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName
$OutputFolder = (join-path $script:SourceFolder 'combined')

$script:LinkedFiles = [ordered]@{}

function Write-CustomWarning ([string]$message, $pad = " ", $padCount = 0)
{
    Write-CustomHost -message $message -Warning -pad $pad -padCount $padCount
}

function Write-CustomHost ([string]$message, [switch]$Warning, $ForegroundColor, $pad = " ", $padCount = 0)
{
    $padding 
    if($padCount -gt 0){
        $padding = "$(-join ($pad * $padCount)) $($padCount): "
    }
    if($Warning) {
        Write-Host "$($padding)WARNING: $($message)" -ForegroundColor DarkYellow
    } else {
        if($ForegroundColor -eq $null){
            Write-Host "$($padding)$($message)"
        }else {
            Write-Host "$($padding)$($message)" -ForegroundColor $ForegroundColor
        }
    }
}

function Get-CombinedOpenScadFile([string]$ScadFilePath, [switch]$Child, [int]$childCount = 1){
    [string[]]$fileLines = @()
    
    #If its a child file add the file to the linked files like.
    if($Child) {$script:LinkedFiles[$ScadFilePath] = @()}
    $scadFile = Get-Item -LiteralPath $ScadFilePath
    Write-CustomHost "processing $($ScadFilePath) includes:$($script:LinkedFiles.Count) isChild:$($Child)" -ForegroundColor Yellow  -padCount $childCount
    
    #open the current file and read it contence
    Get-Content -LiteralPath $ScadFilePath -Encoding utf8 | ForEach-Object {
        #If the line is an include, process that file
        if($_ -imatch '^\s?(use|include) <(.*)>'){
            $includeType = $Matches[1]
            Write-CustomHost "Matched $($Matches[1]) path $($Matches[2])" -ForegroundColor Green -padCount $childCount
            [string]$childPath = resolve-path (Join-Path $scadFile.Directory.FullName $Matches[2])
            if($script:LinkedFiles.Contains($childPath)){
                Write-CustomHost "Path already included" -ForegroundColor Gray -padCount $childCount
            } else {
                $script:LinkedFiles[$childPath] = (Get-CombinedOpenScadFile -ScadFilePath $childPath -childCount ($childCount+1) -Child)
                
                # Write-CustomHost "Cleaning child script '$($Matches[2])'" -padCount $childCount
                 
                #clean child files as needed
                #by pulling all files in to one, we are essentually treating use like an Include. This can and will break things.
                #$lines = @()
                #$script:LinkedFiles[$childPath] | ForEach-Object{
                #    #Manually add a comment to user file so we know what like to remove to prevent the execution
                #    #i.e. basic_cup();//execution point
                #    if($includeType -ieq 'use' -and $_ -imatch '.*\/\/execution\spoint$') {
                #        write-CustomWarning "for 'use' files prevent execution call within the file. $($childPath)" -padCount $childCount
                #        Write-CustomHost "removing line '$($_)'" -padCount $childCount
                #    #i.e. /* [Connector 3 - Flange] */
                #    } elseif($_ -imatch '^\s*\/\*\s*\[.*\]\s*\*\/\s*$') {
                #        Write-CustomWarning "removing line [] from '$($_)' within the file. $($childPath)" -padCount $childCount
                #        $lines += $_.Replace('[','').Replace(']','')
                #    }else {
                #        $lines += $_
                #    }
                #}
                #$script:LinkedFiles[$childPath] = $lines
            }
        }
        else{
            #all lines other than use an include lines are added to the list to be returned,
            $fileLines += $_
        }
    }
    Write-CustomHost "processing end $($ScadFilePath) linesFound:$($fileLines.Count) isChild:$($Child)" -ForegroundColor Yellow  -padCount $childCount
  
    #If its a child file, return the lines up the chain
    if($Child){
        return $fileLines
    }

    #clean child files as needed
    #by pulling all files in to one, we are essentually treating use like an Include. This can and will break things.

    # Loop through the OrderedDictionary
    $linkedFileKeys = @($script:LinkedFiles.Keys)
    $linkedFileKeys | ForEach-Object {
        $key  = $_
        Write-CustomHost "Cleaning LinkedFile '$($key)'" -padCount $childCount
         
        $lines = @()
        $script:LinkedFiles[$key] | ForEach-Object{
            #Manually add a comment to user file so we know what like to remove to prevent the execution
            #i.e. basic_cup();//execution point
            if($includeType -ieq 'use' -and $_ -imatch '.*\/\/execution\spoint$') {
                write-CustomWarning "for 'use' files prevent execution call within the file. $($childPath)" -padCount $childCount
                Write-CustomHost "removing line '$($_)'" -padCount $childCount
            #i.e. /* [Connector 3 - Flange] */
            } elseif($_ -imatch '^\s*\/\*\s*\[.*\]\s*\*\/\s*$') {
                Write-CustomWarning "removing line [] from '$($_)' within the file. $($childPath)" -padCount $childCount
                $lines += $_.Replace('[','').Replace(']','')
            }else {
                $lines += $_
            }
        }
        $script:LinkedFiles[$key] = $lines
    }

    #Processing all child files has completed, create the combined content
    [string[]]$combinedLines = @()
    #add a comment to the top of the combined file so we know when it was 'compiled'
    $combinedLines += '///////////////////////////////////////'
    $combinedLines += "//Combined version of '$($scadFile.Name)'. Generated $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    $combinedLines += '///////////////////////////////////////'
    
    $injected = $false
    $fileLines | ForEach-Object {
        
        if($_ -match '^module\s?.*?\(\)\s?\{\}\s?$' -and $injected -eq $false)
        {
            $injected = $true
            Write-CustomHost "match Module.... '$($_)'" -ForegroundColor DarkCyan -padCount $childCount
            $combinedLines += $_
            $script:LinkedFiles.Keys | ForEach-Object {
                $filename = $(Split-Path $_ -leaf)
                Write-CustomHost "Injecting file $($filename)" -padCount $childCount
                $combinedLines += "//Combined from path $($filename)"
                $combinedLines += $script:LinkedFiles[$_]
                $combinedLines += "//CombinedEnd from path $($filename)"
            }
        }
        else{
            $combinedLines += $_
        }
    }
    return $combinedLines
}

function Save-CombinedOpenScadFile([string]$ScadFilePath, [string]$OutputFolder){
    $script:LinkedFiles = [ordered]@{}

    $inputFilePath = $ScadFilePath
    $file = Get-Item -LiteralPath $inputFilePath 
    Write-host "Creating combined file for $($file.Name)" -ForegroundColor Green
    $resulLines = (Get-CombinedOpenScadFile -ScadFilePath $inputFilePath)
    $resulLines = $resulLines | where {$_ -ne $null} | ForEach-Object { $_.ToString() }
    Write-host "found lines $($resulLines.count )"
    $output_path = (Join-Path $OutputFolder $file.Name)
    #$resulLines | Out-File $output_path -Encoding utf8 

    #$MyRawString = Get-Content -Raw $MyPath
    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
    [System.IO.File]::WriteAllLines($output_path, $resulLines, $Utf8NoBomEncoding)
}

cls

Get-ChildItem $script:SourceFolder -Filter '*.scad' | ForEach-Object {
    Save-CombinedOpenScadFile -ScadFilePath $_.FullName -OutputFolder $OutputFolder
}

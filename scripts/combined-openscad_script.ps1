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
function Get-CombinedOpenScadFile([string]$ScadFilePath, [switch]$Child){
    [string[]]$fileLines = @()
    
    #If its a child file add the file to the linked files like.
    if($Child) {$script:LinkedFiles[$ScadFilePath] = @()}
    $scadFile = Get-Item -LiteralPath $ScadFilePath
    Write-Host "processing $($ScadFilePath) includes:$($script:LinkedFiles.Count) isChild:$($Child)" -ForegroundColor Yellow
    
    #open the current file and read it contence
    Get-Content -LiteralPath $ScadFilePath -Encoding utf8 | ForEach-Object {
        #If the line is an include, process that file
        if($_ -imatch '^\s?(use|include) <(.*)>'){
            $includeType = $Matches[1]
            Write-Host "Matched $($Matches[1]) path $($Matches[2])" -ForegroundColor Green
            [string]$childPath = resolve-path (Join-Path $scadFile.Directory.FullName $Matches[2])
            if($script:LinkedFiles.Contains($childPath)){
                Write-Host "Path already included" -ForegroundColor Gray
            } else {
                $script:LinkedFiles[$childPath] = (Get-CombinedOpenScadFile -ScadFilePath $childPath -Child)
                
                if($includeType -ieq 'use'){
                    #by pulling all files in to one, we are essentually treating use like an Include. This can and will break things.
                    write-warning "for 'use' files prevent execution call within the file. $($childPath)"
                    $lines = @()
                    $script:LinkedFiles[$childPath] | ForEach-Object{
                        #Manually add a comment to user file so we know what like to remove to prevent the execution
                        #i.e. basic_cup();//execution point
                        if($_ -imatch '.*\/\/execution\spoint$') {
                            Write-Host "removing line '$($_)'"
                        }
                        else
                        {
                            $lines += $_
                        }
                    }
                    $script:LinkedFiles[$childPath] = $lines
                }
            }
        }
        else{
            #all lines other than use an include lines are added to the list to be returned,
            $fileLines += $_
        }
    }
    Write-Host "processing end $($ScadFilePath) linesFound:$($fileLines.Count) isChild:$($Child)" -ForegroundColor Yellow
  
    #If its a child file, return the lines up the chain
    if($Child){
        return $fileLines
    }

    #Processing all child files has completed, create the combined content
    [string[]]$combinedLines = @()
    #add a comment to the top of the combined file so we know when it was 'compiled'
    $combinedLines += '///////////////////////////////////////'
    $combinedLines += "//Combined version of '$($scadFile.Name)'. Generated $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    $combinedLines += '///////////////////////////////////////'
     
    $fileLines | ForEach-Object {
        if($_ -match '^module\s?.*?\(\)\s?\{\}\s?$')
        {
            Write-Host "match Module.... '$($_)'" -ForegroundColor DarkCyan
            $combinedLines += $_
            $script:LinkedFiles.Keys | ForEach-Object {
                $filename = $(Split-Path $_ -leaf)
                Write-Host "Injecting files $($filename)"
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

    $inputFilePath = $ScadFilePath
    $file = Get-Item -LiteralPath $inputFilePath 
    Write-host "Creating combined file for $($file.Name)" -ForegroundColor Green
    $resulLines = Get-CombinedOpenScadFile -ScadFilePath $inputFilePath

    $resulLines | Out-File (Join-Path $OutputFolder $file.Name) -Encoding utf8
}

Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_basic_cup.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_drawers.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_socket_holder.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_tray.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_item_holder.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_baseplate.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_cutlerytray.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_silverware.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_glue_stick.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_vertical_divider.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_chess.scad') -OutputFolder $OutputFolder
Save-CombinedOpenScadFile -ScadFilePath (join-path $script:SourceFolder 'gridfinity_baseplate_flsun_q5.scad') -OutputFolder $OutputFolder
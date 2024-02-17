#Combine an Openscad scripts in to a single script

#$InputFile = 'gridfinity_basic_cup.scad'
$OutputCombinedFile= 'C:\src\ostat\gridfinity_extended_openscad\gridfinity_basic_cup_combined.scad'


$script:LinkedFiles = [ordered]@{}
function Get-CombinedOpenScadFile([string]$ScadFilePath, [switch]$Child){
    [string[]]$fileLines = @()
    
    if($Child) {$script:LinkedFiles[$ScadFilePath] = @()}
    $scadFile = Get-Item -LiteralPath $ScadFilePath
    Write-Host "processing $($ScadFilePath) includes:$($script:LinkedFiles.Count)" -ForegroundColor Yellow
    
    Get-Content -LiteralPath $ScadFilePath -Encoding utf8 | ForEach-Object {
        if($_ -imatch '^\s?(use|include) <(.*)>'){
            $includeType = $Matches[1]
            Write-Host "Matched $($Matches[1]) path $($Matches[2])" -ForegroundColor Green
            [string]$childPath = resolve-path (Join-Path $scadFile.Directory.FullName $Matches[2])
            if($script:LinkedFiles.Contains($childPath)){
                Write-Host "Path already included" -ForegroundColor Gray
            } else {
                $script:LinkedFiles[$childPath] = (Get-CombinedOpenScadFile -ScadFilePath $childPath -Child)
                if($includeType -ieq 'use'){
                    write-host "for 'use' files prevent execution call within the file. $($childPath)"
                    $lines = @()
                    $script:LinkedFiles[$childPath] | ForEach-Object{
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
            $fileLines += $_
        }
    }

    if($Child){
        return $fileLines
    }

    [string[]]$combinedLines = @()
    $combinedLines += '///////////////////////////////////////'
    $combinedLines += "//Combined version of '$($scadFile.Name)'. Generated $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    $combinedLines += '///////////////////////////////////////'

    $fileLines | ForEach-Object {
        if($_ -match '^module\s?.*?\(\)\s?\{\}\s?$')
        {
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

$resulLines = Get-CombinedOpenScadFile -ScadFilePath 'C:\src\ostat\gridfinity_extended_openscad\gridfinity_basic_cup.scad'
$resulLines | Out-File $OutputCombinedFile -Encoding utf8
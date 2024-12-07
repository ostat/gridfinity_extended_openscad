#version 2022-10-04

$Script:Widths = ( 0.5, 1, 1.5, 2, 3, 4, 5, 6)
$Script:Depths = ( 1, 2, 3, 4, 5, 6)
$Script:Heights = ( 2, 2.5, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37)

$Script:MagnetDiameter = 6.5
$Script:ScrewDepth = 6
$Script:Labels = ('disabled', 'full', 'left', 'right', 'center')
$Script:Fingerslides = ('none', 'rounded')
$Script:EfficientFloors = ('off', 'on', 'smooth')
$Script:FlatBases = ($true, $false)
$Script:BaseAttachments = ('none', 'magnet','magnetscrew')
$Script:MaxChambers = 6

$Script:HalfPitchs = ($true, $false)

$Script:ForceRegeneration = $false

$script:SourceFolder = (Get-Item $MyInvocation.MyCommand.Source).Directory
$script:ScadScriptPath = Join-Path $SourceFolder 'gridfinity_basic_cup.scad'
$script:ScadExePath = 'C:\Program Files\OpenSCAD\openscad.exe'

function CreateFolderIfNeeded([string] $path) {

    if(!(Test-Path -LiteralPath $path))
    {
        New-Item $path -ItemType Directory
    }
}

function number-tostring($number){
    if([decimal]$number -ne [int]$number){
        ([decimal]$number).ToString("00.0")
    } else {
        ([decimal]$number).ToString("00")
    }
}

Function IIf($If, $Right, $Wrong) {if ($If) { return $Right } else { return $Wrong }}

#Create CSV of the needed files
$Script:Heights | ForEach-Object { 
    $Height = $_ 
    $heightlist = $Script:Widths | ForEach-Object { 
        $Width = $_
        $chambers = @(1..([math]::Min($Script:MaxChambers, $Width*2)))
        
        $Script:chambers | ForEach-Object { 
            $chamber = $_ 
        $Script:Depths | ForEach-Object { 
            $Depth = $_ 
        $Script:Labels | Where-Object {(($chamber -eq 1 -or ($chamber -eq 2 -and $_ -eq 'center')) -and $Width -ge 1 ) -or $_ -eq 'full' -or $_ -eq 'disabled'} | ForEach-Object { 
            $Label = $_ 

            if($Label -eq 'left' -or $Label -eq 'right' -or $Label -eq 'center'){
                $labelWidth = [math]::Min(2.0, $Width/2) #For a subwith it should be 2 or less
            }
            if($Label -eq  'full')
            {
                $Label = 'left'
                $labelWidth = 0
            }
            if($Label -eq 'disabled')
            {
                $labelWidth = 0
            }

        $Script:Fingerslides | ForEach-Object { 
            $Fingerslide = $_ 
        $Script:EfficientFloors | Where-Object {($Fingerslide -eq 'none' -and $chamber -eq 1 -and $Label -eq 'disabled') -or $_ -ne 'smooth' } | ForEach-Object { 
            $EfficientFloor = $_ 
        $Script:HalfPitchs | ForEach-Object { 
            $HalfPitch = $_ 
        $Script:FlatBases | ForEach-Object { 
            $FlatBase  = $_ 
        $Script:BaseAttachments | ForEach-Object {
            $BaseAttachment = $_ 
            #| Where-Object {
                #for regular, no attachment only blank box, 
                #(($EfficientFloor -eq $false -and (($Fingerslide -eq 'none' -and $chamber -eq 1 -and $Label -eq 'disabled') -or $_ -ne 'off')) -or `
                #for light/efficient floor attachment only blank box, 
                #($EfficientFloor -eq $true -and (($Fingerslide -eq 'none' -and $chamber -eq 1 -and $Label -eq 'disabled') -or $_ -eq 'off')))
                #} | ForEach-Object { 

       
            #for plain bin (no finger slide, no dividers, no labels), support no attachment, magnet only and magnetscrew
            #for non plain bin (finger slide, or divider or label)
                #efficient is no magnet no screw only
                #non efficient is  magnet and screw only
            $generate = $true
            if($FlatBase -eq $true){
                if($chamber -ne 1 -or $Label -ne 'disabled' -or $Fingerslide -ne 'none' -or $BaseAttachment -ne 'none' -or $HalfPitch -ne $false) {
                    $generate = $false
                }
                else{
                    Write-Verbose "success FlatBase=$($FlatBase) chamber=$($chamber) Label=$($Label) Fingerslide=$($Fingerslide) BaseAttachment=$($BaseAttachment) HalfPitch=$($HalfPitch)"
                }
            }
            elseif($Fingerslide -eq 'none' -and $chamber -eq 1 -and $Label -eq 'disabled') {
                if($BaseAttachment -eq 'screw'){
                    $generate = $false
                    #continue
                }
            } else {
                if($EfficientFloor) {
                    if($BaseAttachment -ne 'none') {
                        $generate = $false
                        #continue
                    }          
                } else { 
                    if($BaseAttachment -ne 'magnetscrew') {
                        $generate = $false
                        #continue
                    }          
                }
            }

            #Check if bin is symetrical, if so only do where depth is greater than width.
            if($Fingerslide -eq 'none' -and $chamber -eq 1 -and $Label -eq 'disabled')
            {
                if($Depth -lt $Width)
                {
                    Write-Verbose "Bin is symetrical and Depth is < width. Depth:$($Depth) -lt Width:$($Width) Fingerslide:$($Fingerslide) chamber:$($chamber) Label:$($Label))"
                    $generate = $false
                }
            }
            
            #CreateGridfinityCup -Width $Width -Depth $Depth -Height $Height `
            #                -MagnetDiameter $Script:MagnetDiameter -ScrewDepth $Script:ScrewDepth -Chamber $chamber `
            #                -Label $Label -Fingerslide $Fingerslide -HalfPitch $Script:HalfPitch
            if($generate) {
                return [pscustomobject]@{
                    Width = $Width
                    Depth =$Depth
                    Height =$Height
                    MagnetDiameter = (IIf ($BaseAttachment -ieq 'magnet' -or $BaseAttachment -ieq 'magnetscrew') $Script:MagnetDiameter 0)
                    ScrewDepth = (IIf ($BaseAttachment -ieq 'screw' -or $BaseAttachment -ieq 'magnetscrew') $Script:ScrewDepth 0)
                    Chamber = $chamber
                    Label = $Label
                    LabelWidth = $LabelWidth
                    Fingerslide = $Fingerslide
                    HalfPitch = $HalfPitch
                    EfficientFloor = $EfficientFloor
                    FlatBase = $FlatBase
                }
            }
        }}}}}}}}
    }
    #$heightlist | Format-List -Force
    write-host "for height $(number-tostring $Height) we have $($heightlist.Count)"
    $heightlist | Export-Csv -Path (Join-Path $script:SourceFolder "..\generated\basiccup\height$(number-tostring $Height).csv") -NoTypeInformation
}

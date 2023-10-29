cls
# Turns the item size list in the snippits that can be put in to scripts.
$path = Join-Path (Split-Path -Parent $PSCommandPath) 'ItemSizeList.csv'
$list = @(Get-Content -Path $path | ConvertFrom-Csv)
$list | Group-Object -Property type | ForEach-Object {
    $category = $_
    $options = [string]::Join(', ', ($category.Group | ForEach-Object { "`"$($_.code)`":`"$($_.description)`"" }))


    #
    Write-Host "$($category.Name) Openscad config"
    Write-Host "$($category.Name) = `"custom`"; // [ custom:`"Custome`", $($options)]"
    Write-Host "$($category.Name) Openscad lookup"
    #   name == "aaaa" ? ["round", 8.3, 0] : 
    $category.Group | ForEach-Object {  Write-Host "  name == `"$($_.code)`" ? [$($_.width), $($_.thickness), $($_.depthneeded), $($_.height), `"$($_.shape)`"] :" }

    Write-Host "$($category.Name) markdown"
    $category.Group | ForEach-Object {  Write-Host "``$($_.code)`` | $($_.width) | $($_.thickness) | $($_.depthneeded) | $($_.height) | $($_.shape) | $($_.source) |" }}


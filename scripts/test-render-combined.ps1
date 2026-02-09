Param(
    [string]$OpenScadPath,
    $ScadScriptFolders = @(
            (join-path (Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName 'combined')
            ),
    [switch]$saveResults,
    [string]$outputScriptFolder = 'test_results'
)

.\test-render.ps1 `
    -OpenScadPath $OpenScadPath `
    -ScadScriptFolders $ScadScriptFolders `
    -saveResults $saveResults `
    -outputScriptFolder $outputScriptFolder
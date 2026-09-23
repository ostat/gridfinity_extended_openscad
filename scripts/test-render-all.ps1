Param(
    [string]$OpenScadPath,
    $ScadScriptFolders = @(
            (Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName,
            (join-path (Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName 'combined'),
            (join-path (Get-Item $MyInvocation.MyCommand.Source).Directory.Parent.FullName 'demos')
            ),
    [switch]$saveResults,
    [string]$outputScriptFolder = 'test_results'
)

.\test-render.ps1 `
    -OpenScadPath $OpenScadPath `
    -ScadScriptFolders $ScadScriptFolders `
    -saveResults $saveResults `
    -outputScriptFolder $outputScriptFolder

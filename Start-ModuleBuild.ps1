param(
    [version]$Version = "1.0.0"
)
#Requires -Module ModuleBuilder

$params = @{
    SourcePath = "$PSScriptRoot\src\ArgParser.psd1"
    #CopyPaths = @("$PSScriptRoot\readme.md")
    #Version = $Version
    UnversionedOutputDirectory = $true
}
Build-Module @params

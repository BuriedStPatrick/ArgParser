# ArgParser

Write intuitive CLIs with PowerShell. ArgParser helps with building command objects from standard string arguments. Useful for when you want to write in PowerShell but don't love the way arguments are handled natively.

Essentially, if you prefer to build something like this:

```powershell
my-cli <command> <resource> <values> <flags>
```

Over this:

```powershell
Start-MyModuleResourceAction -Value -Switch
```

Then this module might be for you.

## Installation

1. Build this repo (See [Build section](#Build))
2. Import the module from your scripts or wherever you need it:

```powershell
Import-Module <repo>/Output/ArgParser/ArgParser.psd1
```

## Examples & Usage

```powershell
## Check if user added a --version|-v switch
## Example inputs:
# $ ./script.ps1 --version
# $ ./script.ps1 -v
$version = "1.0.0"
$hasVersionSwitch = Get-ArgsParserHasSwitch `
    -Name "version" `
    -ShortName "v" `
    -Arguments $args

if ($hasVersionSwitch) {
    Write-Host "Version: $version"
}
```

```powershell
## Get a string value --name|-n
## Example input:
# $ ./script.ps1 --name Patrick
# $ ./script.ps1 --name=Patrick
# $ ./script.ps1 -n Patrick
# $ ./script.ps1 -n=Patrick
$name = Get-ArgsParserStringValue `
    -Name "name" `
    -ShortName "n" `
    -Arguments $args

Write-Host "Hello $name!"
```

```powershell
## Get multiple string values --name|-n
## Example input:
# $ ./script.ps1 --names Patrick -n Grønbæch --names=Christensen
$names = Get-ArgsParserStringValues `
    -Name "names" `
    -ShortName "n" `
    -Arguments $args

$names | ForEach-Object {
    Write-Host $_
}
## Outputs:
# Patrick
# Grønbæch
# Christensen
 #>
```

Check the `/examples` directory for more info on how to parse arguments.

## Build

1. Clone this repo
2. Run `./Install-Requirements.ps1` to install the Module-Builder module used to "compile" this project
3. Run `./Start-ModuleBuild.ps1` to build the project into the `./Output` directory

## Testing

To simply run all tests, run `./Start-Tests.ps1`. To run a file-watcher that runs all tests and live updates the results when source files change, run `./Start-TestsWatcher.ps1`.


## Debugging

You should be able to debug all the code inside `./src/` using a basic debugger like the one included in VSCode. Otherwise I recommend writing unit tests inside the `./tests/` directory.

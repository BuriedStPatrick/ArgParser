# ArgParser

Write intuitive CLIs with PowerShell. ArgParser helps with building command objects from standard string arguments. Useful for when you want to write in PowerShell but don't love the way arguments are handled natively.

Essentially, if you prefer to build something like this:

```powershell
my-cli <command> <resource> <flags>
```

Over this:

```powershell
Start-MyModuleResourceAction -Flags
```

Then this module might be for you.

## Installation

You can simply install from PSGallery:

```powershell
Install-Module ArgParser
```

But if you prefer from source code:

1. Build this repo (See [Build section](#Build))
2. Import the module from your scripts or wherever you need it:

```powershell
Import-Module <repo>/Output/ArgParser/ArgParser.psd1
```

## Build

1. Clone this repo
2. Run `./Install-Requirements.ps1` to install the Module-Builder module used to "compile" this project
3. Run `./Start-ModuleBuild.ps1` to build the project into the `./Output` directory

## Testing

To simply run all tests, run `./Start-Tests.ps1`. To run a file-watcher that runs all tests and live updates the results when source files change, run `./Start-TestsWatcher.ps1`.


## Debugging

You should be able to debug all the code inside `./src/` using a basic debugger like the one included in VSCode. Otherwise I recommend writing unit tests inside the `./tests/` directory.

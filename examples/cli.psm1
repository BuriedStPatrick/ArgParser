#####################################################
# Example CLI                                       #
# "Abuses" Set-Alias to function as a root-command  #
#####################################################

# Import the ArgParser module
Import-Module (Join-Path $PSScriptRoot .. Output ArgParser)

function Invoke-MyCli() {
    # Parse arguments into an array, assume arguments space delimited
    try {
        $arguments = $args.Split(' ')
    } catch {
        # Unable to parse arguments which probably means nothing was entered beyond the root command 'my-cli'
        # Print a user-friendly message, perhaps the help documentation
        Write-Host "Usage: my-cli <command> <flags>"
        return
    }

    # Hack: Force $arguments to be an array even if it's only a single entry.
    # PowerShell treats single entry arrays as strings otherwise.
    if (($arguments -is [string])) {
        $arguments = @($arguments)
    }

    # Print the version of the CLI if requested
    if (Get-ArgParserHasSwitch -Name "version" -ShortName "v" -Arguments $arguments) {
        Write-Host "Version: 1.0.0.0"
    }

    # Print helpful documentation of the CLI if requested, break out of application flow
    if (Get-ArgParserHasSwitch -Name "help" -ShortName "h" -Arguments $arguments) {
        Write-Host "Usage: my-cli <command> <flags>"
        return
    }

    # Print a greeting if user entered their name with either format:
    # --name <name>
    # --name=<name>
    # -n <name>
    # -n=<name>
    $name = Get-ArgParserStringValue -Name "name" -ShortName "n" -Arguments $arguments
    if ($name) {
       Write-Host "Hello, $name! You have been reported to the authorities, have a great day :D"
    }
}

# Put the name of the "root" command of your CLI here as an alias that invokes the root command "Invoke-MyCli"
# Here we can invoke the commands via the format:
# $ my-cli <command> <flags>
Set-Alias my-cli Invoke-MyCli
Export-ModuleMember -Function Invoke-MyCli -Alias my-cli

# Examples could look something like this, it's all up how you want to design your CLI:
# $ my-cli --version
# $ my-cli get resource --id 1234
# $ my-cli update resource --id 1234 --force
# $ my-cli delete resource --id 1234 -F

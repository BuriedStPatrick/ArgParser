function Get-HasSwitch {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Name,

        [Parameter(Mandatory)]
        [string] $ShortName,

        [Parameter(Mandatory = $false)]
        [string[]] $Arguments
    )

    if ($Arguments.Length -lt 1) {
        return $false
    }

    if ($Arguments.Contains("--$Name")) {
        return $true
    }

    # Look for arguments with short flags like (where 'x' is the desired flag):
    # -x
    # -xG
    # -Sx
    foreach ($argument in $Arguments) {
        # Is not a short flag, skip this one
        if (!($argument.StartsWith("-") -and !($argument.StartsWith("--")))) {
            continue;
        }

        if (!($argument.Contains($ShortName))) {
            return $false
        }

        return $true
    }

    return $false
}

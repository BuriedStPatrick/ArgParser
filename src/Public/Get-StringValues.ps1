function Get-StringValues
{
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Name,

        [Parameter(Mandatory)]
        [string] $ShortName,

        [Parameter(Mandatory)]
        [string[]] $Arguments
    )

    $index = 0

    # Positional arguments
    return $Arguments | ForEach-Object {
        $value = $null
        if ($_ -eq "--$Name" -or $_ -eq "-$ShortName") {
            try {
                $value = $Arguments[$index + 1]
            } catch { }
        }

        if ($_.StartsWith("--$Name=") -or $_.StartsWith("-$ShortName=")) {
            $value = $_.Split('=')[1]
        }

        $index++;
        return $value
    } | Where-Object { !($_ -eq $null) }
}

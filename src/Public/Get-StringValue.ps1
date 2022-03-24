function Get-StringValue
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

    # Positional
    $index = [Array]::IndexOf($Arguments, "--$Name")
    $index = $index -gt -1 `
        ? $index `
        : [Array]::IndexOf($Arguments, "-$ShortName")

    if ($index -gt -1) {
        $valueIndex = $index + 1
        try {
            return $Arguments[$valueIndex]
        } catch {
            return $null
        }
    }

    # Delimited
    $argument = ($Arguments | Where-Object { ($_ -ilike "--$Name=*") -or ($_ -ilike "-$ShortName=*") } | Select-Object -First 1)

    if ($argument) {
        return $argument.Split("=")[1]
    }

    return $null
}

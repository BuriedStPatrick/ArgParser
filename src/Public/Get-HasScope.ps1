function Get-HasScope
{
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        [string[]] $Scope,
        [Parameter(Mandatory)]
        [string[]] $Arguments
    )

    $activeScope = Get-Scope -Arguments $Arguments
    $index = 0

    $validations = $Scope | ForEach-Object {
        $result = $_ -eq $activeScope[$index]
        $index++

        return $result
    } | Where-Object { $_ -eq $true }

    return $validations.Length -eq $activeScope.Length
}

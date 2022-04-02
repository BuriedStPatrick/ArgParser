function Get-Scope
{
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        [string[]] $Arguments
    )

    $index = 0

    return $Arguments | ForEach-Object {
        # Check if this is some kind of of flag
        $result = $_.StartsWith("-") `
            ? $null `
            # Check if this is a flag value by looking at previous argument
            : ($index -gt 0 -and ($Arguments[$index - 1].StartsWith("-"))) `
                ? $null `
                : $_

        $index++
        return $result
    } | Where-Object { $_ }
}

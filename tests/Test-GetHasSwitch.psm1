Import-Module (Convert-Path (Join-Path $PSScriptRoot ".." "src" "Public" "Get-HasSwitch.ps1"))

function Test-FindsLongNamedSwitch {
    # Act
    $result = Get-HasSwitch `
        -Name "help" `
        -ShortName "h" `
        -Arguments @("command", "--help")

    # Assert
    return $result -eq $true
}

function Test-FindsShortNamedSwitch {
    # Act
    $result = Get-HasSwitch `
        -Name "help" `
        -ShortName "h" `
        -Arguments @("command", "-h")

    # Assert
    return $result -eq $true
}
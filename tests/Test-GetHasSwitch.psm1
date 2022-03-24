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

function Test-FindsCombinedShortNamedSwitches {
    # Arrange
    $command = @("sudo", "pacman", "-Syu")

    # Act
    $result = Get-HasSwitch `
        -Name "something" `
        -ShortName "S" `
        -Arguments $command

    $result = $result -and (Get-HasSwitch `
        -Name "you-rock" `
        -ShortName "y" `
        -Arguments $command)

    $result = $result -and (Get-HasSwitch `
        -Name "update" `
        -ShortName "u" `
        -Arguments $command)

    # Assert
    return $result -eq $true
}

function Test-SwitchesAreCaseSensitive {
    # Arrange
    $command = @("sudo", "pacman", "-Syu")

    # Act
    $result = Get-HasSwitch `
        -Name "something" `
        -ShortName "s" `
        -Arguments $command

    # Assert
    return $result -eq $false
}
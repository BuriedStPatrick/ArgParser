Import-Module (Convert-Path (Join-Path $PSScriptRoot ".." "src" "Public" "Get-Scope.ps1"))
Import-Module (Convert-Path (Join-Path $PSScriptRoot ".." "src" "Public" "Get-HasScope.ps1"))

function Test-FiltersFlagsFromScope {
    # Arrange, Act
    $result = Get-Scope `
        -Arguments @("root", "command", "subcommand", "--value", "1234", "-Syu")

    # Assert
    return $result.Length -eq 3 -and `
        $result[0] -eq "root" -and `
        $result[1] -eq "command" -and `
        $result[2] -eq "subcommand"
}

function Test-FiltersFlagsFromScopeWithOddPlacements {
    # Arrange, Act
    $result = Get-Scope `
        -Arguments @("root", "--value", "1234", "command", "subcommand", "-Syu")

    # Assert
    return $result.Length -eq 3 -and `
        $result[0] -eq "root" -and `
        $result[1] -eq "command" -and `
        $result[2] -eq "subcommand"
}


function Test-CanValidateScope {
    # Arrange, Act
    $scope = Get-Scope `
        -Arguments @("root", "--value", "1234", "command", "subcommand", "-Syu")

    # Assert
    return Get-HasScope `
        -Scope $scope `
        -Arguments @("root", "command", "subcommand")
}

function Test-CanValidateInvalidScope {
    # Arrange, Act
    $scope = Get-Scope `
        -Arguments @("root", "--value", "1234", "command", "subcommand", "-Syu")

    # Assert
    return !(Get-HasScope `
        -Scope $scope `
        -Arguments @("root", "othercommand", "subcommand"))
}

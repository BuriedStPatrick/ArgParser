Import-Module (Convert-Path (Join-Path $PSScriptRoot ".." "src" "Public" "Get-StringValue.ps1"))

function Test-GetsPositionalStringArgument {
    # Act
    $result = Get-StringValue `
        -Name "value" `
        -ShortName "v" `
        -Arguments @("command", "--value", "test1234")

    # Assert
    return $result -eq "test1234"
}

function Test-GetsShortNamedPositionalStringArgument {
    # Act
    $result = Get-StringValue `
        -Name "value" `
        -ShortName "v" `
        -Arguments @("command", "-v", "test1234")

    # Assert
    return $result -eq "test1234"
}

function Test-GetsEqualityDenominatedStringArgument {
    # Act
    $result = Get-StringValue `
        -Name "value" `
        -ShortName "v" `
        -Arguments @("command", "--value=test1234")

    # Assert
    return $result -eq "test1234"
}

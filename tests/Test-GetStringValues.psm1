Import-Module (Convert-Path (Join-Path $PSScriptRoot ".." "src" "Public" "Get-StringValues.ps1"))

function Test-GetsStringArguments {
    # Arrange
    $command = @("command",
        "--value", "test1234",
        "--value", "test2345",
        "--value=test3456",
        "--value", "test=5678",
        "-v=shortdelimited",
        "-v", "shortpositional")

    # Act
    $result = Get-StringValues `
        -Name "value" `
        -ShortName "v" `
        -Arguments $command

    # Assert
    return `
        $result -contains "test2345" -and `
        $result -contains "test1234" -and `
        $result -contains "test3456" -and `
        $result -contains "test=5678" -and `
        $result -contains "shortdelimited" -and `
        $result -contains "shortpositional"
}

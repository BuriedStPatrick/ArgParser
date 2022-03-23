$currentFunctions = Get-ChildItem function: # Currently loaded functions

# Collect and import test modules
$testModules = Get-ChildItem .\tests\*.psm1 | ForEach-Object {
    Import-Module $_.FullName

    return $_.Name.Replace(".psm1", "")
}

# Collect newly added functions from test modules
# Excluding all other currently loaded functions.
# Only include functions that start with Test-*
$scriptFunctions = Get-ChildItem function: | Where-Object {
    $currentFunctions -notcontains $_ -and $_.Name.StartsWith("Test")
}

# Run and evaluate functions from test modules and print the result
try {
    $failed = 0
    $succeeded = 0
    $scriptFunctions | ForEach-Object {
        $passed = (& $_.ScriptBlock)

        if (!$passed) {
            $failed = $failed + 1
        } else {
            $succeeded = $succeeded + 1
        }
        

        $params = @{
            NoNewLine = $true
            BackgroundColor = $passed ? "Green" : "Yellow"
            ForegroundColor = "Black"
            Object = $passed ? " PASSED " : " FAILED "
        }

        Write-Host @params
        Write-Host " $($_)"
    }
} catch {
    Write-Host " ERROR  " -ForegroundColor White -BackgroundColor Red -NoNewline
    Write-Host " $($_.Exception.Message)"
} finally {
    $testModules | % { Remove-Module $_ }
}

@{
    Succeeded = $succeeded
    Failed = $failed
}
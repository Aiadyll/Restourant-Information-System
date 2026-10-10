
$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

try {
    # Update SQL database schema
    $global:LASTEXITCODE = 0
    & "$PSScriptRoot\sync-database.ps1"

    if ($LASTEXITCODE -ne 0) {
        throw "Database sync failed."
    }

    Write-Host "SQL synchronization completed."

    # Upload all project changes to GitHub
    $global:LASTEXITCODE = 0
    & "$PSScriptRoot\auto-git-sync.ps1"

    if ($LASTEXITCODE -ne 0) {
        throw "GitHub sync failed."
    }

    Write-Host "SUCCESS! All files synced to GitHub."
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)"
    exit 1
}


$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

try {
    # Update database schema
    & "$PSScriptRoot\sync-database.ps1"

    if ($LASTEXITCODE -ne 0) {
        throw "Database sync failed."
    }

    # Sync all project files
    & "$PSScriptRoot\auto-git-sync.ps1"

    if ($LASTEXITCODE -ne 0) {
        throw "GitHub sync failed."
    }

    Write-Host "SUCCESS! All synchronization completed."
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)"
    exit 1
}

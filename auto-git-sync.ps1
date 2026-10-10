
$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

try {
    # Check Git repository
    git rev-parse --is-inside-work-tree | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Git repository not found."
    }

    # Check current branch
    $branch = (git branch --show-current).Trim()

    if ($branch -ne "main") {
        Write-Host "Skipped: current branch is $branch"
        exit 0
    }

    # Add changed project files
    git add -A

    if ($LASTEXITCODE -ne 0) {
        throw "Git add failed."
    }

    # Check staged changes
    git diff --cached --quiet

    if ($LASTEXITCODE -eq 0) {
        Write-Host "No new changes."
        exit 0
    }

    if ($LASTEXITCODE -ne 1) {
        throw "Git diff failed."
    }

    # Create commit
    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    git commit -m "Auto sync: $date"

    if ($LASTEXITCODE -ne 0) {
        throw "Git commit failed."
    }

    # Push to GitHub
    git push origin main

    if ($LASTEXITCODE -ne 0) {
        throw "Git push failed."
    }

    Write-Host "SUCCESS! Project synced to GitHub."
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)"
    exit 1
}

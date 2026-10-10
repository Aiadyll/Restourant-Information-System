
$ErrorActionPreference = "Stop"

Import-Module SqlServer -Force

$server = "Aiadyll\SQLEXPRESS01"
$database = "RestaurantDB_Lab6"
$output = Join-Path $PSScriptRoot "schema.sql"

try {
    $connection = New-Object Microsoft.SqlServer.Management.Common.ServerConnection
    $connection.ServerInstance = $server
    $connection.LoginSecure = $true
    $connection.TrustServerCertificate = $true

    $sqlServer = New-Object Microsoft.SqlServer.Management.Smo.Server($connection)
    $db = $sqlServer.Databases[$database]

    if ($null -eq $db) {
        throw "Database not found: $database"
    }

    $scripter = New-Object Microsoft.SqlServer.Management.Smo.Scripter($sqlServer)
    $scripter.Options.ScriptSchema = $true
    $scripter.Options.ScriptData = $false
    $scripter.Options.DriAll = $true
    $scripter.Options.Indexes = $true
    $scripter.Options.IncludeHeaders = $false
    $scripter.Options.NoCommandTerminator = $false

    $lines = New-Object 'System.Collections.Generic.List[string]'
    $lines.Add("USE [$database]")
    $lines.Add("GO")

    foreach ($table in ($db.Tables | Sort-Object Schema, Name)) {
        if ($table.IsSystemObject) {
            continue
        }

        $lines.Add("")

        foreach ($statement in $scripter.Script(@($table.Urn))) {
            $lines.Add($statement)
            $lines.Add("GO")
        }
    }

    if ($lines.Count -le 2) {
        throw "No tables found. File was not changed."
    }

    $encoding = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllLines($output, $lines, $encoding)

    Write-Host "SUCCESS! schema.sql updated." -ForegroundColor Green
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
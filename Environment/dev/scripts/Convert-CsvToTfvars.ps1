param(
    [string]$CsvPath,
    [string]$TfvarsPath
)

$ErrorActionPreference = "Stop"

# ------------------------------------------------------------
# Determine dev environment folder
# ------------------------------------------------------------

$DevFolder = Split-Path -Parent $PSScriptRoot

# If paths are not provided, use default files in dev folder
if ([string]::IsNullOrWhiteSpace($CsvPath)) {
    $CsvPath = Join-Path $DevFolder "resource-groups.csv"
}

if ([string]::IsNullOrWhiteSpace($TfvarsPath)) {
    $TfvarsPath = Join-Path $DevFolder "terraform.tfvars"
}

Write-Host "============================================"
Write-Host " CSV to Terraform Variables Conversion"
Write-Host "============================================"
Write-Host ""

Write-Host "Environment Folder : $DevFolder"
Write-Host "CSV File            : $CsvPath"
Write-Host "TFVARS File         : $TfvarsPath"
Write-Host ""

# ------------------------------------------------------------
# Validate CSV file
# ------------------------------------------------------------

if (-not (Test-Path -LiteralPath $CsvPath -PathType Leaf)) {
    throw "CSV file not found: $CsvPath"
}

Write-Host "CSV file found."
Write-Host ""

# ------------------------------------------------------------
# Read CSV
# ------------------------------------------------------------

$resourceGroups = @(Import-Csv -LiteralPath $CsvPath)

if ($resourceGroups.Count -eq 0) {
    throw "CSV file is empty."
}

Write-Host "Resource groups found: $($resourceGroups.Count)"
Write-Host ""

# ------------------------------------------------------------
# Validate CSV headers
# ------------------------------------------------------------

$requiredColumns = @(
    "resource_group_name",
    "location"
)

$csvColumns = $resourceGroups[0].PSObject.Properties.Name

foreach ($column in $requiredColumns) {

    if ($column -notin $csvColumns) {
        throw "Required CSV column '$column' is missing."
    }
}

# ------------------------------------------------------------
# Validate data and detect duplicates
# ------------------------------------------------------------

$seenResourceGroups = @{}

$tfvarsContent = New-Object System.Collections.Generic.List[string]

$tfvarsContent.Add("resource_groups = {")

foreach ($rg in $resourceGroups) {

    $rgName = if ($null -ne $rg.resource_group_name) {
        $rg.resource_group_name.Trim()
    }
    else {
        ""
    }

    $location = if ($null -ne $rg.location) {
        $rg.location.Trim()
    }
    else {
        ""
    }

    # Validate resource group name
    if ([string]::IsNullOrWhiteSpace($rgName)) {
        throw "Resource group name cannot be empty."
    }

    # Validate location
    if ([string]::IsNullOrWhiteSpace($location)) {
        throw "Location cannot be empty for resource group '$rgName'."
    }

    # Detect duplicate resource group names
    if ($seenResourceGroups.ContainsKey($rgName)) {
        throw "Duplicate resource group found: '$rgName'."
    }

    $seenResourceGroups[$rgName] = $true

    # Add Terraform configuration
    $tfvarsContent.Add("")
    $tfvarsContent.Add("  `"$rgName`" = {")
    $tfvarsContent.Add("    name     = `"$rgName`"")
    $tfvarsContent.Add("    location = `"$location`"")
    $tfvarsContent.Add("  }")
}

$tfvarsContent.Add("}")

# ------------------------------------------------------------
# Write terraform.tfvars
# ------------------------------------------------------------

$tfvarsContent | Set-Content -LiteralPath $TfvarsPath -Encoding UTF8

Write-Host ""
Write-Host "============================================"
Write-Host " SUCCESS"
Write-Host "============================================"
Write-Host ""
Write-Host "terraform.tfvars created successfully."
Write-Host ""
Write-Host "Output:"
Write-Host $TfvarsPath
Write-Host ""
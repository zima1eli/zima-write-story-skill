param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectRoot,

    [switch]$Force
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$skillRoot = Resolve-Path (Join-Path $scriptDir "..")
$skillName = Split-Path -Leaf $skillRoot
$projectPath = Resolve-Path $ProjectRoot

$targets = @(
    Join-Path $projectPath ".agents\skills\$skillName",
    Join-Path $projectPath ".claude\skills\$skillName",
    Join-Path $projectPath ".cursor\skills\$skillName"
)

foreach ($target in $targets) {
    if ((Test-Path $target) -and -not $Force) {
        Write-Host "Skip existing: $target (use -Force to overwrite)"
        continue
    }

    $parent = Split-Path -Parent $target
    New-Item -ItemType Directory -Force -Path $parent | Out-Null

    if (Test-Path $target) {
        Remove-Item -Recurse -Force -Path $target
    }

    Copy-Item -Recurse -Force -Path $skillRoot -Destination $target
    Write-Host "Installed: $target"
}

Write-Host "Done. Skill '$skillName' is available for Codex, Claude Code, and Cursor."

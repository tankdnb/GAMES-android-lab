[CmdletBinding(SupportsShouldProcess)]
param()

$researchRoot = Split-Path -Parent $PSScriptRoot
$targets = @(
    (Join-Path $researchRoot 'worktrees'),
    (Join-Path $researchRoot 'cache'),
    (Join-Path $researchRoot 'tmp')
)

foreach ($target in $targets) {
    if (-not (Test-Path -LiteralPath $target)) {
        New-Item -ItemType Directory -Path $target | Out-Null
    }

    $items = Get-ChildItem -LiteralPath $target -Force | Where-Object { $_.Name -ne '.gitkeep' }
    foreach ($item in $items) {
        if ($PSCmdlet.ShouldProcess($item.FullName, 'Remove research artifact')) {
            Remove-Item -LiteralPath $item.FullName -Recurse -Force
        }
    }
}

Write-Output 'Research workspace cleaned.'

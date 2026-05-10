[CmdletBinding(SupportsShouldProcess)]
param()

$researchRoot = Split-Path -Parent $PSScriptRoot
$worktreesRoot = Join-Path $researchRoot 'worktrees'
$targets = @(
    $worktreesRoot,
    (Join-Path $researchRoot 'cache'),
    (Join-Path $researchRoot 'tmp')
)

$worktreePrefix = [System.IO.Path]::GetFullPath($worktreesRoot)
$gradleLikeProcesses = Get-CimInstance Win32_Process | Where-Object {
    $_.Name -like 'java*' -and
    $_.CommandLine -and
    $_.CommandLine.Contains($worktreePrefix)
}

foreach ($process in $gradleLikeProcesses) {
    if ($PSCmdlet.ShouldProcess("PID $($process.ProcessId)", 'Stop worktree-owned Gradle/Java process')) {
        Stop-Process -Id $process.ProcessId -Force -ErrorAction SilentlyContinue
    }
}

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

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$srcWww = Join-Path $root "www"
$dstAssets = Join-Path $root "android_project\app\src\main\assets"

if (Test-Path $dstAssets) {
    Remove-Item -Recurse -Force $dstAssets
}
New-Item -ItemType Directory -Force -Path $dstAssets | Out-Null
Copy-Item -Path (Join-Path $srcWww "*") -Destination $dstAssets -Recurse -Force

Push-Location (Join-Path $root "android_project")
try {
    gradle assembleDebug
    Write-Host "APK built successfully! Check app/build/outputs/apk/debug/app-debug.apk" -ForegroundColor Green
} finally {
    Pop-Location
}

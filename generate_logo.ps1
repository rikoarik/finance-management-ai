Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Generate Logo untuk FinChat App" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if logo file exists
$logoFile = $null
if (Test-Path "assets\logo\logo_app.png") {
    $logoFile = "assets\logo\logo_app.png"
} elseif (Test-Path "assets\logo\logo.png") {
    $logoFile = "assets\logo\logo.png"
}

if (-not $logoFile) {
    Write-Host "[ERROR] Logo tidak ditemukan!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Silakan letakkan logo Anda di: assets\logo\logo.png atau logo_app.png" -ForegroundColor Yellow
    Write-Host "Ukuran disarankan: 1024x1024 px (PNG dengan background transparan)" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Tekan Enter untuk keluar"
    exit 1
}

Write-Host "[INFO] Logo ditemukan: $logoFile" -ForegroundColor Green
Write-Host ""

Write-Host "[INFO] Menginstall dependencies..." -ForegroundColor Yellow
flutter pub get

Write-Host ""
Write-Host "[INFO] Generate logo untuk Android..." -ForegroundColor Yellow
flutter pub run flutter_launcher_icons

Write-Host ""
Write-Host "[SUCCESS] Logo berhasil di-generate!" -ForegroundColor Green
Write-Host ""
Write-Host "File logo sudah ada di:" -ForegroundColor Cyan
Write-Host "  - android\app\src\main\res\mipmap-*\ic_launcher.png"
Write-Host ""
Write-Host "Langkah selanjutnya:" -ForegroundColor Yellow
Write-Host "  1. Test di device: flutter run"
Write-Host "  2. Build APK: flutter build apk"
Write-Host ""
Read-Host "Tekan Enter untuk keluar"


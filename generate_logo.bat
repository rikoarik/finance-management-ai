@echo off
echo ========================================
echo    Generate Logo untuk FinChat App
echo ========================================
echo.

REM Check if logo file exists
if not exist "assets\logo\logo_app.png" (
    if not exist "assets\logo\logo.png" (
        echo [ERROR] Logo tidak ditemukan!
        echo.
        echo Silakan letakkan logo Anda di: assets\logo\logo.png atau logo_app.png
        echo Ukuran disarankan: 1024x1024 px (PNG dengan background transparan)
        echo.
        pause
        exit /b 1
    ) else (
        set LOGO_FILE=assets\logo\logo.png
    )
) else (
    set LOGO_FILE=assets\logo\logo_app.png
)

echo [INFO] Logo ditemukan: %LOGO_FILE%
echo.
echo [INFO] Menginstall dependencies...
call flutter pub get

echo.
echo [INFO] Generate logo untuk Android...
call flutter pub run flutter_launcher_icons

echo.
echo [SUCCESS] Logo berhasil di-generate!
echo.
echo File logo sudah ada di:
echo   - android\app\src\main\res\mipmap-*\ic_launcher.png
echo.
echo Langkah selanjutnya:
echo   1. Test di device: flutter run
echo   2. Build APK: flutter build apk
echo.
pause


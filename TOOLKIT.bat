@echo off
chcp 65001 >nul
title Dev & Admin Toolkit
mode con cols=80 lines=30
color 0B

:: Administrator huquqini avtomatik so'rash
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Boshlang'ich til: UZ (O'zbekcha)
set "LANG=UZ"

:MENU
cls
if "%LANG%"=="EN" goto MENU_EN
goto MENU_UZ

:MENU_UZ
echo ======================================================================
echo                             Vohid TOOLKIT                       (UZ)
echo ======================================================================
echo  [1] Terminal (CMD)
echo  [2] PowerShell 
echo  [3] Windows-ni aktivatsiya qilish (MAS)
echo  [4] BIOS (UEFI) sozlamalariga kirish (Restart)
echo  [5] Barcha dasturlarni avtomatik yangilash (Winget)
echo  [6] Band bo'lgan portni majburiy yopish (Kill Port)
echo  [7] Kompyuterni Scan qilish va xatolarni to'g'irlash
echo  [8] Environment Variables (PATH) sozlamalarini ochish
echo  [9] Device Manager (Qurilmalar dispetcheri)
echo  [10] Kompyuterni o'chirish (30 soniyadan keyin)
echo.
echo  [A] About                       [L] Tilni o'zgartirish
echo.
echo  [0 / exit] Chiqish
echo ======================================================================
set /p choice="Amalni kiriting: "
goto PROCESS_CHOICE

:MENU_EN
echo ======================================================================
echo                             Vohid TOOLKIT                       (EN)
echo ======================================================================
echo  [1] Terminal (CMD)
echo  [2] PowerShell 
echo  [3] Activate Windows (MAS)
echo  [4] Reboot to BIOS (UEFI)
echo  [5] Update all software (Winget)
echo  [6] Force kill busy port
echo  [7] System Scan and Repair
echo  [8] Open Environment Variables (PATH)
echo  [9] Device Manager
echo  [10] Shutdown computer (in 30s)
echo.
echo  [A] About                       [L] Change Language
echo.
echo  [0 / exit] Exit
echo ======================================================================
set /p choice="Select action: "
goto PROCESS_CHOICE

:PROCESS_CHOICE
if "%choice%"=="1" goto CMD
if "%choice%"=="2" goto PS
if "%choice%"=="3" goto ACTIVATE
if "%choice%"=="4" goto CONFIRM_BIOS
if "%choice%"=="5" goto WINGET
if "%choice%"=="6" goto KILLPORT
if "%choice%"=="7" goto SCAN
if "%choice%"=="8" goto ENV
if "%choice%"=="9" goto DEVMGMT
if "%choice%"=="10" goto CONFIRM_SHUTDOWN
if /i "%choice%"=="a" goto ABOUT_INFO
if /i "%choice%"=="l" goto CHANGE_LANG
if "%choice%"=="0" exit
if /i "%choice%"=="exit" exit

echo.
if "%LANG%"=="EN" (
    powershell -Command "Write-Host '[X] Invalid command! Please try again.' -ForegroundColor Red"
) else (
    powershell -Command "Write-Host '[X] Notog''ri buyruq kiritildi! Qayta urinib ko''ring.' -ForegroundColor Red"
)
timeout /t 2 >nul
goto MENU

:CMD
start cmd.exe
goto MENU

:PS
start powershell.exe
goto MENU

:ACTIVATE
cls
echo ======================================================================
echo                   [3] WINDOWS ACTIVATION (MAS)
echo ======================================================================
echo.
powershell -Command "irm https://get.activated.win | iex"
echo.
pause
goto MENU

:CONFIRM_BIOS
cls
echo ======================================================================
echo                     [4] REBOOT TO BIOS / UEFI
echo ======================================================================
echo.
if "%LANG%"=="EN" (
    set /p confirm="Are you sure you want to reboot to BIOS? (y/n): "
) else (
    set /p confirm="Kompyuterni BIOS-ga qayta yoqishni tasdiqlaysizmi? (y/n): "
)
if /i "%confirm%"=="y" (
    echo.
    if "%LANG%"=="EN" (
        echo [!] Computer is rebooting in 3 seconds...
    ) else (
        echo [!] Kompyuter 3 soniyada qayta yoqilmoqda...
    )
    timeout /t 3 /nobreak
    shutdown /r /fw /t 0
)
goto MENU

:WINGET
cls
echo ======================================================================
echo                   [5] WINGET SOFTWARE UPDATE
echo ======================================================================
echo.
winget upgrade --all --include-unknown
echo.
if "%LANG%"=="EN" (
    powershell -Command "Write-Host '[✓] All applications updated!' -ForegroundColor Green"
) else (
    powershell -Command "Write-Host '[✓] Barcha dasturlar yangilandi!' -ForegroundColor Green"
)
pause
goto MENU

:KILLPORT
cls
echo ======================================================================
echo                      [6] KILL BUSY PORT
echo ======================================================================
echo.
if "%LANG%"=="EN" (
    set /p port="Enter port number to terminate (e.g. 8080): "
) else (
    set /p port="To'xtatmoqchi bo'lgan port raqamini kiriting (masalan 8080): "
)
if "%port%"=="" goto MENU
echo.
powershell -Command "$p = Get-NetTCPConnection -LocalPort %port% -ErrorAction SilentlyContinue; if ($p) { Stop-Process -Id $p.OwningProcess -Force; Write-Host '[✓] Port %port% terminated!' -ForegroundColor Green } else { Write-Host '[X] No process found on port %port%.' -ForegroundColor Red }"
echo.
pause
goto MENU

:SCAN
cls
echo ======================================================================
echo                   [7] SYSTEM REPAIR AND SCAN
echo ======================================================================
echo.
if "%LANG%"=="EN" (
    echo [1/2] Scanning Windows system files (SFC)...
) else (
    echo [1/2] Windows fayllari skanerlanmoqda (SFC)...
)
sfc /scannow
echo.
if "%LANG%"=="EN" (
    echo [2/2] Repairing system image errors (DISM)...
) else (
    echo [2/2] Tizim obrazidagi xatolar tiklanmoqda (DISM)...
)
dism /online /cleanup-image /restorehealth
echo.
if "%LANG%"=="EN" (
    powershell -Command "Write-Host '[✓] Scan and repair completed!' -ForegroundColor Green"
) else (
    powershell -Command "Write-Host '[✓] Skanerlash va tiklash yakunlandi!' -ForegroundColor Green"
)
pause
goto MENU

:ENV
start sysdm.cpl
goto MENU

:DEVMGMT
start devmgmt.msc
goto MENU

:CHANGE_LANG
cls
echo ======================================================================
echo                         SELECT LANGUAGE / TILNI TANLANG
echo ======================================================================
echo.
echo  [1] Uzbek (UZ)
echo  [2] English (EN)
echo.
echo ======================================================================
set /p lang_choice="Choose / Tanlang [1-2]: "
if "%lang_choice%"=="1" set "LANG=UZ"
if "%lang_choice%"=="2" set "LANG=EN"
goto MENU

:ABOUT_INFO
cls
echo ======================================================================
echo                             ABOUT TOOLKIT
echo ======================================================================
echo.
if "%LANG%"=="EN" (
    echo   Vohid TOOLKIT v1.0
    echo   ------------------------------------------------------------------
    echo   A lightweight, highly automated CLI toolkit designed for Windows
    echo   system administration and DevOps operations. It streamlines core
    echo   tasks like network port management, system repairs, environment
    echo   variables configuration, and software updates.
    echo.
    echo   Author  : Muhammadamin Vohid
    echo   Gmail   : mnmbackend@gmail.com
    echo   GitHub  : github.com/mnmbackend
) else (
    echo   Vohid TOOLKIT v1.0
    echo   ------------------------------------------------------------------
    echo   Windows tizimini boshqarish va DevOps vazifalarini avtomatlashtirish
    echo   uchun mo'ljallangan tezkor CLI yordamchi. Tizim fayllarini skan 
    echo   qilish, band portlarni majburiy yopish, PATH sozlamalariga kirish 
    echo   va dasturlarni avto-yangilash kabi amallarni tezkor bajaradi.
    echo.
    echo   Muallif : Muhammadamin Vohid
    echo   Gmail   : mnmbackend@gmail.com
    echo   GitHub  : github.com/mnmbackend
)
echo.
echo ======================================================================
echo.
pause
goto MENU

:CONFIRM_SHUTDOWN
cls
echo ======================================================================
echo                  [10] SHUTDOWN COMPUTER (30s)
echo ======================================================================
echo.
if "%LANG%"=="EN" (
    set /p confirm="Are you sure you want to shut down the computer? (y/n): "
) else (
    set /p confirm="Kompyuterni o'chirishni tasdiqlaysizmi? (y/n): "
)
if /i "%confirm%"=="y" (
    echo.
    if "%LANG%"=="EN" (
        powershell -Command "Write-Host '[!] Computer will shut down in 30 seconds.' -ForegroundColor Yellow"
        powershell -Command "Write-Host '[i] Press [Ctrl + C] during the timer to cancel!' -ForegroundColor Red"
    ) else (
        powershell -Command "Write-Host '[!] Kompyuter 30 soniyadan so''ng o''chiriladi.' -ForegroundColor Yellow"
        powershell -Command "Write-Host '[i] Bekor qilish uchun taymer davomida [Ctrl + C] ni bosing!' -ForegroundColor Red"
    )
    echo.
    shutdown /s /t 30
    
    timeout /t 30
    shutdown /a >nul 2>&1
    exit
)
goto MENU
@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Vohid TOOLKIT v1.1
mode con cols=84
cd /d "%~dp0"

rem ======================================================================
rem  Administrator huquqini so'rash
rem ======================================================================
net session >nul 2>&1
if errorlevel 1 goto ELEVATE
goto INIT

:ELEVATE
echo.
echo   Administrator huquqi so'ralmoqda / Requesting administrator rights...
powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" >nul 2>&1
if not errorlevel 1 exit /b 0
echo.
echo   [x] Administrator huquqi berilmadi / Administrator rights were denied.
echo.
pause
exit /b 1

rem ======================================================================
rem  Boshlang'ich sozlamalar
rem ======================================================================
:INIT
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "C_0=%ESC%[0m"
set "C_C=%ESC%[96m"
set "C_G=%ESC%[92m"
set "C_Y=%ESC%[93m"
set "C_R=%ESC%[91m"
set "C_D=%ESC%[90m"
set "C_W=%ESC%[97m"

set "TK_CFG=%LOCALAPPDATA%\VohidToolkit.lang"
set "TK_LANG=UZ"
if exist "%TK_CFG%" set /p TK_LANG=<"%TK_CFG%"
if /i "!TK_LANG!"=="EN" (set "TK_LANG=EN") else (set "TK_LANG=UZ")
call :LANG_!TK_LANG!

rem ======================================================================
rem  Asosiy menyu
rem ======================================================================
:MENU
set "choice="
cls
echo.
echo   %C_C%========================================================================%C_0%
echo     %C_W%VOHID TOOLKIT%C_0% %C_D%v1.0%C_0%         %C_D%!T_SUB!%C_0%          %C_G%[!TK_LANG!]%C_0%
echo   %C_C%========================================================================%C_0%
echo     %C_D%PC: %COMPUTERNAME%   ^|   %USERNAME%   ^|   Admin: ON%C_0%
echo.
echo     %C_G%[1]%C_0%   !T_M1!
echo     %C_G%[2]%C_0%   !T_M2!
echo     %C_G%[3]%C_0%   !T_M3!
echo     %C_G%[4]%C_0%   !T_M4!
echo     %C_G%[5]%C_0%   !T_M5!
echo     %C_G%[6]%C_0%   !T_M6!
echo     %C_G%[7]%C_0%   !T_M7!
echo     %C_G%[8]%C_0%   !T_M8!
echo     %C_G%[9]%C_0%   !T_M9!
echo     %C_G%[10]%C_0%  !T_M10!
echo.
echo   %C_D%------------------------------------------------------------------------%C_0%
echo     %C_C%[A]%C_0% !T_MA!      %C_C%[L]%C_0% !T_ML!      %C_C%[0]%C_0% !T_M0!
echo   %C_C%========================================================================%C_0%
echo.
set /p "choice=  %C_C%>>%C_0% "

set "choice=!choice:"=!"
set "choice=!choice: =!"
if not defined choice goto MENU

if "!choice!"=="1" goto T_CMD
if "!choice!"=="2" goto T_PS
if "!choice!"=="3" goto T_ENV
if "!choice!"=="4" goto T_DEV
if "!choice!"=="5" goto T_SCAN
if "!choice!"=="6" goto T_ACT
if "!choice!"=="7" goto T_BIOS
if "!choice!"=="8" goto T_OFF
if "!choice!"=="9" goto T_WG
if "!choice!"=="10" goto T_PORT
if /i "!choice!"=="a" goto T_ABOUT
if /i "!choice!"=="l" goto T_LANG
if "!choice!"=="0" goto QUIT
if /i "!choice!"=="exit" goto QUIT

echo.
call :ERR "!T_INVALID!"
timeout /t 2 /nobreak >nul
goto MENU

rem ======================================================================
rem  [1] [2] [3] [4]  Asboblar
rem ======================================================================
:T_CMD
start "CMD Admin" /d "%USERPROFILE%" cmd.exe
goto MENU

:T_PS
start "PowerShell Admin" /d "%USERPROFILE%" powershell.exe -NoLogo
goto MENU

:T_ENV
rundll32 sysdm.cpl,EditEnvironmentVariables
goto MENU

:T_DEV
start "" devmgmt.msc
goto MENU

rem ======================================================================
rem  [5] Tizimni skanerlash (avval DISM, keyin SFC - to'g'ri tartib)
rem ======================================================================
:T_SCAN
call :HEADER "!T_M5!"
call :INFO "[1/2] !T_SCAN1!"
echo.
dism /online /cleanup-image /restorehealth
echo.
call :INFO "[2/2] !T_SCAN2!"
echo.
sfc /scannow
echo.
call :OK "!T_SCAN_DONE!"
call :INFO "!T_LOG! %windir%\Logs\CBS\CBS.log"
goto PAUSE_BACK

rem ======================================================================
rem  [6] Windows aktivatsiya holati
rem ======================================================================
:T_ACT
call :HEADER "!T_M6!"
cscript //nologo "%windir%\System32\slmgr.vbs" /xpr
echo.
call :INFO "!T_ACT_NOTE!"
call :ASK_YN "!T_ACT_OPEN!"
if not errorlevel 1 start "" ms-settings:activation
goto PAUSE_BACK

rem ======================================================================
rem  [7] BIOS / UEFI ga qayta yoqish
rem ======================================================================
:T_BIOS
call :HEADER "!T_M7!"
call :WARN "!T_BIOS_WARN!"
call :ASK_YN "!T_ASK_BIOS!"
if errorlevel 1 goto MENU
shutdown /r /fw /t 10
if errorlevel 1 goto CMD_FAIL
call :COUNTDOWN 10
if errorlevel 1 goto PAUSE_BACK
exit /b 0

rem ======================================================================
rem  [8] Kompyuterni o'chirish (30 soniya, bekor qilish mumkin)
rem ======================================================================
:T_OFF
call :HEADER "!T_M8!"
call :WARN "!T_OFF_WARN!"
call :ASK_YN "!T_ASK_OFF!"
if errorlevel 1 goto MENU
shutdown /s /t 30
if errorlevel 1 goto CMD_FAIL
call :COUNTDOWN 30
if errorlevel 1 goto PAUSE_BACK
exit /b 0

:CMD_FAIL
echo.
call :ERR "!T_FAIL!"
goto PAUSE_BACK

rem ======================================================================
rem  [9] Winget bilan yangilash
rem ======================================================================
:T_WG
call :HEADER "!T_M9!"
where winget >nul 2>&1
if errorlevel 1 goto WG_MISSING
winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements
set "RC=!errorlevel!"
echo.
if "!RC!"=="0" goto WG_OK
call :WARN "!T_WG_WARN! [code !RC!]"
goto PAUSE_BACK

:WG_OK
call :OK "!T_WG_OK!"
goto PAUSE_BACK

:WG_MISSING
call :ERR "!T_WG_MISSING!"
goto PAUSE_BACK

rem ======================================================================
rem  [10] Band portni yopish
rem ======================================================================
:T_PORT
call :HEADER "!T_M10!"
set "port="
set /p "port=  !T_PORT_Q! "
set "port=!port:"=!"
set "port=!port: =!"
if not defined port goto MENU
set "chk="
for /f "delims=0123456789" %%a in ("!port!") do set "chk=1"
if defined chk goto PORT_BAD
if not "!port:~5!"=="" goto PORT_BAD
set "TK_PORT=!port!"

echo.
powershell -NoProfile -Command "$c=@(Get-NetTCPConnection -LocalPort ([int]$env:TK_PORT) -State Listen -ErrorAction SilentlyContinue); if($c.Count -eq 0){exit 2}; $c | Select-Object -ExpandProperty OwningProcess -Unique | ForEach-Object { $x=Get-Process -Id $_ -ErrorAction SilentlyContinue; '     ' + $x.ProcessName + '   PID ' + $_ }"
if errorlevel 1 goto PORT_NONE

call :ASK_YN "!T_PORT_ASK! !port!"
if errorlevel 1 goto MENU
powershell -NoProfile -Command "Get-NetTCPConnection -LocalPort ([int]$env:TK_PORT) -State Listen -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess -Unique | Where-Object { $_ -gt 4 } | ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction Stop }"
if errorlevel 1 goto PORT_FAIL
echo.
call :OK "!T_PORT_OK! !port!"
goto PAUSE_BACK

:PORT_BAD
echo.
call :ERR "!T_PORT_BAD!"
goto PAUSE_BACK

:PORT_NONE
call :ERR "!T_PORT_NONE! !port!"
goto PAUSE_BACK

:PORT_FAIL
echo.
call :ERR "!T_PORT_FAIL!"
goto PAUSE_BACK

rem ======================================================================
rem  Til tanlash
rem ======================================================================
:T_LANG
call :HEADER "SELECT LANGUAGE / TILNI TANLANG"
echo     %C_C%[1]%C_0%   O'zbekcha
echo     %C_C%[2]%C_0%   English
echo.
choice /c 12 /n /m "  >> "
if errorlevel 2 (set "TK_LANG=EN") else (set "TK_LANG=UZ")
echo !TK_LANG!>"%TK_CFG%" 2>nul
call :LANG_!TK_LANG!
goto MENU

rem ======================================================================
rem  About
rem ======================================================================
:T_ABOUT
call :HEADER "ABOUT TOOLKIT"
if /i "!TK_LANG!"=="EN" goto ABOUT_EN
echo     Vohid TOOLKIT v1.1
echo     ----------------------------------------------------------------
echo     Windows tizimini boshqarish va DevOps vazifalarini avtomatlashtirish
echo     uchun mo'ljallangan tezkor CLI yordamchi. Tizim fayllarini skan
echo     qilish, band portlarni yopish, PATH sozlamalariga kirish va
echo     dasturlarni avto-yangilash kabi amallarni tezkor bajaradi.
echo.
echo     Muallif : Muhammadamin Vohid
goto ABOUT_COMMON

:ABOUT_EN
echo     Vohid TOOLKIT v1.1
echo     ----------------------------------------------------------------
echo     A lightweight, highly automated CLI toolkit designed for Windows
echo     system administration and DevOps operations. It streamlines core
echo     tasks like network port management, system repairs, environment
echo     variables configuration, and software updates.
echo.
echo     Author  : Muhammadamin Vohid

:ABOUT_COMMON
echo     Gmail   : mnmbackend@gmail.com
echo     GitHub  : github.com/mnmbackend
goto PAUSE_BACK

:QUIT
exit /b 0

rem ======================================================================
rem  Yordamchi funksiyalar
rem ======================================================================
:PAUSE_BACK
echo.
echo   %C_D%!T_PRESS!%C_0%
pause >nul
goto MENU

:HEADER
cls
echo.
echo   %C_C%========================================================================%C_0%
echo     %C_W%%~1%C_0%
echo   %C_C%========================================================================%C_0%
echo.
exit /b 0

:OK
echo   %C_G%[+]%C_0%  %~1
exit /b 0

:ERR
echo   %C_R%[x]%C_0%  %~1
exit /b 0

:WARN
echo   %C_Y%[*]%C_0%  %~1
exit /b 0

:INFO
echo   %C_C%[i]%C_0%  %~1
exit /b 0

:ASK_YN
echo.
choice /c YN /n /m "  %~1 [Y/N]: "
if errorlevel 2 exit /b 1
exit /b 0

:COUNTDOWN
echo.
choice /c CX /n /t %~1 /d X /m "  !T_CD! "
if errorlevel 2 exit /b 0
shutdown /a >nul 2>&1
echo.
call :OK "!T_CANCELLED!"
exit /b 1

rem ======================================================================
rem  Tillar
rem ======================================================================
:LANG_UZ
set "T_SUB=Windows tizim yordamchisi"
set "T_G1=ASBOBLAR"
set "T_G2=TIZIM"
set "T_G3=DASTURLAR VA TARMOQ"
set "T_M1=Terminal (CMD)"
set "T_M2=PowerShell"
set "T_M3=Environment Variables (PATH)"
set "T_M4=Device Manager (Qurilmalar dispetcheri)"
set "T_M5=Tizimni skanerlash va tuzatish (DISM + SFC)"
set "T_M6=Windows aktivatsiya holati"
set "T_M7=BIOS (UEFI) sozlamalariga qayta yoqish"
set "T_M8=Kompyuterni o'chirish - 30 soniyadan keyin"
set "T_M9=Barcha dasturlarni yangilash (Winget)"
set "T_M10=Band portni majburiy yopish"
set "T_MA=Haqida"
set "T_ML=Til"
set "T_M0=Chiqish"
set "T_PRESS=Menyuga qaytish uchun istalgan tugmani bosing..."
set "T_INVALID=Noto'g'ri buyruq. Qayta urinib ko'ring."
set "T_SCAN1=DISM: tizim obrazini tiklash..."
set "T_SCAN2=SFC: Windows fayllarini tekshirish..."
set "T_SCAN_DONE=Skanerlash va tiklash yakunlandi."
set "T_LOG=Batafsil log:"
set "T_ACT_NOTE=Aktivatsiya Sozlamalar sahifasida yoki o'z litsenziya kalitingiz orqali amalga oshiriladi."
set "T_ACT_OPEN=Aktivatsiya sozlamalari ochilsinmi?"
set "T_BIOS_WARN=Saqlanmagan ishlar yo'qoladi. Kompyuter UEFI sozlamalariga qayta yoqiladi."
set "T_ASK_BIOS=BIOS ga qayta yoqishni tasdiqlaysizmi?"
set "T_OFF_WARN=Saqlanmagan ishlar yo'qoladi."
set "T_ASK_OFF=Kompyuter 30 soniyadan so'ng o'chirilsinmi?"
set "T_CD=Bekor qilish uchun C tugmasini bosing."
set "T_CANCELLED=Bekor qilindi."
set "T_FAIL=Bajarib bo'lmadi. UEFI qo'llab-quvvatlanmasligi yoki boshqa o'chirish jarayoni kutilayotgan bo'lishi mumkin."
set "T_WG_MISSING=Winget topilmadi. Microsoft Store orqali App Installer ni o'rnating."
set "T_WG_OK=Barcha dasturlar yangilandi."
set "T_WG_WARN=Winget ogohlantirish bilan yakunlandi. Yuqoridagi natijani tekshiring."
set "T_PORT_Q=Port raqami (masalan 8080):"
set "T_PORT_BAD=Port faqat raqamdan iborat bo'lishi kerak (1-65535)."
set "T_PORT_NONE=Bu portda tinglayotgan jarayon topilmadi. Port:"
set "T_PORT_ASK=Yuqoridagi jarayonlar majburiy to'xtatilsinmi? Port:"
set "T_PORT_OK=Jarayon to'xtatildi. Port:"
set "T_PORT_FAIL=Jarayonni to'xtatib bo'lmadi."
exit /b 0

:LANG_EN
set "T_SUB=Windows system helper"
set "T_G1=TOOLS"
set "T_G2=SYSTEM"
set "T_G3=SOFTWARE AND NETWORK"
set "T_M1=Terminal (CMD)"
set "T_M2=PowerShell"
set "T_M3=Environment Variables (PATH)"
set "T_M4=Device Manager"
set "T_M5=System scan and repair (DISM + SFC)"
set "T_M6=Windows activation status"
set "T_M7=Reboot to BIOS (UEFI)"
set "T_M8=Shutdown computer - in 30 seconds"
set "T_M9=Update all software (Winget)"
set "T_M10=Force kill busy port"
set "T_MA=About"
set "T_ML=Language"
set "T_M0=Exit"
set "T_PRESS=Press any key to return to the menu..."
set "T_INVALID=Invalid command. Please try again."
set "T_SCAN1=DISM: repairing system image..."
set "T_SCAN2=SFC: scanning Windows system files..."
set "T_SCAN_DONE=Scan and repair completed."
set "T_LOG=Detailed log:"
set "T_ACT_NOTE=Activate through the Settings page or with your own license key."
set "T_ACT_OPEN=Open activation settings?"
set "T_BIOS_WARN=Unsaved work will be lost. The computer will reboot into UEFI setup."
set "T_ASK_BIOS=Confirm reboot to BIOS?"
set "T_OFF_WARN=Unsaved work will be lost."
set "T_ASK_OFF=Shut down the computer in 30 seconds?"
set "T_CD=Press C to cancel."
set "T_CANCELLED=Cancelled."
set "T_FAIL=Failed. UEFI may be unsupported or another shutdown is already pending."
set "T_WG_MISSING=Winget not found. Install App Installer from the Microsoft Store."
set "T_WG_OK=All applications updated."
set "T_WG_WARN=Winget finished with warnings. Check the output above."
set "T_PORT_Q=Port number (e.g. 8080):"
set "T_PORT_BAD=Port must be a number (1-65535)."
set "T_PORT_NONE=No listening process found on port"
set "T_PORT_ASK=Force-stop the processes listed above? Port:"
set "T_PORT_OK=Process stopped. Port:"
set "T_PORT_FAIL=Could not stop the process."
exit /b 0

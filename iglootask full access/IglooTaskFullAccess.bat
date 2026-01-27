@echo off
title IglooTask v1.3 - PK8.3
mode con: cols=100 lines=32
color 0b

:main
cls
echo ==========================================================================================
echo   IGLOOTASK v1.3 ^| TaskTool
echo ==========================================================================================
echo   1) PROCESS LIST          5) START NEW TASK
echo   2) PERFORMANCE           6) KILL TASK
echo   3) STARTUP APPS          7) DISABLE STARTUP APP
echo   4) NETWORK TASKS         9) FIX TASK MGR
echo                            8) EXIT
echo ==========================================================================================
echo.
set /p choice="Choice >> "

if "%choice%"=="1" goto list
if "%choice%"=="2" goto perf
if "%choice%"=="3" goto startup
if "%choice%"=="4" goto netproc
if "%choice%"=="5" goto start_task
if "%choice%"=="6" goto kill_task
if "%choice%"=="7" goto disable_startup
if "%choice%"=="8" exit
if "%choice%"=="9" goto fix_taskmgr
goto main

:list
cls
echo [ PROCESS LIST ]
tasklist /fi "memusage gt 5000"
echo.
pause
goto main

:perf
cls
echo [ PERFORMANCE ]
wmic cpu get loadpercentage, name
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value
pause
goto main

:startup
cls
echo [ STARTUP ]
echo --- USERPARTITION ---
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run
echo.
echo --- SISTEM BOLUMU ---
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
echo.
pause
goto main

:netproc
cls
echo [ NETWORK TASKS ]
netstat -ano | findstr "ESTABLISHED"
pause
goto main

:start_task
echo.
set /p "newtask=Calistirilacak program (orn: explorer.exe): "
start %newtask%
goto main

:kill_task
echo.
set /p "target=Durdurulacak EXE adi veya PID: "
taskkill /f /im %target% 2>nul || taskkill /f /pid %target% 2>nul
if %errorlevel%==0 (echo Islem durduruldu.) else (echo Bulunamadi.)
pause
goto main

:disable_startup
cls
echo [ RM STARTUP  ]
echo WRITE THE CODE OR NAME.
set /p appname="Isim: "
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v "%appname%" /f 2>nul
reg delete HKLM\Software\Microsoft\Windows\CurrentVersion\Run /v "%appname%" /f 2>nul
echo success.
pause
goto main

:fix_taskmgr
cls
echo [!] Task Manager kisitlamalari kaldiriliyor...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f 2>nul
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /t REG_DWORD /d 0 /f 2>nul
echo.
echo [+] Regedit repaired. 
echo [+] Ctrl+Shift+Esc is enabled.
echo.
pause
goto main
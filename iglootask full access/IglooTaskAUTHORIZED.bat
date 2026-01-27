@echo off
title IglooTask - Terminal Task Manager
mode con: cols=100 lines=30
color 0b

:main
cls
echo ==========================================================================================
echo   IGLOOTASK v1.1 ^| System Recovery ^& Task Management
echo ==========================================================================================
echo   1) PROCESS LIST          5) START NEW TASK
echo   2) PERFORMANCE           6) KILL TASK
echo   3) STARTUP APPS          7) DISABLE STARTUP APP (NEW)
echo   4) NETWORK TASKS         8) EXIT
echo ==========================================================================================
echo.
set /p choice="Selection >> "

if "%choice%"=="1" goto list
if "%choice%"=="2" goto perf
if "%choice%"=="3" goto startup
if "%choice%"=="4" goto netproc
if "%choice%"=="5" goto start_task
if "%choice%"=="6" goto kill_task
if "%choice%"=="7" goto disable_startup
if "%choice%"=="8" exit
goto main

:startup
cls
echo [ STARTUP PROGRAMS - CURRENT USER ]
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run
echo.
echo [ STARTUP PROGRAMS - MACHINE ]
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
echo.
pause
goto main

:disable_startup
cls
echo [ DISABLE STARTUP APP ]
echo 1) Disable from CURRENT USER
echo 2) Disable from MACHINE (Needs Admin)
echo 3) Back
set /p stype="Select area: "

if "%stype%"=="3" goto main
set /p appname="Enter the EXACT Value Name to delete: "

if "%stype%"=="1" (
    reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v "%appname%" /f
) else if "%stype%"=="2" (
    reg delete HKLM\Software\Microsoft\Windows\CurrentVersion\Run /v "%appname%" /f
)

if %errorlevel%==0 (echo Success: Startup entry removed.) else (echo Error: Entry not found or Access Denied.)
pause
goto main

:: --- Diğer Fonksiyonlar (Aynı Kalıyor) ---
:list
cls
tasklist /fi "memusage gt 10000"
pause
goto main

:perf
cls
wmic cpu get loadpercentage
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value
pause
goto main

:netproc
cls
netstat -ano | findstr "ESTABLISHED"
pause
goto main

:start_task
set /p "newtask=Enter program: "
start %newtask%
goto main

:kill_task
set /p "target=Enter Process/PID: "
taskkill /f /im %target% 2>nul || taskkill /f /pid %target% 2>nul
pause
goto main
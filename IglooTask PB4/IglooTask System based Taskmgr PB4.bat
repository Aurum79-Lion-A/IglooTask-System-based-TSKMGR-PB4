@echo off
title IglooTask PB4 - 
mode con: cols=100 lines=30
color 0b

:main
cls
echo ==========================================================================================
echo   IGLOOTASK v1.0 ^| System based Task Manager ^& Task Management
echo ==========================================================================================
echo   1) PROCESS LIST          	5) START TASK
echo   2) PERFORMANCE           	6) KILL TASK
echo   3) STARTUP APPS  		7) REFRESH
echo   4) DETAILED NETWORK TASKS	8) EXIT AND RESET BUFFER
echo ==========================================================================================
echo.
set /p choice="Selection >> "

if "%choice%"=="1" goto list
if "%choice%"=="2" goto perf
if "%choice%"=="3" goto startup
if "%choice%"=="4" goto netproc
if "%choice%"=="5" goto start_task
if "%choice%"=="6" goto kill_task
if "%choice%"=="7" goto main
if "%choice%"=="8" exit
goto main

:list
cls
echo [ PROCESS LIST ] - (Memory Usage > 10MB)
echo ------------------------------------------------------------
tasklist /fi "memusage gt 10000"
echo.
pause
goto main

:perf
cls
echo [ PERFORMANCE MONITOR ]
echo ------------------------------------------------------------
echo [CPU]
wmic cpu get loadpercentage, name
echo [MEMORY]
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value
echo [DISK]
wmic logicaldisk get caption, freespace, size
echo.
pause
goto main

:startup
cls
echo [ STARTUP PROGRAMS ]
echo ------------------------------------------------------------
wmic startup get caption, command
echo.
pause
goto main

:netproc
cls
echo [ NETWORK ACTIVE PROCESSES ]
echo ------------------------------------------------------------
netstat -ano | findstr "ESTABLISHED"
echo.
echo (Find the PID from list above and match with Process List)
pause
goto main

:start_task
echo.
set /p "newtask=Enter program name or path (e.g. notepad.exe): "
start %newtask%
if %errorlevel%==0 (echo Task started.) else (echo Error: Could not start task.)
timeout /t 2 >nul
goto main

:kill_task
echo.
set /p "target=Enter Process Name (e.g. chrome.exe) or PID: "
taskkill /f /im %target% 2>nul || taskkill /f /pid %target% 2>nul
if %errorlevel%==0 (echo Task terminated.) else (echo Task not found.)
timeout /t 2 >nul
goto main
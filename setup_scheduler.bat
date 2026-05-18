@echo off
:: ════════════════════════════════════════════════════
::  SETUP SCRIPT — Windows Task Scheduler
::  Creates 4 daily tasks that run auto_commit.py
::  Times: 09:00, 13:00, 18:00, 22:00
:: ════════════════════════════════════════════════════

:: Detect Python path
for /f "delims=" %%i in ('where python 2^>nul') do set PYTHON_PATH=%%i
if "%PYTHON_PATH%"=="" (
    echo [ERROR] Python not found. Install Python and add it to PATH.
    pause
    exit /b 1
)

:: Script location
set SCRIPT=%~dp0auto_commit.py

echo.
echo  ┌─────────────────────────────────────────────┐
echo  │   🤖  GitHub Auto-Commit Setup               │
echo  │   4 commits per day will be scheduled        │
echo  └─────────────────────────────────────────────┘
echo.
echo  Python  : %PYTHON_PATH%
echo  Script  : %SCRIPT%
echo.

:: ── Delete old tasks if they exist ──────────────────
schtasks /delete /tn "AutoCommit_9AM"  /f >nul 2>&1
schtasks /delete /tn "AutoCommit_1PM"  /f >nul 2>&1
schtasks /delete /tn "AutoCommit_6PM"  /f >nul 2>&1
schtasks /delete /tn "AutoCommit_10PM" /f >nul 2>&1

:: ── Create 4 scheduled tasks ────────────────────────

schtasks /create /tn "AutoCommit_9AM"  /tr "\"%PYTHON_PATH%\" \"%SCRIPT%\"" /sc DAILY /st 09:00 /f
schtasks /create /tn "AutoCommit_1PM"  /tr "\"%PYTHON_PATH%\" \"%SCRIPT%\"" /sc DAILY /st 13:00 /f
schtasks /create /tn "AutoCommit_6PM"  /tr "\"%PYTHON_PATH%\" \"%SCRIPT%\"" /sc DAILY /st 18:00 /f
schtasks /create /tn "AutoCommit_10PM" /tr "\"%PYTHON_PATH%\" \"%SCRIPT%\"" /sc DAILY /st 22:00 /f

if %errorlevel% == 0 (
    echo.
    echo  ✅ All 4 tasks scheduled successfully!
    echo.
    echo  📅 Schedule:
    echo     09:00  →  Commit 1
    echo     13:00  →  Commit 2
    echo     18:00  →  Commit 3
    echo     22:00  →  Commit 4
    echo.
    echo  ℹ️  Make sure your PC is ON at these times.
    echo  ℹ️  Git credentials must be saved (no password prompt).
) else (
    echo  ❌ Task creation failed. Try running as Administrator.
)

echo.
pause

@echo off
:: ════════════════════════════════════════════════════
::  TEST COMMIT SCRIPT
::  Runs auto_commit.py immediately to verify everything
:: ════════════════════════════════════════════════════

cd /d "%~dp0"

echo.
echo  ┌─────────────────────────────────────────────┐
echo  │   🚀 Testing Auto-Commit System             │
echo  │   Running auto_commit.py now...             │
echo  └─────────────────────────────────────────────┘
echo.

python auto_commit.py

echo.
echo  -------------------------------------------------
echo  📄 Latest logs (commit_log.txt):
echo  -------------------------------------------------
if exist commit_log.txt (
    type commit_log.txt
) else (
    echo  [LOG] No log file generated yet.
)
echo.

pause

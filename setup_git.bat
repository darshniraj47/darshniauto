@echo off
:: ════════════════════════════════════════════════════
::  GIT SETUP — Run this FIRST before setup_scheduler
::  Initializes repo and connects to GitHub
:: ════════════════════════════════════════════════════

cd /d "%~dp0"

echo.
echo  ┌─────────────────────────────────────────────┐
echo  │   🔧  Git Repository Setup                   │
echo  └─────────────────────────────────────────────┘
echo.

:: ── Ask for GitHub details ───────────────────────────
set /p GH_USER="Enter your GitHub username: "
set /p GH_EMAIL="Enter your GitHub email: "
set /p GH_REPO="Enter your GitHub repo URL (https://github.com/USER/REPO.git): "

:: ── Configure git identity ───────────────────────────
git config user.name  "%GH_USER%"
git config user.email "%GH_EMAIL%"

:: ── Initialize git if not already done ──────────────
if not exist ".git" (
    git init
    echo ✅ Git initialized
) else (
    echo ℹ️  Git already initialized
)

:: ── Create initial files ─────────────────────────────
if not exist "activity" mkdir activity
echo Auto-commit system started on %DATE% > activity\daily_tick.txt
echo. >> README.md

:: ── Initial commit ───────────────────────────────────
git add .
git commit -m "🚀 Initial commit — auto-commit system setup"

:: ── Connect to GitHub ────────────────────────────────
git remote remove origin >nul 2>&1
git remote add origin %GH_REPO%
git branch -M main
git push -u origin main

if %errorlevel% == 0 (
    echo.
    echo  ✅ GitHub connected successfully!
    echo  🌐 Repo: %GH_REPO%
) else (
    echo.
    echo  ❌ Push failed. Check your repo URL and credentials.
    echo  💡 Tip: Use GitHub Personal Access Token if asked for password.
)

echo.
pause

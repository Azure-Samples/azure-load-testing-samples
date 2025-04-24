@echo off
cd /d %~dp0
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "ps_files/launchkit.ps1"
pause
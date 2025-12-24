@echo off
setlocal

REM ============================================
REM  CONFIGURATION
REM ============================================
set OPENOCD_PATH="C:\OpenOCD\bin"
set PROJECT_NAME=tiva_project
set BUILD_TYPE=Debug

REM ============================================
REM  Paths
REM ============================================
set ROOT_DIR=%~dp0
set ELF_FILE=%ROOT_DIR%build\%BUILD_TYPE%\bin\%PROJECT_NAME%.elf

REM ============================================
REM  Check if file exists
REM ============================================
if not exist "%ELF_FILE%" (
    echo ERROR: ELF file not found: %ELF_FILE%
    echo Please build the project first.
    pause
    exit /b 1
)

REM ============================================
REM  Flash using OpenOCD
REM ============================================
echo Flashing %PROJECT_NAME% to TM4C123...
echo.

%OPENOCD_PATH%\openocd.exe ^
  -f interface/stlink-v2.cfg ^
  -f target/ti_tm4c123.cfg ^
  -c "program %ELF_FILE% verify reset exit"

if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo FLASHING SUCCESSFUL!
    echo ============================================
) else (
    echo.
    echo ============================================
    echo FLASHING FAILED!
    echo ============================================
)

pause
endlocal
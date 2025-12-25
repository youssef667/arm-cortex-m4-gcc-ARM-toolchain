@echo off

setlocal



REM ============================================

REM  CONFIGURATION

REM ============================================

set GCC="C:\Program Files (x86)\Arm\GNU Toolchain mingw-w64-i686-arm-none-eabi\bin\arm-none-eabi-"

set OPENOCD_PATH="C:\OpenOCD\bin"

set PROJECT_NAME=tiva_project

set BUILD_TYPE=Debug



REM ============================================

REM  Paths

REM ============================================

set ROOT_DIR=%~dp0

set ELF_FILE=%ROOT_DIR%build\%BUILD_TYPE%\bin\%PROJECT_NAME%.elf



REM ============================================

REM  Start OpenOCD server

REM ============================================

echo Starting OpenOCD server...

start "OpenOCD Server" %OPENOCD_PATH%\openocd.exe ^

  -f interface/stlink-v2.cfg ^

  -f target/ti_tm4c123.cfg



REM Wait for server to start

timeout /t 3 /nobreak > nul



REM ============================================

REM  Start GDB client

REM ============================================

echo Starting GDB...

%GCC_PATH%\arm-none-eabi-gdb.exe %ELF_FILE% ^

  -ex "target extended-remote localhost:3333" ^

  -ex "monitor reset halt" ^

  -ex "load" ^

  -ex "break main" ^

  -ex "continue"



REM Cleanup

taskkill /F /IM openocd.exe > nul 2>&1



endlocal
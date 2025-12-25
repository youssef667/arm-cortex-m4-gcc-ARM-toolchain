@echo off
echo.
echo =================================
echo   Building TIVA C Project
echo =================================
echo.

REM Set paths - don't touch this path 
set GCC="C:\Program Files (x86)\Arm\GNU Toolchain mingw-w64-i686-arm-none-eabi\bin\arm-none-eabi-"
set PROJ=tiva_project

REM Clean
if exist build rmdir /s /q build

REM Create directories
mkdir build
mkdir build\obj

REM Compile assembly
echo Compiling startup_tm4c123.s...
%GCC%gcc -mcpu=cortex-m4 -mthumb -c startup_tm4c123.s -o build\obj\startup.o
if errorlevel 1 goto error

REM Compile C
echo Compiling main.c...
%GCC%gcc -mcpu=cortex-m4 -mthumb -c src\main.c -o build\obj\main.o
if errorlevel 1 goto error

REM Link
echo Linking...
%GCC%gcc -mcpu=cortex-m4 -mthumb -T tm4c123gh6pm.ld -nostartfiles -Wl,-Map=build\%PROJ%.map build\obj\*.o -o build\%PROJ%.elf
if errorlevel 1 goto error

REM Create hex file
echo Creating hex file...
%GCC%objcopy -O ihex build\%PROJ%.elf build\%PROJ%.hex
%GCC%objcopy -O binary build\%PROJ%.elf build\%PROJ%.bin

REM Show results
echo.
echo =================================
echo BUILD SUCCESSFUL!
echo =================================
echo.
echo Files in 'build' folder:
echo   %PROJ%.elf
echo   %PROJ%.hex
echo   %PROJ%.bin
echo   %PROJ%.map
echo.
echo Memory usage:
%GCC%size build\%PROJ%.elf
echo.
pause
exit /b 0

:error
echo.
echo BUILD FAILED!
pause
exit /b 1
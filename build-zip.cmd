@echo off
set NOPAUSE=true
set VERBOSE_LOG_FLAG=true
set DYNAMIC_SCRIPTS_PATH="d:\dev\_VEAF\VEAF-Mission-Creation-Tools"
call build.cmd
copy build\*.miz .
pause
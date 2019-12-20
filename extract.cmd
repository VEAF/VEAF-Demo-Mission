@echo off
set MISSION_NAME=Test
echo -
echo ----------------------------------------
echo extracting Test Mission
echo ----------------------------------------

rem -- default options values
IF [%SEVENZIP%] == [] GOTO DefineDefaultSEVENZIP
goto DontDefineDefaultSEVENZIP
:DefineDefaultSEVENZIP
set SEVENZIP=7za
:DontDefineDefaultSEVENZIP
echo SEVENZIP = %SEVENZIP%
rem extracting MIZ files
"%SEVENZIP%" x -y *.miz -o"%cd%\src\mission\"
del /f /q src\mission\l10n\Default\*.lua
del *.miz

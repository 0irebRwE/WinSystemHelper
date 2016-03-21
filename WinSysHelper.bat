@echo off
rem ***********************************
rem *  WinSystemHelper                *
rem *  Author: avfisher               *
rem ***********************************

echo.
echo ************** WinSystemHelper **************
echo.
for /f "delims=" %%a in ('ver') do call :.ver %%a

if %winver%==5.0 set OSversion=Win_2000&&goto lt2003
if %winver%==5.1 set OSversion=Win_XP&&goto lt2003   
if %winver%==5.2 set OSversion=Win_2003&&goto lt2003
if %winver%==6.0 set OSversion=Win_2008/Win_Vesta&&goto gt2003 
if %winver%==6.1 set OSversion=Win_2008_R2/Win_7&&goto gt2003
if %winver%==6.2 set OSversion=Win_2012/Win_8&&goto gt2003 
set OSversion=Unknown&&goto quit

:.ver
if not "%2"=="" shift /1 &goto :.ver
set Winver=%1
set Winver=%Winver:~0,3%
exit /b

:lt2003
echo OS: %OSversion%
echo.
echo Exploit(s) of Privilege Escalation:
echo.
systeminfo > tmp.txt && for /f "tokens=1,2,3,4,* delims=," %%i in (explt2003.txt) do (
type tmp.txt|find /i "%%i"||echo vul: %%j, exp: %%l)
goto quit

:gt2003
echo OS: %OSversion%
echo.
echo Exploit(s) of Privilege Escalation:
echo.
systeminfo > tmp.txt && for /f "tokens=1,2,3,4,* delims=," %%i in (expgt2003.txt) do (
type tmp.txt|find /i "%%i"||echo vul: %%j, exp: %%l)
goto quit

:quit
del /f /q /a tmp.txt
exit /b

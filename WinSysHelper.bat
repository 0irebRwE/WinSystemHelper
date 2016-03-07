@echo off
rem ***********************************
rem *  WinSystemHelper                *
rem *  Author: avfisher               *
rem ***********************************

echo.
echo ************** WinSystemHelper **************
echo.
rem systeminfo > tmp.txt
for /f "delims=" %%a in ('ver') do call :.ver %%a

if %winver%==5.0 set OSversion=WIN2000&&goto lt2003
if %winver%==5.1 set OSversion=WINXP&&goto lt2003   
if %winver%==5.2 set OSversion=WIN2003&&goto lt2003
if %winver%==6.0 set OSversion=WIN2008&&goto gt2003 
if %winver%==6.1 set OSversion=WIN2008R2&&goto gt2003
if %winver%==6.2 set OSversion=WIN2012&&goto gt2003 
set OSversion=Unknown&&goto quit

:.ver
if not "%2"=="" shift /1 &goto :.ver
set Winver=%1
set Winver=%Winver:~0,3%
exit /b

:lt2003
for /f "tokens=1,2,3,4,* delims=," %%i in (explt2003.txt) do (
	find %%i tmp.txt && echo %%i,"installed" ||echo %%i,"not installed"
)
goto quit

:gt2003
systeminfo > tmp.txt && for /f "tokens=1,2,3,4,* delims=," %%i in (expgt2003.txt) do (type tmp.txt|find /i "%%i"||echo %%i,%%j,"not installed")
goto quit

:quit
echo.
echo ************** Cleaning files... **************
echo.
echo tmp.txt
del /f /q /a tmp.txt
echo.
echo ***************** Clean done! *****************
exit /b

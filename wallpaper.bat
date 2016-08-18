:: This batch file was made and tested on Windows 10

:: This file was created to try and create a script that changed my wallpaper
:: at certain times of the day with the use of Windows Task Scheduler.

:: Unfortunately, this script doesn't seem to run in the Task Scheduler as it
:: should and the lines near the bottom meant for updating the system
:: background only work sometimes. The registry gets successly changed
:: everytime I run the file, but the background doesn't always get updated;
:: sometimes just turning to a black screen.

@echo off

set VALID_NUMBERS=1,2,3,4,5,6,7,8,9
set wallpaper=E:\Users\spart\Pictures\Firewatch\firewatch_
set regKeyPath="HKCU\Control Panel\Desktop"

echo Wallpaper is being changed..

:: Gets the current time
set currentTime=%time:~0,2%.%time:~3,2%

:: Used for testing the first character of currentTime
set timeTest=%currentTime:~0,1%

:: Checks if the first character of currentTime is a valid number
for %%a in (%VALID_NUMBERS%) do (
	if %%a == %timeTest% goto timeOfDay
)

:: Sets the currentTime if it wasn't in a valid form
set currentTime=0%time:~1,1%.%time:~3,2%

:: Continues here if the currentTime was in valid format
:timeOfDay

::Morning
if %currentTime% GEQ 05.00 if %currentTime% LSS 09.30 (
	echo Morning
	set wallpaper=%wallpaper%morning.bmp
)

::Day
if %currentTime% GEQ 09.30 if %currentTime% LSS 15.30 (
	echo Day
	set wallpaper=%wallpaper%day.bmp
)

::Evening
if %currentTime% GEQ 15.30 if %currentTime% LSS 20.00 (
	echo Evening
	set wallpaper=%wallpaper%evening.bmp	
)

::Night
:: Need two lines because of 24-hour clock
if %currentTime% GEQ 20.00 (
	echo Night
	set wallpaper=%wallpaper%night.bmp
)
if %currentTime% LSS 05.00 (
	echo Night
	set wallpaper=%wallpaper%night.bmp
)

::Used for updating the desktop background
reg add %regKeyPath% /v Wallpaper /t REG_SZ /d "" /f
rundll32.exe user32.dll,UpdatePerUserSystemParameters
reg add %regKeyPath% /v Wallpaper /t REG_SZ /d %wallpaper% /f
rundll32.exe user32.dll,UpdatePerUserSystemParameters

pause
:end
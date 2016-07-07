@echo off
title Rough Backup Cyberfox Profile Windows 7-8-10 Version 1.4

setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "5.0" (
echo.Operating system is unsupported! >>"%~DP0errorlog.log"
goto :end
)
if "%version%" == "5.1" (
echo.Operating system is unsupported! >>"%~DP0errorlog.log"
goto :end
)
if "%version%" == "5.2" (
echo.Operating system is unsupported! >>"%~DP0errorlog.log"
goto :end
)
if "%version%" == "6.0" (
echo.Operating system is unsupported! >>"%~DP0errorlog.log"
goto :end
)
if "%version%" == "6.1" goto :continue
if "%version%" == "6.2" goto :continue
if "%version%" == "6.3" goto :continue
if "%version%" == "10.0" goto :continue
goto :end
endlocal

:continue
set curTimestamp=%date:~7,2%_%date:~3,3%_%date:~10,4%_%time:~0,2%_%time:~3,2%

if exist "%userprofile%\AppData\Roaming\8pecxstudios" (
set ProfilePath="%userprofile%\AppData\Roaming\8pecxstudios"
) else (
echo.Cyberfox profile folder not found!, Please check you have cyberfox installed and try again >>"%~DP0errorlog.log"
goto :end
)

if not exist "%~DP07za.exe" (
echo.7za.exe not found!, Please unpack the archive and try again >>"%~DP0errorlog.log"
goto :end
)

if exist "%ProfilePath%\Cyberfox\Profiles.ini" (
set iniProfile="%ProfilePath%\Cyberfox\Profiles.ini"
) else (
echo.Cyberfox profiles.ini not found!, Please check you have cyberfox installed and try again >>"%~DP0errorlog.log"
goto :end
)

if exist "%ProfilePath%\Cyberfox\Profiles" (
set folderProfile="%ProfilePath%\Cyberfox\Profiles"
) else (
echo.Cyberfox profiles folder not found!, Please check you have cyberfox installed and try again >>"%~DP0errorlog.log"
goto :end
)

tasklist /FI "IMAGENAME eq cyberfox.exe" 2>NUL | find /I /N "cyberfox.exe">NUL
if "%ERRORLEVEL%"=="0" (
echo Cyberfox is running, Please close before creating backups >>"%~DP0errorlog.log"
goto :end
)

if not exist "%~DP0_backups" mkdir "%~DP0_backups"
if not exist "%~DP0_backups\logs" mkdir "%~DP0_backups\logs"

for /f "tokens=* delims=|" %%f in ('dir /b "%folderProfile%"') do "%~DP07za.exe" a -mmt -mx9 -t7z "%~DP0_backups\%%f_%curTimestamp%_.7z" "%folderProfile%\%%f"  > "%~DP0_backups\logs\%%f_backup.log" && type "%~DP0_backups\logs\%%f_backup.log"
copy /y "%iniProfile%" "%~DP0_backups"

if exist "%~DP0_backups\Profiles.ini" (
ren "%~DP0_backups\Profiles.ini" "Profiles_%curTimestamp%_.ini"
) else (
echo.Rough Backup encountered an error!, Rough Backup was unable to location or replace the existing Profiles_%curTimestamp%_.ini  >>"%~DP0errorlog.log"
echo.Please check the backup was completed successfully >>"%~DP0errorlog.log"
goto :end
)

:end
popd
exit /b %ERRORLEVEL%
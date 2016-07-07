@ECHO OFF
TITLE Rough Backup Cyberfox Profile Windows 7-8-10 [Version 2.0]

:: SET current working directory.
SET DIR=%~DP0

:: Set profile backups folder and directory.
SET BACKUPSDIRECTORY=%DIR%_backups

:: Check current operating system is supported.
Call "%DIR%Functions\Check_OS.bat"

IF %ERRORLEVEL% EQU 0 (
	GOTO :CONTINUE
) ELSE IF %ERRORLEVEL% NEQ 0 (
    GOTO :END  
)

:CONTINUE
:: Set current date & time for time stamping files.
SET CURRENTTIMESTAMP=%date:~7,2%_%date:~3,3%_%date:~10,4%_%time:~0,2%_%time:~3,2%

:: Check if 8pecxsutdios folder in AppData\Roaming directory exists.
IF EXIST "%userprofile%\AppData\Roaming\8pecxstudios" (
    SET PROFILEPATH="%userprofile%\AppData\Roaming\8pecxstudios"
) ELSE (
    Call "%DIR%Functions\Error_Log.bat" "8pecxstudios folder in AppData\Roaming NOT found!, Please check you have cyberfox installed and try again" & GOTO :END
)

:: Check if profiles folder in AppData\Roaming\8pecxsutdios\Cyberfox directory exists.
IF EXIST "%PROFILEPATH%\Cyberfox\Profiles" (
    SET FOLDERPROFILE="%PROFILEPATH%\Cyberfox\Profiles"
) ELSE (
    Call "%DIR%Functions\Error_Log.bat" "Cyberfox profiles folder in AppData\Roaming\8pecxsutdios\Cyberfox NOT found!, Please check you have cyberfox installed and try again" & GOTO :END
)

:: Check if Profiles.ini in AppData\Roaming\8pecxsutdios\Cyberfox directory exists.
IF EXIST "%PROFILEPATH%\Cyberfox\Profiles.ini" (
    SET INIPROFILE="%PROFILEPATH%\Cyberfox\Profiles.ini"
) ELSE (
    Call "%DIR%Functions\Error_Log.bat" "Cyberfox profiles.ini in AppData\Roaming\8pecxsutdios\Cyberfox NOT found!, Please check you have cyberfox installed and try again" & GOTO :END
)

:: Check if the standalone 7za.exe (7ZIP) is present in the current directory.
IF NOT EXIST "%DIR%7za.exe" (
    Call "%DIR%Functions\Error_Log.bat" "7za.exe in current directory NOT found or may be corrupt, Please unpack the archive and try again" & GOTO :END
)

:: Check if cyberfox is currently running.
TASKLIST /FI "IMAGENAME eq cyberfox.exe" 2>NUL | FIND /I /N "cyberfox.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    Call "%DIR%Functions\Error_Log.bat" "Cyberfox is running, Please close before creating backups" & GOTO :END
)

:: Check if the backups & logs directories exists if not create them.
IF NOT EXIST "%BACKUPSDIRECTORY%" MKDIR "%BACKUPSDIRECTORY%"
IF NOT EXIST "%BACKUPSDIRECTORY%\logs" MKDIR "%BACKUPSDIRECTORY%\logs"

:: Create archives of all profiles found.
FOR /f "tokens=* delims=|" %%f IN ('DIR /b "%FOLDERPROFILE%"') DO "%DIR%7za.exe" a -mmt -mx9 -t7z "%BACKUPSDIRECTORY%\%%f_%CURRENTTIMESTAMP%_.7z" "%FOLDERPROFILE%\%%f"  > "%BACKUPSDIRECTORY%\logs\%%f_backup.log" && TYPE "%BACKUPSDIRECTORY%\logs\%%f_backup.log"
COPY /y "%INIPROFILE%" "%BACKUPSDIRECTORY%"

:: Rename the copy of Profiles.ini with the same time stamp as the archived profiles.
IF EXIST "%BACKUPSDIRECTORY%\Profiles.ini" (
    REN "%BACKUPSDIRECTORY%\Profiles.ini" "Profiles_%CURRENTTIMESTAMP%_.ini"
) ELSE (
    Call "%DIR%Functions\Error_Log.bat" "Rough Backup encountered an error!, Rough Backup was unable to location or replace the existing Profiles_%CURRENTTIMESTAMP%_.ini"
    Call "%DIR%Functions\Error_Log.bat" "Please check the backup was completed successfully" & GOTO :END
)

:END
POPD
EXIT /B %ERRORLEVEL%
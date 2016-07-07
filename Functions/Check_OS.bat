@ECHO OFF

:: ----------------------------------------------------------
:: Function declaration
:: ----------------------------------------------------------

CD %~dp0
SETLOCAL
FOR /f "tokens=4-5 delims=. " %%i IN ('VER') DO SET VERSION=%%i.%%j
IF "%version%" == "5.0" ( GOTO :ERROR )
IF "%version%" == "5.1" ( GOTO :ERROR )
IF "%version%" == "5.2" ( GOTO :ERROR )
IF "%version%" == "6.0" ( GOTO :ERROR )

:: Return success exit code if valid operating system.
POPD & EXIT /B 0

:ERROR
:: Return error exit code if invalid operating system.
CALL Error_Log.bat "Operating system is unsupported!"
POPD & EXIT /B 1

ENDLOCAL
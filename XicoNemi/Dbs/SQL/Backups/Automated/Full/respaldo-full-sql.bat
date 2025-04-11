@echo off
setlocal enabledelayedexpansion

:: Configuración
set MYSQL_USER=root
set MYSQL_PASSWORD=1234
set MYSQL_DATABASE=xiconemi
set BACKUP_PATH=C:\Respaldos
set BACKUP_FILE=%BACKUP_PATH%\FullBackup-%MYSQL_DATABASE%-%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%.sql

:: Encabezado ASCII
echo.
echo  ##################################################
echo  #                                                #
echo  #   RESPALDO BASE DE DATOS XICONEMI              #
echo  #                                                #
echo  ##################################################
echo.
echo    N   N  EEEEE  M   M  III
echo    NN  N  E      MM MM   I 
echo    N N N  EEEE   M M M   I 
echo    N  NN  E      M   M   I 
echo    N   N  EEEEE  M   M  III
echo.


mysqldump -u%MYSQL_USER% -p%MYSQL_PASSWORD% --databases %MYSQL_DATABASE% > "%BACKUP_FILE%"

:: Obtener fecha y hora con formato limpio
for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set /a HORA=100 + %%a
    set /a MIN=100 + %%b
    set /a SEG=100 + %%c
)
set START_TIME=%HORA:~1%:%MIN:~1%:%SEG:~1%

echo --------------------------------------------------
echo Iniciando respaldo de la base de datos: %MYSQL_DATABASE%
echo Fecha y hora de inicio: %DATE% %START_TIME%
echo --------------------------------------------------

:: Crear directorio de respaldo si no existe
if not exist "%BACKUP_PATH%" mkdir "%BACKUP_PATH%"

:: Ejecutar respaldo con mysqldump
mysqldump -u%MYSQL_USER% -p%MYSQL_PASSWORD% --databases %MYSQL_DATABASE% > "%BACKUP_FILE%"

:: Obtener hora de finalización
for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set /a HORA=100 + %%a
    set /a MIN=100 + %%b
    set /a SEG=100 + %%c
)
set END_TIME=%HORA:~1%:%MIN:~1%:%SEG:~1%

:: Calcular tiempo transcurrido en segundos (más preciso)
set /a TOTAL_START_SEC=(%START_HOUR%*3600) + (%START_MIN%*60) + %START_SEC%
set /a TOTAL_END_SEC=(%HORA%*3600) + (%MIN%*60) + %SEG%
set /a ELAPSED_SEC=%TOTAL_END_SEC% - %TOTAL_START_SEC%

set /a DURATION_HOUR=%ELAPSED_SEC% / 3600
set /a DURATION_MIN=(%ELAPSED_SEC% %% 3600) / 60
set /a DURATION_SEC=%ELAPSED_SEC% %% 60

:: Obtener tamaño del archivo
for %%F in ("%BACKUP_FILE%") do set SIZE=%%~zF

echo.
echo ==================================================
echo     RESPALDO COMPLETADO CORRECTAMENTE
echo ==================================================
echo Fecha y hora de finalización: %DATE% %END_TIME%
echo Duración total: %DURATION_HOUR%h %DURATION_MIN%m %DURATION_SEC%s
echo Tamaño del archivo generado: %SIZE% bytes
echo Archivo de respaldo: %BACKUP_FILE%
echo ==================================================
echo.

pause


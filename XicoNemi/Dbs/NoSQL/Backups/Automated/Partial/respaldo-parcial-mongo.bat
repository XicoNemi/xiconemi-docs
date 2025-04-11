@echo off
setlocal enabledelayedexpansion

:: Configuración
set MONGO_URI=mongodb+srv://octadev:112020a@clusteroctavio.n8a1lsl.mongodb.net/?retryWrites=true&w=majority&appName=ClusterOctavio
set BACKUP_PATH=C:\Respaldos
set DATABASE=nombre_de_tu_base_de_datos
set COLLECTION=tokens
set BACKUP_FILE=%BACKUP_PATH%\Backup_%DATABASE%_%COLLECTION%_%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%.gz

:: Encabezado ASCII
echo.
echo  ##################################################
echo  #                                                #
echo  #   RESPALDO PARCIAL MONGODB - CLUSTER XICONEMI  #
echo  #                                                #
echo  ##################################################
echo.
echo    N   N  EEEEE  M   M  III
echo    NN  N  E      MM MM   I 
echo    N N N  EEEE   M M M   I 
echo    N  NN  E      M   M   I 
echo    N   N  EEEEE  M   M  III
echo.

:: Obtener hora de inicio
for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set START_HOUR=%%a
    set START_MIN=%%b
    set START_SEC=%%c
)
set START_TIME=%START_HOUR%:%START_MIN%:%START_SEC%

echo Iniciando respaldo de MongoDB desde el URI: %MONGO_URI%
echo Base de datos: %DATABASE%
echo Colección: %COLLECTION%
echo Fecha y hora de inicio: %date% %START_TIME%
echo.

:: Crear directorio de respaldo si no existe
if not exist "%BACKUP_PATH%" mkdir "%BACKUP_PATH%"

:: Ejecutar respaldo de la colección tokens
mongodump --uri=%MONGO_URI% --db=%DATABASE% --collection=%COLLECTION% --archive="%BACKUP_FILE%" --gzip

:: Obtener hora de finalización
for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set END_HOUR=%%a
    set END_MIN=%%b
    set END_SEC=%%c
)
set END_TIME=%END_HOUR%:%END_MIN%:%END_SEC%

:: Calcular tiempo transcurrido
set /a DURATION_HOUR=%END_HOUR%-%START_HOUR%
set /a DURATION_MIN=%END_MIN%-%START_MIN%
set /a DURATION_SEC=%END_SEC%-%START_SEC%

:: Obtener tamaño del archivo
for %%F in ("%BACKUP_FILE%") do set SIZE=%%~zF

echo.
echo ====================================
echo =  RESPALDO COMPLETADO CON ÉXITO  =
echo ====================================
echo Fecha y hora de finalización: %date% %END_TIME%
echo Tiempo total de duración: %DURATION_HOUR%h %DURATION_MIN%m %DURATION_SEC%s
echo Magnitud del archivo de respaldo: %SIZE% bytes
echo Archivo generado en: %BACKUP_FILE%
echo.

endlocal
pause

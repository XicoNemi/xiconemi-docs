@echo off
setlocal enabledelayedexpansion

:: ===============================================
:: CONFIGURACIÓN DE VARIABLES
:: ===============================================
:: URI de conexión a MongoDB Atlas, ruta del respaldo
:: y nombre del archivo con fecha y hora.

set MONGO_URI=mongodb+srv://octadev:112020a@clusteroctavio.n8a1lsl.mongodb.net/?retryWrites=true&w=majority&appName=ClusterOctavio
set BACKUP_PATH=C:\Respaldos                            :: Carpeta donde se guardará el respaldo
set BACKUP_FILE=%BACKUP_PATH%\Backup_MongoDB_%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%.gz

:: ===============================================
:: ENCABEZADO ESTÉTICO PARA USUARIO
:: ===============================================

echo.
echo  ##################################################
echo  #                                                #
echo  #        RESPALDO MONGODB - CLUSTER XICONEMI     #
echo  #                                                #
echo  ##################################################
echo.
echo    N   N  EEEEE  M   M  III
echo    NN  N  E      MM MM   I 
echo    N N N  EEEE   M M M   I 
echo    N  NN  E      M   M   I 
echo    N   N  EEEEE  M   M  III
echo.

:: ===============================================
:: GUARDAR HORA DE INICIO DEL RESPALDO
:: ===============================================

for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set START_HOUR=%%a
    set START_MIN=%%b
    set START_SEC=%%c
)
set START_TIME=%START_HOUR%:%START_MIN%:%START_SEC%

:: Mensaje de inicio para el usuario
echo Iniciando respaldo de MongoDB desde el URI: %MONGO_URI%
echo Fecha y hora de inicio: %date% %START_TIME%
echo.

:: ===============================================
:: CREAR EL DIRECTORIO SI NO EXISTE
:: ===============================================

if not exist "%BACKUP_PATH%" mkdir "%BACKUP_PATH%"

:: ===============================================
:: EJECUTAR EL RESPALDO CON MONGODUMP
:: ===============================================
:: El archivo de salida es un `.gz` comprimido usando --gzip

mongodump --uri=%MONGO_URI% --archive="%BACKUP_FILE%" --gzip

:: ===============================================
:: GUARDAR HORA DE FINALIZACIÓN
:: ===============================================

for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set END_HOUR=%%a
    set END_MIN=%%b
    set END_SEC=%%c
)
set END_TIME=%END_HOUR%:%END_MIN%:%END_SEC%

:: ===============================================
:: CALCULAR TIEMPO TRANSCURRIDO
:: ===============================================

set /a DURATION_HOUR=%END_HOUR%-%START_HOUR%
set /a DURATION_MIN=%END_MIN%-%START_MIN%
set /a DURATION_SEC=%END_SEC%-%START_SEC%

:: ===============================================
:: OBTENER EL TAMAÑO DEL ARCHIVO FINAL
:: ===============================================

for %%F in ("%BACKUP_FILE%") do set SIZE=%%~zF

:: ===============================================
:: MENSAJE FINAL DE ÉXITO Y ESTADÍSTICAS
:: ===============================================

echo.
echo ====================================
echo =  RESPALDO COMPLETADO CON ÉXITO  =
echo ====================================
echo Fecha y hora de finalización: %date% %END_TIME%
echo Tiempo total de duración: %DURATION_HOUR%h %DURATION_MIN%m %DURATION_SEC%s
echo Magnitud del archivo de respaldo: %SIZE% bytes
echo Archivo generado en: %BACKUP_FILE%
echo.

:: Finaliza el entorno local y espera confirmación
endlocal
pause

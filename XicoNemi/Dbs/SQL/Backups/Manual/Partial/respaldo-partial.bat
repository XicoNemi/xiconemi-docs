@echo off
setlocal enabledelayedexpansion

:: ===============================================
:: CONFIGURACIÓN DE VARIABLES
:: ===============================================
:: Se define el usuario, contraseña, base de datos, las tablas a respaldar,
:: el directorio donde se guardará el respaldo y el nombre del archivo con fecha y hora.

set MYSQL_USER=root                    :: Usuario de MySQL
set MYSQL_PASSWORD=1234               :: Contraseña del usuario
set MYSQL_DATABASE=xiconemi           :: Nombre de la base de datos
set MYSQL_TABLES=users businesses     :: Tablas a respaldar
set BACKUP_PATH=C:\Respaldos          :: Carpeta donde se guardará el respaldo

:: Generación dinámica del nombre del archivo de respaldo
:: Incluye base de datos, tablas y marca de tiempo
set BACKUP_FILE=%BACKUP_PATH%\Backup_%MYSQL_DATABASE%_users_businesses-%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%.sql

:: ===============================================
:: ENCABEZADO DECORATIVO PARA EL USUARIO
:: ===============================================

echo.
echo ==================================================
echo =             RESPALDO DE TABLAS MYSQL           =
echo =          BASE DE DATOS: XICONEMI (LOCAL)       =
echo ==================================================
echo.
echo    N   N  EEEEE  M   M  III
echo    NN  N  E      MM MM   I 
echo    N N N  EEEE   M M M   I 
echo    N  NN  E      M   M   I 
echo    N   N  EEEEE  M   M  III
echo.

:: ===============================================
:: CAPTURAR LA HORA DE INICIO DEL RESPALDO
:: ===============================================

for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set START_HOUR=%%a
    set START_MIN=%%b
    set START_SEC=%%c
)
set START_TIME=%START_HOUR%:%START_MIN%:%START_SEC%

:: Mostrar mensaje de inicio con fecha y hora
echo Iniciando respaldo de las tablas users y businesses de la base de datos %MYSQL_DATABASE%...
echo Fecha y hora de inicio: %date% %START_TIME%
echo.

:: ===============================================
:: CREAR EL DIRECTORIO SI NO EXISTE
:: ===============================================

if not exist "%BACKUP_PATH%" mkdir "%BACKUP_PATH%"

:: ===============================================
:: EJECUTAR EL RESPALDO CON MYSQLDUMP
:: ===============================================
:: Solo respalda las tablas específicas declaradas en MYSQL_TABLES.

mysqldump -u%MYSQL_USER% -p%MYSQL_PASSWORD% %MYSQL_DATABASE% %MYSQL_TABLES% > "%BACKUP_FILE%"

:: ===============================================
:: CAPTURAR LA HORA DE FINALIZACIÓN DEL RESPALDO
:: ===============================================

for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set END_HOUR=%%a
    set END_MIN=%%b
    set END_SEC=%%c
)
set END_TIME=%END_HOUR%:%END_MIN%:%END_SEC%

:: ===============================================
:: CALCULAR DURACIÓN DEL RESPALDO
:: ===============================================
:: Esta operación asume que no hay cambio de hora en el sistema
:: entre el inicio y el final. No maneja casos de cambio de día.

set /a DURATION_HOUR=%END_HOUR%-%START_HOUR%
set /a DURATION_MIN=%END_MIN%-%START_MIN%
set /a DURATION_SEC=%END_SEC%-%START_SEC%

:: ===============================================
:: OBTENER EL TAMAÑO DEL ARCHIVO DE RESPALDO
:: ===============================================
:: Se calcula en bytes.

for %%F in ("%BACKUP_FILE%") do set SIZE=%%~zF

:: ===============================================
:: MENSAJE FINAL CON RESUMEN DEL RESPALDO
:: ===============================================

echo.
echo ====================================
echo =  RESPALDO COMPLETADO CON ÉXITO  =
echo ====================================
echo Fecha y hora de finalizacion: %date% %END_TIME%
echo Tiempo total de duracion: %DURATION_HOUR%h %DURATION_MIN%m %DURATION_SEC%s
echo Magnitud del archivo de respaldo: %SIZE% bytes
echo Archivo generado en: %BACKUP_FILE%
echo.

:: Finaliza el entorno local y espera confirmación del usuario
endlocal
pause

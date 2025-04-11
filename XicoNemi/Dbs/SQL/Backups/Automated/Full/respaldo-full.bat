@echo off
setlocal enabledelayedexpansion

:: ===============================================
:: CONFIGURACIÓN DE VARIABLES
:: ===============================================
:: Se definen las variables necesarias para conectarse a MySQL,
:: la base de datos que se va a respaldar y la ruta de almacenamiento.

set MYSQL_USER=root                 :: Usuario de MySQL
set MYSQL_PASSWORD=1234            :: Contraseña del usuario
set MYSQL_DATABASE=xiconemi        :: Nombre de la base de datos a respaldar
set BACKUP_PATH=C:\Respaldos       :: Ruta donde se guardará el respaldo

:: Se genera el nombre del archivo incluyendo fecha y hora.
:: %DATE:~6,4% = Año, %DATE:~3,2% = Mes, %DATE:~0,2% = Día
:: %TIME:~0,2%%TIME:~3,2% = Hora y minutos
set BACKUP_FILE=%BACKUP_PATH%\FullBackup-%MYSQL_DATABASE%-%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%.sql

:: ===============================================
:: ENCABEZADO EN CONSOLA PARA EL USUARIO
:: ===============================================
:: Solo sirve como presentación visual para indicar que se está
:: realizando el respaldo de la base de datos XICONEMI.

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

:: ===============================================
:: CAPTURA DE LA HORA DE INICIO
:: ===============================================
:: Se obtiene la hora actual para saber cuándo empieza el respaldo.
:: El formato de tiempo puede variar según la región (24h o 12h).

for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set /a HORA=100 + %%a
    set /a MIN=100 + %%b
    set /a SEG=100 + %%c
)
set START_TIME=%HORA:~1%:%MIN:~1%:%SEG:~1%

:: ===============================================
:: MENSAJE INFORMATIVO DE INICIO
:: ===============================================

echo --------------------------------------------------
echo Iniciando respaldo de la base de datos: %MYSQL_DATABASE%
echo Fecha y hora de inicio: %DATE% %START_TIME%
echo --------------------------------------------------

:: ===============================================
:: CREACIÓN DEL DIRECTORIO DE RESPALDO SI NO EXISTE
:: ===============================================
:: Antes de guardar el archivo, se verifica si la carpeta ya existe.
:: Si no, se crea automáticamente.

if not exist "%BACKUP_PATH%" mkdir "%BACKUP_PATH%"

:: ===============================================
:: RESPALDO DE LA BASE DE DATOS USANDO MYSQLDUMP
:: ===============================================
:: Se utiliza el comando `mysqldump` para exportar la base de datos
:: a un archivo `.sql` que contiene todas las instrucciones necesarias
:: para restaurarla más adelante.

mysqldump -u%MYSQL_USER% -p%MYSQL_PASSWORD% --databases %MYSQL_DATABASE% > "%BACKUP_FILE%"

:: ===============================================
:: CAPTURA DE LA HORA DE FINALIZACIÓN
:: ===============================================
:: Al terminar el respaldo, se vuelve a obtener la hora
:: para calcular la duración del proceso.

for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set /a HORA=100 + %%a
    set /a MIN=100 + %%b
    set /a SEG=100 + %%c
)
set END_TIME=%HORA:~1%:%MIN:~1%:%SEG:~1%

:: ===============================================
:: CÁLCULO DEL TIEMPO TRANSCURRIDO (INCOMPLETO)
:: ===============================================
:: Intenta calcular cuántos segundos duró el respaldo.
:: ⚠️ Nota: esta parte tiene un error porque las variables START_HOUR,
:: START_MIN y START_SEC no se definieron, así que no calcula bien.

set /a TOTAL_START_SEC=(%START_HOUR%*3600) + (%START_MIN%*60) + %START_SEC%
set /a TOTAL_END_SEC=(%HORA%*3600) + (%MIN%*60) + %SEG%
set /a ELAPSED_SEC=%TOTAL_END_SEC% - %TOTAL_START_SEC%

set /a DURATION_HOUR=%ELAPSED_SEC% / 3600
set /a DURATION_MIN=(%ELAPSED_SEC% %% 3600) / 60
set /a DURATION_SEC=%ELAPSED_SEC% %% 60

:: ===============================================
:: OBTENER TAMAÑO DEL ARCHIVO GENERADO
:: ===============================================
:: Aquí se mide el peso final del archivo `.sql` de respaldo.

for %%F in ("%BACKUP_FILE%") do set SIZE=%%~zF

:: ===============================================
:: MENSAJE FINAL CON RESUMEN DEL PROCESO
:: ===============================================
:: Se informa al usuario que el respaldo terminó, cuánto duró y
:: cuánto pesa el archivo generado.

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

:: ===============================================
:: PAUSA FINAL PARA VER LA INFORMACIÓN EN PANTALLA
:: ===============================================
:: La terminal no se cierra automáticamente hasta que el usuario presione una tecla.

pause

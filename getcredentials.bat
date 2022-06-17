@ECHO OFF
@REM Usando el comando cmdkey, comprobar si el valor devuelto contiene la cadena "NINGUNO" o "NONE"

set PC=DELL-PC
set ADMNUSER=DELL

CLS

@REM Guardar en la variable "VALUE" el resultado de ejecutar el comando cmdkey

FOR /F "tokens=*" %%i IN ('cmdkey /list:domain:interactive=%PC%\%ADMNUSER%') DO (
    if %%i == "* NINGUNO * " (
        ECHO "El usuario %ADMNUSER% no tiene credenciales"
    )
)







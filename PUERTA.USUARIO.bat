@ECHO OFF
FOR /F "tokens=1,2 delims=." %%i in ("%~n0") do (
  SET GTWY=%%i
  SET USER=%%j
)

IF "%USER%" NEQ "" IF "%GTWY%" NEQ "" (
    @REM Comprobar que la variable USER no esté vacía
    IF [%1]==[] (
        REM Iniciar este archivo como el usuario SISTEMAS ("La cuenta con privilegios de administrador")
        ( if exist "%temp%\user.vbs" del "%temp%\user.vbs" ) 
        cd /d "%~dp0" 
        fsutil dirty query %systemdrive% 1>nul 2>nul || (  
            cmd /u /c echo Set WshShell = WScript.CreateObject^("WScript.Shell"^)  >> "%temp%\user.vbs"
            cmd /u /c echo WshShell.run^("runas /user:%USER% /savedcred ""%~dpnx0 1"""^)  >> "%temp%\user.vbs" >> "%temp%\user.vbs" >> "%temp%\user.vbs" && "%temp%\user.vbs" 1>nul 2>nul && exit /B )


    ) ELSE (
        IF "%1" == "1" (
        REM Iniciar este archivo como el usuario Administrador.
            ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) 
            fsutil dirty query %systemdrive% 1>nul 2>nul || (  
                cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "%~dpnx0", "2", "%~dp0", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" 1>nul 2>nul && exit /B )
                PAUSE
            CLS
        ) ELSE (                
            @ECHO OFF

            REM CAMBIAR PUERTA DE ENLACE
            SETLOCAL EnableDelayedExpansion 
            FOR /f "delims=[] tokens=2" %%a in ('PING -4 -n 1 %COMPUTERNAME% ^| FINDSTR [') do SET IP=%%a
            FOR /F "tokens=4*" %%a in ('netsh interface show interface ^| more +2') do (
                REM echo %%a %%b
                FOR /F "tokens=4*" %%f in ('netsh interface show interface "%%a %%b"') do (
                    IF %%f == Conectado netsh interface ipv4 set address "%%a %%b" static !IP! 255.255.255.0 192.100.10.%GTWY%  
                    
                )
            )
            EXIT
        )    
    )
) 

ECHO Ocurrio un error durante la obtencion del Usuario y la Puerta de Enlace.
TIMEOUT /T 5

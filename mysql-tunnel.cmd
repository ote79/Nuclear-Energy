@echo off
setlocal

set "SSH_EXE=%WINDIR%\System32\OpenSSH\ssh.exe"
set "SERVER_USER=ubuntu"
set "SERVER_HOST=159.75.132.76"
set "LOCAL_PORT=3307"
set "REMOTE_HOST=127.0.0.1"
set "REMOTE_PORT=3306"

if not exist "%SSH_EXE%" (
    echo ssh.exe not found: %SSH_EXE%
    pause
    exit /b 1
)

echo Starting SSH tunnel...
echo Local endpoint: 127.0.0.1:%LOCAL_PORT%
echo Remote endpoint: %REMOTE_HOST%:%REMOTE_PORT% via %SERVER_USER%@%SERVER_HOST%
echo Keep this window open. Closing it will stop the tunnel.
echo.

"%SSH_EXE%" -N -L %LOCAL_PORT%:%REMOTE_HOST%:%REMOTE_PORT% %SERVER_USER%@%SERVER_HOST% -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -o ExitOnForwardFailure=yes

echo.
echo Tunnel closed.
pause

@echo off
setlocal enabledelayedexpansion

set /p app=<.config
for /f "tokens=2 delims==" %%a in ('findstr "appname" .config') do (
  set "app=%%a"
)
for /f "tokens=2 delims==" %%a in ('findstr "ports" .config') do (
  set "ports=%%a"
)

for /f "tokens=1" %%a in ('docker ps ^| findstr "!app!"') do (
  docker stop %%a
)

docker rm --force %app%

docker build -t %app% .

REM docker run -p 80:80 -d python-api-rest
REM docker run -p %ports% -d %app%
docker run -p 5000:5000 -d %app%

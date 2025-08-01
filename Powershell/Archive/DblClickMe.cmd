@echo off

set "IPConfigFile=%USERPROFILE%\ipconfig.txt" & set "NetDir=%USERPROFILE%\Desktop"

DATE /T > %IPConfigFile%
TIME /T >> %IPConfigFile%
ipconfig -all >> %IPConfigFile%
SYSTEMINFO >> %IPConfigFile%

TYPE %IPConfigFile%

COPY /V /Y %IPConfigFile% %NetDir%

set IPConfigFile=
set NetDir=
pause

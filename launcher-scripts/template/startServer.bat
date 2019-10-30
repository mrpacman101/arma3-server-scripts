:: =====================================
:: === Launch Arma3 Server Instance ====
:: =====================================
:: ==== Author:   Mark Chang
:: ==== Author    Email: me@markchang.de
:: ==== License:  GPL-3.0
:: =====================================
:: ==== Description:
:: ==== Simple Batch Script which handles launching arma3server and keeping it running without extended Battleye enabled.
:: =====================================
:: ==== How to use:
:: Just copy this file and rename it to (for example) startServer_ExilePublic.bat
:: Make sure to edit this file in a Notepad Editor or Notepad++ (whatever you prefer)
:: Read the comments first and adjust below parameters
:: You can have multiple instances running just rename this file to (for example) startServer_ExilePublic2.bat
:: and make sure you change the Port, instanceName and serverName.
:: Keep the CMD Window open in order to use the full functionalities of this script.
:: =====================================

:: Echo Code for Debugging - default off
@ECHO off

:: Everything local
SETLOCAL

:: ClearScreen
cls

:: General Params
SET scriptVersion=0.0.1

:: ===============================
:: ==== START EDIT Parameters BELOW:
:: Adjust below Parameters but read comments first
:: ==== Note:
:: Do not remove the quotes around the SET "param=" this will help escaping spaces
:: ===============================

:: == Set the gamePort
:: If you have multiple instances running make sure to use different ports.
SET gamePort=2302

:: == Set the instanceName
:: Can be anything you want to identify your Server
SET "instanceName=Arma3 Example Server"

:: == Set the installRootDir
:: Input the path to your arma3 installation folder
SET "installRootDir=C:\ExampleServerInstall"

:: == Set the arma3 server executable either normal or new 64bit
:: == Default: arma3server.exe
:: == 64-bit Version: arma3server_x64.exe
SET arma3Exec=arma3server.exe

:: == Set the serverName
:: This is basicly the name of the Server and must be the same as the server Profile Name
:: == Note: If possible prevent spaces in serverName!
SET serverName=Example_Server

:: == Set the path to the Profile, Server and Network Config
:: By default it uses the arma3 standard configs. You can use TADST to generate the path and configs or edit them yourself.
:: == Example:
:: // SET pathToProfile=%installRootDir%\TADST\%serverName%
:: // SET pathToConfig=%installRootDir%\TADST\%serverName%\TADST_config.cfg
:: // SET pathToNetworkConfig=%installRootDir%\TADST\%serverName%\TADST_basic.cfg
SET "pathToProfile=default_profile"
SET "pathToConfig=default_profile\example_config.cfg"
SET "pathToNetworkConfig=default_profile\example_basic.cfg"

:: == Set startupParams
:: See for more infos: https://community.bistudio.com/wiki/Arma_3_Startup_Parameters
SET "startupParams=-netlog -hugePages -noSound"

:: == Set modList
:: Copy paste from TADST or manual edit the line below.
:: Example: "modList=C:\InstallRoot\@CBA_A3;C:\InstallRoot\@CUP_Weapons"
SET "modList="

:: ========================================================
:: =================== DO NOT EDIT BELOW ==================
:: ========================================================
:: Window Title
TITLE Launch %instanceName% Instance

:: Check if Server was installed otherwise notify and exit
if not exist "%installRootDir%\%arma3Exec%" ^
GOTO :not_installed

:: Go to the Arma3Server Root Directory
:: allows to drop the batch file anywhere on the server
cd %installRootDir%

:: Launch Instance
start "%instanceName%" /wait /high "arma3Exec" -port=%gamePort% "-config=%pathToConfig%" "-cfg=%pathToNetworkConfig%" "-profiles=%pathToProfile%" -name=%serverName% %startupParams% "-mod=%modList%"

:: If server instance crashed or closed
:: The CMD Window needs to stay open for it to work!
echo (%time%) %instanceName% closed or crashed, restarting.
GOTO observer

:: Observer of executable which auto-starts the .exe if crashed or closed
:observer
:: Clear the crap generated above and start over
cls
echo (%time%) %instanceName% started.

:not_installed
echo "It seems you have not installed Arma3Server or the Path to the Installation Directory is wrong." ^
GOTO :exit_script

:exit_script
:: Exit Script on key pressed
echo "Press any key to exit!"
pause
ENDLOCAL
TIMEOUT /t 5

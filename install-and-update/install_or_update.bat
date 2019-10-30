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

:: ECHO Code for Debugging - default off
@ECHO off

:: Everything local
SETLOCAL

:: ClearScreen
cls

:: General Params
SET scriptVersion=0.0.1

@rem http://media.steampowered.com/installer/steamcmd.zip

SETLOCAL ENABLEDELAYEDEXPANSION

:: DEFINE the following variables where applicable to your install

:start_user_input
:: Set Steam Login Name
SET /P steamLoginName=Please enter your Steam Login Name:
IF "%steamLoginName%"=="" GOTO :no_user_input
:: Set Steam Login Password
SET /P steamLoginPwd=Please enter your Steam Password:
IF "%steamLoginPwd%"=="" GOTO :no_user_input
:: Set Arma3 Installation Folder
SET /P armaDestPath=Please enter the full Arma3 Installation Destination Path:
IF "%armaDestPath%"=="" GOTO :no_user_input
:: Set steamcmd Installation Folder
SET /P "steamcmdDestPath=Please enter the full steamcmd Installation Destination Path:
IF "%steamcmdDestPath%"=="" GOTO :no_user_input
GOTO :end_user_input

:: If input was missing value/s then display all here to see check if anything was missing
:no_user_input
ECHO "User Input missing. Check below Outputs to see if you missed anything!"

ECHO "Steam Login Name"           %steamLoginName%
ECHO "Steam Login Password"       %steamLoginPwd%
ECHO "Arma3 Installation Path"    %armaDestPath%
ECHO "steamcmd Installation Path" %steamcmdDestPath%
TIMEOUT /t 10
:: Startover if above value/s where missing something
GOTO :start_user_input

:: If everything was passed then show summary of user Input
:end_user_input
ECHO "Steam Login Name"           %steamLoginName%
ECHO "Arma3 Installation Path"    %armaDestPath%
ECHO "Steamcmd Installation Path" %steamcmdDestPath%
TIMEOUT /t 4

:: ==== DO NOT EDIT BELOW ====
SET STEAMLOGIN=%steamLoginName% %steamLoginPwd%
:: For stable use 233780 -beta
:: For Dev use 233780 -beta development
SET A3serverBRANCH=233780 -beta

:: _________________________________________________________
ECHO  "."
ECHO  "You are about to install or update ArmA3 server"
ECHO  "."
ECHO  "Press any Key to procceed"
pause

:: Start the installation or update routine
%steamcmdDestPath%\steamcmd.exe +login %STEAMLOGIN% +force_install_dir %armaDestPath% +"app_update %A3serverBRANCH%" validate +quit
ECHO  "."
ECHO "Your ArmA 3 server is now installed and up to date"
ECHO "Press any key to exit"
pause

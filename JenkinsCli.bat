@echo off
setlocal EnableDelayedExpansion
set nodeName=%1
set cwd="C:\\Workspace"

:: should around variable by double quote to ensure batch file raise exception
:: HELP PART
if /I "%~1" EQU "/?" (
    goto HELP
)

:: INITIAL PART
echo *****************************************************
echo ** Jenkins Command Line Interactive [Version 0.0.1.a]
echo ** (c) 2022 Dang Huy Hoang. All rights reserved.
echo *****************************************************
echo ** CAUTION 0: This version only supports multiple command at a time on one line (split by ^&^&).
echo ** CAUTION 1: use command below to switch working directory, should using it before another command if you're using multiple command on a line.
echo **          chdir D:
echo **          chdir C:\\Workspace
echo **          chdir the-full-path-with-double-backslash-and-no-trailing-backslash
echo ** CAUTION 2: use command below to exit the current session.
echo **          exit
echo *****************************************************
echo(
:: ASK NODE NAME
if /I "%~1" EQU "" (
    set /p nodeName="Enter node name:"
)
echo Entering node %nodeName%...
echo(

:: MAIN PART
:: change working directory to current directory path of the running batch file
cd /d %~dp0
:MAIN_PART
set /p command="JenkinsCLI %cwd% [%nodeName%]>"
:: Split two part of command
set "opt="
for /f "tokens=1" %%h in ("%command%") do (
    if not defined opt set "opt=%%h"
)
:: Check if chdir command, switch into another working directory
:: Do not use trailing slash or backslash
if /I "%opt%" EQU "chdir" (
    for /f "tokens=2" %%h in ("%command%") do (
        set "cwd=%%h"
    )
    set "chdir_cmd=chdir !cwd!"
    call set "command=%%command:!chdir_cmd!=pwd%%"
)
if /I "%opt%" EQU "exit" (
    goto END
)
:: Call ScriptConsole
call ScriptConsole.bat !nodeName! "!command!" "!cwd!"
GOTO :MAIN_PART
goto END

:HELP
echo Execute command on jenkins node based on script console.
echo(
echo %~nx0 [nodename]
echo(
pause

:END
echo Exiting...
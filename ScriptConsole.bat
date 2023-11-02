@echo off
setlocal EnableDelayedExpansion
set nodeName=%1
set executeCommand=%2
set cwd=%3

:: should around variable by double quote to ensure batch file raise exception
if /I "%~1" EQU "/?" (
    goto HELP
)

:: change working directory to current directory path of the running batch file
cd /d %~dp0
:: Using Rest API
sh ./curl.sh !nodeName! !executeCommand! !cwd! !JK_USER! !JK_TOKEN! !JK_URL!
:: Using jenkins cli
@REM java -jar jenkins-cli.jar -s !JK_URL! ^
@REM -auth !JK_USER!:!JK_TOKEN! ^
@REM -webSocket groovy = !nodeName! !executeCommand! !cwd! < ExecuteCommandOnNode_viaCLI.groovy

goto END

:HELP
echo Execute command on jenkins node based on script console.
echo(
echo %~nx0 [nodename] [command to execute] [working directory]
echo(
echo Example: ScriptConsole.bat 410336 "echo hello" "C:\\Workspace"
pause

:END
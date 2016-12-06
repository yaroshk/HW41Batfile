@ECHO OFF
::==============================================================================================

SET GITHUB_ACCOUNT=yaroshk
SET WS_DIR=Workspace
SET REPO_NAME=HW41
SET APP_VERSION=1.1
SET MAIN_CLASS=core.Selenium
SET ARGS_01=


::============================================================================================

IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
ECHO Java installed
IF "%M2%" == "" GOTO EXIT_MVN
ECHO Maven installed
CALL git --version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
ECHO Git installed
GOTO NEXT

:NEXT
IF NOT EXIST C:\%WS_DIR% GOTO NO_WORKSPACE
IF EXIST C:\%WS_DIR%\%REPO_NAME% RMDIR /S /Q C:\%WS_DIR%\%REPO_NAME%
CD C:\%WS_DIR%
 
git clone git@github.com:yaroshk/HW41.git

CD %REPO_NAME%
ECHO go to repo name
ping 127.0.0.1 -n 4 > nul
CALL mvn clean site -Dtest=AllTest -Da.version="1.1"
ECHO Executing JAVA	

Echo We don't compile the java file the program will close after this
Echo We can call mvn package in this case it will run main class
java -cp C:\%WS_DIR%\%REPO_NAME%\target\%APP_VERSION%.jar %MAIN_CLASS% %ARG_01%

GOTO END
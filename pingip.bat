@echo off
:ping_loop
set /p ip=Please enter the desired IP for ping: 
if "%ip%"=="" (
    echo IP cannot be empty!
    goto ping_loop
)

:: Create a folder named after the IP
mkdir "%ip%"

:: Get the current date and time
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do set mydate=%%a-%%b-%%c
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set mytime=%%a-%%b

:: Define the log file name
set logfile=%ip%\%mydate%_%mytime%.txt

:: Use PowerShell for real-time ping and logging
powershell -Command "ping %ip% | Tee-Object -FilePath '%logfile%'"

echo ============================
echo Ping completed. Log saved to %logfile%.

set /p again=Want another ping? (y/n): 
if /i "%again%"=="y" goto ping_loop

echo Thank you for using the service!
timeout /t 3
exit

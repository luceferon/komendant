@echo off
setlocal

set SERVER=192.168.28.167
set USER=root
set PASSWORD=admin213
set DB=komendant

rem Create timestamp for unique filename
for /f "tokens=2 delims==." %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "TIMESTAMP=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%_%dt:~8,2%-%dt:~10,2%-%dt:~12,2%"

set FILENAME=%DB%_%TIMESTAMP%.sql

echo Creating backup %FILENAME%...

mysqldump -h %SERVER% -u %USER% -p%PASSWORD% %DB% > "%FILENAME%"

if %errorlevel% neq 0 (
    echo Error creating backup.
) else (
    echo Backup created successfully.
)

endlocal
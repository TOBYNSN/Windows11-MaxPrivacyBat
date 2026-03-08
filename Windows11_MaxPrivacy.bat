@echo off
:: ------------------------------
:: Windows 11 Maximal Privacy All-in-One
:: ------------------------------

echo Stopping telemetry services...
sc stop DiagTrack
if %errorlevel% neq 0 (
    echo [INFO] DiagTrack was not running or already stopped
) else (
    echo [OK] DiagTrack stopped
)

sc config DiagTrack start= disabled
if %errorlevel% neq 0 (
    echo [FAILED] Could not disable automatic start of DiagTrack
) else (
    echo [OK] DiagTrack automatic start disabled
)

echo Stopping push and diagnostic services...
sc stop dmwappushservice
if %errorlevel% neq 0 echo [INFO] dmwappushservice was not running or invalid
sc config dmwappushservice start= disabled
if %errorlevel% neq 0 echo [FAILED] Could not disable dmwappushservice

echo Editing registry for privacy...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
if %errorlevel% neq 0 echo [FAILED] Cortana registry

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
if %errorlevel% neq 0 echo [FAILED] AdvertisingInfo registry

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f
if %errorlevel% neq 0 echo [FAILED] ContentDeliveryManager registry

echo Disabling app access to devices...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /t REG_SZ /d Deny /f
if %errorlevel% neq 0 echo [FAILED] Microphone registry

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v Value /t REG_SZ /d Deny /f
if %errorlevel% neq 0 echo [FAILED] Camera registry

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d Deny /f
if %errorlevel% neq 0 echo [FAILED] Location registry

echo Editing hosts file to block Microsoft telemetry...
copy %windir%\System32\drivers\etc\hosts %windir%\System32\drivers\etc\hosts.bak
if %errorlevel% neq 0 echo [FAILED] Hosts backup failed

(
echo 0.0.0.0 vortex.data.microsoft.com
echo 0.0.0.0 telemetry.microsoft.com
echo 0.0.0.0 watson.telemetry.microsoft.com
echo 0.0.0.0 settings-win.data.microsoft.com
echo 0.0.0.0 v10.events.data.microsoft.com
) >> %windir%\System32\drivers\etc\hosts
if %errorlevel% neq 0 echo [FAILED] Hosts file block failed

echo Disabling Web Search and Timeline...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ActivityHistory" /v PublishUserActivities /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ActivityHistory" /v UploadUserActivities /t REG_DWORD /d 0 /f

echo Disabling Office telemetry...
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Common\Privacy" /v DisableTelemetry /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Common\Privacy" /v BlockTelemetry /t REG_DWORD /d 1 /f

echo Done! Restarting Explorer to apply changes...
taskkill /f /im explorer.exe & start explorer.exe
echo Explorer has been restarted.
pause
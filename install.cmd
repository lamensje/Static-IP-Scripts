set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

PowerShell.exe -ExecutionPolicy Bypass -Command Set-ExecutionPolicy RemoteSigned

copy Set_DHCP.ps1 C:\Windows\System32\WindowsPowerShell\v1.0\
copy Set_Static_IP.ps1 C:\Windows\System32\WindowsPowerShell\v1.0\
copy Set_Static_IP_Huawei.ps1 C:\Windows\System32\WindowsPowerShell\v1.0\
copy Set_Static_IP_Growatt.ps1 C:\Windows\System32\WindowsPowerShell\v1.0\
copy Set_Static_IP_Internet.ps1 C:\Windows\System32\WindowsPowerShell\v1.0\
del Set_Static_IP.ps1
del Set_DHCP.ps1
del Set_Static_IP_Huawei.ps1
del Set_Static_IP_Growatt.ps1
del Set_Static_IP_Internet.ps1
del install.cmd
pause
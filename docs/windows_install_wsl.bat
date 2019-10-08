echo on

REM Installing Chocolatey - "The package manager for Windows"...
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
REM Chocolatey install complete.

REM Windows feature installs
choco install -y --no-progress --source windowsfeatures ^
    Microsoft-Windows-Subsystem-Linux ^
    Microsoft-Hyper-V-All

REM Software Installs (Other)
choco install --no-progress -y ^
    wsl-ubuntu-1804

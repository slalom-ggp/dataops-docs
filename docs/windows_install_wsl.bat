echo on

REM Installing Chocolatey - "The package manager for Windows"...
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
REM Chocolatey install complete.

REM Enabling Windows feature...
choco install --no-progress -y wsl
REM Dism /online /Enable-Feature /NoRestart /FeatureName:Microsoft-Windows-Subsystem-Linux

refreshenv

REM Installing Ubuntu...
choco install --no-progress --verbose -y ^
    wsl-ubuntu-1804

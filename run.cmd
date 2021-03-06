@echo off
setlocal
cd /d %~dp0

:: install latest CLI to .dotnet/
powershell -ExecutionPolicy Bypass .\installcli.ps1

:: find version of Microsoft.Private.WPF that came with CLI and use that for nupkg
for /d %%d in (.dotnet\shared\Microsoft.Private.WPF\*) do (
    set MicrosoftWpfPrivatePackageVersion=%%~nxd
)

:: set up child processes (msbuild, devenv to use downloaded CLI)
set DOTNET_MULTILEVEL_LOOKUP=0
set DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
set PATH=%CD%\.dotnet;%PATH%

:: run arguments as a command with environment setup above
%*

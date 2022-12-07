# Base Windows Image
FROM mcr.microsoft.com/windows/server:ltsc2022

# Change to Root Dir
WORKDIR /

# Copy InstallShield installer to root
ADD InstallShield2021R2StandaloneBuild.exe /

# InstallShield installation
RUN InstallShield2021R2StandaloneBuild.exe /s /v"INSTALLLEVEL=101 SABCONTAINER=1 /qn"

RUN powershell Remove-Item InstallShield2021R2StandaloneBuild.exe

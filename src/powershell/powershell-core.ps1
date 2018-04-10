Function InstallChocoPackages()
{
    choco install chocolatey
    choco install flashplayerplugin
    choco install googlechrome
    choco install winrar
    choco install jre8
    choco install adobereader
    choco install firefox
    choco install flashplayeractivex
    choco install chocolatey-core.extension
    choco install adobeair
    choco install 7zip.install
    choco install javaruntime
    choco install skype
    choco install notepadplusplus.install
    choco install git.install
    choco install nodejs.install
    choco install vlc
    choco install git
    choco install 7zip
    choco install notepadplusplus
    choco install ccleaner
    choco install putty.install
    choco install jdk8
    choco install adobeshockwaveplayer
    choco install silverlight
    choco install filezilla
    choco install dotnet4.5
    choco install adobereader-update
    choco install ruby
    choco install putty
    choco install libreoffice
    choco install nodejs
    choco install curl
    choco install php
    choco install atom
    choco install github
    choco install virtualbox
    choco install dropbox
    choco install python2
    choco install python
    choco install youtube-dl
    choco install visualstudiocode
    choco install fiddler4
    choco install foxitreader
    choco install sourcetree
    choco install googledrive
    choco install docker
}

Function UpgradeChocoPackages()
{
    choco upgrade chocolatey -y
    choco upgrade flashplayerplugin -y
    choco upgrade googlechrome -y
    choco upgrade winrar -y
    choco upgrade jre8 -y
    choco upgrade adobereader -y
    choco upgrade firefox -y
    choco upgrade flashplayeractivex -y
    choco upgrade chocolatey-core.extension -y
    choco upgrade adobeair -y
    choco upgrade 7zip.install -y
    choco upgrade javaruntime -y
    choco upgrade skype -y
    choco upgrade notepadplusplus.install -y
    choco upgrade git.install -y
    choco upgrade nodejs.install -y
    choco upgrade vlc -y
    choco upgrade git -y
    choco upgrade 7zip -y
    choco upgrade notepadplusplus -y
    choco upgrade ccleaner -y
    choco upgrade putty.install -y
    choco upgrade jdk8 -y
    choco upgrade adobeshockwaveplayer -y
    choco upgrade silverlight -y
    choco upgrade filezilla -y
    choco upgrade dotnet4.5 -y
    choco upgrade adobereader-update -y
    choco upgrade ruby -y
    choco upgrade putty -y
    choco upgrade libreoffice -y
    choco upgrade nodejs -y
    choco upgrade curl -y
    choco upgrade php -y
    choco upgrade atom -y
    choco upgrade github -y
    choco upgrade virtualbox -y
    choco upgrade dropbox -y
    choco upgrade python2 -y
    choco upgrade python -y
    choco upgrade youtube-dl -y
    choco upgrade visualstudiocode -y
    choco upgrade fiddler4 -y
    choco upgrade foxitreader -y
    choco upgrade sourcetree -y
    choco upgrade googledrive -y
    choco upgrade docker -y
}

Function InstallPackagesForSystem()
{
    Set-ExecutionPolicy AllSigned
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
    InstallChocoPackages()
}

New-Alias install_system InstallPackagesForSystem
New-Alias install_choco InstallChocoPackages
New-Alias up_choco UpgradeChocoPackages

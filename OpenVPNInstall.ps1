param(
    [Parameter(Mandatory,Position=0)][Array]$Files
)
$InstallFile = Get-ChildItem OpenVPN*.msi
Start-Process msiexec.exe -ArgumentList "/I $($InstallFile.FullName) /qn /norestart" -Wait -NoNewWindow
if($InstallFile -match "x86"){
    $Destination = "C:\Program Files (x86)\OpenVPN\Config"
}else{
    $Destination = "C:\Program Files\OpenVPN\Config"
}
foreach($File in $Files){
    Move-Item $File -Destination $Destination
}

<#
    .SYNOPSIS
    Will install OpenVPN onto the device and add the configuration files

    .DESCRIPTION
    Installs OpenVPN using the msi and copies all mentionned ovpn files
    to the Program Files config folder, depending on the installed program
    architecture.

    .PARAMETER Files
    Array containing the configuration files you wish to copy.

    .EXAMPLE
    PS> OpenVPNInstall.ps1 Config1.ovpn,Config2.ovpn

    .EXAMPLE
    PS> OpenVPNInstall.ps1 -Files Config1.ovpn

    .LINK
    OpenVPN msi download : https://openvpn.net/community-downloads/

    .LINK
    Get-ChildItem

    .LINK
    Move-Item

    .LINK
    Start-Process

    .LINK
    msiexec.exe
#>
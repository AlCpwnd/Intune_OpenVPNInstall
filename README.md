# OpenVPNInstall
Script allowing the installation of the OpenVPN client and copies the configuration files into the required folders.
This is meant for deployment through Intune and assumes that everyone can user the same OVPN configuration file.

___

## Package Preperation
1. Download [IntuneWinAppUtil.exe](https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/blob/master/IntuneWinAppUtil.exe) from Github and copy it into a folder.
2. In the same folder, create 2 additionnal folders ("Input" & "Output").
3. Download the [OpenVPN msi file](https://openvpn.net/community-downloads/).
4. Copy the following into the "Input" folder :
    - OpenVPNInstall.ps1
    - the OpenVPN msi file
    - your .ovpn configuration file(s)
5. Open a command prompt and navigate to the folder where **IntuneWinAppUtil.exe** is located.
6. Run the following command : `IntuneWinAppUtil.exe -c .\Input\ -s OpenVPNInstall.ps1 -o .\Outut\`

___

## Creating the app

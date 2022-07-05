# OpenVPNInstall
Script allowing the installation of the OpenVPN client and copies the configuration files into the required folders.
This is meant for deployment through Intune and assumes that everyone can user the same OVPN configuration file.

___

## Script
Will search for any file corresponding to "OpenVPN*.msi" and attempt to install it using msiexec.
Once installed, it will copy all ovpn files referenced into `C:\Program Files\OpenVPN\Config` or `C:\Program Files(x86)\OpenVPN\Config` depending on the msi type.

### Parameters

#### File
Will accept and array of OpenVPN (.ovpn) configuration files.
If multiple are to be configured, they can be seperated by a comma :
```PS
PS> OpenVPNInstall.ps1 .\Config1.ovpn,.\Config2.ovpn
```

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
1. Open your browser and go to the [App Management](https://endpoint.microsoft.com/#blade/Microsoft_Intune_DeviceSettings/AppsMenu/allApps) within the Microsoft Endpoing portal.
2. Add a new app using the *Windows app (Win32)* App type.
3. Using *Select app package file* point to the **OpenVPNInstall.intunewin** within your "Output" folder.
4. Complete the necessary information and click Next.
5. Within the *Program* tab complete the following :
    - Install command : `powershell.exe -executionpolicy bypass -file OpenVPNInstall.ps1 ConfigFile1.ovpn`
    - Uninstall command : `msiexec /x "{C57B257B-3D92-4AC0-8FE8-7D6FF81AEF73}" /q`
        - This is the GUID for the *OpenVPN-2.5.7-I602-amd64.msi*. Your GUID may need to be adapted depending on your installer and version. To recover the GUID of installed files you can use the following command : `get-wmiobject Win32_Product | Sort-Object -Property Name |Format-Table IdentifyingNumber, Name, LocalPackage -AutoSize`
6. Within the *Requirements* tab, complete the "Operating system architecture" and "Minimum operating system."
7. Within the *Detection rules* tab do the following :
    - Rules format : Manually configure detection rules
        - Rule type : MSI
        - MSI product code : *Your program GUID*
        - MSI product version check : No
8. No *Dependencies*
9. No *Supesedence*
10. Assign the application to the concerned users
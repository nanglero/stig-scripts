# WinSCP latest patching script
$installerPath = "C:\Users"

#Step 1: verify that the installer exists
if (Test-Path $installerPath) {
    Write-Path "Installer found at $installPath. Proceeding with installation..."
    exit
    } else {
    Write-Host "Installer not found at the specific path. Please check the file location."
    exit
    }

    #step 2: Install WinSCP silently
    Write-Host "Installing WinSCP silently..."
    Start-Process -FilePath $installerPath -ArgumentList "/sAll /rs /msi /norestart" -wait

    #step 3: Verify if installation was successful
    $WinSCPInstalled = Get-WmiObject -Class win32_Product | Where-Object { $_.Name -like "WinSCP"}

    if ($WinSCPInstalled) {
    Write-Host "WinSCP installed successfully." 
    }else {
    Write-Host "WinSCP installation failed." 
    }
    write-Host "Script execution completed"

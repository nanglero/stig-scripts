# Windows 10 - Multiple Patch Installation Script

# Define the directory containing Windows 10 patches
$patchDirectory = "C:\Users\Win10Patches"

# Verify that the patch directory exists
if (-Not (Test-Path $patchDirectory)) {
    Write-Host "Patch directory not found at: $patchDirectory. Please check the file location."
    exit
}

# Get all patch files (assuming they are .msu or .cab files)
$patchFiles = Get-ChildItem -Path $patchDirectory -Filter "*.msu","*.cab"

# Check if there are any patches to install
if ($patchFiles.Count -eq 0) {
    Write-Host "No Windows 10 patch files found in $patchDirectory. Exiting script."
    exit
}

# Loop through and install each patch
foreach ($patch in $patchFiles) {
    $patchPath = $patch.FullName
    Write-Host "Installing Windows 10 patch: $patchPath"

    # Detect file type and install accordingly
    if ($patch.Extension -eq ".msu") {
        # Install Windows 10 patch using Windows Update Standalone Installer (wusa)
        Start-Process -FilePath "wusa.exe" -ArgumentList "`"$patchPath`" /quiet /norestart" -Wait
    }
    elseif ($patch.Extension -eq ".cab") {
        # Install Windows 10 patch using Deployment Image Servicing and Management (DISM)
        Start-Process -FilePath "dism.exe" -ArgumentList "/Online /Add-Package /PackagePath:`"$patchPath`"" -Wait
    }

    # Verify installation status
    if ($?) {
        Write-Host "Patch $patch installed successfully."
    } else {
        Write-Host "Failed to install patch $patch. Check logs for details."
    }
}

# Verify pending updates
$pendingUpdates = Get-WindowsUpdateLog
if ($pendingUpdates) {
    Write-Host "Some updates may require a restart. Please reboot the system if needed."
}

Write-Host "Script execution completed."

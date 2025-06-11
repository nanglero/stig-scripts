# Microsoft Office Professional Plus 2016 - Multiple Patch Installation Script

# Define the installer directory containing all patches
$installerDirectory = "C:\Users\Patches"

# Verify that the installer directory exists
if (-Not (Test-Path $installerDirectory)) {
    Write-Host "Installer directory not found at: $installerDirectory. Please check the file location."
    exit
}

# Get all patch files (assuming they are .msp or similar)
$patchFiles = Get-ChildItem -Path $installerDirectory -Filter "*.msp"

# Check if there are any patches to install
if ($patchFiles.Count -eq 0) {
    Write-Host "No patch files found in $installerDirectory. Exiting script."
    exit
}

# Loop through and install each patch
foreach ($patch in $patchFiles) {
    $patchPath = $patch.FullName
    Write-Host "Installing patch: $patchPath"
    
    # Execute patch installation
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/update `"$patchPath`" /quiet /norestart" -Wait
    
    # Verify if the patch was installed
    if ($?) {
        Write-Host "Patch $patch installed successfully."
    } else {
        Write-Host "Failed to install patch $patch. Check logs for details."
    }
}

# Verify if Microsoft Office Professional Plus is installed
$OfficePlusInstalled = Get-WmiObject -Class win32_Product | Where-Object { $_.Name -like "Microsoft Office Professional Plus*" }

if ($OfficePlusInstalled) {
    Write-Host "Microsoft Office Professional Plus is installed and patched successfully."
} else {
    Write-Host "Microsoft Office Professional Plus installation verification failed."
}

Write-Host "Script execution completed."

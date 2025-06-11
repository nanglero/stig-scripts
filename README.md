Stig-scripts - Latest Patching Script

## Overview

This repository contains a PowerShell script designed to automate the silent installation of McAfee Endpoint Security Threat Prevention using a preinstalled package. The script performs the following steps:

1. Verifies the presence of the installer at a specified path
2. Executes a silent installation
3. Confirms whether the installation was successful

---

## Script Details

### Installer Path

The script assumes the installer is located at 
Update the `$installerPath` variable in the script if your installer is in a different location.

---

### Installation Process

The script performs a **silent installation** using the following command-line options:


These flags ensure that the installation completes quietly without requiring user interaction or restarting the system.

---

### Verification

After the installation completes, the script checks whether **McAfee Endpoint Security Threat Prevention** is listed among installed programs using the `Win32_Product` WMI class.

A confirmation message will indicate whether the installation was successful.

---

## Usage Instructions

1. Clone or download this repository.
2. Place the McAfee installer in the path specified in the script (default is `C:\Users`).
3. Open PowerShell as an Administrator.
4. Run the script:
   ```powershell
   .\Install_McAfee_ThreatPrevention.ps1

## Notes
Make sure you have the correct McAfee installer in .exe or .msi format placed in the defined $installerPath.

The script may require administrative privileges to install McAfee and to access WMI queries.

Modify the $installerPath and installation flags based on your organization’s deployment preferences.



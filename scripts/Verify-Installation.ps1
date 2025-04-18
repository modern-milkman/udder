# Modern Milkman Udder Installation Verification Script for Windows
# Run as: powershell -ExecutionPolicy Bypass -File .\Verify-Installation.ps1

# Colors for output
$Red = 'Red'
$Green = 'Green'
$Yellow = 'Yellow'
$White = 'White'

# Print header
function Print-Header {
    Write-Host "`n===============================================" -ForegroundColor $Green
    Write-Host "== Modern Milkman Udder Installation Verifier ==" -ForegroundColor $Green
    Write-Host "===============================================`n" -ForegroundColor $Green
}

# Check WinGet installation
function Check-WinGet {
    Write-Host "Checking WinGet Configuration:" -ForegroundColor $Green
    
    # Check if WinGet is installed
    try {
        $wingetVersion = winget --version
        Write-Host "✅ WinGet is installed: $wingetVersion"
    } catch {
        Write-Host "❌ WinGet is not installed." -ForegroundColor $Red
        Write-Host "Please install the App Installer from the Microsoft Store." -ForegroundColor $Yellow
        return $false
    }
    
    # Check for Modern Milkman packages
    Write-Host "`nInstalled Packages from Modern Milkman:" -ForegroundColor $Green
    
    $mmPackages = winget list | Select-String "ModernMilkman\."
    if ($mmPackages) {
        $mmPackages | ForEach-Object {
            Write-Host $_
        }
    } else {
        Write-Host "No Modern Milkman packages found."
    }
    
    return $true
}

# Check system information
function Check-System {
    Write-Host "System Information:" -ForegroundColor $Green
    
    $osInfo = Get-ComputerInfo | Select-Object WindowsProductName, OsArchitecture
    Write-Host "Operating System: $($osInfo.WindowsProductName)"
    Write-Host "Architecture: $($osInfo.OsArchitecture)"
    
    Check-WinGet
}

# Main function
function Main {
    Print-Header
    Check-System
    
    Write-Host "`nInstallation verification complete." -ForegroundColor $Green
}

# Run the main function
Main

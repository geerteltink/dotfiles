# powershell -ExecutionPolicy Bypass -File .\w11-tweaks.ps1

Function Log([String] $Message)
{
    If (($Message -ne $null) -and ($Message.Length -gt 0))
    {
        $Time = Get-Date -DisplayHint Time
        Write-Host "[$Time] [LOG] > $Message" -ForegroundColor Cyan
    }
}



Log("Tweaking shutdown")

if(!(Test-Path "HKCU:\Control Panel\Desktop")){ New-Item -Path "HKCU:\Control Panel\Desktop" -Force -ErrorAction SilentlyContinue }
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'WaitToKillAppTimeout' -Value '5000' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'HungAppTimeout' -Value '4000' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'AutoEndTasks' -Value '1' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'LowLevelHooksTimeout' -Value 4096 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Control Panel\Desktop' -Name 'WaitToKillServiceTimeout' -Value 8192 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'verbosestatus' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
# Remove Task View from Taskbar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -type "Dword" -Value "0"
# Remove Chat from Taskbar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -type "Dword" -Value "0"
# Remove Widgets from Taskbar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -type "Dword" -Value "0"
# Enable Windows Dark Theme
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -type "Dword" -Name "SystemUsesLightTheme" -Value "0"
# Enable App Dark Theme
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -type "Dword" -Name "AppsUseLightTheme" -Value "0"



Log("Improve privacy and disable telemetry")

# Disable Tailored Experiences With Diagnostic Data
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -type "Dword" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value "0"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "MaxTelemetryAllowed" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0


Log("Tweak usability")

# Default Explorer view This PC
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -type "Dword" -Name "LaunchTo" -Value "1"
# Show file extensions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -type "Dword" -Name "HideFileExt"  -Value "0"
# Disable Keyboard BS
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value "506"
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Value "122"
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Value "58"



Log("Tweaks are done!")

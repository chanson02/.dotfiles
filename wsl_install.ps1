

# Disable Prompts
Powershell-Cmdlet -Confirm:$false

# Create Symlink for Windows Terminal
$term_path = "C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

if (Test-Path $term_path) {}
else { New-Item $term_path -ItemType Directory }

if (Test-Path $term_path\settings.json) { Remove-Item $term_path\settings.json }
New-Item -ItemType SymbolicLink -Path $term_path\settings.json -Target $PSScriptRoot\windows_terminal_settings.json

workflow EnableHyperVisor {
  # Enable WSL
  dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
  dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

  Restart-Computer -Wait
 
  # For some reason if this isn't here it crashes
  wsl --set-default-version 1

  # Update Linux Kernel
  $dl_link = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
  $path = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
  $installer = "$path/wsl_update_x64.msi"
  $wc = New-Object System.Net.WebClient
  $wc.DownloadFile($dl_link, $installer)

  wsl --install -d Ubuntu # Download / Install Ubuntu
  wsl --set-default-version 2
}
EnableHyperVisor

# Ubuntu #HOME directory: \\wsl$\Ubuntu\home\chanson

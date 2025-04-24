### Install Powershell ###
sudo apt-get update
sudo apt-get install -y powershell

### Providing the access ###
chmod +x startkitlinuxpowershell.ps1
sudo pwsh -Command "& {Start-Process pwsh -ArgumentList '-File ps_files\startkitlinuxpowershell.ps1' -Verb RunAs}"

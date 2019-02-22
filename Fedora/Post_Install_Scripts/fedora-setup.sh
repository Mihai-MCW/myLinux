#!/usr/bin/bash

# Update the system
sudo dnf update -y

# Setup some repositories
# Install Google Chrome repo
sudo dnf install fedora-workstation-repositories -y

# Install Rpmfusion repo
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager --set-enabled google-chrome rpmfusion-nonfree-steam
# Install Atom repo
sudo rpm --import https://packagecloud.io/AtomEditor/atom/gpgkey
sudo sh -c 'echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/yum.repos.d/atom.repo'
# Install Code repo
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# Update cache for package installs
sudo dnf update -y
sudo dnf makecache

# Install all basic packages
sudo dnf install $(cat ~/Documents/Personal/FedoraSetup/mine/fedora.packages) -y

# Install the MSCore fonts
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Install Flathub
sudo dnf install https://dl.flathub.org/repo/flathub.flatpakrepo -y
sudo dnf update -y
sudo dnf makecache

# Install flatpaks
flatpak install skype
flatpak install wps

# Python versioning pyenv install
#curl https://pyenv.run | bash
#curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
#pyenv update
#echo '\n # pynev' >> ~/.bashrc
#echo 'export PATH="/home/mihai-fd/.pyenv/bin:$PATH"' >> ~/.bashrc
#echo 'eval "$(pyenv init -)"' >> ~/.bashrc
#echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

#Custom shell prompt with aliases Source: https://www.linuxquestions.org/questions/linux-general-1/ultimate-prompt-and-bashrc-file-4175518169/
touch ~/.bashrc_aliases
echo '\n # bashrc_aliases config' >> ~/.bashrc
echo 'if [ -f ~/.bashrc_aliases ]; 2>&1; then \n . ~/.bashrc_aliases \n fi \n ' >> ~/.bashrc
cat ./bashrc.aliases >> ~/.bashrc_aliases
cat ./bashrc >> ~/.bashrc

#Gnome Shell Tweaks
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.interface show-battery-percentage true


#Disable Wayland and use Xorg
sudo sed -i '/WaylandEnable/s/^#//g' /etc/gdm/custom.conf

#theme https://github.com/vinceliuice/matcha

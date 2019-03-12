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
# Install the libinput copr for touchpad https://copr.fedorainfracloud.org/coprs/mhoeher/multitouch/
sudo dnf copr enable mhoeher/multitouch

# Update cache for package installs
sudo dnf update -y
sudo dnf makecache

# Install all of my basic packages
sudo dnf install $(cat ./fedora.packages) -y

# Install the MSCore fonts
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
# Install WPS missing fonts
sudo mkdir /usr/share/fonts/wps-fonts
sudo cp -a WPSfonts/. /usr/share/fonts/wps-fonts
sudo chmod 644 /usr/share/fonts/wps-fonts/*
sudo fc-cache -vfs

# Install Flathub
sudo dnf install https://dl.flathub.org/repo/flathub.flatpakrepo -y
sudo dnf update -y
sudo dnf makecache

# Install flatpaks
flatpak install skype
flatpak install wps

# Custom shell prompt with aliases Source: https://www.linuxquestions.org/questions/linux-general-1/ultimate-prompt-and-bashrc-file-4175518169/
cat ./bashrc >> ~/.bashrc
echo -e 'if [ -f ~/.bashrc_aliases ]; then\n. ~/.bashrc_aliases\nfi\n' >> ~/.bashrc
cat ./bashrc.aliases >> ~/.bashrc_aliases
wget https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS -O ~/.LS_COLORS
echo '# Use ls colors' >> ~/.bashrc
echo 'eval $(dircolors -b $HOME/.LS_COLORS)' >> ~/.bashrc
#cat ./LS_COLORS >> ~/.LS_COLORS

# If ~./inputrc doesn't exist yet, first include the original /etc/inputrc so we don't override it
if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' > ~/.inputrc; fi
# Add option to ~/.inputrc to enable case-insensitive tab completion
echo 'set completion-ignore-case On' >> ~/.inputrc


# Gnome Shell Tweaks
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Extensions installation
sudo dnf install $(cat ./gnome.extensions) -y

# Noise cancellationpulse
sudo cp /etc/pulse/default.pa /etc/pulse/default.pa.bak
sudo bash -c 'echo -e "\n# Noise cancellation fix\nload-module module-echo-cancel source_name=noechosource sink_name=noechosink\nset-default-source noechosource\nset-default-sink noechosink" >> /etc/pulse/default.pa'
pulseaudio -k


#Disable Wayland and use Xorg
#sudo sed -i '/WaylandEnable/s/^#//g' /etc/gdm/custom.conf

#theme https://github.com/vinceliuice/matcha

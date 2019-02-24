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

# Python versioning with pyenv install https://github.com/pyenv/pyenv
# don't forget to [pyenv rehash] after installing python versions
# then you can use [pyenv global x.x.x] to set the global path
# you can check what the current global version pyenv set with [pyenv shell]
# you can set a local version per folter with [python local x.x.x]
git clone https://github.com/pyenv/pyenv ~/Software/.pyenv
echo '###########################\n# pyenv python versioning #\n###########################\n'
echo 'export PYENV_ROOT="$HOME/Software/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi\n' >> ~/.bashrc
# Install virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
echo '# pyenv plugin virtualenv' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# Install Netbeans
git clone https://github.com/apache/incubator-netbeans ~/Software/NetBeans
cd ~/Software/NetBeans
# extra steps needed
ant

# Gnome Shell Tweaks
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Extensions installation
sudo dnf install $(cat ./gnome.extensions) -y

# Noice cancellationpulse
sudo cp /etc/pulse/default.pa /etc/pulse/default.pa.bak
sudo bash -c 'echo -e "\n# Noise cancellation fix\nload-module module-echo-cancel source_name=noechosource sink_name=noechosink\nset-default-source noechosource\nset-default-sink noechosink" >> /etc/pulse/default.pa'
pulseaudio -k

#Disable Wayland and use Xorg
#sudo sed -i '/WaylandEnable/s/^#//g' /etc/gdm/custom.conf

#Install Visual Paradigm (GUI install) https://www.visual-paradigm.com/download/community.jsp?platform=linux&arch=64bit
wget https://www.visual-paradigm.com/downloads/vpce/Visual_Paradigm_CE_Linux64.sh -O ~/Downloads/visualParadigm.sh
sh ~/Downloads/visualParadigm.sh

#theme https://github.com/vinceliuice/matcha

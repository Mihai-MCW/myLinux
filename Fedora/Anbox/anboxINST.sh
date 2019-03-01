# Install kernel modules for Anbox
git clone https://github.com/anbox/anbox-modules ~/Software/Anbox/anbox-modules
sudo cp ~/Software/Anbox/anbox-modules/anbox.conf /etc/modules-load.d/
sudo cp ~/Software/Anbox/anbox-modules/99-anbox.rules /lib/udev/rules.d/
sudo cp -rT ~/Software/Anbox/anbox-modules/ashmem /usr/src/anbox-ashmem-1
sudo cp -rT ~/Software/Anbox/anbox-modules/binder /usr/src/anbox-binder-1
sudo dkms install anbox-ashmem/1
sudo dkms install anbox-binder/1

# Install Anbox
sudo dnf install -y snapd
snap install --devmode --beta anbox
sudo dnf install -y lzip unzip squashfs-tools android-tools

# Installing Arch using EFI
## Navigation
[Go to Readme](../README.md)

## Flash
```
dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress && sync
```
## Setting up WiFi
1. List all interfaces
```
iwctl device list
```
2. Scan interface
```
iwctl station wlan0 scan
```
3. List all networks
```
iwctl station wlan0 get-networks
```
4. Connect ti network
```
iwctl station wlan0 connect name-of-station
```
5. Check connection
```
ping -c 3 archlinux.org
```

## Partition
1. Check which hard drive use
```
lsblk -l
```
2. Create new partition table
```
gdisk /dev/sda

Type ‘o’ to create a partition table
Type ‘n’ for a new partition
Enter
Enter
+1G
EF00
```
```
Type ‘n’ to create a new partition
Enter
Enter
Enter
8309
```
```
Check if everything looks right with pressing ‘p’ and press ‘w’.
```

3. Create the encrypted filesystems
```
cryptsetup luksFormat /dev/sda2
cryptsetup open /dev/sda2 cryptlvm

pvcreate /dev/mapper/cryptlvm
vgcreate datafortress /dev/mapper/cryptlvm
```
```
lvcreate -L 20G datafortress -n swap
lvcreate -L 160G datafortress -n root
lvcreate -l +100%FREE datafortress -n home
```
```
mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/mapper/datafortress-root
mkfs.ext4 /dev/mapper/datafortress-home
mkswap /dev/mapper/datafortress-swap
```
```
mount /dev/mapper/datafortress-root /mnt

mkdir /mnt/home
mkdir /mnt/boot

mount /dev/mapper/datafortress-home /mnt/home
mount /dev/sda1 /mnt/boot

swapon /dev/mapper/datafortress-swap
```
## Installation
1. Install Arch Linux
```
pacstrap /mnt base base-devel linux linux-firmware vim iw iwd man dhcpcd netctl
```
2. Generate fstab file
```
genfstab /mnt >> /mnt/etc/fstab
```
3. Change root of system
```
arch-chroot /mnt
```
4. Sel locale
```
vim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```
5. Set yhe time zone
```
ln -sf /usr/share/zoneinfo/
ln -sf /usr/share/zoneinfo/Europe/Kiev /etc/localtime
```
6. Set local time
```
hwclock --systohc --utc
Check: date
```
7. Set hostname
```
echo lnv-700 > /etc/hostname
vim /etc/hosts
ADD: 127.0.1.1 localhost.localdomain lnv-700
```
8. Set root password
```
passwd
```
9. BOOT
```
pacman -Syu
pacman -S wpa_supplicant dhclient lvm2 dialog
```
```
vim /etc/mkinitcpio.conf
EDIT: HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems resume fsck)

mkinitcpio -p linux
bootctl install

lsblk -l
blkid

vim /boot/loader/entries/arch.conf Add the following:

title ArchLinux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options cryptdevice=UUID=<YOUR UUID encryptdd  disk>:lvm:allow-discards resume=/dev/mapper/datafortress-swap root=/dev/mapper/datafortress-root rw quiet
```
10. Reboot
```
exit
umount -R /mnt
reboot
```

## Add user
```
useradd -m -g users -G wheel -s /bin/bash mick
passwd mick

EDITOR=vim visudo
UNCOMMENT: # %wheel ALL=(ALL) ALL
```

## Check WiFi
```
dhcpcd
iwctl
```

## Install X and audio
pacman -S pulseaudio pulseaudio-alsa xorg xorg-xinit xorg-server

## Fonts
дослідити fonts<br/>
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts

## i3
```
pacman -S i3-gaps i3status rxvt-unicode dmenu
echo 'exec i3' >> ~/.xinitrc

startx
```

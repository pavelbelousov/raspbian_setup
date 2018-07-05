#!/bin/sh

uname_out="$(uname -s)"

write_wifi_conf() {
  echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=$3

network={
    ssid=\"$1\"
    psk=\"$2\"
    key_mgmt=WPA-PSK
}" > /Volumes/boot/wpa_supplicant.conf
}

write_ssh() {
  echo > /Volumes/boot/ssh
}

setup_mac() {
  if hash pv 2>/dev/null; then
    echo "Unmounting SD card..."
    diskutil unmountDisk /dev/$1
    echo "Writing image to SD card..."

    FILESIZE=$(stat -f%z "$2")

    sudo dd if=$2 conv=sync | pv -s $FILESIZE | sudo dd of=/dev/r$1 bs=1m
    echo "Mounting 'boot' partition..."
    diskutil mount $1s1
    echo "Writing Wi-Fi settings..."
    write_wifi_conf $3 $4 $5
    echo "Enabling SSH..."
    write_ssh
    echo "Ejecting SD card..."
    #diskutil eject /dev/r$1
    echo "Done!"
  else
    echo "Install pv first"
  fi
}

os_unsupported() {
  echo "OS is unsupported"
}

case "${uname_out}" in
  Darwin*)
    machine=Mac
    setup_mac $1 $2 $WIFI_HOME_SSID $WIFI_HOME_PASS $COUNTRY_CODE
    ;;
  *)
    machine="UNKNOWN:${unameOut}"
    os_unsupported
esac

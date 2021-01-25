#font console-mode

showconsolefont

## temporay set font /usr/share/kbd/consolefonts/
setfont lat2-16 -m 8859-2
setfont -h8 /usr/share/kbd/consolefonts/drdos8x8.psfu.gz
setfont -h8 /usr/share/kbd/consolefonts/ter-112n.psf.gz

## permanent changes
in file /etc/vconsole.conf

# mhwd
sudo pacman -R linux-latest linux-latest-nvidia-440xx linux54-rt-nvidia-440xx linux58-nvidia-440xx
sudo mhwd -r pci video-nvidia-440xx
sudo mhwd -i pci video-nvidia-455xx

## rebuild drivers from source
cd nvidia-4YYxx-utils && makepkg -si
cd ../lib32-nvidia-4YYxx-utils && makepkg -si
cd ../nvidia-4YYxx && makepkg -sif

## install driver
mhwd -r pci <video-nvidia>

## remove driver
mhwd -i pci <video-nvidia>

## create nvidia config file
mhwd-gpu --setmod nvidia --setxorg /etc/X11/mhwd.d/nvidia.conf

# network

## list networks and signal strengh
nmcli -f in-use,ssid,bssid,signal,bars  dev wifi

## connect to bssid
nmcli d wifi connect XX:XX:XX:XX:XX

# pacman remove unused packages
pacman -Qtdq | sudo pacman -Rns -

## enable printer
sudo systemctl start --now cups.service && sudo systemctl start --now cups.socket && sudo systemctl start --now cups.path

  - sefsef
    - sefse
    - sefef
      --sefsef
        -sefse

        -sefsef
 - sefesf

## TODO


xrandr --output DISPLAY --auto

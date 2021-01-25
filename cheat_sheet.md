#mhwd

## install driver
mhwd -r pci <video-nvidia>

## remove driver
mhwd -i pci <video-nvidia>


## create nvidia config file
mhwd-gpu --setmod nvidia --setxorg /etc/X11/mhwd.d/nvidia.conf


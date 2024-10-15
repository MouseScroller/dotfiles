
noblacklist /sys/module
whitelist /sys/module/nvidia*
read-only /sys/module/nvidia*

ignore private-dev
ignore noroot


include allow-commen.inc

nowhitelist ${HOME}/.killingfloor
nowhitelist ${HOME}/.klei
nowhitelist ${HOME}/.paradoxinteractive
nowhitelist ${HOME}/.prey
nowhitelist ${HOME}/.mbwarband

ignore whitelist ${HOME}/.killingfloor
ignore whitelist ${HOME}/.klei
ignore whitelist ${HOME}/.paradoxinteractive
ignore whitelist ${HOME}/.prey
ignore whitelist ${HOME}/.mbwarband

ignore mkdir ${HOME}/.killingfloor
ignore mkdir ${HOME}/.klei
ignore mkdir ${HOME}/.paradoxinteractive
ignore mkdir ${HOME}/.prey
ignore mkdir ${HOME}/.mbwarband

ignore noblacklist ${HOME}/.killingfloor
ignore noblacklist ${HOME}/.klei
ignore noblacklist ${HOME}/.paradoxinteractive
ignore noblacklist ${HOME}/.prey
ignore noblacklist ${HOME}/.mbwarband

blacklist ${HOME}/.killingfloor
blacklist ${HOME}/.klei
blacklist ${HOME}/.paradoxinteractive
blacklist ${HOME}/.prey
blacklist ${HOME}/.mbwarband

include ${CFG}/steam-runtime.profile

blacklist ${HOME}/.killingfloor
blacklist ${HOME}/.klei
blacklist ${HOME}/.paradoxinteractive
blacklist ${HOME}/.prey
blacklist ${HOME}/.mbwarband

noblacklist /mnt/save/SteamLibrary/
read-write /mnt/save/SteamLibrary/

noblacklist ${HOME}/.local/share/Steam
read-write ${HOME}/.local/share/Steam

noblacklist /sys/module
whitelist /sys/module/nvidia*
read-only /sys/module/nvidia*

ignore private-dev
ignore noroot



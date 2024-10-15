
include allow-commen.inc
include editor.inc

ignore net 
ignore x11

seccomp !@process 	#allow group


noblacklist ${PATH}/as

include ${CFG}/nvim.profile
keep-dev-shm

include editor.inc

netfilter
protocol unix,inet,inet6,netlink
ipc-namespace

seccomp !@process 	#allow group

apparmor	# if you have AppArmor running, try this one!

caps.drop all
nonewprivs
noroot


no3d	# disable 3D acceleration
nodvd	# disable DVD and CD devices
notv	# disable DVB TV devices
nou2f	# disable U2F devices
novideo	# disable video capture devices
noinput	# disable input devices

#private-bin ld,as,gcc,mv,gzip,tar,curl,mktemp,mkdir,id,env,rm,xsel,bash,git,nvim,stylua,*-language-server,sh,rust-analyzer,rm

#private-cache	# run with an empty ~/.cache directory
private-dev
#private-etc ssl,gitconfig,userdb,xdg,login.defs,



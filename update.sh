CP="cp -u"

$CP ~/cheat_sheet.md .
$CP ~/.bash_profile .
$CP ~/.bashrc .
$CP ~/.rustfmt.toml . #?

#gpg -c ~/pass.kdbx
#mv ~/pass.kdbx.gpg .


mkdir -p .config
$CP -r ~/.config/nvim ./.config/.
$CP -r ~/.config/htop ./.config/.
$CP -r ~/.config/bash ./.config/.
$CP -r ~/.config/firejail ./.config/.

#mkdir -p .config/xfce4/terminal .config/xfce4/xfconf/xfce-perchannel-xml/

#$CP -r ~/.config/xfce4/terminal/terminalrc ./.config/xfce4/terminal/.
#$CP -r ~/.config/xfce4/xfconf/xfce-perchannel-xml/* ./.config/xfce4/xfconf/xfce-perchannel-xml/.

rm -rf ./.config/nvim/.plugins/lazy/
rm -rf ./.config/bash/.bash_history
rm -rf ./.config/bash/.bash_history.bak

rg -uuu "$HOME"

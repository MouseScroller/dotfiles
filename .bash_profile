
if [ -n "$BASH" ]
then
	if [ -f ~/.bashrc ]
	then
		. ~/.bashrc
	fi
	if [ -f ~/.system_bashrc ]
	then
		. ~/.system_bashrc
	fi
fi

#!/bin/sh

bash_profile=$HOME/.bash_profile
if [ ! -f $bash_profile ]; then
	touch $bash_profile
	echo "[I] Created .bash_profile file. Please make sure that it is loaded in your .bashrc script"
fi

comletion_file='~/.bash/git-completion.sh'

comment='# git completion script'
command='source '$comletion_file 
statement='if [ -f '"$comletion_file"' ]; then'
endStatement='fi'

if ! grep -q "$command" "$bash_profile"
then
	echo "" >> $bash_profile
	echo $comment >> $bash_profile
	echo $statement >> $bash_profile
	echo '	'$command >> $bash_profile
	echo $endStatement >> $bash_profile
	echo "[S] (git) Done. Please reload bash. Command: source ~/.bashrc"
else
	echo "[S] (git) .bash_profile already updated"
fi

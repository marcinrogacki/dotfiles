#!/bin/sh

current_dir=pwd
install_dir=$HOME/share/ctags

case "${1:-''}" in
	 'download')
	 	cd ~
		git submodule update
		cd -
	 	;;
	 'configure')
		cd $install_dir/src
		./configure --prefix=$install_dir
		cd - 
	 	;;
	 'make')
	 	make -C "$install_dir/src"
    	;;
     'install')
	 	make -C "$install_dir/src" install
       	;;
     'alias')
		home_relative_path=${install_dir#$HOME}/bin/ctags
		if [ ! -f $HOME$home_relative_path ]; then
			echo "Ctags is not installed"
			return
		fi

		bash_aliases=$HOME/.bash_aliases
		if [ ! -f $bash_aliases ]; then
			touch $bash_aliases
		fi
		
		bin_path='$HOME'$home_relative_path
	 	comment='# ctags software installed for this user'
		alias='alias ctags="'$bin_path'"' 
		
		if ! grep -q "$alias" "$bash_aliases"
		then
			echo "" >> $bash_aliases
			echo $comment >> $bash_aliases
			echo $alias >> $bash_aliases
			echo 'Done. Please reload bash aliases. Command:'
			echo 'source ~/.bash_aliases'
		fi
		;;
     'help'|*)
       echo "Usage: $0 <PARAM>"
       echo 
       echo "download		download the sources"
       echo "configure		./configure --prefix=~/share/ctags"
       echo "make			do make command"	
       echo "install 		do make install command"
       echo "alias			add alias 'ctags-exuberant' .bash_aliases"
       echo 
	   echo "Run respectively:"
	   echo "sh install.sh download"
	   echo "sh install.sh configure"
	   echo "sh install.sh make"
	   echo "sh install.sh install"
	   echo "sh install.sh alias"
       exit 1
       ;;
esac

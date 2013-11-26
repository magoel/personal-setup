#!/bin/bash -f 

script_dir=$(dirname $0);
PROGNAME=$(basename $0);

if [ -d $PWD/$script_dir ]; then 
# relative path
script_dir=$(echo -n $PWD/${script_dir});
fi


function clean_up {
	exit $1;
}

function error_exit {
	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	clean_up 1
}

backup_dir="/home/$USER/dotfiles.bak.$$.$RANDOM";
function create_backup_dir {
	echo -n "Suggest a dotfiles-dir [$HOME/dotfiles.bak] > "
	read backup_dir;
	if [ ! -n "$backup_dir" ]; then 
		backup_dir="/home/$USER/dotfiles.bak"
	else
		parent_dir=$(dirname $backup_dir);
		if [ ! -d $parent_dir ]; then 
			error_exit "$parent_dir doesn't exist"
		fi
		pushd $(dirname $backup_dir) 
		backup_dir=$PWD/$(basename $backup_dir);
		popd;
	fi
	mkdir -p $backup_dir;
}


dotfiles_dir="/home/$USER/dotfiles"
function create_dotfiles_dir {
	echo -n "Suggest a dotfiles-dir [$HOME/dotfiles] > "
	read dotfiles_dir;
	if [ ! -n "$dotfiles_dir" ]; then 
		dotfiles_dir="/home/$USER/dotfiles"
	else
		parent_dir=$(dirname $dotfiles_dir);
		if [ ! -d $parent_dir ]; then 
			error_exit "$parent_dir doesn't exist"
		fi
		pushd $(dirname $dotfiles_dir) 
		dotfiles_dir=$PWD/$(basename $dotfiles_dir);
		popd;
	fi
	mkdir -p $dotfiles_dir
}



function backup_vim {
	pushd /home/$USER;
	mv  $(readlink -fn .vimrc) $1/.
	mv  $(readlink -fn .vim) $1/.
	popd
}

function backup_emacs {
	pushd /home/$USER;
	mv $(readlink -fn .emacs.d) $1/.
	popd
}

function backup_bash {
	pushd /home/$USER;
	mv $(readlink -fn .bashrc) $1/.
	mv $(readlink -fn .bash_profile) $1/. 
	mv $(readlink -fn .bashrc_custom) $1/. 
	popd
}

function backup_screen {
	pushd /home/$USER;
	mv  $(readlink -fn .screenrc) $1/.
	popd
}

function backup_cshrc {
	pushd /home/$USER;
	mv $(readlink -fn .cshrc) $1/. 
	mv $(readlink -fn .aliases) $1/.
	popd
}

function backup_gdb {
	pushd /home/$USER;
	mv $(readlink -fn .gdbinit) $1/.
	popd
}

function confirm_backup {
	clear
	echo -n "Shall I backup preference for $1? [y/n] : ";
	read confirm ;
	case $confirm in 
		y | Y ) $2 $backup_dir ;;
		n | N ) echo "Skipping backup for $1" ;;
		* ) confirm_backup $1 $2;;
	esac
}

function configure_vim {
	pushd /home/$USER;
	cp -rf $script_dir/dotfiles/.vimrc $1/.
	cp -rf $script_dir/dotfiles/.vim $1/.
	ln -s $1/.vimrc .  
	ln -s $1/.vim . 
	popd
}

function configure_emacs {
	pushd /home/$USER;
	cp -rf $script_dir/dotfiles/.emacs.d $1/.
	ln -s $1/.emacs.d . 
	popd
}

function configure_bash {
	pushd /home/$USER;
	cp -rf $script_dir/dotfiles/.bashrc $1/.
	cp -rf $script_dir/dotfiles/.bash_profile $1/.
	cp -rf $script_dir/dotfiles/.bashrc_custom $1/.
	ln -s $1/.bashrc .
	ln -s $1/.bash_profile . 
	ln -s $1/.bashrc_custom . 
	popd
}

function configure_screen {
	pushd /home/$USER;
	cp -rf $script_dir/dotfiles/.screenrc $1/.
	ln -s  $1/.screenrc .
	popd
}

function configure_cshrc {
	pushd /home/$USER;
	cp -rf $script_dir/dotfiles/.cshrc $1/.
	cp -rf $script_dir/dotfiles/.aliases $1/.
	ln -s $1/.cshrc . 
	ln -s $1/.aliases .
	popd
}

function configure_gdb {
	pushd /home/$USER;
	cp -rf $script_dir/dotfiles/.gdbinit $1/.
	ln -s $1/.gdbinit 
	popd
}



function confirm_configuration {
	clear
	echo -n "Shall I configure $1? [y/n] : ";
	read confirm ;
	case $confirm in 
		y | Y ) $2 $dotfiles_dir ;;
		n | N ) echo "Skipping configuration for $1" ;;
		* ) confirm_configuration $1 $2;;
	esac
}

trap clean_up SIGHUP SIGINT SIGTERM;
create_backup_dir
create_dotfiles_dir

confirm_backup vim backup_vim
confirm_configuration vim configure_vim

confirm_backup bash backup_bash
confirm_configuration bash configure_bash

confirm_backup gdb backup_gdb
confirm_configuration gdb configure_gdb

confirm_backup screen backup_screen
confirm_configuration screen configure_screen

confirm_backup emacs backup_emacs
confirm_configuration emacs configure_emacs

confirm_backup csh backup_cshrc
confirm_configuration csh configure_cshrc

echo "Backup is created in $backup_dir"
echo "Dotfiles are created in $dotfiles_dir"
clean_up 0

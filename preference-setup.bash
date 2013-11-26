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
	echo "Creating backup dir" 
	count=0;
	while  [ -d $backup_dir ] && [ $count -lt 10 ] ; do 
		backup_dir="/home/$USER/dotfiles.bak.$$.$RANDOM";
		count=$((count+1));
	done
	if [ $count -ge 10 ]; then 
		error_exit <<- _EMSG_
		Failed to find a suitable backup-dir \n
		Try cleaning up existing directory like ~/dotfiles.bak.[0-9]+.[0-9]+"\n
		And then run script again\n
		_EMSG_
	fi
	mkdir -p $backup_dir;
}


dotfiles_dir="/home/$USER/dotfiles.$$.$RANDOM"
function create_dotfiles_dir {
	echo "Creating dotfiles dir"
	count=0;
	while [ -d dotfiles_dir ]  && [ $count -lt 10 ] ; do
		dotfiles_dir="/home/$USER/dotfiles.$$.$RANDOM"
		count=$((count+1));
	done
	if [ $count -ge 10 ]; then 
		error_exit <<- _EMSG_
		Failed to find a suitable dotfiles-dir\n
		Try cleaning up existing directory like ~/dotfiles.[0-9]+.[0-9]+\n
		And then run script again\n
		_EMSG_
	fi
	cp -rf $script_dir/dotfiles $dotfiles_dir
}



function backup_vim {
	pushd /home/$USER;
	mv  .vimrc $1/.
	mv  .vim $1/.
	popd
}

function backup_emacs {
	pushd /home/$USER;
	mv .emacs.d $1/.
	popd
}

function backup_bash {
	pushd /home/$USER;
	mv .bashrc $1/.
	mv .bash_profile $1/. 
	mv .bashrc_custom $1/. 
	popd
}

function backup_screen {
	pushd /home/$USER;
	mv  .screenrc $1/.
	popd
}

function backup_cshrc {
	pushd /home/$USER;
	mv .cshrc $1/. 
	mv .aliases $1/.
	popd
}

function backup_gdb {
	pushd /home/$USER;
	mv .gdbinit $1/.
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
	ln -s $1/.vimrc .  
	ln -s $1/.vim . 
	popd
}

function configure_emacs {
	pushd /home/$USER;
	ln -s $1/.emacs.d . 
	popd
}

function configure_bash {
	pushd /home/$USER;
	ln -s $1/.bashrc .
	ln -s $1/.bash_profile . 
	ln -s $1/.bashrc_custom . 
	popd
}

function configure_screen {
	pushd /home/$USER;
	ln -s  $1/.screenrc .
	popd
}

function configure_cshrc {
	pushd /home/$USER;
	ln -s $1/.cshrc . 
	ln -s $1/.aliases .
	popd
}

function configure_gdb {
	pushd /home/$USER;
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

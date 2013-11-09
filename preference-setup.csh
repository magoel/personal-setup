#!/bin/csh -f 

#create backup of old-preference files
set script_dir = `dirname $argv[0]`

pushd $HOME
mkdir -p dotfiles.bak
mv .cshrc* dotfiles.bak;
mv .screenrc dotfiles.bak;
mv .gdbinit dotfiles.bak;
mv .vimrc dotfiles.bak;
mv .gvimrc dotfiles.bak;
mv .vim* dotfiles.bak;
mv .aliases dotfiles.bak;



#install preferences
ln -sb $script_dir/dotfiles/.screenrc .
ln -sb $script_dir/dotfiles/.gdbinit . 
ln -sb $script_dir/dotfiles/.vimrc  .
ln -sb $script_dir/dotfiles/.gvimrc .
ln -sb $script_dir/dotfiles/.cshrc . 
ln -sf $script_dir/dotfiles/.aliases .
popd

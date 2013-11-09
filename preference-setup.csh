#!/bin/csh -f 

set script_dir = `dirname $0`
set script_dir=`echo $PWD/$script_dir`

#create backup of old-preference files
\rm -rf ~/dotfiles.bak
mv ~/dotfiles ~/dotfiles.bak
mv ~/.vim ~/dotfiles.bak



#start
cp -rf $script_dir/dotfiles ~/.


#install vim-pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
touch ~/dotfiles/.vimrc
echo 'execute pathogen#infect()' >> ~/dotfiles/.vimrc


#install vim-sensible
pushd ~/.vim/bundle
git clone git://github.com/tpope/vim-sensible.git
popd
#configure vim-sensible to be loaded before .vimrc , so that one can over-ride in .vimrc
touch ~/dotfiles/.vimrc
echo 'runtime! plugin/sensible.vim' >> ~/dotfiles/.vimrc
echo '"Recommendation : Write any prefernce setting below this line only' >> ~/dotfiles/.vimrc
#intsall vim-slime
pushd ~/.vim/bundle
git clone git://github.com/jpalardy/vim-slime.git
popd
#configure slime for screen
touch ~/dotfiles/.vimrc
echo 'let g:slime_target = "screen"' >> ~/dotfiles/.vimrc
#append remaining settings
cat $script_dir/dotfiles/.vimrc-append >> ~/dotfiles/.vimrc

pushd $HOME



#install preferences
ln -sb ~/dotfiles/.screenrc .
ln -sb ~/dotfiles/.gdbinit . 
ln -sb ~/dotfiles/.vimrc  .
ln -sb ~/dotfiles/.gvimrc .
ln -sb ~/dotfiles/.cshrc . 
ln -sf ~/dotfiles/.aliases .
popd

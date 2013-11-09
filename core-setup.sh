#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
sudo apt-get install -y curl



#install vim-pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
touch ~/.vimrc
echo 'execute pathogen#infect()' >> ~/.vimrc


#install vim-sensible
pushd ~/.vim/bundle
git clone git://github.com/tpope/vim-sensible.git
popd
#configure vim-sensible to be loaded before .vimrc , so that one can over-ride in .vimrc
touch ~/.vimrc
echo 'runtime! plugin/sensible.vim' >> ~/.vimrc
echo '#Recommendation : Write any prefernce setting below this line only' >> ~/.vimrc
#intsall vim-slime
pushd ~/.vim/bundle
git clone git://github.com/jpalardy/vim-slime.git
popd
#configure slime for screen
touch ~/.vimrc
echo 'let g:slime_target = "screen"' >> ~/.vimrc





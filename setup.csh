#!/bin/csh -f 

set script_dir = `dirname $0`
pushd $script_dir;
source core-setup.sh
source preference-setup.csh
popd

# intsall utility scripts
mkdir -p $HOME/Trash
mkdir -p $HOME/Scripts





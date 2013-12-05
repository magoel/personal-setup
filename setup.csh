#!/bin/csh -f 

set script_dir = `dirname $0`
#set script_dir=`echo $PWD/$script_dir`
pushd $script_dir;
source core-setup.sh
source preference-setup.csh
popd


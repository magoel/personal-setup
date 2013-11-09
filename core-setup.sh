#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
export script_dir=`dirname $0`
export script_dir=`echo $PWD/$script_dir`
sudo apt-get install -y git
sudo apt-get install -y curl








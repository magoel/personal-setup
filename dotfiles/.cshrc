#!/bin/csh -f
#echo " ######### .cshrc(Linux) ######### "
#
# "noclobber" prevents accidental replacement of files by use of ">"
# redirection. ">!" will replace a file even with noclobber set.
set noclobber
#
# filename completion (shelltool only), history limit
set filec
set ignoreeof
set nobeep
set history=40
set savehist=20
#set deftty=wy50
#
# umask value restricts permissions on created directories.  027 says turn
# off write permission for group members, and all permissions for others.
# umask value is XORed with mode 777
umask 022
#
# the foll line will prevent core file to be generated
limit coredumpsize 0

#
# set up search path
#
set path = ( /bin /usr/bin . )
set host = `hostname`
#alias cp        'cp -i'
#alias mv        'mv -i'
#alias rm        'rm -i'

#          skip remaining setup if not an interactive shell
if ($?USER == 0 || $?prompt == 0) exit
set prompt = "`whoami`@`hostname`[\!] "
#alias setprompt 'echo -n '

#alias cd        'cd \!* ; setprompt'
#alias chdir     'chdir \!* ; setprompt'

#######   ****SETENV***   ########
setenv EDITOR vim
setenv SHELL            '/bin/tcsh'
setenv GCC_LD_LIBRARY_PATH "/usr/local/lib:"
setenv LD_LIBRARY_PATH /usr/lib:/usr/local/lib
set path = (/usr/sbin /bin /usr/bin /usr/local/bin /usr/X11R6/bin . /sbin)



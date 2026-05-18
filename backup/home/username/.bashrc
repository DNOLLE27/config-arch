#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

PATH=$PATH:~/Documents/scripts:~/soft-local/path:~/composer:~/.config/symfony-cli/bin:~/doxygen/bin

alias av-scan=av-scan.sh
alias launch_wireshark=launch_wireshark.sh
alias launch_codeblocks=launch_codeblocks.sh
alias composer=composer.phar
alias plantuml=plantuml.sh
alias launch_firefox=launch_firefox.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

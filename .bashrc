SSH_ENV=$HOME/.ssh/environment
   
# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}
   
if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Alias

alias ls='ls --color'

# Alias para windoseros
alias dir='ls -lh'
alias ddir='ls'
alias md='mkdir'
alias del='rm'
alias cls='clear'

# Path

PATH=${PATH}:/c/Archivos\ de\ programa/Vim/vim74:/C/Archivos\ de\ programa/KDE/bin:
PATH=${PATH}:/c/Archivos\ de\ programa/KDiff3:


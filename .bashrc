PATH=${PATH}:/cygdrive/c/Program\ Files\ \(x86\)/gnuplot/bin
PATH=${PATH}:~/bin
export PATH

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return



# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #


# Setting VESTA
PATH=${PATH}:~/bin/VESTA-win64
export PATH
alias ves='VESTA.exe'


#export PATH=$PATH:$HOME/.pyenv/versions/3.6.2/envs/venv3.6/bin
export PATH=/Users/janmeppe/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages
export PATH="$PATH:/Users/janmeppe/development/flutter/bin"
# Add custom binds to bash.profile! 

# export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
# export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh' 
alias "l=ls -lah"

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
killall Finder /System/Library/CoreServices/Finder.app'

alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO;
killall Finder /System/Library/CoreServices/Finder.app'

# Edit ~/.profile if you get Locale error 
alias rec='source ~/.profile && asciinema rec'

# added by Anaconda 2.2.0 installer
export PATH="/Users/janmeppe/anaconda/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Lazy git, because ... were lazy
# example: $ lazygit "My commit msg"
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
# reload with . .bash_profile

# 6/6/16 fix for RWeka Java 
#export  JAVA_HOME=`/usr/libexec/java_home -v 1.7`
export JAVA_HOME=$(/usr/libexec/java_home)

alias rec='LC_ALL=en_IN.UTF-8 asciinema rec'
alias oxl='/Applications/OxMetrics7/ox/bin/oxl'

export MATLAB_EXECUTABLE=/Applications/MATLAB_R2014b.app/bin/matlab
# added by Anaconda3 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/janmeppe/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/janmeppe/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/janmeppe/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/janmeppe/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

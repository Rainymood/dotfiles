# showFiles / hideFiles alias
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# edit zshrc/vimrc, etc.
alias zshrc='vim ~/dotfiles/zshrc'
alias vimrc='vim ~/dotfiles/vimrc'

# ls alias
alias ls='ls -GFh' 
alias "l=ls -lah"

# change prompt "~/Projects/dotfiles/zshfunctions % "
PROMPT='%~ %# '

# plugins
plugins=(zsh-completions)

autoload -U compinit && compinit

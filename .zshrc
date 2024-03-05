case "$OSTYPE" in
  solaris*) OS="SOLARIS" ;;
  darwin*)  OS="OSX" ;;
  linux*)   OS="LINUX" ;;
  bsd*)     OS="BSD" ;;
  msys*)    OS="WINDOWS" ;;
  *)        OS="unknown: $OSTYPE" ;;
esac

function exists() {
  command -v "$1" >/dev/null 2>&1
}
function upvim(){
  cd ~/
  if [[ $OS == 'OSX' ]]; then
    echo 'nvim:osx'
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
    tar -xf nvim-macos.tar.gz
    # mv ./nvim-osx64/bin/nvim /usr/local/bin/
  fi
  if [[ $OS == 'linux' ]]; then
    echo 'nvim:linux'
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage

  fi
}
function upalacritty(){
  cd ~/alacritty
  git pull origin HEAD
  rustup update stable
  cargo build --release
  make app
  if [[ $OS == 'OSX' ]]; then
    cp -r target/release/osx/Alacritty.app /Applications/Alacritty.app
    cd -
  fi
  if [[ $OS == 'linux' ]]; then
    cp -r target/release/alacritty /usr/local/bin/
    cd -
  fi
}
function upprezto(){
  cd $ZPREZTODIR
  git pull
  git submodule update --init --recursive
  cd -
}

function nfy() {
  if [[ $OS == 'OSX' ]]; then
    osascript -e 'display notification "'$1'" with title "'$2'" subtitle "'$3'" sound name "Submarine"'
  fi
}

# RUST verification
if ! exists rustup; then
  # install rust
  if [[ $OS == 'OSX' ]]; then
    echo 'rustup:osx'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
fi

if [[ $OS == 'OSX' ]]; then
  defaults write -g InitialKeyRepeat -int 10
fi
# ALIASES
alias c='git --git-dir=$HOME/.dot/ --work-tree=$HOME'
alias dd="cd ~/Desktop/"
alias 7b="cd ~/7blazes/git/"
alias zshrc="nvim ~/.zshrc"
alias cls="clear"
alias lg="lazygit"


alias ni='nvim'
alias nv='nvim'
alias nvi='nvim'
alias im='nvim'
alias vim='nvim'
alias v='nvim'
alias nvim='~/nvim-macos/bin/nvim'

alias stat='gotop -c monokai'
alias irc= 'weechat';
# List all files colorized in long format
alias l="eza -l --icons"
# List all files colorized in long format, including dot files
alias la="eza -la  --icons"
# List only directories
alias ls='eza --icons'
alias lsd='eza -l | grep "^d" --icons'
# Always use color output for `ls`
alias top='bpytop' #brew install bpytop
alias cat='bat' #brew install bat
alias chrom="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --new-window --app=https://youtube.com"

# alias sharemux="gotty tmux new-session -A -s jojolitos"
# brew install yudai/gotty/gotty

alias share="tty-share --public" # brew install tty-share

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
# Flush Directory Service cache
alias flush="dscacheutil -flushcache"
# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Shortcuts
# Empty the Trash on all mounted volumes and the main HDD
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash"
if [[ $OS == 'OSX' ]]; then
  # Hide/show all desktop icons (useful when presenting)
  alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
  alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
  showHidden() {
    defaults write com.apple.Finder AppleShowAllFiles true
    killall Finder
  }
  hideHidden() {
    defaults write com.apple.Finder AppleShowAllFiles false
    killall Finder
  }
fi
# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "$method"="lwp-request -m '$method'"
done
alias mux='tmuxinator'
alias server='http-server -p 4000 -i true'

alias gitDeleteLocalBranches='git branch | grep -v "master" | xargs git branch -D'
alias gitReset='git checkout -- .'
alias gitUndoMerge='git reset --merge'

if [[ $OS == 'OSX' ]]; then
  alias notify='osascript -e "display notification \"Process finished\" with title \"Done!\""'
fi

 # git functions
gflowBeforeFinish(){
  curBranch=$(git rev-parse --abbrev-ref HEAD)
  echo "Fetching ${1}..."
  git checkout $1 &>/dev/null
  git pull &>/dev/null
  echo "Switching back to ${curBranch}..."
  git checkout $curBranch &>/dev/null
  echo "Merging ${1} into ${curBranch}..."
  git merge $1
}

alias gmm="gflowBeforeFinish master"
alias gmd="gflowBeforeFinish develop"
alias g="git"
alias gl="git pull"
alias gt="git log --graph --pretty=oneline --abbrev-commit"
alias gb="git branch"
alias gup="git remote update origin --prune"
alias gf="git-flow"
alias gco="git checkout"
alias gcd="git checkout develop"
alias gcm="git checkout master"
alias gc='git commit -m'
alias undopush="git push -f origin HEAD^:master" # Undo a `git push`
alias undocommit="git reset --soft HEAD~1"
alias gs='git status' # Git Status
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`' # git root


# Prezto
[[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]] && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# ZPlug
[[ -f ~/.zplug/init.zsh ]] && source ~/.zplug/init.zsh

zplug "bobthecow/git-flow-completion"
zplug "Valiev/almostontop"
zplug "djui/alias-tips"
zplug "arzzen/calc.plugin.zsh"
zplug "akoenig/npm-run.plugin.zsh"

zplug load
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

# # fix perl error on ack.vim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LANG="en_US"

export BAT_THEME="Monokai Extended"

export EDITOR="nvim" # Make vim the default editor
export MANPAGER="less -X" # Don’t clear the screen after quitting a manual page
export HISTSIZE=32768  # Larger bash history (allow 32³ entries; default is 500)
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%F %T ' # saved for later analysis
export HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help" # Make some commands not show up in history

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$HOME:$PATH
export PATH=$HOME/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/.local/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PNPM_HOME="/Users/jojo/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"


if [ -d "/usr/local/opt/ruby/bin" ]; then
  export PATH=/usr/local/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi
# pnpm
export PNPM_HOME="/Users/jojo/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$GOPATH/bin":$PATH
#pnpm end

export PATH="/opt/homebrew/lib/python3.11/site-packages:$PATH"
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
export OPENAI_API_KEY="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"
# bun completions
[ -s "/Users/jojo/.bun/_bun" ] && source "/Users/jojo/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

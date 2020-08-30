# Path to your oh-my-zsh installation.
export ZSH="/Users/ashorshe/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# aliases
alias k="kubectl"
alias kpods="k get pods"
alias kdeps="k get deployments"
alias kserv="k get services"
alias knodes="k get nodes"
alias krc="k get rc"
alias kname="k get namespaces"

#weather
alias weather='curl -4 http://wttr.in/Raleigh'
alias moon='curl -4 http://wttr.in/Moon'


# editing and reloading bash profile
alias ezsh='vim ~/.zshrc'
alias rzsh='source ~/.zshrc'
alias vim='nvim'

# use exa instead of ls
alias ls='exa'

# colours for `ls` command
# alias ls='ls -G'
# alias lsa='ls -la'

# ENV variables
export HOMEBREW_NO_ANALYTICS=1

export TERM=xterm-256color
export FZF_DEFAULT_COMMAND='fd --type file --follow'
export FZF_CTRL_T_COMMAND='fd --type file --follow'
export FZF_DEFAULT_OPTS='--height 20%'

# go
export PATH="$PATH:$HOME/go/bin"
export GOPATH=$HOME/go

export PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=~/.local/bin:$PATH
export GIT_PS1_SHOWCOLORHINTS=true
export VISUAL=vim
export EDITOR="$VISUAL"
export GO111MODULE=on

# Use to clear out all local docker images and containers
dockerNuke () {
	docker stop $(docker ps -a -q);
	docker rm $(docker ps -a -q) --force;
	docker rmi $(docker images -q) --force;
}

kns() {
	# 1: namespace, if not given command prints out current namespace and exits
	# 2: context (apollo-dev /use), defaults to the current context
    if [[ -z $1 ]] ; then
        context=$(/usr/local/bin/kubectl config current-context)
        namespace=$(/usr/local/bin/kubectl config view | grep "cluster: $context" -A 1| grep namespace: | tr -d '[:space:]')
        namespace_clean="${namespace#namespace:}"
        echo "Current namespace: $namespace_clean";
    else
		context=$2
		if [[ -z $context ]] ; then
			context=$(kubectl config current-context)
		fi
		kubectl config set-context $context --namespace=$1
	fi
}

kredis() { k exec -it --namespace=apollo-system -c master $1 -- redis-cli -n 0; }

# fnm
eval "$(fnm env --multi)"

[

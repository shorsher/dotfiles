# aliases
alias k="kubectl"
alias kpods="k get pods"
alias kdeps="k get deployments"
alias kserv="k get services"
alias knodes="k get nodes"
alias krc="k get rc"
alias kname="k get namespaces"
alias gs="git status"
alias gl="git log"

abbr -a m make
abbr -a g git
abbr -a ga 'git add -p'
abbr -a gc 'git checkout'
abbr -a gs 'git status'
abbr -a gah 'git stash; and git pull --rebase; and git stash pop'
abbr -a gdc 'git diff | comview'
function pr
    set -l title (git show -s --format=%s HEAD)
    set -l body (git show -s --format=%B HEAD | tail -n+3 | string collect)
    gh pr create -t "$title" -b "$body"
end
abbr -a vimdiff 'nvim -d'

# use exa instead of ls
#alias ls='exa'

alias vim='nvim'

if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ls 'eza'
	abbr -a ll 'eza -l'
	abbr -a lll 'eza -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

# Type - to move up to top parent dir which is a repository
function d
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end

# zsh
functions -c fish_prompt _original_fish_prompt 2>/dev/null

function fish_prompt --description 'Write out the prompt'
  if set -q ZMX_SESSION
    echo -n "[$ZMX_SESSION] "
  end
  _original_fish_prompt
end

# ENV variables
export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120
export TERM=xterm-256color

# go
export PATH="$PATH:$HOME/go/bin"
export GOPATH=$HOME/go

# zls
export PATH="$PATH:$HOME/go/src/github.com/zigtools/zls/zig-out/bin"

# java
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$PATH:$JAVA_HOME/bin"

# Editor
set -gx EDITOR nvim

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# greeting
set fish_greeting

# fnm
eval "$(fnm env )"

# vi bindings
fish_vi_key_bindings

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'

if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ls 'eza'
	abbr -a ll 'eza -l'
	abbr -a lll 'eza -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

fish_add_path /opt/homebrew/bin

function fish_prompt
	set_color brblack
	echo -n "["(date "+%H:%M")"] "
	set_color blue
	echo -n (whoami)
	if [ $PWD != $HOME ]
		set_color brblack
		echo -n ':'
		set_color yellow
		echo -n (basename $PWD)
	end
	set_color green
	printf '%s ' (__fish_git_prompt)
	set_color red
	echo -n '| '
end

fish_add_path $HOME/.local/bin

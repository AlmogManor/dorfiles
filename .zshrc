source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export VIRTUAL_ENV_DISABLE_PROMPT=0

# divider line between each command
divider_line() {
	venv_prompt="%F{105} [${${VIRTUAL_ENV%/}##*/}] %f"
	
	if [[ -z "$VIRTUAL_ENV" ]]; then
    	echo -n "%F{236}"
    	printf '─%.0s' {1..$COLUMNS}
    	echo -n "%f"
	else
    	echo -n "%F{236}"
		echo -n "─$venv_prompt"
		# +9 to account for the color formatting, start from 2 because
		# we printed a dash before the venv prompt
    	echo -n "%F{236}"
		printf '─%.0s' {2..$((COLUMNS-$#venv_prompt+9))}
    	echo -n "%f"
	fi

}

# git prompt if inside git directory
git_prompt() {
    if ! git rev-parse --is-inside-work-tree 1>/dev/null 2>/dev/null; then
	echo -n " "
	return 0
    fi

    if [ "$(git status --porcelain)" = "" ]; then
	echo -n " %F{34}($(git branch --show-current))%f "
    else
	echo -n " %F{160}($(git branch --show-current))%f "
    fi
}
# run commands in prompt
setopt PROMPT_SUBST
# write commands to hist_file immediatly instead of when zsh exits
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

# cwd [git prompt] 
PS1='$(divider_line)%F{99}%~%f$(git_prompt)%F{14}%2{ %} %f'
# if return code was not 0, display it
RPS1="%(?..%F{160}%? %2{󱞥 %} %f)"

# ensure 256 color support
TERM="xterm-256color"

# hist_file size and location
SAVEHIST=10000
HISTFILE=~/.zsh_history

# custom ls colors
LS_COLORS="di=34:ln=35:so=36:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# custom less colors
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# colors when autocompleting
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit
# highlight current tab selection
zstyle ':completion:*' menu select

# make delete work
bindkey  "^[[3~"  delete-char
# make ctrl+arrow work
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias vim="nvim"
alias ls="ls -lAh --color=auto"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gr="git rebase"
alias gs="git status"
alias glog="git log --oneline --graph"
alias ichd="choose-adb-serial;export ANDROID_SERIAL=\$(cat '/tmp/ichoose-device-serial-file')"
alias vend="deactivate"

venv() {
	if (( "$#" == 0 )); then
		source "./venv/bin/activate"
	else
		source "./$1/bin/activate"
	fi
}

export PATH="/home/Almog/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

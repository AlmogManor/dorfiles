source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# divider line between each command
divider_line() {
    echo -n "%F{236}"
    printf '─%.0s' {1..$COLUMNS}
    echo -n "%f"
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
alias glog="git log --oneline --graph"

export PATH="/home/Almog/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

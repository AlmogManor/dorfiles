# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

divider_line() {
    echo -n "%F{236}"
    printf '─%.0s' {1..$COLUMNS}
    echo -n "%f"
}

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

setopt PROMPT_SUBST
PS1='$(divider_line)%F{99}%~%f$(git_prompt)%F{14}%2{ %} %f'
RPS1="%(?..%F{160}%? %2{󱞥 %} %f)"

TERM="xterm-256color"

SAVEHIST=10000
HISTFILE=~/.zsh_history

bindkey  "^[[3~"  delete-char

alias vim="nvim"
alias ls="ls -lAh"
alias ga="git add"
alias gc="git commit"
alias gr="git rebase"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

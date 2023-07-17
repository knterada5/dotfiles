# don`t duplicate zsh history.
setopt hist_ignore_dups

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE=~/.zsh_history
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
  PS1="%F{2}%n%f:%F{4}%c%f$ "
else
  PS1='%n:%c$ '
fi
unset color_prompt

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# python pipenv create .venv in project directory.
export PIPENV_VENV_IN_PROJECT=true

# setting asdf.
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# GO
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.go/bin"

# cargo
export PATH="$PATH:$HOME/.cargo/bin"

# basex
export PATH="$PATH:$HOME/basex/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/knterada5/.miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/knterada5/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/knterada5/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/knterada5/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


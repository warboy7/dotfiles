# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# comp init
autoload -Uz compinit
compinit

# Plugins
# powerlevel
source $HOME/github/powerlevel10k/powerlevel10k.zsh-theme
# autosuggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# completion
fpath=(/usr/share/zsh/site-functions $fpath)

# completion settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# HISTORY SETTINGS
HISTFILE=~/.zsh_history
HISTSIZE=500000
SAVEHIST=500000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[Z' reverse-menu-complete
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# kill word
autoload -U select-word-style
select-word-style bash
export WORDCHARS='.-'

# fzf settings
export FZF_DEFAULT_COMMAND='find -L'
source <(fzf --zsh)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# MISC SETTINGS
# custom path
export PATH="$PATH:/$HOME/tools/scripts:/home/$USER/tools/binaries"
export PATH=$PATH:$HOME/.local/bin

#bat theme
export BAT_THEME="Dracula"

# pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# alias
source ~/.alias

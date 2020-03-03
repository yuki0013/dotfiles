# alias
alias ls='ls -FhG --color=auto'
alias ll='ls -lGFh --color=auto'
alias la='ls -lAGhF --color=auto'
alias history='history -iD'
alias grep='grep --color=auto'

setopt no_beep
setopt no_hist_beep
setopt no_list_beep

if [ ! -e ${HOME}/.zplug ];then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh
export PATH=$PATH:$HOME/.nodebrew/current/bin
export PATH=$PATH:/Application/XAMPP/xamppfiles/bin/

autoload -U compinit promptinit
compinit -C
promptinit

#  hokan group
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*' menu select=2

### 補完候補に色を付ける。
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' verbose no
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin


setopt completealiases

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# ヒストリの共有の有効化
setopt share_history
setopt extended_history
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
# ヒストリに追加されるコマンドが古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
setopt auto_cd
setopt auto_pushd
setopt prompt_subst
setopt no_nomatch
cdpath=(.. ~ ~/src)


autoload -Uz colors
colors
if [ -f "${HOME}/.commonshrc" ] ; then
    source "${HOME}/.commonshrc"
fi

# zplug
#source ~/.zplug/init.zsh
# ないコマンドで赤くなるやつ
zplug "zsh-users/zsh-syntax-highlighting"
# めちゃくちゃ補完候補増やすやつ
zplug "zsh-users/zsh-completions"
# git の補完を効かせる
# 補完＆エイリアスが追加される
zplug "peterhurford/git-aliases.zsh"
# 薄く出すやつ
zplug "zsh-users/zsh-autosuggestions", defer:2


if ! zplug check --verbose; then
	zplug install
fi

setopt promptsubst
setopt auto_list
setopt auto_menu

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

#PROMPT="[%*]%F{039}%n@%m%f:%F{083}%d%f
#%(?|%F{076}|%F{009})%(?!(*'-') !(%?;-;%) )%#%f "

PROMPT="[%*]%F{039}%n@%m%f:%F{083}%d%f
 %(?|%F{076}|%F{009})%#%f "
setopt correct
SPROMPT="%{%F{220}%}%{$suggest%}(._.%)? %B %r is correct? [n,y,a,e]:%f%}%b "


# history pecoで検索
function peco-history-selection() {
    BUFFER=`history -n 1 | perl -e 'print reverse <>' | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection
chmod -R 755 ${HOME}/.zplug
zplug load

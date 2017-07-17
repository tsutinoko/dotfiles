# Created by newuser for 5.2
fpath=(/usr/local/share/zsh-completions $fpath)
export PATH=$HOME/.nodebrew/current/bin:$PATH

# http://post.simplie.jp/posts/60 の設定
#
# zplug
#

# zpulgの環境変数追加
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# brewを通さずインストールしたときのもの
# 上記で環境変数を追加しているので不要かも
# source ~/.zplug/init.zsh

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:3
# zplug 'mollifier/anyframe'

if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose

#
# Autoloadings
#

autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit -u
autoload -Uz url-quote-magic
autoload -Uz vcs_info

#
# ZLE settings
#

zle -N self-insert url-quote-magic

#
# General settings
#

setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt ignore_eof
setopt inc_append_history
setopt interactive_comments
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt magic_equal_subst
setopt notify
setopt print_eight_bit
setopt print_exit_value
setopt prompt_subst
setopt pushd_ignore_dups
setopt rm_star_wait
setopt share_history
setopt transient_rprompt

#cdとlsの省略
setopt auto_cd
function chpwd() { ls }

# 移動した場所を記録し、cd -[TAB] で以前移動したディレクトリの候補を提示してくれて、その番号を入力することで移動出来るようになる。
setopt auto_pushd

# auto_pushdで重複するディレクトリは記録しないようにする。
setopt pushd_ignore_dups

# コマンドのスペルミスを指摘して予想される正しいコマンドを提示してくれる。このときのプロンプトがSPROMPT。
setopt correct

#初回シェル時のみtmuxを実行
if [ $SHLVL = 1 ]; then
   tmux
fi

#
# Exports
#

export CLICOLOR=true
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
export EDITOR=vim
export HISTFILE=~/.zhistory
export HISTSIZE=1000
export SAVEHIST=1000000
export LANG=ja_JP.UTF-8

#
# Key bindings
#

bindkey -v
bindkey -v '^?' backward-delete-char
bindkey '^[[Z' reverse-menu-complete

#anyframeがよく分からないので一旦除外
#bindkey '^@' anyframe-widget-cd-ghq-repository
#bindkey '^r' anyframe-widget-put-history

#
# Aliases
#

alias la='ls -la'
alias vi='vim'
alias reload='exec $SHELL -l'
alias vvim='vi ~/.vimrc'
alias vtmux='vi ~/.tmux.conf'
alias vzsh='vi ~/.zshrc'

#
# Module settings
#

# Completion
autoload -U compinit; compinit
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'

# hash
#hashの'~'を省略
setopt CDABLE_VARS
hash -d htdocs=/Applications/MAMP/htdocs


# PROMPT
# 右プロンプトに現在地を表示。
RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%}%{$fg_bold[white]%}]%{$reset_color%}"

# スペルミス時の「もしかして」表示の文言を変更
SPROMPT="%{$fg[yellow]%}%{$suggest%}(*'~'%)? < もしかして %B%r%b %{$fg[yellow]%}かな? [そう!(y), 違う!(n),a,e]:${reset_color} "

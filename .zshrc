#----- LANGの設定
export LANG=ja_JP.UTF-8


#----- lessから使うエディタの指定
export VISUAL=emacs


#----- colors のロード
autoload colors
colors
# これをやるとプロンプトで色の名前が使える

#----- Home/binのパス
export PATH=${PATH}:~/bin

#----- プロンプトの設定
#----- ----- git の設定
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
setopt prompt_subst             # プロンプトが表示されるたび評価、置換
function rprompt-git-current-branch {
        local name st color gitdir action
    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
        return
    fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
    if [[ -z $name ]]; then
        return
    fi
        gitdir=`git rev-parse --git-dir 2> /dev/null`
    action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
        st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color=%F{green}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color=%F{yellow}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
        color=%B%F{red}
    else
        color=%F{red}
    fi
       echo "$color$name$action%f%b "
}
alias cntall='expr `ls -a|wc -w` - 2'
alias cntfil='ls|wc -w'
alias cntdir='ls -F|grep /|wc -l'
alias cntdot='expr `cntall` - `cntfil`'

#----- ----- プロンプトの設定
PROMPT="
%B%F{magenta}[%n@%m] %(!.#.$) %f%b"
PROMPT2="$B%F{magenta}%_> %f%b"
SPROMPT="%B%F{red} correct: %R -> %r [n,y,a,e]? %f%b"
RPROMPT='%B%F{yellow}[%f%b`rprompt-git-current-branch`%B%F{yellow}%~]%f%b'


#----- ターミナル、ウィンドウのタイトルの設定
case "${TERM}" in
    kterm*|xterm*)
       precmd() {
          echo -ne "\033]0;${USER}@${HOST}\007"  # ターミナルのウィンドウタイトル
       }
       ;;
    screen*)
        if [ "$OS" != "Windows_NT" ]
        then    # screenのウィンドウタイトル
          preexec() {
             mycmd=(${(s: :)${1}})
             echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):#$mycmd[1]\e\\"
          }
          precmd() {
             echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):$(basename $(pwd))\e\\"
          }
        fi
        ;;
esac


#----- 履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory     # HISTFILEを上書きせずに追記
setopt hist_ignore_all_dups     # 重複したとき、古い履歴を削除
setopt hist_ignore_space     # 先頭にスペースを入れると履歴を保存しない
setopt hist_reduce_blanks       # 余分なスペースを削除して履歴を保存
setopt share_history     # 履歴を共有する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end    # C-p, C-n でインクリメンタルサーチ
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


#----- 補完
autoload -U compinit
compinit
zstyle ':completion:*:default' list-colors ${LS_COLORS} # 補完候補を色付きで表示
#zstyle ':completion:*' list-colors 'di=01;34:ln=01;36:ex=01;32:*.tar=01;31:*.gz=01;31' # 手動設定
zstyle ':completion:*:default' menu select=1 # 補完候補をEmacsのキーバインドで選択
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31' # killの候補を色付き表示
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[-_.]=**' # 大文字を補完、-_.の前に*を補うようにして補完


#----- ls color の設定
alias ls="ls --color"
alias la="ls -a"
alias l="ls -l"



#----- alias まとめ
alias vi="vim"
alias emw="emacs-w32"
alias c="cygstart"
alias cver='cygcheck -c'
alias ves='VESTA.exe'
alias glog='git log'
alias gtree='git log --oneline --graph'
alias gsta='git status'
alias wg='/cygdrive/c/Program\ Files/gnuplot5/bin/wgnuplot.exe'

#----- Delete/Home/End key を有効にする
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey "^[[3~" delete-char

#----- emacs ライクな操作を有効にする
bindkey -e



#----- emacs daemon
# デーモンが起動していればデーモンを起動
# 既に起動していればデーモンでバッファを開く
alias ema='emacsclient -a ""'

# emacsdaemon をkillする
alias ekill='emacsclient -e "(kill-emacs)"'


# OS依存の設定
case ${OS} in
	Windows_NT*) # 大学のデスクトップPC
    
    #----- PATH の設定
	export PATH=${PATH}:/cygdrive/c/Program\ Files\ \(x86\)/gnuplot/bin
	export PATH=${PATH}:~/bin/VESTA-win64
        export PATH=${PATH}:/cygdrive/c/gtk/bin
    
	#----- x window の設定
    export DISPLAY=:0.0

	#----- k の設定
	source ~/bin/k/k.sh


	;;
esac

case ${OSTYPE} in
	linux-gnu*) # mic machine

	# (CPVO) screen_new に表示されるイタレーションをリアルタイムで確認する
	alias sn="tail -f screen_new"
	;;
esac	

if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

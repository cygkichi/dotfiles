# ------------------------------------------------------------
# zinitの設定
# ------------------------------------------------------------
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# ------------------------------------------------------------
# 環境変数
# ------------------------------------------------------------
export EDITOR=vim
export LANG=ja_JP.UTF-8
export PATH="$PATH:/Users/hnakano/.local/bin" # Created by `pipx` on 2024-12-15 13:53:58


# ------------------------------------------------------------
# プラグイン
# ------------------------------------------------------------

# テーマのロード
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure


# コマンド入力補完
# * コマンドを途中まで入力すると、履歴から残りの候補を提示してくれる
# * https://github.com/zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-autosuggestions


# コマンド補完
# * Tabキーでファイル名やコマンドの候補を表示する
# * https://github.com/zsh-users/zsh-completions
zinit light zsh-users/zsh-completions


# コマンドからの検索履歴
# * https://github.com/robobenklein/zdharma-history-search-multi-word
zinit light zdharma/history-search-multi-word

# シェルコマンドの色付け
# * https://github.com/zdharma-continuum/fast-syntax-highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

# エイリアス(abbr)
# - abbrエイリアスは、履歴に元コマンドを残せる
# - https://github.com/olets/zsh-abbr
zinit light olets/zsh-abbr


# zeno設定
# * 参考:https://qiita.com/obake_fe/items/da8f861eed607436b91c
# 25/01/05:よくわからんから放置
# zinit ice lucid depth"1" blockf
# zinit light yuki-yano/zeno.zsh

# ------------------------------------------------------------
# エイリアス
# ------------------------------------------------------------
#abbr ls='ls --color'
#abbr l='ls -l --color'
#abbr la='ls -la --color'

# ------------------------------------------------------------
# TAB補完
# ------------------------------------------------------------

# TABで部分一致できるようにする
# 例えば`hoge[TAB]`で`sample-hoge-abc`をマッチさせることができる
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|{a-zA-Z}=**'

# TABで保管する際にメニュー画面設定
zstyle ':completion:*' menu select


# ------------------------------------------------------------
# クラウド設定(Google Cloud SDKの設定)
# ------------------------------------------------------------
if [ -f '/Users/hnakano/bin/google-cloud-sdk/path.zsh.inc' ]
then
    . '/Users/hnakano/bin/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/Users/hnakano/bin/google-cloud-sdk/completion.zsh.inc' ]
then
    . '/Users/hnakano/bin/google-cloud-sdk/completion.zsh.inc'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


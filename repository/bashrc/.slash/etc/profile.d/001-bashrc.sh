export EDITOR=vim
export GOPATH=$HOME/workspace/go
export PATH=$PATH:$HOME/.slash/bin:$GOPATH/bin

# load bashrc on tmux session
case $- in *i*) . ~/.bashrc;; esac
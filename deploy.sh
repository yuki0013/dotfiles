#!/bin/bash
# ${HOME}に.rcのリンク作成するやつ

DOT_DIR="${HOME}/dotfiles"
_REMOTE="git@github.com:yuki0013/dotfiles.git"

cd

if [ ! type "git" >/dev/null 2>&1 ]; then
    echo "command not found: git"
    exit 1
fi

if [ ! -d ${DOT_DIR} ];then
    echo "Downloading dotfiles..."
    mkdir -p ${DOT_DIR}
    git clone --recursive "${_REMOTE}" "${DOT_DIR}"
fi

cd ${DOT_DIR}
git pull >/dev/null 2>&1

for f in .??*;do
    [ ${f} = ".git" ] && continue
    [ ${f} = ".gitignore" ] && continue
    [ ${f} = ".config" ] && continue
    ln -snfv ${DOT_DIR}/${f} ${HOME}/${f}
done

cd

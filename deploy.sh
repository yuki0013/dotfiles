#!/bin/bash
DOT_DIR="${HOME}/dotfiles"
_REMOTE="git@github.com:yuki0013/dotfiles.git"

if [ ! type "git" >/dev/null 2>&1 ]; then
    echo "command not found: git"
    return 0
fi

if [ ! -d ${DOT_DIR} ];then
    echo "Downloading dotfiles..."
    mkdir -p ${DOT_DIR}
    git clone --recursive "${_REMOTE}" "${DOT_DIR}"
fi

cd ${DOT_DIR}
git pull

for f in .??*;do
    [ ${f} = ".git" ] && continue
    [ ${f} = ".gitignore" ] && continue
    [ ${f} = ".config" ] && continue
    ln -snfv ${DOT_DIR}/${f} ${HOME}/${f}
done

. ~/.bashrc
cd

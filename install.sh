#!/bin/bash

BASHRC=${HOME}/.bashrc

#####

export COLOR_GREEN="\e[32m"
export COLOR_YELLOW="\e[33m"
export COLOR_RED="\e[31m"
export COLOR_NONE="\e[0m"

function notice()
{
    # print in green
    echo $'\e[32m'${*}$'\e[0m'
}

function warning()
{
    # print in yellow
    echo $'\e[33m'${*}$'\e[0m'
}

function error()
{
    # print in red
    echo $'\e[31m'${*}$'\e[0m'
}

function set_link()
{
    s=${1}
    t=${2}
    ln_output=`ln -s ${s} ${t} 2>&1`; r=$?
    if [ $r -eq 0 ]; then
        notice "linked ${s} to ${t}"
    else
        echo ${ln_output} | grep "File exists" &> /dev/null &&
        warning "${t} already exists" ||
        error "could not link ${s} to ${t}"
    fi
}

MYENV_DIR="$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)"

RC_INSERT="test -r ${MYENV_DIR}/rc && source ${MYENV_DIR}/rc"
grep "^${RC_INSERT}$" ${BASHRC} &> /dev/null; r=$?
if [ $r -eq 0 ]; then
    warning "${MYENV_DIR}/rc already sourced in ${BASHRC}"
else
    echo ${RC_INSERT} >> ${BASHRC} &&
    notice "${MYENV_DIR}/rc sourced in ${BASHRC}" ||
    notice "could not source ${MYENV_DIR}/rc in ${BASHRC}"
fi

set_link $MYENV_DIR/screen-session-attach/attach ${HOME}/bin/attach
set_link $MYENV_DIR/dotfiles/vimrc ${HOME}/.vimrc
set_link $MYENV_DIR/dotfiles/screenrc ${HOME}/.screenrc
set_link $MYENV_DIR/dotfiles/inputrc ${HOME}/.inputrc
set_link $MYENV_DIR/dotfiles/ssh/rc ${HOME}/.ssh/rc
set_link $MYENV_DIR/dotfiles/gitexcludes ${HOME}/.gitexcludes

if [ -e "${HOME}/.gitconfig" ]; then
    warning "${HOME}/.gitconfig already exists"
else
    cp ${MYENV_DIR}/dotfiles/gitconfig ${HOME}/.gitconfig &&
    notice "copied ${MYENV_DIR}/dotfiles/gitconfig to ${HOME}/.gitconfig" ||
    error "could not copy ${MYENV_DIR}/dotfiles/gitconfig to ${HOME}/.gitconfig"

    git config --global core.excludesfile ${HOME}/.gitexcludes &&
    notice "added ${HOME}/.gitexcludes to core.excludesfile in ${HOME}/.gitconfig" ||
    error "could not add ${HOME}/.gitexcludes to core.excludesfile in ${HOME}/.gitconfig"

    if [ "x${USER}" = "xkris" ]; then
        git_user_email="kris@ofa2.com"
    elif [ "x${USER}" = "xsteinhof" ]; then
        git_user_email="steinhof@umich.edu"
    fi

    git config --global user.email ${git_user_email} &&
    notice "added ${git_user_email} to user.email in ${HOME}/.gitconfig" ||
    error "could not add ${git_user_email} to user.email in ${HOME}/.gitconfig"
fi

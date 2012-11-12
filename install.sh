#!/bin/sh

BASHRC=${HOME}/.bashrc

#####

export COLOR_GREEN="\e[32m"
export COLOR_YELLOW="\e[33m"
export COLOR_RED="\e[31m"
export COLOR_NONE="\e[0m"

function notice()
{
    msg=${*}
    echo -e "${COLOR_GREEN}${msg}${COLOR_NONE}"
}

function warning()
{
    msg=${*}
    echo -e "${COLOR_YELLOW}WARNING ${msg}${COLOR_NONE}"
}

function error()
{
    msg=${*}
    echo -e "${COLOR_RED}ERROR ${msg}${COLOR_NONE}"
    exit 1;
}

RC="$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/rc"

RC_INSERT="test -r ${RC} && source ${RC}"

echo $RC_INSERT


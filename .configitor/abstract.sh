#!/bin/sh

source $HOME/.configitor/colors.sh

function c_log() {
    echo -e "${1} ${2}${3}${RCol}"
}

function c_success() {
    c_log "[S]" $Gre "$1"
}

function c_info() {
    c_log "[I]" $Yel "$1"
}

function c_error() {
    c_log "[E]" $Red "$1"
}


#!/usr/bin/env bash
# utils.sh

_die() {
    local msg=$1
    local code=${2:-1} # default exit status 1
    error "$msg"
    exit "$code"
}

utils::need_cmd() {
    if ! _check_cmd "$1"; then
        _die "Error: '$1' command not found but needed"
    fi
}

_check_cmd() {
    command -v "$1" >/dev/null 2>&1
}

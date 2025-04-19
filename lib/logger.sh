#!/usr/bin/env bash
# logger.sh

#-------------------------------------------------------------
# SETUP COLORS CONFIGURATION
#-------------------------------------------------------------
logger::setup_colors() {
    if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
        COLOR_RESET='\033[0m'
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        YELLOW='\033[0;33m'

    else
        COLOR_RESET=''
        RED=''
        GREEN=''
        YELLOW=''
    fi
}

logger::info() {
    local message="$1"
    echo -e "${GREEN}[INFO] ${message}${COLOR_RESET}"
}

logger::warn() {
    local message="$1"
    echo -e "${YELLOW}[WARNING] ${message}${COLOR_RESET}"
}

logger::error() {
    local message="$1"
    echo -e "${RED}[ERROR] ${message}${COLOR_RESET}" >&2
}

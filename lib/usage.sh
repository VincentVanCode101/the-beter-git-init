#!/usr/bin/env bash
# usage.sh

usage::general() {
    # ANSI escape codes for styling
    BOLD="\033[1m"
    RESET="\033[0m"
    UNDERLINE="\033[4m"

    echo -e "${BOLD}USAGE${RESET}"
    echo -e "  ${ROOT_SCRIPT} [OPTIONS]"
    echo

    echo -e "${BOLD}DESCRIPTION${RESET}"
    echo -e "  Initialize a local Git repository and create a corresponding GitHub"
    echo -e "  repository (public or private), then configure the 'origin' remote."
    echo -e "  Supports a custom description via -d|--description, and will"
    echo -e "  detect and update existing repos/remotes to avoid errors."
    echo

    echo -e "${BOLD}GLOBAL OPTIONS${RESET}"
    echo -e "  ${BOLD}-h, --help${RESET}                Display this help message."
    echo -e "  ${BOLD}--private${RESET}                 Create a private repository on GitHub."
    echo -e "  ${BOLD}-d, --description <desc>${RESET}  Set the repository description."
    echo

    echo -e "${BOLD}EXAMPLES${RESET}"
    echo -e "  ${UNDERLINE}${ROOT_SCRIPT}${RESET}"
    echo -e "      Initialize a new public repo"
    echo
    echo -e "  ${UNDERLINE}${ROOT_SCRIPT} --private${RESET}"
    echo -e "      Initialize a new private repo."
    echo
    echo -e "  ${UNDERLINE}${ROOT_SCRIPT} -d \"just a test\"${RESET}"
    echo -e "      Initialize a new public repo with description \"just a test\"."
    echo
    echo -e "  ${UNDERLINE}${ROOT_SCRIPT} --private -d \"secret project\"${RESET}"
    echo -e "      Initialize a new private repo with description \"secret project\"."
    echo

    exit 0
}

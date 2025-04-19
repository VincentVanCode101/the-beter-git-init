#!/usr/bin/env bash

git_local::init_and_link_repo() {
    local ssh_url="$1"

    if [ ! -d .git ]; then
        logger::info "Initializing local git repository..."
        git init --initial-branch=main >/dev/null 2>&1
    else
        logger::info "Git repository already initialized; skipping git init."
    fi

    if git remote | grep -q '^origin$'; then
        logger::warn "Remote 'origin' exists; updating URL to $ssh_url."
        git remote set-url origin "$ssh_url"
    else
        logger::info "Adding remote 'origin' -> $ssh_url."
        git remote add origin "$ssh_url"
    fi
}

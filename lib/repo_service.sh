#!/usr/bin/env bash

repo_service::create() {
    case "${REPO_PROVIDER:-github}" in
    github) github::create "$@" ;;
    gitlab) gitlab::create "$@" ;;
    *)
        logger::error "Unknown repo provider: $REPO_PROVIDER"
        exit 1
        ;;
    esac
}

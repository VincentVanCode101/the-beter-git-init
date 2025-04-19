#!/usr/bin/env bash

github::create() {
    local private_flag="$1"
    local description="$2"

    repo_name=$(basename "$PWD" |
        tr '[:upper:]' '[:lower:]' |
        sed -E 's/[^a-z0-9]+/-/g' |
        sed -E 's/^-+|-+$//g')

    local payload
    payload=$(jq -n \
        --arg name "$repo_name" \
        --arg desc "$description" \
        --argjson priv "$private_flag" \
        '{ name: $name, description: $desc, private: $priv, auto_init: false }')

    logger::info "Creating remote repository on GitHub..."
    local response
    response=$(curl -s -H "Authorization: token $PERSONAL_ACCESS_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Content-Type: application/json" \
        -d "$payload" \
        https://api.github.com/user/repos)

    if echo "$response" | grep -q '"full_name"'; then
        repo_html_url=$(echo "$response" | jq -r .html_url)
        repo_ssh_url=$(echo "$response" | jq -r .ssh_url)
        logger::info "Remote repository created: $repo_html_url"
    elif echo "$response" | grep -q 'name already exists'; then
        logger::warn "Repository already exists on GitHub."

        local github_user
        github_user=$(curl -s -H "Authorization: token $PERSONAL_ACCESS_TOKEN" \
            https://api.github.com/user | jq -r .login)

        if [[ -z "$github_user" || "$github_user" == "null" ]]; then
            logger::error "Failed to retrieve GitHub username from token."
            exit 1
        fi

        repo_ssh_url="git@github.com:${github_user}/${repo_name}.git"

        echo
        logger::info "Repository exists. To link your local repo, run:"
        echo
        echo "    git remote add origin ${repo_ssh_url}"
        echo
        exit 0
    else
        logger::error "GitHub API error. Response:"
        echo "$response"
        exit 1
    fi
}

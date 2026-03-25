#!/bin/bash

# These are helper functions to set up or configure few things, when or if required. 
# For e.g., to configure a trainer bot username and email in local exercise repo to distinguish commits, and so on. 

# Intended to be extended for other purposes.


set -e

config_local_username() {
    # In the exercise repo, set local git user name and email to distinguish commits between user and setup script.
    # Only set if not already configured (globally or locally) to avoid overwriting the user's identity.

    EXERCISE_REPO_NAME='exercise'

    REPO=$(git rev-parse --show-toplevel) # Grab the git repo name
    REPO_NAME=$(basename ${REPO})

    if [[ ! -z ${REPO_NAME} && ${REPO_NAME} == 'exercise' ]]; then
        if ! git config user.name > /dev/null 2>&1; then
            git config --local user.name "git-katas trainer bot"
        fi
        if ! git config user.email > /dev/null 2>&1; then
            git config --local user.email "git-katas@example.com"
        fi
        echo "Successfully configured local username and email"
    fi
}

clear_local_user() {
# In the exercise repo, unset local git user name and email only if we set them (value is trainer bot).

    EXERCISE_REPO_NAME='exercise'

    REPO=$(git rev-parse --show-toplevel) # Grab the git repo name
    REPO_NAME=$(basename ${REPO})

    if [[ ! -z ${REPO_NAME} && ${REPO_NAME} == 'exercise' ]]; then
        if [[ "$(git config --local user.name 2>/dev/null)" == "git-katas trainer bot" ]]; then
            git config --local --unset user.name
        fi
        if [[ "$(git config --local user.email 2>/dev/null)" == "git-katas@example.com" ]]; then
            git config --local --unset user.email
        fi
        echo "Successfully unset local username and email"
    fi

}

config_local_gpgsigning() {
    # In the exercise repo, disable signing commits as it might be enabled globally.
    EXERCISE_REPO_NAME='exercise'

    REPO=$(git rev-parse --show-toplevel) # Grab the git repo name
    REPO_NAME=$(basename ${REPO})

    if [[ ! -z ${REPO_NAME} && ${REPO_NAME} == 'exercise' ]]; then
        git config --local commit.gpgsign "false"
        echo "Successfully disable local GPG signing"
    fi
}

clear_local_gpgsigning() {
# In the exercise repo, unset locally disabled signing of commits.

    EXERCISE_REPO_NAME='exercise'

    REPO=$(git rev-parse --show-toplevel) # Grab the git repo name
    REPO_NAME=$(basename ${REPO})

    if [[ ! -z ${REPO_NAME} && ${REPO_NAME} == 'exercise' ]]; then
        git config --local --unset commit.gpgsign
        echo "Successfully unset local GPG signing"
    fi
}

pre_setup () {
    kata="$(basename $(pwd))"   # kata: name of the exercise which is respective folder name
    make_exercise_repo
    config_local_username
    config_local_gpgsigning
}

pre_setup_with_remote () {
    kata="$(basename $(pwd))"   # kata: name of the exercise which is respective folder name
    make_bare_remote_repo 
    clone_remote_to_exercise
    config_local_username
    config_local_gpgsigning
}

post_setup () {
    clear_local_user
    clear_local_gpgsigning
}


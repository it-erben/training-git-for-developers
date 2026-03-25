#!/bin/bash
make_bare_remote_repo() {
    # First cleanup if there is an old exercise repository
    rm -rf remote/

    # Initialize a new remote repository
    git -c init.defaultBranch="$DEFAULT_BRANCH" init --bare remote
}

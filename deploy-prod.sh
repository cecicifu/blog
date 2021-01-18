#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"


# DEV BRANCH --------------------------------------------------------

git init -b dev

git add .

msg=""
if [ -n "$*" ]; then
	msg="$*"
else
	exit 1
fi
git commit -m "$msg"

git push -f https://github.com/cecicifu/blog.git dev


# MAIN BRANCH ------------------------------------------------------

# Build the project.
hugo -t archie # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

# Init repo on main branch
git init -b main

# Add changes to git.
git add .

# Commit changes.
git commit -m "rebuilding site $(date)"

# Push source and build repos.
git push -f https://github.com/cecicifu/blog.git main
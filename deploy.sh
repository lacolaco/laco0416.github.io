# !/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project. 
hugo

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin hugo-src
git checkout master
git add public/* -f
git commit -m "$msg"
git push origin `git subtree split --prefix public master`:master --force
git checkout hugo-src
git rm -rf public
git commit -m "$msg" --amend
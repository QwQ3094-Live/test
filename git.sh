#!/bin/sh

echo "\nCommit name: "
read name

git add .
git commit -m "$name"
git push -u test
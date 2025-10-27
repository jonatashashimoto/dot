#!/usr/bin/env bash

cd $(tmux run "echo #{pane_current_path}")
url=$(git remote get-url origin)

echo $url
if [[ $url == *github.com* ]]; then
  if [[ $url == git@* ]]; then
      url="${url#git@}"
      url="${url/://}"
      url="https://$url"
  fi
  open "$url"
else
  echo "This repository is not hosted on GitHub"
fi
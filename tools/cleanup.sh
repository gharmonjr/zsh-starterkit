#!/usr/bin/env sh

function zsh_starterkit_cleanup() {
  echo "About to delete all 'pre-zsh-starterkit' backup files and directories if found."
  echo "This cannot be undone. Would you like to continue? [Y/n]: \c"
  read line
  if [[ "$line" != Y* ]] && [[ "$line" != y* ]]; then
    return -1
  fi
  rm -rf ~/.*.pre-zsh-starterkit*
  rm -rf ~/*.pre-zsh-starterkit*
  rm -rf "${XDG_CONFIG_HOME}"/.*.pre-zsh-starterkit*
  rm -rf "${XDG_CONFIG_HOME}"/*.pre-zsh-starterkit*
}
zsh_starterkit_cleanup

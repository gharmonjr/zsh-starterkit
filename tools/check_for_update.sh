#!/usr/bin/env zsh

zmodload zsh/datetime

XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$XDG_CACHE_HOME/zsh}"
[ -d "$ZSH_CACHE_DIR" ] || mkdir -p "$ZSH_CACHE_DIR"

function _current_epoch() {
  echo $(( $EPOCHSECONDS / 60 / 60 / 24 ))
}

function _update_zsh_update() {
  echo "LAST_EPOCH=$(_current_epoch)" >! ${ZSH_CACHE_DIR}/.zsh-starterkit-update
}

function _upgrade_zsh() {
  antigen update
  # update the zsh file
  _update_zsh_update
}

epoch_target=$UPDATE_ZSH_DAYS
if [[ -z "$epoch_target" ]]; then
  # Default to old behavior
  epoch_target=13
fi

# Cancel upgrade if git is unavailable on the system
whence git >/dev/null || return 0

if mkdir "${ZSH_CACHE_DIR}/update.lock" 2>/dev/null; then
  if [ -f ${ZSH_CACHE_DIR}/.zsh-starterkit-update ]; then
    . ${ZSH_CACHE_DIR}/.zsh-starterkit-update

    if [[ -z "$LAST_EPOCH" ]]; then
      _update_zsh_update && return 0
    fi

    epoch_diff=$(($(_current_epoch) - $LAST_EPOCH))
    if [ $epoch_diff -gt $epoch_target ]; then
      if [ "$DISABLE_UPDATE_PROMPT" = "true" ]; then
        _upgrade_zsh
      else
        echo "[zsh-starterkit] Would you like to update? [Y/n]: \c"
        read line
        if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
          _upgrade_zsh
        else
          _update_zsh_update
        fi
      fi
    fi
  else
    # create the zsh file
    _update_zsh_update
  fi

  rmdir "${ZSH_CACHE_DIR}"/update.lock
fi

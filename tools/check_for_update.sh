#!/usr/bin/env zsh

zmodload zsh/datetime

function _current_epoch() {
  echo $(( $EPOCHSECONDS / 60 / 60 / 24 ))
}

function _update_zsh_update() {
  echo "LAST_EPOCH=$(_current_epoch)" >! ${ZSH_STARTERKIT}/.zsh-update
}

function _upgrade_zsh() {
  env ZSH_STARTERKIT=$ZSH_STARTERKIT sh $ZSH_STARTERKIT/tools/upgrade.sh
  # update the zsh file
  _update_zsh_update
}

epoch_target=$UPDATE_ZSH_DAYS
if [[ -z "$epoch_target" ]]; then
  # Default to old behavior
  epoch_target=13
fi

# Cancel upgrade if the current user doesn't have write permissions for the
# oh-my-zsh directory.
[[ -w "$ZSH_STARTERKIT" ]] || return 0

# Cancel upgrade if git is unavailable on the system
whence git >/dev/null || return 0

if mkdir "$ZSH_STARTERKIT/update.lock" 2>/dev/null; then
  if [ -f ${ZSH_STARTERKIT}/.zsh-update ]; then
    . ${ZSH_STARTERKIT}/.zsh-update

    if [[ -z "$LAST_EPOCH" ]]; then
      _update_zsh_update && return 0
    fi

    epoch_diff=$(($(_current_epoch) - $LAST_EPOCH))
    if [ $epoch_diff -gt $epoch_target ]; then
      _upgrade_zsh
      # if [ "$DISABLE_UPDATE_PROMPT" = "true" ]; then
      #   _upgrade_zsh
      # else
      #   echo "[zsh-starterkit] Would you like to update? [Y/n]: \c"
      #   read line
      #   if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
      #     _upgrade_zsh
      #   else
      #     _update_zsh_update
      #   fi
      # fi
    fi
  else
    # create the zsh file
    _update_zsh_update
  fi

  rmdir $ZSH_STARTERKIT/update.lock
fi

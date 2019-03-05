#!/usr/bin/env zsh

zmodload zsh/datetime

_set_last_updated() {
  echo "LAST_EPOCH=$EPOCHSECONDS" >! ${ZSH_STARTERKIT}/.zsh-starterkit-update
}

main() {
  UPDATE_ZSH_DAYS="${UPDATE_ZSH_DAYS:-14}"

  # Cancel upgrade if the current user doesn't have write permissions for the
  # zsh-starterkit directory.
  [[ -w "$ZSH_STARTERKIT" ]] || return 0

  [ ! -f "${ZSH_STARTERKIT}"/.zsh-starterkit-update ] && _set_last_updated
  source "${ZSH_STARTERKIT}"/.zsh-starterkit-update

  DAYS_SINCE_UPDATE="$(( ($EPOCHSECONDS - $LAST_EPOCH) / 60 / 60 / 24 ))"
  if [ $DAYS_SINCE_UPDATE -ge $UPDATE_ZSH_DAYS ]; then
    env sh "${ZSH_STARTERKIT}"/tools/update.sh
    _set_last_updated
  fi
}
main

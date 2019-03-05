#!/usr/bin/env zsh

zmodload zsh/datetime

main() {
  UPDATE_ZSH_DAYS="${UPDATE_ZSH_DAYS:-14}"

  # Cancel upgrade if the current user doesn't have write permissions for the
  # zsh-starterkit directory.
  [[ -w "$ZSH_STARTERKIT" ]] || return 0

  LAST_EPOCH=0
  [ -f "${ZSH_STARTERKIT}"/.zsh-starterkit-update ] && source "${ZSH_STARTERKIT}"/.zsh-starterkit-update

  DAYS_SINCE_UPDATE="$(( ($EPOCHSECONDS - $LAST_EPOCH) / 60 / 60 / 24 ))"
  if [ $DAYS_SINCE_UPDATE -ge $UPDATE_ZSH_DAYS ]; then
    env sh "${ZSH_STARTERKIT}"/tools/update.sh

    echo "LAST_EPOCH=$EPOCHSECONDS" >! ${ZSH_STARTERKIT}/.zsh-starterkit-update
  fi
}
main

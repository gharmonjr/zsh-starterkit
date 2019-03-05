# meant to be sourced from .zshrc
# "pay no attention to the antigen behind the curtain"

zmodload zsh/datetime

# Just in case XDG isn't set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# these should already be set
export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
export ZSH_STARTERKIT="${ZSH_STARTERKIT:-$ZDOTDIR/.zsh-starterkit}"

# set reasonable defaults
USE_OMZ="${USE_OMZ:-true}"
OMZ_THEME="${OMZ_THEME:-refined}"
UPDATE_ZSH_DAYS="${UPDATE_ZSH_DAYS:-14}"


# --- antigen ------------------------------------------------------------------
# install antigen if needed
ADOTDIR="${ADOTDIR:-$XDG_DATA_HOME/antigen}"
if [[ ! -f "$ADOTDIR"/antigen.zsh ]]; then
  mkdir -p "$ADOTDIR"
  curl -L git.io/antigen > "$ADOTDIR"/antigen.zsh
fi

# tell antigen to monitor the following files for changes
typeset -a ANTIGEN_CHECK_FILES=("$ZDOTDIR/.zshrc" "$ZSH_STARTERKIT/zsh-starterkit.zsh" "$ADOTDIR/antigen.zsh")

# load antigen
source "$ADOTDIR"/antigen.zsh

# oh-my-zsh
[[ "$USE_OMZ" == "true" ]] && antigen use oh-my-zsh

# theme
[[ ! -z "$OMZ_THEME" ]] && antigen theme $OMZ_THEME

# load all of the plugins that were defined in zshrc
for plugin ($ZSH_PLUGINS); do
  antigen bundle $plugin
done

# make it so
antigen apply


# --- misc ---------------------------------------------------------------------
# helpful aliases
# also, undo/fix some things omz does
alias cd..='cd ..'
alias reload='source "${ZDOTDIR}"/.zshrc'
alias zshrc='${=EDITOR} "${ZDOTDIR}"/.zshrc'
alias ls='ls -GF'

# `ls` after `cd`
# https://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() {
  if [[ "$LS_AFTER_CD" == "true" ]]; then
    emulate -L zsh
    ls -F
  fi
}

# list the zsh themes available
function omz-themes() {
  find "$ADOTDIR"/bundles/robbyrussell/oh-my-zsh/themes -type f -name '*.zsh-theme' -exec basename {} .zsh-theme \; | sort -f | column
}

# list the zsh plugins available
function omz-plugins() {
  find "$ADOTDIR"/bundles/robbyrussell/oh-my-zsh/plugins -type d -exec basename {} \; | sort -f | column
}

# update all the plugins that antigen manages
function zsh-update() {
  env zsh -f "$ZSH_STARTERKIT"/tools/upgrade.sh
}

# Check for updates on initial load...
if [ "$DISABLE_AUTO_UPDATE" != "true" ]; then
  env zsh -f "$ZSH_STARTERKIT"/tools/check_for_update.sh
fi

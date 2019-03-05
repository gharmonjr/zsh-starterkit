# meant to be sourced from .zshrc
# "pay no attention to the antigen behind the curtain"

zmodload zsh/datetime

# set reasonable defaults
USE_OMZ="${USE_OMZ:-true}"
OMZ_THEME="${OMZ_THEME:-refined}"
UPDATE_ZSH_DAYS="${UPDATE_ZSH_DAYS:14}"


# --- antigen ------------------------------------------------------------------
# install antigen if needed
ADOTDIR="${ADOTDIR:-$XDG_DATA_HOME/antigen}"
if [[ ! -f "$ADOTDIR"/antigen.zsh ]]; then
  mkdir -p "$ADOTDIR"
  curl -L git.io/antigen > "$ADOTDIR"/antigen.zsh
fi

# tell antigen to monitor the following files for changes
typeset -a ANTIGEN_CHECK_FILES=("$ZDOTDIR/.zshrc" "$ZDOTDIR/zsh-starterkit.zsh" "$ADOTDIR/antigen.zsh")

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
alias ls='la -GF'

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
  antigen update
  echo "Plugins updated... Reload your shell to see changes."
}

# Check for updates on initial load...
if [ "$DISABLE_AUTO_UPDATE" != "true" ]; then
  LAST_EPOCH=0
  [ -f "{ZDOTDIR}"/.zsh-starterkit-update ] && source "{ZDOTDIR}"/.zsh-starterkit-update
  DAYS_SINCE_UPDATE="$(( ($EPOCHSECONDS - $LAST_EPOCH) / 60 / 60 / 24 ))"
  if [ $DAYS_SINCE_UPDATE -ge $UPDATE_ZSH_DAYS ];
    antigen update
    echo "LAST_EPOCH=$EPOCHSECONDS" >! ${ZDOTDIR}/.zsh-starterkit-update
  fi
fi

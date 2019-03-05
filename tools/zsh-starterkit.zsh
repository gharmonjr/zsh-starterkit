# this file contains the minimal scripting that needs to be sourced by .zshrc
# in order to use zsh-starterkit to load plugins and themes. The "magic" is
# really just leveraging the plugin manager antigen, but we hide that detail
# from .zshrc in the event that we want to swap to another package manager
# in the future.

# set reasonable defaults
USE_OMZ="${USE_OMZ:-true}"
OMZ_THEME="${OMZ_THEME:-refined}"

# install antigen if needed
ADOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/antigen"
if [[ ! -f "$ADOTDIR"/antigen.zsh ]]; then
  mkdir -p "$ADOTDIR"
  curl -L git.io/antigen > "$ADOTDIR"/antigen.zsh
fi

# tell antigen about the other files we use
# typeset -a ANTIGEN_CHECK_FILES=("$ZDOTDIR/.zshrc" "$ZDOTDIR/zshrc.zsh" "$ADOTDIR/antigen.zsh")

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

# done
antigen apply


# Check for updates on initial load...
if [ "$DISABLE_AUTO_UPDATE" != "true" ]; then
  zsh -f ${ZDOTDIR}/zsh-starterkit/tools/check_for_update.sh
fi

# helpful aliases
# also, undo/fix some things omz does
alias cd..='cd ..'
alias zsh-reload='source "${ZDOTDIR}"/.zshrc'
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
  source "${ZDOTDIR}"/.zshrc
}

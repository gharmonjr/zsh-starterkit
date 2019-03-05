#!/usr/bin/env sh

# handle setting base XDG directories first because .zshenv will assume they
# are there already
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

declare -a xdgdirs=("$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME")
for xdgdir in "${xdgdirs[@]}"; do
  [ -d "$xdgdir" ] || mkdir -p "$xdgdir"
done

# setup variables
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
export ADOTDIR="${ADOTDIR:-$XDG_DATA_HOME/antigen}"

main() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  BACKUPEXT="pre-zsh-starterkit-$(date +%Y%m%d-%H%M%S)"

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  if ! command -v zsh >/dev/null 2>&1; then
    printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
    exit
  fi

  # backup existing setup
  printf "${BLUE}Looking for existing zsh configs...${NORMAL}\n"
  declare -a zshfiles=(~/.zshrc ~/.zshenv)
  for f in "${zshfiles[@]}"; do
    if [ -f "$f" ] || [ -h "$f" ]; then
      printf "${YELLOW}Found $f.${NORMAL} ${GREEN}Backing up to $f.${BACKUPEXT}${NORMAL}\n";
      mv "$f" "${f}.${BACKUPEXT}"
    fi
  done
  declare -a zshdirs=(~/.config/zsh)
  for d in "${zshdirs[@]}"; do
    if [ -d "$d" ] || [ -h "$d" ]; then
      printf "${YELLOW}Found $d.${NORMAL} ${GREEN}Backing up to $d.${BACKUPEXT}${NORMAL}\n";
      mv "$d" "${d}.${BACKUPEXT}"
    fi
  done

  # pull in template files
  printf "${BLUE}Setting up optimal zsh structure in ${ZDOTDIR}${NORMAL}\n"
  declare -a templatefiles=(
    .zshenv
    .config/zsh/.zshrc
    .config/zsh/zsh-starterkit.zsh
  )
  mkdir -p "${ZDOTDIR}"
  for tfile in "${templatefiles[@]}"; do
    curl -L "https://raw.githubusercontent.com/mattmc3/zsh-starterkit/master/templates/${tfile}" > $HOME/$tfile
  done

  # make some handy extras
  touch "${ZDOTDIR}/.zshenv"
  zsh -c "cd ${ZDOTDIR}; ln -s .zshrc zshrc.zsh"
  zsh -c "cd ${ZDOTDIR}; ln -s .zshenv zshenv.zsh"

# If this user's login shell is not already "zsh", attempt to switch.
  TEST_CURRENT_SHELL=$(basename "$SHELL")
  if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
      printf "${BLUE}Time to change your default shell to zsh!${NORMAL}\n"
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    # Else, suggest the user do so manually.
    else
      printf "I can't change your shell automatically because this system does not have chsh.\n"
      printf "${BLUE}Please manually change your default shell to zsh!${NORMAL}\n"
    fi
  fi

  printf "${GREEN}"
  echo 'Woohoo! zsh-starterkit is now installed!'
  echo ''
  echo "Please look over the ${ZDOTDIR}/.zshrc file to select plugins, themes, and options."
  printf "${NORMAL}"
  env zsh -l
}

main

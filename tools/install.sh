#!/usr/bin/env sh

# handle setting base XDG directories first because .zshenv will assume they
# are there already
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# make sure the XDG files are there
for xdgdir in "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME"; do
  [ -d "$xdgdir" ] || mkdir -p "$xdgdir"
done

# setup variables
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
export ADOTDIR="${ADOTDIR:-$XDG_DATA_HOME/antigen}"
export ZSH_STARTERKIT="${ZSH_STARTERKIT:-$ZDOTDIR/.zsh-starterkit}"

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

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  if ! command -v zsh >/dev/null 2>&1; then
    printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
    exit
  fi

  # check if zsh-starterkit is already installed
  if [ -d "$ZSH_STARTERKIT" ]; then
    printf "${YELLOW}You already have zsh-starterkit installed.${NORMAL}\n"
    printf "You'll need to remove $ZSH_STARTERKIT if you want to re-install.\n"
    exit
  fi

  # backup existing setup
  BACKUPEXT="pre-zsh-starterkit-$(date +%Y%m%d-%H%M%S)"
  printf "${BLUE}Looking for existing zsh configs...${NORMAL}\n"
  for f in ~/.zshrc ~/.zshenv "${ZDOTDIR}/.zshrc"; do
    if [ -f "$f" ] || [ -h "$f" ]; then
      printf "${YELLOW}Found $f.${NORMAL} ${GREEN}Backing up to $f.${BACKUPEXT}${NORMAL}\n";
      mv "$f" "${f}.${BACKUPEXT}"
    fi
  done
  mkdir -p "$ZDOTDIR"

  # Prevent the cloned repository from having insecure permissions. Failing to
  # do so causes compinit() calls to fail with "command not found: compdef"
  # errors for users with insecure umasks (e.g., "002", allowing group
  # writability). Note that this will be ignored under Cygwin by default, as
  # Windows ACLs take precedence over umasks except for filesystems mounted with
  # option "noacl".
  umask g-w,o-w

  printf "${BLUE}Cloning zsh-starterkit...${NORMAL}\n"
  command -v git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  # The Windows (MSYS) Git is not compatible with normal use on cygwin
  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi
  env git clone --depth=1 https://github.com/mattmc3/zsh-starterkit.git "$ZSH_STARTERKIT" || {
    printf "Error: git clone of zsh-starterkit repo failed\n"
    exit 1
  }

  # install the config templates
  printf "${BLUE}Copying the zsh-starterkit template configs to ${ZDOTDIR}${NORMAL}\n"
  cp "$ZSH_STARTERKIT"/templates/.zshenv ~/.zshenv
  cp "$ZSH_STARTERKIT"/templates/.config/zsh/.zshrc "${ZDOTDIR}"/.zshrc
  touch "${ZDOTDIR}/.zshenv"
  [ ! -f "${ZDOTDIR}"/zshrc.zsh ] && ln -s "${ZDOTDIR}"/.zshrc "${ZDOTDIR}"/zshrc.zsh
  if [ -f ~/.zsh_history ]; then
    if [ ! -f "${ZDOTDIR}"/zsh_history ]; then
      mv ~/.zsh_history "${ZDOTDIR}"/zsh_history
    else
      mv ~/.zsh_history "${ZDOTDIR}/zsh_history.${BACKUPEXT}"
    fi
  fi

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

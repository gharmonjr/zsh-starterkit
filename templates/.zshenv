# handle setting base XDG directories
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
[ -f "${ZDOTDIR}/.zshenv" ] && source "${ZDOTDIR}/.zshenv"

# Config created by zsh-starterkit

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Uncomment if you prefer not to use oh-my-zsh, but be warned - this means that
# you also cannot use an OMZ_THEME and omz-based ZSH_PLUGINS
# USE_OMZ="false"

# Set name of the oh-my-zsh theme to load
# https://github.com/robbyrussell/oh-my-zsh/wiki/themes
OMZ_THEME="avit"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to enable listing directory contents after
# changing to a new directory
# export LS_AFTER_CD="true"

# Which plugins would you like to load?
ZSH_PLUGINS=(
  # better shell living via better zsh config!
  mattmc3/zsh-starterkit
  mattmc3/zsh-history

  # oh-my-zsh
  colored-man-pages
  common-aliases
  git
  z

  # zsh-users awesomesauce
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-syntax-highlighting

  # its handy to have a calculator in the terminal
  arzzen/calc.plugin.zsh

  # misc
  mafredri/zsh-async
)

# load the starter kit
source ${ZDOTDIR}/zsh-starterkit.zsh

# --- User configuration below -------------------------------------------------

# export MANPATH="/usr/local/man:$MANPATH"

# Setting the cdpath variable will let you treat subdirs of this list if they
# were directly avalailable as subdir of whatever directory you are already in.
# setopt auto_cd
# cdpath=(
#   $HOME/Documents
# )

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vi'
#   export VISUAL="vim"
# else
#   export EDITOR='nvim'
#   export VISUAL="code"
# fi

# Preferred command line pager
# export PAGER="less"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs, plugins
# and themes. For a full list of active aliases, run `alias`.
# alias zsh-config='${VISUAL} "${ZDOTDIR}"/.zshrc'

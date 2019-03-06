# zsh-starterkit

Are you looking for a great shell setup, but don't have hours or days to get
a great configuration? Do you want to introduce yourself or others to ZSH and
want a starterkit to help make that dirt simple? Do you want something you can
install now with amazing defaults that will grow with you if you decide to
customize over time? Then this project is for you.

_Better shell living through better ZSH defaults - that's **zsh-starterkit**._

![Terminal][terminal]

## What is it?

**zsh-starterkit** is a simple, single command ZSH installer to get new users
up and running fast with a well configured and themed Z shell. It combines
[oh-my-zsh], [antigen], and the fish-like plugins from [zsh-users] as well as
other goodies into a powerful out-of-the-box default ZSH configuration. While
geared towards quick setup and introducing new users to ZSH, it is flexible
enough for seasoned ZSH users too.

## Basic Installation

**zsh-starterkit** can be installed by running this `curl` command.

```shell
sh -c "$(curl -fsSL git.io/zsh-starterkit)"
```

## Details

### WHAT'S INCLUDED

The [oh-my-zsh] project is a great start for your ZSH config with themes and
excellent defaults, but it lacks some modern conveniences like autocomplete,
syntax checking, and an easy way to install and manage 3rd party plugins. This
project builds on the shoulders of giants with the goal of pulling together the
best possible out-of-the-box ZSH experience.

You get some of the best plugins:

- [oh-my-zsh] for a great ZSH base install, and themes, and other goodies
- [antigen] for an amazing plugin manager to let you extend your Z shell
  experience
- [zsh-autosuggestions] to suggest commands as you type
- [zsh-completions] for tab complete help for common shell commands
- [zsh-syntax-highlighting] to let you know when you have a typo
- [zsh-history-substring-search] to let you type a small part of a command and
  use the up arrow to cycle back in your command history for similar commands

 You get some of the best themes:

- [oh-my-zsh-themes] for a selection of more than 100 themes to choose from
- [pure theme][pure-theme] is an optional install, though omz includes an
  earlier version of it called "refined"
- [spaceship theme][spaceship-prompt] for when you decide you want to go to the
  next level. **NOTE:** Requires you to install some non-standard fonts. This
  one is waiting for when you're ready.

### TECHNICAL DETAILS

In a nutshell, this is what this project does to a system to get Z shell setup:

- Backs up any existing ZSH config files, (`~/.zshrc`, `~/.zshenv`)
- Sets `$ZDOTDIR` in a new `~/.zshenv` to use the `~/.config/zsh` directory
  instead of cluttering your $HOME
- Creates a new ZSH config in the `~/.config/zsh` directory
- Installs [antigen] as a plugin manager. You don't need to know antigen is
  used behind the scenes. **zsh-starterkit** gives you a configuration array in
  `$ZDOTDIR/.zshrc` to add or remove plugins. However, if you want to run
  [antigen] commands, they are still available.
- Attempts to change your default shell to ZSH
- Installs a set of default plugins including [oh-my-zsh] and goodies from
  [zsh-users]
- Installs this project (not a plugin!) in `$ZDOTDIR/.zsh-starterkit` and
  sources `zsh-starterkit.zsh` from `.zshrc`.
- All the magic is in `zsh-starterkit.zsh`. This is a thin, micro-framework
  that serves as mostly an [antigen] wraper.

Some other notables:

- **zsh-starterkit** is set to automatically update itself
  and your plugins by default, similar to [oh-my-zsh] and for the same reasons.
  This can be turned off. Just to be clear, the update is for **zsh-starterkit**
  itself, and will not reset your `.zshrc` config. That only happens on the
  initial install.
- **zsh-starterkit** respects the XDG spec and won't clutter up your home
  directory - you're welcome! If you have `$XDG_CONFIG_HOME` set to something
  other than `~/.config`, that path is respected.
- **zsh-starterkit** is a framework. It is **NOT** a plugin. Do not add
  mattmc3/zsh-starterkit to your $ZSH_PLUGINS. Bad things could happen.

### CUSTOMIZATION

- `$ZDOTDIR/.zshrc` : This file runs on every start of ZSH. **zsh-starterkit**
  gives you a great base configuration, but feel free to make changes here to
  suit your needs.
- Plugins : plugins are added via changes to `$ZDOTDIR/.zshrc`. Both [oh-my-zsh]
  and 3rd party plugins are supported.
- Themes : themes are set via changes to `$ZDOTDIR/.zshrc`
- `~/.zshenv` : Some shell environment variables are set here, but this file
  should generally be left alone unless you are familiar with ZSH.

### FAQ

_**Q:** How do I change my theme?_

**A:** Have a look in `$ZDOTDIR/.zshrc`. There you will find the theme
settings.

---

_**Q:** How do I know what themes are available?_

**A:** **zsh-starterkit** comes with a `omz-themes` function to view a list of
[oh-my-zsh themes][oh-my-zsh-themes].
Type `omz-themes` at your prompt.

---

_**Q:** Can I try out a theme to see if I like it??_

**A:** Sure! Use the `omz-themes` function and provide it with the name of a
theme to try temporarily. Try the half-life theme by typing this:
`omz-themes half-life`. If you decide you want to keep a theme, edit your
`$ZDOTDIR/.zshrc` file.

---

_**Q:** How do I know what plugins are available?_

**A:** **zsh-starterkit** comes with a `omz-plugins` function to view a list of
oh-my-zsh plugins. Type `omz-plugins` at your prompt.

---

_**Q:** How do I stop **zsh-starterkit** from updating itself?_

**A:** Have a look in `$ZDOTDIR/.zshrc`. There you will find settings to
change this.

---

_**Q:** How can I make my shell load faster?_

**A:** **zsh-starterkit** aims for a zippy shell with great defaults, but if you
add too many plugins, you may start to see slowdowns. Make sure you only load
the plugins you need.

---

_**Q:** How can I benchmark my shell load times?_

**A:** **zsh-starterkit** comes with a `benchmark` function.

---

_**Q:** What if I want to stop using **zsh-starterkit** or make my own setup?_

**A:** The .zshrc file is yours to edit as you please. Remove the
**zsh-starterkit** content from that file and you are free. Also, check out the
antigen] project to see how the magic happens.

---

_**Q:** Why did you choose [antigen] instead of
[[insert your favorite plugin manager here]][antibody]?_

**A:** Antigen is a great plugin manager with fantastic oh-my-zsh theme
integration.

---

_**Q:** Your terminal image shows a dark theme and my terminal is light.
How can I pick a dark theme?_

**A:** The dark/light terminal color isn't due to a theme. That's configured
in the terminal application itself and not something **zsh-starterkit** can
change. Try your terminal settings, or try another terminal like
[iTerm2][iterm2].


[antibody]: http://getantibody.github.io/
[antigen]: http://antigen.sharats.me/
[iterm2]: https://www.iterm2.com/
[oh-my-zsh-themes]: https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
[oh-my-zsh]: https://ohmyz.sh/
[pure-theme]: https://github.com/sindresorhus/pure
[spaceship-prompt]: https://github.com/denysdovhan/spaceship-prompt
[terminal]: https://raw.githubusercontent.com/mattmc3/zsh-starterkit/master/media/zsh-starterkit.png
[zsh-async]: https://github.com/mafredri/zsh-async
[zsh-autosuggestions]: https://github.com/zsh-users/zsh-autosuggestions
[zsh-completions]: https://github.com/zsh-users/zsh-completions
[zsh-history-substring-search]: https://github.com/zsh-users/zsh-history-substring-search
[zsh-starterkit]: https://github.com/mattmc3/zsh-starterkit
[zsh-syntax-highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting
[zsh-users]: https://github.com/zsh-users/

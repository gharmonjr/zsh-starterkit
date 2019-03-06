# zsh-starterkit

Are you looking for a great shell setup, but don't have hours or days to get
a great configuration? Do you want to introduce yourself or others to zsh and
want a starterkit to help make that dirt simple? Do you want something you can
install now with amazing defaults that will grow with you if you decide to
customize over time? Then this project is for you.

Better shell living via better zsh defaults - that's zsh-starterkit.

![Terminal][terminal]

## Basic Installation

zsh-starterkit can be installed by running this `curl` command.

```shell
sh -c "$(curl -fsSL git.io/zsh-starterkit)"
```

## Details

### SHELL CONFIG

zsh-starter kit won't clutter up your home directory - you're welcome! It uses
`~/.config/zsh` to store its configs. The exception to this is `~/.zshenv` which
is required to reside in your $HOME, and sets an environment variable to tell
zsh where to find the rest of its configuration.

If you have `$XDG_CONFIG_HOME` set to something other than `~/.config`, that
path is respected.

### WHAT'S INCLUDED

The [oh-my-zsh] project is great, but it lacks a good plugin manager and some
modern defaults. This project builds on the shoulders of giants with the goal
of pulling together the best possible out-of-the-box zsh experience.

You get some of the best plugins:

- [oh-my-zsh] for a great zsh base
- [antigen] for a great plugin manager
- [zsh-autosuggestions] to suggest commands you've typed before as you type
- [zsh-completions] for tab complete of common shell commands
- [zsh-syntax-highlighting] to let you know when you have a typo
- [zsh-history-substring-search] to let you type a small part of a command and
  use the up arrow to cycle back in your command history for similar commands

 You get some of the best themes:

- [oh-my-zsh-themes] for an amazing set of starter themes to choose from
- [pure theme][pure-theme] is an optional install, though omz includes an
  earlier version of it called "refined"
- [spaceship theme][spaceship-prompt] for when you decide you want to go to the
  next level. **NOTE:** Requires you to install some non-standard fonts. This
  one is waiting for when you're ready.

### CUSTOMIZATION

#### Files

- `~/.zshenv` : Some shell environment variables are set here, but this file
  should generally be left alone unless you are familiar with zsh.
- `~/.config/zsh/.zshrc` : This file runs on every start of zsh. zsh-starterkit
  gives you a great base configuration, but feel free to make changes here to
  suit your needs.
- `~/.config/zsh/.zsh-starterkit` : This is where this project will live.

#### Common questions

_Q: How do I change my theme?_

**A: Have a look in `~/.config/zsh/.zshrc`. There you will find the theme
settings**

_Q: How do I know what themes are available?_

**A: zsh-starterkit comes with a `omz-themes` function to view a list of
[oh-my-zsh themes][oh-my-zsh-themes].
Type `omz-themes` at your prompt.**

_Q: Can I try out a theme to see if I like it??_

**A: Sure! Use the `omz-themes` function and provide it with the name of a theme
to try temporarily. Try the half-life theme by typing this:
`omz-themes half-life`. If you decide you want to keep a theme, edit your
`$ZDOTDIR/.zshrc` file.**

_Q: How do I know what plugins are available?_

**A: zsh-starterkit comes with a `omz-plugins` function to view a list of
oh-my-zsh plugins.
Type `omz-plugins` at your prompt.**

_Q: How do I stop zsh-starterkit from updating itself?_

**A: Have a look in `~/.config/zsh/.zshrc`. There you will find settings to
change this**

_Q: How can I make my shell load faster?_

**A: zsh-starterkit aims for a zippy shell with great defaults, but if you add
too many plugins, you may start to see slowdowns. Make sure you only load
the plugins you need.**

_Q: How can I benchmark my shell load times?_

**A: zsh-starterkit comes with a `benchmark` function.**

_Q: What if I want to stop using zsh-starterkit or make my own setup?_

**A: The .zshrc file is yours to edit as you please. Remove the zsh-starterkit
content from that file and you are free. Also, check out the antigen] project
to see how the magic happens.**

_Q: Why did you choose [antigen] instead of
[[insert other plugin manager here]][antibody]?_

**A: Antigen is a great starter plugin manager with fantastic oh-my-zsh
integration.**


[antibody]: http://getantibody.github.io/
[antigen]: http://antigen.sharats.me/
[oh-my-zsh-themes]: https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[zsh-async]: https://github.com/mafredri/zsh-async
[zsh-autosuggestions]: https://github.com/zsh-users/zsh-autosuggestions
[zsh-completions]: https://github.com/zsh-users/zsh-completions
[zsh-history-substring-search]: https://github.com/zsh-users/zsh-history-substring-search
[zsh-starterkit]: https://github.com/mattmc3/zsh-starterkit
[zsh-syntax-highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting
[pure-theme]: https://github.com/sindresorhus/pure
[spaceship-prompt]: https://github.com/denysdovhan/spaceship-prompt
[terminal]: https://raw.githubusercontent.com/mattmc3/zsh-starterkit/master/media/zsh-starterkit.png

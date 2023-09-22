## My zsh configuration

*Not much to see here.*

This is a fairly minimal configuration without dependencies, tailored for my environment, zsh running on the builtin Terminal app on macOS.

In addition to the standard `.zshrc` configuration file, my `ZDOTDIR` includes:

- functions in the aptly-named `functions` directory are autoloaded from `.zshrc`
  - Don't assume I know what I'm doing. I'm a long-term shell user but a scripting noob. Some of these functions are misguided experiments.
- `null_config` directory and `zdir` function are part of a quick hack for toggling on & off my zsh configuration

A zsh configuration can be saved in any directory `ZDOTDIR` is set to in `~/.zshenv`. Mine is set to `~/.zsh.d`:


```
# file: ~/.zshenv
ZDOTDIR=~/.zsh.d
```

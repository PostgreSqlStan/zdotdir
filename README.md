## My zsh configuration

*Not much to see here.*

A zsh configuration can be saved in any directory `ZDOTDIR` is set to in `~/.zshenv`. Mine's saved in `~/.zsh.d`:

```zsh
# file: ~/.zshenv
ZDOTDIR=~/.zsh.d
```
This is a fairly minimal configuration without dependencies, tailored for my environment, zsh running on the builtin Terminal app on macOS.

In addition to the standard `.zshrc` configuration file, my `ZDOTDIR` includes:

- functions in the aptly-named `functions` directory are autoloaded from `.zshrc`
- `null_config` directory and `zdir` function are part of a quick hack for toggling on & off my zsh configuration


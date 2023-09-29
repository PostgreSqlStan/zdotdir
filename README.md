A fairly simple zsh configuration for macOS.

## Environment

- macOS 13, zsh 5
- Dependencies: [Starship prompt](https://starship.rs)

To use a zsh config directory, set the `ZDOTDIR` variable to the location from a `~/.zshenv` file.

For example, this directory is located at `~/.zsh.d` on my computer and `~/.zshenv` contains this line:

```
ZDOTDIR=~/.zsh.d
```

## Notes

The entire `functions` directory is autoloaded from `.zshrc`.

*I'm a noob at shell scripting. Don't assume anything here following best, or even sane, practices.*

### Starship prompt

*Currently test-driving the starship prompt. It's easy to install, fast, and easy to configure. I'll probably keep it.*

I used the recommended shell script (after reviewing it) to install the starship binary at `/usr/local/bin`:

```zsh
curl -sS https://starship.rs/install.sh | sh
```

These lines in `.zshrc` load the starship prompt and specify a custom config file location:

```zsh
export STARSHIP_CONFIG=${ZDOTDIR}/config/starship.toml
eval "$(starship init zsh)"
```

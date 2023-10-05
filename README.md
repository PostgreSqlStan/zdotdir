A fairly simple zsh configuration for macOS.

## Environment

- macOS 13, zsh 5
- Dependencies: [Starship prompt](https://starship.rs)

To use a zsh config directory, set the `ZDOTDIR` variable to the location from the configuration file `~/.zshenv`.

For example, the contents of this repo directory are stored in `~/.zsh.d` on my computer. The file `~/.zshenv` contains this line:

```
ZDOTDIR=~/.zsh.d
```

## Starship prompt

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

## Functions

*I'm a noob at shell scripting. Don't assume anything here following best, or even sane, practices.*

These functions are intended and might be appropriate for general use:

<!-- - `note` are `nnote` functions, both autoloaded from the `note` file, are  maintained in a separate, [note-functions](https://github.com/PostgreSqlStan/note-functions), repo. -->

`note` - display files(s) from configurable notes directory
`nnote` - add entry to default note
`bindlist` - list key bindings in a compact form
`manf` - (copied from somewhere) search man page for supplied text, e.g. `manf zshall CONDITIONAL`

These functions are tailored for my setup:

- `gfm` - render file to github-flavored-markdown
  - unfortunately, i still haven't figured out how to prevent substitutions for non-ASCII characters, even though the jekyll uses the same command (somewhere) to correctly render local previews of github pages.
- `start-blog` - start jekyll server for local github pages site
- `zdir` - toggle `ZDOTDIR=~/.zsh.d` (set in `.zshenv` for this config) on and off

### Loading functions

The `functions` directory is added to `fpath` and autoloaded from `.zshrc`:

```zsh
## FUNCTIONS                            (${ZDOTDIR}/functions)
my_functions=${ZDOTDIR:-$HOME}/functions
if [[ -z ${fpath[(r)$my_functions]} ]] ; then
    fpath=($my_functions $fpath)       # add to $fpath
    autoload -Uz ${my_functions}/*(:t) # autoload functions

    note                               # init note function
    compdef '_path_files -W "${NOTE_HOME:-${HOME}/notes/}" -g "^.*"' note
    compdef _gnu_generic pbnote

    bindlist                           # init bindlist function

fi
typeset -U fpath                       # remove dupe paths
```


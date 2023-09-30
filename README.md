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

### function: `note`

The `note` function displays notes stored in `~/notes`.

```zsh
% note example
This is an example note.
```

Called without arguments, `note` lists the files in `~/notes`.

The file containing the function also assigns the alias `n` to it:

```zsh
% n example
This is an example note.
```

Use the `-e` (edit) option to open a note in the program specified by the shell environment variable `$VISUAL` or `$EDITOR`.

```zsh
% n -e example
```

The default directory, `~/notes`, can be overriden with the variable `$NOTE_HOME`.


### function: `pbnote`

The `pbnote` function appends text to a note stored in `~/notes`.

The note name `pasted-yyyymmdd` (where yyyyymmdd represents the date) is used when none is specified.

There are several options which control what is inserted:

```
Options:
  -b --bullet                  insert bullet
  -d --datetime                add timestamp
  -h --help                    show this message
  -i --input                   prompt for description
  -n --no-newline              no empty line before entry
  -t --title <title>           entry title
  -v --paste                   insert clipboard (copied text)
```


# Connect

[![IRC][IRC Badge]][IRC]

###### [Usage](#usage) | [Documentation](#commands) | [Contributing](CONTRIBUTING)

> [Kakoune] extension to connect a program to the current client.

[![asciicast](https://asciinema.org/a/234300.svg)](https://asciinema.org/a/234300)

> “Connect is by far my most used plugin, nothing else even comes close.  
> I use this every single time I use Kakoune.”  
> — [@robertmeta] – [Connect – Render Markdown with Glow](https://discuss.kakoune.com/t/connect-render-markdown-with-glow/821/2 "2019-12-31")

## Installation

### [Pathogen]

``` kak
pathogen-infect /home/user/repositories/github.com/alexherbo2/connect.kak
```

**Optional** – To install globally:

``` sh
ln -s "$PWD/rc/commands/edit" ~/.local/bin/kak-connect
```

## Usage

You can use `:connect` to create a new terminal with `[e]dit`, `[b]uffer` and `VISUAL`, `EDITOR` connected to the client.

If you open a file using the shell command `edit` or an application using the default editor,
the file will be opened in the client from where `:connect` was executed.

You can also open a buffer by using the `buffer` command (or its alias `b`).
With no argument, `buffer` will list the available buffers.

If in your workflow you use [one session for all projects],
it can be useful to have Connect [installed globally](#installation).

**Example** – Shell configuration to default in [Othala] session:

``` sh
KAKOUNE_SESSION=othala
alias kak=kak-connect
```

### Examples

``` kak
:connect # Spawn a terminal
```

From that terminal:

``` sh
$ edit example.txt
```

To render Markdown for the current buffer with [Glow]:

``` sh
glow $(it) # Equivalent to `get val buffile`
```

You can also run the shell commands from Kakoune.

For example, [ranger] and [fzf][]⁺[ᶠᵈ][fd] integration can be:

``` kak
define-command ranger -params .. -file-completion %(connect ranger %arg(@))
```

``` kak
define-command fzf-files -params .. -file-completion %(connect edit $(fd --type file . %arg(@) | fzf))
```

``` kak
alias global fzf fzf-files
```

``` kak
define-command fzf-buffers %(connect buffer $(buffer | fzf))
```

To use with [Rofi]⁺[ᶠᵈ][fd]:

``` kak
define-command rofi-files -params .. -file-completion %(connect-shell edit $(fd --type file . %arg(@) | rofi -dmenu -p "'Select files'"))
```

``` kak
alias global rofi rofi-files
```

## Commands

- `connect-shell [program] [arguments]`: Run a shell with `[e]dit`, `[b]uffer` and `VISUAL`, `EDITOR` connected to the current client
- `connect-terminal [program] [arguments]`: Create a new terminal with `[e]dit`, `[b]uffer` and `VISUAL`, `EDITOR` connected to the current client

## Aliases

- `connect` → `connect-terminal`

## Shell environment

- `VISUAL=edit`
- `EDITOR=edit`
- `[e]dit [files]`: Open files in the client from where `:connect` was executed
- `[b]uffer [buffers]`: Get buffer list or open buffers in the client from where `:connect` was executed
- `it`: Get the current buffer (equivalent to `get val buffile`)
- `get {type} {name}`: Get a [value][Expansions] in the client from where `:connect` was executed
- `send {commands}`: Send commands in the client from where `:connect` was executed

## Options

- `connect_shell`: Shell program to be used as default entry-point (Default: `SHELL`)

## Credits

Thanks to [@occivink] :heart: for his work on the [:terminal] command to abstract the various windowing systems.

[Kakoune]: https://kakoune.org
[Expansions]: https://github.com/mawww/kakoune/blob/master/doc/pages/expansions.asciidoc
[IRC]: https://webchat.freenode.net/#kakoune
[IRC Badge]: https://img.shields.io/badge/IRC-%23kakoune-blue.svg
[Pathogen]: https://github.com/alexherbo2/pathogen.kak
[@occivink]: https://github.com/occivink
[@robertmeta]: https://github.com/robertmeta
[:terminal]: https://github.com/mawww/kakoune/pull/2617
[ranger]: https://ranger.github.io
[fzf]: https://github.com/junegunn/fzf
[fd]: https://github.com/sharkdp/fd
[Rofi]: https://github.com/davatorium/rofi
[Glow]: https://github.com/charmbracelet/glow
[One session for all projects]: https://discuss.kakoune.com/t/one-session-for-all-projects/473
[Othala]: https://stargate.fandom.com/wiki/Othala_(planet)

# Connect

[![IRC][IRC Badge]][IRC]

###### [Usage](#usage) | [Documentation](#commands) | [Contributing](CONTRIBUTING)

> [Kakoune] extension to connect a program to the current client.

[![asciicast](https://asciinema.org/a/234300.svg)](https://asciinema.org/a/234300)

## Installation

### [Pathogen]

``` kak
pathogen-infect /home/user/repositories/github.com/alexherbo2/connect.kak
```

## Usage

You can use `:connect` to create a new terminal with `[e]dit`, `[b]uffer` and `VISUAL`, `EDITOR` connected to the client.

If you open a file using the shell command `edit` or an application using the default editor,
the file will be opened in the client from where `:connect` was executed.

You can also open a buffer by using the `buffer` command (or its alias `b`).
With no argument, `buffer` will list the available buffers.

### Examples

``` kak
:connect # Spawn a terminal
```

From that terminal:

``` sh
$ edit example.txt
```

You can also run the shell commands from Kakoune.

For example, [ranger] and [fzf][]⁺[ᶠᵈ][fd] integration can be:

``` kak
define-command ranger -params .. -file-completion %(connect ranger %arg(@))
```

``` kak
define-command fzf-files -params .. -file-completion %(connect edit $(fd . %arg(@) | fzf))
```

``` kak
alias global fzf fzf-files
```

``` kak
define-command fzf-buffers %(connect buffer $(buffer | fzf))
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
- `get {type} {name}`: Get a [value][Expansions] in the client from where `:connect` was executed

## Options

- `connect_shell`: Shell program to be used as default entry-point (Default: `SHELL`)

## Credits

Thanks to [@occivink] :heart: for his work on the [:terminal] command to abstract the various windowing systems.

[Kakoune]: https://kakoune.org
[Expansions]: https://github.com/mawww/kakoune/blob/master/doc/pages/expansions.asciidoc
[IRC]: https://webchat.freenode.net?channels=kakoune
[IRC Badge]: https://img.shields.io/badge/IRC-%23kakoune-blue.svg
[Pathogen]: https://github.com/alexherbo2/pathogen.kak
[@occivink]: https://github.com/occivink
[:terminal]: https://github.com/mawww/kakoune/pull/2617
[ranger]: https://ranger.github.io
[fzf]: https://github.com/junegunn/fzf
[fd]: https://github.com/sharkdp/fd

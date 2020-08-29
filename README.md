# connect.kak

Leverage the client-server architecture of [Kakoune] to connect programs to clients.

[Kakoune]: https://kakoune.org

[![connect.kak](https://img.youtube.com/vi_webp/jca2N-cE_mM/maxresdefault.webp)](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3 "YouTube – connect.kak")
[![YouTube Play Button](https://www.iconfinder.com/icons/317714/download/png/16)](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3) · [connect.kak](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3)

The objective of connect.kak is
to synchronize external applications with Kakoune clients easily.
A typical use case is opening a file browser and
having it open the files in the Kakoune client.
Another very typical use case is connecting a terminal.

connect.kak provides basic [commands] to interact with the connected client interactively
or to write your own scripts
(check [`:batch`], which is an integration crafted from the rest of the commands)
as well as a set of officially supported [modules] (Kakoune commands to programs).

[`:batch`]: https://github.com/alexherbo2/batch.kak/blob/master/rc/connect/commands/:batch

## Dependencies

- [prelude.kak]

[prelude.kak]: https://github.com/alexherbo2/prelude.kak

### Optional integrations

- [explore.kak]
- [terminal-mode.kak]
- [yank-ring.kak]
- [batch.kak]

[explore.kak]: https://github.com/alexherbo2/explore.kak
[terminal-mode.kak]: https://github.com/alexherbo2/terminal-mode.kak
[yank-ring.kak]: https://github.com/alexherbo2/yank-ring.kak
[batch.kak]: https://github.com/alexherbo2/batch.kak

## Installation

Run the following in your terminal:

``` sh
make install
```

Add [`rc`](rc) to your autoload or source [`connect.kak`](rc/connect.kak) and its [modules] manually.

## Usage examples

**>**, **$** and **&** are [Kakoune commands][Documentation].

The colon (**:**) prefixes all [connect.kak shell commands][Commands],
which usually have an [alias][Aliases] of a single key – `:[e]dit` and `:[o]pen` for example.

### Example 1

**Kakoune** – Launch a new connected terminal:

``` kak
>
```

**Terminal** – Open all `.txt` files in the connected client:

``` sh
:e *.txt
```

### Example 2

**Terminal** – Open all `.txt` files in a new client:

``` sh
:o *.txt
```

### Example 3

**Kakoune** – Launch a connected [Dolphin] instance:

``` kak
$ dolphin
```

[Dolphin]: https://dolphin.kde.org

### Example 4

**Kakoune** – Use [Dolphin’s module] to do the same as example 3:

[dolphin’s module]: rc/modules/dolphin.kak

``` kak
require-module connect-dolphin

dolphin
```

### Example 5

**Terminal** – Render with [Glow] the current buffer:

``` sh
glow `:it`
```

[Glow]: https://github.com/charmbracelet/glow

### Example 6

**Terminal** – Run a shell connected to an arbitrary session from your terminal:

``` sh
kak-shell
```

**Illustration**

```
$ kak-shell
Kakoune sessions:
1 kanto
2 johto
+ create new session
Kakoune session: 1█
@kanto $ :a█
```

### Example 7

**Kakoune** – Detach from the client and generate a file to connect to the session.

``` kak
&
```

**In the terminal that spawned the client**

```
$ sh connect.sh
@kanto $ █
```

## Configuration

## Example configuration

A typical workflow is mapping `<c-q>` to `quit!` and use the alias `:a`/`a` to
reattach back and forth inside a `kak-shell` (or any connected terminal).

``` kak
# Modules
require-module connect-fzf

# Explore files and buffers with fzf
alias global explore-files fzf-files
alias global explore-buffers fzf-buffers

# Terminal settings
map global normal -docstring 'Terminal' <c-w> ': enter-user-mode terminal<ret>'

# Create a new window
map global normal <c-t> ': connect-terminal<ret>'
map global normal <c-n> ': connect-shell alacritty<ret>'

# Quit
map global normal <c-q> ': quit!<ret>'

# Yank ring
map global normal Y ': yank-ring<ret>'
```

### Custom connect commands

You can also define your own connect [commands] and [aliases] and
locate them in a path set in the `connect_paths` option.
By default, it is set to your
`$XDG_CONFIG_HOME/kak/connect/commands` and `$XDG_CONFIG_HOME/kak/connect/aliases` folders.

### Custom environment

By setting the `connect_environment` option, you can specify commands that
are evaluated before launching/running the programs.  This might be useful if you want to
change or export environment variables.

``` kak
set-option global connect_environment %{
  SHELL=elvish
  export GIT_EDITOR=kak
}
```

### Custom prompt

You can modify your shell [prompt][Prompt customization]
to notify you whenever you are connected to a session.

``` bash
PS1='$(~/.local/share/kak/connect/prompt) $ '
```

[Prompt customization]: https://wiki.archlinux.org/index.php/Bash/Prompt_customization

## Documentation

[Documentation]: #documentation

- `>` ⇒ Open a new terminal
- `$` ⇒ Execute commands in a shell
- `&` ⇒ Write an attachable program to `connect.sh` and detach the client

<!---->

- [Commands]
- [Aliases]
- [Modules]
- [Extra documentation for users][user-extra-documentation]
- [Recipes]
- [Integration with other tools][integration]
 
[Commands]: rc/connect/commands
[Aliases]: rc/connect/aliases
[Modules]: rc/modules
[user-extra-documentation]: docs/user-extra-documentation.md
[recipes]: docs/recipes.md
[integration]: docs/integration.md

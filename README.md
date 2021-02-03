# connect.kak

###### [Installation] | [Usage] | [Configuration] | [Documentation] | [FAQ]

[Installation]: #installation
[Usage]: #usage
[Configuration]: #configuration
[Documentation]: docs
[FAQ]: docs/faq.md

Leverage the client-server architecture of [Kakoune] to connect programs to clients.

[Kakoune]: https://kakoune.org

[![connect.kak](https://img.youtube.com/vi_webp/jca2N-cE_mM/maxresdefault.webp)](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3 "YouTube – connect.kak")
[![YouTube Play Button](https://www.iconfinder.com/icons/317714/download/png/16)](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3) · [connect.kak](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3)

The objective of connect.kak is to synchronize external applications with Kakoune clients easily.
A typical use case is opening a file browser and having it open the files in the Kakoune client.
Another very typical use case is connecting a terminal.

connect.kak provides basic [commands] to interact with the connected client interactively or to write your own scripts
(check [`:batch`], which is an integration crafted from the rest of the commands)
as well as a set of officially supported [modules] (Kakoune commands to programs).

[`:batch`]: https://github.com/alexherbo2/batch.kak/blob/master/rc/connect/commands/:batch

## Dependencies

- [prelude.kak]

[prelude.kak]: https://github.com/alexherbo2/prelude.kak

### Optional integrations

- [alacritty.kak]
- [explore.kak]
- [terminal-mode.kak]
- [yank-ring.kak]
- [batch.kak]

[alacritty.kak]: https://github.com/alexherbo2/alacritty.kak
[explore.kak]: https://github.com/alexherbo2/explore.kak
[terminal-mode.kak]: https://github.com/alexherbo2/terminal-mode.kak
[yank-ring.kak]: https://github.com/alexherbo2/yank-ring.kak
[batch.kak]: https://github.com/alexherbo2/batch.kak

## Installation

Run the following in your terminal:

``` sh
make install
```

It will install [`kak-shell`] and [`kak-desktop`] to your `~/.local/bin` directory
and create a [`kakoune-connect.desktop`] desktop entry.

[`kak-shell`]: bin/kak-shell
[`kak-desktop`]: bin/kak-desktop
[`kakoune-connect.desktop`]: share/applications/kakoune-connect.desktop

If you want to use Kakoune as your default editor, for example when opening files in [Dolphin],
open `$XDG_CONFIG_HOME/mimeapps.list` and add the following MIME type association:

[Dolphin]: https://dolphin.kde.org

`~/.config/mimeapps.list`

```
[Default Applications]
text/plain=kakoune-connect.desktop
text/xml=kakoune-connect.desktop
```

Add more entries to your liking.

---

Add [`connect.kak`](rc/connect.kak) and its [modules] to your autoload or source them manually.

``` kak
require-module connect
```

## Usage

**>**, **+**, **@**, **$** and **&** are [Kakoune commands][Documentation].

The **:** prefixes all [connect.kak shell commands][Commands],
and usually have an [alias][Aliases] on a single key – `:[e]dit` and `:[o]pen` for example.

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

**Kakoune** – Same, but with a dedicated [`dolphin`][`dolphin.kak`] command:

``` kak
require-module connect-dolphin

dolphin
```

[`dolphin.kak`]: rc/connect/modules/dolphin/dolphin.kak

As you can notice by its [content][`dolphin.kak`], the module is fairly simple and seamless.
We just provide the nicety to have a `dolphin` command from Kakoune.

### Example 5

**Terminal** – Render with [Glow] the current file or buffer content:

``` sh
glow `:it`
```

``` sh
:cat | glow -
```

The latter outputs the buffer content, which is useful when the file is not saved.

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

**Kakoune** – Detach from the client and generate a file to connect to the session:

``` kak
&
```

In the terminal that spawned the client:

```
$ sh connect.sh
@kanto $ █
```

---

Learn more about the [commands] and [aliases] in the [documentation].

## Configuration

A typical workflow is mapping <kbd>Control</kbd> + <kbd>q</kbd> to `quit` and
use the alias `:a` or `a` to reattach back and forth inside a `kak-shell`
(or any connected terminal).

### Example configuration

``` kak
# Modules
require-module connect-fzf

# Windowing
hook global ModuleLoaded x11 %{
  alias global terminal alacritty-terminal
  alias global popup alacritty-terminal-popup

  # If your terminal does not have popups, fall back to x11-terminal.
  # alias global popup x11-terminal
}

# Explore files and buffers with fzf
alias global explore-files fzf-files
alias global explore-buffers fzf-buffers

# Terminal settings
map global normal -docstring 'Terminal' <c-w> ': enter-user-mode terminal<ret>'

# Create a new window
map global normal <c-t> ': connect-terminal<ret>'
map global normal <c-n> ': connect-shell alacritty<ret>'

# Quit
map global normal <c-q> ': quit<ret>'

# Yank ring
map global normal Y ': yank-ring<ret>'
```

### Custom connect commands

You can also define your own connect [commands] and [aliases] and locate them in a path set in the `connect_paths` option.
By default, it is set to your `%val{config}/connect/commands` and `%val{config}/connect/aliases` folders.

Take a look at the [default modules][Modules].
You can use them as a skeleton to your connect commands.

### Custom environment

By setting the `connect_environment` option, you can specify shell commands to run before running your program.
This might be useful, if you want to change or export environment variables.

``` kak
set-option global connect_environment %{
  export SHELL=elvish
  export GIT_EDITOR=kak
}
```

### Custom prompt

You can modify your shell [prompt][Prompt customization] to notify you whenever you are connected to a session.

[Prompt customization]: https://wiki.archlinux.org/index.php/Bash/Prompt_customization

**Example** – for Bash:

``` bash
PS1='$(test "$IN_KAKOUNE_CONNECT" && printf 🐈)$ '
```

**Example** – with [Starship]:

`~/.config/starship.toml`

``` toml
[custom.kakoune_connect_client]
symbol = '🐈 '
command = 'printf "${KAKOUNE_CLIENT}@${KAKOUNE_SESSION}"'
when = 'test "$IN_KAKOUNE_CONNECT" = 1 -a -n "$KAKOUNE_SESSION" -a -n "$KAKOUNE_CLIENT"'
shell = ['dash']
description = 'Indicates that the current shell is connected to a Kakoune client'
style = 'green italic'

[custom.kakoune_connect_session]
symbol = '🐈 '
command = 'printf "${KAKOUNE_SESSION}"'
when = 'test "$IN_KAKOUNE_CONNECT" = 1 -a -n "$KAKOUNE_SESSION" -a -z "$KAKOUNE_CLIENT"'
shell = ['dash']
description = 'Indicates that the current shell is connected to a Kakoune session'
style = 'green italic'
```

[Starship]: https://starship.rs

Available variables are:

- `IN_KAKOUNE_CONNECT` (_1_ when _true_)
- `KAKOUNE_SESSION`
- `KAKOUNE_CLIENT`

[Commands]: rc/connect/commands
[Aliases]: rc/connect/aliases
[Modules]: rc/connect/modules

## Similar projects

- [kakoune-remote-control]

[kakoune-remote-control]: https://github.com/danr/kakoune-remote-control

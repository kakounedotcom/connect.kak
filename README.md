# connect.kak

Leverage the client-server architecture of [Kakoune] to connect programs to clients.

[Kakoune]: https://kakoune.org

[![connect.kak](https://img.youtube.com/vi_webp/jca2N-cE_mM/maxresdefault.webp)](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3 "YouTube – connect.kak")
[![YouTube Play Button](https://www.iconfinder.com/icons/317714/download/png/16)](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3) · [connect.kak](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3)

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

Add [`rc`](rc) to your autoload or source [`connect.kak`](rc/connect.kak) and its [modules](rc/modules) manually.

## Usage

**>**, **$** and **&** are [Kakoune commands][Documentation].

The **:** prefixes all [connect.kak shell commands][Commands],
and usually have an [alias][Aliases] on a single key – `:[e]dit` and `:[o]pen` for example.

### Example 1

**Kakoune** – Open a new terminal:

``` kak
>
```

**Terminal** – Open all `.txt` files:

``` sh
:e *.txt
```

### Example 2

**Terminal** – Same in a new client:

``` sh
:o *.txt
```

### Example 3

**Kakoune** – Open [Dolphin]:

``` kak
$ dolphin
```

[Dolphin]: https://dolphin.kde.org

### Example 4

**Kakoune** – Same with [modules]:

``` kak
require-module connect-dolphin

dolphin
```

### Example 5

**Terminal** – Manage sessions:

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

## Example 6

**Terminal** – [Glow] the current buffer:

``` sh
glow `:it`
```

[Glow]: https://github.com/charmbracelet/glow

---

Learn more about the [commands] and [aliases] in the [documentation].

## Configuration

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

### Turn Kakoune into an IDE

``` kak
define-command ide -params 0..1 -docstring 'ide [session-name]: Turn Kakoune into an IDE' %{
  # Session name
  try %{
    rename-session %arg{1}
  }

  # Main client
  rename-client main
  set-option global jumpclient main

  # Tools client
  new %{
    rename-client tools
    set-option global toolsclient tools
  }

  # Docs client
  new %{
    rename-client docs
    set-option global docsclient docs
  }

  # Project drawer
  dolphin

  # Git
  > lazygit

  # Terminal
  >
}
```

### Custom environment

By setting the `connect_environment` option, you can specify commands that
are run before the shell is executed.  This might be useful, if you want to
change or export environment variables.

``` kak
set-option global connect_environment %{
  SHELL=elvish
  export GIT_EDITOR=kak
}
```

### Custom connect commands

You can also define your own connect commands by setting the `connect_paths` option.
By default, it is set to your `$XDG_CONFIG_HOME/kak/connect/commands` and `$XDG_CONFIG_HOME/kak/connect/aliases`.
See [commands] and [aliases] for examples.

### Custom prompt

``` bash
PS1='$(~/.local/share/kak/connect/prompt) $ '
```

## Documentation

[Documentation]: #documentation

- `>` ⇒ Open a new terminal
- `$` ⇒ Execute commands in a shell
- `&` ⇒ Write an attachable program to `connect.sh` and detach the client

<!---->

- [Commands]
- [Aliases]
- [Modules]

[Commands]: rc/connect/commands
[Aliases]: rc/connect/aliases
[Modules]: rc/modules

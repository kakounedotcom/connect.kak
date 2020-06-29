# connect.kak

###### [Installation](#installation) | [Usage](#usage) | [Configuration](#configuration) | [Documentation](#documentation) | [Contributing](CONTRIBUTING)

Connect a program to [Kakoune] clients.

[Kakoune]: https://kakoune.org

[![connect.kak](https://img.youtube.com/vi_webp/jca2N-cE_mM/maxresdefault.webp)](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3 "YouTube – connect.kak")
[![YouTube Play Button](https://www.iconfinder.com/icons/317714/download/png/16)](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3) · [connect.kak](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3)

## Dependencies

- [prelude.kak]
- [terminal-mode.kak]

[prelude.kak]: https://github.com/alexherbo2/prelude.kak
[terminal-mode.kak]: https://github.com/alexherbo2/terminal-mode.kak

### Suggestion

- [explore.kak]
- [yank-ring.kak]

[explore.kak]: https://github.com/alexherbo2/explore.kak
[yank-ring.kak]: https://github.com/alexherbo2/yank-ring.kak

## Installation

Add [`rc`](rc) to your autoload or source [`connect.kak`](rc/connect.kak) and its [modules](rc/modules) manually.

### Start an interactive shell

Add [`kak-shell`] to your path.

[`kak-shell`]: bin/kak-shell

### Add to desktop

1. Copy [`kakoune-connect.desktop`] to `$XDG_DATA_HOME/applications`.
2. Copy [Kakoune’s logo] to `$XDG_DATA_HOME/icons/hicolor/scalable/apps/kakoune.svg`.
3. Add [`kak-desktop`] to your path.
4. Open `$XDG_CONFIG_HOME/mimeapps.list` and add the following MIME type association:

```
[Default Applications]
text/plain=kakoune-connect.desktop
text/xml=kakoune-connect.desktop
```

Add more entries to your liking.

[`kakoune-connect.desktop`]: share/applications/kakoune-connect.desktop
[`kak-desktop`]: bin/kak-desktop
[Kakoune’s logo]: https://github.com/mawww/kakoune/blob/master/doc/kakoune_logo.svg

## Usage

Connect a terminal with `:connect-terminal`.
Open files with the `edit` shell command or your favorite program;
buffers with the `buffer` shell command…

You can start an interactive shell (or a program) connected to a session, in the same way [nix-shell] does.
By default, the connections occur in the same terminal window (try `:fzf-files` or `:fzf-buffers` to see);
you can change the terminal settings with `,tcr` (for _user mode_ – _terminal_ – _connect_ – _reset_),
which resets the detach option and prompts you to choose a windowing system ([X11], [tmux], etc.).
You can change it at your will with `,t`.
The [terminal-mode.kak] interface is similar to [i3’s split commands].

**Illustration**

```
$ kak-shell
Kakoune sessions:
kanto
johto
+ create new session
Kakoune session: kanto█
(kak-shell) $ edit
:fzf-files
```

[nix-shell]: https://nixos.org/nix/manual#sec-nix-shell
[X11]: https://x.org
[tmux]: https://github.com/tmux/tmux
[i3’s split commands]: https://i3wm.org/docs/userguide.html#OrientationSplit

## Configuration

``` kak
# Modules
require-module connect-fzf

# Explore files and buffers with fzf
alias global explore-files fzf-files
alias global explore-buffers fzf-buffers

# Terminal settings
map global user t ': enter-user-mode terminal<ret>' -docstring 'Terminal'

# Create a new window
map global normal <c-n> ': new<ret>'
map global normal <c-t> ': connect-terminal<ret>'

# Quit
map global normal <c-q> ': quit<ret>'

# Yank ring
map global normal Y ': yank-ring<ret>'
```

By setting the option `connect_environment`, you can specify commands that
are run before the shell is executed.  This might be useful, if you want to
change or export environment variables:

``` kak
set-option global connect_environment %{
  GIT_EDITOR='kak -c $KAKOUNE_SESSION'
  export LYEDITOR='edit %(file)s +%(line)s:%(column)s'
}
```

## Documentation

### Kakoune

Defined in [`connect.kak`](rc/connect.kak).

#### Commands

- `connect-terminal` (alias: `t`): Connect a terminal.
- `connect-shell` (alias: `T`): Connect a shell.
- `connect-detach` (alias: `d`): Write the given shell command to your connect data path and detach the client.

#### Options

- `connect_attach`: Attach to terminal.  Default is `no`.
- `connect_data_path`: Path to connect data.  Default is `$XDG_DATA_HOME/kak/connect` or `~/.local/share/kak/connect`.

#### Modules

Defined in [`modules`](rc/modules).

- `connect-dmenu`
- `connect-dolphin`
- `connect-fzf`
- `connect-lf`
- `connect-rofi`
- `connect-wofi`

### Shell

#### Commands

Defined in [`commands`](rc/paths/commands) and [`aliases`](rc/paths/aliases).

- `edit` (alias: `e`): Open files.
- `buffer` (alias: `b`): Open buffers.  With no argument, list buffers instead.
- `attach` (alias: `a`): Attach a command ran from Kakoune with `:connect-detach`.
- `it`: Get the current buffer.
- `send`: Send a command.
- `get`: Get a property.

#### Environment variables

Defined in [`env`](rc/env).

- `KAKOUNE_SESSION`: Kakoune session.
- `KAKOUNE_CLIENT`: Kakoune client.
- `KAKOUNE_CONNECT_SCRIPT`: Path to connect script, used by `:connect-detach` for writing shell commands.
- `KAKOUNE_CONNECT_ATTACH`: Whether to attach to terminal.
- `EDITOR`: Editor to be used.  Default is `edit`.
- `VISUAL`: Visual editor to be used.  Default is `edit`.
- `GIT_EDITOR`: [Git] editor to be used.  Default is `edit -wait`.

[Git]: https://git-scm.com

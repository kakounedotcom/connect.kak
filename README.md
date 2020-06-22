# connect.kak

###### [Installation](#installation) | [Usage](#usage) | [Configuration](#configuration) | [Documentation](#documentation) | [Resources](#resources) | [Contributing](CONTRIBUTING)

Connect a program to [Kakoune] clients.

[![connect.kak](https://img.youtube.com/vi_webp/jca2N-cE_mM/maxresdefault.webp)](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3 "YouTube – connect.kak")
[![YouTube Play Button](https://www.iconfinder.com/icons/317714/download/png/16)](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3) · [connect.kak](https://youtube.com/playlist?list=PLdr-HcjEDx_k-Y_9uSV0YAUCNHzqHjmz3)

## Dependencies

- [prelude.kak]
- [terminal-mode.kak]

[prelude.kak]: https://github.com/alexherbo2/prelude.kak
[terminal-mode.kak]: https://github.com/alexherbo2/terminal-mode.kak

## Installation

Add [`rc`] to your autoload or source [`connect.kak`] and its [modules] manually.

### Add to desktop

1. Copy [`kakoune-connect.desktop`] to `$XDG_DATA_HOME/applications`.
2. Copy [Kakoune’s logo] to `$XDG_DATA_HOME/icons/hicolor/scalable/apps/kakoune.svg`.
3. Add [`kak-connect`] to your path.
4. Open `$XDG_CONFIG_HOME/mimeapps.list` and add the following MIME type association:

```
[Default Applications]
text/plain=kakoune-connect.desktop
text/xml=kakoune-connect.desktop
```

Add more entries to your liking.

[`kakoune-connect.desktop`]: share/applications/kakoune-connect.desktop
[`kak-connect`]: bin/kak-connect
[Kakoune’s logo]: https://github.com/mawww/kakoune/blob/master/doc/kakoune_logo.svg

## Usage

Connect a terminal with [`:connect-terminal`].  Open files with [`edit`] or your
favorite program; buffers with the [`buffer`] command…

**Tip**: You can connect to your current terminal (open in the same terminal window) – in a similar way to [vim-vinegar] – with the [`kak-connect`] shell command.
Try: `$ kak-connect` → `:connect-terminal` → `$ edit`.

[vim-vinegar]: https://github.com/tpope/vim-vinegar

**Example** – Open a connected shell and reattach with [`edit`]:

```
$ kak-connect → :connect-terminal → $ edit → Quit to return to your shell
```

**Tip**: Map <kbd>Control</kbd> + <kbd>q</kbd> to quit.

**Example** – Open a connected shell and [lf]:

```
$ kak-connect → :connect-terminal → $ lf → Open a file → Quit to return to lf
```

**Example** – Open [lf] connected to the Kakoune session:

```
$ kak-connect → :lf
```

If you loaded the [modules], [`:fzf-files`] and [`:fzf-buffers`] commands are
also available.  connect.kak currently has batteries for [fzf], [dmenu], [Rofi],
[Wofi], [lf] and [Dolphin].

**Note**: [`fzf`] and [`dmenu`]-like modules require [fd] for listing files.

**Example** – **Kakoune** – Connect a terminal with [`:connect-terminal`]:

``` kak
connect-terminal
```

Or simply [`:t`].

If you are in [tmux], you might want at some point to request a terminal in a
new window.  It can be done with the [`:connect-shell`] command.

**Example** – **Kakoune** – Connect [Alacritty] with [`:connect-shell`]:

``` kak
connect-shell alacritty
```

Or simply [`:T`] followed by `alacritty`.

**Example** – **Terminal** – Send a file to the client with [`edit`] or its alias [`e`]:

``` sh
edit file.txt
```

**Example** – **Terminal** – Open multiple files:

``` sh
e *.txt
```

**Note**: If you have [explore.kak] installed and configured the file explorer,
you can also explore directories with the `:e[dit]` command.

**Example** – **Terminal** – Open files with [lf]:

``` sh
lf
```

**Note**: Not to be confused with [`:lf`].  connect.kak pairs with [modules]
that you can load with the [`:require-module`] command.

Also works great with GUI programs.

**Example** – **Kakoune** – Open files with [Dolphin]:

``` kak
connect-shell dolphin
```

Or simply [`:dolphin`] if you have loaded the module.

**Example** – **Kakoune** – Open selected files with [dmenu]:

``` kak
connect-shell %{
  edit $(fd --type file | dmenu)
}
```

**Example** – **Terminal** – List all buffers with [`buffer`] or its alias [`b`]:

``` sh
buffer
```

**Example** – **Terminal** – Open buffers with [fzf]:

``` sh
b $(b | fzf)
```

**Note**: If you have [explore.kak] installed and configured to use [`:fzf-buffers`],
you can also explore buffers with the `:b[uffer]` command.

**Example** – **Terminal** – [`git-add`] the current buffer:

``` sh
git add $(it)
```

**Example** – **Terminal** – Render Markdown with [Glow]:

``` sh
glow $(it)
```

**Example** – **Terminal** – Load a previous yank with [fzf], by sending the result to [`:yank-ring-load-from-file`]:

``` sh
send yank-ring-load-from-file $(find $(get %opt{yank_ring_path}) -type f | sort -n -r | fzf --preview 'cat {}')
```

**Note**: If you have [yank-ring.kak] installed, you can simply call [`:yank-ring`].

## Configuration

``` kak
require-module connect-fzf
require-module connect-dmenu
require-module connect-rofi
require-module connect-wofi
require-module connect-lf
require-module connect-dolphin

# Create a new window
map global normal <c-n> ': new<ret>'
map global normal <c-t> ': connect-terminal<ret>'
map global normal <c-w> ': connect-shell alacritty<ret>'

# Quit
map global normal <c-q> ': quit<ret>'
```

By setting the option `connect_environment` you can specify commands that
are run before the shell is executed. This might be useful, if you want to
change or export environment variables:

``` kak
set-option global connect_environment %{
  GIT_EDITOR='kak -c $KAKOUNE_SESSION'
  export LYEDITOR='edit %(file)s +%(line)s:%(column)s'
}
```

## Documentation

### Kakoune commands

- [`:connect-terminal`] | [`:t`]
- [`:connect-shell`] | [`:T`]
- [`:connect-detach`] | [`:d`]
- [`fzf`]
  - [`:fzf-files`] | [`:fzf`]
  - [`:fzf-buffers`]
- [`dmenu`]
  - [`:dmenu-files`] | [`:dmenu`]
  - [`:dmenu-buffers`]
- [`rofi`]
  - [`:rofi-files`] | [`:rofi`]
  - [`:rofi-buffers`]
- [`wofi`]
  - [`:wofi-files`] | [`:wofi`]
  - [`:wofi-buffers`]
- [`lf`]
  - [`:lf`]
- [`dolphin`]
  - [`:dolphin`]

[`rc`]: rc
[modules]: rc/modules

[`connect.kak`]: rc/connect.kak
[`:connect-terminal`]: rc/connect.kak
[`:t`]: rc/connect.kak
[`:connect-shell`]: rc/connect.kak
[`:T`]: rc/connect.kak
[`:connect-detach`]: rc/connect.kak
[`:d`]: rc/connect.kak

[`fzf`]: rc/modules/fzf.kak
[`:fzf-files`]: rc/modules/fzf.kak
[`:fzf`]: rc/modules/fzf.kak
[`:fzf-buffers`]: rc/modules/fzf.kak

[`dmenu`]: rc/modules/dmenu.kak
[`:dmenu-files`]: rc/modules/dmenu.kak
[`:dmenu`]: rc/modules/dmenu.kak
[`:dmenu-buffers`]: rc/modules/dmenu.kak

[`rofi`]: rc/modules/rofi.kak
[`:rofi-files`]: rc/modules/rofi.kak
[`:rofi`]: rc/modules/rofi.kak
[`:rofi-buffers`]: rc/modules/rofi.kak

[`wofi`]: rc/modules/wofi.kak
[`:wofi-files`]: rc/modules/wofi.kak
[`:wofi`]: rc/modules/wofi.kak
[`:wofi-buffers`]: rc/modules/wofi.kak

[`lf`]: rc/modules/lf.kak
[`:lf`]: rc/modules/lf.kak

[`dolphin`]: rc/modules/dolphin.kak
[`:dolphin`]: rc/modules/dolphin.kak

### Shell commands

- [`edit`] | [`e`]
- [`buffer`] | [`b`]
- [`attach`] | [`a`]
- [`it`]
- [`send`]
- [`get`]

[`edit`]: rc/paths/commands/edit
[`e`]: rc/paths/aliases/e
[`buffer`]: rc/paths/commands/buffer
[`b`]: rc/paths/aliases/b
[`attach`]: rc/paths/commands/attach
[`a`]: rc/paths/aliases/a
[`it`]: rc/paths/commands/it
[`send`]: rc/paths/commands/send
[`get`]: rc/paths/commands/get

### Options

- `connect_attach`: Attach to terminal.  Default is `no`.
- `connect_data_path`: Path to connect data.  Default is `$XDG_DATA_HOME/kak/connect` or `~/.local/share/kak/connect`.

## Resources

See also [explore.kak].

[Kakoune]: https://kakoune.org
[tmux]: https://github.com/tmux/tmux
[Alacritty]: https://github.com/alacritty/alacritty
[fzf]: https://github.com/junegunn/fzf
[dmenu]: https://tools.suckless.org/dmenu/
[Rofi]: https://github.com/davatorium/rofi
[Wofi]: https://hg.sr.ht/~scoopta/wofi
[lf]: https://github.com/gokcehan/lf
[Dolphin]: https://dolphin.kde.org
[fd]: https://github.com/sharkdp/fd
[jq]: https://stedolan.github.io/jq/
[explore.kak]: https://github.com/alexherbo2/explore.kak
[yank-ring.kak]: https://github.com/alexherbo2/yank-ring.kak
[`:yank-ring`]: https://github.com/alexherbo2/yank-ring.kak
[`:yank-ring-load-from-file`]: https://github.com/alexherbo2/yank-ring.kak
[`git-add`]: https://git-scm.com/docs/git-add
[Glow]: https://github.com/charmbracelet/glow
[`:require-module`]: https://github.com/mawww/kakoune/blob/master/doc/pages/commands.asciidoc#module-commands

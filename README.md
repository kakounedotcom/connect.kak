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

Connect a terminal with [`:connect-terminal`].  Open files with [`edit`] or your
favorite program; buffers with the [`buffer`] command…

You can start an interactive shell (or a program) connected to a session, in the same way [nix-shell] does.
By default, the connections occur in the same terminal window (try [`:fzf-files`] or [`:fzf-buffers`] to see);
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

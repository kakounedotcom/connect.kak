# connect.kak

Connect a program to [Kakoune] clients.

## Installation

Add [`rc`] to your autoload or source [`connect.kak`] and its [modules] manually.

## Usage

Connect a terminal with [`connect-terminal`].  Open files with [`edit`] or your
favorite program; buffers with the [`buffer`] command…

If you loaded the [modules], [`fzf-files`] and [`fzf-buffers`] (Kakoune commands)
are also available.  connect.kak currently has batteries for [fzf], [Rofi] and [lf].

**Note**: [`fzf`] and [`rofi`] modules require [fd] for listing files.

**Example** – **Kakoune** – Connect a terminal with [`connect-terminal`]:

``` kak
connect-terminal
```

Or simply [`t`].

**Example** – **Terminal** – Send a file to the client with [`edit`] or its alias [`e`]:

``` sh
edit file.txt
```

**Example** – **Terminal** – Open multiple files:

``` sh
e *.txt
```

**Example** – **Terminal** – Open files with [lf]:

``` sh
lf
```

**Note**: Not to be confused with [`:lf`][`lf`].  connect.kak pairs with [modules]
that you can load with the [`require-module`] command.

**Example** – **Kakoune** – Open selected files with [Rofi]:

``` kak
connect-shell %{
  edit $(fd --type file | rofi -dmenu)
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

**Example** – **Terminal** – [`git-add`] the current buffer:

``` sh
git add $(it)
```

**Example** – **Terminal** – Render Markdown with [Glow]:

``` sh
glow $(it)
```

**Example** – **Terminal** – Load a previous yank with [fzf], by sending the result to [`yank-ring-load-from-file`]:

``` sh
send yank-ring-load-from-file $(find $(get %opt{yank_ring_path}) -type f | sort -n -r | fzf --preview 'cat {}')
```

**Note**: If you have [yank-ring.kak] installed, you can simply call [`yank-ring`] from Kakoune.

## Configuration

``` kak
require-module connect-fzf
require-module connect-rofi
require-module connect-lf

map global normal <c-t> ': connect-terminal<ret>'
```

## Kakoune commands

- [`connect-terminal`] | [`t`]
- [`connect-shell`]
- [`fzf-files`] | [`fzf`]
- [`fzf-buffers`]
- [`rofi-files`] | [`rofi`]
- [`rofi-buffers`]
- [`lf`]

[`rc`]: rc
[modules]: rc/modules

[`connect.kak`]: rc/connect.kak
[`connect-terminal`]: rc/connect.kak
[`connect-shell`]: rc/connect.kak
[`t`]: rc/connect.kak

[`fzf`]: rc/modules/fzf.kak
[`fzf-files`]: rc/modules/fzf.kak
[`fzf-buffers`]: rc/modules/fzf.kak

[`rofi`]: rc/modules/rofi.kak
[`rofi-files`]: rc/modules/rofi.kak
[`rofi-buffers`]: rc/modules/rofi.kak

[`lf`]: rc/modules/lf.kak

## Shell commands

- [`edit`] | [`e`]
- [`buffer`] | [`b`]
- [`open`] | [`o`]
- [`it`]
- [`send`]
- [`get`]

[`edit`]: rc/paths/commands/edit
[`e`]: rc/paths/aliases/e
[`buffer`]: rc/paths/commands/buffer
[`b`]: rc/paths/aliases/b
[`open`]: rc/paths/commands/open
[`o`]: rc/paths/aliases/o
[`it`]: rc/paths/commands/it
[`send`]: rc/paths/commands/send
[`get`]: rc/paths/commands/get

[Kakoune]: https://kakoune.org
[fzf]: https://github.com/junegunn/fzf
[Rofi]: https://github.com/davatorium/rofi
[lf]: https://github.com/gokcehan/lf
[fd]: https://github.com/sharkdp/fd
[jq]: https://stedolan.github.io/jq/
[yank-ring.kak]: https://github.com/alexherbo2/yank-ring.kak
[`yank-ring`]: https://github.com/alexherbo2/yank-ring.kak
[`yank-ring-load-from-file`]: https://github.com/alexherbo2/yank-ring.kak
[`git-add`]: https://git-scm.com/docs/git-add
[Glow]: https://github.com/charmbracelet/glow
[`require-module`]: https://github.com/mawww/kakoune/blob/master/doc/pages/commands.asciidoc#module-commands

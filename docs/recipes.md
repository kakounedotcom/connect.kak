# Recipes

## Appending Kakoune’s shell prompt to the usual prompt

If you are using `bash`, you can add the following lines to your `.bashrc`.

``` sh
if [ -e ~/.local/share/kak/connect/prompt ]; then
    PS1="\$(~/.local/share/kak/connect/prompt)$PS1"
fi
```

## Working with headless sessions with `kak-shell`

`kak-shell :attach` lets your run a client connected to a session,
just like `kak -c <session id>`.
But with `kak-shell :attach` you have a list of all the active sessions
and you can also create a new named session which starts in headless mode,
which is very useful for detaching and reattaching continually.

Therefore, `kak-shell :attach` replaces `kak -c <session id>` and `kak -d -s <session id>`
and can serve to spawn a client in whatever situation you are.

**Tip**: You can alias `kak-shell` to something like `ks`,
and you’d only need to type `ks :a`.

## Turn Kakoune into an IDE

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

### Change directory

In complement to `:cd!` which syncs the client to your current working directory,
you can do the opposite.

Add to your `.bashrc`:

``` bash
if [ "$IN_KAKOUNE_CONNECT" = 1 ]; then
  alias :cd='cd `:pwd`'
  alias :cd?='cd `:bwd`'
fi
```


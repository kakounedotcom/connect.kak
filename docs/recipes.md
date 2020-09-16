# Recipes

## Working with headless sessions with _kak-shell_

`kak-shell :attach` lets you run a client connected to a session, just like the plain `kak -c <session-name>`.
But with `kak-shell :attach`, you have a list of all the active sessions and you can also create a new named session
which starts in headless mode, which is very useful for detaching and reattaching continually.

Therefore, `kak-shell :attach` replaces `kak -c <session-name>` and `kak -d -s <session-name>`
and can serve to spawn a client in whatever situation you are.

**Tip**: Alias `kak-shell` to `ks` and connect to a session with `ks a`.

## Custom prompt

You can modify your shell [prompt][Prompt customization] to notify you whenever you are connected to a session.

[Prompt customization]: https://wiki.archlinux.org/index.php/Bash/Prompt_customization

**Example** – for Bash:

``` bash
PS1='$(test "$IN_KAKOUNE_CONNECT" && printf 🐈)$ '
```

## Change directory

In complement to `:cd!` which syncs the client to your current working directory,
you can do the opposite.

Add to your bashrc:

``` bash
if [ "$IN_KAKOUNE_CONNECT" = 1 ]; then
  alias :cd='cd `:pwd`'
  alias :cd?='cd `:bwd`'
fi
```

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

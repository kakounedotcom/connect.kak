# Broot
# https://dystroy.org/broot/

provide-module connect-broot %{
  require-module connect

  define-command broot -params .. -file-completion -docstring 'Open files with Broot' %{
    > broot %arg{@}
  }
}

# nnn
# https://github.com/jarun/nnn

provide-module connect-nnn %{
  require-module connect

  define-command nnn -params .. -file-completion -docstring 'Open files with nnn' %{
    > nnn %arg{@}
  }
}

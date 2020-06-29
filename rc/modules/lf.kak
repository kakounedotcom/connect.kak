# lf
# https://github.com/gokcehan/lf

provide-module connect-lf %{
  require-module connect
  define-command lf -params .. -file-completion -docstring 'Open files with lf' %{
    connect-terminal lf %arg{@}
  }
}

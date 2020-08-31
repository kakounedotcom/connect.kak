provide-module connect-fifo %{
  require-module connect

  define-command fifo -params 1.. -shell-completion -docstring 'Run command in a fifo buffer' %{
    $ :fifo %arg{@}
  }
}

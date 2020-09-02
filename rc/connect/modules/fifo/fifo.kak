provide-module connect-fifo %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_path}/connect/modules/fifo/aliases" "%opt{connect_path}/connect/modules/fifo/commands"

  # Commands
  define-command fifo -params 1.. -shell-completion -docstring 'Run command in a fifo buffer' %{
    $ :fifo %arg{@}
  }
}

# Broot
# https://dystroy.org/broot/

provide-module connect-broot %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_path}/connect/modules/broot/aliases" "%opt{connect_path}/connect/modules/broot/commands"

  # Commands
  define-command broot -params .. -file-completion -docstring 'Open files with Broot' %{
    > broot %arg{@}
  }

  # Aliases
  alias global br broot
}

# nnn
# https://github.com/jarun/nnn

provide-module connect-nnn %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_modules_path}/nnn/aliases" "%opt{connect_modules_path}/nnn/commands"

  # Commands
  define-command nnn -params .. -file-completion -docstring 'Open files with nnn' %{
    > nnn %arg{@}
  }

  # Aliases
  alias global n nnn
}

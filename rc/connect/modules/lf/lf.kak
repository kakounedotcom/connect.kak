# lf
# https://github.com/gokcehan/lf

provide-module connect-lf %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_path}/connect/modules/lf/aliases" "%opt{connect_path}/connect/modules/lf/commands"

  # Commands
  define-command lf -params .. -file-completion -docstring 'Open files with lf' %{
    > lf %arg{@}
  }
}

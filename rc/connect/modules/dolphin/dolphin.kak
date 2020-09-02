# Dolphin
# https://dolphin.kde.org

provide-module connect-dolphin %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_path}/connect/modules/dolphin/aliases" "%opt{connect_path}/connect/modules/dolphin/commands"

  # Commands
  define-command dolphin -params .. -file-completion -docstring 'Open files with Dolphin' %{
    $ sh -c %(dolphin "${@:-.}") -- %arg{@}
  }
}

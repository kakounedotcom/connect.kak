# Dolphin
# https://dolphin.kde.org

provide-module connect-dolphin %{
  require-module connect

  define-command dolphin -params .. -file-completion -docstring 'Open files with Dolphin' %{
    $ %(dolphin "${@:-.}") -- %arg{@}
  }
}

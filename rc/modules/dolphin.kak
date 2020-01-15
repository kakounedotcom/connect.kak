provide-module connect-dolphin %{
  require-module connect
  define-command dolphin -params .. -file-completion -docstring 'Open files with Dolphin' %{
    connect-shell %{
      dolphin "${@:-.}"
    } -- %arg{@}
  }
}

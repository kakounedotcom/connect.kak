provide-module connect-dmenu %{
  require-module connect
  define-command dmenu-files -params .. -file-completion -docstring 'Open selected files with Rofi' %{
    connect-shell %{
      edit $(fd --type file . "$@" | dmenu -l 20 -i -p 'Open selected files')
    } -- %arg{@}
  }
  define-command dmenu-buffers -params ..1 -buffer-completion -docstring 'Open selected buffers with Rofi' %{
    connect-shell %{
      buffer $(buffer | grep -F "$1" | dmenu -l 20 -i -p 'Open selected buffers')
    } -- %arg{@}
  }
  alias global dmenu dmenu-files
}

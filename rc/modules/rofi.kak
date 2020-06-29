# Rofi
# https://github.com/davatorium/rofi

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-rofi %{
  require-module connect
  define-command rofi-files -params .. -file-completion -docstring 'Open selected files with Rofi' %{
    connect-shell %{
      edit $(fd --type file . "$@" | rofi -dmenu -i -p 'Open selected files')
    } -- %arg{@}
  }
  define-command rofi-buffers -params ..1 -buffer-completion -docstring 'Open selected buffers with Rofi' %{
    connect-shell %{
      buffer $(buffer | grep -F "$1" | rofi -dmenu -i -p 'Open selected buffers')
    } -- %arg{@}
  }
  alias global rofi rofi-files
}

# Rofi
# https://github.com/davatorium/rofi

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-rofi %{
  require-module connect

  define-command rofi-files -params .. -file-completion -docstring 'Open files with Rofi' %{
    $ %(:edit $(fd --type file . "$@" | rofi -dmenu -i -p 'Open files')) -- %arg{@}
  }

  define-command rofi-buffers -params ..1 -buffer-completion -docstring 'Open buffers with Rofi' %{
    $ %(:buffer $(:ls | grep -F "$1" | rofi -dmenu -i -p 'Open buffers')) -- %arg{@}
  }

  alias global rofi rofi-files
}

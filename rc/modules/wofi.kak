# Wofi
# https://hg.sr.ht/~scoopta/wofi

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-wofi %{
  require-module connect
  define-command wofi-files -params .. -file-completion -docstring 'Open selected files with Wofi' %{
    connect-shell %{
      edit $(fd --type file . "$@" | wofi --show dmenu --prompt 'Open selected files')
    } -- %arg{@}
  }
  define-command wofi-buffers -params ..1 -buffer-completion -docstring 'Open selected buffers with Wofi' %{
    connect-shell %{
      buffer $(buffer | grep -F "$1" | wofi --show dmenu --prompt 'Open selected buffers')
    } -- %arg{@}
  }
  alias global wofi wofi-files
}

provide-module connect-fzf %{
  require-module connect
  define-command fzf-files -params .. -file-completion -docstring 'Open selected files with fzf' %{
    connect-terminal sh -c %{
      edit $(fd --type file . "$@" | fzf)
    } -- %arg{@}
  }
  define-command fzf-buffers -params ..1 -buffer-completion -docstring 'Open selected buffers with fzf' %{
    connect-terminal sh -c %{
      buffer $(buffer | grep -F "$1" | fzf)
    } -- %arg{@}
  }
  alias global fzf fzf-files
}

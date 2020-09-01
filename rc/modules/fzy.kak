# fzy
# https://github.com/jhawthorn/fzy

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-fzy %{
  require-module connect

  define-command fzy-files -params .. -file-completion -docstring 'Open files with fzy' %{
    > :fzy-files %arg{@}
  }

  define-command fzy-buffers -params ..1 -buffer-completion -docstring 'Open buffers with fzy' %{
    > :fzy-buffers %arg{@}
  }

  alias global fzy fzy-files
}

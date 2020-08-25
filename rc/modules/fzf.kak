# fzf
# https://github.com/junegunn/fzf

# Dependencies:
# – fd (https://github.com/sharkdp/fd)
# – bat (https://github.com/sharkdp/bat)

provide-module connect-fzf %{
  require-module connect

  define-command fzf-files -params .. -file-completion -docstring 'Open files with fzf' %{
    > :fzf-files %arg{@}
  }

  define-command fzf-buffers -params ..1 -buffer-completion -docstring 'Open buffers with fzf' %{
    > :fzf-buffers %arg{@}
  }

  alias global fzf fzf-files
}

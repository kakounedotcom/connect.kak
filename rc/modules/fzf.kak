# fzf
# https://github.com/junegunn/fzf

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-fzf %{
  require-module connect

  define-command fzf-files -params .. -file-completion -docstring 'Open files with fzf' %{
    > sh -c %(:edit $(fd --type file . "$@" | fzf --prompt='(f)>')) -- %arg{@}
  }

  define-command fzf-buffers -params ..1 -buffer-completion -docstring 'Open buffers with fzf' %{
    > sh -c %(:buffer $(:ls | grep -F "$1" | fzf --prompt='(b)>')) -- %arg{@}
  }

  alias global fzf fzf-files
}

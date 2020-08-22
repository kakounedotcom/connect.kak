# fzf
# https://github.com/junegunn/fzf

# Dependencies:
# – fd (https://github.com/sharkdp/fd)
# – bat (https://github.com/sharkdp/bat)

provide-module connect-fzf %{
  require-module connect

  define-command fzf-files -params .. -file-completion -docstring 'Open files with fzf' %{
    > sh -c %(:edit $(fd --type file . "$@" | fzf --preview-window=down:60% --preview 'bat --style=numbers --color=always --line-range :500 {}' --prompt='(f)>')) -- %arg{@}
  }

  define-command fzf-buffers -params ..1 -buffer-completion -docstring 'Open buffers with fzf' %{
    > sh -c %(:buffer $(:ls | grep -F "$1" | fzf --preview-window=down:60% --preview 'bat --style=numbers --color=always --line-range :500 {}' --prompt='(b)>')) -- %arg{@}
  }

  alias global fzf fzf-files
}

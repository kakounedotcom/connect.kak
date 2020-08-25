# dmenu
# https://tools.suckless.org/dmenu/

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-dmenu %{
  require-module connect

  define-command dmenu-files -params .. -file-completion -docstring 'Open files with dmenu' %{
    $ :dmenu-files %arg{@}
  }

  define-command dmenu-buffers -params ..1 -buffer-completion -docstring 'Open buffers with dmenu' %{
    $ :dmenu-buffers %arg{@}
  }

  alias global dmenu dmenu-files
}

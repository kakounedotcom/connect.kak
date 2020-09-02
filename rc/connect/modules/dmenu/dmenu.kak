# dmenu
# https://tools.suckless.org/dmenu/

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-dmenu %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_modules_path}/dmenu/aliases" "%opt{connect_modules_path}/dmenu/commands"

  # Commands
  # Files
  define-command dmenu-files -params .. -file-completion -docstring 'Open files with dmenu' %{
    $ :dmenu-files %arg{@}
  }

  # Buffers
  define-command dmenu-buffers -params ..1 -buffer-completion -docstring 'Open buffers with dmenu' %{
    $ :dmenu-buffers %arg{@}
  }

  # Aliases
  alias global dmenu dmenu-files
}

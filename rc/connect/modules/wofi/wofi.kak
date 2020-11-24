# Wofi
# https://hg.sr.ht/~scoopta/wofi

# Dependencies:
# – fd (https://github.com/sharkdp/fd)
# – ripgrep (https://github.com/BurntSushi/ripgrep)

provide-module connect-wofi %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_modules_path}/wofi/aliases" "%opt{connect_modules_path}/wofi/commands"

  # Commands
  # Files
  define-command wofi-files -params .. -file-completion -docstring 'Open files with Wofi' %{
    $ :wofi-files %arg{@}
  }

  # Buffers
  define-command wofi-buffers -params ..1 -buffer-completion -docstring 'Open buffers with Wofi' %{
    $ :wofi-buffers %arg{@}
  }

  # Grep
  define-command wofi-grep -params .. -file-completion -docstring 'Open files (search by content) with Wofi' %{
    $ :wofi-grep %arg{@}
  }

  # Aliases
  alias global wofi wofi-files
}

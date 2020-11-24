# fzy
# https://github.com/jhawthorn/fzy

# Dependencies:
# – fd (https://github.com/sharkdp/fd)
# – ripgrep (https://github.com/BurntSushi/ripgrep)

provide-module connect-fzy %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_modules_path}/fzy/aliases" "%opt{connect_modules_path}/fzy/commands"

  # Commands
  # Files
  define-command fzy-files -params .. -file-completion -docstring 'Open files with fzy' %{
    + :fzy-files %arg{@}
  }

  # Buffers
  define-command fzy-buffers -params ..1 -buffer-completion -docstring 'Open buffers with fzy' %{
    + :fzy-buffers %arg{@}
  }

  # Grep
  define-command fzy-grep -params .. -file-completion -docstring 'Open files (search by content) with fzy' %{
    + :fzy-grep %arg{@}
  }

  # Aliases
  alias global fzy fzy-files
}

# fzy
# https://github.com/jhawthorn/fzy

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-fzy %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_modules_path}/fzy/aliases" "%opt{connect_modules_path}/fzy/commands"

  # Commands
  # Files
  define-command fzy-files -params .. -file-completion -docstring 'Open files with fzy' %{
    > :fzy-files %arg{@}
  }

  # Buffers
  define-command fzy-buffers -params ..1 -buffer-completion -docstring 'Open buffers with fzy' %{
    > :fzy-buffers %arg{@}
  }

  # Aliases
  alias global fzy fzy-files
}

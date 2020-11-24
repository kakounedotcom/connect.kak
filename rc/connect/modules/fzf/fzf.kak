# fzf
# https://github.com/junegunn/fzf

# Dependencies:
# – fd (https://github.com/sharkdp/fd)
# – bat (https://github.com/sharkdp/bat)
# – ripgrep (https://github.com/BurntSushi/ripgrep)

provide-module connect-fzf %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_modules_path}/fzf/aliases" "%opt{connect_modules_path}/fzf/commands"

  # Commands
  # Files
  define-command fzf-files -params .. -file-completion -docstring 'Open files with fzf' %{
    + :fzf-files %arg{@}
  }

  # Buffers
  define-command fzf-buffers -params ..1 -buffer-completion -docstring 'Open buffers with fzf' %{
    + :fzf-buffers %arg{@}
  }

  # Grep
  define-command fzf-grep -params .. -file-completion -docstring 'Open files (search by content) with fzf' %{
    + :fzf-grep %arg{@}
  }

  # Aliases
  alias global fzf fzf-files
}

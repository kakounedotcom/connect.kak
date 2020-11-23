# fzf
# https://github.com/junegunn/fzf

# Dependencies:
# – fd (https://github.com/sharkdp/fd)
# – bat (https://github.com/sharkdp/bat)

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

  # Aliases
  alias global fzf fzf-files
}

# Rofi
# https://github.com/davatorium/rofi

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-rofi %{
  # Modules
  require-module connect

  # Register our paths
  set-option -add global connect_paths "%opt{connect_modules_path}/rofi/aliases" "%opt{connect_modules_path}/rofi/commands"

  # Commands
  # Files
  define-command rofi-files -params .. -file-completion -docstring 'Open files with Rofi' %{
    $ :rofi-files %arg{@}
  }

  # Buffers
  define-command rofi-buffers -params ..1 -buffer-completion -docstring 'Open buffers with Rofi' %{
    $ :rofi-buffers %arg{@}
  }

  # Aliases
  alias global rofi rofi-files
}

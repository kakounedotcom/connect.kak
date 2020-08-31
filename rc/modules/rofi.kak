# Rofi
# https://github.com/davatorium/rofi

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-rofi %{
  require-module connect

  define-command rofi-files -params .. -file-completion -docstring 'Open files with Rofi' %{
    $ :rofi-files %arg{@}
  }

  define-command rofi-buffers -params ..1 -buffer-completion -docstring 'Open buffers with Rofi' %{
    $ :rofi-buffers %arg{@}
  }

  alias global rofi rofi-files
}

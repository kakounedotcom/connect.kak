# Wofi
# https://hg.sr.ht/~scoopta/wofi

# Dependencies:
# – fd (https://github.com/sharkdp/fd)

provide-module connect-wofi %{
  require-module connect

  define-command wofi-files -params .. -file-completion -docstring 'Open files with Wofi' %{
    $ :wofi-files %arg{@}
  }

  define-command wofi-buffers -params ..1 -buffer-completion -docstring 'Open buffers with Wofi' %{
    $ :wofi-buffers %arg{@}
  }

  alias global wofi wofi-files
}

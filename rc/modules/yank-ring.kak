provide-module connect-yank-ring %{
  require-module connect
  require-module yank-ring
  define-command yank-ring -params ..1 -docstring 'yank-ring [regex]: Load a previous yank with fzf' %{
    connect-terminal sh -c %{
      kak_opt_yank_ring_path=$1
      shift
      send yank-ring-load-from-file $(
        grep -R -l -E -e "$1" "$kak_opt_yank_ring_path" |
        sort -n -r |
        fzf --preview-window=down:90% --preview '
          quoted_register=$(cat {})
          eval "set -- $quoted_register"
          jq --null-input "\$ARGS.positional" --args "$@"
        '
      )
    } -- %opt{yank_ring_path} %arg{@}
  }
  alias global y yank-ring
}

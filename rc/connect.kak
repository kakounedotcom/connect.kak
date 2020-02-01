declare-option -hidden str connect_path %sh(dirname "$kak_source")

provide-module connect %{
  define-command connect-terminal -params .. -docstring 'Connect a terminal' %{
    terminal sh -c %{
      kak_opt_connect_path=$1 kak_session=$2 kak_client=$3 kak_client_env_SHELL=$4
      . "$kak_opt_connect_path/env/default.env"
      . "$kak_opt_connect_path/env/overrides.env"
      . "$kak_opt_connect_path/env/kakoune.env"
      . "$kak_opt_connect_path/env/git.env"
      shift 4
      "${@:-$SHELL}"
    } -- %opt{connect_path} %val{session} %val{client} %val{client_env_SHELL} %arg{@}
  }
  define-command connect-shell -params 1.. -docstring 'Connect a shell' %{
    nop %sh{
      # kak_opt_connect_path kak_session kak_client kak_client_env_SHELL
      . "$kak_opt_connect_path/env/default.env"
      . "$kak_opt_connect_path/env/overrides.env"
      . "$kak_opt_connect_path/env/kakoune.env"
      . "$kak_opt_connect_path/env/git.env"
      setsid sh -c "$@" < /dev/null > /dev/null 2>&1 &
    }
  }
  alias global t connect-terminal
}

require-module connect

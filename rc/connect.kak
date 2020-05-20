declare-option -hidden str connect_path %sh(dirname "$kak_source")
declare-option str connect_environment
declare-option str connect_focus 0

provide-module connect %{
  define-command connect-terminal -params .. -command-completion -docstring 'Connect a terminal' %{
    terminal sh -c %{
      kak_opt_prelude=$1 kak_opt_connect_path=$2 kak_opt_connect_environment=$3 kak_opt_connect_focus=$4 kak_session=$5 kak_client=$6 kak_client_env_SHELL=$7
      . "$kak_opt_connect_path/env/default.env"
      . "$kak_opt_connect_path/env/overrides.env"
      . "$kak_opt_connect_path/env/kakoune.env"
      . "$kak_opt_connect_path/env/git.env"
      export kak_opt_connect_focus
      eval "$kak_opt_connect_environment"
      shift 7
      "${@:-$SHELL}"
    } -- %opt{prelude} %opt{connect_path} %opt{connect_environment} %opt{connect_focus} %val{session} %val{client} %val{client_env_SHELL} %arg{@}
  }
  define-command connect-shell -params 1.. -shell-completion -docstring 'Connect a shell' %{
    nop %sh{
      # kak_opt_prelude kak_opt_connect_path kak_opt_connect_environment kak_session kak_client kak_client_env_SHELL
      . "$kak_opt_connect_path/env/default.env"
      . "$kak_opt_connect_path/env/overrides.env"
      . "$kak_opt_connect_path/env/kakoune.env"
      . "$kak_opt_connect_path/env/git.env"
      eval "$kak_opt_connect_environment"
      setsid sh -c "$@" < /dev/null > /dev/null 2>&1 &
    }
  }
  alias global t connect-terminal
  alias global T connect-shell
}

require-module connect

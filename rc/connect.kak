declare-option -hidden str connect_path %sh(dirname "$kak_source")
declare-option str connect_environment

provide-module connect %{
  define-command connect-command -params 1.. -command-completion -docstring 'connect-command <command> [<program>] [<arguments]: use <command> as the terminal command' %{
    %arg{1} sh -c %{
      kak_opt_prelude=$1 kak_opt_connect_path=$2 kak_opt_connect_environment=$3 kak_session=$4 kak_client=$5 kak_client_env_SHELL=$6
      . "$kak_opt_connect_path/env/default.env"
      . "$kak_opt_connect_path/env/overrides.env"
      . "$kak_opt_connect_path/env/kakoune.env"
      . "$kak_opt_connect_path/env/git.env"
      eval "$kak_opt_connect_environment"
      shift 7
      "${@:-$SHELL}"
    } -- %opt{prelude} %opt{connect_path} %opt{connect_environment} %val{session} %val{client} %val{client_env_SHELL} %arg{@}
  }
  define-command connect-terminal -params .. -command-completion -docstring 'connect-terminal [<program>] [<arguments>]: connect a terminal' %{
      connect-command terminal %arg{@}
  }
  define-command connect-shell -params 1.. -shell-completion -docstring 'connect-shell <program> [<arguments>]: connect a shell' %{
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

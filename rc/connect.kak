declare-option -hidden str connect_path %sh(dirname "$kak_source")
declare-option str connect_environment

provide-module connect %{
  declare-option -docstring 'Path to connect data' str connect_data_path %sh{
    # Environment variables
    XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
    DATA=$XDG_DATA_HOME/kak/connect
    printf '%s' "$DATA"
  }
  define-command connect-terminal -params .. -shell-completion -docstring 'Connect a terminal' %{
    terminal sh -c %{
      kak_opt_prelude=$1 kak_opt_connect_path=$2 kak_opt_connect_environment=$3 kak_session=$4 kak_client=$5 kak_client_env_SHELL=$6
      . "$kak_opt_connect_path/env/default.env"
      . "$kak_opt_connect_path/env/overrides.env"
      . "$kak_opt_connect_path/env/kakoune.env"
      . "$kak_opt_connect_path/env/git.env"
      eval "$kak_opt_connect_environment"
      shift 6
      "${@:-$SHELL}"
    } -- %opt{prelude} %opt{connect_path} %opt{connect_environment} %val{session} %val{client} %val{client_env_SHELL} %arg{@}
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
  define-command connect-detach -params .. -shell-completion -docstring 'Write the given shell command to your connect data path and detach the client' %{
    evaluate-commands %sh{
      mkdir -p "$kak_opt_connect_data_path/$kak_session"
    }
    echo -to-file "%opt{connect_data_path}/%val{session}/script.sh" -quoting shell %arg{@}
    quit!
  }
  alias global t connect-terminal
  alias global T connect-shell
  alias global d connect-detach
}

require-module connect

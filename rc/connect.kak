# Save the connect path
declare-option -hidden str connect_path %sh(dirname "$kak_source")

provide-module connect %{
  # Modules
  require-module prelude

  # Options
  declare-option str connect_environment

  # Commands
  define-command connect-terminal -params .. -shell-completion -docstring 'Open a new terminal' %{
    terminal sh -c %{
      kak_opt_prelude=$1
      kak_opt_connect_path=$2
      kak_opt_connect_environment=$3
      kak_session=$4
      kak_client=$5

      . "$kak_opt_connect_path/env/default.env"
      . "$kak_opt_connect_path/env/overrides.env"
      . "$kak_opt_connect_path/env/kakoune.env"
      . "$kak_opt_connect_path/env/git.env"

      eval "$kak_opt_connect_environment"

      shift 5

      [ "$1" ] && "$@" || "$SHELL"
    } -- \
      %opt{prelude} \
      %opt{connect_path} \
      %opt{connect_environment} \
      %val{session} \
      %val{client} \
      %arg{@}
  }

  define-command connect-shell -params 1.. -shell-completion -docstring 'Execute commands in a shell' %{
    nop %sh{
      # kak_opt_prelude
      # kak_opt_connect_path
      # kak_opt_connect_environment
      # kak_session
      # kak_client

      . "$kak_opt_connect_path/env/default.env"
      . "$kak_opt_connect_path/env/overrides.env"
      . "$kak_opt_connect_path/env/kakoune.env"
      . "$kak_opt_connect_path/env/git.env"

      eval "$kak_opt_connect_environment"

      setsid sh -c "$@" < /dev/null > /dev/null 2>&1 &
    }
  }

  define-command connect-detach -params .. -shell-completion -docstring 'Write an attachable program to connect.sh and detach the client' %{
    echo -to-file "%val{client_env_PWD}/connect.sh" -quoting shell sh -c %{
      rm connect.sh

      kak_opt_prelude=$1
      kak_opt_connect_path=$2
      kak_opt_connect_environment=$3
      kak_session=$4
      kak_server_working_directory=$5

      . "$kak_opt_connect_path/env/default.env"
      . "$kak_opt_connect_path/env/overrides.env"
      . "$kak_opt_connect_path/env/kakoune.env"
      . "$kak_opt_connect_path/env/git.env"

      eval "$kak_opt_connect_environment"

      shift 5

      cd "$kak_server_working_directory"

      [ "$1" ] && "$@" || "$SHELL"
    } -- \
      %opt{prelude} \
      %opt{connect_path} \
      %opt{connect_environment} \
      %val{session} \
      %sh{pwd} \
      %arg{@}

    # Detach the client
    quit!
  }

  # Aliases
  alias global > connect-terminal
  alias global $ connect-shell
  alias global & connect-detach
}

require-module connect

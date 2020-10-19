# Save the connect paths
declare-option -hidden str connect_root_path %sh(dirname "$kak_source")
declare-option -hidden str connect_modules_path "%opt{connect_root_path}/connect/modules"

# Default modules
hook global ModuleLoaded connect %{
  require-module connect-fifo
}

provide-module connect %{
  # Modules
  require-module prelude

  # Options
  declare-option -docstring 'connect environment' str connect_environment

  # Connect paths
  declare-option -docstring 'connect paths' str-list connect_paths

  # Internal variable to mirror the connect paths as PATH.
  declare-option -hidden str connect_environment_paths

  # Watch the connect_paths option
  hook -group connect-watch-connect-paths global WinSetOption 'connect_paths=.*' %{
    evaluate-commands %sh{
      # Prelude
      . "$kak_opt_prelude_path"

      eval "set -- $kak_quoted_opt_connect_paths"

      # Iterate paths
      paths=''
      for path do
        paths=$paths:$path
      done

      # Update the option
      kak_escape set-option global connect_environment_paths "$paths"
    }
  }

  # Initialize the option with the user config paths
  set-option global connect_paths "%val{config}/connect/aliases" "%val{config}/connect/commands"

  # Commands
  define-command connect-terminal -params .. -shell-completion -docstring 'Open a new terminal' %{
    terminal sh -c %{
      kak_opt_prelude_path=$1
      kak_opt_connect_root_path=$2
      kak_opt_connect_environment=$3
      kak_opt_connect_environment_paths=$4
      kak_session=$5
      kak_client=$6

      . "$kak_opt_connect_root_path/connect/env/default.env"
      . "$kak_opt_connect_root_path/connect/env/overrides.env"
      . "$kak_opt_connect_root_path/connect/env/kakoune.env"
      . "$kak_opt_connect_root_path/connect/env/git.env"

      eval "$kak_opt_connect_environment"

      shift 6

      [ "$1" ] && "$@" || "$SHELL"
    } -- \
      %opt{prelude_path} \
      %opt{connect_root_path} \
      %opt{connect_environment} \
      %opt{connect_environment_paths} \
      %val{session} \
      %val{client} \
      %arg{@}
  }

  define-command connect-shell -params 1.. -shell-completion -docstring 'Execute commands in a shell' %{
    nop %sh{
      # kak_opt_prelude_path
      # kak_opt_connect_root_path
      # kak_opt_connect_environment
      # kak_opt_connect_environment_paths
      # kak_session
      # kak_client

      . "$kak_opt_connect_root_path/connect/env/default.env"
      . "$kak_opt_connect_root_path/connect/env/overrides.env"
      . "$kak_opt_connect_root_path/connect/env/kakoune.env"
      . "$kak_opt_connect_root_path/connect/env/git.env"

      eval "$kak_opt_connect_environment"

      setsid "$@" < /dev/null > /dev/null 2>&1 &
    }
  }

  define-command connect-detach -params .. -shell-completion -docstring 'Write an attachable program to connect.sh and detach the client' %{
    echo -to-file "%val{client_env_PWD}/connect.sh" -quoting shell sh -c %{
      rm connect.sh

      kak_opt_prelude_path=$1
      kak_opt_connect_root_path=$2
      kak_opt_connect_environment=$3
      kak_opt_connect_environment_paths=$4
      kak_session=$5
      kak_server_working_directory=$6

      . "$kak_opt_connect_root_path/connect/env/default.env"
      . "$kak_opt_connect_root_path/connect/env/overrides.env"
      . "$kak_opt_connect_root_path/connect/env/kakoune.env"
      . "$kak_opt_connect_root_path/connect/env/git.env"

      eval "$kak_opt_connect_environment"

      shift 6

      cd "$kak_server_working_directory"

      [ "$1" ] && "$@" || "$SHELL"
    } -- \
      %opt{prelude_path} \
      %opt{connect_root_path} \
      %opt{connect_environment} \
      %opt{connect_environment_paths} \
      %val{session} \
      %sh{pwd} \
      %arg{@}

    # Detach the client
    quit
  }

  # Aliases
  alias global > connect-terminal
  alias global $ connect-shell
  alias global & connect-detach
}

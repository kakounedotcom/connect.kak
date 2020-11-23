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
    connect terminal %arg{@}
  }

  define-command connect-popup -params 1.. -shell-completion -docstring 'Open a new popup' %{
    connect popup %arg{@}
  }

  define-command connect-repl -params .. -shell-completion -docstring 'Open a new REPL' %{
    connect repl-new %arg{@}
  }

  define-command connect-shell -params 1.. -shell-completion -docstring 'Execute commands in a shell' %{
    connect sh %arg{@}
  }

  define-command connect-detach -params .. -shell-completion -docstring 'Write an attachable program to connect.sh and detach the client' %{
    connect detach %arg{@}
  }

  define-command connect -params 1.. -command-completion -docstring 'Run the given command as <command> sh -c {connect} -- [arguments].  Example: connect terminal sh' %{
    %arg{1} sh -c %{
      kak_opt_prelude_path=$1
      kak_opt_connect_root_path=$2
      kak_opt_connect_environment=$3
      kak_opt_connect_environment_paths=$4
      kak_session=$5
      kak_client=$6
      kak_server_working_directory=$7

      . "$kak_opt_connect_root_path/connect/env/default.env"
      . "$kak_opt_connect_root_path/connect/env/overrides.env"
      . "$kak_opt_connect_root_path/connect/env/kakoune.env"
      . "$kak_opt_connect_root_path/connect/env/git.env"

      eval "$kak_opt_connect_environment"

      shift 8

      cd "$kak_server_working_directory"

      [ "$1" ] && "$@" || "$SHELL"
    } -- \
      %opt{prelude_path} \
      %opt{connect_root_path} \
      %opt{connect_environment} \
      %opt{connect_environment_paths} \
      %val{session} \
      %val{client} \
      %sh{pwd} \
      %arg{@}
  }

  # Note:
  #
  # The `sh` command is out of connect.kak’s scope,
  # as the command does not connect things.
  # It is used as an interface to run GUI programs.
  #
  # Example: connect sh dolphin
  define-command sh -params 1.. -shell-completion -docstring 'Execute commands in a shell' %{
    nop %sh{
      setsid "$@" < /dev/null > /dev/null 2>&1 &
    }
  }

  define-command detach -params 1.. -shell-completion -docstring 'Write an attachable program to connect.sh and detach the client' %{
    # Could be simpler with `echo -to-file <file> -append <text>`
    # https://github.com/mawww/kakoune/issues/3874
    echo -to-file "%val{client_env_PWD}/connect.sh~" -quoting shell %arg{@}

    # Remove connect.sh on source
    nop %sh{
      echo 'rm "$0"' | cat - "$kak_client_env_PWD/connect.sh~" > "$kak_client_env_PWD/connect.sh"
      rm "$kak_client_env_PWD/connect.sh~"
    }

    # Detach the client
    quit
  }

  # Aliases
  alias global > connect-terminal
  alias global + connect-popup
  alias global @ connect-repl
  alias global $ connect-shell
  alias global & connect-detach
}

declare-option -hidden str connect_path %sh(dirname "$kak_source")
declare-option str connect_environment

hook global ModuleLoaded connect %{
  hook global ModuleLoaded terminal-mode %{
    require-module connect-terminal-mode
  }
  hook global KakBegin .* %{
    require-module connect-terminal-mode
  }
}

provide-module connect %{
  require-module prelude
  declare-option -docstring 'Attach to terminal' bool connect_attach no
  declare-option -docstring 'Path to connect data' str connect_data_path %sh{
    # Environment variables
    XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
    DATA=$XDG_DATA_HOME/kak/connect
    printf '%s' "$DATA"
  }
  define-command connect-terminal -params .. -shell-completion -docstring 'Connect a terminal' %{
    terminal sh -c %{
      kak_opt_prelude=$1 kak_opt_connect_path=$2 kak_opt_connect_data_path=$3 kak_opt_connect_attach=$4 kak_opt_connect_environment=$5 kak_session=$6 kak_client=$7 kak_client_env_SHELL=$8 kak_sh_pwd=$9
      . "$kak_opt_connect_path/env/default.env"
      . "$kak_opt_connect_path/env/overrides.env"
      . "$kak_opt_connect_path/env/kakoune.env"
      . "$kak_opt_connect_path/env/git.env"
      eval "$kak_opt_connect_environment"
      shift 9
      # Start the shell in the current working directory.
      cd "$kak_sh_pwd"
      "${@:-$SHELL}"
    } -- %opt{prelude} %opt{connect_path} %opt{connect_data_path} %opt{connect_attach} %opt{connect_environment} %val{session} %val{client} %val{client_env_SHELL} %sh{pwd} %arg{@}
  }
  define-command connect-shell -params 1.. -shell-completion -docstring 'Connect a shell' %{
    nop %sh{
      # kak_opt_prelude kak_opt_connect_path kak_opt_connect_data_path kak_opt_connect_attach kak_opt_connect_environment kak_session kak_client kak_client_env_SHELL
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
      mkdir -p "$kak_opt_connect_data_path"
    }
    echo -to-file "%opt{connect_data_path}/script.sh" -quoting shell %arg{@}
    # Delete the script
    hook -once global ClientCreate %val{client} %{
      nop %sh{
        rm -f "$kak_opt_connect_data_path/script.sh~"
      }
    }
    quit!
  }
  alias global t connect-terminal
  alias global $ connect-shell
  alias global d connect-detach
}

provide-module connect-terminal-mode %{
  require-module connect
  require-module terminal-mode

  declare-user-mode connect

  # Set the terminal to :connect-detach.
  # connect-set-detach <scope>
  define-command -hidden connect-set-detach -params 1 %{
    set-option %arg{1} connect_attach yes
    alias %arg{1} terminal connect-detach
  }

  # Reset terminal settings.
  # connect-set-terminal <scope>
  define-command -hidden connect-set-terminal -params 1 %{
    set-option %arg{1} connect_attach no
    enter-user-mode terminal
  }

  # Mappings
  map global terminal c ': enter-user-mode connect<ret>' -docstring 'connect'
  map global connect d ': connect-set-detach global<ret>' -docstring 'Detach'
  map global connect r ': connect-set-terminal global<ret>' -docstring 'Reset'
}

require-module connect

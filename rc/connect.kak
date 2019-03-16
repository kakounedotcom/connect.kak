declare-option -docstring 'Default shell' str connect_shell %sh(echo ${SHELL:-sh})
declare-option -hidden str connect_editor %sh(printf '%s/connect.sh' "${kak_source%/*}")
declare-option -hidden str connect_cache %sh(printf '%s/kak/connect' "${XDG_CACHE_HOME:-~/.cache}")

define-command -hidden connect-configure %{
  nop %sh{
    bin=$kak_opt_connect_cache/bin
    mkdir -p "$bin"
    cp "$kak_opt_connect_editor" "$bin/connect"
  }
}

define-command connect-shell -params 1.. -shell-completion -docstring 'Run a shell with connect and EDITOR connected to the current client' %{
  connect-configure
  nop %sh(PATH=$kak_opt_connect_cache/bin:$PATH EDITOR=connect KAKOUNE_SESSION=$kak_session KAKOUNE_CLIENT=$kak_client $@)
}

define-command connect-terminal -params .. -shell-completion -docstring 'Create a new terminal with connect and EDITOR connected to the current client' %{
  evaluate-commands %sh{
    if test $# = 0; then
      printf 'connect-terminal- %%opt(connect_shell)'
    else
      printf 'connect-terminal- %%arg(@)'
    fi
  }
}

define-command -hidden connect-terminal- -params .. %{
  connect-configure
  terminal sh -c "PATH=%opt(connect_cache)/bin:$PATH EDITOR=connect KAKOUNE_SESSION=%val(session) KAKOUNE_CLIENT=%val(client) %arg(@)"
}

alias global connect connect-terminal

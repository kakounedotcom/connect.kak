declare-option -docstring 'Default shell' str connect_shell %sh(echo ${SHELL:-sh})
declare-option -hidden str connect_editor %sh(printf '%s/connect.sh' "${kak_source%/*}")

define-command connect-shell -params 1.. -shell-completion -docstring 'Run a shell with EDITOR connected to the current client' %{
  nop %sh(EDITOR=$kak_opt_connect_editor KAKOUNE_SESSION=$kak_session KAKOUNE_CLIENT=$kak_client $@)
}

define-command connect-terminal -params .. -shell-completion -docstring 'Create a new terminal with EDITOR connected to the current client' %{
  evaluate-commands %sh{
    if test $# = 0; then
      printf 'connect-terminal- %%opt(connect_shell)'
    else
      printf 'connect-terminal- %%arg(@)'
    fi
  }
}

define-command -hidden connect-terminal- -params .. %{
  terminal sh -c "EDITOR=%opt(connect_editor) KAKOUNE_SESSION=%val(session) KAKOUNE_CLIENT=%val(client) %arg(@)"
}

alias global connect connect-terminal

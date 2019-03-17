declare-option -docstring 'Shell program to be used as default entry-point' str connect_shell %sh(echo ${SHELL:-sh})
declare-option -hidden str connect_source %sh(printf '%s' "${kak_source%/*}")

define-command connect-shell -params 1.. -shell-completion -docstring 'Run a shell with [e]dit, [b]uffer and EDITOR connected to the current client' %{
  nop %sh(export PATH=$kak_opt_connect_source/commands:$kak_opt_connect_source/aliases:$PATH EDITOR=edit KAKOUNE_SESSION=$kak_session KAKOUNE_CLIENT=$kak_client KAKOUNE_BUFFERS=$kak_buflist; $@)
}

define-command connect-terminal -params .. -shell-completion -docstring 'Create a new terminal with [e]dit, [b]uffer and EDITOR connected to the current client' %{
  evaluate-commands %sh{
    if test $# = 0; then
      printf 'connect-terminal- %%opt(connect_shell)'
    else
      printf 'connect-terminal- %%arg(@)'
    fi
  }
}

define-command -hidden connect-terminal- -params .. %{
  terminal sh -c "export PATH=%opt(connect_source)/commands:%opt(connect_source)/aliases:$PATH EDITOR=edit KAKOUNE_SESSION=%val(session) KAKOUNE_CLIENT=%val(client) KAKOUNE_BUFFERS=""%val(buflist)""; %arg(@)"
}

alias global connect connect-terminal

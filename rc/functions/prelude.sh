# Prototype:
# kak_escape [text…]
#
# Description:
# Similar to `shell_escape` you may find in other programming languages,
# `kak_escape` escapes each argument so that it can be safely passed to Kakoune.
#
# Implementation:
# Single quotes each argument and doubles the single quotes inside.
#
# Note:
# The resulted text should be used unquoted and is not intended for use in double quotes, nor in single quotes.
#
# Example:
# kak_escape evaluate-commands -try-client "$KAKOUNE_CLIENT" 'echo Tchou' | kak -p "$KAKOUNE_SESSION"
#
kak_escape() {
  for text do
    printf "'"
    while true; do
      case "$text" in
        *"'"*)
          head=${text%%"'"*}
          tail=${text#*"'"}
          printf "%s''" "$head"
          text=$tail
          ;;
        *)
          printf "%s' " "$text"
          break
          ;;
      esac
    done
  done
  printf '\n'
}

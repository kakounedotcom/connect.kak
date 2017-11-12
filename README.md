[![IRC][shields/kakoune/badge]][freenode/kakoune]

[Kakoune][] extension to connect to client / session.

Dependencies
------------

- [shell.kak][]

Installation
------------

1. Download the [script](bin/kak-connect)
2. Place it on your `$PATH` (`~/bin` is a good choice if it is on your path)
3. Set it to be executable (`chmod +x <file>…`)

Running
-------

- When `$KAK_{SESSION,CLIENT}` are set: Open in the specified client
- When `$KAK_SESSION` is set: Connect to the specified session
- Else: Fall back to `kak`

Usage
-----

Add a `:terminal` command:

``` kak
define-command terminal -params .. %{
  shell \
    -export session \
    -export client \
    %sh(echo $TERMINAL) -e %arg(@) \
    %sh(test $# = 0 &&
      echo $SHELL
    )
}
```

Launch a terminal then execute in it:

``` sh
kak-connect <file>
```

The file will be opened in the client from where `:terminal` was executed.

You can configure your applications to use `kak-connect` instead of `kak`.

[Kakoune]: http://kakoune.org
[freenode/kakoune]: https://webchat.freenode.net?channels=kakoune
[shields/kakoune/badge]: https://img.shields.io/badge/IRC-%23kakoune-blue.svg
[shell.kak]: https://github.com/alexherbo2/shell.kak

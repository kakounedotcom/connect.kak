# Extra documentation for users

## FAQ

### What’s the difference between `>` and `$`?

`>` or `connect-terminal` runs its argument
(which by default is your shell)
inside a terminal,
while `$` or `connect-shell` simply runs its argument.

Some programs must be run inside a terminal,
while others spawn their own graphical window.
Use `>` for the first type and `$` for the second.

### What’s the purpose of `&` or `connect-detach`?

`connect-detach` detaches (closes) the current client
(leaving you in a terminal if you launched Kakoune there) and
creates a file named `connect.sh` which you can run with `sh connect.sh`
to start a shell connected to that client’s server.
The file is automatically erased when it’s sourced.

**Note 1**: The Kakoune server is deleted if you detach the last client and
you didn’t start it in daemon mode.

**Note 2**: The implementation uses Kakoune’s `quit!` command instead of `quit`.

### What is `kak-shell`?

`kak-shell` is inspired by [nix-shell].

It lets you run a program (by default your shell) connected to a session.
Initially, it displays the list of active sessions and asks you to choose one.

```
$ kak-shell
Kakoune sessions:
1 kanto
2 johto
+ create new session
Kakoune session: 1█
@kanto $ :a█
```

If you enter a number _i_, it will try to connect to the _i_-th entry.
Otherwise, it will interpret the entry as a session name and connect to it.
If the session is not running, it will start it in daemon mode.

Apart from running a connected shell, you can use `kak-shell` to run
commands in the context of the session.
For example, you could run `kak-shell tig` to run [tig] connected to an arbitrary session.

[tig]: https://github.com/jonas/tig
[nix-shell]: https://nixos.org/nix/manual#sec-nix-shell

---

## Conventions and design decisions

### What’s the difference between [commands] and [modules]?

The term module is used for small program integrations for Kakoune
(which are implemented as Kakoune’s modules).
The term command is used for small binaries that can be used by a connected application.

[commands]: ../rc/connect/commands
[modules]:  ../rc/modules

### Why do all [commands] start with a colon (`:`)?

The colon is the key used to access the prompt menu inside Kakoune.
Because the commands usually resemble Kakoune commands,
prepending them with a colon is a good way to reuse our muscle memory,
and it makes it very simple to differentiate them from traditional commands
(think of `pwd` versus `:pwd`).


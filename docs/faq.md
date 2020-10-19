# FAQ

## What is the difference between _>_ and _$_?

The `>` or `connect-terminal` command runs its arguments (by default your shell) inside a connected terminal,
while `$` or `connect-shell` simply runs its arguments in a connected environment.

Some programs must be run inside a terminal, while others spawn their own graphical window.

Use `>` for the first type and `$` for the second.

## What is the purpose of _&_?

The `&` or `connect-detach` command detaches (closes) the current client
(leaving you in a terminal if you launched Kakoune there) and
creates a file named `connect.sh` that you can execute with `sh`
to start a shell connected to that client’s server.

**Notes**

- The file is automatically erased after being sourced.
- Kakoune refuses to quit if you try to detach the last client and you didn’t start it in daemon mode.

### What is _kak-shell_?

`kak-shell` is a program to start an interactive shell (or a program) connected to a session, in the same way [nix-shell] does.

[nix-shell]: https://nixos.org/nix/manual#sec-nix-shell

Initially, it displays the list of active sessions and asks you to choose one.

**Illustration**

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
If the session does not exists, the session will be started in daemon mode.

Apart from running a connected shell, you can use `kak-shell` to run commands in the context of the session.
For example, you can run `kak-shell lazygit` to run [lazygit] connected to an arbitrary session.

[lazygit]: https://github.com/jesseduffield/lazygit

## What is the difference between commands and modules?

The term [module][Modules] is used for small program integrations for Kakoune
(which are implemented as Kakoune’s modules).

The term [command][Commands] is used for small binaries that can be used by a connected application.

[Commands]: ../rc/connect/commands
[Modules]: ../rc/connect/modules

## Why do all connect commands start with _:_?

The **:** is the key used to access the prompt menu inside Kakoune.
Because the commands usually resemble Kakoune commands,
prepending them with **:** is a good way to reuse our muscle memory,
and it makes it very simple to differentiate them from traditional commands
(think of `pwd` vs. `:pwd`).

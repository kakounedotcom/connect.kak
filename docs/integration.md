# Integration with other tools

connect.kak is also a framework for developing your own plugins.

## Plugins that use or can work with connect.kak

- [yank-ring.kak]
- [batch.kak]

[yank-ring.kak]: https://github.com/alexherbo2/yank-ring.kak
[batch.kak]: https://github.com/alexherbo2/batch.kak

## Interacting with Kakoune

Integration with other applications usually comes from writing a small program,
typically a shell script, and prefixed with **:** (e.g. `:dolphin`) by convention.
Plugins can register their paths to the `connect_paths` option to add their utilities,
and the same programs can be called inside Kakoune using the `>` or `$` commands (e.g. `> :yank-ring`).
Usually, plugin authors also provide a Kakoune command for them (e.g. `yank-ring`).

The basic [commands] for plugin crafting are:

[Commands]: ../rc/connect/commands

- [`:send`]: Send commands to the client.
- [`:attach`]: Reattach to the session.
- [`:get`]: Get a value from a client.  Example: `:get -quoting shell %val{selections}`.

[`:send`]: ../rc/connect/commands/:send
[`:attach`]: ../rc/connect/commands/:attach
[`:get`]: ../rc/connect/commands/:get

<!---->

- [`:edit`]: Open files.
- [`:buffer`]: Open buffer.
- [`:fifo`]: Send to fifo buffer the output of the given command, or read from **stdin** if available.  Example: `:fifo make`.

[`:edit`]: ../rc/connect/commands/:edit
[`:buffer`]: ../rc/connect/commands/:buffer
[`:fifo`]: ../rc/connect/commands/:fifo

<!---->

- [`:it`]: Get the current buffer path.
- [`:ls`]: List buffers.

[`:it`]: ../rc/connect/commands/:it
[`:ls`]: ../rc/connect/commands/:ls

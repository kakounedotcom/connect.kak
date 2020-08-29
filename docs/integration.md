# Integration with other apps

connect.kak is also framework for developing your own plugins.

## Plugins that use or can work with connect.kak

- [yank-ring.kak]
- [batch.kak]

[yank-ring.kak]: https://github.com/alexherbo2/yank-ring.kak
[batch.kak]: https://github.com/alexherbo2/batch.kak

## Interacting with Kakoune

Integration with other applications usually comes from writing a small program
(typically a shell script).
Plugin’s can add folders to the `connect_paths` option to add their utilities,
and the same programs can be called inside Kakoune
using the commands `>` or `$` ([Example][yank-ring.kak]).
Though it's common for plugin’s authors to provide wrappers inside a module.

The basic [commands] for plugin crafting are:

- [`:get`]: Gets the result of a Kakoune’s `echo` command from the client.
- [`:send`]: Sends commands to the client.

---

- [`:it`]: Prints the current buffer.
- [`:ls`] and [`:buffer`]: Show the list of buffers or change buffers.
- [`:attach`]: Starts a client connected to the session.
- [`:edit`] and [`:edit-wait`]: Open files in the client.
`:edit-wait` does the same but waits for user confirmation
(useful for applications that check the return value of the editor, like git).

[commands]:   ../rc/connect/commands/
[`:attach`]: ../rc/connect/commands/:attach
[`:buffer`]: ../rc/connect/commands/:buffer
[`:edit`]: ../rc/connect/commands/:edit
[`:edit-wait`]: ../rc/connect/commands/:edit-wait
[`:get`]: ../rc/connect/commands/:get
[`:it`]: ../rc/connect/commands/:it
[`:ls`]: ../rc/connect/commands/:ls
[`:send`]: ../rc/connect/commands/:send

# Connect

[![IRC][IRC Badge]][IRC]

###### [Usage](#usage) | [Documentation](#commands) | [Contributing](CONTRIBUTING)

> [Kakoune] extension to connect a program to the current client.

[![asciicast](https://asciinema.org/a/234186.svg)](https://asciinema.org/a/234186)

## Installation

### [Pathogen]

``` kak
pathogen-infect /home/user/repositories/github.com/alexherbo2/connect.kak
```

## Usage

Create a new terminal with `:connect` and edit a file with say, a file explorer.

The file will be opened in the client from where `:connect` was executed by using `EDITOR`.

You can also use the `connect` shell command available in `PATH`.

## Commands

- `connect-shell [program] [arguments]`: Run a shell with `connect` and `EDITOR` connected to the current client
- `connect-terminal [program] [arguments]`: Create a new terminal with `connect` and `EDITOR` connected to the current client

## Aliases

- `connect` → `connect-terminal`

## Options

- `connect_shell`: Shell program to be used as default entry-point (Default: `SHELL`)

[Kakoune]: https://kakoune.org
[IRC]: https://webchat.freenode.net?channels=kakoune
[IRC Badge]: https://img.shields.io/badge/IRC-%23kakoune-blue.svg
[Pathogen]: https://github.com/alexherbo2/pathogen.kak

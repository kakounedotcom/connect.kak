# Connect

[![IRC][IRC Badge]][IRC]

###### [Usage](#usage) | [Documentation](#commands) | [Contributing](CONTRIBUTING)

> [Kakoune] extension to connect a program to the current client.

[![YouTube](https://img.youtube.com/vi/v_Ffno9wiJ4/0.jpg)](https://youtu.be/v_Ffno9wiJ4)

## Installation

### [Pathogen]

``` kak
pathogen-infect /home/user/repositories/github.com/alexherbo2/connect.kak
```

## Usage

Create a new terminal with `:connect` and edit a file with say, a file explorer.

The file will be opened in the client from where `:connect` was executed by using `EDITOR`.

You can also configure your shell to alias `kak` to `rc/connect.sh`.

## Commands

- `connect-shell [program] [arguments]`: Run a shell with `EDITOR` connected to the current client
- `connect-terminal [program] [arguments]`: Create a new terminal with `EDITOR` connected to the current client

## Aliases

- `connect` → `connect-terminal`

## Options

- `connect_shell`: Default shell (Default: `SHELL`)

[Kakoune]: https://kakoune.org
[IRC]: https://webchat.freenode.net?channels=kakoune
[IRC Badge]: https://img.shields.io/badge/IRC-%23kakoune-blue.svg
[Pathogen]: https://github.com/alexherbo2/pathogen.kak

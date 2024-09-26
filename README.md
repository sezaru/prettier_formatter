# PrettierFormatter

[![Hex.pm Version](http://img.shields.io/hexpm/v/prettier_formatter.svg)](https://hex.pm/packages/prettier_formatter)

A formatter that can be plugged in to `mix format` in order to format javascript and css files.

## Installation

The package can be installed by adding `prettier_formatter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:prettier_formatter, "~> 0.2.0"}
  ]
end
```

Then, to install Prettier itself, first set the version you want to use by adding the following to your `config.exs`:

```elixir
config :prettier_formatter, :version, "3.3.3"
```

And then run:

```sh
mix prettier.install
```

## Usage

Add `PrettierFormatter` to the `.formatter.exs` plugin list.

```elixir
[
  plugins: [PrettierFormatter],
  inputs: [
    ...
    "assets/js/**/*.{js,ts,jsx,tsx}",
    "assets/tailwind.config.js",
    "assets/css/**/*.css"
  ]
]
```

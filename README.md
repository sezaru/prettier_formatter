# PrettierFormatter

A formatter that can be plugged in to `mix format` in order to format javascrit and css files.

## Installation

The package can be installed by adding `prettier_formatter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:prettier_formatter, "~> 0.1.0"}
  ]
end
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

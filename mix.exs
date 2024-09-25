defmodule PrettierFormatter.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :prettier_formatter,
      version: @version,
      elixir: "~> 1.17",
      deps: deps()
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.4"}
    ]
  end
end

defmodule PrettierFormatter.MixProject do
  @moduledoc false
  
  use Mix.Project

  @app :prettier_formatter
  @name "PrettierFormatter"
  @description "A formatter to format javascript and css files."
  @version "0.2.0"
  @github "https://github.com/sezaru/#{@app}"
  @author "Eduardo Barreto Alexandre"
  @license "MIT"

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.17",
      name: @name,
      description: @description,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.4"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

    defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @github
    ]
  end

  defp package do
    [
      name: @app,
      maintainers: [@author],
      licenses: [@license],
      files: ~w(mix.exs lib README.md),
      links: %{"Github" => @github}
    ]
  end
end

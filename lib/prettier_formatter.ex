defmodule PrettierFormatter do
  @moduledoc """
  A formatter that can be plugged in to `mix format` in order to format javascrit
  and css files.

  ## Usage

  Add `PrettierFormatter` to the `.formatter.exs` plugin list.

  ```
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
  """

  alias PrettierFormatter.Installer

  require Logger

  @behaviour Mix.Tasks.Format

  @latest_version "3.3.3"

  def configured_version do
    unless Application.get_env(:prettier_formatter, :version) do
      Logger.warning("""
        Prettier version is not configured. Please set it in your config files:

            config :prettier_formatter, :version, "#{latest_version()}"
      """)
    end

    Application.get_env(:prettier_formatter, :version, latest_version())
  end

  @impl true
  def features(_opts) do
    [extensions: ~w(.js .ts .jsx .tsx .css)]
  end

  @impl true
  def format(contents, opts) do

    version = configured_version()

    unless Installer.installed?(version) == :ok do
      raise """
      Prettier #{version} is not installed.

      To install it, run

          mix prettier.install
      """
    end

    extension = Keyword.fetch!(opts, :extension)

    do_format(contents, extension)
  end

  defp do_format(contents, extension) when extension in ~w(.js .ts .jsx .tsx),
    do: run_format(contents, "typescript")

  defp do_format(contents, extension) when extension in ~w(.css), do: run_format(contents, "css")

  defp run_format(contents, parser) do
    contents = String.replace(contents, "'", "'\"'\"'")

    {contents, 0} = System.shell("echo '#{contents}' | prettier --stdin --parser #{parser}")

    contents
  end

  defp latest_version, do: @latest_version
end

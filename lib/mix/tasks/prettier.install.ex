defmodule Mix.Tasks.Prettier.Install do
  @moduledoc false

  use Mix.Task

  require Logger

  @impl true
  def run(_args) do
    version = PrettierFormatter.configured_version()

    PrettierFormatter.Installer.maybe_install!(version)

    Logger.info("Prettier installed successfully")
  end
end

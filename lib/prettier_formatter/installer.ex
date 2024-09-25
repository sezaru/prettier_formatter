defmodule PrettierFormatter.Installer do
  @moduledoc false

  require Logger

  def installed?(version) do
    cond do
      not has_executable?("npm") -> {:error, :npm_not_found}
      not has_executable?("prettier") -> {:error, :prettier_not_found}
      not correct_version?(version) -> {:error, :incorrect_version}
      true -> :ok
    end
  end

  def maybe_install!(version) do
    case installed?(version) do
      :ok ->
        :ok

      {:error, :npm_not_found} ->
        raise "PrettierFormatter: npm not found, please install it first"

      {:error, :prettier_not_found} ->
        Logger.info("Prettier is not globally installed, installing it now.")

        install!(version)

      {:error, :incorrect_version} ->
        raise """
        PrettierFormatter: Installed prettier version is incorrect. Please install the correct version with:

            npm i -g prettier@#{version}
        """
    end
  end

  defp install!(version) do
    case System.shell("npm i -g prettier@#{version}") do
      {_, 0} ->
        :ok

      {content, error_code} ->
          raise """
          PrettierFormatter: failed to install prettier, got error code #{error_code}:

          #{content}
          """
    end
  end

  defp correct_version?(version) do
    {output, 0} = System.shell("npm list --depth 1 -g --json prettier")

    installed_version = output |> Jason.decode!() |> Map.fetch!("dependencies") |> Map.fetch!("prettier") |> Map.fetch!("version")

    version == installed_version
  end

  defp has_executable?(binary), do: binary |> System.find_executable() |> is_nil() |> Kernel.not()
end

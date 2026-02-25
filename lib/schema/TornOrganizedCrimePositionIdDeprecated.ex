defmodule Torngen.Client.Schema.TornOrganizedCrimePositionIdDeprecated do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values ["P1", "P2", "P3", "P4", "P5", "P6"]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning(
        "Invalid enum value #{inspect(data)} of TornOrganizedCrimePositionIdDeprecated"
      )

      nil
    end
  end
end

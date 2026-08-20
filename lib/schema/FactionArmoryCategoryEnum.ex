defmodule Torngen.Client.Schema.FactionArmoryCategoryEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "weapons",
    "armor",
    "temporary",
    "medical",
    "consumables",
    "drugs",
    "boosters",
    "utilities",
    "loot"
  ]

  @spec values() :: [t()]
  def values, do: @values

  @impl true
  def validate?(value), do: Enum.member?(@values, value)

  @impl true
  def parse(data) do
    if validate?(data) do
      data
    else
      Logger.warning("Invalid enum value #{inspect(data)} of FactionArmoryCategoryEnum")
      nil
    end
  end
end

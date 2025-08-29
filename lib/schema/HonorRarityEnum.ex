defmodule Torngen.Client.Schema.HonorRarityEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Extremely Rare",
    "Very Rare",
    "Rare",
    "Limited",
    "Uncommon",
    "Common",
    "Very Common",
    "Unknown"
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
      Logger.warning("Invalid enum value #{inspect(data)} of HonorRarityEnum")
      nil
    end
  end
end

defmodule Torngen.Client.Schema.TornItemStatTitleEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Damage",
    "Rounds fired",
    "Hits",
    "Misses",
    "Damage taken",
    "Reloads",
    "Highest damage",
    "Hits received",
    "Most damage taken",
    "Damage mitigated",
    "Most damage mitigated",
    "Finishing hits",
    "Critical hits",
    "First owner",
    "First faction owner",
    "Time created",
    "Respect earned"
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
      Logger.warning("Invalid enum value #{inspect(data)} of TornItemStatTitleEnum")
      nil
    end
  end
end

defmodule Torngen.Client.Schema.TornShopliftingStatusTitleEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "One camera",
    "Two cameras",
    "Three cameras",
    "Four cameras",
    "Checkpoint",
    "One guard",
    "Two guards"
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
      Logger.warning("Invalid enum value #{inspect(data)} of TornShopliftingStatusTitleEnum")
      nil
    end
  end
end

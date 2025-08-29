defmodule Torngen.Client.Schema.HonorTypeEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "attacking",
    "camo",
    "weapons",
    "education",
    "crimes",
    "drugs",
    "jail",
    "hospital",
    "travel",
    "gym",
    "level",
    "competitions",
    "money",
    "items",
    "commitment",
    "casino",
    "missions",
    "misc",
    "default"
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
      Logger.warning("Invalid enum value #{inspect(data)} of HonorTypeEnum")
      nil
    end
  end
end

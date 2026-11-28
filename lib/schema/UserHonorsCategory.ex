defmodule Torngen.Client.Schema.UserHonorsCategory do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "all",
    "latest",
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
    "misc"
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
      Logger.warning("Invalid enum value #{inspect(data)} of UserHonorsCategory")
      nil
    end
  end
end

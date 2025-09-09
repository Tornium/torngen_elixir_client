defmodule Torngen.Client.Schema.UserRankEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Absolute beginner",
    "Beginner",
    "Inexperienced",
    "Rookie",
    "Novice",
    "Below average",
    "Average",
    "Reasonable",
    "Above average",
    "Competent",
    "Highly competent",
    "Veteran",
    "Distinguished",
    "Highly distinguished",
    "Professional",
    "Star",
    "Master",
    "Outstanding",
    "Celebrity",
    "Supreme",
    "Idolized",
    "Champion",
    "Heroic",
    "Legendary",
    "Elite",
    "Invincible"
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
      Logger.warning("Invalid enum value #{inspect(data)} of UserRankEnum")
      nil
    end
  end
end

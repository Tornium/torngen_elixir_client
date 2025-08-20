defmodule Torngen.Client.Schema.UserSkillSlugEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "hunting",
    "racing",
    "reviving",
    "search_for_cash",
    "bootlegging",
    "graffiti",
    "shoplifting",
    "pickpocketing",
    "card_skimming",
    "burglary",
    "hustling",
    "disposal",
    "cracking",
    "forgery",
    "scamming",
    "arson"
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
      Logger.warning("Invalid enum value #{inspect(data)} of UserSkillSlugEnum")
      nil
    end
  end
end

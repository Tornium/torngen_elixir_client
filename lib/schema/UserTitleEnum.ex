defmodule Torngen.Client.Schema.UserTitleEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Alcoholic",
    "Sharpshooter",
    "Accomplice",
    "Loser",
    "Silent Killer",
    "Killer",
    "Merchant",
    "Medalist",
    "Tycoon",
    "Damage Dealer",
    "Slayer",
    "Hired Gun",
    "Egotist",
    "Outcast",
    "Punchbag",
    "Tank",
    "Antagonist",
    "Druggy",
    "Scavenger",
    "Boxer",
    "Importer",
    "Looter",
    "Samaritan",
    "Felon",
    "Socialite",
    "Mercenary",
    "Investor",
    "Thief",
    "One Hit Killer",
    "Mobster",
    "Addict",
    "Bonds Agent",
    "Buster",
    "Hoarder",
    "Racer",
    "Soldier",
    "Avenger",
    "Healer",
    "Booster",
    "Intimidator",
    "Trader",
    "Jobsworth",
    "Tourist",
    "Nudist",
    "Sage",
    "Coward",
    "Newcomer",
    "Deserter"
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
      Logger.warning("Invalid enum value #{inspect(data)} of UserTitleEnum")
      nil
    end
  end
end

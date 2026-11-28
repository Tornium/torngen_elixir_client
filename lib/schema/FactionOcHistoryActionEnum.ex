defmodule Torngen.Client.Schema.FactionOcHistoryActionEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Joined",
    "Left",
    "Kicked",
    "RoleChanged",
    "Spawned",
    "ItemUsed",
    "ItemLost",
    "Jailed",
    "Hospitalized",
    "Injured",
    "Completed",
    "Failed",
    "Expired",
    "Payout",
    "PayoutReceived"
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
      Logger.warning("Invalid enum value #{inspect(data)} of FactionOcHistoryActionEnum")
      nil
    end
  end
end

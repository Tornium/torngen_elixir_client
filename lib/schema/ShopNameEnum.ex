defmodule Torngen.Client.Schema.ShopNameEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Arms Dealer",
    "General Store",
    "Black Market",
    "Big Al's Gun Shop",
    "Sally's Sweet Shop",
    "TC Clothing",
    "Bits 'n' Bobs",
    "Jewelry Store",
    "Super Store",
    "Docks",
    "Post Office",
    "Pharmacy",
    "Nikeh Sports",
    "Print Shop",
    "Recycling Center",
    "Cyber Force",
    "Pawn Shop"
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
      Logger.warning("Invalid enum value #{inspect(data)} of ShopNameEnum")
      nil
    end
  end
end

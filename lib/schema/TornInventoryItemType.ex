defmodule Torngen.Client.Schema.TornInventoryItemType do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Collectible",
    "Clothing",
    "Other",
    "Tool",
    "Melee",
    "Defensive",
    "Material",
    "Car",
    "Primary",
    "Secondary",
    "Book",
    "Special",
    "Supply Pack",
    "Temporary",
    "Enhancer",
    "Artifact",
    "Flower",
    "Booster",
    "Medical",
    "Candy",
    "Jewelry",
    "Alcohol",
    "Plushie",
    "Drug",
    "Energy Drink"
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
      Logger.warning("Invalid enum value #{inspect(data)} of TornInventoryItemType")
      nil
    end
  end
end

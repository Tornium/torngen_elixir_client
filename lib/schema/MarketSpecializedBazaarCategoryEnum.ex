defmodule Torngen.Client.Schema.MarketSpecializedBazaarCategoryEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Alcohol",
    "Artifact",
    "Booster",
    "Candy",
    "Car",
    "Clothing",
    "Collectible",
    "Defensive",
    "Drug",
    "Energy Drink",
    "Enhancer",
    "Flower",
    "Jewelry",
    "Material",
    "Medical",
    "Melee",
    "Other",
    "Plushie",
    "Primary",
    "Secondary",
    "Special",
    "Supply Pack",
    "Temporary",
    "Tool"
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
      Logger.warning("Invalid enum value #{inspect(data)} of MarketSpecializedBazaarCategoryEnum")
      nil
    end
  end
end

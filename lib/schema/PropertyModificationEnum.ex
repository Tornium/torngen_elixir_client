defmodule Torngen.Client.Schema.PropertyModificationEnum do
  @moduledoc false

  require Logger

  @behaviour Torngen.Client.Schema

  @type t :: String.t()

  @values [
    "Hot Tub",
    "Sauna",
    "Open Bar",
    "Small Pool",
    "Medium Pool",
    "Large Pool",
    "Small Vault",
    "Medium Vault",
    "Large Vault",
    "Extra Large Vault",
    "Medical Facility",
    "Advanced Shooting Range",
    "Airstrip",
    "Private Yacht",
    "Sufficient Interior Modification",
    "Superior Interior Modification"
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
      Logger.warning("Invalid enum value #{inspect(data)} of PropertyModificationEnum")
      nil
    end
  end
end

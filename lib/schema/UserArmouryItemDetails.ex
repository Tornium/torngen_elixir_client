defmodule Torngen.Client.Schema.UserArmouryItemDetails do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:stats, :rarity, :bonuses]

  defstruct [
    :stats,
    :rarity,
    :bonuses
  ]

  @type t :: %__MODULE__{
          stats: nil | Torngen.Client.Schema.ItemMarketListingItemStats.t(),
          rarity: nil | String.t(),
          bonuses: [Torngen.Client.Schema.ItemMarketListingItemBonus.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stats:
        data
        |> Map.get("stats")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.ItemMarketListingItemStats]}
        ),
      rarity:
        data
        |> Map.get("rarity")
        |> Torngen.Client.Schema.parse(
          {:one_of, [{:static, :null}, {:enum, :string, ["yellow", "orange", "red"]}]}
        ),
      bonuses:
        data
        |> Map.get("bonuses")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.ItemMarketListingItemBonus}}
        )
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = data) do
    @keys
    |> Enum.map(fn key -> {key, Map.get(data, Atom.to_string(key))} end)
    |> Enum.map(fn {key, value} -> validate_key?(key, value) end)
    |> Enum.all?()
  end

  defp validate_key?(:stats, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.ItemMarketListingItemStats]}
    )
  end

  defp validate_key?(:rarity, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [{:static, :null}, {:enum, :string, ["yellow", "orange", "red"]}]}
    )
  end

  defp validate_key?(:bonuses, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.ItemMarketListingItemBonus}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

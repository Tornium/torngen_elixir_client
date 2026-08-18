defmodule Torngen.Client.Schema.TornCityShop do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:name, :items, :id]

  defstruct [
    :name,
    :items,
    :id
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          items: [Torngen.Client.Schema.TornCityShopItem.t()],
          id: Torngen.Client.Schema.CityShopId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      items:
        data
        |> Map.get("items")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornCityShopItem}}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CityShopId})
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

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.TornCityShopItem}}
    )
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CityShopId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

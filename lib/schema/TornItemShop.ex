defmodule Torngen.Client.Schema.TornItemShop do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:shop, :sell_price, :country, :buy_price]

  defstruct [
    :shop,
    :sell_price,
    :country,
    :buy_price
  ]

  @type t :: %__MODULE__{
          shop: Torngen.Client.Schema.ShopNameEnum.t(),
          sell_price: nil | integer(),
          country: Torngen.Client.Schema.CountryEnum.t(),
          buy_price: nil | integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      shop:
        data
        |> Map.get("shop")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ShopNameEnum}),
      sell_price:
        data
        |> Map.get("sell_price")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      country:
        data
        |> Map.get("country")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.CountryEnum}),
      buy_price:
        data
        |> Map.get("buy_price")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
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

  defp validate_key?(:shop, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ShopNameEnum})
  end

  defp validate_key?(:sell_price, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:country, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.CountryEnum})
  end

  defp validate_key?(:buy_price, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

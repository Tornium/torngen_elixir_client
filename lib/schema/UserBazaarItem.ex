defmodule Torngen.Client.Schema.UserBazaarItem do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:uids, :type, :quantity, :price, :name, :market_price, :item_details, :id]

  defstruct [
    :uids,
    :type,
    :quantity,
    :price,
    :name,
    :market_price,
    :item_details,
    :id
  ]

  @type t :: %__MODULE__{
          uids: [Torngen.Client.Schema.UserBazaarItemUid.t()],
          type: Torngen.Client.Schema.TornInventoryItemType.t(),
          quantity: integer(),
          price: nil | integer(),
          name: String.t(),
          market_price: integer(),
          item_details: nil | Torngen.Client.Schema.UserArmouryItemDetails.t(),
          id: Torngen.Client.Schema.ItemId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      uids:
        data
        |> Map.get("uids")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserBazaarItemUid}}),
      type:
        data
        |> Map.get("type")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornInventoryItemType}),
      quantity: data |> Map.get("quantity") |> Torngen.Client.Schema.parse({:static, :integer}),
      price:
        data
        |> Map.get("price")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      market_price:
        data |> Map.get("market_price") |> Torngen.Client.Schema.parse({:static, :integer}),
      item_details:
        data
        |> Map.get("item_details")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.UserArmouryItemDetails]}
        ),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ItemId})
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

  defp validate_key?(:uids, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.UserBazaarItemUid}}
    )
  end

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TornInventoryItemType})
  end

  defp validate_key?(:quantity, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:price, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:market_price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:item_details, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.UserArmouryItemDetails]}
    )
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

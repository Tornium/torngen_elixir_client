defmodule Torngen.Client.Schema.AuctionHouseListing do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timestamp, :seller, :price, :item, :id, :buyer, :bids]

  defstruct [
    :timestamp,
    :seller,
    :price,
    :item,
    :id,
    :buyer,
    :bids
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          seller: Torngen.Client.Schema.BasicUser.t(),
          price: integer(),
          item:
            Torngen.Client.Schema.TornItemDetails.t()
            | Torngen.Client.Schema.AuctionHouseStackableItem.t(),
          id: Torngen.Client.Schema.AuctionListingId.t(),
          buyer: Torngen.Client.Schema.BasicUser.t(),
          bids: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      seller:
        data
        |> Map.get("seller")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.BasicUser}),
      price: data |> Map.get("price") |> Torngen.Client.Schema.parse({:static, :integer}),
      item:
        data
        |> Map.get("item")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             ref: Torngen.Client.Schema.TornItemDetails,
             ref: Torngen.Client.Schema.AuctionHouseStackableItem
           ]}
        ),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.AuctionListingId}),
      buyer:
        data
        |> Map.get("buyer")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.BasicUser}),
      bids: data |> Map.get("bids") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:seller, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.BasicUser})
  end

  defp validate_key?(:price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:item, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         ref: Torngen.Client.Schema.TornItemDetails,
         ref: Torngen.Client.Schema.AuctionHouseStackableItem
       ]}
    )
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.AuctionListingId})
  end

  defp validate_key?(:buyer, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.BasicUser})
  end

  defp validate_key?(:bids, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

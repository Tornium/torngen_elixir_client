defmodule Torngen.Client.Schema.AuctionHouseListingResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:auctionhouselisting]

  defstruct [
    :auctionhouselisting
  ]

  @type t :: %__MODULE__{
          auctionhouselisting: Torngen.Client.Schema.AuctionHouseListing.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      auctionhouselisting:
        data
        |> Map.get("auctionhouselisting")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.AuctionHouseListing})
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

  defp validate_key?(:auctionhouselisting, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.AuctionHouseListing})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

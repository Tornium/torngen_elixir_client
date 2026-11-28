defmodule Torngen.Client.Schema.AuctionHouseResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:auctionhouse_timestamp, :auctionhouse_delay, :auctionhouse, :_metadata]

  defstruct [
    :auctionhouse_timestamp,
    :auctionhouse_delay,
    :auctionhouse,
    :_metadata
  ]

  @type t :: %__MODULE__{
          auctionhouse_timestamp: nil | integer(),
          auctionhouse_delay: nil | integer(),
          auctionhouse: [Torngen.Client.Schema.AuctionHouseListing.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      auctionhouse_timestamp:
        data
        |> Map.get("auctionhouse_timestamp")
        |> Torngen.Client.Schema.parse({:one_of, [static: :integer]}),
      auctionhouse_delay:
        data
        |> Map.get("auctionhouse_delay")
        |> Torngen.Client.Schema.parse({:one_of, [static: :integer]}),
      auctionhouse:
        data
        |> Map.get("auctionhouse")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.AuctionHouseListing}}
        ),
      _metadata:
        data
        |> Map.get("_metadata")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.RequestMetadataWithLinks})
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

  defp validate_key?(:auctionhouse_timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:auctionhouse_delay, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:auctionhouse, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.AuctionHouseListing}}
    )
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.RequestMetadataWithLinks})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

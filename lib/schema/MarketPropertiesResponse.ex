defmodule Torngen.Client.Schema.MarketPropertiesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:properties, :_metadata]

  defstruct [
    :properties,
    :_metadata
  ]

  @type t :: %__MODULE__{
          properties: Torngen.Client.Schema.MarketPropertyDetails.t(),
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      properties:
        data
        |> Map.get("properties")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.MarketPropertyDetails}),
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

  defp validate_key?(:properties, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.MarketPropertyDetails})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.RequestMetadataWithLinks})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

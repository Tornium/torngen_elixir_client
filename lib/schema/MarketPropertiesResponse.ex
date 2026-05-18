defmodule Torngen.Client.Schema.MarketPropertiesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:properties_timestamp, :properties_delay, :properties, :_metadata]

  defstruct [
    :properties_timestamp,
    :properties_delay,
    :properties,
    :_metadata
  ]

  @type t :: %__MODULE__{
          properties_timestamp: integer(),
          properties_delay: nil | integer(),
          properties: Torngen.Client.Schema.MarketPropertyDetails.t(),
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinksAndTotal.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      properties_timestamp:
        data
        |> Map.get("properties_timestamp")
        |> Torngen.Client.Schema.parse({:static, :integer}),
      properties_delay:
        data
        |> Map.get("properties_delay")
        |> Torngen.Client.Schema.parse({:one_of, [static: :integer]}),
      properties:
        data
        |> Map.get("properties")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.MarketPropertyDetails}),
      _metadata:
        data
        |> Map.get("_metadata")
        |> Torngen.Client.Schema.parse(
          {:ref, Torngen.Client.Schema.RequestMetadataWithLinksAndTotal}
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

  defp validate_key?(:properties_timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:properties_delay, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:properties, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.MarketPropertyDetails})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.RequestMetadataWithLinksAndTotal}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

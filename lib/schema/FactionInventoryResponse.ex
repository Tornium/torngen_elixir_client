defmodule Torngen.Client.Schema.FactionInventoryResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:inventory_timestamp, :inventory, :_metadata]

  defstruct [
    :inventory_timestamp,
    :inventory,
    :_metadata
  ]

  @type t :: %__MODULE__{
          inventory_timestamp: integer(),
          inventory: [Torngen.Client.Schema.FactionInventoryItem.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinksAndTotal.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      inventory_timestamp:
        data |> Map.get("inventory_timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      inventory:
        data
        |> Map.get("inventory")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.FactionInventoryItem}}
        ),
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

  defp validate_key?(:inventory_timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:inventory, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.FactionInventoryItem}}
    )
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

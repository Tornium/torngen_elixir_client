defmodule Torngen.Client.Schema.UserInventory do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timestamp, :items]

  defstruct [
    :timestamp,
    :items
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          items: [Torngen.Client.Schema.UserInventoryItem.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      items:
        data
        |> Map.get("items")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserInventoryItem}})
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

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.UserInventoryItem}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

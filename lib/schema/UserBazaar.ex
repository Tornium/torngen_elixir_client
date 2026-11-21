defmodule Torngen.Client.Schema.UserBazaar do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:items, :is_open, :exists]

  defstruct [
    :items,
    :is_open,
    :exists
  ]

  @type t :: %__MODULE__{
          items: [Torngen.Client.Schema.UserBazaarItem.t()],
          is_open: boolean(),
          exists: boolean()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      items:
        data
        |> Map.get("items")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserBazaarItem}}),
      is_open: data |> Map.get("is_open") |> Torngen.Client.Schema.parse({:static, :boolean}),
      exists: data |> Map.get("exists") |> Torngen.Client.Schema.parse({:static, :boolean})
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

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.UserBazaarItem}})
  end

  defp validate_key?(:is_open, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:exists, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

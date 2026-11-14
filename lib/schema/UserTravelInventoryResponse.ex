defmodule Torngen.Client.Schema.UserTravelInventoryResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:travelinventory]

  defstruct [
    :travelinventory
  ]

  @type t :: %__MODULE__{
          travelinventory: Torngen.Client.Schema.UserTravelInventory.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      travelinventory:
        data
        |> Map.get("travelinventory")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserTravelInventory})
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

  defp validate_key?(:travelinventory, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserTravelInventory})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.UserTravelInventory do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:inventory, :capacity]

  defstruct [
    :inventory,
    :capacity
  ]

  @type t :: %__MODULE__{
          inventory: [Torngen.Client.Schema.UserTravelInventorySlot.t()],
          capacity: Torngen.Client.Schema.UserTravelInventoryCapacity.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      inventory:
        data
        |> Map.get("inventory")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.UserTravelInventorySlot}}
        ),
      capacity:
        data
        |> Map.get("capacity")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserTravelInventoryCapacity})
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

  defp validate_key?(:inventory, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.UserTravelInventorySlot}}
    )
  end

  defp validate_key?(:capacity, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.UserTravelInventoryCapacity}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

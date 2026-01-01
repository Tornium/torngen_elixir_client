defmodule Torngen.Client.Schema.UserEquipmentResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:equipment, :clothing]

  defstruct [
    :equipment,
    :clothing
  ]

  @type t :: %__MODULE__{
          equipment: [Torngen.Client.Schema.UserEquipment.t()],
          clothing: [Torngen.Client.Schema.UserClothing.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      equipment:
        data
        |> Map.get("equipment")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserEquipment}}),
      clothing:
        data
        |> Map.get("clothing")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserClothing}})
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

  defp validate_key?(:equipment, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.UserEquipment}})
  end

  defp validate_key?(:clothing, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.UserClothing}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

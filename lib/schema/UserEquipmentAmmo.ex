defmodule Torngen.Client.Schema.UserEquipmentAmmo do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :quantity, :name, :id]

  defstruct [
    :type,
    :quantity,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.TornItemAmmoTypeEnum.t(),
          quantity: integer(),
          name: String.t(),
          id: Torngen.Client.Schema.AmmoId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type:
        data
        |> Map.get("type")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornItemAmmoTypeEnum}),
      quantity: data |> Map.get("quantity") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.AmmoId})
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

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TornItemAmmoTypeEnum})
  end

  defp validate_key?(:quantity, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.AmmoId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

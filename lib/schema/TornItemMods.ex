defmodule Torngen.Client.Schema.TornItemMods do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:weapons, :name, :id, :dual_fit, :description]

  defstruct [
    :weapons,
    :name,
    :id,
    :dual_fit,
    :description
  ]

  @type t :: %__MODULE__{
          weapons: [Torngen.Client.Schema.TornItemWeaponTypeEnum.t()],
          name: String.t(),
          id: Torngen.Client.Schema.ItemModId.t(),
          dual_fit: boolean(),
          description: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      weapons:
        data
        |> Map.get("weapons")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornItemWeaponTypeEnum}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemModId),
      dual_fit: data |> Map.get("dual_fit") |> Torngen.Client.Schema.parse({:static, :boolean}),
      description:
        data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:weapons, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornItemWeaponTypeEnum})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ItemModId)
  end

  defp validate_key?(:dual_fit, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

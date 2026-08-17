defmodule Torngen.Client.Schema.TornGym do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:note, :name, :modifiers, :id, :energy_cost, :cost, :class]

  defstruct [
    :note,
    :name,
    :modifiers,
    :id,
    :energy_cost,
    :cost,
    :class
  ]

  @type t :: %__MODULE__{
          note: nil | String.t(),
          name: String.t(),
          modifiers: Torngen.Client.Schema.TornGymModifiers.t(),
          id: Torngen.Client.Schema.GymId.t(),
          energy_cost: integer(),
          cost: integer(),
          class: Torngen.Client.Schema.GymClassEnum.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      note:
        data
        |> Map.get("note")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      modifiers:
        data
        |> Map.get("modifiers")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornGymModifiers}),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.GymId}),
      energy_cost:
        data |> Map.get("energy_cost") |> Torngen.Client.Schema.parse({:static, :integer}),
      cost: data |> Map.get("cost") |> Torngen.Client.Schema.parse({:static, :integer}),
      class:
        data
        |> Map.get("class")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.GymClassEnum})
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

  defp validate_key?(:note, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:modifiers, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TornGymModifiers})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.GymId})
  end

  defp validate_key?(:energy_cost, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:cost, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:class, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.GymClassEnum})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

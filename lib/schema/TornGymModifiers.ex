defmodule Torngen.Client.Schema.TornGymModifiers do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:strength, :speed, :dexterity, :defense]

  defstruct [
    :strength,
    :speed,
    :dexterity,
    :defense
  ]

  @type t :: %__MODULE__{
          strength: integer() | float(),
          speed: integer() | float(),
          dexterity: integer() | float(),
          defense: integer() | float()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      strength: data |> Map.get("strength") |> Torngen.Client.Schema.parse({:static, :number}),
      speed: data |> Map.get("speed") |> Torngen.Client.Schema.parse({:static, :number}),
      dexterity: data |> Map.get("dexterity") |> Torngen.Client.Schema.parse({:static, :number}),
      defense: data |> Map.get("defense") |> Torngen.Client.Schema.parse({:static, :number})
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

  defp validate_key?(:strength, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:speed, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:dexterity, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:defense, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

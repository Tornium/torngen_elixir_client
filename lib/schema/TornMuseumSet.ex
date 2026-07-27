defmodule Torngen.Client.Schema.TornMuseumSet do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:points, :name, :items]

  defstruct [
    :points,
    :name,
    :items
  ]

  @type t :: %__MODULE__{
          points: integer(),
          name: String.t(),
          items: [Torngen.Client.Schema.ItemId.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      points: data |> Map.get("points") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      items:
        data
        |> Map.get("items")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.ItemId}})
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

  defp validate_key?(:points, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.ItemId}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

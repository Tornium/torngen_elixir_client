defmodule Torngen.Client.Schema.TornItemStat do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:value, :title, :id]

  defstruct [
    :value,
    :title,
    :id
  ]

  @type t :: %__MODULE__{
          value: integer(),
          title: String.t(),
          id: Torngen.Client.Schema.ItemStatId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: data |> Map.get("value") |> Torngen.Client.Schema.parse({:static, :integer}),
      title: data |> Map.get("title") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ItemStatId})
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

  defp validate_key?(:value, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:title, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemStatId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.TornCardsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:cards]

  defstruct [
    :cards
  ]

  @type t :: %__MODULE__{
          cards: [Torngen.Client.Schema.TornCard.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      cards:
        data
        |> Map.get("cards")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornCard}})
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

  defp validate_key?(:cards, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.TornCard}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.FactionOcHistory do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:history, :crime_id]

  defstruct [
    :history,
    :crime_id
  ]

  @type t :: %__MODULE__{
          history: [Torngen.Client.Schema.FactionOcHistoryEntry.t()],
          crime_id: Torngen.Client.Schema.FactionCrimeId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      history:
        data
        |> Map.get("history")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.FactionOcHistoryEntry}}
        ),
      crime_id:
        data
        |> Map.get("crime_id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionCrimeId})
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

  defp validate_key?(:history, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.FactionOcHistoryEntry}}
    )
  end

  defp validate_key?(:crime_id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.FactionCrimeId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.TornPokerTablesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:pokertables]

  defstruct [
    :pokertables
  ]

  @type t :: %__MODULE__{
          pokertables: [Torngen.Client.Schema.TornPokerTable.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      pokertables:
        data
        |> Map.get("pokertables")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornPokerTable}})
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

  defp validate_key?(:pokertables, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.TornPokerTable}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

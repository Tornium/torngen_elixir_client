defmodule Torngen.Client.Schema.TornEliminationTeamsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:elimination]

  defstruct [
    :elimination
  ]

  @type t :: %__MODULE__{
          elimination: [Torngen.Client.Schema.TornEliminationTeam.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      elimination:
        data
        |> Map.get("elimination")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornEliminationTeam})
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

  defp validate_key?(:elimination, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornEliminationTeam})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

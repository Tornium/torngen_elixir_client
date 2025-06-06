defmodule Torngen.Client.Schema.TornTerritoriesNoLinksReponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:territory]

  defstruct [
    :territory
  ]

  @type t :: %__MODULE__{
          territory: [Torngen.Client.Schema.TornTerritory.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory:
        data
        |> Map.get("territory")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.TornTerritory})
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

  defp validate_key?(:territory, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.TornTerritory})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

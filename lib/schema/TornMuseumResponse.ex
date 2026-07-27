defmodule Torngen.Client.Schema.TornMuseumResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:museum]

  defstruct [
    :museum
  ]

  @type t :: %__MODULE__{
          museum: [Torngen.Client.Schema.TornMuseumSet.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      museum:
        data
        |> Map.get("museum")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornMuseumSet}})
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

  defp validate_key?(:museum, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.TornMuseumSet}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.UserOrganizedCrimesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:organizedcrimes]

  defstruct [
    :organizedcrimes
  ]

  @type t :: %__MODULE__{
          organizedcrimes: [Torngen.Client.Schema.FactionCrime.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      organizedcrimes:
        data
        |> Map.get("organizedcrimes")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.FactionCrime}})
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

  defp validate_key?(:organizedcrimes, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.FactionCrime}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

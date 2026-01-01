defmodule Torngen.Client.Schema.UserFactionResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:faction]

  defstruct [
    :faction
  ]

  @type t :: %__MODULE__{
          faction: nil | Torngen.Client.Schema.UserFaction.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      faction:
        data
        |> Map.get("faction")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.UserFaction]}
        )
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

  defp validate_key?(:faction, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.UserFaction]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

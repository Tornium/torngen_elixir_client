defmodule Torngen.Client.Schema.FactionHofStats do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:respect, :rank, :chain]

  defstruct [
    :respect,
    :rank,
    :chain
  ]

  @type t :: %__MODULE__{
          respect: Torngen.Client.Schema.HofValue.t(),
          rank: Torngen.Client.Schema.HofValueString.t(),
          chain: Torngen.Client.Schema.HofValue.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      respect:
        data |> Map.get("respect") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue),
      rank:
        data
        |> Map.get("rank")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValueString),
      chain:
        data |> Map.get("chain") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.HofValue)
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

  defp validate_key?(:respect, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  defp validate_key?(:rank, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValueString)
  end

  defp validate_key?(:chain, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.HofValue)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

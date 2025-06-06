defmodule Torngen.Client.Schema.FactionHofValues do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:respect, :chain_duration, :chain]

  defstruct [
    :respect,
    :chain_duration,
    :chain
  ]

  @type t :: %__MODULE__{
          respect: nil | integer(),
          chain_duration: nil | integer(),
          chain: nil | integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      respect:
        data
        |> Map.get("respect")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      chain_duration:
        data
        |> Map.get("chain_duration")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      chain:
        data
        |> Map.get("chain")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]})
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
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:chain_duration, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:chain, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

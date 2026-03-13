defmodule Torngen.Client.Schema.UserTradesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:trades, :_metadata]

  defstruct [
    :trades,
    :_metadata
  ]

  @type t :: %__MODULE__{
          trades: [Torngen.Client.Schema.UserTrade.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      trades:
        data
        |> Map.get("trades")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserTrade}}),
      _metadata:
        data
        |> Map.get("_metadata")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.RequestMetadataWithLinks})
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

  defp validate_key?(:trades, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.UserTrade}})
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.RequestMetadataWithLinks})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

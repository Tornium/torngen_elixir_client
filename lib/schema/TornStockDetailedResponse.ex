defmodule Torngen.Client.Schema.TornStockDetailedResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:stocks]

  defstruct [
    :stocks
  ]

  @type t :: %__MODULE__{
          stocks: Torngen.Client.Schema.TornStockDetailed.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stocks:
        data
        |> Map.get("stocks")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornStockDetailed})
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

  defp validate_key?(:stocks, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TornStockDetailed})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

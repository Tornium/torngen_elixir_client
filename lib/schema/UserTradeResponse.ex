defmodule Torngen.Client.Schema.UserTradeResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:trade]

  defstruct [
    :trade
  ]

  @type t :: %__MODULE__{
          trade: Torngen.Client.Schema.UserTradeDetailed.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      trade:
        data
        |> Map.get("trade")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserTradeDetailed})
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

  defp validate_key?(:trade, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserTradeDetailed})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

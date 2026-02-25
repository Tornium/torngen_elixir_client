defmodule Torngen.Client.Schema.TornStockHistory do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timestamp, :price, :change]

  defstruct [
    :timestamp,
    :price,
    :change
  ]

  @type t :: %__MODULE__{
          timestamp: integer(),
          price: integer() | float(),
          change: integer() | float()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp: data |> Map.get("timestamp") |> Torngen.Client.Schema.parse({:static, :integer}),
      price: data |> Map.get("price") |> Torngen.Client.Schema.parse({:static, :number}),
      change: data |> Map.get("change") |> Torngen.Client.Schema.parse({:static, :number})
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

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:change, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.TornStockPerformance do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:start, :low, :high, :end, :change_percentage, :change]

  defstruct [
    :start,
    :low,
    :high,
    :end,
    :change_percentage,
    :change
  ]

  @type t :: %__MODULE__{
          start: integer() | float(),
          low: integer() | float(),
          high: integer() | float(),
          end: integer() | float(),
          change_percentage: integer() | float(),
          change: integer() | float()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      start: data |> Map.get("start") |> Torngen.Client.Schema.parse({:static, :number}),
      low: data |> Map.get("low") |> Torngen.Client.Schema.parse({:static, :number}),
      high: data |> Map.get("high") |> Torngen.Client.Schema.parse({:static, :number}),
      end: data |> Map.get("end") |> Torngen.Client.Schema.parse({:static, :number}),
      change_percentage:
        data |> Map.get("change_percentage") |> Torngen.Client.Schema.parse({:static, :number}),
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

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:low, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:high, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:change_percentage, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:change, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

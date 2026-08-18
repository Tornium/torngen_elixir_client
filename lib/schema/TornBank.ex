defmodule Torngen.Client.Schema.TornBank do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:rate, :days]

  defstruct [
    :rate,
    :days
  ]

  @type t :: %__MODULE__{
          rate: integer() | float(),
          days: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      rate: data |> Map.get("rate") |> Torngen.Client.Schema.parse({:static, :number}),
      days: data |> Map.get("days") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:rate, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:days, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

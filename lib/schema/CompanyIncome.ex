defmodule Torngen.Client.Schema.CompanyIncome do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:weekly, :daily]

  defstruct [
    :weekly,
    :daily
  ]

  @type t :: %__MODULE__{
          weekly: integer(),
          daily: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      weekly: data |> Map.get("weekly") |> Torngen.Client.Schema.parse({:static, :integer}),
      daily: data |> Map.get("daily") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:weekly, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:daily, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

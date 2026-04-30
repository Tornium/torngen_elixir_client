defmodule Torngen.Client.Schema.CompanyEmployeeStats do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:manual_labor, :intelligence, :endurance]

  defstruct [
    :manual_labor,
    :intelligence,
    :endurance
  ]

  @type t :: %__MODULE__{
          manual_labor: integer(),
          intelligence: integer(),
          endurance: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      manual_labor:
        data |> Map.get("manual_labor") |> Torngen.Client.Schema.parse({:static, :integer}),
      intelligence:
        data |> Map.get("intelligence") |> Torngen.Client.Schema.parse({:static, :integer}),
      endurance: data |> Map.get("endurance") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:manual_labor, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:intelligence, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:endurance, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

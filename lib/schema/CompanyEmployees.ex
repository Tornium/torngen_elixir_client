defmodule Torngen.Client.Schema.CompanyEmployees do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:hired, :capacity]

  defstruct [
    :hired,
    :capacity
  ]

  @type t :: %__MODULE__{
          hired: integer(),
          capacity: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      hired: data |> Map.get("hired") |> Torngen.Client.Schema.parse({:static, :integer}),
      capacity: data |> Map.get("capacity") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:hired, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:capacity, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

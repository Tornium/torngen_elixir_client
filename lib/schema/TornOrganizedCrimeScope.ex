defmodule Torngen.Client.Schema.TornOrganizedCrimeScope do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:return, :cost]

  defstruct [
    :return,
    :cost
  ]

  @type t :: %__MODULE__{
          return: integer(),
          cost: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      return: data |> Map.get("return") |> Torngen.Client.Schema.parse({:static, :integer}),
      cost: data |> Map.get("cost") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:return, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:cost, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

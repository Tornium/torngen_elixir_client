defmodule Torngen.Client.Schema.UserTravelInventoryCapacity do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:special, :base]

  defstruct [
    :special,
    :base
  ]

  @type t :: %__MODULE__{
          special: integer(),
          base: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      special: data |> Map.get("special") |> Torngen.Client.Schema.parse({:static, :integer}),
      base: data |> Map.get("base") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:special, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:base, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

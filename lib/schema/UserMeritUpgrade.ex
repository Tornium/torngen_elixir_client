defmodule Torngen.Client.Schema.UserMeritUpgrade do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:level, :id]

  defstruct [
    :level,
    :id
  ]

  @type t :: %__MODULE__{
          level: integer(),
          id: Torngen.Client.Schema.MeritId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :integer}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.MeritId})
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

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.MeritId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

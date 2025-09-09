defmodule Torngen.Client.Schema.UserCompetitionEasterEggs do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:total, :score, :name]

  defstruct [
    :total,
    :score,
    :name
  ]

  @type t :: %__MODULE__{
          total: integer(),
          score: integer(),
          name: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      total: data |> Map.get("total") |> Torngen.Client.Schema.parse({:static, :integer}),
      score: data |> Map.get("score") |> Torngen.Client.Schema.parse({:static, :integer}),
      name:
        data
        |> Map.get("name")
        |> Torngen.Client.Schema.parse({:enum, :string, ["Easter Egg Hunt"]})
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

  defp validate_key?(:total, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:score, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:enum, :string, ["Easter Egg Hunt"]})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

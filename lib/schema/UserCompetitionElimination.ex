defmodule Torngen.Client.Schema.UserCompetitionElimination do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:team, :score, :name, :attacks]

  defstruct [
    :team,
    :score,
    :name,
    :attacks
  ]

  @type t :: %__MODULE__{
          team: String.t(),
          score: integer(),
          name: String.t(),
          attacks: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      team: data |> Map.get("team") |> Torngen.Client.Schema.parse({:static, :string}),
      score: data |> Map.get("score") |> Torngen.Client.Schema.parse({:static, :integer}),
      name:
        data |> Map.get("name") |> Torngen.Client.Schema.parse({:enum, :string, ["Elimination"]}),
      attacks: data |> Map.get("attacks") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:team, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:score, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:enum, :string, ["Elimination"]})
  end

  defp validate_key?(:attacks, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

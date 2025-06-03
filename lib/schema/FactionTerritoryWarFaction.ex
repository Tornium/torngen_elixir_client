defmodule Torngen.Client.Schema.FactionTerritoryWarFaction do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:score, :players_on_wall, :name, :id, :chain]

  defstruct [
    :score,
    :players_on_wall,
    :name,
    :id,
    :chain
  ]

  @type t :: %__MODULE__{
          score: integer(),
          players_on_wall: [term()],
          name: String.t(),
          id: Torngen.Client.Schema.FactionId.t(),
          chain: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      score: data |> Map.get("score") |> Torngen.Client.Schema.parse({:static, :integer}),
      players_on_wall:
        data |> Map.get("players_on_wall") |> Torngen.Client.Schema.parse({:array, :any}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      chain: data |> Map.get("chain") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:score, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:players_on_wall, value) do
    Torngen.Client.Schema.validate?(value, {:array, :any})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionId)
  end

  defp validate_key?(:chain, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

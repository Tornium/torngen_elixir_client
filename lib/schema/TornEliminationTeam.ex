defmodule Torngen.Client.Schema.TornEliminationTeam do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :wins,
    :score,
    :position,
    :participants,
    :name,
    :losses,
    :lives,
    :leaders,
    :id,
    :eliminated_timestamp,
    :eliminated
  ]

  defstruct [
    :wins,
    :score,
    :position,
    :participants,
    :name,
    :losses,
    :lives,
    :leaders,
    :id,
    :eliminated_timestamp,
    :eliminated
  ]

  @type t :: %__MODULE__{
          wins: integer(),
          score: integer(),
          position: integer(),
          participants: integer(),
          name: String.t(),
          losses: integer(),
          lives: integer(),
          leaders: [Torngen.Client.Schema.BasicUser.t()],
          id: Torngen.Client.Schema.EliminationTeamId.t(),
          eliminated_timestamp: nil | integer(),
          eliminated: boolean()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      wins: data |> Map.get("wins") |> Torngen.Client.Schema.parse({:static, :integer}),
      score: data |> Map.get("score") |> Torngen.Client.Schema.parse({:static, :integer}),
      position: data |> Map.get("position") |> Torngen.Client.Schema.parse({:static, :integer}),
      participants:
        data |> Map.get("participants") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      losses: data |> Map.get("losses") |> Torngen.Client.Schema.parse({:static, :integer}),
      lives: data |> Map.get("lives") |> Torngen.Client.Schema.parse({:static, :integer}),
      leaders:
        data
        |> Map.get("leaders")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.BasicUser}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.EliminationTeamId),
      eliminated_timestamp:
        data
        |> Map.get("eliminated_timestamp")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      eliminated:
        data |> Map.get("eliminated") |> Torngen.Client.Schema.parse({:static, :boolean})
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

  defp validate_key?(:wins, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:score, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:position, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:participants, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:losses, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:lives, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:leaders, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.BasicUser})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.EliminationTeamId)
  end

  defp validate_key?(:eliminated_timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:eliminated, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

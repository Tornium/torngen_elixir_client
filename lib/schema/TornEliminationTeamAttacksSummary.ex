defmodule Torngen.Client.Schema.TornEliminationTeamAttacksSummary do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:team_id, :attacks]

  defstruct [
    :team_id,
    :attacks
  ]

  @type t :: %__MODULE__{
          team_id: Torngen.Client.Schema.EliminationTeamId.t(),
          attacks: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      team_id:
        data
        |> Map.get("team_id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.EliminationTeamId}),
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

  defp validate_key?(:team_id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.EliminationTeamId})
  end

  defp validate_key?(:attacks, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

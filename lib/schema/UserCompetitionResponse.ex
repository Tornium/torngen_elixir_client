defmodule Torngen.Client.Schema.UserCompetitionResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:competition]

  defstruct [
    :competition
  ]

  @type t :: %__MODULE__{
          competition:
            Torngen.Client.Schema.UserCompetitionElimination.t()
            | Torngen.Client.Schema.UserCompetitionRps.t()
            | Torngen.Client.Schema.UserCompetitionEasterEggs.t()
            | Torngen.Client.Schema.UserCompetitionHalloween.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      competition:
        data
        |> Map.get("competition")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             Torngen.Client.Schema.UserCompetitionElimination,
             Torngen.Client.Schema.UserCompetitionRps,
             Torngen.Client.Schema.UserCompetitionEasterEggs,
             Torngen.Client.Schema.UserCompetitionHalloween
           ]}
        )
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

  defp validate_key?(:competition, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         Torngen.Client.Schema.UserCompetitionElimination,
         Torngen.Client.Schema.UserCompetitionRps,
         Torngen.Client.Schema.UserCompetitionEasterEggs,
         Torngen.Client.Schema.UserCompetitionHalloween
       ]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.UserPersonalStatsFull do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:personalstats]

  defstruct [
    :personalstats
  ]

  @type t :: %__MODULE__{
          personalstats: [
            Torngen.Client.Schema.PersonalStatsOther.t()
            | Torngen.Client.Schema.PersonalStatsNetworthExtended.t()
            | Torngen.Client.Schema.PersonalStatsRacing.t()
            | Torngen.Client.Schema.PersonalStatsMissions.t()
            | Torngen.Client.Schema.PersonalStatsDrugs.t()
            | Torngen.Client.Schema.PersonalStatsTravel.t()
            | Torngen.Client.Schema.PersonalStatsItems.t()
            | Torngen.Client.Schema.PersonalStatsInvestments.t()
            | Torngen.Client.Schema.PersonalStatsBounties.t()
            | Torngen.Client.Schema.PersonalStatsCrimes.t()
            | Torngen.Client.Schema.PersonalStatsCommunication.t()
            | Torngen.Client.Schema.PersonalStatsFinishingHits.t()
            | Torngen.Client.Schema.PersonalStatsHospital.t()
            | Torngen.Client.Schema.PersonalStatsJail.t()
            | Torngen.Client.Schema.PersonalStatsTrading.t()
            | Torngen.Client.Schema.PersonalStatsJobsExtended.t()
            | Torngen.Client.Schema.PersonalStatsBattleStats.t()
            | Torngen.Client.Schema.PersonalStatsAttackingExtended.t()
          ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      personalstats:
        data
        |> Map.get("personalstats")
        |> Torngen.Client.Schema.parse(
          {:all_of,
           [
             ref: Torngen.Client.Schema.PersonalStatsOther,
             ref: Torngen.Client.Schema.PersonalStatsNetworthExtended,
             ref: Torngen.Client.Schema.PersonalStatsRacing,
             ref: Torngen.Client.Schema.PersonalStatsMissions,
             ref: Torngen.Client.Schema.PersonalStatsDrugs,
             ref: Torngen.Client.Schema.PersonalStatsTravel,
             ref: Torngen.Client.Schema.PersonalStatsItems,
             ref: Torngen.Client.Schema.PersonalStatsInvestments,
             ref: Torngen.Client.Schema.PersonalStatsBounties,
             ref: Torngen.Client.Schema.PersonalStatsCrimes,
             ref: Torngen.Client.Schema.PersonalStatsCommunication,
             ref: Torngen.Client.Schema.PersonalStatsFinishingHits,
             ref: Torngen.Client.Schema.PersonalStatsHospital,
             ref: Torngen.Client.Schema.PersonalStatsJail,
             ref: Torngen.Client.Schema.PersonalStatsTrading,
             ref: Torngen.Client.Schema.PersonalStatsJobsExtended,
             ref: Torngen.Client.Schema.PersonalStatsBattleStats,
             ref: Torngen.Client.Schema.PersonalStatsAttackingExtended
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

  defp validate_key?(:personalstats, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:all_of,
       [
         ref: Torngen.Client.Schema.PersonalStatsOther,
         ref: Torngen.Client.Schema.PersonalStatsNetworthExtended,
         ref: Torngen.Client.Schema.PersonalStatsRacing,
         ref: Torngen.Client.Schema.PersonalStatsMissions,
         ref: Torngen.Client.Schema.PersonalStatsDrugs,
         ref: Torngen.Client.Schema.PersonalStatsTravel,
         ref: Torngen.Client.Schema.PersonalStatsItems,
         ref: Torngen.Client.Schema.PersonalStatsInvestments,
         ref: Torngen.Client.Schema.PersonalStatsBounties,
         ref: Torngen.Client.Schema.PersonalStatsCrimes,
         ref: Torngen.Client.Schema.PersonalStatsCommunication,
         ref: Torngen.Client.Schema.PersonalStatsFinishingHits,
         ref: Torngen.Client.Schema.PersonalStatsHospital,
         ref: Torngen.Client.Schema.PersonalStatsJail,
         ref: Torngen.Client.Schema.PersonalStatsTrading,
         ref: Torngen.Client.Schema.PersonalStatsJobsExtended,
         ref: Torngen.Client.Schema.PersonalStatsBattleStats,
         ref: Torngen.Client.Schema.PersonalStatsAttackingExtended
       ]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

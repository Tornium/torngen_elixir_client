defmodule Torngen.Client.Schema.UserBattleStatsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:battlestats]

  defstruct [
    :battlestats
  ]

  @type t :: %__MODULE__{
          battlestats: %{
            total: integer(),
            strength: Torngen.Client.Schema.UserBattleStatDetail.t(),
            speed: Torngen.Client.Schema.UserBattleStatDetail.t(),
            dexterity: Torngen.Client.Schema.UserBattleStatDetail.t(),
            defense: Torngen.Client.Schema.UserBattleStatDetail.t()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      battlestats:
        data
        |> Map.get("battlestats")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             total: {:static, :integer},
             speed: {:ref, Torngen.Client.Schema.UserBattleStatDetail},
             strength: {:ref, Torngen.Client.Schema.UserBattleStatDetail},
             dexterity: {:ref, Torngen.Client.Schema.UserBattleStatDetail},
             defense: {:ref, Torngen.Client.Schema.UserBattleStatDetail}
           }}
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

  defp validate_key?(:battlestats, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         total: {:static, :integer},
         speed: {:ref, Torngen.Client.Schema.UserBattleStatDetail},
         strength: {:ref, Torngen.Client.Schema.UserBattleStatDetail},
         dexterity: {:ref, Torngen.Client.Schema.UserBattleStatDetail},
         defense: {:ref, Torngen.Client.Schema.UserBattleStatDetail}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

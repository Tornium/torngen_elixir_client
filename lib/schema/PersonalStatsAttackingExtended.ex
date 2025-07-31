defmodule Torngen.Client.Schema.PersonalStatsAttackingExtended do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:attacking]

  defstruct [
    :attacking
  ]

  @type t :: %__MODULE__{
          attacking: %{
            :unarmored_wins => integer(),
            :networth => %{
              :money_mugged => integer(),
              :largest_mug => integer(),
              :items_looted => integer()
            },
            :killstreak => %{:current => integer(), :best => integer()},
            :hits => %{
              :success => integer(),
              :one_hit_kills => integer(),
              :miss => integer(),
              :critical => integer()
            },
            :highest_level_beaten => integer(),
            :faction => %{
              :territory => %{
                :wall_time => integer(),
                :wall_joins => integer(),
                :wall_clears => integer()
              },
              :retaliations => integer(),
              :respect => integer(),
              :ranked_war_hits => integer(),
              :raid_hits => integer()
            },
            :escapes => %{:player => integer(), :foes => integer()},
            :elo => integer(),
            :defends => %{
              :won => integer(),
              :total => integer(),
              :stalemate => integer(),
              :lost => integer()
            },
            :damage => %{:total => integer(), :best => integer()},
            :attacks => %{
              :won => integer(),
              :stealth => integer(),
              :stalemate => integer(),
              :lost => integer(),
              :assist => integer()
            },
            :ammunition => %{
              :tracer => integer(),
              :total => integer(),
              :special => integer(),
              :piercing => integer(),
              :incendiary => integer(),
              :hollow_point => integer()
            }
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      attacking:
        data
        |> Map.get("attacking")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             unarmored_wins: {:static, :integer},
             networth:
               {:object,
                %{
                  money_mugged: {:static, :integer},
                  largest_mug: {:static, :integer},
                  items_looted: {:static, :integer}
                }},
             killstreak: {:object, %{current: {:static, :integer}, best: {:static, :integer}}},
             hits:
               {:object,
                %{
                  success: {:static, :integer},
                  critical: {:static, :integer},
                  one_hit_kills: {:static, :integer},
                  miss: {:static, :integer}
                }},
             highest_level_beaten: {:static, :integer},
             faction:
               {:object,
                %{
                  territory:
                    {:object,
                     %{
                       wall_time: {:static, :integer},
                       wall_joins: {:static, :integer},
                       wall_clears: {:static, :integer}
                     }},
                  retaliations: {:static, :integer},
                  respect: {:static, :integer},
                  ranked_war_hits: {:static, :integer},
                  raid_hits: {:static, :integer}
                }},
             escapes: {:object, %{player: {:static, :integer}, foes: {:static, :integer}}},
             elo: {:static, :integer},
             defends:
               {:object,
                %{
                  total: {:static, :integer},
                  won: {:static, :integer},
                  stalemate: {:static, :integer},
                  lost: {:static, :integer}
                }},
             damage: {:object, %{total: {:static, :integer}, best: {:static, :integer}}},
             attacks:
               {:object,
                %{
                  won: {:static, :integer},
                  stalemate: {:static, :integer},
                  lost: {:static, :integer},
                  stealth: {:static, :integer},
                  assist: {:static, :integer}
                }},
             ammunition:
               {:object,
                %{
                  total: {:static, :integer},
                  tracer: {:static, :integer},
                  special: {:static, :integer},
                  piercing: {:static, :integer},
                  incendiary: {:static, :integer},
                  hollow_point: {:static, :integer}
                }}
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

  defp validate_key?(:attacking, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         unarmored_wins: {:static, :integer},
         networth:
           {:object,
            %{
              money_mugged: {:static, :integer},
              largest_mug: {:static, :integer},
              items_looted: {:static, :integer}
            }},
         killstreak: {:object, %{current: {:static, :integer}, best: {:static, :integer}}},
         hits:
           {:object,
            %{
              success: {:static, :integer},
              critical: {:static, :integer},
              one_hit_kills: {:static, :integer},
              miss: {:static, :integer}
            }},
         highest_level_beaten: {:static, :integer},
         faction:
           {:object,
            %{
              territory:
                {:object,
                 %{
                   wall_time: {:static, :integer},
                   wall_joins: {:static, :integer},
                   wall_clears: {:static, :integer}
                 }},
              retaliations: {:static, :integer},
              respect: {:static, :integer},
              ranked_war_hits: {:static, :integer},
              raid_hits: {:static, :integer}
            }},
         escapes: {:object, %{player: {:static, :integer}, foes: {:static, :integer}}},
         elo: {:static, :integer},
         defends:
           {:object,
            %{
              total: {:static, :integer},
              won: {:static, :integer},
              stalemate: {:static, :integer},
              lost: {:static, :integer}
            }},
         damage: {:object, %{total: {:static, :integer}, best: {:static, :integer}}},
         attacks:
           {:object,
            %{
              won: {:static, :integer},
              stalemate: {:static, :integer},
              lost: {:static, :integer},
              stealth: {:static, :integer},
              assist: {:static, :integer}
            }},
         ammunition:
           {:object,
            %{
              total: {:static, :integer},
              tracer: {:static, :integer},
              special: {:static, :integer},
              piercing: {:static, :integer},
              incendiary: {:static, :integer},
              hollow_point: {:static, :integer}
            }}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

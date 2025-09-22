defmodule Torngen.Client.Schema.PersonalStatsAttackingPopular do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:attacking]

  defstruct [
    :attacking
  ]

  @type t :: %__MODULE__{
          attacking: %{
            :networth => %{
              :money_mugged => integer(),
              :largest_mug => integer(),
              :items_looted => integer()
            },
            :killstreak => %{:best => integer()},
            :hits => %{
              :success => integer(),
              :one_hit_kills => integer(),
              :miss => integer(),
              :critical => integer()
            },
            :faction => %{:respect => integer(), :ranked_war_hits => integer()},
            :escapes => %{:player => integer(), :foes => integer()},
            :elo => integer(),
            :defends => %{:won => integer(), :stalemate => integer(), :lost => integer()},
            :damage => %{:total => integer(), :best => integer()},
            :attacks => %{
              :won => integer(),
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
             networth:
               {:object,
                %{
                  money_mugged: {:static, :integer},
                  largest_mug: {:static, :integer},
                  items_looted: {:static, :integer}
                }},
             killstreak: {:object, %{best: {:static, :integer}}},
             hits:
               {:object,
                %{
                  critical: {:static, :integer},
                  success: {:static, :integer},
                  one_hit_kills: {:static, :integer},
                  miss: {:static, :integer}
                }},
             faction:
               {:object, %{respect: {:static, :integer}, ranked_war_hits: {:static, :integer}}},
             escapes: {:object, %{player: {:static, :integer}, foes: {:static, :integer}}},
             elo: {:static, :integer},
             defends:
               {:object,
                %{
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
         networth:
           {:object,
            %{
              money_mugged: {:static, :integer},
              largest_mug: {:static, :integer},
              items_looted: {:static, :integer}
            }},
         killstreak: {:object, %{best: {:static, :integer}}},
         hits:
           {:object,
            %{
              critical: {:static, :integer},
              success: {:static, :integer},
              one_hit_kills: {:static, :integer},
              miss: {:static, :integer}
            }},
         faction:
           {:object, %{respect: {:static, :integer}, ranked_war_hits: {:static, :integer}}},
         escapes: {:object, %{player: {:static, :integer}, foes: {:static, :integer}}},
         elo: {:static, :integer},
         defends:
           {:object,
            %{won: {:static, :integer}, stalemate: {:static, :integer}, lost: {:static, :integer}}},
         damage: {:object, %{total: {:static, :integer}, best: {:static, :integer}}},
         attacks:
           {:object,
            %{
              won: {:static, :integer},
              stalemate: {:static, :integer},
              lost: {:static, :integer},
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

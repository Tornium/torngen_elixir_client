defmodule Torngen.Client.Schema.TornCityStatsResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:stats]

  defstruct [
    :stats
  ]

  @type t :: %__MODULE__{
          stats: %{
            users: %{
              total: integer(),
              married: integer(),
              male: integer(),
              female: integer(),
              enby: integer()
            },
            traveling: %{
              united_kingdom: integer(),
              united_arab_emirates: integer(),
              total_trips: integer(),
              switzerland: integer(),
              south_africa: integer(),
              mexico: integer(),
              japan: integer(),
              items_bought_abroad: integer(),
              hawaii: integer(),
              china: integer(),
              cayman_islands: integer(),
              argentina: integer()
            },
            trading: %{
              trades: integer(),
              sold_points: integer(),
              sold_on_market: integer(),
              sold_in_bazaar: integer(),
              items_sent: integer(),
              bazaar_profit: integer(),
              auctions: integer()
            },
            other: %{
              years_played: integer(),
              stat_enhancers_used: integer(),
              merits_bought: integer(),
              logins: integer(),
              energy_refills: integer(),
              company_trains: integer()
            },
            jobs: %{
              unemployed: integer(),
              medical: integer(),
              law: integer(),
              grocer: integer(),
              education: integer(),
              company: integer(),
              casino: integer(),
              army: integer()
            },
            jail: %{
              jailings: integer(),
              busts_failed: integer(),
              busts: integer(),
              bails_spent: integer(),
              bails: integer()
            },
            items: %{
              trashed: integer(),
              total: integer(),
              found_in_dump: integer(),
              found_in_city: integer()
            },
            hospital: %{trips: integer(), revives: integer(), medical_items_used: integer()},
            drugs: %{
              xanax: integer(),
              vicodin: integer(),
              total_used: integer(),
              speed: integer(),
              shrooms: integer(),
              pcp: integer(),
              overdoses: integer(),
              opium: integer(),
              lsd: integer(),
              ketamine: integer(),
              ecstasy: integer(),
              cannabis: integer()
            },
            currency: %{
              points_used: integer(),
              points_total: integer(),
              points_players: integer(),
              points_market: integer(),
              points_factions: integer(),
              money_on_hand_average: integer(),
              money_on_hand: integer(),
              money_in_bank: integer()
            },
            crimes: %{total: integer(), jail_sentences: integer()},
            communication: %{
              total_messages: integer(),
              spouses: integer(),
              personals_placed: integer(),
              friends: integer(),
              coworkers: integer(),
              classified_ads_placed: integer()
            },
            bounties: %{placed: integer(), money_spent: integer()},
            attacking: %{
              rounds_fired: integer(),
              respect_gained: integer(),
              money_mugged: integer(),
              misses: integer(),
              hits: integer(),
              escapes: integer(),
              critical_hits: integer(),
              attacks_won: integer(),
              attacks_stealthed: integer(),
              attacks_stalemated: integer(),
              attacks_lost: integer()
            }
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stats:
        data
        |> Map.get("stats")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             other:
               {:object,
                %{
                  merits_bought: {:static, :integer},
                  years_played: {:static, :integer},
                  stat_enhancers_used: {:static, :integer},
                  logins: {:static, :integer},
                  energy_refills: {:static, :integer},
                  company_trains: {:static, :integer}
                }},
             items:
               {:object,
                %{
                  total: {:static, :integer},
                  trashed: {:static, :integer},
                  found_in_dump: {:static, :integer},
                  found_in_city: {:static, :integer}
                }},
             currency:
               {:object,
                %{
                  points_used: {:static, :integer},
                  points_total: {:static, :integer},
                  points_players: {:static, :integer},
                  points_market: {:static, :integer},
                  points_factions: {:static, :integer},
                  money_on_hand_average: {:static, :integer},
                  money_on_hand: {:static, :integer},
                  money_in_bank: {:static, :integer}
                }},
             jobs:
               {:object,
                %{
                  education: {:static, :integer},
                  casino: {:static, :integer},
                  company: {:static, :integer},
                  medical: {:static, :integer},
                  law: {:static, :integer},
                  grocer: {:static, :integer},
                  army: {:static, :integer},
                  unemployed: {:static, :integer}
                }},
             attacking:
               {:object,
                %{
                  escapes: {:static, :integer},
                  money_mugged: {:static, :integer},
                  hits: {:static, :integer},
                  rounds_fired: {:static, :integer},
                  respect_gained: {:static, :integer},
                  misses: {:static, :integer},
                  critical_hits: {:static, :integer},
                  attacks_won: {:static, :integer},
                  attacks_stealthed: {:static, :integer},
                  attacks_stalemated: {:static, :integer},
                  attacks_lost: {:static, :integer}
                }},
             crimes:
               {:object, %{total: {:static, :integer}, jail_sentences: {:static, :integer}}},
             hospital:
               {:object,
                %{
                  revives: {:static, :integer},
                  medical_items_used: {:static, :integer},
                  trips: {:static, :integer}
                }},
             communication:
               {:object,
                %{
                  friends: {:static, :integer},
                  total_messages: {:static, :integer},
                  spouses: {:static, :integer},
                  personals_placed: {:static, :integer},
                  coworkers: {:static, :integer},
                  classified_ads_placed: {:static, :integer}
                }},
             jail:
               {:object,
                %{
                  busts: {:static, :integer},
                  bails: {:static, :integer},
                  jailings: {:static, :integer},
                  busts_failed: {:static, :integer},
                  bails_spent: {:static, :integer}
                }},
             trading:
               {:object,
                %{
                  trades: {:static, :integer},
                  auctions: {:static, :integer},
                  sold_points: {:static, :integer},
                  sold_on_market: {:static, :integer},
                  sold_in_bazaar: {:static, :integer},
                  items_sent: {:static, :integer},
                  bazaar_profit: {:static, :integer}
                }},
             bounties:
               {:object, %{placed: {:static, :integer}, money_spent: {:static, :integer}}},
             users:
               {:object,
                %{
                  total: {:static, :integer},
                  married: {:static, :integer},
                  male: {:static, :integer},
                  female: {:static, :integer},
                  enby: {:static, :integer}
                }},
             traveling:
               {:object,
                %{
                  united_kingdom: {:static, :integer},
                  united_arab_emirates: {:static, :integer},
                  total_trips: {:static, :integer},
                  switzerland: {:static, :integer},
                  south_africa: {:static, :integer},
                  mexico: {:static, :integer},
                  japan: {:static, :integer},
                  items_bought_abroad: {:static, :integer},
                  hawaii: {:static, :integer},
                  china: {:static, :integer},
                  cayman_islands: {:static, :integer},
                  argentina: {:static, :integer}
                }},
             drugs:
               {:object,
                %{
                  speed: {:static, :integer},
                  xanax: {:static, :integer},
                  vicodin: {:static, :integer},
                  total_used: {:static, :integer},
                  shrooms: {:static, :integer},
                  pcp: {:static, :integer},
                  overdoses: {:static, :integer},
                  opium: {:static, :integer},
                  lsd: {:static, :integer},
                  ketamine: {:static, :integer},
                  ecstasy: {:static, :integer},
                  cannabis: {:static, :integer}
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

  defp validate_key?(:stats, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         other:
           {:object,
            %{
              merits_bought: {:static, :integer},
              years_played: {:static, :integer},
              stat_enhancers_used: {:static, :integer},
              logins: {:static, :integer},
              energy_refills: {:static, :integer},
              company_trains: {:static, :integer}
            }},
         items:
           {:object,
            %{
              total: {:static, :integer},
              trashed: {:static, :integer},
              found_in_dump: {:static, :integer},
              found_in_city: {:static, :integer}
            }},
         currency:
           {:object,
            %{
              points_used: {:static, :integer},
              points_total: {:static, :integer},
              points_players: {:static, :integer},
              points_market: {:static, :integer},
              points_factions: {:static, :integer},
              money_on_hand_average: {:static, :integer},
              money_on_hand: {:static, :integer},
              money_in_bank: {:static, :integer}
            }},
         jobs:
           {:object,
            %{
              education: {:static, :integer},
              casino: {:static, :integer},
              company: {:static, :integer},
              medical: {:static, :integer},
              law: {:static, :integer},
              grocer: {:static, :integer},
              army: {:static, :integer},
              unemployed: {:static, :integer}
            }},
         attacking:
           {:object,
            %{
              escapes: {:static, :integer},
              money_mugged: {:static, :integer},
              hits: {:static, :integer},
              rounds_fired: {:static, :integer},
              respect_gained: {:static, :integer},
              misses: {:static, :integer},
              critical_hits: {:static, :integer},
              attacks_won: {:static, :integer},
              attacks_stealthed: {:static, :integer},
              attacks_stalemated: {:static, :integer},
              attacks_lost: {:static, :integer}
            }},
         crimes: {:object, %{total: {:static, :integer}, jail_sentences: {:static, :integer}}},
         hospital:
           {:object,
            %{
              revives: {:static, :integer},
              medical_items_used: {:static, :integer},
              trips: {:static, :integer}
            }},
         communication:
           {:object,
            %{
              friends: {:static, :integer},
              total_messages: {:static, :integer},
              spouses: {:static, :integer},
              personals_placed: {:static, :integer},
              coworkers: {:static, :integer},
              classified_ads_placed: {:static, :integer}
            }},
         jail:
           {:object,
            %{
              busts: {:static, :integer},
              bails: {:static, :integer},
              jailings: {:static, :integer},
              busts_failed: {:static, :integer},
              bails_spent: {:static, :integer}
            }},
         trading:
           {:object,
            %{
              trades: {:static, :integer},
              auctions: {:static, :integer},
              sold_points: {:static, :integer},
              sold_on_market: {:static, :integer},
              sold_in_bazaar: {:static, :integer},
              items_sent: {:static, :integer},
              bazaar_profit: {:static, :integer}
            }},
         bounties: {:object, %{placed: {:static, :integer}, money_spent: {:static, :integer}}},
         users:
           {:object,
            %{
              total: {:static, :integer},
              married: {:static, :integer},
              male: {:static, :integer},
              female: {:static, :integer},
              enby: {:static, :integer}
            }},
         traveling:
           {:object,
            %{
              united_kingdom: {:static, :integer},
              united_arab_emirates: {:static, :integer},
              total_trips: {:static, :integer},
              switzerland: {:static, :integer},
              south_africa: {:static, :integer},
              mexico: {:static, :integer},
              japan: {:static, :integer},
              items_bought_abroad: {:static, :integer},
              hawaii: {:static, :integer},
              china: {:static, :integer},
              cayman_islands: {:static, :integer},
              argentina: {:static, :integer}
            }},
         drugs:
           {:object,
            %{
              speed: {:static, :integer},
              xanax: {:static, :integer},
              vicodin: {:static, :integer},
              total_used: {:static, :integer},
              shrooms: {:static, :integer},
              pcp: {:static, :integer},
              overdoses: {:static, :integer},
              opium: {:static, :integer},
              lsd: {:static, :integer},
              ketamine: {:static, :integer},
              ecstasy: {:static, :integer},
              cannabis: {:static, :integer}
            }}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

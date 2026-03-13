defmodule Torngen.Client.Schema.PersonalStatsTrading do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:trading]

  defstruct [
    :trading
  ]

  @type t :: %__MODULE__{
          trading: %{
            trades: integer(),
            points: %{sold: integer(), bought: integer()},
            items: %{
              sent: integer(),
              bought: %{shops: integer(), market: integer()},
              auctions: %{won: integer(), sold: integer()}
            },
            item_market:
              nil | %{sales: integer(), revenue: integer(), fees: integer(), customers: integer()},
            bazaar: %{sales: integer(), profit: integer(), customers: integer()}
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      trading:
        data
        |> Map.get("trading")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             items:
               {:object,
                %{
                  sent: {:static, :integer},
                  bought: {:object, %{shops: {:static, :integer}, market: {:static, :integer}}},
                  auctions: {:object, %{won: {:static, :integer}, sold: {:static, :integer}}}
                }},
             points: {:object, %{sold: {:static, :integer}, bought: {:static, :integer}}},
             bazaar:
               {:object,
                %{
                  sales: {:static, :integer},
                  customers: {:static, :integer},
                  profit: {:static, :integer}
                }},
             trades: {:static, :integer},
             item_market:
               {:one_of,
                [
                  static: :null,
                  object: %{
                    fees: {:static, :integer},
                    sales: {:static, :integer},
                    revenue: {:static, :integer},
                    customers: {:static, :integer}
                  }
                ]}
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

  defp validate_key?(:trading, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         items:
           {:object,
            %{
              sent: {:static, :integer},
              bought: {:object, %{shops: {:static, :integer}, market: {:static, :integer}}},
              auctions: {:object, %{won: {:static, :integer}, sold: {:static, :integer}}}
            }},
         points: {:object, %{sold: {:static, :integer}, bought: {:static, :integer}}},
         bazaar:
           {:object,
            %{
              sales: {:static, :integer},
              customers: {:static, :integer},
              profit: {:static, :integer}
            }},
         trades: {:static, :integer},
         item_market:
           {:one_of,
            [
              static: :null,
              object: %{
                fees: {:static, :integer},
                sales: {:static, :integer},
                revenue: {:static, :integer},
                customers: {:static, :integer}
              }
            ]}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

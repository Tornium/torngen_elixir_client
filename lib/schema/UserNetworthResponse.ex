defmodule Torngen.Client.Schema.UserNetworthResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:networth]

  defstruct [
    :networth
  ]

  @type t :: %__MODULE__{
          networth: %{
            total: integer(),
            timestamp: integer(),
            points: integer(),
            money: %{
              wallet: integer(),
              vault: integer(),
              unpaid_fees: integer(),
              piggy_bank: integer(),
              pending: integer(),
              loans: integer(),
              city_bank: integer(),
              cayman_bank: integer(),
              bookie: integer()
            },
            items: %{
              trades: integer(),
              item_market: integer(),
              inventory: integer(),
              enlisted_cars: integer(),
              display_case: integer(),
              bazaar: integer(),
              auction_house: integer()
            },
            assets: %{stock_market: integer(), property: integer(), company: integer()}
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      networth:
        data
        |> Map.get("networth")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             timestamp: {:static, :integer},
             total: {:static, :integer},
             items:
               {:object,
                %{
                  bazaar: {:static, :integer},
                  trades: {:static, :integer},
                  inventory: {:static, :integer},
                  item_market: {:static, :integer},
                  enlisted_cars: {:static, :integer},
                  display_case: {:static, :integer},
                  auction_house: {:static, :integer}
                }},
             points: {:static, :integer},
             money:
               {:object,
                %{
                  pending: {:static, :integer},
                  wallet: {:static, :integer},
                  unpaid_fees: {:static, :integer},
                  piggy_bank: {:static, :integer},
                  loans: {:static, :integer},
                  bookie: {:static, :integer},
                  vault: {:static, :integer},
                  city_bank: {:static, :integer},
                  cayman_bank: {:static, :integer}
                }},
             assets:
               {:object,
                %{
                  property: {:static, :integer},
                  stock_market: {:static, :integer},
                  company: {:static, :integer}
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

  defp validate_key?(:networth, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         timestamp: {:static, :integer},
         total: {:static, :integer},
         items:
           {:object,
            %{
              bazaar: {:static, :integer},
              trades: {:static, :integer},
              inventory: {:static, :integer},
              item_market: {:static, :integer},
              enlisted_cars: {:static, :integer},
              display_case: {:static, :integer},
              auction_house: {:static, :integer}
            }},
         points: {:static, :integer},
         money:
           {:object,
            %{
              pending: {:static, :integer},
              wallet: {:static, :integer},
              unpaid_fees: {:static, :integer},
              piggy_bank: {:static, :integer},
              loans: {:static, :integer},
              bookie: {:static, :integer},
              vault: {:static, :integer},
              city_bank: {:static, :integer},
              cayman_bank: {:static, :integer}
            }},
         assets:
           {:object,
            %{
              property: {:static, :integer},
              stock_market: {:static, :integer},
              company: {:static, :integer}
            }}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.PersonalStatsNetworthExtended do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:networth]

  defstruct [
    :networth
  ]

  @type t :: %__MODULE__{
          networth: %{
            :wallet => integer(),
            :vaults => integer(),
            :unpaid_fees => integer(),
            :total => integer(),
            :stock_market => integer(),
            :property => integer(),
            :points => integer(),
            :piggy_bank => integer(),
            :pending => integer(),
            :overseas_bank => integer(),
            :loans => integer(),
            :item_market => integer(),
            :inventory => integer(),
            :enlisted_cars => integer(),
            :display_case => integer(),
            :company => integer(),
            :bookie => integer(),
            :bazaar => integer(),
            :bank => integer(),
            :auction_house => integer()
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
             pending: {:static, :integer},
             total: {:static, :integer},
             property: {:static, :integer},
             points: {:static, :integer},
             wallet: {:static, :integer},
             vaults: {:static, :integer},
             unpaid_fees: {:static, :integer},
             stock_market: {:static, :integer},
             piggy_bank: {:static, :integer},
             overseas_bank: {:static, :integer},
             loans: {:static, :integer},
             item_market: {:static, :integer},
             inventory: {:static, :integer},
             enlisted_cars: {:static, :integer},
             display_case: {:static, :integer},
             company: {:static, :integer},
             bookie: {:static, :integer},
             bazaar: {:static, :integer},
             bank: {:static, :integer},
             auction_house: {:static, :integer}
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
         pending: {:static, :integer},
         total: {:static, :integer},
         property: {:static, :integer},
         points: {:static, :integer},
         wallet: {:static, :integer},
         vaults: {:static, :integer},
         unpaid_fees: {:static, :integer},
         stock_market: {:static, :integer},
         piggy_bank: {:static, :integer},
         overseas_bank: {:static, :integer},
         loans: {:static, :integer},
         item_market: {:static, :integer},
         inventory: {:static, :integer},
         enlisted_cars: {:static, :integer},
         display_case: {:static, :integer},
         company: {:static, :integer},
         bookie: {:static, :integer},
         bazaar: {:static, :integer},
         bank: {:static, :integer},
         auction_house: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

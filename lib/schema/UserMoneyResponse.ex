defmodule Torngen.Client.Schema.UserMoneyResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:money]

  defstruct [
    :money
  ]

  @type t :: %__MODULE__{
          money: %{
            wallet: integer(),
            vault: integer(),
            points: integer(),
            faction: %{points: integer(), money: integer()},
            daily_networth: integer(),
            company: integer(),
            city_bank: %{
              until: integer(),
              profit: integer(),
              invested_at: integer(),
              interest_rate: integer() | float(),
              duration: integer(),
              amount: integer()
            },
            cayman_bank: integer()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      money:
        data
        |> Map.get("money")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             points: {:static, :integer},
             faction: {:object, %{points: {:static, :integer}, money: {:static, :integer}}},
             wallet: {:static, :integer},
             company: {:static, :integer},
             vault: {:static, :integer},
             daily_networth: {:static, :integer},
             city_bank:
               {:object,
                %{
                  until: {:static, :integer},
                  duration: {:static, :integer},
                  amount: {:static, :integer},
                  profit: {:static, :integer},
                  invested_at: {:static, :integer},
                  interest_rate: {:static, :number}
                }},
             cayman_bank: {:static, :integer}
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

  defp validate_key?(:money, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         points: {:static, :integer},
         faction: {:object, %{points: {:static, :integer}, money: {:static, :integer}}},
         wallet: {:static, :integer},
         company: {:static, :integer},
         vault: {:static, :integer},
         daily_networth: {:static, :integer},
         city_bank:
           {:object,
            %{
              until: {:static, :integer},
              duration: {:static, :integer},
              amount: {:static, :integer},
              profit: {:static, :integer},
              invested_at: {:static, :integer},
              interest_rate: {:static, :number}
            }},
         cayman_bank: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.ReportStockAnalysis do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:items]

  defstruct [
    :items
  ]

  @type t :: %__MODULE__{
          items: [
            %{
              :trip_duration => integer(),
              :item => %{
                :value => integer(),
                :price => integer(),
                :name => String.t(),
                :id => Torngen.Client.Schema.ItemId.t(),
                :due => nil | integer()
              },
              :hourly_profit => integer(),
              :country => Torngen.Client.Schema.CountryEnum.t()
            }
          ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      items:
        data
        |> Map.get("items")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              item:
                {:object,
                 %{
                   id: Torngen.Client.Schema.ItemId,
                   name: {:static, :string},
                   value: {:static, :integer},
                   price: {:static, :integer},
                   due: {:one_of, [static: :null, static: :integer]}
                 }},
              trip_duration: {:static, :integer},
              hourly_profit: {:static, :integer},
              country: Torngen.Client.Schema.CountryEnum
            }}}
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

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:object,
        %{
          item:
            {:object,
             %{
               id: Torngen.Client.Schema.ItemId,
               name: {:static, :string},
               value: {:static, :integer},
               price: {:static, :integer},
               due: {:one_of, [static: :null, static: :integer]}
             }},
          trip_duration: {:static, :integer},
          hourly_profit: {:static, :integer},
          country: Torngen.Client.Schema.CountryEnum
        }}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

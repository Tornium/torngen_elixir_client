defmodule Torngen.Client.Schema.MarketPropertyDetails do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:property, :listings]

  defstruct [
    :property,
    :listings
  ]

  @type t :: %__MODULE__{
          property: Torngen.Client.Schema.BasicProperty.t(),
          listings: [
            %{
              :upkeep => integer(),
              :modifications => [Torngen.Client.Schema.PropertyModificationEnum.t()],
              :market_price => integer(),
              :happy => integer(),
              :cost => integer()
            }
          ]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      property:
        data
        |> Map.get("property")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.BasicProperty),
      listings:
        data
        |> Map.get("listings")
        |> Torngen.Client.Schema.parse(
          {:array,
           {:object,
            %{
              "cost" => {:static, :integer},
              "happy" => {:static, :integer},
              "market_price" => {:static, :integer},
              "modifications" => {:array, Torngen.Client.Schema.PropertyModificationEnum},
              "upkeep" => {:static, :integer}
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

  defp validate_key?(:property, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.BasicProperty)
  end

  defp validate_key?(:listings, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array,
       {:object,
        %{
          "cost" => {:static, :integer},
          "happy" => {:static, :integer},
          "market_price" => {:static, :integer},
          "modifications" => {:array, Torngen.Client.Schema.PropertyModificationEnum},
          "upkeep" => {:static, :integer}
        }}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.BazaarWeekly do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :trending,
    :top_grossing,
    :most_popular,
    :dollar_sale,
    :busiest,
    :bulk,
    :bargain,
    :advanced_item
  ]

  defstruct [
    :trending,
    :top_grossing,
    :most_popular,
    :dollar_sale,
    :busiest,
    :bulk,
    :bargain,
    :advanced_item
  ]

  @type t :: %__MODULE__{
          trending: [Torngen.Client.Schema.BazaarRecentFavorites.t()],
          top_grossing: [Torngen.Client.Schema.BazaarWeeklyIncome.t()],
          most_popular: [Torngen.Client.Schema.BazaarTotalFavorites.t()],
          dollar_sale: [Torngen.Client.Schema.BazaarDollarSales.t()],
          busiest: [Torngen.Client.Schema.BazaarWeeklyCustomers.t()],
          bulk: [Torngen.Client.Schema.BazaarBulkSales.t()],
          bargain: [Torngen.Client.Schema.BazaarBargainSales.t()],
          advanced_item: [Torngen.Client.Schema.BazaarAdvancedItemSales.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      trending:
        data
        |> Map.get("trending")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.BazaarRecentFavorites}),
      top_grossing:
        data
        |> Map.get("top_grossing")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.BazaarWeeklyIncome}),
      most_popular:
        data
        |> Map.get("most_popular")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.BazaarTotalFavorites}),
      dollar_sale:
        data
        |> Map.get("dollar_sale")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.BazaarDollarSales}),
      busiest:
        data
        |> Map.get("busiest")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.BazaarWeeklyCustomers}),
      bulk:
        data
        |> Map.get("bulk")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.BazaarBulkSales}),
      bargain:
        data
        |> Map.get("bargain")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.BazaarBargainSales}),
      advanced_item:
        data
        |> Map.get("advanced_item")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.BazaarAdvancedItemSales})
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

  defp validate_key?(:trending, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.BazaarRecentFavorites})
  end

  defp validate_key?(:top_grossing, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.BazaarWeeklyIncome})
  end

  defp validate_key?(:most_popular, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.BazaarTotalFavorites})
  end

  defp validate_key?(:dollar_sale, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.BazaarDollarSales})
  end

  defp validate_key?(:busiest, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.BazaarWeeklyCustomers})
  end

  defp validate_key?(:bulk, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.BazaarBulkSales})
  end

  defp validate_key?(:bargain, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.BazaarBargainSales})
  end

  defp validate_key?(:advanced_item, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, Torngen.Client.Schema.BazaarAdvancedItemSales}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

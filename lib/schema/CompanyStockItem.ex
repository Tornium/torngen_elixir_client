defmodule Torngen.Client.Schema.CompanyStockItem do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:sold_worth, :sold_amount, :rrp, :price, :on_order, :name, :in_stock, :id, :cost]

  defstruct [
    :sold_worth,
    :sold_amount,
    :rrp,
    :price,
    :on_order,
    :name,
    :in_stock,
    :id,
    :cost
  ]

  @type t :: %__MODULE__{
          sold_worth: integer(),
          sold_amount: integer(),
          rrp: integer(),
          price: integer(),
          on_order: integer(),
          name: String.t(),
          in_stock: integer(),
          id: integer(),
          cost: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      sold_worth:
        data |> Map.get("sold_worth") |> Torngen.Client.Schema.parse({:static, :integer}),
      sold_amount:
        data |> Map.get("sold_amount") |> Torngen.Client.Schema.parse({:static, :integer}),
      rrp: data |> Map.get("rrp") |> Torngen.Client.Schema.parse({:static, :integer}),
      price: data |> Map.get("price") |> Torngen.Client.Schema.parse({:static, :integer}),
      on_order: data |> Map.get("on_order") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      in_stock: data |> Map.get("in_stock") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse({:static, :integer}),
      cost: data |> Map.get("cost") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:sold_worth, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:sold_amount, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:rrp, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:on_order, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:in_stock, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:cost, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

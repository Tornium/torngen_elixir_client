defmodule Torngen.Client.Schema.TornCityShopItem do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:stock, :price, :name, :id]

  defstruct [
    :stock,
    :price,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          stock: %{default: integer(), current: integer()},
          price: integer(),
          name: String.t(),
          id: Torngen.Client.Schema.ItemId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stock:
        data
        |> Map.get("stock")
        |> Torngen.Client.Schema.parse(
          {:object, %{default: {:static, :integer}, current: {:static, :integer}}}
        ),
      price: data |> Map.get("price") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ItemId})
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

  defp validate_key?(:stock, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{default: {:static, :integer}, current: {:static, :integer}}}
    )
  end

  defp validate_key?(:price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

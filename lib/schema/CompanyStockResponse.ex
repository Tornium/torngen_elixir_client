defmodule Torngen.Client.Schema.CompanyStockResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:stock]

  defstruct [
    :stock
  ]

  @type t :: %__MODULE__{
          stock: [Torngen.Client.Schema.CompanyStockItem.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      stock:
        data
        |> Map.get("stock")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.CompanyStockItem}})
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
      {:array, {:ref, Torngen.Client.Schema.CompanyStockItem}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

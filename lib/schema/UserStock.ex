defmodule Torngen.Client.Schema.UserStock do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:transactions, :shares, :id, :bonus]

  defstruct [
    :transactions,
    :shares,
    :id,
    :bonus
  ]

  @type t :: %__MODULE__{
          transactions: [Torngen.Client.Schema.UserStockTransaction.t()],
          shares: integer(),
          id: Torngen.Client.Schema.StockId.t(),
          bonus: %{
            progress: integer(),
            increment: integer(),
            frequency: integer(),
            available: boolean()
          }
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      transactions:
        data
        |> Map.get("transactions")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.UserStockTransaction}}
        ),
      shares: data |> Map.get("shares") |> Torngen.Client.Schema.parse({:static, :integer}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.StockId}),
      bonus:
        data
        |> Map.get("bonus")
        |> Torngen.Client.Schema.parse(
          {:object,
           %{
             progress: {:static, :integer},
             increment: {:static, :integer},
             available: {:static, :boolean},
             frequency: {:static, :integer}
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

  defp validate_key?(:transactions, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.UserStockTransaction}}
    )
  end

  defp validate_key?(:shares, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.StockId})
  end

  defp validate_key?(:bonus, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object,
       %{
         progress: {:static, :integer},
         increment: {:static, :integer},
         available: {:static, :boolean},
         frequency: {:static, :integer}
       }}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

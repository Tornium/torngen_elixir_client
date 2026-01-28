defmodule Torngen.Client.Schema.BazaarAdvancedItemSales do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [%{advanced_item_sales: integer()} | Torngen.Client.Schema.Bazaar.t()]
        }
  @types [
    {:object, %{advanced_item_sales: {:static, :integer}}},
    {:ref, Torngen.Client.Schema.Bazaar}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse({:object, %{advanced_item_sales: {:static, :integer}}}),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.Bazaar})
      ]
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(data) do
    Enum.all?(@types, fn type -> Torngen.Client.Schema.validate?(data, type) end)
  end
end

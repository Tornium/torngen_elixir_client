defmodule Torngen.Client.Schema.UserTradeDetailed do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [
            %{items: [Torngen.Client.Schema.TradeItem.t()]} | Torngen.Client.Schema.UserTrade.t()
          ]
        }
  @types [
    {:object, %{items: {:array, {:ref, Torngen.Client.Schema.TradeItem}}}},
    {:ref, Torngen.Client.Schema.UserTrade}
  ]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse(
          {:object, %{items: {:array, {:ref, Torngen.Client.Schema.TradeItem}}}}
        ),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserTrade})
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

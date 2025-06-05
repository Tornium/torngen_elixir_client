defmodule Torngen.Client.Schema.BazaarAdvancedItemSales do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{
          values: [%{:advanced_item_sales => integer()} | Torngen.Client.Schema.Bazaar.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data
        |> Torngen.Client.Schema.parse({:object, %{"advanced_item_sales" => {:static, :integer}}}),
        data |> Torngen.Client.Schema.parse(Torngen.Client.Schema.Bazaar)
      ]
    }
  end

  @impl true
  def parse(_data), do: nil

  @impl true
  def validate?(%{} = _data), do: true

  @impl true
  def validate?(_data), do: false
end

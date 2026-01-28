defmodule Torngen.Client.Schema.BazaarBargainSales do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{values: [%{bargain_sales: integer()} | Torngen.Client.Schema.Bazaar.t()]}
  @types [{:object, %{bargain_sales: {:static, :integer}}}, {:ref, Torngen.Client.Schema.Bazaar}]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data |> Torngen.Client.Schema.parse({:object, %{bargain_sales: {:static, :integer}}}),
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

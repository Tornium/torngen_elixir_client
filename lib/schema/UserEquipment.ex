defmodule Torngen.Client.Schema.UserEquipment do
  @moduledoc false

  @behaviour Torngen.Client.Schema

  defstruct [:values]

  @type t :: %__MODULE__{values: [%{slot: integer()} | Torngen.Client.Schema.TornItemDetails.t()]}
  @types [{:object, %{slot: {:static, :integer}}}, {:ref, Torngen.Client.Schema.TornItemDetails}]

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      values: [
        data |> Torngen.Client.Schema.parse({:object, %{slot: {:static, :integer}}}),
        data |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornItemDetails})
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

defmodule Torngen.Client.Schema.FactionOcHistoryPayoutDetails do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :percentage, :participants, :money, :items, :destination]

  defstruct [
    :type,
    :percentage,
    :participants,
    :money,
    :items,
    :destination
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.FactionOcHistoryPayoutTypeEnum.t(),
          percentage: integer() | float(),
          participants: [Torngen.Client.Schema.UserId.t()],
          money: nil | integer(),
          items: [Torngen.Client.Schema.FactionOcHistoryItem.t()],
          destination: nil | Torngen.Client.Schema.FactionOcHistoryPayoutDestinationEnum.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type:
        data
        |> Map.get("type")
        |> Torngen.Client.Schema.parse(
          {:ref, Torngen.Client.Schema.FactionOcHistoryPayoutTypeEnum}
        ),
      percentage:
        data |> Map.get("percentage") |> Torngen.Client.Schema.parse({:static, :number}),
      participants:
        data
        |> Map.get("participants")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserId}}),
      money:
        data
        |> Map.get("money")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      items:
        data
        |> Map.get("items")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.FactionOcHistoryItem}}
        ),
      destination:
        data
        |> Map.get("destination")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [static: :null, ref: Torngen.Client.Schema.FactionOcHistoryPayoutDestinationEnum]}
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

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.FactionOcHistoryPayoutTypeEnum}
    )
  end

  defp validate_key?(:percentage, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:participants, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.UserId}})
  end

  defp validate_key?(:money, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:items, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.FactionOcHistoryItem}}
    )
  end

  defp validate_key?(:destination, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.FactionOcHistoryPayoutDestinationEnum]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

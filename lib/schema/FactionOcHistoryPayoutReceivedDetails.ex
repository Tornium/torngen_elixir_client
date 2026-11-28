defmodule Torngen.Client.Schema.FactionOcHistoryPayoutReceivedDetails do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :role, :percentage, :money, :items, :destination, :crime_id]

  defstruct [
    :type,
    :role,
    :percentage,
    :money,
    :items,
    :destination,
    :crime_id
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.FactionOcHistoryPayoutTypeEnum.t(),
          role: Torngen.Client.Schema.FactionOcHistoryRole.t(),
          percentage: integer() | float(),
          money: nil | integer(),
          items: [Torngen.Client.Schema.FactionOcHistoryItem.t()],
          destination: nil | Torngen.Client.Schema.FactionOcHistoryPayoutDestinationEnum.t(),
          crime_id: nil | Torngen.Client.Schema.FactionCrimeId.t()
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
      role:
        data
        |> Map.get("role")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionOcHistoryRole}),
      percentage:
        data |> Map.get("percentage") |> Torngen.Client.Schema.parse({:static, :number}),
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
        ),
      crime_id:
        data
        |> Map.get("crime_id")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.FactionCrimeId]}
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

  defp validate_key?(:role, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.FactionOcHistoryRole})
  end

  defp validate_key?(:percentage, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
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

  defp validate_key?(:crime_id, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.FactionCrimeId]}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

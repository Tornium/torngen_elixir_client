defmodule Torngen.Client.Schema.TornItemStats do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:uid, :type, :sub_type, :stats, :name, :id]

  defstruct [
    :uid,
    :type,
    :sub_type,
    :stats,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          uid: Torngen.Client.Schema.ItemUid.t(),
          type: Torngen.Client.Schema.TornItemTypeEnum.t(),
          sub_type: nil | Torngen.Client.Schema.TornItemWeaponTypeEnum.t(),
          stats: [Torngen.Client.Schema.TornItemStat.t()],
          name: Torngen.Client.Schema.TornItemStatTitleEnum.t(),
          id: Torngen.Client.Schema.ItemId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      uid:
        data
        |> Map.get("uid")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ItemUid}),
      type:
        data
        |> Map.get("type")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornItemTypeEnum}),
      sub_type:
        data
        |> Map.get("sub_type")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.TornItemWeaponTypeEnum]}
        ),
      stats:
        data
        |> Map.get("stats")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.TornItemStat}}),
      name:
        data
        |> Map.get("name")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.TornItemStatTitleEnum}),
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

  defp validate_key?(:uid, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemUid})
  end

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TornItemTypeEnum})
  end

  defp validate_key?(:sub_type, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.TornItemWeaponTypeEnum]}
    )
  end

  defp validate_key?(:stats, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.TornItemStat}})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.TornItemStatTitleEnum})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

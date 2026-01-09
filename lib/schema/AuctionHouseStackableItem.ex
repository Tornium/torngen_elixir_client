defmodule Torngen.Client.Schema.AuctionHouseStackableItem do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:uid, :type, :name, :id]

  defstruct [
    :uid,
    :type,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          uid: Torngen.Client.Schema.ItemUid.t(),
          type: Torngen.Client.Schema.TornItemTypeEnum.t(),
          name: String.t(),
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
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
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

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

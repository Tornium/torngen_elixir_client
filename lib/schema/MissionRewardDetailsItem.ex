defmodule Torngen.Client.Schema.MissionRewardDetailsItem do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :sub_type, :name, :id]

  defstruct [
    :type,
    :sub_type,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          type: Torngen.Client.Schema.TornItemTypeEnum.t(),
          sub_type: nil | Torngen.Client.Schema.TornItemWeaponTypeEnum.t(),
          name: String.t(),
          id: Torngen.Client.Schema.ItemId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type:
        data
        |> Map.get("type")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemTypeEnum),
      sub_type:
        data
        |> Map.get("sub_type")
        |> Torngen.Client.Schema.parse(
          {:one_of, [{:static, :null}, Torngen.Client.Schema.TornItemWeaponTypeEnum]}
        ),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.ItemId)
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
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornItemTypeEnum)
  end

  defp validate_key?(:sub_type, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [{:static, :null}, Torngen.Client.Schema.TornItemWeaponTypeEnum]}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.ItemId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

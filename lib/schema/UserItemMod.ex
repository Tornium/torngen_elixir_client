defmodule Torngen.Client.Schema.UserItemMod do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:title, :id, :equipped_item_uid, :equipped]

  defstruct [
    :title,
    :id,
    :equipped_item_uid,
    :equipped
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          id: Torngen.Client.Schema.ItemModId.t(),
          equipped_item_uid: nil | Torngen.Client.Schema.ItemUid.t(),
          equipped: boolean()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      title: data |> Map.get("title") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ItemModId}),
      equipped_item_uid:
        data
        |> Map.get("equipped_item_uid")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.ItemUid]}
        ),
      equipped: data |> Map.get("equipped") |> Torngen.Client.Schema.parse({:static, :boolean})
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

  defp validate_key?(:title, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemModId})
  end

  defp validate_key?(:equipped_item_uid, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.ItemUid]}
    )
  end

  defp validate_key?(:equipped, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

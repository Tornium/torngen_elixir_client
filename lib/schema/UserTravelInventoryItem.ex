defmodule Torngen.Client.Schema.UserTravelInventoryItem do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:uid, :type, :name, :is_permanent, :is_faction_owned, :is_equipped, :id]

  defstruct [
    :uid,
    :type,
    :name,
    :is_permanent,
    :is_faction_owned,
    :is_equipped,
    :id
  ]

  @type t :: %__MODULE__{
          uid: nil | Torngen.Client.Schema.ItemUid.t(),
          type: String.t(),
          name: String.t(),
          is_permanent: boolean(),
          is_faction_owned: boolean(),
          is_equipped: boolean(),
          id: Torngen.Client.Schema.ItemId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      uid:
        data
        |> Map.get("uid")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.ItemUid]}
        ),
      type: data |> Map.get("type") |> Torngen.Client.Schema.parse({:static, :string}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      is_permanent:
        data |> Map.get("is_permanent") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_faction_owned:
        data |> Map.get("is_faction_owned") |> Torngen.Client.Schema.parse({:static, :boolean}),
      is_equipped:
        data |> Map.get("is_equipped") |> Torngen.Client.Schema.parse({:static, :boolean}),
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
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.ItemUid]}
    )
  end

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:is_permanent, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_faction_owned, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:is_equipped, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

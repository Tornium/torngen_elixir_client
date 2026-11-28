defmodule Torngen.Client.Schema.UserBazaarItemUid do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:uid, :price]

  defstruct [
    :uid,
    :price
  ]

  @type t :: %__MODULE__{
          uid: Torngen.Client.Schema.ItemUid.t(),
          price: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      uid:
        data
        |> Map.get("uid")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ItemUid}),
      price: data |> Map.get("price") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:price, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

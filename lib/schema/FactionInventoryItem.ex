defmodule Torngen.Client.Schema.FactionInventoryItem do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:uids, :type, :name, :loaned, :id, :amount]

  defstruct [
    :uids,
    :type,
    :name,
    :loaned,
    :id,
    :amount
  ]

  @type t :: %__MODULE__{
          uids: [Torngen.Client.Schema.ItemUid.t()],
          type: Torngen.Client.Schema.MarketSpecializedBazaarCategoryEnum.t(),
          name: String.t(),
          loaned: nil | %{name: String.t(), id: Torngen.Client.Schema.UserId.t()},
          id: Torngen.Client.Schema.ItemId.t(),
          amount: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      uids:
        data
        |> Map.get("uids")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.ItemUid}}),
      type:
        data
        |> Map.get("type")
        |> Torngen.Client.Schema.parse(
          {:ref, Torngen.Client.Schema.MarketSpecializedBazaarCategoryEnum}
        ),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      loaned:
        data
        |> Map.get("loaned")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             static: :null,
             object: %{id: {:ref, Torngen.Client.Schema.UserId}, name: {:static, :string}}
           ]}
        ),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.ItemId}),
      amount: data |> Map.get("amount") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:uids, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.ItemUid}})
  end

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:ref, Torngen.Client.Schema.MarketSpecializedBazaarCategoryEnum}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:loaned, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         static: :null,
         object: %{id: {:ref, Torngen.Client.Schema.UserId}, name: {:static, :string}}
       ]}
    )
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.ItemId})
  end

  defp validate_key?(:amount, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

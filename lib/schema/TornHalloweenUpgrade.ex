defmodule Torngen.Client.Schema.TornHalloweenUpgrade do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:requirement, :name, :id, :flavor, :description, :cost]

  defstruct [
    :requirement,
    :name,
    :id,
    :flavor,
    :description,
    :cost
  ]

  @type t :: %__MODULE__{
          requirement: integer(),
          name: String.t(),
          id: Torngen.Client.Schema.HalloweenBasketUpgradeId.t(),
          flavor: String.t(),
          description: String.t(),
          cost: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      requirement:
        data |> Map.get("requirement") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.HalloweenBasketUpgradeId}),
      flavor: data |> Map.get("flavor") |> Torngen.Client.Schema.parse({:static, :string}),
      description:
        data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string}),
      cost: data |> Map.get("cost") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:requirement, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.HalloweenBasketUpgradeId})
  end

  defp validate_key?(:flavor, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:cost, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

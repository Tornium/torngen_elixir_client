defmodule Torngen.Client.Schema.FactionBranchDetails do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:upgrades, :order, :name, :multiplier]

  defstruct [
    :upgrades,
    :order,
    :name,
    :multiplier
  ]

  @type t :: %__MODULE__{
          upgrades: [Torngen.Client.Schema.FactionUpgradeDetails.t()],
          order: integer(),
          name: String.t(),
          multiplier: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      upgrades:
        data
        |> Map.get("upgrades")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionUpgradeDetails}),
      order: data |> Map.get("order") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      multiplier:
        data |> Map.get("multiplier") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:upgrades, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionUpgradeDetails})
  end

  defp validate_key?(:order, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:multiplier, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

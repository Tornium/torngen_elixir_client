defmodule Torngen.Client.Schema.FactionTerritoryWarfare do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:territory, :target, :start, :result, :id, :end, :defender, :aggressor]

  defstruct [
    :territory,
    :target,
    :start,
    :result,
    :id,
    :end,
    :defender,
    :aggressor
  ]

  @type t :: %__MODULE__{
          territory: Torngen.Client.Schema.FactionTerritoryEnum.t(),
          target: integer(),
          start: integer(),
          result: String.t(),
          id: Torngen.Client.Schema.TerritoryWarId.t(),
          end: integer(),
          defender: Torngen.Client.Schema.FactionTerritoryWarFaction.t(),
          aggressor: Torngen.Client.Schema.FactionTerritoryWarFaction.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territory:
        data
        |> Map.get("territory")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionTerritoryEnum),
      target: data |> Map.get("target") |> Torngen.Client.Schema.parse({:static, :integer}),
      start: data |> Map.get("start") |> Torngen.Client.Schema.parse({:static, :integer}),
      result: data |> Map.get("result") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TerritoryWarId),
      end: data |> Map.get("end") |> Torngen.Client.Schema.parse({:static, :integer}),
      defender:
        data
        |> Map.get("defender")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionTerritoryWarFaction),
      aggressor:
        data
        |> Map.get("aggressor")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionTerritoryWarFaction)
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

  defp validate_key?(:territory, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionTerritoryEnum)
  end

  defp validate_key?(:target, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:result, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TerritoryWarId)
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:defender, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionTerritoryWarFaction)
  end

  defp validate_key?(:aggressor, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionTerritoryWarFaction)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

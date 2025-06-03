defmodule Torngen.Client.Schema.FactionRaidReport do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:start, :id, :end, :defender, :aggressor]

  defstruct [
    :start,
    :id,
    :end,
    :defender,
    :aggressor
  ]

  @type t :: %__MODULE__{
          start: integer(),
          id: Torngen.Client.Schema.RaidWarId.t(),
          end: integer(),
          defender: Torngen.Client.Schema.FactionRaidReportFaction.t(),
          aggressor: Torngen.Client.Schema.FactionRaidReportFaction.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      start: data |> Map.get("start") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RaidWarId),
      end: data |> Map.get("end") |> Torngen.Client.Schema.parse({:static, :integer}),
      defender:
        data
        |> Map.get("defender")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionRaidReportFaction),
      aggressor:
        data
        |> Map.get("aggressor")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionRaidReportFaction)
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

  defp validate_key?(:start, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RaidWarId)
  end

  defp validate_key?(:end, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:defender, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionRaidReportFaction)
  end

  defp validate_key?(:aggressor, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionRaidReportFaction)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

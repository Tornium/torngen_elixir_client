defmodule Torngen.Client.Schema.FactionRaidReportFaction do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:score, :non_attackers, :name, :id, :attackers]

  defstruct [
    :score,
    :non_attackers,
    :name,
    :id,
    :attackers
  ]

  @type t :: %__MODULE__{
          score: integer() | float(),
          non_attackers: [Torngen.Client.Schema.FactionRaidReportUser.t()],
          name: String.t(),
          id: Torngen.Client.Schema.FactionId.t(),
          attackers: [Torngen.Client.Schema.FactionRaidReportAttacker.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      score: data |> Map.get("score") |> Torngen.Client.Schema.parse({:static, :number}),
      non_attackers:
        data
        |> Map.get("non_attackers")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionRaidReportUser}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId),
      attackers:
        data
        |> Map.get("attackers")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionRaidReportAttacker})
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

  defp validate_key?(:score, value) do
    Torngen.Client.Schema.validate?(value, {:static, :number})
  end

  defp validate_key?(:non_attackers, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionRaidReportUser})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionId)
  end

  defp validate_key?(:attackers, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, Torngen.Client.Schema.FactionRaidReportAttacker}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

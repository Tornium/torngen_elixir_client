defmodule Torngen.Client.Schema.FactionTerritoryWarReportResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:territorywarreport]

  defstruct [
    :territorywarreport
  ]

  @type t :: %__MODULE__{
          territorywarreport: [Torngen.Client.Schema.FactionTerritoryWarReport.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      territorywarreport:
        data
        |> Map.get("territorywarreport")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionTerritoryWarReport})
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

  defp validate_key?(:territorywarreport, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, Torngen.Client.Schema.FactionTerritoryWarReport}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

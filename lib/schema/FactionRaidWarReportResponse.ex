defmodule Torngen.Client.Schema.FactionRaidWarReportResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:raidreport]

  defstruct [
    :raidreport
  ]

  @type t :: %__MODULE__{
          raidreport: [Torngen.Client.Schema.FactionRaidReport.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      raidreport:
        data
        |> Map.get("raidreport")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.FactionRaidReport})
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

  defp validate_key?(:raidreport, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.FactionRaidReport})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

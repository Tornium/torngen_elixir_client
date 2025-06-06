defmodule Torngen.Client.Schema.RacingCarUpgradesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:carupgrades]

  defstruct [
    :carupgrades
  ]

  @type t :: %__MODULE__{
          carupgrades: [Torngen.Client.Schema.RaceCarUpgrade.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      carupgrades:
        data
        |> Map.get("carupgrades")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.RaceCarUpgrade})
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

  defp validate_key?(:carupgrades, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.RaceCarUpgrade})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

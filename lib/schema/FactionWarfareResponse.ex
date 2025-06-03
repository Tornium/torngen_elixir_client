defmodule Torngen.Client.Schema.FactionWarfareResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:warfare, :_metadata]

  defstruct [
    :warfare,
    :_metadata
  ]

  @type t :: %__MODULE__{
          warfare:
            [Torngen.Client.Schema.FactionWarfareDirtyBomb.t()]
            | [Torngen.Client.Schema.FactionRaidWarfare.t()]
            | [Torngen.Client.Schema.FactionChainWarfare.t()]
            | [Torngen.Client.Schema.FactionTerritoryWarfare.t()]
            | [Torngen.Client.Schema.FactionRankedWarDetails.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      warfare:
        data
        |> Map.get("warfare")
        |> Torngen.Client.Schema.parse(
          {:one_of,
           [
             array: Torngen.Client.Schema.FactionWarfareDirtyBomb,
             array: Torngen.Client.Schema.FactionRaidWarfare,
             array: Torngen.Client.Schema.FactionChainWarfare,
             array: Torngen.Client.Schema.FactionTerritoryWarfare,
             array: Torngen.Client.Schema.FactionRankedWarDetails
           ]}
        ),
      _metadata:
        data
        |> Map.get("_metadata")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.RequestMetadataWithLinks)
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

  defp validate_key?(:warfare, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of,
       [
         array: Torngen.Client.Schema.FactionWarfareDirtyBomb,
         array: Torngen.Client.Schema.FactionRaidWarfare,
         array: Torngen.Client.Schema.FactionChainWarfare,
         array: Torngen.Client.Schema.FactionTerritoryWarfare,
         array: Torngen.Client.Schema.FactionRankedWarDetails
       ]}
    )
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.RequestMetadataWithLinks)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

defmodule Torngen.Client.Schema.UserRacesResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:races, :_metadata]

  defstruct [
    :races,
    :_metadata
  ]

  @type t :: %__MODULE__{
          races: [Torngen.Client.Schema.UserRaceDetails.t()],
          _metadata: Torngen.Client.Schema.RequestMetadataWithLinks.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      races:
        data
        |> Map.get("races")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserRaceDetails}}),
      _metadata:
        data
        |> Map.get("_metadata")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.RequestMetadataWithLinks})
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

  defp validate_key?(:races, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.UserRaceDetails}}
    )
  end

  defp validate_key?(:_metadata, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.RequestMetadataWithLinks})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

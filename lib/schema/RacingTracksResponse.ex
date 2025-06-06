defmodule Torngen.Client.Schema.RacingTracksResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:tracks]

  defstruct [
    :tracks
  ]

  @type t :: %__MODULE__{
          tracks: [Torngen.Client.Schema.RaceTrack.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      tracks:
        data
        |> Map.get("tracks")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.RaceTrack})
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

  defp validate_key?(:tracks, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.RaceTrack})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

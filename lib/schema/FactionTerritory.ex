defmodule Torngen.Client.Schema.FactionTerritory do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:slots, :size, :sector, :respect, :racket, :id, :density, :coordinates, :acquired_at]

  defstruct [
    :slots,
    :size,
    :sector,
    :respect,
    :racket,
    :id,
    :density,
    :coordinates,
    :acquired_at
  ]

  @type t :: %__MODULE__{
          slots: integer(),
          size: integer(),
          sector: integer(),
          respect: integer(),
          racket: nil | Torngen.Client.Schema.TornRacket.t(),
          id: Torngen.Client.Schema.FactionTerritoryEnum.t(),
          density: integer(),
          coordinates: Torngen.Client.Schema.TornTerritoryCoordinates.t(),
          acquired_at: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      slots: data |> Map.get("slots") |> Torngen.Client.Schema.parse({:static, :integer}),
      size: data |> Map.get("size") |> Torngen.Client.Schema.parse({:static, :integer}),
      sector: data |> Map.get("sector") |> Torngen.Client.Schema.parse({:static, :integer}),
      respect: data |> Map.get("respect") |> Torngen.Client.Schema.parse({:static, :integer}),
      racket:
        data
        |> Map.get("racket")
        |> Torngen.Client.Schema.parse(
          {:one_of, [{:static, :null}, Torngen.Client.Schema.TornRacket]}
        ),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionTerritoryEnum),
      density: data |> Map.get("density") |> Torngen.Client.Schema.parse({:static, :integer}),
      coordinates:
        data
        |> Map.get("coordinates")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornTerritoryCoordinates),
      acquired_at:
        data |> Map.get("acquired_at") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:slots, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:size, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:sector, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:respect, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:racket, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [{:static, :null}, Torngen.Client.Schema.TornRacket]}
    )
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionTerritoryEnum)
  end

  defp validate_key?(:density, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:coordinates, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornTerritoryCoordinates)
  end

  defp validate_key?(:acquired_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

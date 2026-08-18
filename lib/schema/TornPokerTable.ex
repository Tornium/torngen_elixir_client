defmodule Torngen.Client.Schema.TornPokerTable do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:speed, :players, :name, :id, :blinds]

  defstruct [
    :speed,
    :players,
    :name,
    :id,
    :blinds
  ]

  @type t :: %__MODULE__{
          speed: integer(),
          players: %{maximum: integer(), current: integer()},
          name: String.t(),
          id: Torngen.Client.Schema.PokerTableId.t(),
          blinds: %{small: integer(), big: integer()}
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      speed: data |> Map.get("speed") |> Torngen.Client.Schema.parse({:static, :integer}),
      players:
        data
        |> Map.get("players")
        |> Torngen.Client.Schema.parse(
          {:object, %{maximum: {:static, :integer}, current: {:static, :integer}}}
        ),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.PokerTableId}),
      blinds:
        data
        |> Map.get("blinds")
        |> Torngen.Client.Schema.parse(
          {:object, %{big: {:static, :integer}, small: {:static, :integer}}}
        )
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

  defp validate_key?(:speed, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:players, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{maximum: {:static, :integer}, current: {:static, :integer}}}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.PokerTableId})
  end

  defp validate_key?(:blinds, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{big: {:static, :integer}, small: {:static, :integer}}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

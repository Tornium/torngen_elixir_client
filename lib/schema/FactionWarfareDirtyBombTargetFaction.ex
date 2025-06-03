defmodule Torngen.Client.Schema.FactionWarfareDirtyBombTargetFaction do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:respect_lost, :name, :id]

  defstruct [
    :respect_lost,
    :name,
    :id
  ]

  @type t :: %__MODULE__{
          respect_lost: integer(),
          name: String.t(),
          id: Torngen.Client.Schema.FactionId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      respect_lost:
        data |> Map.get("respect_lost") |> Torngen.Client.Schema.parse({:static, :integer}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionId)
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

  defp validate_key?(:respect_lost, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.FactionId)
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

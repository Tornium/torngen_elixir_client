defmodule Torngen.Client.Schema.FactionWarfareDirtyBomb do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:user, :planted_at, :id, :faction, :detonated_at]

  defstruct [
    :user,
    :planted_at,
    :id,
    :faction,
    :detonated_at
  ]

  @type t :: %__MODULE__{
          user: nil | Torngen.Client.Schema.FactionWarfareDirtyBombPlanter.t(),
          planted_at: integer(),
          id: Torngen.Client.Schema.DirtyBombId.t(),
          faction: Torngen.Client.Schema.FactionWarfareDirtyBombTargetFaction.t(),
          detonated_at: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      user:
        data
        |> Map.get("user")
        |> Torngen.Client.Schema.parse(
          {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionWarfareDirtyBombPlanter]}
        ),
      planted_at:
        data |> Map.get("planted_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      id: data |> Map.get("id") |> Torngen.Client.Schema.parse(Torngen.Client.Schema.DirtyBombId),
      faction:
        data
        |> Map.get("faction")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.FactionWarfareDirtyBombTargetFaction),
      detonated_at:
        data |> Map.get("detonated_at") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:user, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [{:static, :null}, Torngen.Client.Schema.FactionWarfareDirtyBombPlanter]}
    )
  end

  defp validate_key?(:planted_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.DirtyBombId)
  end

  defp validate_key?(:faction, value) do
    Torngen.Client.Schema.validate?(
      value,
      Torngen.Client.Schema.FactionWarfareDirtyBombTargetFaction
    )
  end

  defp validate_key?(:detonated_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

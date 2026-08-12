defmodule Torngen.Client.Schema.UserSearch do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:online, :name, :level, :id, :icons, :faction_id]

  defstruct [
    :online,
    :name,
    :level,
    :id,
    :icons,
    :faction_id
  ]

  @type t :: %__MODULE__{
          online: Torngen.Client.Schema.UserLastActionStatusEnum.t(),
          name: String.t(),
          level: integer(),
          id: Torngen.Client.Schema.UserId.t(),
          icons: [Torngen.Client.Schema.UserIconPublic.t()],
          faction_id: Torngen.Client.Schema.FactionId.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      online:
        data
        |> Map.get("online")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserLastActionStatusEnum}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      level: data |> Map.get("level") |> Torngen.Client.Schema.parse({:static, :integer}),
      id:
        data |> Map.get("id") |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.UserId}),
      icons:
        data
        |> Map.get("icons")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserIconPublic}}),
      faction_id:
        data
        |> Map.get("faction_id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionId})
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

  defp validate_key?(:online, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserLastActionStatusEnum})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:level, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.UserId})
  end

  defp validate_key?(:icons, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.UserIconPublic}})
  end

  defp validate_key?(:faction_id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.FactionId})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

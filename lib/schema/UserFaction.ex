defmodule Torngen.Client.Schema.UserFaction do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:tag_image, :tag, :position, :name, :id, :days_in_faction]

  defstruct [
    :tag_image,
    :tag,
    :position,
    :name,
    :id,
    :days_in_faction
  ]

  @type t :: %__MODULE__{
          tag_image: String.t(),
          tag: String.t(),
          position: String.t(),
          name: String.t(),
          id: Torngen.Client.Schema.FactionId.t(),
          days_in_faction: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      tag_image: data |> Map.get("tag_image") |> Torngen.Client.Schema.parse({:static, :string}),
      tag: data |> Map.get("tag") |> Torngen.Client.Schema.parse({:static, :string}),
      position: data |> Map.get("position") |> Torngen.Client.Schema.parse({:static, :string}),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.FactionId}),
      days_in_faction:
        data |> Map.get("days_in_faction") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:tag_image, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:tag, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:position, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.FactionId})
  end

  defp validate_key?(:days_in_faction, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

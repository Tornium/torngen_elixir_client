defmodule Torngen.Client.Schema.UserMedalDetailed do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:timestamp, :progress, :name, :is_unlocked, :id, :description]

  defstruct [
    :timestamp,
    :progress,
    :name,
    :is_unlocked,
    :id,
    :description
  ]

  @type t :: %__MODULE__{
          timestamp: nil | integer(),
          progress: nil | Torngen.Client.Schema.UserMedalProgress.t(),
          name: String.t(),
          is_unlocked: boolean(),
          id: Torngen.Client.Schema.MedalId.t(),
          description: String.t()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      timestamp:
        data
        |> Map.get("timestamp")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      progress:
        data
        |> Map.get("progress")
        |> Torngen.Client.Schema.parse(
          {:one_of, [static: :null, ref: Torngen.Client.Schema.UserMedalProgress]}
        ),
      name: data |> Map.get("name") |> Torngen.Client.Schema.parse({:static, :string}),
      is_unlocked:
        data |> Map.get("is_unlocked") |> Torngen.Client.Schema.parse({:static, :boolean}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:ref, Torngen.Client.Schema.MedalId}),
      description:
        data |> Map.get("description") |> Torngen.Client.Schema.parse({:static, :string})
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

  defp validate_key?(:timestamp, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:progress, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:one_of, [static: :null, ref: Torngen.Client.Schema.UserMedalProgress]}
    )
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:is_unlocked, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:ref, Torngen.Client.Schema.MedalId})
  end

  defp validate_key?(:description, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

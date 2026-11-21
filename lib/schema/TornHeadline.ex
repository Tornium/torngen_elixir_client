defmodule Torngen.Client.Schema.TornHeadline do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:type, :start_at, :link, :importance, :id, :headline, :has_countdown, :end_at]

  defstruct [
    :type,
    :start_at,
    :link,
    :importance,
    :id,
    :headline,
    :has_countdown,
    :end_at
  ]

  @type t :: %__MODULE__{
          type: String.t(),
          start_at: integer(),
          link: nil | String.t(),
          importance: String.t(),
          id: nil | integer(),
          headline: String.t(),
          has_countdown: boolean(),
          end_at: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      type: data |> Map.get("type") |> Torngen.Client.Schema.parse({:static, :string}),
      start_at: data |> Map.get("start_at") |> Torngen.Client.Schema.parse({:static, :integer}),
      link:
        data
        |> Map.get("link")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :string]}),
      importance:
        data
        |> Map.get("importance")
        |> Torngen.Client.Schema.parse({:enum, :string, ["normal", "urgent"]}),
      id:
        data
        |> Map.get("id")
        |> Torngen.Client.Schema.parse({:one_of, [static: :null, static: :integer]}),
      headline: data |> Map.get("headline") |> Torngen.Client.Schema.parse({:static, :string}),
      has_countdown:
        data |> Map.get("has_countdown") |> Torngen.Client.Schema.parse({:static, :boolean}),
      end_at: data |> Map.get("end_at") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:type, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:start_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:link, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :string]})
  end

  defp validate_key?(:importance, value) do
    Torngen.Client.Schema.validate?(value, {:enum, :string, ["normal", "urgent"]})
  end

  defp validate_key?(:id, value) do
    Torngen.Client.Schema.validate?(value, {:one_of, [static: :null, static: :integer]})
  end

  defp validate_key?(:headline, value) do
    Torngen.Client.Schema.validate?(value, {:static, :string})
  end

  defp validate_key?(:has_countdown, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  defp validate_key?(:end_at, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

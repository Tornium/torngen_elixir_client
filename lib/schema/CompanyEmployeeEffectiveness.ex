defmodule Torngen.Client.Schema.CompanyEmployeeEffectiveness do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :wrong_gender,
    :working_stats,
    :total,
    :settled_in,
    :merits,
    :management,
    :inactivity,
    :director_education,
    :book,
    :addiction
  ]

  defstruct [
    :wrong_gender,
    :working_stats,
    :total,
    :settled_in,
    :merits,
    :management,
    :inactivity,
    :director_education,
    :book,
    :addiction
  ]

  @type t :: %__MODULE__{
          wrong_gender: integer(),
          working_stats: integer(),
          total: integer(),
          settled_in: integer(),
          merits: integer(),
          management: integer(),
          inactivity: integer(),
          director_education: integer(),
          book: integer(),
          addiction: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      wrong_gender:
        data |> Map.get("wrong_gender") |> Torngen.Client.Schema.parse({:static, :integer}),
      working_stats:
        data |> Map.get("working_stats") |> Torngen.Client.Schema.parse({:static, :integer}),
      total: data |> Map.get("total") |> Torngen.Client.Schema.parse({:static, :integer}),
      settled_in:
        data |> Map.get("settled_in") |> Torngen.Client.Schema.parse({:static, :integer}),
      merits: data |> Map.get("merits") |> Torngen.Client.Schema.parse({:static, :integer}),
      management:
        data |> Map.get("management") |> Torngen.Client.Schema.parse({:static, :integer}),
      inactivity:
        data |> Map.get("inactivity") |> Torngen.Client.Schema.parse({:static, :integer}),
      director_education:
        data |> Map.get("director_education") |> Torngen.Client.Schema.parse({:static, :integer}),
      book: data |> Map.get("book") |> Torngen.Client.Schema.parse({:static, :integer}),
      addiction: data |> Map.get("addiction") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:wrong_gender, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:working_stats, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:total, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:settled_in, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:merits, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:management, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:inactivity, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:director_education, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:book, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:addiction, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

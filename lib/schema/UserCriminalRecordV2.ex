defmodule Torngen.Client.Schema.UserCriminalRecordV2 do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :version,
    :vandalism,
    :total,
    :theft,
    :illicit_services,
    :illegal_production,
    :fraud,
    :extortion,
    :cybercrime,
    :counterfeiting
  ]

  defstruct [
    :version,
    :vandalism,
    :total,
    :theft,
    :illicit_services,
    :illegal_production,
    :fraud,
    :extortion,
    :cybercrime,
    :counterfeiting
  ]

  @type t :: %__MODULE__{
          version: String.t(),
          vandalism: integer(),
          total: integer(),
          theft: integer(),
          illicit_services: integer(),
          illegal_production: integer(),
          fraud: integer(),
          extortion: integer(),
          cybercrime: integer(),
          counterfeiting: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      version:
        data |> Map.get("version") |> Torngen.Client.Schema.parse({:enum, :string, ["v2"]}),
      vandalism: data |> Map.get("vandalism") |> Torngen.Client.Schema.parse({:static, :integer}),
      total: data |> Map.get("total") |> Torngen.Client.Schema.parse({:static, :integer}),
      theft: data |> Map.get("theft") |> Torngen.Client.Schema.parse({:static, :integer}),
      illicit_services:
        data |> Map.get("illicit_services") |> Torngen.Client.Schema.parse({:static, :integer}),
      illegal_production:
        data |> Map.get("illegal_production") |> Torngen.Client.Schema.parse({:static, :integer}),
      fraud: data |> Map.get("fraud") |> Torngen.Client.Schema.parse({:static, :integer}),
      extortion: data |> Map.get("extortion") |> Torngen.Client.Schema.parse({:static, :integer}),
      cybercrime:
        data |> Map.get("cybercrime") |> Torngen.Client.Schema.parse({:static, :integer}),
      counterfeiting:
        data |> Map.get("counterfeiting") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:version, value) do
    Torngen.Client.Schema.validate?(value, {:enum, :string, ["v2"]})
  end

  defp validate_key?(:vandalism, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:total, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:theft, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:illicit_services, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:illegal_production, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:fraud, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:extortion, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:cybercrime, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:counterfeiting, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

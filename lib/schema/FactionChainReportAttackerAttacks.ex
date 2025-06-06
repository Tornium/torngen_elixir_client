defmodule Torngen.Client.Schema.FactionChainReportAttackerAttacks do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [
    :war,
    :total,
    :retaliations,
    :overseas,
    :mug,
    :losses,
    :leave,
    :hospitalize,
    :escapes,
    :draws,
    :bonuses,
    :assists
  ]

  defstruct [
    :war,
    :total,
    :retaliations,
    :overseas,
    :mug,
    :losses,
    :leave,
    :hospitalize,
    :escapes,
    :draws,
    :bonuses,
    :assists
  ]

  @type t :: %__MODULE__{
          war: integer(),
          total: integer(),
          retaliations: integer(),
          overseas: integer(),
          mug: integer(),
          losses: integer(),
          leave: integer(),
          hospitalize: integer(),
          escapes: integer(),
          draws: integer(),
          bonuses: integer(),
          assists: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      war: data |> Map.get("war") |> Torngen.Client.Schema.parse({:static, :integer}),
      total: data |> Map.get("total") |> Torngen.Client.Schema.parse({:static, :integer}),
      retaliations:
        data |> Map.get("retaliations") |> Torngen.Client.Schema.parse({:static, :integer}),
      overseas: data |> Map.get("overseas") |> Torngen.Client.Schema.parse({:static, :integer}),
      mug: data |> Map.get("mug") |> Torngen.Client.Schema.parse({:static, :integer}),
      losses: data |> Map.get("losses") |> Torngen.Client.Schema.parse({:static, :integer}),
      leave: data |> Map.get("leave") |> Torngen.Client.Schema.parse({:static, :integer}),
      hospitalize:
        data |> Map.get("hospitalize") |> Torngen.Client.Schema.parse({:static, :integer}),
      escapes: data |> Map.get("escapes") |> Torngen.Client.Schema.parse({:static, :integer}),
      draws: data |> Map.get("draws") |> Torngen.Client.Schema.parse({:static, :integer}),
      bonuses: data |> Map.get("bonuses") |> Torngen.Client.Schema.parse({:static, :integer}),
      assists: data |> Map.get("assists") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:war, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:total, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:retaliations, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:overseas, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:mug, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:losses, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:leave, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:hospitalize, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:escapes, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:draws, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:bonuses, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:assists, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

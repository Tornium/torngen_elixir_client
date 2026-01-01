defmodule Torngen.Client.Schema.UserBattleStatDetail do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:value, :modifiers, :modifier]

  defstruct [
    :value,
    :modifiers,
    :modifier
  ]

  @type t :: %__MODULE__{
          value: integer(),
          modifiers: [Torngen.Client.Schema.UserBattleStatModifierDetail.t()],
          modifier: integer()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      value: data |> Map.get("value") |> Torngen.Client.Schema.parse({:static, :integer}),
      modifiers:
        data
        |> Map.get("modifiers")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.UserBattleStatModifierDetail}}
        ),
      modifier: data |> Map.get("modifier") |> Torngen.Client.Schema.parse({:static, :integer})
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

  defp validate_key?(:value, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:modifiers, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.UserBattleStatModifierDetail}}
    )
  end

  defp validate_key?(:modifier, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

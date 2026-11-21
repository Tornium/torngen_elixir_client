defmodule Torngen.Client.Schema.UserHalloween do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:treats, :basket_upgrades]

  defstruct [
    :treats,
    :basket_upgrades
  ]

  @type t :: %__MODULE__{
          treats: %{total: integer(), current: integer()},
          basket_upgrades: [Torngen.Client.Schema.UserHalloweenBasketUpgrade.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      treats:
        data
        |> Map.get("treats")
        |> Torngen.Client.Schema.parse(
          {:object, %{total: {:static, :integer}, current: {:static, :integer}}}
        ),
      basket_upgrades:
        data
        |> Map.get("basket_upgrades")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.UserHalloweenBasketUpgrade}}
        )
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

  defp validate_key?(:treats, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:object, %{total: {:static, :integer}, current: {:static, :integer}}}
    )
  end

  defp validate_key?(:basket_upgrades, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.UserHalloweenBasketUpgrade}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

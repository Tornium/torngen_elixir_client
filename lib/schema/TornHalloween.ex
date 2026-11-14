defmodule Torngen.Client.Schema.TornHalloween do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:basket_upgrades]

  defstruct [
    :basket_upgrades
  ]

  @type t :: %__MODULE__{
          basket_upgrades: [Torngen.Client.Schema.TornHalloweenUpgrade.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      basket_upgrades:
        data
        |> Map.get("basket_upgrades")
        |> Torngen.Client.Schema.parse(
          {:array, {:ref, Torngen.Client.Schema.TornHalloweenUpgrade}}
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

  defp validate_key?(:basket_upgrades, value) do
    Torngen.Client.Schema.validate?(
      value,
      {:array, {:ref, Torngen.Client.Schema.TornHalloweenUpgrade}}
    )
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

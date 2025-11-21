defmodule Torngen.Client.Schema.UserAmmoResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:ammo]

  defstruct [
    :ammo
  ]

  @type t :: %__MODULE__{
          ammo: [Torngen.Client.Schema.UserAmmo.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      ammo:
        data
        |> Map.get("ammo")
        |> Torngen.Client.Schema.parse({:array, Torngen.Client.Schema.UserAmmo})
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

  defp validate_key?(:ammo, value) do
    Torngen.Client.Schema.validate?(value, {:array, Torngen.Client.Schema.UserAmmo})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

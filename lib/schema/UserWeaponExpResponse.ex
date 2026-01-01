defmodule Torngen.Client.Schema.UserWeaponExpResponse do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:weaponexp]

  defstruct [
    :weaponexp
  ]

  @type t :: %__MODULE__{
          weaponexp: [Torngen.Client.Schema.UserWeaponExp.t()]
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      weaponexp:
        data
        |> Map.get("weaponexp")
        |> Torngen.Client.Schema.parse({:array, {:ref, Torngen.Client.Schema.UserWeaponExp}})
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

  defp validate_key?(:weaponexp, value) do
    Torngen.Client.Schema.validate?(value, {:array, {:ref, Torngen.Client.Schema.UserWeaponExp}})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end

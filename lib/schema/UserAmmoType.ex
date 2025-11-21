defmodule Torngen.Client.Schema.UserAmmoType do
  @moduledoc false

  use Torngen.Client.SchemaObjectAccess, deprecated: []

  @behaviour Torngen.Client.Schema

  @keys [:quantity, :name, :equipped]

  defstruct [
    :quantity,
    :name,
    :equipped
  ]

  @type t :: %__MODULE__{
          quantity: integer(),
          name: Torngen.Client.Schema.TornItemAmmoTypeEnum.t(),
          equipped: boolean()
        }

  @impl true
  def parse(%{} = data) do
    %__MODULE__{
      quantity: data |> Map.get("quantity") |> Torngen.Client.Schema.parse({:static, :integer}),
      name:
        data
        |> Map.get("name")
        |> Torngen.Client.Schema.parse(Torngen.Client.Schema.TornItemAmmoTypeEnum),
      equipped: data |> Map.get("equipped") |> Torngen.Client.Schema.parse({:static, :boolean})
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

  defp validate_key?(:quantity, value) do
    Torngen.Client.Schema.validate?(value, {:static, :integer})
  end

  defp validate_key?(:name, value) do
    Torngen.Client.Schema.validate?(value, Torngen.Client.Schema.TornItemAmmoTypeEnum)
  end

  defp validate_key?(:equipped, value) do
    Torngen.Client.Schema.validate?(value, {:static, :boolean})
  end

  @spec keys() :: list(atom())
  def keys(), do: @keys
end
